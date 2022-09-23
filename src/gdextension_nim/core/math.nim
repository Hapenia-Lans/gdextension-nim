import std/math
export math

### Some math functions does not exists in nim's std library.

const
  CMP_EPSILON* = 0.00001
  CMP_EPSILON2* = CMP_EPSILON^2
  UNIT_EPSILON* = 0.001


proc isEqualApprox*(a, b: float): bool {.inline.} =
  if a == b: return true
  var tol = CMP_EPSILON * abs(a)
  if tol < CMP_EPSILON: tol = CMP_EPSILON
  result = abs(a-b) < tol


proc isEqualApprox*(a, b, tolerance: float): bool {.inline.} =
  if a == b: return true
  result = abs(a-b) < tolerance


proc isZeroApprox*(s: float): bool = abs(s) < CMP_EPSILON


proc sign*[T](x: T): T =
  cast[T](if x < 0: -1 else: 1)


proc fposmod*(x, y: float): float =
  result = floorMod(x, y)
  if (result < 0 and y > 0) or (result > 0 and y < 0):
    result += y


proc snapped*(value, step: float): float {.inline.} =
  result = value
  if step != 0:
    result = floor(value/step + 0.5) * step


proc lerp*(minv, maxv, t: float): float {.inline.}=
  minv + t * (maxv - minv)


proc cubicInterpolate*(fromvalue,tovalue,pre,post,weight: float): float {.inline.} =
  result = 0.5 * (
    (fromvalue * 2) +
    (-pre + tovalue) * weight +
    (2.0*pre - 5.0*fromvalue + 4.0*tovalue - post) * weight^2 +
    (-pre + 3.0*fromvalue - 3.0*tovalue + post) * weight^3
  )

