require 'spec_helper'

describe Assignment do
  it "validates the duration" do
    assignment = Factory.build(:assignment, :assigned => 3.days.from_now, :due => 3.days.ago) 
    assignment.should_not be_valid
  end
end
