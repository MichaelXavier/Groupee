require 'spec_helper'

describe "agenda_items/index.html.erb" do
  before(:each) do
    assign(:agenda_items, [
      stub_model(AgendaItem,
        :name => "MyString",
        :description => "MyText",
        :meeting_id => 1,
        :completed => false
      ),
      stub_model(AgendaItem,
        :name => "MyString",
        :description => "MyText",
        :meeting_id => 1,
        :completed => false
      )
    ])
  end

  it "renders a list of agenda_items" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
