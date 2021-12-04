class Board
  SIZE = 5

  def initialize(rows)
    @nums = rows.map(&:split).flatten.map(&:to_i)
    @num_positions = []
    @marked_positions = []
    @last_marked = -1
    @nums.each.with_index do |num, idx|
      @num_positions[num] = idx
      @marked_positions[idx] = false
    end
  end

  def mark(num)
    unless @num_positions[num].nil?
      @marked_positions[@num_positions[num]] = true
      @last_marked = num
    end
  end

  def wins?
    (0...SIZE).step.any? { |n| row_complete?(n) || col_complete?(n) }
  end

  def row_complete?(idx)
    @marked_positions.slice(idx*SIZE, SIZE).all?
  end

  def col_complete?(idx)
    @marked_positions.each_slice(SIZE).all?{|row| row[idx]}
  end

  def score
    @marked_positions.each.with_index.reduce(0){|sum, (marked, idx)| !marked ? sum + @nums[idx] : sum} * @last_marked
  end

  def to_s
    @nums.each.with_index.reduce("") do |output, (num, idx)|
      newline = idx % SIZE == SIZE - 1 ? "\n" : ""
      prefix = @marked_positions[idx] ? "*" : ""
      output + "#{prefix}#{num}".rjust(4) + newline
    end
  end
end

boards = []
draws = []
File.open("input", "r") do |f|
  draws = f.readline(chomp: true).split(",").map(&:to_i)
  f.readline
  boards = f.readlines(chomp: true).each_slice(Board::SIZE + 1).map{|rows| Board.new(rows[0,Board::SIZE])}
end


winners = []
draws.each do |n|
  won, lost = boards.partition do |board|
    board.mark(n)
    board.wins?
  end

  winners += won
  boards = lost
end

pp winners.first.score
pp winners.last.score