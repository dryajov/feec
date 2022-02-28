import std/unittest

import ../../feec/gf/gflut

const
  # this constants are mixed in by the
  # underlying GF implementation
  GFExp = 18
  GFPolynomial = 262221

type
  GFSymbol = initSymbol(GFExp)

suite "GF Arithmetic in GF 18":

  test "Addition":
    check:
      50000.GFSymbol + 50000.GFSymbol == 0.GFSymbol
      150000.GFSymbol + 200000.GFSymbol == 83120.GFSymbol
      5.GFSymbol + 233000.GFSymbol == 233005.GFSymbol

  test "Multiplication":
    check:
      50000.GFSymbol * 50000.GFSymbol == 62720.GFSymbol
      15000.GFSymbol * 20000.GFSymbol == 142914.GFSymbol
      50000.GFSymbol * 23300.GFSymbol == 165035.GFSymbol

  test "Substraction":
    check:
      50000.GFSymbol - 50000.GFSymbol == 0.GFSymbol
      15000.GFSymbol - 20000.GFSymbol == 29880.GFSymbol
      50000.GFSymbol - 23300.GFSymbol == 38996.GFSymbol

  test "Divission":
    check:
      50000.GFSymbol / 50000.GFSymbol == 1.GFSymbol
      15000.GFSymbol / 20000.GFSymbol == 55685.GFSymbol
      50000.GFSymbol / 23300.GFSymbol == 200881.GFSymbol

  test "Exponentiation":
    check:
      50000.GFSymbol ^ 50000 == 50371.GFSymbol
      15000.GFSymbol ^ 20000 == 141975.GFSymbol
      50000.GFSymbol ^ 23300 == 149378.GFSymbol

  test "Inverse":
    check:
      GFSymbol(50000).inverse == 74255.GFSymbol
      GFSymbol(15000).inverse == 143543.GFSymbol
      GFSymbol(23300).inverse == 114202.GFSymbol
