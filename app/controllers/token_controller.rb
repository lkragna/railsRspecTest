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

    create_token(params)
    var = {:token => @token_response}
    render json: var, status: :ok
  end






  #########################
  private
  def valid_user(user_id, secret_key)
    @user = User.where(user_id: user_id, secret_key: secret_key)
  end

  def validate_credit_card_number(number)
    if (number == nil || /^[0-9]{15,16}$/.match(number) == nil )
       return false;
    end

    credit_card_type = nil

    if (/^34|37.*$/.match(number) != nil )
      credit_card_type = 'AMEX'
    elsif (/^4.*$/.match(number) != nil )
      credit_card_type = 'VISA'
    elsif (/^51|52|53|54|55.*$/.match(number) != nil )
      credit_card_type = 'MASTERCARD'
    else
      credit_card_type = nil
      return false
    end
    true
  end

  def valid_exp_date(exp_date)
    if exp_date == nil
      return false
    end
    valid_date = /^(([0-9]{2})\/([0-9]{2}))$/.match(exp_date)

    if (valid_date == nil || (valid_date[2].to_i < 1 || valid_date[2].to_i > 12) || (valid_date[3].to_i < 16))
      return false
    end
    true
  end

  def valid_name(name)
    valid_name = /^[A-za-z\ ]*$/.match(name)
    if(valid_name == nil)
      return false
    end

    true

  end

  def create_token(params)
    token_card = TokenCard.new(params)
    token_card.save
    @token_response = token_card.token
  end
end
