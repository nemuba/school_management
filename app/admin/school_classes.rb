ActiveAdmin.register SchoolClass do
  permit_params :period, :series, :year_school, :user_id

  form do |f|
    f.inputs "School Details" do
      f.input :series
      f.input :period
      f.input :user, collection: User.where(kind: :teacher) {|u| [u.name, u.id]}
      f.input :year_school, as: :datepicker
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
        table_for school_class.students.order('name ASC') do
          column "Number class" do |student|
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

  scope :period_integral
  scope :period_manha
  scope :period_tarde
  scope :period_parcial

end
