import ../wrapped_header/gdnative_interface
import ../internal as internal
import ../core/variant
import ../core/property_info

type Wrapped = ref object of RootObj
  plist: ptr GDNativePropertyInfo
  plistSize: uint32
  owner*: pointer

method getExtensionClass(self: Wrapped): string {.base.} = ""


method getBindingCallbacks(self: Wrapped): ptr GDNativeInstanceBindingCallbacks {.base.} = nil


method notification(self: Wrapped, pWhat: int): void {.base.} = discard


# proc set(self: Wrapped, pname: StringName, pProperty: GodotVariant): bool = false


# proc get(self: Wrapped, pname: StringName, rProperty: GodotVariant): bool = false


# proc getPropertyList(self: Wrapped, pList: var Seq[PropertyInfo]): void


# proc propertyCanRevert(self: Wrapped, pName: StringName): bool = false


# proc propertyGetRevert(self: Wrapped, pName: StringName, rProperty: GodotVariant): bool = false



method notificationBind(self: Wrapped, pInstance: GDExtensionClassInstancePtr, pWhat: int32): void {.base.} = discard


proc setBind(pInstance: GDExtensionClassInstancePtr, pName: GDNativeStringNamePtr, pValue: GDNativeVariantPtr): GDNativeBool = uint8 false


proc getBind(pInstance: GDExtensionClassInstancePtr, pName: GDNativeStringNamePtr, pValue: GDNativeVariantPtr): GDNativeBool = uint8 false


proc getPropertyListBind(pInstance: GDExtensionClassInstancePtr, rCount: uint32): ptr GDNativePropertyInfo = nil


proc freePropertyListBind(pInstance: GDExtensionClassInstancePtr, pList: ptr GDNativePropertyInfo): void = discard


proc propertyCanRevertBind(pInstance: GDExtensionClassInstancePtr, pList: ptr GDNativePropertyInfo): GDNativeBool = uint8 false


proc propertyGetRevertBind(pInstance: GDExtensionClassInstancePtr, pName: GDNativeStringNamePtr, rRet: GDNativeVariantPtr): GDNativeBool = uint8 false


# proc toStringBind(pInstance: GDExtensionClassInstancePtr, rOut: GDNativeStringPtr): void


method postInitialize(self: Wrapped): void {.base.} =
  let extensionClass = self.getExtensionClass
  if extensionClass != "":
    internal.gdnInterface.object_set_instance(self.owner, extensionClass, addr self[])
    
  internal.gdnInterface.object_set_instance_binding(self.owner, internal.token, addr self[], self.getBindingCallbacks())


proc getClassStatic*(): string = "Wrapped"


proc getInstanceID*(): uint64 = 0


proc allocAndCopyCstr*(pStr: cstring): cstring =
  var size = pStr.len + 1
  result = cast[cstring](alloc(size))
  copyMem(result, pStr, size)


proc toString(self: Wrapped): string = "[" & $get_class_static() & ":" & $getInstanceID() & "]"


proc `$`*(self: Wrapped): string = self.toString()


proc newWrapped*(pGodotClass: cstring): Wrapped =
  result = new Wrapped
  result.owner = internal.gdnInterface.classdb_construct_object(pGodotClass)


# proc newWrapped(pGodotObject: ptr GodotObject): Wrapped =
#   _owner = pGodotObject


# proc postInitializeHandler(self, pWrapped: Wrapped): void =
#   pWrapped.postInitialize()