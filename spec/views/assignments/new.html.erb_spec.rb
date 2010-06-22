require 'spec_helper'

describe "assignments/new.html.erb" do
  before(:each) do
    assign(:assignment, stub_model(Assignment,
      :new_record? => true,
      :name => "MyString",
      :course_id => 1
    ))
  end

  it "renders new assignment form" do
    render

    response.should have_selector("form", :action => assignments_path, :method => "post") do |form|
      form.should have_selector("input#assignment_name", :name => "assignment[name]")
      form.should have_selector("input#assignment_course_id", :name => "assignment[course_id]")
    end
  end
end
