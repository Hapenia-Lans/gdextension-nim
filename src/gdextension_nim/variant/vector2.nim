import ../core/math



type
  Axis* = enum
    AxisX, AxisY

  Kind* = enum
    Basic, Ui

  Vector2* = object
    x*, y*: float


proc nativePtr*(v: Vector2): pointer = unsafeAddr v


proc `width`*(v: Vector2): float = v.x


proc `width=`*(v: var Vector2, value: float): void = v.x = value


proc `height`*(v: Vector2): float = v.y


proc `height=`*(v: var Vector2, value: float): void = v.y = value


proc `+`*(v1, v2: Vector2): Vector2 =
  Vector2(
    x: v1.x + v2.x,
    y: v1.y + v2.y
  )


proc `-`*(v: Vector2): Vector2 =
  Vector2(
    x: -v.x,
    y: -v.y
  )


proc `-`*(v1, v2: Vector2): Vector2 =
  Vector2(
    x: v1.x - v2.x,
    y: v1.y - v2.y
  )


proc `+=`*(v: var Vector2, v1: Vector2): void =
  v.x += v1.x
  v.y += v1.y


proc `-=`*(v: var Vector2, v1: Vector2): void =
  v.x -= v1.x
  v.y -= v1.y


proc `*`*(v1, v2: Vector2): Vector2 =
  Vector2(
    x: v1.x * v2.x,
    y: v1.y * v2.y
  )


proc `*`*(v: Vector2, f: float): Vector2 =
  Vector2(
    x: v.x * f,
    y: v.y * f
  )


proc `*`*(f: float, v: Vector2): Vector2 =
  Vector2(
    x: v.x * f,
    y: v.y * f
  )


proc `*=`*(v: var Vector2, rValue: Vector2): void =
  v = v * rValue


proc `*=`*(v: var Vector2, rValue: float): void =
  v = rValue * v


proc `/`*(v1, v2: Vector2): Vector2 =
  Vector2(
    x: v1.x/v2.x,
    y: v1.y/v2.y
  )


proc `/`*(v: Vector2, f: float): Vector2 = (1/f) * v


proc `/=`*(v: var Vector2, rValue: float): void =
  v = v / rValue


proc `/=`*(v: var Vector2, rValue: Vector2): void =
  v = v / rValue


proc `==`*(v1, v2: Vector2): bool = v1.x == v2.x and v1.y == v2.y


proc `!=`*(v1, v2: Vector2): bool = not(v1 == v2)


proc `<`*(v1, v2: Vector2): bool =
  if v1.x == v2.x: (v1.y < v2.y) else: (v1.x < v2.x)


proc `>`*(v1, v2: Vector2): bool =
  if v1.x == v2.x: (v1.y > v2.y) else: (v1.x > v2.x)


proc `<=`*(v1, v2: Vector2): bool =
  if v1.x == v2.x: (v1.y <= v2.y) else: (v1.x < v2.x)


proc `>=`*(v1, v2: Vector2): bool =
  if v1.x == v2.x: (v1.y >= v2.y) else: (v1.x > v2.x)


proc setAll*(vec: var Vector2; pValue: float): void {.inline.} =
  vec.x = pValue
  vec.y = pValue


proc length*(vec: Vector2): float {.inline.} = sqrt(vec.x^2 + vec.y^2)


proc lengthSquared*(vec: Vector2): float {.inline.} = vec.x^2 + vec.y^2


proc minAxisIndex*(vec: Vector2): Axis {.inline.} =
  if vec.x < vec.y: AxisX else: AxisY


proc maxAxisIndex*(vec: Vector2): Axis {.inline.} =
  if vec.x > vec.y: AxisX else: AxisY


proc normalize*(vec: var Vector2): void =
  let l = vec.x^2 + vec.y^2
  if l != 0:
    let t = sqrt(l)
    vec /= t


proc normalized*(vec: Vector2): Vector2 =
  result = vec
  result.normalize()


proc isNormalized*(vec: Vector2): bool =
  isEqualApprox(vec.lengthSquared(), 1, UNIT_EPSILON)


proc limitLength*(vec: Vector2, pLen: float = 1): Vector2 =
  let l = vec.length()
  result = vec
  if l > 0 and pLen < l:
    result /= l
    result *= pLen;


proc min*(a, b: Vector2): Vector2 =
  result = Vector2(
    x: min(a.x, b.x),
    y: min(a.y, b.y)
  )


proc max*(a, b: Vector2): Vector2 =
  result = Vector2(
    x: max(a.x, b.x),
    y: max(a.y, b.y)
  )


proc distanceTo*(a, b: Vector2): float =
  sqrt((a.x-b.x)^2 + (a.y-b.y)^2)


proc distanceSquaredTo*(a, b: Vector2): float =
  (a.x-b.x)^2 + (a.y-b.y)^2


proc dot*(a, b: Vector2): float =
  a.x * b.x + a.y * b.y


