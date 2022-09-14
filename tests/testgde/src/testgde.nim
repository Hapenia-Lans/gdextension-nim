import gdextension_nim as godot
import gdextension_nim
include gdextension_nim/includes
include gdextension_nim/preludes
import gdextension_nim/utility_functions as GD


proc initializeModule(lvl: ModuleInitializationLevel): void =
  echo "My GDExtension initializing, level = " & $lvl
  GD.print(Variant(true))
  

proc deInitializeModule(lvl: ModuleInitializationLevel): void =
  echo "My GDExtension deinitializing, level = " & $lvl
  GD.print(Variant(false))


proc exampleLibraryInit(pInterface: ptr GDNativeInterface, pLibrary: GDNativeExtensionClassLibraryPtr, rInitialization: ptr GDNativeInitialization): GDNativeBool {.gdnExport.} =
  godot.init(
    args = (pInterface, pLibrary, rInitialization),
    callbacks = (initializeModule, deInitializeModule)
  )
  return 1

