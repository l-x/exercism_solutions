proc isLeapYear*(year: int): bool =
  return if year %% 400 == 0:
    true
  elif year %% 100 == 0:
    false
  else:
    year %% 4 == 0