proc cross*(a, b: Vector2): float =
  a.x * b.y - a.y * b.x


proc angleTo*(a, b: Vector2): float =
  arctan2(cross(a, b), dot(a, b))


proc angle*(v: Vector2): float = arctan2(v.y, v.x)


proc angleToPoint*(a, b: Vector2): float =
  (b-a).angle()


proc abs*(v: Vector2): Vector2 {.inline.} =
  Vector2(x: abs(v.x), y: abs(v.y))


proc floor*(v: Vector2): Vector2 =
  Vector2(x: floor(v.x), y: floor(v.y))


proc ceil*(v: Vector2): Vector2 =
  Vector2(x: ceil(v.x), y: ceil(v.y))


proc round*(v: Vector2): Vector2 =
  Vector2(x: round(v.x), y: round(v.y))


proc sign*(v: Vector2): Vector2 =
  Vector2(x: sign(v.x), y: sign(v.y))


proc rotated*(v: Vector2, angle: float): Vector2 =
  let
    s = sin(angle)
    c = cos(angle)
  Vector2(
    x: v.x * c - v.y * s,
    y: v.x * s + v.y + c
  )


proc directionTo*(vFrom, vTo: Vector2): Vector2 {.inline.} =
  result = (vTo - vFrom).normalized()


proc posmod*(vec: Vector2, pmod: float): Vector2 =
  Vector2(x: fposmod(vec.x, pmod), y: fposmod(vec.y, pmod))


proc posmodv*(vec, pmod: Vector2): Vector2 =
  Vector2(x: fposmod(vec.x, pmod.x), y: fposmod(vec.y, pmod.y))


proc project*(vFrom, vTo: Vector2): Vector2 =
  vTo * (dot(vFrom, vTo) / vTo.lengthSquared())


proc clamp*(v, min, max: Vector2): Vector2 =
  Vector2(
    x: clamp(v.x, min.x, max.x),
    y: clamp(v.y, min.y, max.y)
  )


proc planeProject*(vec: Vector2; pD: float, pVec: Vector2): Vector2 =
  result = pVec - vec * (dot(vec, pVec) - pD)


proc lerp*(vFrom, vTo: Vector2, weight: float): Vector2 {.inline.} =
  result = vFrom + weight * (vTo - vFrom)


proc slerp*(vFrom, vTo: Vector2, weight: float): Vector2 {.inline.} =
  let
    startLengthSq = vFrom.lengthSquared()
    endLengthSq = vTo.lengthSquared()
  if unlikely(startLengthSq == 0.0 or endLengthSq == 0.0):
    return lerp(vFrom, vTo, weight)
  let
    startLength = sqrt(startLengthSq)
    resultLength = lerp(startLength, sqrt(endLengthSq), weight)
    angle = vFrom.angleTo(vTo)
  result = vFrom.rotated(angle * weight) * (resultLength / startLength)


proc cubicInterpolate*(a, b, preA, postB: Vector2,
    weight: float): Vector2 {.inline.} =
  result = a
  result.x = cubicInterpolate(result.x, b.x, preA.x, postB.x, weight)
  result.y = cubicInterpolate(result.y, b.y, preA.y, postB.y, weight)


proc bezierInterpolate*(vstart, ctrl1, ctrl2, vend: Vector2,
    t: float): Vector2 {.inline.} =
  let
    omt = 1 - t
    omt2 = omt^2
    omt3 = omt2 * omt
    t2 = t^2
    t3 = t2 * t
  result = (vstart * omt3) + (ctrl1 * omt2 * t * 3.0 + ctrl2 * omt * t2 * 3.0) +
      (vend * t3)


proc moveToward*(vFrom, vTo: Vector2, delta: float): Vector2 =
  result = vFrom
  let vd = vTo - result
  let len = vd.length()
  result = if len <= delta or len < CMP_EPSILON: vTo else: result + vd / len * delta


proc slide*(v, normal: Vector2): Vector2 =
  result = v - normal * v.dot(normal)


proc reflect*(v, normal: Vector2): Vector2 =
  result = 2 * normal * v.dot(normal) - v


proc bounce*(v, normal: Vector2): Vector2 = -v.reflect(normal)


proc isEqualApprox*(v1, v2: Vector2): bool =
  result = isEqualApprox(v1.x, v2.x) and isEqualApprox(v1.y, v2.y)


proc orthogonal*(v: Vector2): Vector2 =
  Vector2(x: v.y, y: -v.x)


proc snapped*(v, by: Vector2): Vector2 =
  Vector2(
    x: snapped(v.x, by.x),
    y: snapped(v.x, by.y)
  )


proc aspect*(v: Vector2): float = v.x / v.y


proc fromAngle*(angle: float): Vector2 =
  Vector2(x: cos(angle), y: sin(angle))


proc toString*(v: Vector2): string =
  result = "[" & $v.x & ", " & $v.y & "]"


proc `$`*(v: Vector2): string = v.toString()
