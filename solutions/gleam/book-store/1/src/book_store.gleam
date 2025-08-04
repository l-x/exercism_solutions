import gleam/dict
import gleam/int
import gleam/list

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> group_by_counts
  |> count_series
  |> optimize_series
  |> calculate_total
}

fn group_by_counts(books: List(Int)) -> List(List(Int)) {
  books
  |> list.group(fn(x) { x })
  |> dict.values
}

fn count_series(counts: List(List(Int))) -> List(Int) {
  dict.from_list([#(1, 0), #(2, 0), #(3, 0), #(4, 0), #(5, 0)])
  |> dict.merge(
    counts
    |> list.transpose
    |> list.group(fn(x) { list.length(x) })
    |> dict.map_values(fn(_, x) { list.length(x) }),
  )
  |> dict.values
}

fn optimize_series(series: List(Int)) -> List(Int) {
  case series {
    [a, b, c, d, e] -> {
      let align = int.min(c, e)
      [a, b, c - align, d + 2 * align, e - align]
    }
    _ -> series
  }
}

fn series_price(series_size: Int) -> Float {
  case series_size {
    2 -> 1520.0
    3 -> 2160.0
    4 -> 2560.0
    5 -> 3000.0
    _ -> 800.0
  }
}

fn calculate_total(series: List(Int)) -> Float {
  let sub_total = fn(sub_total, series_count, index) {
    let series_count = int.to_float(series_count)
    let series_price = series_price(index + 1)

    sub_total +. series_count *. series_price
  }

  series
  |> list.index_fold(from: 0.0, with: sub_total)
}
