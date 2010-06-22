require 'spec_helper'

describe GroupMembership do
  describe "::leaders" do
    gm_leader, gm_normal = Factory(:leader_group_membership), Factory(:group_membership)
    res = GroupMembership.leaders.to_a
    res.include?(gm_leader).should == true
    res.include?(gm_normal).should_not == true
  end
end
