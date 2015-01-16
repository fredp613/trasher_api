class TempImage < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	scope :find_by_temp_id, -> (temp_id) { where(temp_id: temp_id) }

	before_create :default_name
	after_destroy :remove_img


	def remove_img
		# FileUtils.rm_rf("#{Rails.root}/public/uploads/images/temp_image/#{self.id}")
		# FileUtils.rm_rf("#{Rails.root}/public/uploads/images/temp_image/thumb_#{self.id}")
	 self.remove_image!
	end

	def default_name
		name ||= File.basename(image.filename, '.*').titleize if image
	end

end
