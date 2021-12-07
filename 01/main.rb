def num_increases(numbers)
  numbers.each_cons(2).select{|nums| nums[1] > nums[0]}.count
end

lines = File.open("input"){|f| f.readlines(chomp: true)}.map(&:to_i)

pp num_increases(lines)

sums = lines.each_cons(3).map(&:sum)
pp num_increases(sums)
