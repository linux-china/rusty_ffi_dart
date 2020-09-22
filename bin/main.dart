// Import dart:ffi.
import 'dart:ffi' as ffi;

// Utilities for working with ffi like String
import 'package:ffi/ffi.dart';
import 'dart:io';

// Create a typedef with the FFI type signature of the C function.
// Commonly used types defined by dart:ffi library include Double, Int32, NativeFunction, Pointer, Struct, Uint8, and Void.
typedef play_once_func = ffi.Void Function(ffi.Pointer<Utf8>);

// Create a typedef for the variable that you’ll use when calling the C function.
typedef PlayOnce = void Function(ffi.Pointer<Utf8>);

void main() {
  var currentDir = Directory.current.path;
  ffi.DynamicLibrary dylib;
  // Open the dynamic library that contains the C function.
  if (Platform.isMacOS) {
    dylib = ffi.DynamicLibrary.open(
        currentDir + '/target/debug/libplay_once.dylib');
  } else if (Platform.isWindows) {
    dylib =
        ffi.DynamicLibrary.open(currentDir + 'target/debug/libplay_once.dll');
  } else if (Platform.isLinux) {
    dylib =
        ffi.DynamicLibrary.open(currentDir + 'target/debug/libplay_once.so');
  }

  // Get a reference to the C function, and put it into a variable. This code uses the typedefs defined in steps 2 and 3, along with the dynamic library variable from step 4.
  // ignore: omit_local_variable_types
  final PlayOnce play_once = dylib
      .lookup<ffi.NativeFunction<play_once_func>>('play_once')
      .asFunction();

  // Convert a Dart [String] to a Utf8-encoded null-terminated C string.
  // ignore: omit_local_variable_types
  final ffi.Pointer<Utf8> song = Utf8.toUtf8('data/music.mp3').cast();

  // Call the C function.
  play_once(song);
}
