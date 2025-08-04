import gleam/bool

pub type Error {
  InvalidSquare
}

fn do_square(n: Int) -> Int {
  case n {
    1 -> 1
    _ -> 2 * do_square(n - 1)
  }
}

pub fn square(square: Int) -> Result(Int, Error) {
  use <- bool.guard(
    when: square < 1 || square > 64,
    return: Error(InvalidSquare),
  )

  Ok(do_square(square))
}

pub fn total() -> Int {
  let assert Ok(n) = square(64)

  n * 2 - 1
}
