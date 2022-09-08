# This is just an example to get you started. A typical library package
# exports the main API in this file. Note that you cannot rename this file
# but you can remove it if you wish.

import gdextension_nim/godot
import gdextension_nim/variant/variant
include gdextension_nim/includes

export gdnative_interface
export godot
export variant


# --------------------------------- EXPORT C --------------------------------- #


proc initializeLevel(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.gdnExport.}=
  godot.initializeLevel(userdata, pLevel)


proc deInitializeLevel(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.gdnExport.}=
  godot.deInitializeLevel(userdata, pLevel)

