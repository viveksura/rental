class PropertiesController < ApplicationController
    before_action :authenticate_user!

    def all
        if current_user.PropertyManager?
            @properties = apply_filter_and_sort(Property.all, params)
            @params = params
        else
            redirect_to "/422.html"
        end
    end

    def show
        if current_user.PropertyManager?
            @property = Property.where(id: params[:id]).first
        else
            @property = Property.available_properties.where(id: params[:id]).first
        end
        @current_occupancy = @property&.current_occupancy

        unless @property
            redirect_to "/404.html"
        end
    end

    def available
        @properties = apply_filter_and_sort(Property.available_properties, params)
        @params = params
    end

    def update
        Rails.logger.debug "params = #{params.inspect}"
        property = Property.where(property_manager_id: current_user.id, id: params[:id]).first
        if property
            property.update(rent: params["property"]["rent"])
            redirect_to property_path(params[:id]), notice: "Rent Updated"
        else
            redirect_to "/422.html"
        end
    end
    
    def book_appointment
        if current_user.Renter?
            existing_appointments = Appointment.where(date: params[:date], time: params[:time]).where("property_id = ? or renter_id = ?", params[:id], current_user.id)
            if existing_appointments.blank?
                Appointment.create!(renter_id: current_user.id, property_id: params[:id], date: params[:date], time: params[:time])
                redirect_to "/properties/#{params[:id]}/", notice: "Appointment Booked"
            else
                redirect_to "/422.html", notice: "Appointment not booked"
            end
        else
            redirect_to "/422.html"
        end
    end

    private

    def apply_filter_and_sort(properties, params)
        if params["filter"] && params["filter"] == "my_properties"
            properties = properties.where(property_manager_id: current_user.id)
        elsif params["filter"] && params["filter"] != "all"
            properties = properties.where(property_type: params["filter"])
        end

        if params["sort"] == "rent_low_to_high"
            properties = properties.order("rent asc")
        elsif params["sort"] == "rent_high_to_low"
            properties = properties.order("rent desc")
        elsif params["sort"] == "size_low_to_high"
            properties = properties.order("size asc")
        elsif params["sort"] == "size_high_to_low"
            properties = properties.order("size desc")
        else
            properties = properties.order("available_from asc")
        end
        properties
    end
end
