ActiveAdmin.register Registration do
  includes :student, :school_class
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

   controller do
    before_action :set_registration, only: [:edit, :show, :destroy, :update]

    def create
      @registration = Registration.new(permitted_params[:registration])

      if @registration.save
        flash[:alert] = I18n.t('messages.create', model: @registration.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
      if @registration.destroy
        flash[:alert] = I18n.t('messages.destroy', model: @registration.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :index
      end
    end

    def update

      if @registration.update_attributes(permitted_params[:registration])
        flash[:alert] = I18n.t('messages.update', model: @registration.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :edit
      end
    end

    private

    def set_registration
      @registration = Registration.find(params[:id])
    end
   end

  action_item :return, only: [:show, :new, :edit] do
    link_to "Voltar", admin_registrations_path
  end
end
