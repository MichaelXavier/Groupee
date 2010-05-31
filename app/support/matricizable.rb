module Matricizable

  # Receives hash with ids as the keys, a label as the value
  def matricize_with_cols(cols={})
    raise ArgumentError, "Expecting block" unless block_given?
    # Initial offset
    idx = 1
    row_col_map, label_map = {}, []
    cols.each do |id, label|
      row_col_map[id] = idx
      label_map[idx] = label
      idx += 1
    end

    workbook = create_workbook
    sheet    = workbook.create_worksheet
    builder  = MatrixBuilder.new(sheet, row_col_map)
    builder.prepare_labels(label_map)
    yield builder
    workbook
  end

  class MatrixBuilder
    attr_reader :sheet, :map

    def initialize(s, m)
      @sheet, @map = s, m
    end

    def prepare_labels(label_map)
      label_map.each_with_index do |label, idx|
        @sheet[0,idx] = label
        @sheet[idx,0] = label
      end
    end

    def add_weight(left_id, right_id, weight=0.0)
      @sheet[@map[left_id],@map[right_id]] = @sheet[@map[left_id],@map[right_id]].to_f + weight
      @sheet[@map[right_id],@map[left_id]] = @sheet[@map[right_id],@map[left_id]].to_f + weight
    end
  end

private

  def create_workbook
    Spreadsheet::Workbook.new
  end
end
