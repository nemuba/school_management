ActiveAdmin.register SchoolClass do
  includes :user, :students
  menu label: proc {(current_user.teacher?) ? I18n.t('menu.school_class.teacher') : SchoolClass.model_name.human(count: 2).titleize}, priority: 2

  permit_params :period, :series, :year_school, :user_id

  form do |f|
    f.inputs I18n.t('messages.school_class.details', model: school_class.model_name.human.titleize) do
      f.input :series
      f.input :period
      f.input :user, collection: (current_user.teacher?) ? User.where(kind: :teacher).pluck(:name, :id) : User.where.not(kind: :admin).pluck(:name, :id)
      f.input :year_school, as: :date_picker
    end
    f.actions
  end

  index do
    id_column
    column :series
    column :period do |school_class|
      school_class.humanized_period
    end
    column :user do |school_class|
      school_class.user
    end
    column :students do |school_class|
      school_class.students.count
    end
    column :year_school do |school_class|
      school_class.year_school.strftime('%Y')
    end
    actions
  end
  show do
    panel I18n.t('messages.school_class.info', model: school_class.to_s) do
      if school_class.students.any?
        table_for school_class.students.order('number_registration ASC') do
          column :number_registration do |student|
            student.number_registration
          end
          column :name do |student|
            link_to student.name, [:admin, student]
          end
          column :ra do |student|
            student.ra
          end
          column :birthdate do |student|
            student.birthdate.strftime('%d/%m/%Y')
          end
          column :phone do |student|
            student.phone
          end
          column :lack do |student|
            student.presences.where(status: :lack).count
          end
          column :presences do |student|
            student.presences.where(status: :present).count
          end
        end
      else
        h4 I18n.t('messages.school_class.no_students')
      end
    end
  end
  sidebar I18n.t('messages.school_class.details', model: SchoolClass.model_name.human.titleize), :only => :show do
    attributes_table do
      row :series
      row :period do |school_class|
        school_class.humanized_period
      end
      row :user do |school_class|
        school_class.user
      end
      row :year_school do |school_class|
        school_class.year_school.strftime('%Y')
      end
      row :students do |school_class|
        school_class.students.count
      end
    end
  end

  filter :user, collection: -> {User.where(kind: :teacher)}
  filter :period, as: :select, collection: proc {SchoolClass.periods}
  filter :series
  filter :year_school

  scope proc {I18n.t('activerecord.scopes.school_class.all')}, :all, default: true
  scope proc {I18n.t('activerecord.scopes.school_class.period_integral')}, :period_integral, if: -> {current_user.admin?}
  scope proc {I18n.t('activerecord.scopes.school_class.period_manha')}, :period_manha, if: -> {current_user.admin?}
  scope proc {I18n.t('activerecord.scopes.school_class.period_tarde')}, :period_tarde, if: -> {current_user.admin?}
  scope proc {I18n.t('activerecord.scopes.school_class.period_parcial')}, :period_parcial, if: -> {current_user.admin?}


  controller do
    before_action :set_school_class, only: [:edit, :show, :destroy, :update]

    def create
      @school_class = SchoolClass.new(permitted_params[:school_class])

      if @school_class.save
        flash[:alert] = I18n.t('messages.create', model: @school_class.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
      if @school_class.destroy
        flash[:alert] = I18n.t('messages.destroy', model: @school_class.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :index
      end
    end

    def update

      if @school_class.update_attributes(permitted_params[:school_class])
        flash[:alert] = I18n.t('messages.update', model: @school_class.model_name.human.titleize)
        redirect_to :action => :index
      else
        render :action => :edit
      end
    end

    private

    def set_school_class
      @school_class = SchoolClass.find(params[:id])
    end
  end

  action_item :return, only: [:show, :new, :edit] do
    link_to "Voltar", admin_school_classes_path
  end

end
