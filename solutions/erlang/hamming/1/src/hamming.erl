-module(hamming).

-export([distance/2]).

distance(Strand1, Strand2) when length(Strand1) =:= length(Strand2) ->
    length([true || {S1, S2} <:- lists:zip(Strand1, Strand2), S1 =/= S2]);
distance(_Strand1, _Strand2) ->
    {error, badarg}.
