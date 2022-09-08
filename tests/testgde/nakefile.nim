import nake;
import strformat;

const
  GodotProjectPath = "../testproj"
  GeneratedBinDirName = "bin"
  Entry = "src/testgde"


task "gen", "generate binding":
  #todo: add bindgen
  discard

task "build", "compile your nim extension into dynamic library.":
  # discard execShellCmd fmt"nim c {Entry} --mm:orc --app:lib -o:" & GodotProjectPath/DynlibName
  shell fmt"nim c --mm:orc --app:lib --outdir:{GodotProjectPath/GeneratedBinDirName} {Entry}"
