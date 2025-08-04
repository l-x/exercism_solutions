import gleam/bool
import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

fn insert(tree: Tree, data: Int) -> Tree {
  use <- bool.guard(
    when: tree == Nil,
    return: Node(data:, left: Nil, right: Nil),
  )

  let assert Node(self, left, right) = tree

  case self < data {
    True -> Node(self, left, right |> insert(data))
    False -> Node(self, left |> insert(data), right)
  }
}

fn sorted(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(data, left, right) ->
      list.concat([sorted(left), [data], sorted(right)])
  }
}

pub fn to_tree(data: List(Int)) -> Tree {
  data |> list.fold(Nil, insert)
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data |> to_tree |> sorted
}
