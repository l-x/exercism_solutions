-module(rna_transcription).

-export([to_rna/1]).

-spec complement(char()) -> char().
complement($A) -> $U;
complement($T) -> $A;
complement($C) -> $G;
complement($G) -> $C.


-spec to_rna(string()) -> string().
to_rna(Strand) -> [complement(X) || X <- Strand].
