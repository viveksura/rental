class Property < ApplicationRecord
    belongs_to :manager, class_name: "PropertyManager", foreign_key: "property_manager_id"
    has_many :property_occupancies
  
    enum :property_type, [:studio, :one_bedroom, :two_bedroom, :duplex]


    def self.available_properties
        Property.where("available_from <= ?", Date.today + 5.months)
    end

    def current_occupancy
        PropertyOccupancy.where(property_id: self.id).where("from_date >= ? and to_date <= ?", Date.today, Date.today).first
    end

    def current_renter
        current_occupancy&.renter
    end
end
