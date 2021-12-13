def read_dots(paper, dot_line)
  x, y = dot_line.split(",").map(&:to_i)
  paper[y] ||= []
  paper[y][x] = true
end

def fold(paper, fold_line)
  axis, coord = fold_line.split(" ")[2].split("=")
  coord = coord.to_i

  copy = []

  if axis == "y"
    paper.each.with_index do |row, i|
      if i < coord
        copy[i] = row || []
      else
        next if row.nil?
        row.each.with_index do |v, j|
          copy[paper.length - 1 - i][j] ||= v
        end
      end
    end
  else
    paper.each.with_index do |row, i|
      next if row.nil?
      row.each.with_index do |v, j|
        copy[i] ||= []
        if j < coord
          copy[i][j] = v
        elsif j > coord
          copy[i][2 * coord - j] = (copy[i][2 * coord - j] || v)
        end
      end
    end
  end

  copy
end

def debug(paper)
  paper.each do |row|
    if row.nil?
      puts
      next
    end
    row.each do |v|
      print v ? "#" : "."
    end
    puts
  end
end

def count_dots(paper)
  paper.sum{|row| row.nil? ? 0 : row.count{|v| v == true }}
end

paper = []

reading = :dots

File.open("input", "r"){|f| f.readlines(chomp: true)}.each do |line|
  if line.length  < 2
    reading = :folds
    next
  end

  read_dots(paper, line) if reading == :dots
  if reading == :folds
    paper = fold(paper, line)
    pp count_dots(paper)
  end
end

debug(paper)
