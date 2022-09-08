import gdextension_nim/godot as godot
include gdextension_nim/includes

import modules/main_mod as m

# ------------------------------ EXPORT CDYNLIB ------------------------------ #

proc exampleLibraryInit*(pInterface: ptr GDNativeInterface, pLibrary: GDNativeExtensionClassLibraryPtr, rInitialization: ptr GDNativeInitialization): GDNativeBool {.gdnExport.} =
  godot.registerInitializer(m.initializeExampleModule)
  godot.registerTerminator(m.uninitializeExampleModule)
  godot.setMinimumLibraryInitializationLevel(ModuleInitializationLevel.milCore)
  result = godot.init(pInterface, pLibrary, rInitialization)
