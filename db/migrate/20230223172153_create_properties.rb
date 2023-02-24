class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.integer :property_type, default: 0
      t.integer :property_manager_id, null: false
      t.date :available_from, null: true
      t.integer :rent, null: false, default: 0
      t.string :address
      t.integer :size, default: 0

      t.timestamps
    end
  end
end
