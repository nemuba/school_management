class CreateResponsibleLegals < ActiveRecord::Migration[5.2]
  def change
    create_table :responsible_legals do |t|
      t.string :name
      t.string :phone
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
