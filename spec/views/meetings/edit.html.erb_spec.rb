require 'spec_helper'

describe "meetings/edit.html.erb" do
  before(:each) do
    assign(:meeting, @meeting = stub_model(Meeting,
      :new_record? => false,
      :title => "MyString",
      :location => "MyString"
    ))
  end

  it "renders the edit meeting form" do
    render

    response.should have_selector("form", :action => meeting_path(@meeting), :method => "post") do |form|
      form.should have_selector("input#meeting_title", :name => "meeting[title]")
      form.should have_selector("input#meeting_location", :name => "meeting[location]")
    end
  end
end
