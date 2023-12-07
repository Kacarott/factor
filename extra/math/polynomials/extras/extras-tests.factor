! Copyright (C) 2023 Keldan Chapman
! See https://factorcode.org/license.txt for BSD license

USING: tools.test math.polynomials.extras ;

{ 101586758 } [ 27 { 5 2 8 9 9 1 } polysum ] unit-test
{ 303 } [ 8 { 3 2 1 } polysum ] unit-test
{ 0 } [ 0 { 3 2 1 } polysum ] unit-test
{ 0 } [ 7 { } polysum ] unit-test
{ 8 } [ 7 { 1 } polysum ] unit-test
{ 0 } [ -4 { 1 } polysum ] unit-test