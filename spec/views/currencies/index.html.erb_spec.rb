require 'rails_helper'

RSpec.describe "currencies/index", type: :view do
  before(:each) do
    assign(:currencies, [
      Currency.create!(
        :currency_id => "Currency",
        :description => "Description"
      ),
      Currency.create!(
        :currency_id => "Currency",
        :description => "Description"
      )
    ])
  end

  it "renders a list of currencies" do
    render
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
