import gleam/string
import gleam/int

fn converter(number: Int) -> fn (Int, String) -> String {
  fn (mod: Int, then: String) -> String {
    case number % mod {
      0 -> then
      _ -> ""
    }
  }
}

pub fn convert(number: Int) -> String {
  let convert = converter(number)

  let pling = convert(3, "Pling")
  let plang = convert(5, "Plang")
  let plong = convert(7, "Plong")

  case pling <> plang <> plong {
    "" -> int.to_string(number)
    sound -> sound
  }
}
