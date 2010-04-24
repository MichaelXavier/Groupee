require 'spec_helper'

describe "groups/show.html.erb" do
  before(:each) do
    assign(:group, @group = stub_model(Group,
      :name => "MyString",
      :user_limit => 1,
      :status => "MyString",
      :website => "MyString",
      :open => false
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(1)
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(false)
  end
end
