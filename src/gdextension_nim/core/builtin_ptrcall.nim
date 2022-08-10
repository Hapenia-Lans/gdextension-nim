import ../wrapped_header/gdnative_interface
import sequtils, sugar

when not defined(GODOT_NIM_BUILTIN_PTRCALL):
    const GODOT_NIM_BUILTIN_PTRCALL* = 0


template callBuiltinConstructor*[C](constructor: GDNativePtrConstructor, base: GDNativeTypePtr, args: varargs[typed]): untyped =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => ptr x))
    constructor(base, ptr call_args[0])


template callBuiltinMethodPtrRet*[T](met: GDNativePtrBuiltInMethod, base: GDNativeTypePtr, args: varargs[typed]): T =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => ptr x))
    met(base, ptr call_args, ptr result, args.len())


template callBuiltinMethodPtrNoRet*(met: GDNativePtrBuiltinMethod, base: GDNativeTypePtr, args: varargs[typed]): void =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => ptr x))
    met(base, ptr call_args[0], nil, args.len())


template callBuiltinOperatorPtr*[T](op: GDNativePtrOperatorEvaluator, left: GDNativeTypePtr, right: GDNativeTypePtr): T =
    op(left, right, ptr result)


template callBuiltinPtrGetter*[T](getter: GDNativePtrGetter, base: GDNativeTypePtr): T =
    getter(base, ptr result)
