require 'spec_helper'

describe Group do
  before(:each) do
    @group = Factory.create(:group)
    3.times { Factory.create(:group_membership, :group => @group) }
    Factory.create(:leader_group_membership, :group => @group)
  end

  describe "a small group with a leader" do
    subject do
      @group
    end

    it "should have group memberships" do
      subject.group_memberships.should_not be_empty
    end

    it "should have users by assocation" do
      subject.users.should_not be_empty
    end

    it "should have at least one leader" do
      subject.leaders.should_not be_empty 
      leader_memberships = subject.group_memberships.where('leader = ?', true)
      subject.leaders.all? {|leader| leader_memberships.include? leader}
    end
  end

  describe "a group with no overlapping days" do
    subject do
      dow = 1
      @group.users.each do |user|
        Factory.create(:availability, :user => user, :day_of_week => dow)
        dow += 1
      end
      @group
    end

    it { subject.best_meeting_times.should be_empty }
  end

  describe "a group with no overlapping times" do
    subject do
      from = Time.now.beginning_of_day
      @group.users.each do |user|
        to = from.advance(:minutes => 5)
        Factory.create(:availability, :user => user, :from => from, :to => to)
        from = from.advance(:minutes => 10)
      end
      @group
    end

    it { subject.best_meeting_times.should be_empty }
  end

  describe "a group with multiple shared times" do
    subject do
      # Do 2 sets of overlapping times, one oddball
      from1, from2, @other_from = Time.now.beginning_of_day, Time.now.beginning_of_day.advance(:hours => 2), Time.now.beginning_of_day.advance(:hours => 4)
      to1, to2, @other_to       = from1.advance(:minutes => 30), from2.advance(:minutes => 45), @other_from.advance(:minutes => 60)

      @group.users[0,2].each do |user|
        Factory.create(:availability, :user => user, :day_of_week => 1, :from => from1, :to => to1)
      end
      #user 0 will have from and to 1 and 2
      Factory.create(:availability, :user => @group.users[0], :day_of_week => 2, :from => from2, :to => to2)
      Factory.create(:availability, :user => @group.users[2], :day_of_week => 2, :from => from2, :to => to2)
      Factory.create(:availability, :user => @group.users[3], :day_of_week => 1, :from => @other_from, :to => @other_to)

      @group
    end

    it "should respect the count when given" do
      subject.best_meeting_times(:count => 1).count.should == 1
    end

    it "should return all availabilities if no count given" do
      subject.best_meeting_times.count.should == 2
    end

    it "should not include the oddball availability" do
      subject.best_meeting_times.each do |avail|
        avail.from.should_not == @other_from
        avail.to.should_not   == @other_to
      end
    end
  end

  describe "a group with overlapping availabilities of varying lengths" do
    # The availabilities should have a 20 mintue overlap like so, 1 hour duration
    # user 1    user2     user3
    #       |----------|
    # |---------|   |----------|
    subject do
      # One person starts early, one person is in the middle and one person is available late
      from1, from2, from3 = Time.now.beginning_of_day, Time.now.beginning_of_day.advance(:minutes => 40), Time.now.beginning_of_day.advance(:minutes => 80)
      to1, to2, to3       = from1.advance(:hours => 1), from2.advance(:hours => 1), from3.advance(:hours => 1)

      Factory.create(:availability, :user => @group.users[0], :day_of_week => 1, :from => from1, :to => to1)
      Factory.create(:availability, :user => @group.users[1], :day_of_week => 1, :from => from2, :to => to2)
      Factory.create(:availability, :user => @group.users[2], :day_of_week => 1, :from => from3, :to => to3)
      @group
    end

    it "should suggest a meeting only if the min duration <= 20 mins" do
      subject.best_meeting_times(:count => 1, :duration => 21).count.should == 0
      subject.best_meeting_times(:count => 1, :duration => 5).count.should == 1
    end
  end

  describe "#add_member" do
    subject {Factory.create(:group, :user_limit => 2)}

    before(:each) do
      @user = Factory.create(:user)
      @link_type = mock_model(LinkType)
      LinkType.stub(:group_member).and_return(@link_type)
    end

    it "adds a basic member" do
      subject.add_member(@user)
      subject.users.count.should == 1
    end

    it "accepts arguments for the membership" do
      subject.add_member(@user, :leader => true)
      subject.users.count.should == 1
      subject.leaders.count.should == 1
    end

    it "does not add existing members" do
      subject.add_member(@user)
      subject.add_member(@user).should == nil
      subject.users.count.should == 1
    end

    it "does not create a link for existing members" do
      Link.should_not_receive(:create!)
      subject.add_member(@user)
    end

    it "does not allow you to exceed the group limit" do
      lambda { 3.times { subject.add_member(Factory.create(:user)) } }.should raise_error(GroupFullError)
    end

    it "creates a link for each user when a new one is added" do
      user2 = Factory.create(:user)
      Link.should_receive(:create!).with(:left_user => user2, :right_user => @user, :link_type => @link_type, :context => subject)
      subject.add_member(@user)
      subject.add_member(user2)
    end
  end
end
