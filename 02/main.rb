transformations_1 = {
  "forward" => -> (coords, amount) { coords[:position] += amount },
  "down" => -> (coords, amount) { coords[:depth] += amount },
  "up" => -> (coords, amount) { coords[:depth] -= amount }
}

transformations_2 = {
  "down" => -> (coords, amount) { coords[:aim] += amount },
  "up" => -> (coords, amount) { coords[:aim] -= amount },
  "forward" => -> (coords, amount) { coords[:position] += amount; coords[:depth] += coords[:aim] * amount }
}

def run_transformation(coords, transformation_map, name, amount)
  transformation_map[name].call(coords, amount.to_i)
end


lines = File.open("input", "r"){|f| f.readlines(chomp: true)}

coordinates = {depth: 0, position: 0}
lines.each{|l| run_transformation(coordinates, transformations_1, *l.split(" "))}
puts coordinates[:depth] * coordinates[:position]

coordinates = {depth: 0, position: 0, aim: 0}
lines.each{|l| run_transformation(coordinates, transformations_2, *l.split(" "))}
puts coordinates[:depth] * coordinates[:position]
