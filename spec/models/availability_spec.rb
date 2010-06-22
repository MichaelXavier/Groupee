require 'spec_helper'

describe "normal availability" do
  subject { Factory.build(:availability) }

  it { should_not overlap_with(subject) }

  it "should have an accurate duration" do
    subject.duration.should == (subject.to - subject.from)
  end
end

describe "time travelling availability" do
  subject { Factory.build(:availability, :to => Time.now.beginning_of_day, :from => Time.now.beginning_of_day.advance(:hours => 2)) }

  it { should_not be_valid }
end
