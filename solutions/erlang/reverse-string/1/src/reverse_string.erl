-module(reverse_string).

-export([reverse/1]).

reverse(String) ->
    do_reverse(string:to_graphemes(String), []).

do_reverse([], Acc) ->
    Acc;
do_reverse([H | T], Acc) ->
    do_reverse(T, [H | Acc]).
