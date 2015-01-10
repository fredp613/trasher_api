json.array!(@temp_images) do |temp_image|
  json.extract! temp_image, :id, :image, :temp_id
  json.url temp_image_url(temp_image, format: :json)
end
