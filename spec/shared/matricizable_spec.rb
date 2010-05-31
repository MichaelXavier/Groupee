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

  pending "Do more tests of matricizable"
end

describe Matricizable::MatrixBuilder do
  subject { Matricizable::MatrixBuilder.new }
  pending "Do more tests of matrix builder"
end

