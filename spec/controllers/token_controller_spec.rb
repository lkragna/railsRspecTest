require 'rails_helper'

RSpec.describe TokenController, type: :controller do

  describe "POST #new" do
    request_info =   {:credit_card_number => '1234567890123456'}

    it "returns http success" do
      user = FactoryGirl.create(:user, :user_id => 32323)
      @request.headers['user_id'] = 11111
      @request.headers['secret_key'] = 'asdfqwer'
      post :new, request_info
      expect(response).to have_http_status(:unauthorized)
    end
    it "invalid user" do
      user = FactoryGirl.create(:user, :user_id => 32323)
      @request.headers['user_id'] = 2222222
      @request.headers['secret_key'] = 'asdfqwer'
      post :new, request_info
      expect(response).to have_http_status(:unauthorized)
    end

    it "valid user" do
      user = FactoryGirl.create(:user, name: "que es esto")

      @request.headers['user_id'] = 4321
      @request.headers['secret_key'] = 'ppppppp'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end

    it "valid credit Card number" do
      user = FactoryGirl.create(:user)
      @request.headers['user_id'] = 4321
      @request.headers['secret_key'] = 'ppppppp'
      post :new, request_info
      expect(response).to have_http_status(:success)
    end

    it "invalid credit Card number" do
      user = FactoryGirl.create(:user)
      @request.headers['user_id'] = 4321
      @request.headers['secret_key'] = 'ppppppp'
      request_info["credit_card_number"] = "12312312"
      post :new, request_info
      expect(response).to have_http_status(:bad_request)
    end


  end

end
