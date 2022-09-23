import ../wrapped_header/gdnative_interface

type
  MethodDefinition* {.bycopy.} = object
    name: string
    args: seq[cstring]
  PropertySetget* {.bycopy.} = object
    index: int
    setter, getter: cstring
    

var current_level: GDNativeInitializationLevel


