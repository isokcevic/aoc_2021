class Paper
  def initialize
    @data = []
    @w = 0
    @h = 0
  end

  def <<(coords)
    x, y = coords.split(",").map(&:to_i)
    @w = x + 1 if x + 1 > @w
    @h = y + 1 if y + 1 > @h

    @data[y] ||= []
    @data[y][x] = true
  end

  def fold(spec)
    axis, value = spec.split(" ")[2].split("=")
    value = value.to_i

    if axis == "x"
      fold_x(value)
    else
      fold_y(value)
    end
  end

  def fold_x(value)
    (0...@h).each do |i|
      next if @data[i].nil?
      (0..value).each do |j|
        @data[i][j] ||= @data[i][@w - 1 - j]
      end
    end
    @w = value
  end

  def fold_y(value)
    (0..value).each do |i|
      next if @data[@h - 1 - i].nil?
      @data[i] ||= []
      (0...@w).each do |j|
        @data[i][j] ||= @data[@h - 1 - i][j]
      end
    end
    @h = value
  end

  def to_s
    (0...@h).map do |i|
      if @data[i].nil?
        "." * @w
      else
        (0...@w).map{ |j| @data[i][j] ? "#" : "." }.join("")
      end + "\n"
    end.join("")
  end

  def dots_count
    (0...@h).sum{|i| @data[i].nil? ? 0 : (0...@w).count{|j| @data[i][j] } }
  end
end

reading_dots = true
dots_count = nil

paper = Paper.new
File.open("input", "r") { |f| f.readlines(chomp: true)}.each do |line|
  if line.length == 0
    reading_dots = false
    next
  end

  if reading_dots
    paper << line
  else
    paper.fold(line)
    dots_count = paper.dots_count if dots_count.nil?
  end
end

puts dots_count
puts paper