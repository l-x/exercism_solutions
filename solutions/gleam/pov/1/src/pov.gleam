import gleam/bool
import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  use <- bool.guard(tree.label == from, Ok(tree))
  use path <- result.try(tree |> path_from_root(from))

  let assert [_, next, ..] = path
  let assert Ok(next_tree) =
    list.find(tree.children, fn(tr) { tr.label == next })

  Tree(
    next,
    list.append(next_tree.children, [
      Tree(
        ..tree,
        children: list.filter(tree.children, fn(t) { t.label != next }),
      ),
    ]),
  )
  |> from_pov(from)
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  use tree <- result.try(tree |> from_pov(from))

  tree |> path_from_root(to)
}

fn path_from_root(tree: Tree(a), to: a) -> Result(List(a), Nil) {
  use <- bool.guard(tree.label == to, Ok([to]))
  use xs <- result.try(list.find_map(tree.children, path_from_root(_, to)))

  Ok([tree.label, ..xs])
}
