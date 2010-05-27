require 'spec_helper'

describe AgendaItem do
  subject { Factory.create(:agenda_item) }

  describe "#mark_completed" do
    it "sets completed true" do
      subject.mark_completed
      subject.completed.should == true
    end
  end
end
