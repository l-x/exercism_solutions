-module(strain).

-export([keep/2, discard/2]).

-type predicate() :: fun((Element :: any()) -> boolean()).

-spec keep(Fn :: predicate(), List :: [T]) -> [T].
keep(Fn, List) ->
    keep(Fn, List, []).

-spec keep(Fn :: predicate(), List :: [T], Acc :: [T]) -> [T].
keep(Fn, [H | T], Acc) ->
    case Fn(H) of
        true ->
            keep(Fn, T, [H | Acc]);
        false ->
            keep(Fn, T, Acc)
    end;
keep(_Fn, [], Acc) ->
    lists:reverse(Acc).

-spec discard(Fn :: predicate(), List :: [T]) -> [T].
discard(Fn, List) ->
    keep(fun(E) -> not Fn(E) end, List).
