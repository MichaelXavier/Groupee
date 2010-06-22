require 'spec_helper'

describe "group_memberships/new.html.erb" do
  before(:each) do
    assign(:group_membership, stub_model(GroupMembership,
      :new_record? => true,
      :leader => false,
      :status => "MyString"
    ))
  end

  it "renders new group_membership form" do
    render

    response.should have_selector("form", :action => group_memberships_path, :method => "post") do |form|
      form.should have_selector("input#group_membership_leader", :name => "group_membership[leader]")
      form.should have_selector("input#group_membership_status", :name => "group_membership[status]")
    end
  end
end
