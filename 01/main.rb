lines = File.open("input"){|f| f.readlines(chomp: true)}.map(&:to_i)

def num_increases(numbers)
  (0...numbers.length-1).step.reduce(0) {|increases, n| numbers[n+1] > numbers[n] ? increases + 1 : increases}
end
pp num_increases(lines)

sums = (0...lines.length-2).step.map {|n| lines[n] + lines[n+1] + lines[n+2]}
pp num_increases(sums)
