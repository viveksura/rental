class PropertyOccupancy < ApplicationRecord
    belongs_to :renter, class_name: "Renter", foreign_key: :renter_id
    belongs_to :property

end
