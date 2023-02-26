class Appointment < ApplicationRecord
    belongs_to :renter
    belongs_to :property

end
