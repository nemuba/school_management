ActiveAdmin.register Activity do
  permit_params :fields_of_expertise, :description, :date_activity, :user_id, :school_class_id

  index do
    selectable_column
    id_column
    column :fields_of_expertise
    column "Description" do |activity|
      activity.description[0,25].html_safe << '....'
    end
    column "Date activity" do |activity|
      activity.date_activity.strftime('%d/%m/%Y')
    end
    column :school_class
    actions
  end

  show :title => "Activity" do
    attributes_table do
      row :fields_of_expertise
      row "description" do |activity|
        activity.description[0,25].html_safe
      end
      row :date_activity
    end
  end

  form do |f|
    f.inputs "Activity Details" do
      f.input :school_class, as: :select, collection: current_user.school_classes.all.map {|s| [s.to_s, s.id]}
      f.input :fields_of_expertise
      f.input :description, as: :quill_editor
      f.input :date_activity, mask: "####-##-##"
      f.hidden_field :user_id, value: current_user.id
    end
    f.actions
  end

  controller do
    def self.index
      @activities = resource.where(user_id: current_user.id).page params[:page]
      super
    end
  end

end
