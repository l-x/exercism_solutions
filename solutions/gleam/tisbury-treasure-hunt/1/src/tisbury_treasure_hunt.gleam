import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  #(place_location.1, place_location.0)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  treasure_location == place_location_to_treasure_location(place_location)
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let location = place_location_to_treasure_location(place.1)

  list.length(
    list.filter(treasures, fn(t: #(String, #(Int, String))) -> Bool {
      t.1 == location
    }),
  )
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case place.0, found_treasure.0, desired_treasure.0 {
    "Abandoned Lighthouse", _, "Brass Spyglass" -> True
    "Stormy Breakwater", "Amethyst Octopus", d ->
      case d {
        "Crystal Crab" -> True
        "Glass Starfish" -> True
        _ -> False
      }
    "Harbor Managers Office", "Vintage Pirate Hat", d ->
      case d {
        "Model Ship in Large Bottle" -> True
        "Antique Glass Fishnet Float" -> True
        _ -> False
      }
    _, _, _ -> False
  }
}
