json.array!(@trash_images) do |trash_image|
  json.extract! trash_image, :id, :trash_image, :trash_id
  json.url trash_image_url(trash_image, format: :json)
end
