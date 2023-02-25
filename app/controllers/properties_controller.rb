class PropertiesController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.PropertyManager?
            properties = Property.all
        else
            properties = Property.available_properties
        end

        render json: properties
    end

    def update_rent
        property = Property.where(manager_id: current_user.id, id: params[:id]).first
        if property
            property.update(rent: params[:rent])
            render status: 200
        else
            render status: 403
        end
    end
    
end
