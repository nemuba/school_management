ActiveAdmin.register User do
  permit_params :registration, :name, :kind, :job_role, :email, :password, :password_confirmation, :phone

  index do
    selectable_column
    id_column
    column :name
    tag_column "Kind" do |user|
      (user.kind.nil?) ? user.kind : user.kind.upcase
    end
    tag_column "Job Role" do |user|
      (user.job_role.nil?) ? user.job_role : user.job_role.upcase
    end
    column :email
    column :phone
    column :created_at
    actions
  end
  show :title => proc {|user| user.to_s} do
    attributes_table do
      row :registration
      row :name
      row :email
      row :kind
      row :job_role
      row :phone
    end
  end

  filter :email
  filter :kind
  filter :job_role
  filter :email
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :registration
      f.input :name
      f.input :kind
      f.input :job_role
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :phone
    end
    f.actions
  end

  scope :all

end
