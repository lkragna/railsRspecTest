require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "MyString",
      :user_id => 1,
      :secret_key => "MyString",
      :status => false
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_user_id[name=?]", "user[user_id]"

      assert_select "input#user_secret_key[name=?]", "user[secret_key]"

      assert_select "input#user_status[name=?]", "user[status]"
    end
  end
end
