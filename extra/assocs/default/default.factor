! Copyright (C) 2023 Keldan Chapman.
! See https://factorcode.org/license.txt for BSD license.
USING: kernel assocs delegate delegate.protocols accessors summary stack-checker effects ;
IN: assocs.default

ERROR: invalid-default-quot ;
M: invalid-default-quot summary
  drop "Default quotation must have the effect ( -- default )" ;

TUPLE: default-assoc assoc default ;
: <default-assoc> ( assoc default -- default-assoc )
  dup infer ( -- default ) effect= [ invalid-default-quot ] unless
  default-assoc boa ;

CONSULT: assoc-protocol default-assoc assoc>> ;
M: default-assoc at*
  [ assoc>> ] [ default>> [ nip call( -- default ) ] curry ] bi cache t ;
