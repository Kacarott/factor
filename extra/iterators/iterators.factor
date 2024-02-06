USING: kernel ;
IN: iterators

! Modelled after Rusts iterator trait
! https://doc.rust-lang.org/std/iter/trait.Iterator.html
MIXIN: iterator


! Required Generics
GENERIC: next* ( itr -- value/f ? )

! Optional Generics
GENERIC: next-chunk ( n itr -- seq )
GENERIC: size-hint ( itr -- min max/f )
GENERIC: count ( itr -- n )
GENERIC: last ( itr -- x/f )
GENERIC: advance-by ( n itr -- )
GENERIC: nth* ( n itr -- elt/f ? )
