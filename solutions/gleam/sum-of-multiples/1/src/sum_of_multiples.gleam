import gleam/int
import gleam/list
import gleam/result

fn multiples_upto(limit: Int) -> fn(Int) -> List(Int) {
  fn(factor: Int) -> List(Int) {
    let max = result.unwrap(int.divide(limit, factor), 0)

    list.range(1, max)
    |> list.map(fn(v: Int) -> Int { v * factor })
    |> list.filter(fn(v: Int) -> Bool { v < limit })
  }
}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  let multiples = multiples_upto(limit)

  factors
  |> list.unique
  |> list.map(multiples)
  |> list.flatten
  |> list.unique
  |> int.sum
}
