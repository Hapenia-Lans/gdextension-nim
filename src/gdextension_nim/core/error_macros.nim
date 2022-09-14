import ../internal
import std/strformat


proc errPrintError*(pFunction, pFile, pError, pMessage: cstring, pLine: int32, pIsWarning: bool): void =
  if pIsWarning:
    gdnInterface.print_warning(pMessage, pFunction, pFile, pLine)
  else:
    gdnInterface.print_error(pMessage, pFunction, pFile, pLine)


proc errPrintError*(pFunction, pFile, pError: cstring, pLine: int32, pIsWarning: bool): void =
  errPrintError(
    pFunction = pFunction,
    pFile = pFile,
    pLine = pLine,
    #* INFO: From `godot-cpp`: errPrintError only output pMessage so swapped.
    pError = "", 
    pMessage = pError,
    pIsWarning = pIsWarning
  )


proc errPrintError*(pFunction, pFile: cstring, pLine: int32, pError: cstring, pIsWarning: bool): void =
  errPrintError(
    pFunction = pFunction,
    pFile = pFile,
    pLine = pLine,
    pError = "",
    pMessage = pError,
    pIsWarning = pIsWarning
  )


proc errPrintIndexError*(pFunction, pFile, pIndexStr, pSizeStr: cstring, pMessage: string, pLine: int32, pIndex, pSize: int64, fatal: bool) =
  let str = block:
    var res = fmt"Index {pIndexStr} = {pIndex} is out of bounds ({pSizeStr} = {pSize})."
    if fatal: "FATAL: " & res
    else: res
  errPrintError(
    pFunction = pFunction,
    pFile = pFile,
    pLine = pLine,
    pMessage = cstring(str),
    pError = pMessage,
    pIsWarning = false
  )
  # let str = "Index " & $pIndexStr & " = " & $pIndex & " is out of bounds ("


template ERR_FAIL_INDEX*(mIndex, mSize: int64) =
  if mIndex < 0 or mIndex >= mSize:
    errPrintIndexError(
      pFunction = FUNCTION_STR,
      pFile = FILE,
      pLine = LINE,
      pIndex = mIndex,
      pSize = mSize,
      pIndexStr = $mIndex,
      pSizeStr = $mSize,
      pFatal = false
    )

# TODO: Append other err templates
