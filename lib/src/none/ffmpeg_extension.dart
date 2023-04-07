import 'dart:typed_data';

import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';

abstract class ProgressParam {
  double get ratio;
  double? get time;
}

abstract class LoggerParam {
  String get type;
  String get message;
}

extension FFmpegExtension on FFmpeg {
  Future<void> load() =>
      throw UnsupportedError('load not supported on this platform');

  bool isLoaded() =>
      throw UnsupportedError('isLoaded not supported on this platform');

  void writeFile(String fileName, Uint8List data) =>
      throw UnsupportedError('writeFile not supported on this platform');

  Uint8List readFile(String fileName) =>
      throw UnsupportedError('readFile not supported on this platform');

  void unlink(String fileName) =>
      throw UnsupportedError('unlink not supported on this platform');

  List<String> readDir(String path) =>
      throw UnsupportedError('readDir not supported on this platform');

  void exit() => throw UnsupportedError('exit not supported on this platform');

  void setProgress(void Function(ProgressParam progress) callback) =>
      throw UnsupportedError('setProgress not supported on this platform');

  void setLogger(void Function(LoggerParam logger) callback) =>
      throw UnsupportedError('setLogger not supported on this platform');

  void setLogging(bool logging) =>
      throw UnsupportedError('setLogging not supported on this platform');

  Future<void> runCommand(String command) =>
      throw UnsupportedError('runCommand not supported on this platform');

  Future<void> run(List<String> command) =>
      throw UnsupportedError('run not supported on this platform');
}
