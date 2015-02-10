class RegistrationsController < Devise::SessionsController
    skip_before_filter :authenticate_user!, :only => [:create, :new]
    # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
    respond_to :json

    def new
      super
    end

    def create

      respond_to do |format|
        format.html {
          super
        }
        format.json {

          # resource = resource_from_credentials
          #build_resource
          # return invalid_login_attempt unless resource

          if resource.valid_password?(params[:password])
            render :json => { user: { email: resource.email, :auth_token => resource.authentication_token } }, success: true, status: :created
          else
            render :json => { success: false }
          end
        }
      end
    end

    

    
  end