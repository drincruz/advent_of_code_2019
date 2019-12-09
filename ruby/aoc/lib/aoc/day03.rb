module Day03
  class Solution
    def read
      File.read("data/day03.txt").split("\n")
    end

    def parse_data(input)
      input.map{ |data| data.split(",") }
    end

    def next_point(current, operation)
      direction = operation[0]
      units = operation[1..-1].to_i

      case direction
      when 'D'
        [current[0], current[1] - units]
      when 'L'
        [current[0] - units, current[1]]
      when 'R'
        [current[0] + units, current[1]]
      when 'U'
        [current[0], current[1] + units]
      end
    end

    def fill_state(state, point0, point1)
      steps = state.fetch(point0, [])
      counter =
        if point0 == [0, 0]
          0
        else
          1
        end

      if point0[0] != point1[0]
        if point0[0] < point1[0]
          left = point0[0]
          right = point1[0]
        else
          left = point1[0]
          right = point0[0]
        end

        (left..right).each_with_index { |n, i|
          step_increment = counter + i
          new_point = [n, point0[1]]
          point_steps = state.fetch(new_point, [])
          state[new_point] = point_steps.push( (steps.first || 0) + step_increment)
        }
      else
        if point0[1] < point1[1]
          left = point0[1]
          right = point1[1]
        else
          left = point1[1]
          right = point0[1]
        end

        (left..right).each_with_index { |n, i|
          step_increment = counter + i
          new_point = [point0[0], n]
          point_steps = state.fetch(new_point, [])
          state[new_point] = point_steps.push( (steps.first || 0) + step_increment)
        }
      end

      state
    end

    def get_crossed_paths(wire_points)
      wire_points.select{ |point, count| count > 1 }
    end

    def manhattan_distance(point)
      point[0].abs + point[1].abs
    end

    # Honestly, this feels like there should've been a better approach.
    # But, I'm still new to Ruby, so I'm okay with this.
    def process(data)
      wire0_points = {}
      current_location = [0, 0]

      data.first.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire0_points, current_location, next_location)
        current_location = next_location
      }

      wire1_points = {}
      current_location = [0, 0]

      data.last.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire1_points, current_location, next_location)
        current_location = next_location
      }

      wire_crossed_points = wire0_points.keep_if { |k, v| wire1_points.key? k }

      wire_crossed_points.select {
        |point, count| point != [0, 0]
      }.map { |point, count| manhattan_distance(point) }.sort.first
    end

    def process_part2(data)
      wire0_points = {}

      current_location = [0, 0]
      data.first.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire0_points, current_location, next_location)
        current_location = next_location
      }

      wire1_points = {}
      current_location = [0, 0]
      data.last.each{ |op|
        next_location = next_point(current_location, op)
        fill_state(wire1_points, current_location, next_location)
        current_location = next_location
      }

      wire_crossed_points = wire0_points.keep_if { |k, v| wire1_points.key? k }

      wire_crossed_points.select {
        |point, counts| point != [0, 0]
      }.map {
        |point, counts| [manhattan_distance(point), wire0_points[point].first + wire1_points[point].first]
      }
    end

    def run
      process(parse_data(read))
    end
  end
end
