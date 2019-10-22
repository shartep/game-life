class Game
  def initialize(empty_cell: nil, live_cell: nil, map: nil, cols: nil, rows: nil, **)
    @empty_cell = empty_cell || EMPTY_CELL
    @live_cell = live_cell || LIVE_CELL
    if map.present?
      set_generation(map)
    else
      self.cols = cols || COLS
      self.rows = rows || ROWS
      init_cells
    end
  end

  def set_generation(map)
    rows = map.split(NL)
    self.rows = rows.size
    self.cols = rows[0].chomp.chars.to_a.size
    init_cells

    rows.each_with_index do |row, cur_row|
      row.chars.each_with_index do |cell, cur_col|
        set_life_at(row: cur_row, col: cur_col) if cell == live_cell
      end
    end
  end

  def screen
    cells.map(&:join).join("\n")
  end

  def do_step
    self.cells = cells.map.with_index do |row, cur_row|
      row.map.with_index do |cell, cur_col|
        neighbour_count = neighbour_count_at(row: cur_row, col: cur_col)
        is_cell_will_be_live?(cell, neighbour_count) ? live_cell : empty_cell
      end
    end
  end

  private

  NL = "\n".freeze

  ROWS = 30.freeze
  COLS = 30.freeze

  EMPTY_CELL = '0'.freeze
  LIVE_CELL = '1'.freeze

  # array include arrays like: [-1, 1], [-1, 0], [-1, 1], ... whole amount of combinations, except [0, 0]
  NEIGHBOUR_VECTORS = [-1, 0, 1].map do |delta_row|
    [-1, 0, 1].map { |delta_col| [delta_row, delta_col] }
  end.reject { |vector| vector == [0, 0] }.freeze

  attr_reader :empty_cell, :live_cell
  attr_accessor :rows, :cols, :cells

  def set_life_at(row:, col:)
    cells[row][col] = live_cell
  end

  def init_cells
    self.cells = Array.new(rows, Array.new(cols, EMPTY_CELL))
  end

  def is_cell_life?(row:, col:)
    return false unless (0..rows).include?(row) && (0..cols).include?(col)
    cells[row][col] == live_cell rescue false
  end

  def neighbour_count_at(row:, col:)
    NEIGHBOUR_VECTORS.reduce(0, :+) do |v|
      is_cell_life?(row: row + v.first, col: col + v.second) ? 1 : 0
    end
  end

  def is_cell_will_be_live?(cell, neighbour_count)
    if cell == empty_cell && neighbour_count == 3
      true
    elsif cell == live_cell && (2...3).include?(neighbour_count)
      true
    else
      false
    end
  end
end
