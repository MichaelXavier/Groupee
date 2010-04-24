require 'spec_helper'

describe "meetings/index.html.erb" do
  before(:each) do
    assign(:meetings, [
      stub_model(Meeting,
        :title => "MyString",
        :location => "MyString"
      ),
      stub_model(Meeting,
        :title => "MyString",
        :location => "MyString"
      )
    ])
  end

  it "renders a list of meetings" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
  end
end
