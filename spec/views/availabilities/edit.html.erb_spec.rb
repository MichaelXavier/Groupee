require 'spec_helper'

describe "availabilities/edit.html.erb" do
  before(:each) do
    assign(:availability, @availability = stub_model(Availability,
      :new_record? => false,
      :day_of_week => 1
    ))
  end

  it "renders the edit availability form" do
    render

    response.should have_selector("form", :action => availability_path(@availability), :method => "post") do |form|
      form.should have_selector("input#availability_day_of_week", :name => "availability[day_of_week]")
    end
  end
end
