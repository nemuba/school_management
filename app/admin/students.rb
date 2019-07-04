ActiveAdmin.register Student do
  menu label: proc {(current_user.teacher?) ? "My Students" : "Students"}, priority: 3
  permit_params :name, :ra, :rm, :birthdate, :number_registration, :mother, :father, :phone,
                :addresses_attributes => [:id, :street, :number, :neighboard, :city, :state, :zip_code, :_destroy],
                :responsible_legals_attributes => [:id, :name, :phone, :_destroy]
  form do |f|
    f.inputs "Student Details" do
      f.input :name
      f.input :number_registration
      f.input :ra
      f.input :rm
      f.input :birthdate, mask: "####-##-##"
      f.input :mother
      f.input :father
      f.input :phone, mask: "+55-##-#####-####"
    end
    f.inputs "Address Details" do
      f.has_many :addresses, allow_destroy: true, new_record: true do |ad|
        ad.input :street
        ad.input :number, mask: "####"
        ad.input :neighboard
        ad.input :city
        ad.input :state
        ad.input :zip_code, mask: "#####-###"
      end
    end
    f.inputs "Responsible Legal details" do
      f.has_many :responsible_legals, allow_destroy: true, new_record: true do |rl|
        rl.input :name
        rl.input :phone, mask: "+55-##-#####-####"
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column "Nº Registration", max_width: "20px", min_width: "10px" do |student|
      span student.number_registration
    end
    column :ra
    column :name
    column :birthdate
    actions
  end

  show :title => proc {|student| student.name} do
    attributes_table do
      row :name
      row :birthdate
      row :mother
      row :father
      row :phone
      row :number_registration
      row :ra
      row :rm
      row "Responsible legals" do |student|
        student.responsible_legals.each do |rl|
          rl.name
        end
      end
      row "Addresses" do |student|
        student.addresses.each do |ad|
          ad.to_s
        end
      end
      row "Numbers of Lack" do |student|
        student.presences.where(status: :lack).count
      end
    end
  end

  filter :name
  filter :birthdate
  filter :father
  filter :mother
  filter :addresses, collection: -> {Address.where(addressable_type: 'Student')}
  filter :responsible_legals

  # Ações em lote: Registrando presença para um ou uma seleção de alunos
  batch_action :register_present do |selection|
    #Student.find(selection).each {|s| s.presences.create! kind: :present, student_id: s.id}
    Student.find(selection).each do |s|
      if s.presences.any?
        s.presences.each do |p|
          if p.created_at.today?
            p.update! status: :present
          else
            s.presences.create! status: :present, student_id: s.id, user_id: current_user.id, school_class_id: s.school_class_id, date_presence: Time.now
          end
        end
      else
        s.presences.create! status: :present, student_id: s.id, user_id: current_user.id, school_class_id: s.school_class_id, date_presence: Time.now
      end
    end
    redirect_to admin_students_path, alert: "Presence registered successfully!"
  end

  # Ações em lote: Registrando falta para um ou uma seleção de alunos
  batch_action :register_lack do |selection|
    #Student.find(selection).each {|s| s.presences.create! kind: :present, student_id: s.id}
    Student.find(selection).each do |s|
      if s.presences.any?
        s.presences.each do |p|
          if p.created_at.today?
            p.update! status: :lack
          else
            s.presences.create! status: :lack, student_id: s.id, user_id: current_user.id, school_class_id: s.school_class_id, date_presence: Time.now
          end
        end
      else
        s.presences.create! status: :lack, student_id: s.id, user_id: current_user.id, school_class_id: s.school_class_id, date_presence: Time.now
      end
    end
    redirect_to admin_students_path, alert: "Presence registered successfully!"
  end

end
