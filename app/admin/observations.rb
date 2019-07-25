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
    before_action :set_observation, only: [:edit, :show, :destroy, :update]

    def new
      @observation = Observation.new
    end

    def create
      @observation = Observation.new(permitted_params[:observation])

      if @observation.save
        flash[:alert] = I18n.t('messages.create', model: @observation.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
      if @observation.destroy
        flash[:alert] = I18n.t('messages.destroy', model: @observation.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :index
      end
    end

    def update

      if @observation.update_attributes(permitted_params[:observation])
        flash[:alert] = I18n.t('messages.update', model: @observation.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :edit
      end
    end

    private

    def set_observation
      @observation = Observation.find(params[:id])
    end
  end

  action_item :return, only: [:show, :new, :edit] do
    link_to "Voltar", admin_observations_path
  end

end
