class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :neighboard
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :addressable_id
      t.string :addressable_type
      t.references :addressable, polymorphic: true, index: true
      t.timestamps
    end
    #add_index :addresses, [:addressable_id, :addressable_type]
  end
end
