require 'spec_helper'

describe "availabilities/new.html.erb" do
  before(:each) do
    assign(:availability, stub_model(Availability,
      :new_record? => true,
      :day_of_week => 1
    ))
  end

  it "renders new availability form" do
    render

    response.should have_selector("form", :action => availabilities_path, :method => "post") do |form|
      form.should have_selector("input#availability_day_of_week", :name => "availability[day_of_week]")
    end
  end
end
