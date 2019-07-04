ActiveAdmin.register SchoolClass do
  menu label: proc {(current_user.teacher?) ? "My Class" : "School Classes"}, priority: 2
  permit_params :period, :series, :year_school, :user_id

  form do |f|
    f.inputs "School Details" do
      f.input :series
      f.input :period
      f.input :user, collection: (current_user.teacher?) ? User.where(kind: :teacher).pluck(:name, :id) : User.where.not(kind: :admin).pluck(:name, :id)
      f.input :year_school, mask: "####-##-##"
    end
    f.actions
  end

  index do
      id_column
      column :series
      column :period
      column "Teacher" do |school_class|
        school_class.user
      end
      column "Number of Students" do |school_class|
        school_class.students.count
      end
      column "School Year" do |school_class|
        school_class.year_school.strftime('%Y')
      end
      actions
  end
  show do
    panel "Students of #{school_class.to_s}" do
      if school_class.students.any?
        table_for school_class.students.order('number_registration ASC') do
          column "Number" do |student|
            student.number_registration
          end
          column "Name" do |student|
            link_to student.name, [:admin, student]
          end
          column "RA" do |student|
            student.ra
          end
          column "Birthdate" do |student|
            student.birthdate.strftime('%d/%m/%Y')
          end
          column "Phone" do |student|
            student.phone
          end
          column "Lack" do |student|
            student.presences.where(status: :lack).count
          end
          column "Present" do |student|
            student.presences.where(status: :present).count
          end
        end
      else
        h4 "Nenhum Aluno matriculado !"
      end
    end
  end
  sidebar "School Class Details", :only=> :show do
    attributes_table do
      row :series
      row :period
      row "Teacher" do |school_class|
        school_class.user
      end
      row "School Year" do |school_class|
        school_class.year_school.strftime('%Y')
      end
      row "Number(s) of Student(s)" do |school_class|
        school_class.students.count
      end
    end
  end

  filter :user, label: "Teacher", collection: -> {User.where(kind: :teacher)}
  filter :period, as: :select, collection: proc {SchoolClass.periods}
  filter :series
  filter :year_school

  scope :all, default: true
  scope :period_integral, if:-> {current_user.admin?}
  scope :period_manha, if:-> {current_user.admin?}
  scope :period_tarde, if:-> {current_user.admin?}
  scope :period_parcial, if:-> {current_user.admin?}

end
