positions = File.open("input", "r").readline(chomp: true).split(',').map(&:to_i)

minimum = nil
(positions.min..positions.max).each do |target|
  total = positions.reduce(0){|tot, pos| tot += (pos-target).abs}
  minimum = total if minimum.nil? || total < minimum
end
pp minimum

minimum = nil
(positions.min..positions.max).each do |target|
  total = positions.reduce(0){|tot, pos| tot += (1..(pos-target).abs).sum}
  minimum = total if minimum.nil? || total < minimum
end
pp minimum
