class TokenController < ApplicationController
  def new

    user = valid_user(request.env["HTTP_USER_ID"], request.env["HTTP_SECRET_KEY"])
    if !user.any?
      return render json: {:message => 'invalid user'}, status: :unauthorized
    end

    if !validate_credit_card_number(params['credit_card_number'])
      return render json: {:message => 'invalid credit card number'}, status: :bad_request
    end


    var = {:response_code => params['asdf'],:content_type => request.headers["Content-Type"]}
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
end
