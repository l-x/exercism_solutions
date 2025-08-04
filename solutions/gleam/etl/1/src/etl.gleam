import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  dict.fold(over: legacy, from: dict.new(), with: fn(acc, key, values) {
    list.fold(over: values, from: acc, with: fn(acc, value) {
      dict.insert(into: acc, for: string.lowercase(value), insert: key)
    })
  })
}
