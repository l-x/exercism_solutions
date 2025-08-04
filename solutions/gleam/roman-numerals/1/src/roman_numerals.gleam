import gleam/int.{divide, modulo}
import gleam/result.{unwrap}
import gleam/string.{append, repeat}

fn divmod(number: Int, divisor: Int) -> #(Int, Int) {
  let count = unwrap(divide(number, divisor), 4)
  let rest = unwrap(modulo(number, divisor), 0)

  #(count, rest)
}

pub fn convert(number: Int) -> String {
  let m = divmod(number, 1000)
  let cm = divmod(m.1, 900)
  let d = divmod(cm.1, 500)
  let cd = divmod(d.1, 400)
  let c = divmod(cd.1, 100)
  let xc = divmod(c.1, 90)
  let l = divmod(xc.1, 50)
  let xl = divmod(l.1, 40)
  let x = divmod(xl.1, 10)
  let ix = divmod(x.1, 9)
  let v = divmod(ix.1, 5)
  let iv = divmod(v.1, 4)

  ""
  |> append(repeat("M", m.0))
  |> append(repeat("CM", cm.0))
  |> append(repeat("D", d.0))
  |> append(repeat("CD", cd.0))
  |> append(repeat("C", c.0))
  |> append(repeat("XC", xc.0))
  |> append(repeat("L", l.0))
  |> append(repeat("XL", xl.0))
  |> append(repeat("X", x.0))
  |> append(repeat("IX", ix.0))
  |> append(repeat("V", v.0))
  |> append(repeat("IV", iv.0))
  |> append(repeat("I", iv.1))
}
