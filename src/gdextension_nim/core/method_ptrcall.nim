import ../wrapped_header/gdnative_interface


template MAKE_PTRARG(t: typedesc): untyped =

  proc convert*(pPtr: pointer): t =
    result = cast[ptr t](pPtr)[]

  proc encode*(pVal: t, pPtr: pointer): void =
    cast[ptr t](pPtr)[] = pVal


MAKE_PTRARG(bool)