class TrashImage < ActiveRecord::Base
  belongs_to :trash

  mount_uploader :trash_image, ImageUploader
  before_destroy :remove_img

  def remove_img
    File.delete("#{Rails.root}/public/uploads/images/trash_image/#{name}")
    File.delete("#{Rails.root}/public/uploads/images/trash_image/thumb_#{name}")
  end


end
