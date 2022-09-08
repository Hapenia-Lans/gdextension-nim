import gdextension_nim


proc initializeExampleModule*(pLevel: ModuleInitializationLevel) =
  if pLevel != milScene:
    return
    # classDb.registerClass[Example]()


proc uninitializeExampleModule*(pLevel: ModuleInitializationLevel) =
  if pLevel != milScene:
    return
  # classDb.unRegisterClass[Example]()

