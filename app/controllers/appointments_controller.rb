class AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.Renter?
            @appointments = Appointment.where(renter_id: current_user.id).where("created_at >= ?", Date.today).includes(:renter, property: :manager)
        else 
            @appointments = Appointment.where("created_at >= ?", Date.today).includes(:renter, property: :manager)
        end
    end
end