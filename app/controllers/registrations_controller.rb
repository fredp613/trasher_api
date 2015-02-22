class RegistrationsController < Devise::RegistrationsController

  def create    
  respond_to do |format|
        format.html {
          super
        }
        format.json {

          User.create(params[:user])
          if @user.save
			      render :json => { :state_code => 0, :user => @user }
			    else
			      render :json => { :state_code => 1,  :messages => @user.errors.full_messages }
			    end
        }
      end
end