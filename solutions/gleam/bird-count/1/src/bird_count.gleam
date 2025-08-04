import gleam/int
import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [count, ..] -> count
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [count, ..rest] -> [count + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.contains(days, 0)
}

pub fn total(days: List(Int)) -> Int {
  int.sum(days)
}

pub fn busy_days(days: List(Int)) -> Int {
  days
  |> list.count(where: fn(c: Int) -> Bool { c >= 5 })
}
