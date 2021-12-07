lines = File.open("input"){|f| f.readlines(chomp: true)}.map(&:to_i)

def num_increases(numbers)
  numbers.each_cons(2).reduce(0) {|increases, nums| nums[1] > nums[0] ? increases + 1 : increases}
end
pp num_increases(lines)

sums = lines.each_cons(3).map(&:sum)
pp num_increases(sums)
