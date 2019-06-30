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
      column "School Year" do |school_class|
        school_class.year_school.strftime('%Y')
      end
      actions
  end
  show do
    attributes_table do
      row :series
      row :period
      row "Teacher" do |school_class|
        school_class.user
      end
      row "School Year" do |school_class|
        school_class.year_school.strftime('%Y')
      end
    end
  end


  filter :user, label: "Teacher", collection: -> {User.where(kind: :teacher)}
  filter :period, as: :select, collection: proc {SchoolClass.periods}
  filter :series
  filter :year_school

end
