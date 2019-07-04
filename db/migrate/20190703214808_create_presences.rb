class CreatePresences < ActiveRecord::Migration[5.2]
  def change
    create_table :presences do |t|
      t.integer :status, default: 0
      t.date :date_presence
      t.references :student, foreign_key: true
      t.references :school_class, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
