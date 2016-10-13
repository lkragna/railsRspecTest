require 'rails_helper'

RSpec.describe "currencies/edit", type: :view do
  before(:each) do
    @currency = assign(:currency, Currency.create!(
      :currency_id => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit currency form" do
    render

    assert_select "form[action=?][method=?]", currency_path(@currency), "post" do

      assert_select "input#currency_currency_id[name=?]", "currency[currency_id]"

      assert_select "input#currency_description[name=?]", "currency[description]"
    end
  end
end
