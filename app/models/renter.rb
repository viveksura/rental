class Renter < User
    has_many :appointments

    def current_occupancy
        current_occupancy = PropertyOccupancy.where(renter_id: self.id).where("from_date <= ? and to_date >= ?", Date.today, Date.today).first
    end

    def current_rental_property
        current_occupancy&.property
    end
end
  