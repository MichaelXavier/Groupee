require 'spec_helper'

describe "agenda_items/show.html.erb" do
  before(:each) do
    assign(:agenda_item, @agenda_item = stub_model(AgendaItem,
      :name => "MyString",
      :description => "MyText",
      :meeting_id => 1,
      :completed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain(1)
    response.should contain(false)
  end
end
