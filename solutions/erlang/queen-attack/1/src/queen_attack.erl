-module(queen_attack).

-export([can_attack/2]).

-spec can_attack({number(), number()}, {number(), number()}) -> boolean().
can_attack({X1, Y1}, {X2, Y2}) ->
    X1 =:= X2 orelse Y1 =:= Y2 orelse abs(X1 - X2) =:= abs(Y1 - Y2).
