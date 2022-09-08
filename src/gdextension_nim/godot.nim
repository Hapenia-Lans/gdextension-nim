
import wrapped_header/gdnative_interface
import internal
import variant/variant as variant

export gdnative_interface


type
  ModuleInitializationLevel* = enum
    milCore = GDNATIVE_INITIALIZATION_CORE,
    milServers = GDNATIVE_INITIALIZATION_SERVERS,
    milScene = GDNATIVE_INITIALIZATION_SCENE,
    milEditor = GDNATIVE_INITIALIZATION_EDITOR,
  
  Callback* = proc(p_level: ModuleInitializationLevel): void


var initCallback: Callback
var terminateCallback: Callback

proc initializeLevel*(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.cdecl.} =
  # TODO: Finish this
  # classDb.currentLevel = pLevel
  let cb = initCallback
  if not cb.isNil():
    cb(cast[ModuleInitializationLevel](pLevel)) 
  

proc deinitializeLevel*(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.cdecl.} =
  # TODO: Finish this
  # classDb.currentLevel = pLevel
  # classDb.deinitialize(pLevel)
  let cb = terminateCallback
  if not cb.isNil():
    cb(cast[ModuleInitializationLevel](pLevel))


proc init*(pInterface: ptr GDNativeInterface, pLibrary: GDNativeExtensionClassLibraryPtr, rInitialization: ptr GDNativeInitialization): GDNativeBool =
  gdnInterface = pInterface
  library = pLibrary
  internalToken = pLibrary

  rInitialization.initialize = initializeLevel
  rInitialization.deinitialize = deinitializeLevel
  rInitialization.minimum_initialization_level = minimumInitializationLevel

  assert(initCallback != nil, "Initialization callback must be defined.")

  # TODO: Finish this
  variant.init_bindings()

  result = 0


proc registerInitializer*(pInit: Callback): void =
  initCallback = pInit


proc registerTerminator*(pTerminate: Callback): void =
  terminateCallback = pTerminate


proc setMinimumLibraryInitializationLevel*(pLevel: ModuleInitializationLevel): void =
  minimumInitializationLevel = cast[GDNativeInitializationLevel](pLevel)



