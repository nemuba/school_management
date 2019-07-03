ActiveAdmin.register User do
  menu label: proc {(current_user.admin?) ? "Users" : "Your Perfil"}, priority: 1
  permit_params :registration, :name, :birthdate, :kind, :job_role, :status, :email, :password, :password_confirmation, :phone,
                :addresses_attributes => [:id, :street, :number, :neighboard, :city, :state, :zip_code, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :email
    tag_column "Status" do |user|
      user.status.upcase
    end
    tag_column "Kind" do |user|
      (user.kind.nil?) ? user.kind : user.kind.upcase
    end
    tag_column "Job Role" do |user|
      (user.job_role.nil?) ? user.job_role : user.job_role.upcase
    end
    column "Birthdate" do |user|
      user.birthdate.strftime("%d/%m/%Y")
    end
    actions
  end
  show :title => proc {|user| user.to_s} do
    attributes_table do
      row :registration
      row :name
      row "Birthdate" do |user|
        user.birthdate.strftime("%d/%m/%Y")
      end
      row :email
      tag_row :kind
      tag_row :job_role
      tag_row :status
      row :phone
      row "Address" do |user|
        user.addresses.each do |ad|
          ad.to_s
        end
      end
    end
  end

  if proc {current_user.teacher?}
    sidebar 'School Classes', if: -> {current_user.teacher?}, :only => :show do
      table_for current_user.school_classes do
        column do |school_class|
          link_to school_class.to_s, [:admin, school_class]
        end
      end
    end
  end

  filter :name
  filter :birthdate
  filter :registration
  filter :email
  filter :kind, as: :select, collection: proc {User.kinds}
  filter :job_role, as: :select, collection: proc {User.job_roles}
  filter :status, as: :select, collection: proc {User.statuses}
  filter :email
  filter :addresses, collection: -> {Address.where(addressable_type: 'User')}


  form do |f|
    f.inputs "User Details" do
      f.input :registration
      f.input :name
      f.input :birthdate, as: :datepicker
      f.input :kind
      f.input :job_role
      f.input :status
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :phone
    end
    f.inputs "Address Details" do
      f.has_many :addresses, allow_destroy: true, new_record: true do |ad|
        ad.input :street
        ad.input :number
        ad.input :neighboard
        ad.input :city
        ad.input :state
        ad.input :zip_code
      end
    end
    f.actions
  end

  scope :all, default: true
  scope :teachers, if: -> {current_user.admin?}
  scope :pebs_1, if: -> {current_user.admin?}
  scope :pebs_2, if: -> {current_user.admin?}
  scope :pdis, if: -> {current_user.admin?}
  scope :paebs, if: -> {current_user.admin?}
  scope :asis, if: -> {current_user.admin?}


end
