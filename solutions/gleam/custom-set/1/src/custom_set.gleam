import gleam/dict
import gleam/list

pub opaque type Set(t) {
  Set(dict: dict.Dict(t, Nil))
}

pub fn new(members: List(t)) -> Set(t) {
  members |> list.fold(from: Set(dict.new()), with: add)
}

pub fn is_empty(set: Set(t)) -> Bool {
  set.dict |> dict.is_empty
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  set.dict |> dict.has_key(member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  intersection(first, second) |> is_equal(first)
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  difference(first, second) |> is_equal(first)
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  difference(first, second)
  |> is_empty
  && difference(second, first)
  |> is_empty
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  set.dict
  |> dict.insert(member, Nil)
  |> Set
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.dict
  |> dict.take(second.dict |> dict.keys)
  |> Set
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  first.dict
  |> dict.drop(second.dict |> dict.keys)
  |> Set
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.dict
  |> dict.merge(second.dict)
  |> Set
}
