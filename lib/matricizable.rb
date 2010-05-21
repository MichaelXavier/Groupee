module Matricizable

private
  def matricize_with_cols(cols={})
    raise ArgumentError, "Expecting block" unless block_given?
    idx = 1
    row_col_map = {}
    cols.each do |id, label|
      row_col_map[id] = idx
      idx += 1
    end

    workbook = create_workbook #TODO args
    builder = MatrixBuilder.new(workbook, row_col_map)
    builder.prepare_labels
    yield builder
  end

  def create_workbook
    raise NotImplementedError
  end

  class MatrixBuilder
    attr_reader :workbook, :map

    def initialize(workbook, map)
      @workbook, @map = workbook, map
    end

    def prepare_labels
      #TODO: right top row and leftmost col with the names from the map
      raise NotImplementedError
    end

    def add_weight(left_id, right_id, weight=0.0)
      #TODO: index into the map for both participants and add the given weight
      #TODO: first you shold ||= 0.0 though
    end
    
  end
end
