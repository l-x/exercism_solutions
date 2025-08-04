import gleam/float.{power, square_root}

pub fn score(x: Float, y: Float) -> Int {
  let assert Ok(a2) = power(x, 2.0)
  let assert Ok(b2) = power(y, 2.0)
  let assert Ok(c) = square_root(a2 +. b2)

  case c {
    _ if c >. 10.0 -> 0
    _ if c >. 5.0 -> 1
    _ if c >. 1.0 -> 5
    _ -> 10
  }
}
