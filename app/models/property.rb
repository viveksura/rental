class Property < ApplicationRecord
    belongs_to :manager, class_name: "PropertyManager", foreign_key: "property_manager_id"
    has_many :property_occupancies
    has_many :appointments
  
    enum :property_type, [:studio, :one_bedroom, :two_bedroom, :duplex]


    def self.available_properties
        Property.where("available_from <= ?", Date.today + 5.months)
    end

    def current_occupancy
        PropertyOccupancy.where(property_id: self.id).where("from_date <= ? and to_date >= ?", Date.today, Date.today).first
    end

    def current_renter
        current_occupancy&.renter
    end

    def images
        list = []
        # get this data from metadata column in property
        10.times do |t|
            list.push({
                "url" => "https://upload.wikimedia.org/wikipedia/commons/d/d6/Studio_Apartment_Minneapolis_1.jpg",
                "description" => "#{t} room"
            })
        end
        list
    end

    def available_visiting_slots
        slots = []
        if self.available_from <= (Date.today + 5.months)
            3.times do |i|
                date = Date.today + (i + 1).days
                slots.push({date: date, time: "09:00 AM"})
                slots.push({date: date, time: "09:30 AM"})
                slots.push({date: date, time: "10:00 AM"})
            end
        end
        slots -= booked_visiting_slots
        slots
    end

    def booked_visiting_slots
        self.appointments.where("created_at >= ?", Date.today).map do |appointment|
            {date: appointment.date, time: appointment.time}
        end
    end
end
