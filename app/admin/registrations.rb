ActiveAdmin.register Registration do
  menu label: proc {(current_user.admin?) ? Registration.model_name.human(count: 2).titleize : i18n.t('menu.registration') }, priority: 5
  permit_params :student_id, :school_class_id, :status, :date_registration

  index do
    selectable_column
    id_column
    column :student
    column :school_class
    tag_column :status do |registration|
      registration.humanized_status
    end
    column :date_registration do |registration|
      I18n.l registration.date_registration
    end
    actions
  end
  show do
    attributes_table do
      row :student
      row :school_class
      tag_row :status do |registration|
        registration.humanized_status
      end
      row :date_registration do |registration|
        I18n.l  registration.date_registration
      end
    end
  end

  form do |f|
    f.inputs I18n.t('messages.registration.details', model: Registration.model_name.human.titleize) do
      f.input :student
      f.input :school_class
      f.input :status
      f.input :date_registration, as: :date_picker
    end
    f.actions
  end

  filter :student
  filter :school_class
  filter :status, as: :select, collection: -> {Registration.statuses}
  filter :date_registration
end
