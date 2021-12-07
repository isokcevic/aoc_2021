FISH_MEMO = []

def fish_count(fish, day, fish_type)
  FISH_MEMO[fish_type] ||= []
  if day == 0
    FISH_MEMO[fish_type][day] ||= fish.count{|f| f == fish_type}
  else
    case fish_type
    when 6
      FISH_MEMO[fish_type][day] ||= fish_count(fish, day-1, 0) + fish_count(fish, day-1, 7)
    when 8
      FISH_MEMO[fish_type][day] ||= fish_count(fish, day-1, 0)
    else
      FISH_MEMO[fish_type][day] ||= fish_count(fish, day-1, fish_type + 1)
    end
  end
end

def total_count(fish, day)
  if day == 0
    fish.count
  else
    fish_count(fish, day-1, 0) + total_count(fish, day-1)
  end
end

class FishPool
  def initialize(fish)
    @fish_types = fish.tally
  end

  def tick
    @fish_types = @fish_types.each.with_object(Hash.new(0)) do |(fish_type, amount), fish|
      case fish_type
      when 0
        fish[8] += amount
        fish[6] += amount
      else
        fish[fish_type-1] += amount
      end
      fish
    end
  end

  def size
    @fish_types.values.sum
  end
end

fish = File.open("input", "r").readline(chomp: true).split(',').map(&:to_i)

puts "Simple solution lol"
pool = FishPool.new(fish)
80.times{pool.tick}
puts pool.size
(256-80).times{pool.tick}
puts pool.size

puts "Needles recursion"
pp total_count(fish, 80)
pp total_count(fish, 256)
