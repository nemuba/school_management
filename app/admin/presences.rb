ActiveAdmin.register Presence do
  includes :user, :student, :school_class
  menu label: proc {(current_user.admin?) ? Presence.model_name.human(count: 2).titleize : I18n.t('menu.presence.teacher')}, priority: 4

  permit_params :status, :date_presence, :student_id, :school_class_id, :user_id

  form do |f|
    f.inputs I18n.t('messages.details', model: Presence.model_name.human.titleize) do
      f.input :status
      f.input :student, as: :select, collection: (current_user.teacher?) ? current_user.students.all.map {|s| [s.name, s.id]} : Student.all.map {|st| [st.name, st.id]}
      f.input :school_class, as: :select, collection: (current_user.teacher?) ? SchoolClass.where(user_id: current_user.id) : SchoolClass.all
      f.input :date_presence, as: :date_picker
      f.hidden_field :user_id, value: current_user.id
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :student
    column :user
    column :school_class
    tag_column :status
    column :date_presence
    actions
  end

  show :title => proc {|presence| presence.display} do
    attributes_table do
      row :student
      row :user
      row :school_class
      tag_row :status
      row :date_presence
      row :created_at
      row :updated_at
    end
  end

  controller do
    before_action :set_presence, only: [:edit, :show, :destroy, :update]

    def new
      @presence = Presence.new
    end

    def create
      @presence = Presence.new(permitted_params[:presence])

      if @presence.save
        flash[:alert] = I18n.t('messages.create', model: @presence.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
      if @presence.destroy
        flash[:alert] = I18n.t('messages.destroy', model: @presence.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :index
      end
    end

    def update

      if @presence.update_attributes(permitted_params[:presence])
        flash[:alert] = I18n.t('messages.update', model: @presence.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :edit
      end
    end

    private

    def set_presence
      @presence = Presence.find(params[:id])
    end
  end

  action_item :return, only: [:show, :new, :edit] do
    link_to "Voltar", admin_school_classes_path
  end
end
