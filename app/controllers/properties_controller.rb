class PropertiesController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.property_manager?
            properties = Property.all
        else
            properties = Property.available_properties
        end

        render json: :properties
    end
    
end
