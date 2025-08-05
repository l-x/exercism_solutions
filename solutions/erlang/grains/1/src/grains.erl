-module(grains).

-export([square/1, total/0]).

square(Square) when Square >= 1, Square =< 64 ->
    trunc(math:pow(2, Square - 1));
square(_Square) ->
    {error, "square must be between 1 and 64"}.

total() ->
    2 * square(64) - 1.
