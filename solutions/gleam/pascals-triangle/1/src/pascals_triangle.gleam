import gleam/io
import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  sum_rows(n, [])
  |> list.reverse
}

fn sum_one(prev: List(Int), index: Int) -> Int {
  list.index_fold(prev, 0, fn(acc, v, i) {
    case i == index || i == index - 1 {
      True -> acc + v
      False -> acc
    }
  })
}

fn sum_row(prev: List(Int)) -> List(Int) {
  list.range(0, list.length(prev))
  |> list.map(sum_one(prev, _))
}

fn sum_rows(n: Int, acc: List(List(Int))) -> List(List(Int)) {
  let acc_len = list.length(acc)

  case acc {
    _ if acc_len >= n -> acc
    [] -> sum_rows(n, [[1]])
    [prev, ..] -> {
      prev
      |> sum_row
      |> list.prepend(acc, _)
      |> sum_rows(n, _)
    }
  }
}

