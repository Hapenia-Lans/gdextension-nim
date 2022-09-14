
import ../internal
import ../wrapped_header/gdnative_interface
import method_ptrcall

import ../variant/[vector2]

type
  Type* = enum
    NIL,

    # atomic types
    BOOL,
    INT,
    FLOAT,
    STRING,

    # math types
    VECTOR2,
    VECTOR2I,
    RECT2,
    RECT2I,
    VECTOR3,
    VECTOR3I,
    TRANSFORM2D,
    VECTOR4,
    VECTOR4I,
    PLANE,
    QUATERNION,
    AABB,
    BASIS,
    TRANSFORM3D,
    PROJECTION,

    # misc types
    COLOR,
    STRING_NAME,
    NODE_PATH,
    RID,
    OBJECT,
    CALLABLE,
    SIGNAL,
    DICTIONARY,
    ARRAY,

    # typed arrays
    PACKED_BYTE_ARRAY,
    PACKED_INT32_ARRAY,
    PACKED_INT64_ARRAY,
    PACKED_FLOAT32_ARRAY,
    PACKED_FLOAT64_ARRAY,
    PACKED_STRING_ARRAY,
    PACKED_VECTOR2_ARRAY,
    PACKED_VECTOR3_ARRAY,
    PACKED_COLOR_ARRAY,

    VARIANT_MAX,

    
  Operator* = enum
    # comparison
    OP_EQUAL,
    OP_NOT_EQUAL,
    OP_LESS,
    OP_LESS_EQUAL,
    OP_GREATER,
    OP_GREATER_EQUAL,
    # mathematic
    OP_ADD,
    OP_SUBTRACT,
    OP_MULTIPLY,
    OP_DIVIDE,
    OP_NEGATE,
    OP_POSITIVE,
    OP_MODULE,
    # bitwise
    OP_SHIFT_LEFT,
    OP_SHIFT_RIGHT,
    OP_BIT_AND,
    OP_BIT_OR,
    OP_BIT_XOR,
    OP_BIT_NEGATE,
    # logic
    OP_AND,
    OP_OR,
    OP_XOR,
    OP_NOT,
    # containment
    OP_IN,
    OP_MAX,


type 
  GodotVariantObj* = array[24, byte]
  GodotVariant* = ref GodotVariantObj

var
  fromTypeConstructor: array[VARIANT_MAX,GDNativeVariantFromTypeConstructorFunc]
  toTypeConstructor: array[VARIANT_MAX,GDNativeTypeFromVariantConstructorFunc]


proc initBindings*(): void =
  for i in BOOL..<VARIANT_MAX:
    # echo i
    fromTypeConstructor[i] = gdnInterface.get_variant_from_type_constructor(cast[GDNativeVariantType](i))
    # echo i, " is finished"
    # echo "binding ", i
    toTypeConstructor[i] = gdnInterface.get_variant_to_type_constructor(cast[GDNativeVariantType](i))


proc nativePtr(v: GodotVariant): pointer = unsafeAddr v[]


proc newGodotVariant(): GodotVariant =
  result = new GodotVariant


proc Variant*(): GodotVariant =
  result = newGodotVariant()
  gdnInterface.variant_new_nil(result.nativePtr());


proc Variant*(nativePtr: GDNativeVariantPtr): GodotVariant =
  result = newGodotVariant()
  gdnInterface.variant_new_copy(result.nativePtr(), nativePtr)


proc Variant*(other: GodotVariant): GodotVariant =
  result = newGodotVariant()
  gdnInterface.variant_new_copy(result.nativePtr(), other.nativePtr())


proc Variant*(other: sink GodotVariant): GodotVariant =
  result = newGodotVariant()
  swap(result, other)


proc Variant*(v: bool): GodotVariant =
  result = newGodotVariant()
  var b: GDNativeBool
  encode(v, cast[ptr bool](addr b))
  fromTypeConstructor[BOOL](result.nativePtr(), addr b)


proc Variant*(v: Vector2): GodotVariant =
  result = newGodotVariant()
  fromTypeConstructor[VECTOR2](result.nativePtr(), v.nativePtr())


