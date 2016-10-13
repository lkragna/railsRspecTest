require 'rails_helper'

RSpec.describe TokenController, type: :controller do

  describe "POST #new" do
    request_info =   {:credit_card_number => '5134567890123456',
                      :exp_date=> '11/18', :name => "Ramses Carbajal",
                      :is_credit => true}

    it "returns http success" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end
    it "invalid user" do
      user = FactoryGirl.create(:user, :user_id => 32323)
      @request.env["HTTP_USER_ID"] = 43212
      @request.env["HTTP_SECRET_KEY"] = 'ppppppp3'
      post :new, request_info
      expect(response).to have_http_status(:unauthorized)
    end

    it "valid user" do
      user = FactoryGirl.create(:user, name: "que es esto")

      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end

    it "valid credit Card number" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid credit Card number" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      test_credit_card = request_info.clone
      test_credit_card["credit_card_number"] = "12312312"
      post :new, test_credit_card
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid credit card number')
    end

    it "valid date" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid date" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      test_credit_card = request_info.clone
      test_credit_card["exp_date"] = "11/11"
      post :new, test_credit_card
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid date')
    end

    it "valid name" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)

    end

    it "invalid name" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      test_credit_card = request_info.clone
      test_credit_card["name"] = "ramses2_asdf3 "
      post :new, test_credit_card
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid name')
    end

    it "is valid Credit card? " do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      test_credit_card = request_info.clone
      test_credit_card["is_credit"] = "false"
      post :new, test_credit_card
      expect(response).to have_http_status(:success)
    end

    it "is invalid Credit card? " do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      test_credit_card = request_info.clone
      test_credit_card["is_credit"] = "nada"
      post :new, test_credit_card
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to include("message" => 'invalid param is_credit')
    end



    it "create token" do
      user = FactoryGirl.create(:user)
      @request.env["HTTP_USER_ID"] = 1234
      @request.env["HTTP_SECRET_KEY"] = 'qwerty'
      post :new, request_info
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include("token" => /.*/)

    end


  end

end
