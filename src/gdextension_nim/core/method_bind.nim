import ../wrapped_header/gdnative_interface
import variant


type MethodBind* = object
  name: string
  instanceClass: string
  argCount: int
  hintFlags: uint32
  isStatic, isConst, hasReturn, isVararg: bool
  argNames: seq[string]
  argTypes: ptr GDNativeVariantType
  defaultArguments: seq[GodotVariant]


