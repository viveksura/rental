class CreatePropertyOccupancies < ActiveRecord::Migration[7.0]
  def change
    create_table :property_occupancies do |t|
      t.integer :property_id, null: false
      t.integer :renter_id, null: false
      t.date :from_date, null: false
      t.date :to_date, null: false
      t.float :rent, null: false, default: 0
      t.string :rental_agreement, null: false, default: 0
      
      t.timestamps
    end
  end
end
