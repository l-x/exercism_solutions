-module(simple_linked_list).

-export([cons/2, count/1, empty/0, from_native_list/1, head/1, reverse/1, tail/1,
         to_native_list/1]).

-type empty_list() :: {}.
-type non_empty_list() :: {any(), any_list()}.
-type any_list() :: non_empty_list() | empty_list().

-spec empty() -> empty_list().
empty() ->
    {}.

-spec cons(Elt :: any(), List :: any_list()) -> non_empty_list().
cons(Elt, List) ->
    {Elt, List}.

-spec head(non_empty_list()) -> any().
head({H, _}) ->
    H.

-spec tail(non_empty_list()) -> non_empty_list().
tail({_, {_, _} = Tail}) ->
    Tail.

-spec reverse(List :: empty_list()) -> empty_list();
             (List :: non_empty_list()) -> non_empty_list().
reverse(List) ->
    reverse(List, empty()).

-spec count(List :: any_list()) -> non_neg_integer().
count(List) ->
    count(List, 0).

-spec to_native_list(List :: empty_list()) -> [];
                    (List :: non_empty_list()) -> [any()].
to_native_list(List) ->
    lists:reverse(to_native_list(List, [])).

-spec from_native_list(List :: []) -> empty_list();
                      (List :: [any()]) -> non_empty_list().
from_native_list(NativeList) ->
    from_native_list(lists:reverse(NativeList), empty()).

%% recursive helper functions

reverse({}, Acc) ->
    Acc;
reverse({H, T}, Acc) ->
    reverse(T, cons(H, Acc)).

count({}, Acc) ->
    Acc;
count({_, Xs}, Acc) ->
    count(Xs, Acc + 1).

to_native_list({}, Acc) ->
    Acc;
to_native_list({H, T}, Acc) ->
    to_native_list(T, [H | Acc]).

from_native_list([], Acc) ->
    Acc;
from_native_list([H | T], Acc) ->
    from_native_list(T, cons(H, Acc)).
