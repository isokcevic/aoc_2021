def increase(oct_map, x, y)
  oct_map[y][x] += 1
  if oct_map[y][x] == 10
    flash_coords = [[x, y]]
    (-1..1).each do |dy|
      next if y + dy < 0 || y + dy >= oct_map.length
      (-1..1).each do |dx|
        next if dx == 0 && dy == 0 || x + dx < 0 || x + dx >= oct_map[0].length
        flash_coords += increase(oct_map, x+dx, y+dy)
      end
    end

    flash_coords
  else
    []
  end
end

def reset(oct_map, flash_coords)
  flash_coords.each do |(x, y)|
    oct_map[y][x] = 0
  end
end

oct = File.open("input", "r"){|f| f.readlines(chomp:true).map{|l| l.split("").map(&:to_i)}}

total_flashes = 0
step = 0

loop do
  step += 1
  flash_coords = []

  oct.each.with_index do |r, i|
    r.each.with_index do |_, j|
      flash_coords += increase(oct, j, i)
    end
  end

  total_flashes += flash_coords.count
  pp total_flashes if step == 100

  break if flash_coords.count == oct.length * oct[0].length

  reset(oct, flash_coords)
end

pp step