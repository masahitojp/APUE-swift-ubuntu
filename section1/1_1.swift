import Glibc

let argc = Process.argc

if(argc != 2) {
  print("usage: ls directory_name")
} else {
  let dir_name = Process.arguments[1]
  let dp = opendir(dir_name)
  if dp != nil {
      var entry = readdir(dp)
      while entry != nil {
          var d_name = entry.memory.d_name
          let name = withUnsafePointer(&d_name) {
              String.fromCString(UnsafePointer($0))!
          }
          print("\(name)")
          entry = readdir(dp)
      }
      closedir(dp)
  } else {
    print("can't open \(dir_name)")
  }
}
