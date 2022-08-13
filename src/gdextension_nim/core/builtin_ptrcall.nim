import ../wrapped_header/gdnative_interface
import sequtils, sugar


when not defined(GODOT_NIM_BUILTIN_PTRCALL):
    const GODOT_NIM_BUILTIN_PTRCALL* = true


template callBuiltinConstructor*[C](constructor: GDNativePtrConstructor, base: GDNativeTypePtr, args: varargs[typed]): untyped =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => addr x))
    constructor(base, addr call_args[0])


template callBuiltinMethodPtrRet*[T](met: GDNativePtrBuiltInMethod, base: GDNativeTypePtr, args: varargs[typed]): T =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => addr x))
    met(base, addr call_args, addr result, args.len())


template callBuiltinMethodPtrNoRet*(met: GDNativePtrBuiltinMethod, base: GDNativeTypePtr, args: varargs[typed]): void =
    var call_args: array[GDNativeTypePtr, args.len()] = array(a.map(x => addr x))
    met(base, addr call_args[0], nil, args.len())


template callBuiltinOperatorPtr*[T](op: GDNativePtrOperatorEvaluator, left: GDNativeTypePtr, right: GDNativeTypePtr): T =
    op(left, right, addr result)


template callBuiltinPtrGetter*[T](getter: GDNativePtrGetter, base: GDNativeTypePtr): T =
    getter(base, addr result)


