import gleam/bool.{guard}
import gleam/int.{undigits}
import gleam/list.{map, take}
import gleam/result.{map_error}

pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

fn color_map(color: Color) -> Int {
  case color {
    Black -> 0
    Brown -> 1
    Red -> 2
    Orange -> 3
    Yellow -> 4
    Green -> 5
    Blue -> 6
    Violet -> 7
    Grey -> 8
    White -> 9
  }
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  use <- guard(when: list.length(colors) < 2, return: Error(Nil))

  colors
  |> take(up_to: 2)
  |> map(with: color_map)
  |> undigits(10)
  |> map_error(with: fn(_) { Nil })
}
