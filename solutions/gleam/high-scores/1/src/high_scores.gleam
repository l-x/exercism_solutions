import gleam/int
import gleam/list.{last, reduce, reverse, sort, take}

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  high_scores |> last
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  high_scores |> reduce(int.max)
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores
  |> sort(int.compare)
  |> reverse
  |> take(3)
}
