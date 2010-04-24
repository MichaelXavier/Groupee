require 'spec_helper'

describe "group_memberships/show.html.erb" do
  before(:each) do
    assign(:group_membership, @group_membership = stub_model(GroupMembership,
      :leader => false,
      :status => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(false)
    response.should contain("MyString")
  end
end
