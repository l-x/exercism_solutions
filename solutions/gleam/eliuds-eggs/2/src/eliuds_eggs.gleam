import gleam/int

pub fn egg_count(number: Int) -> Int {
  do_egg_count(number, 0)
}

fn do_egg_count(number: Int, eggs: Int) -> Int {
  case number {
    0 -> eggs
    _ -> {
      // get the first bit of `number` as `Int`
      let egg = int.clamp(number % 2, 0, 1)

      // shift number 1 bit to the right
      let number = { number - egg } / 2

      do_egg_count(number, eggs + egg)
    }
  }
}
