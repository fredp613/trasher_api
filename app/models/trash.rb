class Trash < ActiveRecord::Base
	belongs_to :category
	belongs_to :user

	has_many :trash_images, dependent: :destroy
	attr_accessor :temp_id
	
end
