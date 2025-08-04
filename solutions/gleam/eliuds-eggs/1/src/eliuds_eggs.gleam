import gleam/int

pub fn egg_count(number: Int) -> Int {
  let egg = int.clamp(number % 2, 0, 1)

  case number {
    0 -> egg
    _ -> egg + egg_count({ number - egg } / 2)
  }
}
