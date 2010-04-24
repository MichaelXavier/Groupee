require 'spec_helper'

describe "meetings/new.html.erb" do
  before(:each) do
    assign(:meeting, stub_model(Meeting,
      :new_record? => true,
      :title => "MyString",
      :location => "MyString"
    ))
  end

  it "renders new meeting form" do
    render

    response.should have_selector("form", :action => meetings_path, :method => "post") do |form|
      form.should have_selector("input#meeting_title", :name => "meeting[title]")
      form.should have_selector("input#meeting_location", :name => "meeting[location]")
    end
  end
end
