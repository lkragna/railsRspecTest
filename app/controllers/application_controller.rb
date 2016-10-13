class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  def valid_user(user_id, secret_key)
    @user = User.where(user_id: user_id, secret_key: secret_key)
  end

  def validate_credit_card_number(number)
    if (number == nil || /^[0-9]{15,16}$/.match(number) == nil )
      return false;
    end

    @credit_card_type = nil

    if (/^34|37.*$/.match(number) != nil )
      @credit_card_type = 'AMEX'
    elsif (/^4.*$/.match(number) != nil )
      @credit_card_type = 'VISA'
    elsif (/^51|52|53|54|55.*$/.match(number) != nil )
      @credit_card_type = 'MASTERCARD'
    else
      @credit_card_type = nil
      return false
    end

    bin = /^(([0-9]{6})([0-9]*))$/.match(number)

    if(bin != nil)
      @bin = bin[2]
    end




    true
  end

  def valid_exp_date(exp_date)
    if exp_date == nil
      return false
    end
    valid_date = /^(([0-9]{2})\/([0-9]{2}))$/.match(exp_date)
    current_year = Time.now.year.to_s[2..3].to_i
    if (valid_date == nil || (valid_date[2].to_i < 1 || valid_date[2].to_i > 12) || (valid_date[3].to_i < current_year))
      return false
    end
    true
  end
end
