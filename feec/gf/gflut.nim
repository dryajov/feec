{.push raises: [Defect].}
{.deadCodeElim: on.}

import ./helpers/utils
import ./gf

export gf

type
  GFFieldLut*[Exp: static int] = object of GFField
    gfExp*: seq[uint] # Anti-log (exponentiation) table.
    gfLog*: seq[uint] # Log table, log[0] is impossible and thus unused

proc init*[Exp: static int](T: type GFFieldLut[Exp], poly: static uint): var GFFieldLut[Exp] =
  const
    Order = (1'u shl Exp)
    Degree = Order - 1'u

  var
    field {.global, noInit.}: GFFieldLut[Exp]

  once:
    field = GFFieldLut[Exp](
      gfExp: newSeqUninitialized[uint](((1'u shl Exp) - 1) * 2),
      gfLog: newSeqUninitialized[uint]((1'u shl Exp))
    )

    # For each possible value in the galois field 2^p, we will pre-compute
    # the logarithm and anti-logarithm (exponentiation) of this value
    #
    # To do that, we generate the Galois Field F(2^p) by building a list
    # starting with the element 0 followed by the (p-1) successive powers of
    # the generator a: 1, a, a^1, a^2, ..., a^(p-1).
    var x = 1'u
    for i in 0..<Degree:
      field.gfExp[i] = x.uint # compute anti-log for this value and store it in a table
      field.gfLog[x] = i.uint # compute log at the same time
      x = mulNoLUT(x = x, y = 2'u, prim = poly, order = Order)

    # double the size of the anti-log table so that we don't
    # need to mod 255 to stay inside the bounds

    # NOTE: double the Exponentiation table so we don't have to use `mod`
    for i in 0..<Degree:
      field.gfExp[i + Degree] = field.gfExp[i]

  field

func `+`*[T](x, y: T): T {.inline.} =
  x xor y

func `-`*[T](x, y: T): T {.inline.} =
  # in binary galois field, substraction
  # is just the same as addition (since we mod 2)
  x xor y

proc `*`*[T](x, y: T): T {.inline.} =
  mixin init, GFExp, GFPolynomial
  if x == 0 or y == 0:
    return 0.T

  let
    field = GFFieldLut[GFExp].init(GFPolynomial)

  result = field.gfExp[field.gfLog[x.uint] + field.gfLog[y.uint]].T

proc `div`*[T](x, y: T): T {.raises: [DivByZeroError], inline.} =
  mixin init, GFExp, GFPolynomial
  if y == 0:
    # TODO: use DivByZeroDefect once we drop 1.2.6
    raise newException(DivByZeroError, "Can't divide by 0!")

  if x == 0:
    return 0.T

  let
    field = GFFieldLut[GFExp].init(GFPolynomial)

  field.gfExp[((field.gfLog[x.int] + T.high.uint) - field.gfLog[y.int])].T

proc `/`*[T](x, y: T): T {.inline.} =
  x div y

proc `^`*[T](x: T, power: int): T {.inline.} =
  mixin init, GFExp, GFPolynomial

  let
    field = GFFieldLut[GFExp].init(GFPolynomial)

  field.gfExp[(field.gfLog[x.int] * power.uint) mod T.high.uint].T

proc inverse*[T](x: T): T {.inline.} =
  mixin init, GFExp, GFPolynomial

  let
    field = GFFieldLut[GFExp].init(GFPolynomial)

  field.gfExp[(T.high - field.gfLog[x.int]) mod T.high].T
