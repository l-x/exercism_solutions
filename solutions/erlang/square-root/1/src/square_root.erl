-module(square_root).

-export([square_root/1]).

-spec square_root(Radicant :: integer()) -> integer().
square_root(Radicand) ->
    square_root(Radicand, 1).

-spec square_root(Radicant :: integer(), Sqrt :: integer()) -> integer().
square_root(Radicant, Sqrt) when Sqrt * Sqrt < Radicant ->
    square_root(Radicant, Sqrt + 1);
square_root(_Radicant, Sqrt) ->
    Sqrt.
