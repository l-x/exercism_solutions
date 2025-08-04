import gleam/int
import gleam/result

fn modulo_test(v: Int, d: Int) -> Bool {
  result.unwrap(int.modulo(v, d), 1) == 0
}

pub fn is_leap_year(year: Int) -> Bool {
  modulo_test(year, 4) && !modulo_test(year, 100) || modulo_test(year, 400)
}
