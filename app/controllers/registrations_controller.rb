class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(sign_up_params)
    if @user.save
      render :json => { :user => @user }
    else
      render :json => { :messages => @user.errors.full_messages }
    end

  end
end