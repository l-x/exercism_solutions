import gleam/list.{reverse}

fn filter(list: List(t), predicate: fn(t) -> Bool, acc: List(t)) -> List(t) {
  case list {
    [] -> acc |> reverse
    [hd, ..tl] ->
      case predicate(hd) {
        True -> tl |> filter(predicate, [hd, ..acc])
        False -> tl |> filter(predicate, acc)
      }
  }
}

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list |> filter(predicate, [])
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  list |> keep(fn(x) { !predicate(x) })
}
