! Copyright (C) 2023 Keldan Chapman.
! See https://factorcode.org/license.txt for BSD license.
USING: kernel math math.extras sequences ;
IN: math.polynomials.extras

: polysum ( n p -- Σp[k] )
    over 1 < [ 2drop 0 ] [ dup ?first 0 or -rot 
    [ faulhaber * + ] with each-index ] if ;
