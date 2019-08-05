class AddColumnsToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :skin_color, :integer
    add_column :students, :family_bag, :boolean, default: false
    add_column :students, :birth_certificate_number, :string
  end
end
