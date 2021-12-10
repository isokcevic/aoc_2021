class RecursiveSolver
  CHUNKS = {
    ")" => { pair: "(", :score => 3 },
    "]" => { pair: "[", :score => 57 },
    "}" => { pair: "{", :score => 1197 },
    ">" => { pair: "<", :score => 25137 }
  }

  AUTOCOMPLETE = {
    "(" => { pair: ")", :score => 1 },
    "[" => { pair: "]", :score => 2 },
    "{" => { pair: "}", :score => 3 },
    "<" => { pair: ">", :score => 4 },
  }

  def solve(lines)
    illegal_sum = 0
    autocomplete_scores = []
    lines.each do |l|
      illegal = illegal_score(l)
      if illegal > 0
        illegal_sum += illegal
      else
        autocomplete_scores << autocomplete_score(l)
      end
    end

    pp illegal_sum
    pp autocomplete_scores.sort[autocomplete_scores.length / 2]
  end

  private

  def illegal_score(line)
    line.length.times do |i|
      next unless CHUNKS.keys.include?(line[i])

      if line[i - 1] != CHUNKS[line[i]][:pair]
        return CHUNKS[line[i]][:score]
      else
        return illegal_score(line[0, i - 1] + line[i + 1, line.length])
      end
    end

    0
  end

  def autocomplete_score(line, score = 0)
    (line.length - 1).downto(0) do |i|
      next unless AUTOCOMPLETE.keys.include?(line[i])

      if i == line.length - 1
        score = score * 5 + AUTOCOMPLETE[line[i]][:score]
        return autocomplete_score(line[0, i], score)
      else
        return autocomplete_score(line[0, i] + line[i + 2, line.length], score)
      end
    end

    score
  end
end

class StackSolver
  PAIRS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
  }

  SCORES = {
    ")" => {:error => 3, :autocomplete => 1},
    "]" => {:error => 57, :autocomplete => 2},
    "}" => {:error => 1197, :autocomplete => 3},
    ">" => {:error => 25137, :autocomplete => 4}
  }

  def solve(lines)
    scores = lines.map { |l| score(l) }.reduce({ :error => [], :autocomplete => [] }) do |acc, res|
      acc[:error] << res[:error] unless res[:error].nil?
      acc[:autocomplete] << res[:autocomplete] unless res[:autocomplete].nil?
      acc
    end

    pp scores[:error].sum
    pp scores[:autocomplete].sort[scores[:autocomplete].length / 2]
  end

  private

  def score(line)
    match_stack = []
    line.each_char do |c|
      if !PAIRS[c].nil?
        match_stack.push PAIRS[c]
      elsif c != match_stack.pop
        return { :error => SCORES[c][:error] }
      end
    end

    { :autocomplete => match_stack.reverse.reduce(0){ |total, s| total * 5 + SCORES[s][:autocomplete]} }
  end
end

case ARGV[0]
when /stack|s/
  solver = StackSolver.new
when /recursive|r/
  solver = RecursiveSolver.new
else
  puts "Please specify a solver as a parameter, either 'stack' (or 's'), or 'recursive' (or 'r')"
  puts "e.g. ruby main.rb stack"
  exit 13
end

lines = File.open("input", "r") { |f| f.readlines(chomp: true) }

solver.solve(lines)
