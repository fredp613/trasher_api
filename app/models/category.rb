class Category < ActiveRecord::Base
	has_many :trashes
end
