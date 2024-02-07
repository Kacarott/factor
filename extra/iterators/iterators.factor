USING: kernel ;
IN: iterators

! Modelled after Rusts iterator trait
! https://doc.rust-lang.org/std/iter/trait.Iterator.html

! Core iterator class
MIXIN: iterator

! Required Generics
GENERIC: next* ( itr -- value/f ? )

! Optional Generics
GENERIC: next-chunk ( n itr -- seq )
GENERIC: size-hint ( itr -- min max/f )
GENERIC: length ( itr -- n )
GENERIC: last ( itr -- x/f )
GENERIC: advance* ( n itr -- ? )
GENERIC: nth* ( n itr -- elt/f ? )
GENERIC: step ( n itr -- itr' )
GENERIC: chain ( itr1 itr2 -- itr' ) ! Maybe should be iter-append ?
GENERIC: iter-zip ( itr1 itr2 -- itr' )
GENERIC#: iter-intersperse 1 ( itr elt -- itr' )
GENERIC#: iter-intersperse-with 1 ( itr quot: ( -- elt ) -- itr' )
GENERIC#: iter-map 1 ( itr quot: ( elt -- newelt ) -- itr' )
GENERIC#: iter-each 1 ( itr quot: ( elt -- ) -- itr' ) ! called inspect in rust
GENERIC#: iter-filter 1 ( itr quot: ( elt -- ? ) -- itr' )
GENERIC#: iter-filter-map 2 ( itr filter-quot: ( elt -- ? ) map-quot: ( elt -- newelt ) -- itr' )
GENERIC: iter-enumerated ( itr -- itr' )
! GENERIC: peekable ( itr -- peekable ) ! Implement this seperately in iterators.peekable?
GENERIC#: iter-drop-while 1 ( itr quot: ( elt -- ? ) -- itr' )
GENERIC#: iter-take-while 1 ( itr quot: ( elt -- ? ) -- itr' )
GENERIC#: iter-map-while 1 ( itr quot: ( elt -- newelt ? ) -- itr' )
GENERIC: skip ( n itr -- itr' )
GENERIC: take ( n itr -- itr' )
GENERIC#: iter-scan 1 ( itr quot: ( acc elt -- acc' ? ) -- itr' )
GENERIC#: iter-flat-map ( itr quot: ( elt -- >itr ) -- itr' )
GENERIC: iter-concat ( itr -- itr' )
GENERIC: iter-flatten ( itr -- itr' )
GENERIC: fuse ( itr -- itr' )
GENERIC#: iter-partition 1 ( itr quot: ( elt -- ? ) -- true-itr false-itr )
GENERIC: maximum ( itr -- max )
GENERIC: minimum ( itr -- min )
GENERIC: iter-unzip ( itr -- itr1 itr2 )
! M: iterator clone ;
GENERIC: iter-cycle ( itr -- itr' )
GENERIC: sum ( itr -- n )
GENERIC: product ( itr -- n )
GENERIC: iter= ( itr1 itr2 -- ? ) ! Compares if all elements are equal. Does not care about container type.
GENERIC: sorted? ( itr -- ? )
GENERIC: collect ( itr -- itr> ) ! Collect into a default collection type


! Classes which support iteration
MIXIN: >iterator

! Required Generics
GENERIC: >iter ( >itr -- itr )

! Classes which support collecting from iterables

MIXIN: iterator>

! Required Generics
GENERIC: collect-as ( itr exemplar -- collection )
