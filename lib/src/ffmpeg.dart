/// FFmpeg.wasm for Flutter Web.
@JS('FFmpeg')
library ffmpeg;

import 'package:js/js.dart';

@JS()
@staticInterop
abstract class FFmpeg {}

/// A factory function to create ffmpeg instance.
///
/// [log] - Whether Enable or Disable ffmpeg log to console.
///
/// [corePath] - Path URL of ffmpeg-core library.
///
/// Example :
/// ```dart
/// FFmpeg ffmpeg = createFFmpeg(true, "https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js");
///```
@JS('createFFmpeg')
@staticInterop
external FFmpeg createFFmpeg(bool? log, String corePath);

/// Fetches file from different source.
///
/// [uri] - URI of a file. Typically Http Url.
/// ```dart
/// Uint8List fetchedFile = await promiseToFuture(fetchFile(FILE_URL));
/// ```
@JS('fetchFile')
@staticInterop
external dynamic fetchFile(String uri);
