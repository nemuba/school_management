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
      column :period
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
  sidebar I18n.t('messages.school_class.details', model: SchoolClass.model_name.human.titleize), :only=> :show do
    attributes_table do
      row :series
      row :period
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

  scope :all, default: true
  scope :period_integral, if:-> {current_user.admin?}
  scope :period_manha, if:-> {current_user.admin?}
  scope :period_tarde, if:-> {current_user.admin?}
  scope :period_parcial, if:-> {current_user.admin?}

end
