json.array!(@trashes) do |trash|
  json.extract! trash, :id, :title, :description, :catetory_id, :trash_type
  json.url trash_url(trash, format: :json)
end
