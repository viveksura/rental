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
    
    property.available_from = Date.today + ((i * 2) + 1).days
    property.save!
end

Property.where(property_type: 0).each do |property|
    images = [
        {
            "url" => "https://upload.wikimedia.org/wikipedia/commons/d/d6/Studio_Apartment_Minneapolis_1.jpg",
            "title" => "Studio",
        }, 
        {
            "url" => "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_487/at%2Fhouse%20tours%20stock%20archive%2Ffa4f696375867ca1116f9939843ed3ae21b83c88",
            "title" => "Kitchen",
        }, 
        {
            "url" => "https://i.shgcdn.com/06925221-ef7c-4b3e-a4d1-9d1e2ae8698f/-/format/auto/-/preview/3000x3000/-/quality/lighter/",
            "title" => "Balcony",
        }, 
        {
            "url" => "https://images.squarespace-cdn.com/content/v1/5b4e6b87266c074121c335e9/1588964669255-MKCIAKN2QI2K4Y1D8KB6/small+apartment+bathroom+ideas.jpg?",
            "title" => "Bathroom",
        }, 
    ]
    property.metadata = { "images" => images }
    property.save!
end


Property.where(property_type: 1).each do |property|
    images = [
        {
            "url" => "https://www.shutterstock.com/image-illustration/small-apartment-kitchen-living-room-600w-630857810.jpg",
            "title" => "Living Room",
        }, 
        {
            "url" => "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_487/at%2Fhouse%20tours%20stock%20archive%2Ffa4f696375867ca1116f9939843ed3ae21b83c88",
            "title" => "Kitchen",
        }, 
        {
            "url" => "https://i.shgcdn.com/06925221-ef7c-4b3e-a4d1-9d1e2ae8698f/-/format/auto/-/preview/3000x3000/-/quality/lighter/",
            "title" => "Balcony",
        }, 
        {
            "url" => "https://images.squarespace-cdn.com/content/v1/5b4e6b87266c074121c335e9/1588964669255-MKCIAKN2QI2K4Y1D8KB6/small+apartment+bathroom+ideas.jpg?",
            "title" => "Bathroom",
        }, 
    ]
    property.metadata = { "images" => images }
    property.save!
end


Property.where(property_type: 2).each do |property|
    images = [
        {
            "url" => "https://fpg.roomsketcher.com/image/topic/28/image/2-Bedroom-Apartment-Plan-3D.jpg",
            "title" => "Plan"
        },
        {
            "url" => "https://www.shutterstock.com/image-illustration/small-apartment-kitchen-living-room-600w-630857810.jpg",
            "title" => "Living Room",
        }, 
        {
            "url" => "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_487/at%2Fhouse%20tours%20stock%20archive%2Ffa4f696375867ca1116f9939843ed3ae21b83c88",
            "title" => "Kitchen",
        }, 
        {
            "url" => "https://i.shgcdn.com/06925221-ef7c-4b3e-a4d1-9d1e2ae8698f/-/format/auto/-/preview/3000x3000/-/quality/lighter/",
            "title" => "Balcony",
        }, 
        {
            "url" => "https://images.squarespace-cdn.com/content/v1/5b4e6b87266c074121c335e9/1588964669255-MKCIAKN2QI2K4Y1D8KB6/small+apartment+bathroom+ideas.jpg?",
            "title" => "Bathroom",
        }, 
    ]
    property.metadata = { "images" => images }
    property.save!
end

Property.where(property_type: 3).each do |property|
    images = [
        {
            "url" => "https://www.hamiltoninternationalestates.com/admin/uploads/news/What%20is%20a%20Duplex%20House88-881608272400.jpg",
            "title" => "Duplex"
        },
        {
            "url" => "https://www.shutterstock.com/image-illustration/small-apartment-kitchen-living-room-600w-630857810.jpg",
            "title" => "Living Room",
        }, 
        {
            "url" => "https://cdn.apartmenttherapy.info/image/upload/f_auto,q_auto:eco,c_fill,g_center,w_730,h_487/at%2Fhouse%20tours%20stock%20archive%2Ffa4f696375867ca1116f9939843ed3ae21b83c88",
            "title" => "Kitchen",
        }, 
        {
            "url" => "https://i.shgcdn.com/06925221-ef7c-4b3e-a4d1-9d1e2ae8698f/-/format/auto/-/preview/3000x3000/-/quality/lighter/",
            "title" => "Balcony",
        }, 
        {
            "url" => "https://images.squarespace-cdn.com/content/v1/5b4e6b87266c074121c335e9/1588964669255-MKCIAKN2QI2K4Y1D8KB6/small+apartment+bathroom+ideas.jpg?",
            "title" => "Bathroom",
        }, 
    ]
    property.metadata = { "images" => images }
    property.save!
end