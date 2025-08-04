import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn score(word: String) -> Int {
  word
  |> string.to_graphemes
  |> list.map(letter_score)
  |> list.reduce(int.add)
  |> result.unwrap(0)
}

fn letter_score(char: String) -> Int {
  case char |> string.uppercase {
    "D" | "G" -> 2
    "B" | "C" | "M" | "P" -> 3
    "F" | "H" | "V" | "W" | "Y" -> 4
    "K" -> 5
    "J" | "X" -> 8
    "Q" | "Z" -> 10
    _ -> 1
  }
}
