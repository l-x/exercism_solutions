pub fn square_root(radicand: Int) -> Int {
  do_square_root(radicand, radicand / 2 + 1)
}

fn do_square_root(radicant, guess: Int) -> Int {
  case guess * guess == radicant {
    True -> guess
    False -> do_square_root(radicant, guess - 1)
  }
}
