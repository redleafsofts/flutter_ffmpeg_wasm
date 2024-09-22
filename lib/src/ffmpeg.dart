/// FFmpeg.wasm for Flutter Web.
@JS('FFmpeg')
library ffmpeg;

import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS()
@anonymous
abstract class CreateFFmpegParam {
  external factory CreateFFmpegParam({
    bool? log,
    String? corePath,
    String? mainName,
  });

  /// Whether Enable or Disable ffmpeg log to console.
  external bool? get log;

  /// Path URL of ffmpeg-core library.
  external String? get corePath;

  /// Main name of ffmpeg-core library function.
  external String? get mainName;
}

@JS()
@staticInterop
abstract class FFmpeg {}

/// A factory function to create ffmpeg instance.
///
/// [CreateFFmpegParam.log] - Whether Enable or Disable ffmpeg log to console.
///
/// [CreateFFmpegParam.corePath] - Path URL of ffmpeg-core library.
///
/// Example :
/// ```dart
/// FFmpeg ffmpeg = createFFmpeg(CreateFFmpegParam(log: true, corePath: 'https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js'));
///```
@JS('createFFmpeg')
external FFmpeg createFFmpeg(CreateFFmpegParam? createFFmpeg);

@JS('fetchFile')
external dynamic _fetchFile(String url);

/// Helper method to fetch the media
Future<Uint8List> fetchFile(String url) {
  return promiseToFuture(_fetchFile(url));
}
