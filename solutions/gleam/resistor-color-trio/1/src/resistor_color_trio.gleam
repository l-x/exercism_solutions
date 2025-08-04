import gleam/float
import gleam/int
import gleam/list
import gleam/result.{try}

pub type Resistance {
  Resistance(unit: String, value: Int)
}

fn get_unit(exp: Int) -> Result(String, Nil) {
  case exp {
    0 -> Ok("ohms")
    1 -> Ok("kiloohms")
    2 -> Ok("megaohms")
    3 -> Ok("gigaohms")
    _ -> Error(Nil)
  }
}

fn translate(colors: List(String)) -> Result(List(Int), Nil) {
  colors
  |> list.take(3)
  |> list.map(fn(color) {
    case color {
      "black" -> Ok(0)
      "brown" -> Ok(1)
      "red" -> Ok(2)
      "orange" -> Ok(3)
      "yellow" -> Ok(4)
      "green" -> Ok(5)
      "blue" -> Ok(6)
      "violet" -> Ok(7)
      "grey" -> Ok(8)
      "white" -> Ok(9)
      _ -> Error(Nil)
    }
  })
  |> result.all
}

fn get_exponent(value: Int, acc: Int) -> #(Int, Int) {
  let assert Ok(mod) = int.modulo(value, 1000)

  case value, mod {
    v, 0 if v > 0 -> {
      let assert Ok(v) = int.divide(v, 1000)
      get_exponent(v, acc + 1)
    }
    v, _ -> #(v, acc)
  }
}

fn undigits(values: List(Int)) -> Int {
  let assert [c1, c2, z] = values
  let assert Ok(mul) = int.power(10, int.to_float(z))
  let assert Ok(value) = int.undigits([c1, c2], 10)

  value * float.truncate(mul)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  use values <- try(translate(colors))

  let #(value, exp) =
    values
    |> undigits
    |> get_exponent(0)

  use unit <- try(get_unit(exp))

  Ok(Resistance(unit, value))
}
