class PropertiesController < ApplicationController
    before_action :authenticate_user!

    def all
        if current_user.PropertyManager?
            @properties = Property.all
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
            @images = []
            10.times do |t|
                @images.push({
                    "url" => "https://upload.wikimedia.org/wikipedia/commons/d/d6/Studio_Apartment_Minneapolis_1.jpg",
                    "description" => "#{t} room"
                })
            end
        else
            redirect_to "/404.html"
        end
    end

    def available
        @properties = Property.available_properties
    end

    def update_rent
        property = Property.where(manager_id: current_user.id, id: params[:id]).first
        if property
            property.update(rent: params[:rent])
            redirect_to property_show
        else
            redirect_to "/422.html"
        end
    end
end
