fn do_append(first first: List(a), second second: List(a)) -> List(a) {
  case second {
    [] -> first
    [hd, ..tl] -> do_append([hd, ..first], tl)
  }
}

pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  []
  |> do_append(first)
  |> do_append(second)
  |> reverse
}

pub fn do_concat(lists: List(List(a)), acc: List(a)) -> List(a) {
  case lists {
    [] -> acc
    [hd, ..tl] -> do_concat(tl, append(acc, hd))
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  do_concat(lists, [])
}

fn do_filter(list: List(a), function: fn(a) -> Bool, acc: List(a)) -> List(a) {
  case list {
    [] -> acc |> reverse
    [hd, ..tl] ->
      case function(hd) {
        True -> do_filter(tl, function, [hd, ..acc])
        False -> do_filter(tl, function, acc)
      }
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  do_filter(list, function, [])
}

pub fn length(list: List(a)) -> Int {
  list
  |> foldl(0, fn(x, _) { x + 1 })
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  list
  |> foldr([], fn(acc, x) { [function(x), ..acc] })
}

fn do_foldl(list: List(a), function: fn(b, a) -> b, acc: b) -> b {
  case list {
    [] -> acc
    [hd, ..tl] -> do_foldl(tl, function, function(acc, hd))
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  do_foldl(list, function, initial)
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  list
  |> reverse
  |> foldl(initial, function)
}

fn do_reverse(list: List(a), acc: List(a)) -> List(a) {
  case list {
    [] -> acc
    [hd, ..tl] -> do_reverse(tl, [hd, ..acc])
  }
}

pub fn reverse(list: List(a)) -> List(a) {
  do_reverse(list, [])
}
