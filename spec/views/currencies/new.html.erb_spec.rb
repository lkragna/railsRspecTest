require 'rails_helper'

RSpec.describe "currencies/new", type: :view do
  before(:each) do
    assign(:currency, Currency.new(
      :currency_id => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new currency form" do
    render

    assert_select "form[action=?][method=?]", currencies_path, "post" do

      assert_select "input#currency_currency_id[name=?]", "currency[currency_id]"

      assert_select "input#currency_description[name=?]", "currency[description]"
    end
  end
end
