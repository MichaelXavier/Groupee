require 'spec_helper'

class MockObject < Object;extend Matricizable;end
describe Matricizable do
  subject { MockObject }

  it do
    subject.should respond_to(:matricize_with_cols)
  end
  pending "Do more tests of matricizable"
end

describe Matricizable::MatrixBuilder do
  subject { Matricizable::MatrixBuilder.new }
  pending "Do more tests of matrix builder"
end

