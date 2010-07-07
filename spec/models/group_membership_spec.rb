require 'spec_helper'

describe GroupMembership do
  describe "::leaders" do
    it "selects group leaders only" do
      gm_leader, gm_normal = Factory.create(:leader_group_membership), Factory.create(:group_membership)
      res = GroupMembership.leaders.to_a
      res.should include(gm_leader)
      res.should_not include(gm_normal)
    end
  end
end
