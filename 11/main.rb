def flash(oct_map, flash_map, x, y)
  return 0 if oct_map[y][x] < 10 || flash_map[y][x]
  flash_map[y][x] = true
  flash_count = 1
  (-1..1).each do |dy|
    next if y + dy < 0 || y + dy >= oct_map.length
    (-1..1).each do |dx|
      next if dx == 0 && dy == 0 || x + dx < 0 || x + dx >= oct_map[0].length
      oct_map[y + dy][x + dx] += 1
      flash_count += flash(oct_map, flash_map, x+dx, y+dy)
    end
  end

  flash_count
end

def reset(oct_map, flash_map)
  oct_map.each.with_index do |r, i|
    r.each.with_index do |_, j|
      oct_map[i][j] = 0 if oct_map[i][j] > 9
      flash_map[i][j] = false
    end
  end
end

oct = File.open("input", "r"){|f| f.readlines(chomp:true).map{|l| l.split("").map(&:to_i)}}

flash_map = oct.map{|r| [false] * r.length}

flash_count = 0
step = 0

loop do
  step += 1

  oct.each.with_index do |r, i|
    r.each.with_index do |_, j|
      oct[i][j] += 1
      flash_count += flash(oct, flash_map, j, i)
    end
  end

  pp flash_count if step == 100

  break if flash_map.all?{|r| r.all?}

  reset(oct, flash_map)
end

pp step