import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn split(string: String) -> List(List(Int)) {
  string
  |> string.split("\n")
  |> list.map(fn(s) {
    s
    |> string.split(" ")
    |> list.map(fn(i) {
      i
      |> int.base_parse(10)
      |> result.unwrap(0)
    })
  })
}

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  case
    string
    |> split
    |> list.drop(index - 1)
  {
    [] -> Error(Nil)
    [r, ..] -> Ok(r)
  }
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  case
    string
    |> split
    |> list.transpose
    |> list.drop(index - 1)
  {
    [] -> Error(Nil)
    [r, ..] -> Ok(r)
  }
}
