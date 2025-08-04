import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn is_valid(isbn: String) -> Bool {
  case prepare(isbn) {
    Ok(digits) -> isbn_error_syndrome(digits, 0, 0) == 0
    _ -> False
  }
}

fn prepare(isbn: String) -> Result(List(Int), Nil) {
  let digits =
    isbn
    |> string.split("")
    |> list.filter(fn(x) { x != "-" })

  case list.length(digits) == 10 {
    True ->
      list.index_map(digits, fn(x, index) {
        case x, index {
          "X", 9 -> Ok(10)
          _, _ -> int.base_parse(x, 10)
        }
      })
      |> result.all
    False -> Error(Nil)
  }
}

fn isbn_error_syndrome(digits: List(Int), acc1: Int, acc2: Int) -> Int {
  case digits {
    [] ->
      acc2
      |> int.modulo(11)
      |> result.unwrap(0)
    [x, ..xs] -> {
      let acc1 = acc1 + x
      isbn_error_syndrome(xs, acc1, acc2 + acc1)
    }
  }
}
