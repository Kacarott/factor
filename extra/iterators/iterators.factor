USING: kernel sequences math lists accessors make ;
IN: iterators

! Modelled after Rusts iterator trait
! https://doc.rust-lang.org/std/iter/trait.Iterator.html

! Classes which support iteration
MIXIN: >iterator

! Required Generics
GENERIC: >iter ( >itr -- itr )

! Instances
INSTANCE: sequence >iterator
TUPLE: sequence-iter seq ind ;
M: sequence >iter 0 \ sequence-iter boa ;

INSTANCE: list >iterator
TUPLE: list-iter list ;
M: list >iter \ list-iter boa ;

! Core iterator class
MIXIN: iterator
INSTANCE: iterator >iterator
M: iterator >iter ;

! Required Generics
GENERIC: next* ( itr -- value/f ? )

! Optional Generics
! GENERIC: length ( itr -- n )
M: iterator length -1 [ 1 + over next* nip ] loop nip ;

GENERIC: size-hint ( itr -- min max/f )
M: iterator size-hint drop 0 f ;

GENERIC: last ( itr -- elt/f )
M: iterator last f f [ nip over next* ] loop drop nip ;

GENERIC: nth* ( n itr -- elt/f ? )
M: iterator nth* dup next* roll [ 2drop dup next* ] times nipd ;

GENERIC#: iter-map 1 ( itr quot: ( elt -- newelt ) -- itr' )
GENERIC#: iter-filter 1 ( itr quot: ( elt -- ? ) -- itr' )

! Intances
TUPLE: map-iter itr op ;
INSTANCE: map-iter iterator
M: map-iter next*
    [ itr>> next* ] [ op>> ] bi over
    [ [ call( elt -- newelt ) ] curry dip ] [ drop ] if ;
M: map-iter size-hint itr>> size-hint ;
M: iterator iter-map \ map-iter boa ;

TUPLE: filter-iter itr pred ;
INSTANCE: filter-iter iterator
M: filter-iter next*
    [ itr>> ] [ pred>> f f rot ] bi
    '[ 2drop dup next* dup [ over _ call( elt -- ? ) not ] [ f ] if ] loop nipd ;
M: filter-iter size-hint itr>> size-hint [ drop 0 ] dip ;
M: iterator iter-filter \ filter-iter boa ;

INSTANCE: sequence-iter iterator
M: sequence-iter next*
    dup [ ind>> ] [ seq>> length ] bi <
    [ [ ind>> ] [ seq>> nth ] [ [ 1 + ] change-ind drop t ] tri ]
    [ drop f f ] if ;
M: sequence-iter length
    dup [ seq>> length ] [ ind>> ] bi - tuck [ + ] curry change-ind drop ;
M: sequence-iter size-hint [ seq>> length ] [ ind>> ] bi - dup ;
M: sequence-iter last
    dup size-hint nip 0 = [ drop f ] [
        [ seq>> [ length 1 - ] keep nth ] [ length drop ] bi
    ] if ;
M: sequence-iter nth*
    dup size-hint nip pick < [
        swap [ + ] curry change-ind next*
    ] [ length 2drop f f ] if ;

INSTANCE: list-iter iterator
M: list-iter next* dup list>> dup nil? [ 2drop f f ] [ uncons rot list<< t ] if ;

! Classes which support collecting from iterables

MIXIN: iterator>

! Required Generics
GENERIC: collect-as ( itr exemplar -- collection )

! Instances
INSTANCE: sequence iterator>
M: sequence collect-as [ dup sequence-iter? [ seq>> ] [
        '[ [ _ next* ] [ , ] while drop ] V{ } make
    ] if ] dip like ;

! Eager operations
: map ( ... >itr quot: ( ... elt -- ... newelt ) -- ... itr> )
    over [
        [ >iter ] dip '[ [ _ next* ] [ @ , ] while drop ] V{ } make >iter
    ] dip collect-as ; inline
! : filter ( ... >itr quot: ( ... elt -- ... ? ) -- ... itr> )
!
! ! Mutating operations
! : map! ( ... >itr quot: ( ... elt -- ... newelt ) -- ... )
!
! ! Stretching operations
! : filter! ( ... >itr quot: ( ... elt -- ... ? ) -- ... )





! ~~~ Generics to think about later after demo ~~~
! GENERIC: next-chunk ( n itr -- seq )
! GENERIC: size-hint ( itr -- min max/f )
! GENERIC: length ( itr -- n )
! GENERIC: last ( itr -- elt/f )
! GENERIC: advance* ( n itr -- ? )
! GENERIC: nth* ( n itr -- elt/f ? )
! GENERIC: step ( n itr -- itr' )
! GENERIC: chain ( itr1 itr2 -- itr' ) ! Maybe should be iter-append ?
! GENERIC: iter-zip ( itr1 itr2 -- itr' )
! GENERIC#: iter-intersperse 1 ( itr elt -- itr' )
! GENERIC#: iter-intersperse-with 1 ( itr quot: ( -- elt ) -- itr' )
! GENERIC#: iter-map 1 ( itr quot: ( elt -- newelt ) -- itr' )
! GENERIC#: iter-each 1 ( itr quot: ( elt -- ) -- itr' ) ! called inspect in rust
! GENERIC#: iter-filter 1 ( itr quot: ( elt -- ? ) -- itr' )
! GENERIC#: iter-filter-map 2 ( itr filter-quot: ( elt -- ? ) map-quot: ( elt -- newelt ) -- itr' )
! GENERIC: iter-enumerated ( itr -- itr' )
! ! GENERIC: peekable ( itr -- peekable ) ! Implement this seperately in iterators.peekable?
! GENERIC#: iter-drop-while 1 ( itr quot: ( elt -- ? ) -- itr' )
! GENERIC#: iter-take-while 1 ( itr quot: ( elt -- ? ) -- itr' )
! GENERIC#: iter-map-while 1 ( itr quot: ( elt -- newelt ? ) -- itr' )
! GENERIC: skip ( n itr -- itr' )
! GENERIC: take ( n itr -- itr' )
! GENERIC#: iter-scan 1 ( itr quot: ( acc elt -- acc' ? ) -- itr' )
! GENERIC#: iter-flat-map ( itr quot: ( elt -- >itr ) -- itr' )
! GENERIC: iter-concat ( itr -- itr' )
! GENERIC: iter-flatten ( itr -- itr' )
! GENERIC: fuse ( itr -- itr' )
! GENERIC#: iter-partition 1 ( itr quot: ( elt -- ? ) -- true-itr false-itr )
! GENERIC: maximum ( itr -- max )
! GENERIC: minimum ( itr -- min )
! GENERIC: iter-unzip ( itr -- itr1 itr2 )
! ! M: iterator clone ;
! GENERIC: iter-cycle ( itr -- itr' )
! GENERIC: sum ( itr -- n )
! GENERIC: product ( itr -- n )
! GENERIC: iter= ( itr1 itr2 -- ? ) ! Compares if all elements are equal. Does not care about container type.
! GENERIC: sorted? ( itr -- ? )
! GENERIC: collect ( itr -- itr> ) ! Collect into a default collection type
