positions = File.open("input", "r").readline(chomp: true).split(',').map(&:to_i)

min_1, min_2 = nil
(positions.min..positions.max).each do |target|
  distances = positions.map{|pos| (pos-target).abs}

  total = distances.sum
  min_1 = total if min_1.nil? || total < min_1

  total = distances.sum{|d| (1..d).sum }
  min_2 = total if min_2.nil? || total < min_2
end

pp min_1
pp min_2