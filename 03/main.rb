def ones_counts(numbers)
  numbers.reduce([0] * numbers[0].length) do |counts, num|
    num.each_char.with_index do |c, i|
      counts[i] += 1 if c == "1"
    end
    counts
  end
end


def common_digits(numbers)
  ones_counts(numbers).map do |ones_count|
    zeros_count = numbers.length - ones_count
    if ones_count > zeros_count
      "1"
    elsif ones_count < zeros_count
      "0"
    else
      nil
    end
  end
end


def filter_oxy(numbers, index)
  cd = common_digits(numbers)
  numbers.select{|num| cd[index].nil? && num[index] == "1" || num[index] == cd[index]}
end


def filter_co2(numbers, index)
  cd = common_digits(numbers)
  numbers.select{|num| (cd[index].nil? && num[index] == "0") || (!cd[index].nil? && num[index] != cd[index])}
end


lines = File.open("input", "r"){|f| f.readlines(chomp: true)}

gamma = common_digits(lines).map{ |d| d == "1" ? "1" : "0" }.join.to_i(2)
delta = common_digits(lines).map{ |d| d == "0" ? "1" : "0" }.join.to_i(2)

pp gamma * delta

oxy_numbers = lines
lines[0].length.times do |n|
  oxy_numbers = filter_oxy(oxy_numbers, n)
  break if oxy_numbers.length == 1
end

co2_numbers = lines
lines[0].length.times do |n|
  co2_numbers = filter_co2(co2_numbers, n)
  break if co2_numbers.length == 1
end

pp oxy_numbers[0].to_i(2) * co2_numbers[0].to_i(2)


