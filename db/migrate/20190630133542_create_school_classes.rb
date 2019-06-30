class CreateSchoolClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :school_classes do |t|
      t.integer :period
      t.string :series
      t.date :year_school
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
