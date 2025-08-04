import gleam/bool
import gleam/iterator
import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  use <- bool.guard(
    string.length(strand1) != string.length(strand2),
    Error(Nil),
  )

  iterator.zip(
    strand1 |> string.to_graphemes |> iterator.from_list,
    strand2 |> string.to_graphemes |> iterator.from_list,
  )
  |> iterator.filter(fn(p) { p.0 != p.1 })
  |> iterator.length
  |> Ok
}
