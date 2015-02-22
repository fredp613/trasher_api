class RegistrationsController < Devise::RegistrationsController
skep_before_filter :authenticate_user_from_token!, :only => [:create, :new]
skip_before_filter :authenticate_user!, :only => [:create, :new]
 respond_to :json

  def create    
  respond_to do |format|
        format.html {
          super
        }
        format.json {
          @user = User.create(sign_up_params_json)
          if @user.save
			      render :json => { :state_code => 0, :user => @user }
			    else
			      render :json => { :state_code => 1,  :messages => @user.errors.full_messages }
			    end
        }
      end
    end

    def sign_up_params_json
    	params.require(:user).permit(:email, :password, :password_confirmation)
    end


end