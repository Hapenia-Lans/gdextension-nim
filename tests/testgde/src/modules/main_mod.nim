import gdextension_nim
include gdextension_nim/preludes


proc initializeExampleModule*(pLevel: ModuleInitializationLevel) =
  echo("Level: ", $pLevel)
  #! code above does not work.
  return
    # classDb.registerClass[Example]()


proc uninitializeExampleModule*(pLevel: ModuleInitializationLevel) =
  echo("Level: ", $pLevel)
  if pLevel != milScene:
    return
  # classDb.unRegisterClass[Example]()