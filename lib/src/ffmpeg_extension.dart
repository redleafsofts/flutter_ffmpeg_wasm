import 'dart:typed_data';

import 'package:ffmpeg_wasm/src/ffmpeg.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
@anonymous
abstract class ProgressParam {
  /// Number between 0 to 1.
  external double get ratio;
  external double? get time;
}

@JS()
@anonymous
abstract class LoggerParam {
  /// info: internal workflow debug messages
  /// fferr: ffmpeg native stderr output
  /// ffout: ffmpeg native stdout output
  external String get type;
  external String get message;
}

extension FFmpegExtension on FFmpeg {
  @JS('load')
  external dynamic _load();

  /// Load FFmpeg core wasm module. Call this only once.
  ///
  /// Typically the load() func might take few seconds to minutes to complete, better to do it as early as possible.
  Future<void> load() {
    return promiseToFuture(_load());
  }

  /// API to check where the core is loaded.
  @JS('isLoaded')
  external bool isLoaded();

  @JS('FS')
  external void _writeFile(String method, String fileName, Uint8List data);

  /// Write file to In-Memory File System (MEMFS).
  void writeFile(String fileName, Uint8List data) {
    _writeFile('writeFile', fileName, data);
  }

  @JS('FS')
  external Uint8List _readFile(String method, String fileName);

  /// Read file from MEMFS.
  Uint8List readFile(String fileName) {
    return _readFile('readFile', fileName);
  }

  @JS('FS')
  external void _unlink(String method, String fileName);

  /// Delete a file in MEMFS.
  void unlink(String fileName) {
    _unlink('unlink', fileName);
  }

  @JS('FS')
  external List<dynamic> _readDir(String method, String fileName);

  /// List files inside specific path.
  List<String> readDir(String path) {
    return _readDir('readdir', path).cast<String>();
  }

  /// Kill the execution of the program, also remove MEMFS to free memory
  @JS('exit')
  external void exit();

  @JS('setProgress')
  external void _setProgress(void Function(ProgressParam progress) callback);

  /// Progress handler to get current progress of ffmpeg command.
  void setProgress(void Function(ProgressParam progress) callback) {
    _setProgress(allowInterop(callback));
  }

  @JS('setLogger')
  external void _setLogger(void Function(LoggerParam logger) callback);

  /// Set custom logger to get ffmpeg output messages.
  void setLogger(void Function(LoggerParam logger) callback) {
    _setLogger(allowInterop(callback));
  }

  @JS('setLogging')
  external void setLogging(bool logging);

  /// Run ffmpeg command.
  ///
  /// ```dart
  /// await runCommand('-i flame.avi -s 1920x1080 output.mp4');
  /// ```
  Future<void> runCommand(String command) {
    return run(command.split(' ')..removeWhere((e) => e.isEmpty));
  }

  /// Run ffmpeg command.
  ///
  /// ```dart
  /// await run('-i', 'flame.avi', '-s', '1920x1080', 'output.mp4');
  /// ```
  Future<void> run(List<String> command) {
    return promiseToFuture(callMethod(this, 'run', command));
  }
}
