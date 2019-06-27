class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :registration, :string
    add_column :users, :name, :string
    add_column :users, :status, :integer
    add_column :users, :kind, :integer
    add_column :users, :job_role, :integer
    add_column :users, :phone, :string
  end
end
