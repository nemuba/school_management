ActiveAdmin.register SchoolClass do
  permit_params :period, :series, :year_school, :user_id

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


  filter :user, collection: -> {User.where(kind: :teacher)}


end
