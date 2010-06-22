require 'spec_helper'

describe "assignments/show.html.erb" do
  before(:each) do
    assign(:assignment, @assignment = stub_model(Assignment,
      :name => "MyString",
      :course_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(1)
  end
end
