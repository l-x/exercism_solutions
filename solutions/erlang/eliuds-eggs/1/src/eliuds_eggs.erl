-module(eliuds_eggs).

-export([egg_count/1]).

-spec egg_count(Number :: integer()) -> Count :: non_neg_integer().
egg_count(0) ->
    0;
egg_count(Number) ->
    Number rem 2 + egg_count(Number div 2).
