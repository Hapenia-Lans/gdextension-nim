import godot
import internal
import variant/variant

proc printInternal*(args: openArray[ptr Variant], argCount: int) =
  #* This for debug only. Should be generated automatically.
  let fun = gdnInterface.variant_get_ptr_utility_function("print", 2648703342);
  # CHECK_METHOD_BIND(fun)
  var ret: GDNativeTypePtr
  let parg: GDNativeTypePtr = unsafeAddr args
  fun(ret, unsafeAddr parg, cint(argCount))
