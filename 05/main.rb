def draw_line_1(area, from, to)
  if from[0] == to[0]
    x = from[0]
    y1 = [from[1], to[1]].min
    y2 = [from[1], to[1]].max
    y1.upto(y2){|y| area[y] ||= []; area[y][x] ||= 0; area[y][x] += 1}
  elsif from[1] == to[1]
    y = from[1]
    x1 = [from[0], to[0]].min
    x2 = [from[0], to[0]].max
    x1.upto(x2){|x| area[y] ||= []; area[y][x] ||= 0; area[y][x] += 1}
  end
end

def draw_line_2(area, from, to)
  x1, y1 = from
  x2, y2 = to
  dx = (x2-x1)
  dy = (y2-y1)
  sgn_x = dx <=> 0
  sgn_y = dy <=> 0
  diff = [dx.abs, dy.abs].max
  0.upto(diff){|d| area[y1+d*sgn_y] ||= []; area[y1+d*sgn_y][x1+d*sgn_x] ||= 0; area[y1+d*sgn_y][x1+d*sgn_x] += 1}
end

data = File.open("input", "r"){|f| f.readlines(chomp: true)}

area_1 = []
area_2 = []

data.each do |d|
  from, to = d.split(" -> ").map{|p| p.split(',').map(&:to_i)}
  draw_line_1(area_1, from, to)
  draw_line_2(area_2, from, to)
end

pp area_1.flatten.count{|a| !a.nil? && a >= 2}
pp area_2.flatten.count{|a| !a.nil? && a >= 2}
