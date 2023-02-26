class PropertiesController < ApplicationController
    before_action :authenticate_user!

    def all
        if current_user.PropertyManager?
            @properties = apply_filter_and_sort(Property.all, params)
            @params = params
        else
            redirect_to "/404.html"
        end
    end

    def show
        if current_user.Renter? && false
           @property =  current_user&.current_rental_property
        elsif current_user.PropertyManager?
            @property = Property.where(id: params[:id]).first
        else
            @property = Property.where(id: params[:id]).first
        end

        if @property && @property.id == params[:id].to_i
            @current_occupancy = @property&.current_occupancy || PropertyOccupancy.first
        else
            redirect_to "/404.html"
        end
    end

    def available
        @properties = apply_filter_and_sort(Property.available_properties, params)
        @params = params
    end

    def update
        property = Property.where(manager_id: current_user.id, id: params[:id]).first
        if property
            property.update(rent: params[:rent])
            redirect_to property_show
        else
            redirect_to "/422.html"
        end
    end
    
    def book_appointment
        Rails.logger.debug "params = #{params.inspect}"
    end

    private

    def apply_filter_and_sort(properties, params)
        if params["filter"] && params["filter"] != "all"
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
