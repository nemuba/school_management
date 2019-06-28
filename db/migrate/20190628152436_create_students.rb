class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :ra
      t.string :rm
      t.string :number_registration
      t.date :birthdate
      t.string :father
      t.string :mother
      t.string :phone

      t.timestamps
    end
  end
end
