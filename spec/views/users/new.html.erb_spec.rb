require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :user_id => 1,
      :secret_key => "MyString",
      :status => false
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_user_id[name=?]", "user[user_id]"

      assert_select "input#user_secret_key[name=?]", "user[secret_key]"

      assert_select "input#user_status[name=?]", "user[status]"
    end
  end
end
