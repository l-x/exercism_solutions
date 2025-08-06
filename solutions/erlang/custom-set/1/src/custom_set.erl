-module(custom_set).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1,
         intersection/2, subset/2, union/2]).

-type elem() :: integer().
-type set() :: integer().

-spec add(Elem :: elem(), Set :: set()) -> set().
add(Elem, Set) ->
    union(Set, 1 bsl Elem).

-spec contains(Elem :: elem(), Set :: set()) -> boolean().
contains(Elem, Set) ->
    not empty(intersection(Set, 1 bsl Elem)).

-spec difference(Set1 :: set(), Set2 :: set()) -> set().
difference(Set1, Set2) ->
    Set1 bxor intersection(Set1, Set2).

-spec disjoint(Set1 :: set(), Set2 :: set()) -> boolean().
disjoint(Set1, Set2) ->
    empty(intersection(Set1, Set2)).

-spec empty(Set :: set()) -> boolean().
empty(Set) ->
    equal(Set, 0).

-spec equal(Set1 :: set(), Set2 :: set()) -> boolean().
equal(Set1, Set2) ->
    Set1 == Set2.

-spec from_list(List :: [elem()], Set :: set()) -> set().
from_list([], Set) ->
    Set;
from_list([X | Xs], Set) ->
    from_list(Xs, add(X, Set)).

-spec from_list(List :: [elem()]) -> set().
from_list(List) ->
    from_list(List, 0).

-spec intersection(Set1 :: set(), Set2 :: set()) -> set().
intersection(Set1, Set2) ->
    Set1 band Set2.

-spec subset(Set1 :: set(), Set2 :: set()) -> boolean().
subset(Set1, Set2) ->
    equal(intersection(Set1, Set2), Set1).

-spec union(Set1 :: set(), Set2 :: set()) -> set().
union(Set1, Set2) ->
    Set1 bor Set2.
