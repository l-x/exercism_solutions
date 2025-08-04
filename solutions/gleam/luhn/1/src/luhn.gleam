import gleam/bool.{guard}
import gleam/int
import gleam/list
import gleam/result.{try, unwrap}
import gleam/string

pub fn valid(value: String) -> Bool {
  value
  |> is_valid
  |> unwrap(False)
}

fn is_valid(value: String) -> Result(Bool, Nil) {
  use digits <- try(parse(value))
  use <- guard(when: digits == [0], return: Ok(False))

  digits
  |> list.index_fold(0, sum)
  |> int.modulo(10)
  |> result.map(fn(mod) { mod == 0 })
}

fn sum(sum, digit: Int, index: Int) -> Int {
  use <- guard(when: index % 2 == 0, return: sum + digit)

  sum
  + case digit < 5 {
    True -> digit * 2
    False -> digit * 2 - 9
  }
}

fn parse(value: String) -> Result(List(Int), Nil) {
  value
  |> string.to_graphemes
  |> list.reverse
  |> list.filter(fn(d) { d != " " })
  |> list.try_map(int.base_parse(_, 10))
}
