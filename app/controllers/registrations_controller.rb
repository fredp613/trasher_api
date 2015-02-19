class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(sign_up_params)
    if @user.save
      render :json => { :state_code => 0, :user => @user }
    else
      render :json => { :state_code => 1,  :messages => @user.errors.full_messages }
    end
  end
end