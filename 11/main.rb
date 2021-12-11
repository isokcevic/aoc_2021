def increase(oct_map, x, y)
  flash_count = 0
  oct_map[y][x] += 1

  if oct_map[y][x] == 10
    flash_count = 1
    (-1..1).each do |dy|
      next if y + dy < 0 || y + dy >= oct_map.length
      (-1..1).each do |dx|
        next if dx == 0 && dy == 0 || x + dx < 0 || x + dx >= oct_map[0].length
        flash_count += increase(oct_map, x+dx, y+dy)
      end
    end
  end

  flash_count
end

def reset(oct_map)
  oct_map.each.with_index do |r, i|
    r.each.with_index do |_, j|
      oct_map[i][j] = 0 if oct_map[i][j] > 9
    end
  end
end

oct = File.open("input", "r"){|f| f.readlines(chomp:true).map{|l| l.split("").map(&:to_i)}}

total_flashes = 0
step = 0

loop do
  step += 1
  step_flashes = 0

  oct.each.with_index do |r, i|
    r.each.with_index do |_, j|
      step_flashes += increase(oct, j, i)
    end
  end

  total_flashes += step_flashes
  pp total_flashes if step == 100

  break if step_flashes == oct.length * oct[0].length

  reset(oct) if step_flashes > 0
end

pp step