ActiveAdmin.register Activity do
  includes :user, :school_class
  menu label: Activity.model_name.human(count: 2).titleize, priority: 5

  permit_params :fields_of_expertise, :description, :date_activity, :user_id, :school_class_id

  index do
    selectable_column
    id_column
    column :fields_of_expertise do |activity|
      activity.fields_of_expertise.upcase
    end
    column :description do |activity|
      activity.description.truncate(25).html_safe
    end
    column :school_class
    column :date_activity do |activity|
      I18n.l activity.date_activity
    end
    actions
  end

  show :title => proc {|activity| activity.model_name.human.titleize} do
    attributes_table do
      row :fields_of_expertise do |activity|
        activity.fields_of_expertise.upcase
      end
      row :description do |activity|
        activity.description.truncate(25).html_safe
      end
      row :school_class
      row :date_activity do |activity|
        I18n.l activity.date_activity
      end
    end
  end

  form do |f|
    f.inputs "Activity Details" do
      f.input :school_class, as: :select, collection: current_user.school_classes.all.map {|s| [s.to_s, s.id]}
      f.input :fields_of_expertise
      f.input :description, as: :quill_editor
      f.input :date_activity, as: :date_picker
      f.hidden_field :user_id, value: current_user.id
    end
    f.actions
  end

  controller do
    def new
      @activity = Activity.new
    end
  end

  filter :school_class
  filter :description
  filter :fields_of_expertise, as: :select, collection: proc {Activity.fields_of_expertises}
  filter :date_activity

end
