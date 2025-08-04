import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction:, position:)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  let robot = create(direction, position)

  instructions
  |> string.to_graphemes
  |> list.fold(robot, move_one)
}

fn move_one(robot: Robot, instruction: String) -> Robot {
  case instruction {
    "L" -> Robot(..robot, direction: turn_left(robot.direction))
    "R" -> Robot(..robot, direction: turn_right(robot.direction))
    "A" -> Robot(..robot, position: advance(robot.position, robot.direction))
    _ -> panic as "unknown instruction"
  }
}

fn advance(position: Position, direction: Direction) -> Position {
  case direction {
    North -> Position(..position, y: position.y + 1)
    West -> Position(..position, x: position.x - 1)
    South -> Position(..position, y: position.y - 1)
    East -> Position(..position, x: position.x + 1)
  }
}

fn turn_left(direction: Direction) -> Direction {
  case direction {
    North -> West
    West -> South
    South -> East
    East -> North
  }
}

fn turn_right(direction: Direction) -> Direction {
  case direction {
    North -> East
    East -> South
    South -> West
    West -> North
  }
}
