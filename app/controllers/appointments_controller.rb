class AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.Renter?
            @appointments = Appointment.where(renter_id: current_user.id).where("created_at >= ?", Date.today).includes(:renter, property: :manager).order("date asc")
        else 
            @appointments = Appointment.where("created_at >= ?", Date.today).includes(:renter, property: :manager).order("date asc")
        end
    end
end