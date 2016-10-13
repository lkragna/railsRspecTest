class TokenCard
  attr_reader(:token)
  def initialize(params)
    @params = params
  end

  def save
    @token = SecureRandom.hex(10)
    new_params = valid_params(@params)
    $redis.set(@token, new_params.to_json)
    $redis.expire( @token, 60*5 )
  end


  def valid_params(params)
    new_params = {:credit_card_number => params[:credit_card_number], :exp_date=> params[:exp_date], :name => params[:name],
                  :bin => params[:bin], :credit_card_type => params[:credit_card_type], :is_credit =>  params[:is_credit]}

  end

  def find
    redis_reponse = $redis.get(@params)
    if(redis_reponse != nil)
      card_info = JSON.parse(redis_reponse)

    end
    card_info
  end

  def test_token(test_params)
    if(test_params == nil)
      test_params = {:credit_card_number=>"5134567890123456", :exp_date=>"11/18", :name=>"Ramses Carbajal", :bin=>"513456", :credit_card_type=>"MASTERCARD", :is_credit=>true}
    end
    @params = test_params
    save()
    @token
  end
  def remove(token)
    $redis.del(token)
  end


end