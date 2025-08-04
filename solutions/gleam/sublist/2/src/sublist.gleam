import gleam/list.{contains, length, window}

pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

fn is_sublist(compare list_a: List(a), to list_b: List(a)) -> Bool {
  list_b
  |> window(length(list_a))
  |> contains(list_a)
}

pub fn sublist(compare list_a: List(a), to list_b: List(a)) -> Comparison {
  case list_a, list_b {
    _, _ if list_a == list_b -> Equal
    [_, ..], [] -> Superlist
    [], _ -> Sublist
    _, _ ->
      case is_sublist(list_a, list_b), is_sublist(list_b, list_a) {
        True, _ -> Sublist
        _, True -> Superlist
        _, _ -> Unequal
      }
  }
}
