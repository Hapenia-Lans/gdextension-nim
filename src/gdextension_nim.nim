# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import gdextension_nim/wrapped_header/gdnative_interface


proc initialize*(userdata: pointer, p_level: GDNativeInitializationLevel): void {.exportc, dynlib, cdecl.} =
  echo "initializing, level is " & $p_level


proc deinitialize*(userdata: pointer, p_level: GDNativeInitializationLevel): void {.exportc, dynlib, cdecl.} =
  echo "deinitializing, level is " & $p_level


proc gdextension_library_init*(p_interface: ptr GDNativeInterface, p_library: GDNativeExtensionClassLibraryPtr, r_initialization: ptr GDNativeInitialization): GDNativeBool {.exportc, dynlib, cdecl.} =
  r_initialization.minimum_initialization_level = GDNATIVE_INITIALIZATION_CORE
  r_initialization.initialize = initialize
  r_initialization.deinitialize = deinitialize
  result = 1