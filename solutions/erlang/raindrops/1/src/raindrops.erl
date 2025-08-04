-module(raindrops).

-export([convert/1]).

pling(N) -> case N rem 3 =:= 0 of
    true -> "Pling";
    _ -> ""
end.

plang(N) -> case N rem 5 =:= 0 of
    true -> "Plang";
    _ -> ""
end.

plong(N) -> case N rem 7 =:= 0 of
    true -> "Plong";
    _ -> ""
end.

convert(Number) -> case pling(Number) ++ plang(Number) ++ plong(Number) of
    "" -> integer_to_list(Number);
    X -> X
end.