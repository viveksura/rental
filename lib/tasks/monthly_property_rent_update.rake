task :monthly_property_rent_update do
  # run this only on midnight at 1st of every month
  # scheduled in heroku scheduler
  if (Date.today - Date.today.beginning_of_month).to_i == 0
    PropertyOccupancy.where("from_date <= ? and to_date >= ?", Date.today, Date.today).includes?(:property).each do |occupancy|
        occupancy.rent = occupancy.property.rent
        occupancy.save!
    end
  end
end