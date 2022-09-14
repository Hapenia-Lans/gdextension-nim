
import wrapped_header/gdnative_interface
import internal
import core/variant as variant
include includes

export gdnative_interface
export variant


type
  ModuleInitializationLevel* = enum
    milCore = GDNATIVE_INITIALIZATION_CORE,
    milServers = GDNATIVE_INITIALIZATION_SERVERS,
    milScene = GDNATIVE_INITIALIZATION_SCENE,
    milEditor = GDNATIVE_INITIALIZATION_EDITOR,
  
  Callback* = proc(lvl: ModuleInitializationLevel): void {.nimcall.}

  InitCallbacks* = tuple
    initializeCallback, deinitializeCallback: Callback
  
  InitArguments* = tuple
    pInterface: ptr GDNativeInterface
    pLibrary: GDNativeExtensionClassLibraryPtr
    rInitialization: ptr GDNativeInitialization


type GDNativeIntializeDefect* = object of Defect


var g: InitCallbacks



proc initializeLevel(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.gdnExport.} =
  let cb = g.initializeCallback
  if not cb.isNil():
    cb cast[ModuleInitializationLevel](pLevel)


proc deinitializeLevel(userdata: pointer, pLevel: GDNativeInitializationLevel): void {.gdnExport.} =
  let cb = g.deinitializeCallback
  if not cb.isNil():
    cb cast[ModuleInitializationLevel](pLevel)


proc init*(args: InitArguments, callbacks: InitCallbacks): void =
  (gdnInterface, library, token) = args
  args.rInitialization.initialize = initializeLevel
  args.rInitialization.deinitialize = deinitializeLevel
  args.rInitialization.minimum_initialization_level = minimumInitializationLevel
  g = callbacks
  
  #* init all things here
  variant.initBindings()


proc setMinimumLibraryInitializationLevel*(pLevel: ModuleInitializationLevel): void =
  minimumInitializationLevel = cast[GDNativeInitializationLevel](pLevel)

