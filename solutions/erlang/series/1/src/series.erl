-module(series).

-export([slices/2]).

-spec slices(SliceLength :: integer(), Series :: string(), Acc :: [string()]) ->
                [string()].
slices(SliceLength, Series, Acc) when SliceLength > 0 ->
    Slice = string:slice(Series, 0, SliceLength),
    Complete = string:length(Slice) =:= SliceLength,

    case {Complete, Acc} of
        {false, [_ | _]} ->
            lists:reverse(Acc);
        {true, _} ->
            slices(SliceLength, tl(Series), [Slice | Acc])
    end.

-spec slices(SliceLength :: integer(), Series :: string()) -> [string()].
slices(SliceLength, Series) ->
    slices(SliceLength, Series, []).
