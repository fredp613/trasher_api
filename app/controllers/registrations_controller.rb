class RegistrationsController < Devise::RegistrationsController
skip_before_filter :authenticate_user!, :only => [:create, :new]
 respond_to :json

  def create    
  respond_to do |format|
        format.html {
          super
        }
        format.json {

          User.create(sign_up_params)
          if @user.save
			      render :json => { :state_code => 0, :user => @user }
			    else
			      render :json => { :state_code => 1,  :messages => @user.errors.full_messages }
			    end
        }
      end
    end
end