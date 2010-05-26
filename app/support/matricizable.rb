module Matricizable

  def matricize_with_cols(cols={})
    raise ArgumentError, "Expecting block" unless block_given?
    idx = 1
    row_col_map, label_map = {}, {}
    cols.each do |id, label|
      row_col_map[id] = idx
      label_map[idx] = label
      idx += 1
    end

    workbook = create_workbook
    sheet    = workbook.create_worksheet
    builder  = MatrixBuilder.new(sheet, row_col_map)
    builder.prepare_labels(label_map)
    workbook.write('/tmp/deleteme.xls')#MXDEBUG
    yield builder
    workbook
  end

  class MatrixBuilder
    attr_reader :sheet, :map

    def initialize(s, m)
      @sheet, @map = s, m
    end

    def prepare_labels(label_map)
      @sheet.row(0).push("")
      label_map.each do |idx, label|
        @sheet.row(0).push(label)
        @sheet.row(idx).push(label)  
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
