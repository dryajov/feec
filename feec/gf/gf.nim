{.push raises: [Defect].}
{.deadCodeElim: on.}

import ./helpers/liftop

type
  GFUint8* = distinct uint8
  GFUint16* = distinct uint16
  GFUint32* = distinct uint32
  GFUint64* = distinct uint64

  GFUint* = GFUint8 | GFUint16 | GFUint32 | GFUint64
  GFField* = object of RootObj # base tag

GFLiftOp GFUint8, uint8
GFLiftOp GFUint16, uint16
GFLiftOp GFUint32, uint32
GFLiftOp GFUint64, uint64

template initSymbol*(Exp: static int): auto =
  ## Init a valid field element a.k.a symbol
  ##
  typedesc[range[0.GFUint..(1 shl Exp) - 1]]
