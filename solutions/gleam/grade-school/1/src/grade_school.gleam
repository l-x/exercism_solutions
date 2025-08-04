import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/order
import gleam/pair
import gleam/string

pub opaque type School {
  School(roster: Dict(String, Int))
}

pub fn create() -> School {
  School(roster: dict.new())
}

pub fn roster(school: School) -> List(String) {
  school.roster
  |> dict.to_list
  |> list.sort(fn(a, b) { string.compare(a.0, b.0) })
  |> list.sort(fn(a, b) { int.compare(a.1, b.1) })
  |> list.map(pair.first)
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  use <- bool.guard(
    when: dict.has_key(school.roster, student),
    return: Error(Nil),
  )

  school.roster
  |> dict.insert(student, grade)
  |> School
  |> Ok
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  school.roster
  |> dict.filter(fn(_, g) { g == desired_grade })
  |> dict.keys
  |> list.sort(string.compare)
}
