class TokenController < ApplicationController
  def new

    user = valid_user(request.env["HTTP_USER_ID"], request.env["HTTP_SECRET_KEY"])
    if !user.any?
      return render json: {:message => 'invalid user'}, status: :unauthorized
    end

    if !validate_credit_card_number(params['credit_card_number'])
      return render json: {:message => 'invalid credit card number'}, status: :bad_request
    end

    if !valid_exp_date(params['exp_date'])
      return render json: {:message => 'invalid date'}, status: :bad_request
    end

    if !valid_name(params['name'])
      return render json: {:message => 'invalid name'}, status: :bad_request
    end

    if !is_credit?(params['is_credit'])
      return render json: {:message => 'invalid param is_credit'}, status: :bad_request
    end

    params_to_tokenizer = {:credit_card_number => params["credit_card_number"],
                           :exp_date => params["exp_date"], :name => params["name"],
                           :bin => @bin, :credit_card_type => @credit_card_type,
                           :is_credit => @is_credit}

    create_token(params_to_tokenizer)
    var = {:token => @token_response}
    render json: var, status: :ok
  end



  private


  def valid_name(name)
    valid_name = /^[A-za-z\ ]*$/.match(name)
    if(valid_name == nil)
      return false
    end

    true

  end

  def is_credit?(is_credit)
    (is_credit.to_s.strip.upcase == 'TRUE')
    if is_credit != nil && (is_credit.to_s.strip.upcase == 'TRUE' || is_credit.to_s.strip.upcase == 'FALSE')
      @is_credit = is_credit
      return true
    end

    false

  end

  def create_token(params)
    token_card = TokenCard.new(params)
    token_card.save
    @token_response = token_card.token
  end


end
