import wrapped_header/gdnative_interface

var
  minimumInitializationLevel*: GDNativeInitializationLevel
  gdnInterface*: ptr GDNativeInterface
  library*: GDNativeExtensionClassLibraryPtr
  initialization*: ptr GDNativeInitialization
  internalToken*: pointer = nil