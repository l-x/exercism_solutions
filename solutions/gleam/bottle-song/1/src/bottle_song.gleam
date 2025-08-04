import gleam/list
import gleam/string

fn say(number: Int) -> String {
  case number {
    0 -> "No"
    1 -> "One"
    2 -> "Two"
    3 -> "Three"
    4 -> "Four"
    5 -> "Five"
    6 -> "Six"
    7 -> "Seven"
    8 -> "Eight"
    9 -> "Nine"
    10 -> "Ten"
    _ -> panic
  }
}

fn say_bottles(number: Int) -> String {
  say(number)
  <> " green "
  <> case number != 1 {
    True -> "bottles"
    False -> "bottle"
  }
}

fn verse(number: Int) -> String {
  let bottles = say_bottles(number)
  let one_less = say_bottles(number - 1) |> string.lowercase

  bottles
  <> " hanging on the wall,\n"
  <> bottles
  <> " hanging on the wall,\n"
  <> "And if one green bottle should accidentally fall,\n"
  <> "There'll be "
  <> one_less
  <> " hanging on the wall."
}

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  start_bottles
  |> list.range(start_bottles - take_down + 1)
  |> list.map(verse)
  |> string.join("\n\n")
}
