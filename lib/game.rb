class Game
  attr_reader :stable

  def initialize(empty_cell: nil, live_cell: nil, map: nil, cols: nil, rows: nil, **)
    @stable = false
    @empty_cell = empty_cell || EMPTY_CELL
    @live_cell = live_cell || LIVE_CELL
    if map
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
    '=' * (cols + 2) + "\n" +
    cells.map { |row| '|' + row.join + '|' }.join("\n") +
    "\n" + '=' * (cols + 2)
  end

  def do_step!
    new_generation = cells.map.with_index do |row, cur_row|
      row.map.with_index do |cell, cur_col|
        neighbour_count = neighbour_count_at(row: cur_row, col: cur_col)
        is_cell_will_be_live?(cell, neighbour_count) ? live_cell : empty_cell
      end
    end

    if new_generation == cells
      self.stable = true
    else
      self.cells = new_generation
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
  end.flatten(1).reject { |vector| vector == [0, 0] }.freeze

  attr_reader :empty_cell, :live_cell
  attr_writer :stable
  attr_accessor :rows, :cols, :cells

  def set_life_at(row:, col:)
    cells[row][col] = live_cell
  end

  def init_cells
    self.cells = (0...rows).map { Array.new(cols, empty_cell) }
  end

  def is_cell_life?(row:, col:)
    return false unless (0..rows).include?(row) && (0..cols).include?(col)
    cells[row][col] == live_cell rescue false
  end

  def neighbour_count_at(row:, col:)
    NEIGHBOUR_VECTORS.inject(0) do |sum, v|
      sum + (is_cell_life?(row: row + v[0], col: col + v[1]) ? 1 : 0)
    end
  end

  def is_cell_will_be_live?(cell, neighbour_count)
    if cell == empty_cell && neighbour_count == 3
      true
    elsif cell == live_cell && (2..3).include?(neighbour_count)
      true
    else
      false
    end
  end
end
