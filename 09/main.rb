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
  fill_map = []

  # Generate all-false fillmap
  hmap.length.times do
    fill_map << [false] * hmap[0].length
  end

  fill(hmap, fill_map, x, y).size
end

data = File.open("input", "r").readlines(chomp: true).map{|l| l.split("").map(&:to_i)}

# Generate a heightmap larger than input data, and fill it with 9
heightmap = []
(data.length+2).times do
  heightmap << [9] * (data[0].length + 2)
end
# Copy the input data inside the generated heightmap, so it is padded with 9's
# TODO: better implementation of data padding?
(0...data.length).step do |i|
  (0...data[0].length).step do |j|
    heightmap[i+1][j+1] = data[i][j]
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
