ActiveAdmin.register Student do
  permit_params :name, :ra, :rm, :birthdate, :number_registration, :mother, :father, :phone,
                :addresses_attributes => [:id, :street, :number, :neighboard, :city, :state, :zip_code, :_destroy]
  form do |f|
    f.inputs "Student Details" do
      f.input :name
      f.input :number_registration
      f.input :ra
      f.input :rm
      f.input :birthdate
      f.input :mother
      f.input :father
      f.input :phone
    end
    f.inputs "Address Details" do
      f.has_many :addresses, allow_destroy: true, new_record: true do |ad|
        ad.input :street
        ad.input :number
        ad.input :neighboard
        ad.input :city
        ad.input :state
        ad.input :zip_code
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :number_registration
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
      row "Addresses" do |student|
        student.addresses.each do |ad|
          ad.to_s
        end
      end
    end
  end
end
