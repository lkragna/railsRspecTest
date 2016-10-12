class User
  include Mongoid::Document
  field :name, type: String
  field :user_id, type: String
  field :secret_key, type: String
  field :status, type: String
end
