require 'spec_helper'

describe "agenda_items/edit.html.erb" do
  before(:each) do
    assign(:agenda_item, @agenda_item = stub_model(AgendaItem,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :meeting_id => 1,
      :completed => false
    ))
  end

  it "renders the edit agenda_item form" do
    render

    response.should have_selector("form", :action => agenda_item_path(@agenda_item), :method => "post") do |form|
      form.should have_selector("input#agenda_item_name", :name => "agenda_item[name]")
      form.should have_selector("textarea#agenda_item_description", :name => "agenda_item[description]")
      form.should have_selector("input#agenda_item_meeting_id", :name => "agenda_item[meeting_id]")
      form.should have_selector("input#agenda_item_completed", :name => "agenda_item[completed]")
    end
  end
end
