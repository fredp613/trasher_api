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
          render :json => user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
        }
      end
    end

    

    
  end