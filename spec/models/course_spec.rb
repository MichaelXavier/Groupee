require 'spec_helper'

describe Course do
  describe "#add_student" do
    subject {Factory.create(:course) }

    before(:each) do
      @user = Factory.create(:user)
      @link_type = mock_model(LinkType)
      LinkType.stub(:classmate).and_return(@link_type)
    end

    it "adds a basic member" do
      subject.add_student(@user)
      subject.students.count.should == 1
    end

    it "does not add existing members" do
      subject.add_student(@user)
      subject.add_student(@user).should == nil
      subject.students.count.should == 1
    end

    it "does not create a link for existing members" do
      Link.should_not_receive(:create!)
      subject.add_student(@user)
    end

    it "creates a link for each user when a new one is added" do
      user2 = Factory.create(:user)
      Link.should_receive(:create!).with(:left_user => user2, :right_user => @user, :link_type => @link_type, :context => subject)
      subject.add_student(@user)
      subject.add_student(user2)
    end
  end
end
