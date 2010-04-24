require 'spec_helper'

describe "assignments/edit.html.erb" do
  before(:each) do
    assign(:assignment, @assignment = stub_model(Assignment,
      :new_record? => false,
      :name => "MyString",
      :course_id => 1
    ))
  end

  it "renders the edit assignment form" do
    render

    response.should have_selector("form", :action => assignment_path(@assignment), :method => "post") do |form|
      form.should have_selector("input#assignment_name", :name => "assignment[name]")
      form.should have_selector("input#assignment_course_id", :name => "assignment[course_id]")
    end
  end
end
