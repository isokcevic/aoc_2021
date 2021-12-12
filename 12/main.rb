class String
  def uppercase?
    self == upcase
  end
end

class CaveSystem < Hash
  def initialize(tunnels)
    super() { |h, k| h[k] = { :connections => [] } }

    tunnels.each do |tnl|
      cave, connection = tnl.split("-")
      self[cave][:connections] << connection
      self[connection][:connections] << cave
    end
  end

  def paths_count(cave = "start", visited_prev = [], &cave_allowed)
    return 1 if cave == 'end'

    visited = visited_prev + [cave]

    self[cave][:connections].filter { |c| yield c, visited }.sum { |c| paths_count(c, visited, &cave_allowed) }
  end
end

cs = CaveSystem.new(File.open("input", "r") { |f| f.readlines(chomp: true) })

pp cs.paths_count { |c, visited| c.uppercase? || !visited.include?(c) }

# Needs an intermediate variable, otherwise do..end block gets passed to pp rather than our function. TIL.
# Alternative format would be pp (cs.paths_count do ... end ) - but that is bloody ugly. Worse than a too long one-liner.
r2 = cs.paths_count do |c, visited|
  c == c.upcase || c != 'start' && (!visited.include?(c) || visited.tally.all? { |k, v| k.uppercase? || v == 1 })
end
pp r2
