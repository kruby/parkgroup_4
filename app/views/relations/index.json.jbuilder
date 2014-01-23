json.array!(@relations) do |relation|
  json.extract! relation, :id, :company, :address, :postno, :city, :log, :category, :responsible, :phone, :next_action, :lock_version, :user_id, :type, :search_lock, :homepage, :email
  json.url relation_url(relation, format: :json)
end
