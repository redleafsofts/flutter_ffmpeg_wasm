/// FFmpeg.wasm for Flutter Web.
library ffmpeg;

class FFmpeg {}

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
FFmpeg createFFmpeg(bool? log, String corePath) =>
    throw UnsupportedError('createFFmpeg not supported on this platform');

/// Fetches file from different source.
///
/// [uri] - URI of a file. Typically Http Url.
/// ```dart
/// Uint8List fetchedFile = await promiseToFuture(fetchFile(FILE_URL));
/// ```
dynamic fetchFile(String uri) =>
    throw UnsupportedError('fetchFile not supported on this platform');
