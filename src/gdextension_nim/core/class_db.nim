import ../wrapped_header/gdnative_interface

type
  MethodDefinition* = object
    name: string
    args: seq[string]
  PropertySetget* = object
    index: int
    setter, getter: string
    

var current_level: GDNativeInitializationLevel


