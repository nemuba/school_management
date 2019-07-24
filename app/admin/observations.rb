ActiveAdmin.register Observation do
  includes :user, :school_class
  permit_params :description, :date_observation, :user_id, :school_class_id

  form do |f|
    f.inputs I18n.t('messages.details', model: Observation.model_name.human.titleize) do
      f.input :school_class, as: :select, collection: current_user.school_classes.all.map {|s| [s.to_s, s.id]}
      f.input :description, as: :quill_editor
      f.input :date_observation, as: :date_picker
      f.hidden_field :user_id, value: current_user.id
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :description do |observation|
      observation.description.truncate(30).html_safe
    end
    column :school_class
    column :date_observation do |observation|
      I18n.l observation.date_observation
    end
    actions
  end

  show :title => proc {|observation| observation.model_name.human.titleize} do
    attributes_table do
      row :description do |observation|
        observation.description.truncate(50).html_safe
      end
      row :school_class
      row :date_observation do |observation|
        I18n.l observation.date_observation
      end
    end
  end

  controller do
    def new
      @observation = Observation.new
    end
  end

  action_item only: :show do
    link_to 'voltar', admin_observations_path
  end

end
