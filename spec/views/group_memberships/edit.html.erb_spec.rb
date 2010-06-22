require 'spec_helper'

describe "group_memberships/edit.html.erb" do
  before(:each) do
    assign(:group_membership, @group_membership = stub_model(GroupMembership,
      :new_record? => false,
      :leader => false,
      :status => "MyString"
    ))
  end

  it "renders the edit group_membership form" do
    render

    response.should have_selector("form", :action => group_membership_path(@group_membership), :method => "post") do |form|
      form.should have_selector("input#group_membership_leader", :name => "group_membership[leader]")
      form.should have_selector("input#group_membership_status", :name => "group_membership[status]")
    end
  end
end
