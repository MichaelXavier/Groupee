require 'spec_helper'

describe "courses/show.html.erb" do
  before(:each) do
    assign(:course, @course = stub_model(Course,
      :title => "MyString",
      :sln => "MyString",
      :catalog_name => "MyString",
      :section => "MyString",
      :quarter => "MyString",
      :year => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(1)
  end
end
