import gleam/list
import gleam/string

pub fn build(letter: String) -> String {
  let letters = letters(letter)
  let create_line = line_creator(list.length(letters) - 1)

  let upper_half = list.index_map(letters, create_line)
  let lower_half =
    upper_half
    |> list.reverse
    |> list.drop(1)

  upper_half |> list.append(lower_half) |> string.join("\n")
}

fn letters(letter: String) -> List(String) {
  "ZYXWVUTSRQPONMLKJIHGFEDCBA"
  |> string.crop(before: letter)
  |> string.split(on: "")
  |> list.reverse
}

fn line_creator(margin: Int) -> fn(String, Int) -> String {
  fn(letter: String, index: Int) -> String {
    let pad = string.repeat(" ", margin - index)

    pad
    <> case index {
      0 -> letter
      _ -> letter <> string.repeat(" ", index * 2 - 1) <> letter
    }
    <> pad
  }
}
