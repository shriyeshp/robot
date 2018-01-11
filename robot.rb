class Robot

  NORTH = "north"
  SOUTH = "south"
  EAST = "east"
  WEST = "west"

  RIGHT = {:NORTH => :EAST, :EAST => :SOUTH, :SOUTH => :WEST, :WEST => :NORTH}
  LEFT = {:NORTH => :WEST, :WEST => :SOUTH, :SOUTH => :EAST, :EAST => :NORTH}


  def initialize(x, y, direction)
    @positions = [ {x: x, y: y} ]
    @direction = direction
    calculate_adjacent_positions
  end

  def calculate_adjacent_positions
    current_position = @positions.last
    left = {x: current_position[:x]-1, y: current_position[:y]}
    right = {x: current_position[:x]+1, y: current_position[:y]}
    front = {x: current_position[:x], y: current_position[:y]-1}
    back = {x: current_position[:x], y: current_position[:y]+1}
    @adjacent_positions = {left: left, front: front, right: right, back: back}
  end

  def get_position
    @positions.last
  end

  def get_adjacent_positions
    @adjacent_positions
  end

  def get_direction
    @direction
  end

  def turn_right
    @direction = RIGHT[@direction]
  end

  def turn_left
    @direction = LEFT[@direction]
  end

  def move_forward
    @positions.push(@adjacent_positions[:front])
    calculate_adjacent_positions
    get_position
  end

  def move_back
    @positions.push(@adjacent_positions[:back])
    calculate_adjacent_positions
    get_position
  end

  def move_left
    @positions.push(@adjacent_positions[:left])
    calculate_adjacent_positions
    get_position
  end
  
  def move_right
    @positions.push(@adjacent_positions[:right])
    calculate_adjacent_positions
    get_position
  end



end