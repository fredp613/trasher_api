


class SessionsController < Devise::SessionsController
  before_filter :configure_permitted_parameters
  skip_before_filter :authenticate_user!, :only => [:create, :new, :destroy]
  skip_before_filter :verify_signed_out_user, :only => [:destroy]
  skip_before_filter :authenticate_user_from_token!, :only => [:create, :new, :destroy]
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
          resource = resource_from_credentials
          #build_resource
          return invalid_login_attempt unless resource

          if resource.valid_password?(params[:user][:password])
            # sign_in(resource_name, resource)  
            render :json => { user: { email: resource.email, :auth_token => resource.authentication_token } }, success: true, status: :created
          else            
           invalid_login_attempt           
          end
        }
      end
    end

    def destroy
      respond_to do |format|
        format.html {
          super
        }
        format.json {
          user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])

          if user
            user.reset_authentication_token!
            signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
            render :json => { :state_code => 0, :new_user_token => user.authentication_token }, :success => true, :status => 200            
            logger.info "LOGOUT MESSAGE: #{user.authentication_token}"                      
          else
            logger.info "LOGOUT MESSAGE: we didnt make it"
            # invalid_login_attempt
            render :json => { :state_code => 1, :message => 'Something went wrong, please contact support.' }, :status => 404
          end
        }
      end
    end

   
    protected
    def invalid_login_attempt
      warden.custom_failure!
      render json: { success: false, message: 'Error with your login or password', user: params[:user][:password] }, status: 401
    end

    def resource_from_credentials
      # use this for subdomain (api): data = { email: params[:user][:email], subdomain: params[:user][:subdomain] }
      data = { email: params[:user][:email] }
      if res = resource_class.find_for_database_authentication(data)
        if res.valid_password?(params[:user][:password])
          res
        end
      end
    end


    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in).push(:subdomain)
    end

  



  end

