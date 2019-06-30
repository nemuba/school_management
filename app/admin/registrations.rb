ActiveAdmin.register Registration do
  permit_params :student_id, :school_class_id, :status, :date_registration

  index do
    selectable_column
    id_column
    column :student
    column :school_class
    tag_column :status
    column "Date Registrations" do |registration|
      registration.date_registration.strftime('%d/%m/%Y')
    end
    actions
  end
  show do
    attributes_table do
      row :student
      row :school_class
      tag_row :status
      row "Date registration" do |registration|
        registration.date_registration.strftime('%d/%m/%Y')
      end
    end
  end

  form do |f|
    f.inputs "Registrations Details" do
      f.input :student
      f.input :school_class
      f.input :status
      f.input :date_registration
    end
    f.actions
  end

  filter :student
  filter :school_class
  filter :status, as: :select, collection: -> {Registration.statuses}
  filter :date_registration
end
