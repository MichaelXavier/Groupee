require 'spec_helper'

describe "meetings/show.html.erb" do
  before(:each) do
    assign(:meeting, @meeting = stub_model(Meeting,
      :title => "MyString",
      :location => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
  end
end
