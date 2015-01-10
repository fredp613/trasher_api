class TempImage < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	scope :find_by_temp_id, -> (temp_id) { where(temp_id: temp_id) }
end
