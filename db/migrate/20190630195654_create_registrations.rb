class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :school_class, foreign_key: true
      t.references :student, foreign_key: true
      t.date :date_registration

      t.timestamps
    end
  end
end
