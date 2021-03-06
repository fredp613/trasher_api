class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # acts_as_token_authenticatable


  has_many :trashes #, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #add the commentted sections later if you want custom subdomains, :authenticatable, authentication_keys: [:email]
  validates_uniqueness_of :email #, :scope => :subdomain
 
  before_save :ensure_authentication_token!       

  def self.find_by_email(email)
  	current_user = User.where(email: email).first
  end

  def self.find_by_authentication_token(token)
    current_user = User.where(authentication_token: token).first
  end
     
  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  # Sarbanes-Oxley Compliance: http://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  def password_presence
    password.present?   && password_confirmation.present?
  end

  def password_match
    password == password_confirmation
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(authentication_token: token).first
    end
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
    self.save!
  end

  # def self.find_for_authentication(warden_conditions)
  #   where(:email => warden_conditions[:email], :subdomain => warden_conditions[:subdomain]).first    
  # end
end
