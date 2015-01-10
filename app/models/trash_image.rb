class TrashImage < ActiveRecord::Base
  belongs_to :trash
   mount_uploader :trash_image, ImageUploader
end
