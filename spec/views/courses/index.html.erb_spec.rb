require 'spec_helper'

describe "courses/index.html.erb" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :title => "MyString",
        :sln => "MyString",
        :catalog_name => "MyString",
        :section => "MyString",
        :quarter => "MyString",
        :year => 1
      ),
      stub_model(Course,
        :title => "MyString",
        :sln => "MyString",
        :catalog_name => "MyString",
        :section => "MyString",
        :quarter => "MyString",
        :year => 1
      )
    ])
  end

  it "renders a list of courses" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
