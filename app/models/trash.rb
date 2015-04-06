class Trash < ActiveRecord::Base
	belongs_to :category
	belongs_to :user

	has_many :trash_images, dependent: :destroy
	attr_accessor :temp_id

	def self.rid
		where(:trash_type => true)
	end

	def self.wanted
		where(:trash_type => false)
	end

	def first_image
		self.trash_images.first
	end
	
end
