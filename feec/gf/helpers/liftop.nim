{.push raises: [Defect].}
{.deadCodeElim: on.}

template GFLiftOp*(typ, borowing: type) {.dirty.} =
  proc `+`*(x: typ, y: borowing): typ {.borrow, noSideEffect.}
  proc `+`*(x: borowing, y: typ): typ {.borrow, noSideEffect.}

  proc `-`*(x: typ, y: borowing): typ {.borrow, noSideEffect.}
  proc `-`*(x: borowing, y: typ): typ {.borrow, noSideEffect.}

  # Not closed over type in question (Slot or Epoch)
  proc `mod`*(x: typ, y: typ): typ {.borrow, noSideEffect.}
  proc `mod`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}

  proc `xor`*(x: typ, y: typ): typ {.borrow, noSideEffect.}
  proc `xor`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}

  proc `shl`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}
  proc `shr`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}

  proc `div`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}
  proc `div`*(x: borowing, y: typ): borowing {.borrow, noSideEffect.}

  proc `*`*(x: typ, y: borowing): borowing {.borrow, noSideEffect.}

  proc `+=`*(x: var typ, y: typ) {.borrow, noSideEffect.}
  proc `+=`*(x: var typ, y: borowing) {.borrow, noSideEffect.}
  proc `-=`*(x: var typ, y: typ) {.borrow, noSideEffect.}
  proc `-=`*(x: var typ, y: borowing) {.borrow, noSideEffect.}

  # Comparison operators
  proc `<`*(x: typ, y: typ): bool {.borrow, noSideEffect.}
  proc `<`*(x: typ, y: borowing): bool {.borrow, noSideEffect.}
  proc `<`*(x: borowing, y: typ): bool {.borrow, noSideEffect.}

  proc `<=`*(x: typ, y: typ): bool {.borrow, noSideEffect.}
  proc `<=`*(x: typ, y: borowing): bool {.borrow, noSideEffect.}
  proc `<=`*(x: borowing, y: typ): bool {.borrow, noSideEffect.}

  proc `==`*(x: typ, y: typ): bool {.borrow, noSideEffect.}
  proc `==`*(x: typ, y: borowing): bool {.borrow, noSideEffect.}
  proc `==`*(x: borowing, y: typ): bool {.borrow, noSideEffect.}

  # Nim integration
  proc `$`*(x: typ): string {.borrow, noSideEffect.}
