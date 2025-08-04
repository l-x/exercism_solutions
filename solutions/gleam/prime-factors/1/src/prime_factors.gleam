import gleam/list

pub fn factors(n: Int) -> List(Int) {
  do_factors(n, 2, [])
}

fn do_factors(n: Int, factor: Int, acc: List(Int)) -> List(Int) {
  case n % factor {
    0 -> do_factors(n / factor, factor, [factor, ..acc])
    _ if n > 1 -> do_factors(n, factor + 1, acc)
    _ -> list.reverse(acc)
  }
}
