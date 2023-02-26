class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :property_id, null: false
      t.integer :renter_id, null: false
      t.date :date, null: false
      t.string :time, null: false
      t.timestamps
    end
  end
end
