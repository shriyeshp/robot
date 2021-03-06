class Plateau
  attr_accessor :dimension_x, :dimension_y
  def initialize(dimension_x, dimension_y)
    @dimension_x = dimension_x
    @dimension_y = dimension_y
  end 
end



class Robot
  attr_accessor :direction, :positions, :adjacent_positions

  NORTH = "north"
  SOUTH = "south"
  EAST = "east"
  WEST = "west"

  RIGHT = {:NORTH => :EAST, :EAST => :SOUTH, :SOUTH => :WEST, :WEST => :NORTH}
  LEFT = {:NORTH => :WEST, :WEST => :SOUTH, :SOUTH => :EAST, :EAST => :NORTH}

  def initialize(x = 0, y = 0, direction = :NORTH)
    @positions = [ Coordinate.new(x, y) ]
    @direction = direction
    @plateau = nil
    calculate_adjacent_positions
  end

  def get_position
    { x: @positions.last.x, y: @positions.last.y }
  end

  def get_adjacent_positions
    @adjacent_positions
  end

  def get_direction
    @direction
  end

  def turn_right
    turn(RIGHT[@direction], "turn_right")
  end


  def turn_left
    turn(LEFT[@direction], "turn_left")
  end

  def turn(direction, instruction)
    @direction = direction
    calculate_adjacent_positions
    new_position = Coordinate.new(@positions.last.x, @positions.last.y, instruction)
    @positions.push(new_position)
    @direction
  end

  def move_forward
    move(:front, "move_forward")
  end

  def move_backward
    move(:back, "move_backward")
  end

  def move_left
   move(:left, "move_left")
  end

  def move_right
    move(:right, "move_right")
  end

  def move(adjacency, instruction)
    if has_plateau?
      new_position = Coordinate.new(@adjacent_positions[adjacency][:x], @adjacent_positions[adjacency][:y], instruction)
      @positions.push(new_position)
      calculate_adjacent_positions
      get_position
    else
      "There is no plateau, couldnt move!"
    end
  end

  def get_position_history
    positions = []
    @positions.each do |coordinate|
      positions.push({x: coordinate.x, y: coordinate.y, instruction: coordinate.instruction})
    end
    positions
  end

  def turn_back
    turn_left
    turn_left
    @direction
  end

  def has_plateau?
    @plateau.nil? ? false : true
  end

  def place_robot(plateau)
    @plateau = plateau
  end

  def exceed_plateau(x, y)
    if has_plateau?
      if x > @plateau.dimension_x || y > @plateau.dimension_y
        true
      elsif x < 0 || y < 0
        true
      else
        false
      end
    else
      true
    end
  end

  def execute(commands)
    count = 0
    commands.scan(/../).each do |command|
      case command
      when "TL"
        turn_left
      when "TR"
        turn_right
      when "MF"
        move_forward
      when "MB"
        move_backward
      when "ML"
        move_left
      when "MR"
        move_right
      when "TB"
        turn_back
      else
        break
      end
      count += 1
    end
    commands.slice(0, count*2)
  end
  
end