lines = File.open("input", "r").readlines(chomp:true)

EASY_SEGMENT_COUNTS = [2, 3, 4, 7]

def decode_digits(input)
  digit_length_map = {}
  input.each do |i|
    digit_length_map[i.length] ||= []
    digit_length_map[i.length] << i.split("")
  end

  digits = {}
  # easy ones
  digits[1] = digit_length_map[2].first
  digits[4] = digit_length_map[4].first
  digits[7] = digit_length_map[3].first
  digits[8] = digit_length_map[7].first

  # five-segment digits are 2, 3, and 5; only 3 intersects with 1 in exactly two segments
  found, remaining = digit_length_map[5].partition{|d| d.intersection(digits[1]).length == 2}
  digits[3] = found[0]
  # of remaining five-segment digits, 2 intersects with 4 in two segments, and 5 intersects with 4 in three segments
  remaining.each do |d|
    if d.intersection(digits[4]).length == 2
      digits[2] = d
    else
      digits[5] = d
    end
  end

  # from six-segment digits (0, 6, 9), only 9 contains the whole of 3
  found, remaining = digit_length_map[6].partition{|d| d.intersection(digits[3]).length == digits[3].length}
  digits[9] = found[0]
  # out of remaining digits, 0 intersects with 1 in two segments, and 6 in one segment
  remaining.each do |d|
    if d.intersection(digits[1]).length == 2
      digits[0] = d
    else
      digits[6] = d
    end
  end

  digits.transform_values{|v| v.sort.join("")}.invert
end

def read_digits(text, mapping)
  text.map{|d| mapping[d.split("").sort.join("")]}.reduce(0){|t, d| t * 10 + d}
end


easy_digits = 0
sum = 0
lines.each do |l|
  pattern, output = l.split(" | ").map{|str| str.split(" ")}

  easy_digits += output.count{|digit| EASY_SEGMENT_COUNTS.include?(digit.length)}

  digits = decode_digits(pattern)
  number = read_digits(output, digits)
  sum += number
end

pp easy_digits
pp sum



