class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    # Include Pagy
    include Pagy::Backend

    before_action  :set_city,
                    :set_material,
                    :set_level,
                    :store_action

    #Keep clean Application conroller, moved on noncern
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    #After sign in
    def after_sign_in_path_for(resource)
        root_path
    end
    
    def after_sign_up_path_for(resource)
        root_path
    end
    def after_sign_out_path_for(resource)
        root_path
    end


private
    def set_city
        @citytowns = Citytown.all
    end

    def set_material
        @materials = Material.all
    end

    def set_level
        @levels = Level.all
    end
    def store_action
        return unless request.get? 
        if (request.path != "/users/sign_in" &&
            request.path != "/users/sign_up" &&
            request.path != "/users/password/new" &&
            request.path != "/users/password/edit" &&
            request.path != "/users/confirmation" &&
            request.path != "/users/sign_out" &&
            !request.xhr?) # don't store ajax calls
            store_location_for(:user, request.fullpath)
        end
    end
protected
    #Configure permitted parameters
    def configure_permitted_parameters
        #Sign Up account params
        sign_up_params = [:email, :password, :first_name, :last_name, :full_name, :contact, :matricule,
            :user_role, :gender, :city_name, :level_name, :school_name, :media_name, :material_name, :doublant, :avatar, :slug]
        #Update account params
        update_params = [:first_name, :last_name, :full_name, :contact, :matricule,
            :user_role, :gender, :city_name, :level_name, :material_name, :doublant, 
            :password, :password_confirmation, :current_password, :avatar]

        devise_parameter_sanitizer.permit(:sign_in, keys: [:logged, :password])
        devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_params )
        devise_parameter_sanitizer.permit(:account_update, keys: sign_up_params)
    end
end
