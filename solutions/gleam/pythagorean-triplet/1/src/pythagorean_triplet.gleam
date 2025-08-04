import gleam/list.{flatten, map, range}

pub type Triplet {
  Triplet(Int, Int, Int)
}

fn triplet_factory(u: Int) -> fn(Int, Int) -> Triplet {
  fn(a: Int, b: Int) -> Triplet {
    let c = u - a - b
    Triplet(a, b, c)
  }
}

fn valid_triplet(triplet: Triplet) -> Bool {
  let Triplet(a, b, c) = triplet

  a != b && b != c && c != a && a * a + b * b == c * c
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  let create_triplet = triplet_factory(sum)

  range(1, sum / 2)
  |> map(fn(a: Int) -> List(Triplet) {
    range(a + 1, sum / 2)
    |> map(fn(b: Int) -> Triplet { create_triplet(a, b) })
  })
  |> flatten
  |> list.filter(valid_triplet)
}
