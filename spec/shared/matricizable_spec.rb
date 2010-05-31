require 'spec_helper'

class MockObject < Object;extend Matricizable;end
describe Matricizable do
  subject { MockObject }

  it "extends any class with matricize_with_cols" do
    subject.should respond_to(:matricize_with_cols)
  end

  describe "matricize_with_cols" do
    before(:each) do
      @matrix_builder = mock(Matricizable::MatrixBuilder).as_null_object
      @sheet = mock(Spreadsheet::Worksheet).as_null_object
      @workbook = mock(Spreadsheet::Workbook, :create_worksheet => @sheet).as_null_object

      subject.stub(:create_workbook).and_return(@workbook)
      Matricizable::MatrixBuilder.stub(:new).and_return(@matrix_builder)
    end

    it "prepares labels first" do
      @matrix_builder.should_receive(:prepare_labels)
      subject.matricize_with_cols {}
    end

    it "yields a matrix builder" do
      subject.matricize_with_cols do |builder|
        builder.should == @matrix_builder
      end
    end

    it "returns the workbook" do
      subject.matricize_with_cols {}.should == @workbook
    end
  end
end

describe Matricizable::MatrixBuilder do
  before(:each) do
    @sheet = mock(Spreadsheet::Worksheet).as_null_object
    @row_map = {1 => 1, 2 => 2}
  end

  subject { Matricizable::MatrixBuilder.new(@sheet, @row_map) }

  it "has accessors for the label map and sheet" do
    subject.sheet.should == @sheet
    subject.map.should == @row_map
    subject.should respond_to(:sheet=)
    subject.should respond_to(:map=)
  end

  describe "prepare_labels" do
    it "puts the same labels in the same order both the rows and cols" do
      @sheet.should_receive(:[]=).with(0, 0, 'User1').once
      @sheet.should_receive(:[]=).with(0, 0, 'User1').once
      @sheet.should_receive(:[]=).with(0, 1, 'User2').once
      @sheet.should_receive(:[]=).with(1, 0, 'User2').once
      subject.prepare_labels(['User1', 'User2'])
    end
  end

  describe "add_weight" do
    before(:each) do
      @sheet.stub_chain(:[], :to_f => 1.5)
    end


    it "adds the weight to both left and right participants" do
      @sheet.stub_chain(:[], :to_f => 2.0)
      @sheet.should_receive(:[]=).with(1, 2, 3.5).once
      @sheet.should_receive(:[]=).with(2, 1, 3.5).once
      subject.add_weight(1, 2, 1.5)
    end

    it "adds a weight string of 0.0 if no weight given" do
      @sheet.should_receive(:[]=).with(1, 2, 1.5).once
      @sheet.should_receive(:[]=).with(2, 1, 1.5).once
      subject.add_weight(1, 2)
    end
  end

end

