import gleam/list
import gleam/result
import gleam/string

pub fn first_letter(name: String) -> String {
  name
  |> string.trim
  |> string.first
  |> result.unwrap("")
}

pub fn initial(name: String) -> String {
  first_letter(name)
  |> string.uppercase
  |> string.append(".")
}

pub fn initials(full_name: String) -> String {
  full_name
  |> string.split(" ")
  |> list.map(initial)
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) -> String {
  let heart =
    "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     %1  +  %2     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"

  heart
  |> string.replace("%1", initials(full_name1))
  |> string.replace("%2", initials(full_name2))
}
