import gleam/bool.{guard}
import gleam/int.{absolute_value}

pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  use <- guard(queen.row < 0, Error(RowTooSmall))
  use <- guard(queen.row > 7, Error(RowTooLarge))

  use <- guard(queen.column < 0, Error(ColumnTooSmall))
  use <- guard(queen.column > 7, Error(ColumnTooLarge))

  Ok(Nil)
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  black_queen.column == white_queen.column
  || black_queen.row == white_queen.row
  || absolute_value(black_queen.row - white_queen.row)
  == absolute_value(black_queen.column - white_queen.column)
}
