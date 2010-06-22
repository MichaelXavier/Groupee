require 'spec_helper'

describe Meeting do
  subject {Factory.create(:meeting)}

  describe "#add_attendee" do
    before(:each) do
      @user = Factory.create(:user)
    end

    it "adds to the association" do
      subject.attendees.should_receive(:<<).with(@user)
      subject.add_attendee(@user).should_not == nil
    end

    it "calls a hook" do
      subject.should_receive(:add_attendee_hook).with(@user)
      subject.add_attendee(@user)
    end

    it "does not add to the association and returns nil if the attendee already exists" do
      subject.stub(:attendee_exists?).and_return(true)
      subject.attendees.should_not_receive(:<<).with(@user)
      subject.add_attendee(@user).should == nil
    end
  end

  describe "#sign_in_attendee" do
    before(:each) do
      @user = Factory.create(:user)
      @link_type = mock_model(LinkType)
      LinkType.stub(:meeting_attendee).and_return(@link_type)
      subject.add_attendee(@user)
    end

    it "does not return nil if successful" do
      subject.sign_in_attendee(@user).should_not == nil
    end

    it "calls a hook" do
      subject.should_receive(:sign_in_attendee_hook).with(@user)
      subject.sign_in_attendee(@user)
    end

    it "does not create a link for existing members" do
      Link.should_not_receive(:create!)
      subject.sign_in_attendee(@user)
    end

    it "creates a link for each attendee when a new one is added" do
      user2 = Factory.create(:user)
      subject.add_attendee(user2)
      subject.sign_in_attendee(@user)
      Link.should_receive(:create!).with(:left_user => user2, :right_user => @user, :link_type => @link_type, :context => subject)
      subject.sign_in_attendee(user2)
    end
  end
end
