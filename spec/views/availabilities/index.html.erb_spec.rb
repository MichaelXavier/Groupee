require 'spec_helper'

describe "availabilities/index.html.erb" do
  before(:each) do
    assign(:availabilities, [
      stub_model(Availability,
        :day_of_week => 1
      ),
      stub_model(Availability,
        :day_of_week => 1
      )
    ])
  end

  it "renders a list of availabilities" do
    render
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
