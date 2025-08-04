import gleam/list
import gleam/string

pub fn recite(inputs: List(String)) -> String {
  inputs
  |> list.reverse
  |> do_recite([])
  |> string.join("\n")
}

fn do_recite(inputs: List(String), acc: List(String)) -> List(String) {
  case inputs {
    [] -> list.reverse(acc)
    [a] ->
      do_recite([], [
        "And all for the want of a " <> a <> ".",
        ..list.reverse(acc)
      ])

    [a, b, ..c] ->
      do_recite([b, ..c], [
        "For want of a " <> b <> " the " <> a <> " was lost.",
        ..acc
      ])
  }
}
