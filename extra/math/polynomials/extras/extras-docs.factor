! Copyright (C) 2023 Keldan Chapman
! See https://factorcode.org/license.txt for BSD license

USING: help.markup help.syntax kernel math math.polynomials.extras ;
IN: math.extras

HELP: polysum
{ $values { "n" integer } { "p" "a polynomial" } { "Σp[k]" number } }
{ $description "Efficiently calculate the sum of "
    { $snippet "p[k]" } " for each integer k between " { $snippet "0" }
    " and " { $snippet "n" } " inclusive." } ;