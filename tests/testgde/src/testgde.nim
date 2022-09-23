import gdextension_nim as godot
include gdextension_nim/includes
include gdextension_nim/preludes


proc initializeModule(lvl: ModuleInitializationLevel): void =
  echo "My GDExtension initializing, level = " & $lvl
  # var v = Variant(Vec2(10,2))
  # GD.print(v)
  # GD.print(Variant(true))
  if lvl == ModuleInitializationLevel.milEditor:
    errPrintError("exampleLibraryInit", "testgde.nim", "Test warning", "A test warning", 23, true)
    errPrintError("exampleLibraryInit", "testgde.nim", "Test error", "A test error", 23, false)
  

proc deInitializeModule(lvl: ModuleInitializationLevel): void =
  echo "My GDExtension deinitializing, level = " & $lvl
  # GD.print(Variant(false))


proc exampleLibraryInit(pInterface: ptr GDNativeInterface, pLibrary: GDNativeExtensionClassLibraryPtr, rInitialization: ptr GDNativeInitialization): GDNativeBool {.gdnExport.} =
  godot.init(
    args = (pInterface, pLibrary, rInitialization),
    callbacks = (initializeModule, deInitializeModule)
  )
  #* these works fine :)
  # errPrintError("exampleLibraryInit", "testgde.nim", "Test warning", "A test warning", 23, true)
  # errPrintError("exampleLibraryInit", "testgde.nim", "Test error", "A test error", 23, false)
  return 1

