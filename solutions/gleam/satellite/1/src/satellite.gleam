//// A completely overengineered solution

import gleam/list

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

type TreeResult(a) =
  Result(Tree(a), Error)

type Continuation(a) =
  fn() -> TreeResult(a)

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> TreeResult(a) {
  use <- assert_matching_lengths(inorder, preorder)
  use <- assert_matching_items(inorder, preorder)
  use <- assert_unique_items(inorder)

  Ok(restore_tree(inorder, preorder))
}

fn assert_matching_lengths(
  inorder: List(a),
  preorder: List(a),
  continue: Continuation(a),
) -> TreeResult(a) {
  case list.length(inorder) == list.length(preorder) {
    True -> continue()
    False -> Error(DifferentLengths)
  }
}

fn assert_matching_items(
  inorder: List(a),
  preorder: List(a),
  continue: Continuation(a),
) -> TreeResult(a) {
  case list.all(inorder, fn(x) { list.any(preorder, fn(y) { x == y }) }) {
    True -> continue()
    False -> Error(DifferentItems)
  }
}

fn assert_unique_items(
  list: List(a),
  continue: Continuation(a),
) -> TreeResult(a) {
  case list.length(of: list) == list.length(of: list.unique(list)) {
    True -> continue()
    False -> Error(NonUniqueItems)
  }
}

fn split(inorder: List(a), at value: a) -> #(List(a), List(a)) {
  let #(left, right) =
    list.split_while(inorder, satisfying: fn(x) { x != value })

  #(left, list.drop(right, 1))
}

fn with(preorder: List(a), for inorder: List(a)) -> List(a) {
  list.filter(preorder, keeping: fn(x) { list.contains(inorder, x) })
}

fn restore_tree(inorder: List(a), preorder: List(a)) -> Tree(a) {
  case preorder {
    [] -> Nil
    [value, ..preorder] -> {
      let #(left, right) = split(inorder, at: value)

      let left = restore_tree(left, with(preorder, for: left))
      let right = restore_tree(right, with(preorder, for: right))

      Node(value:, left:, right:)
    }
  }
}
