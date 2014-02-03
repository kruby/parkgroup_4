json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :priority, :parent_id, :user_id, :active
  json.url post_url(post, format: :json)
end
