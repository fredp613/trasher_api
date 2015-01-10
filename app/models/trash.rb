class Trash < ActiveRecord::Base
	belongs_to :category
	has_many :trash_images

	attr_accessor :temp_id
	# accepts_nested_attributes_for :trash_images
	
	
	
end
