class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  # In Rails 3.x:
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # In Rails 4.x:
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  around_filter :global_request_logging
  skip_before_filter  :verify_authenticity_token

  alias_method :devise_current_user, :current_user
 
 #  private
  
  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    # user = User.find_by_email(user_email)
    user = User.find_by_authentication_token(user_auth_token)
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end

  def current_user       
    user_auth_token = request.headers["X-API-TOKEN"].presence
    if user_auth_token
      User.find_by_authentication_token(user_auth_token)      
    else
      devise_current_user
    end   
  end


  def global_request_logging 
    logger.info "USERAGENT: #{request.headers['X-API-TOKEN']}"
    begin 
      yield 
    ensure 
      logger.info "response_status: #{response.status}"
    end 
  end 

  

end
