json.extract! user, :id, :name, :user_id, :secret_key, :status, :created_at, :updated_at
json.url user_url(user, format: :json)