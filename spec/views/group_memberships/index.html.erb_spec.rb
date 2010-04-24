require 'spec_helper'

describe "group_memberships/index.html.erb" do
  before(:each) do
    assign(:group_memberships, [
      stub_model(GroupMembership,
        :leader => false,
        :status => "MyString"
      ),
      stub_model(GroupMembership,
        :leader => false,
        :status => "MyString"
      )
    ])
  end

  it "renders a list of group_memberships" do
    render
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
  end
end
