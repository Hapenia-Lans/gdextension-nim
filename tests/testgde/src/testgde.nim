import gdextension_nim/godot as godot
import gdextension_nim
include gdextension_nim/includes
include gdextension_nim/preludes


import modules/main_mod as m

# ------------------------------ EXPORT CDYNLIB ------------------------------ #

proc exampleLibraryInit*(pInterface: ptr GDNativeInterface, pLibrary: GDNativeExtensionClassLibraryPtr, rInitialization: ptr GDNativeInitialization): GDNativeBool {.gdnExport.} =
  
  godot.registerInitializer(m.initializeExampleModule)
  godot.registerTerminator(m.uninitializeExampleModule)
  godot.setMinimumLibraryInitializationLevel(ModuleInitializationLevel.milCore)
  result = godot.init(pInterface, pLibrary, rInitialization)
  
