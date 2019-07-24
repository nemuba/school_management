class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.text :description
      t.date :date_observation
      t.references :user, foreign_key: true
      t.references :school_class, foreign_key: true

      t.timestamps
    end
  end
end
