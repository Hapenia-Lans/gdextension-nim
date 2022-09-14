import godot
import internal
import core/variant


proc printInternal(args: varargs[ptr GodotVariantObj], argCount: int) =
  #* This for debug only. Should be generated automatically.
  var fun = gdnInterface.variant_get_ptr_utility_function("print", 2648703342);
  # CHECK_METHOD_BIND(fun)
  var
    ret = Variant()
    pRet = addr ret[]
    pArg = cast[GDNativeTypePtr](args[0])
  fun(
    pRet,
    addr pArg,
    cint(argCount)
    )


proc print*(args: varargs[GodotVariant]): void =
  # TODO: rewrite this using `template`
  var a: seq[ptr GodotVariantObj] = @[]
  for i in args: a.add(unsafeAddr(i[]))
  printInternal(a.toOpenArray(0, a.len()), a.len())