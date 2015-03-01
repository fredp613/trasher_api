class TrashImage < ActiveRecord::Base
  belongs_to :trash

  mount_uploader :trash_image, ImageUploader
  before_destroy :remove_img

  def remove_img  	
    # File.delete("#{Rails.root}/public/uploads/images/trash_image/#{name}")
    # File.delete("#{Rails.root}/public/uploads/images/trash_image/thumb_#{name}")	
	self.remove_trash_image!
  end

   def trash_image=(data)
    # decode data and create stream on them
    io = CarrierStringIO.new(Base64.decode64(data))

    # this will do the thing (photo is mounted carrierwave uploader)
    self.trash_image = io
  end


end
