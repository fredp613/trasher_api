class TrashImage < ActiveRecord::Base
  belongs_to :trash

  mount_uploader :trash_image, ImageUploader
  before_destroy :remove_img

  def remove_img  	
    # File.delete("#{Rails.root}/public/uploads/images/trash_image/#{name}")
    # File.delete("#{Rails.root}/public/uploads/images/trash_image/thumb_#{name}")	
	self.remove_trash_image!
  end

  #  def image_data=(data)
  #   # decode data and create stream on them
  #   io = CarrierStringIO.new(Base64.decode64(data))

  #   # this will do the thing (photo is mounted carrierwave uploader)
  #   self.trash_image = io
  # end


end

# class CarrierStringIO < StringIO
#   def original_filename
#     # the real name does not matter
#     "photo.jpeg"
#   end

#   def content_type
#     # this should reflect real content type, but for this example it's ok
#     "image/jpeg"
#   end
# end 
