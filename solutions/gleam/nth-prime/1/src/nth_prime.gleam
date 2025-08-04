import gleam/bool
import gleam/float
import gleam/int
import gleam/iterator

fn candidates() {
  iterator.append(iterator.single(2), iterator.iterate(3, fn(x) { x + 2 }))
}

fn is_prime(n: Int) -> Bool {
  let assert Ok(max) = int.square_root(n)

  candidates()
  |> iterator.take(float.truncate(max))
  |> iterator.drop_while(fn(x) { n % x != 0 })
  |> iterator.length
  == 0
}

pub fn prime(number: Int) -> Result(Int, Nil) {
  use <- bool.guard(when: number < 1, return: Error(Nil))
  use <- bool.guard(when: number == 1, return: Ok(2))

  candidates()
  |> iterator.filter(is_prime)
  |> iterator.take(number - 1)
  |> iterator.last
}
