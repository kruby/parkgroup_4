json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :attachable_type, :attachable_id, :description, :image_size, :priority, :asset_id
  json.url attachment_url(attachment, format: :json)
end
