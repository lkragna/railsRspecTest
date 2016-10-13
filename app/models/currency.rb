class Currency
  include Mongoid::Document
  field :currency_id, type: String
  field :description, type: String
end
