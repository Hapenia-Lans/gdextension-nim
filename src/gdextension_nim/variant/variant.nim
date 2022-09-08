
import ../internal
import ../wrapped_header/gdnative_interface

type
  Type* = enum
    NIL = 0,

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


type Variant* = ref object of RootObj
  opaque: array[24, byte]


var fromTypeConstructor: array[VARIANT_MAX, GDNativeVariantFromTypeConstructorFunc]
var toTypeConstructor: array[VARIANT_MAX, GDNativeTypeFromVariantConstructorFunc]


proc initBindings*(): void =
  # for i in 0..<ord(VARIANT_MAX):
  #   fromTypeConstructor[i] = gdnInterface.get_variant_from_type_constructor(cast[GDNativeVariantType](i))
  for i in Type:
    fromTypeConstructor[i] = gdnInterface.get_variant_from_type_constructor(cast[GDNativeVariantType](ord i))
    echo "binding ", i
    toTypeConstructor[i] = gdnInterface.get_variant_to_type_constructor(cast[GDNativeVariantType](ord i))

proc nativePtr*(self: Variant): auto {.inline.} = unsafeAddr self.opaque


proc variant*(v: cstring): Variant =
  result = new Variant
  fromTypeConstructor[STRING](result.nativePtr(), unsafeAddr v)