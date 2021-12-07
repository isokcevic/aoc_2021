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

fish = File.open("input", "r").readline(chomp: true).split(',').map(&:to_i)

pp total_count(fish, 80)
pp total_count(fish, 256)