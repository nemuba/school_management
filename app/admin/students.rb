ActiveAdmin.register Student do
  includes :addresses, :responsible_legals, :presences
  menu label: proc {(current_user.teacher?) ? I18n.t('menu.student.teacher') : Student.model_name.human(count: 2).titleize}, priority: 3

  permit_params :name, :ra, :rm, :birthdate, :number_registration, :mother, :father, :phone,
                :addresses_attributes => [:id, :street, :number, :neighboard, :city, :state, :zip_code, :_destroy],
                :responsible_legals_attributes => [:id, :name, :phone, :_destroy]
  form do |f|
    tabs do
      tab I18n.t('messages.details', model: student.model_name.human.titleize) do
        f.inputs do
          f.input :name
          f.input :number_registration
          f.input :ra
          f.input :rm
          f.input :birthdate,as: :date_picker, input_html: {style: "float: left; width: 30%;"}
          f.input :mother
          f.input :father
          f.input :phone, mask: "+55-##-#####-####"
        end
      end # tab student details
      tab I18n.t('messages.details', model: Address.model_name.human.titleize) do
        f.inputs do
          f.has_many :addresses, allow_destroy: true, new_record: true do |ad|
            ad.input :street
            ad.input :number, mask: "#####"
            ad.input :neighboard
            ad.input :city
            ad.input :state
            ad.input :zip_code, mask: "#####-###"
          end
        end
      end # tab addresses details
      tab I18n.t('messages.details', model: ResponsibleLegal.model_name.human.titleize) do
        f.inputs do
          f.has_many :responsible_legals, allow_destroy: true, new_record: true do |rl|
            rl.input :name
            rl.input :phone, mask: "+55-##-#####-####"
          end
        end
      end # tab responsibles legals details
    end # end tabs
    f.actions
  end

  index do
    selectable_column
    id_column
    column :number_registration, max_width: "20px", min_width: "10px" do |student|
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
      row :responsible_legals do |student|
        student.responsible_legals.each do |rl|
          rl.name
        end
      end
      row :addresses do |student|
        student.addresses.each do |ad|
          ad.to_s
        end
      end
      row :lack do |student|
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
            s.presences.create! status: :present, student_id: s.id, user_id: current_user.id, school_class_id: s.school_classes.last.id, date_presence: Time.now
          end
        end
      else
        s.presences.create! status: :present, student_id: s.id, user_id: current_user.id, school_class_id: s.school_classes.last.id, date_presence: Time.now
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
            s.presences.create! status: :lack, student_id: s.id, user_id: current_user.id, school_class_id: s.school_classes.last.id, date_presence: Time.now
          end
        end
      else
        s.presences.create! status: :lack, student_id: s.id, user_id: current_user.id, school_class_id: s.school_classes.last.id, date_presence: Time.now
      end
    end
    redirect_to admin_students_path, alert: "Presence registered successfully!"
  end

  controller do
    before_action :set_student, only: [:edit, :show, :destroy, :update]

    def create
      @student = Student.new(permitted_params[:student])

      if @student.save
        flash[:alert] = I18n.t('messages.create', model: @student.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
      if @student.destroy
        flash[:alert] = I18n.t('messages.destroy', model: @student.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :index
      end
    end

    def update

      if @student.update_attributes(permitted_params[:student])
        flash[:alert] = I18n.t('messages.update', model: @student.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :edit
      end
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end
  end

  action_item :return, only: [:show, :new, :edit] do
    link_to "Voltar", admin_students_path
  end

end
