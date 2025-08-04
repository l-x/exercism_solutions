import gleam/list

// TODO: please define the Pizza custom type
pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

fn do_pizza_price(pizza: Pizza, sum: Int) -> Int {
  case pizza {
    Margherita -> sum + 7
    Caprese -> sum + 9
    Formaggio -> sum + 10
    ExtraSauce(p) -> do_pizza_price(p, sum + 1)
    ExtraToppings(p) -> do_pizza_price(p, sum + 2)
  }
}

pub fn pizza_price(pizza: Pizza) -> Int {
  do_pizza_price(pizza, 0)
}

fn do_order_price(order: List(Pizza), sum: Int) -> Int {
  case order {
    [] -> sum
    [p, ..rest] -> do_order_price(rest, sum + pizza_price(p))
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  do_order_price(order, 0)
  + case list.length(order) {
    l if l == 1 -> 3
    l if l == 2 -> 2
    _ -> 0
  }
}
