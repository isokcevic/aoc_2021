# Just check if target is lower than value left, right, above and below it
def low_point?(hmap, x, y)
   hmap[y][x] < hmap[y-1][x] && hmap[y][x] < hmap[y+1][x] && hmap[y][x] < hmap[y][x-1] && hmap[y][x] < hmap[y][x+1]
end

# Fills the point, attempts to recursively fill its neighbours, and returns all filled coordinates
def fill(hmap, fmap, x, y)
  coords = []
  # Only fill if possible, and not already filled
  if hmap[y][x] != 9 && !fmap[y][x]
    # Fill at given coordinates
    fmap[y][x] = true
    coords << [x, y]

    # Recursively fill neighbours
    coords += fill(hmap, fmap, x-1, y)
    coords += fill(hmap, fmap, x+1, y)
    coords += fill(hmap, fmap, x, y-1)
    coords += fill(hmap, fmap, x, y+1)
  end

  coords
end

def basin_size(hmap, x, y)
  # Return false for any coordinates not explicitly set to something else (true)
  fill_map = Hash.new{|hash, key| hash[key] = Hash.new{|h, k| h[k] = false }}

  fill(hmap, fill_map, x, y).size
end

# Return 9 as default value for any not set heightmap coordinates.
# Allows comparing edge and corner elements with values "outside" the known heightmap, without need to take extra care
heightmap = Hash.new{|hash, key| hash[key] = Hash.new{|h, k| h[k] = 9}}
File.open("input", "r").readlines(chomp: true).each.with_index do |line, i|
  line.split("").each.with_index do |c, j|
    heightmap[i][j] = c.to_i
  end
end

h = heightmap.length
w = heightmap[0].length

sum = 0
basin_sizes = []

h.times do |i|
  w.times do |j|
    if low_point?(heightmap, j, i)
      sum += heightmap[i][j] + 1
      basin_sizes << basin_size(heightmap, j, i)
    end
  end
end

pp sum
pp basin_sizes.sort.last(3).reduce(1, :*)
