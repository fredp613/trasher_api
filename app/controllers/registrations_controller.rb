class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(sign_up_params)
    if @user.save
      render :json => {:state => {:code => 0}, :data => @user }
    else
      render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
    end

  end
end