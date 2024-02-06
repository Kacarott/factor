! Copyright (C) 2024 Keldan Chapman.
! See https://factorcode.org/license.txt for BSD license.
USING: help.markup help.syntax ;
IN: iterators

ARTICLE: "iterators" "Iterators"
"The iterator protocol is a generalised way of working with sequential data. Many data types such as sequences and lists support conversion to and from iterators. Iterators in Factor are modelled after the iterator trait in Rust.

All iterators must be instances of the mixin class:"
{ $subsections iterator iterator? }
"All iterators must be able to emit values, advancing the iterator:"
{ $subsections next }
;

ABOUT: "iterators"
