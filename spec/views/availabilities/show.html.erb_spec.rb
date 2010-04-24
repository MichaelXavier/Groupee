require 'spec_helper'

describe "availabilities/show.html.erb" do
  before(:each) do
    assign(:availability, @availability = stub_model(Availability,
      :day_of_week => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(1)
  end
end
