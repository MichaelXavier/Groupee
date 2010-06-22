require 'spec_helper'

describe "assignments/index.html.erb" do
  before(:each) do
    assign(:assignments, [
      stub_model(Assignment,
        :name => "MyString",
        :course_id => 1
      ),
      stub_model(Assignment,
        :name => "MyString",
        :course_id => 1
      )
    ])
  end

  it "renders a list of assignments" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
