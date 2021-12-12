def count_paths(caves, cave, visited_prev = [], &fitness)
  return 1 if cave == 'end'

  visited = visited_prev + [cave]

  caves[cave][:connections].filter{|c| yield c, visited}.sum{|c| count_paths(caves, c, visited, &fitness)}
end

sections = Hash.new { |h, k| h[k] = { :connections => [] } }

File.open("input", "r") do |f|
  f.readlines(chomp: true).each do |l|
    section, connection = l.split("-")
    sections[section][:connections] << connection
    sections[connection][:connections] << section
  end
end

pp count_paths(sections, "start"){|c, visited| c == c.upcase || !visited.include?(c)}

# Needs an intermediate variable, otherwise do..end block gets passed to pp rather than our function. TIL.
# Alternative format would be pp (count_paths(sections, "start") do ... end ) - but that is bloody ugly.
r2 = count_paths(sections, "start") do |c, visited|
  c == c.upcase || c != 'start' && (!visited.include?(c) || visited.tally.all? { |k, v| k == k.upcase || v == 1 })
end
pp r2
