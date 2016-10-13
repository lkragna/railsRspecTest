require 'rails_helper'

RSpec.describe PurchaseController, type: :controller do

  describe "POST #generate" do




    it "contails valid user" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end

    it "contails invalid user" do
      @request.env["HTTP_USER_ID"] = 11111
      @request.env["HTTP_SECRET_KEY"] = 'ewewew'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}

      post :generate, request_info
      expect(response).to have_http_status(:unauthorized)
    end
    it "contails valid token" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end
    it "contails invalid token" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["token"] = "nada"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid token')
    end
    it "valid currency" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end
    it "invalid currency" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["currency"] = "meh"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid currency')
    end

    it "valid cvc" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid cvc" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["cvc"] = "12345"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid cvc')
    end

    it "valid credit card" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid credit card" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["credit_card_number"] = "1211212"

      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid credit card number')
    end


    it "the credit card is diferent in the credit card token" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["credit_card_number"] = "5134567890123411"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid credit card number, the credit card is diferent in the credit card token')
    end

    it "valid date" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid date" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["exp_date"] = "11/11"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid date')
    end

    it "the date is diferent in the credit card token" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      test_request = request_info.clone
      test_request["exp_date"] = "09/20"
      post :generate, test_request
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid exp date, the exp date is diferent in the credit card token')
    end


    it "purchase complete" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      token_card = TokenCard.new(nil);
      token_test = token_card.test_token(nil)
      request_info = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                      :credit_card_number=>"5134567890123456", :exp_date=> '11/18'}
      post :generate, request_info
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include("transaction_id" => /.*/)
    end

    it "purchase rejected" do
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'

      token_card = TokenCard.new(nil);

      invalid_card_token = {:currency => 'MXN', :amount => '1234.12', :cvc => '123',
                            :credit_card_number=>"4012888888881881", :exp_date=> '11/18'}
      token_test = token_card.test_token(invalid_card_token)
      invalid_card_token = {:token => token_test, :currency => 'MXN', :amount => '1234.12', :cvc => '123',
                            :credit_card_number=>"4012888888881881", :exp_date=> '11/18'}

      post :generate, invalid_card_token
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'error with your purchase pls contact your bank')
    end



  end

end
