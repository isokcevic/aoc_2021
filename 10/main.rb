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

lines = File.open("input", "r") { |f| f.readlines(chomp: true) }

solver = RecursiveSolver.new

solver.solve(lines)
