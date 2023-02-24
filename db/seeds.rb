# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Property.delete_all
PropertyOccupancy.delete_all
User.delete_all


5.times do |i|
    PropertyManager.create!(email: "property_manager.#{i}@gmail.com", password: "password_#{i}", password_confirmation: "password_#{i}")
end

property_managers = PropertyManager.ids

100.times do |i|
    property_type = rand(4)
    Property.create!({
        property_type: property_type,
        property_manager_id: property_managers[rand(property_managers.count)],
        available_from: Date.today + 500.days,
        rent: [500, 600, 700, 1200][property_type] + rand(100),
        address: "#{i + 1}, #{(i /10) + 1} Block",
        size: [800, 1000, 1200, 2000][property_type] + rand(100)
    })
end

properties = Property.all.to_a

2.times do |i|
    Receptionist.create!(email: "receptionist.#{i}@gmail.com", password: "password_#{i}", password_confirmation: "password_#{i}")
end

100.times do |i|
    r = Renter.create!(email: "renter.#{i}@gmail.com", password: "password_#{i}", password_confirmation: "password_#{i}")
    property = properties[i]

    PropertyOccupancy.create!(
        renter_id: r.id,
        property_id: property.id,
        from_date: (Date.today - 10.months),
        to_date: Date.today + (i * 2).days,
        rent: property.rent - rand(30),
        rental_agreement: "https://s3-url.com"
    )
    
end