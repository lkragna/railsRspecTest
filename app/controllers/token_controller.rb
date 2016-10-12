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
    print "tarjeta #{number}"
    if (number == nil || !(number =~ /(([0-9]{11,12})([0-9]{4}))/) )
       return false;
    end



    true
  end
end
