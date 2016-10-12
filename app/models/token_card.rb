class TokenCard
  attr_reader(:token)
  def initialize(params)
    @params = params
  end

  def save
    @token = SecureRandom.hex(10)
    new_params = valid_params(@params)

    $redis.set(@token, {:param1 => new_params})
    $redis.expire(@token,30)
    print @token
  end

  private
  def valid_params(params)

    new_params = {:credit_card_number => params["credit_card_number"], :exp_date=> params["exp_date"], :name => params["name"]}

  end
end