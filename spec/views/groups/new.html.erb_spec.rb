require 'spec_helper'

describe "groups/new.html.erb" do
  before(:each) do
    assign(:group, stub_model(Group,
      :new_record? => true,
      :name => "MyString",
      :user_limit => 1,
      :status => "MyString",
      :website => "MyString",
      :open => false
    ))
  end

  it "renders new group form" do
    render

    response.should have_selector("form", :action => groups_path, :method => "post") do |form|
      form.should have_selector("input#group_name", :name => "group[name]")
      form.should have_selector("input#group_user_limit", :name => "group[user_limit]")
      form.should have_selector("input#group_status", :name => "group[status]")
      form.should have_selector("input#group_website", :name => "group[website]")
      form.should have_selector("input#group_open", :name => "group[open]")
    end
  end
end
