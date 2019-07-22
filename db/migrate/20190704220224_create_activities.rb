class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :fields_of_expertise
      t.text :description
      t.date :date_activity
      t.references :user, foreign_key: true
      t.references :school_class, foreign_key: true

      t.timestamps
    end
  end
end
