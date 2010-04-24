require 'spec_helper'

describe "courses/new.html.erb" do
  before(:each) do
    assign(:course, stub_model(Course,
      :new_record? => true,
      :title => "MyString",
      :sln => "MyString",
      :catalog_name => "MyString",
      :section => "MyString",
      :quarter => "MyString",
      :year => 1
    ))
  end

  it "renders new course form" do
    render

    response.should have_selector("form", :action => courses_path, :method => "post") do |form|
      form.should have_selector("input#course_title", :name => "course[title]")
      form.should have_selector("input#course_sln", :name => "course[sln]")
      form.should have_selector("input#course_catalog_name", :name => "course[catalog_name]")
      form.should have_selector("input#course_section", :name => "course[section]")
      form.should have_selector("input#course_quarter", :name => "course[quarter]")
      form.should have_selector("input#course_year", :name => "course[year]")
    end
  end
end
