/// FFmpeg.wasm for Flutter Web.
library ffmpeg;

import 'dart:typed_data';

abstract class CreateFFmpegParam {
  external factory CreateFFmpegParam({
    bool? log,
    String? corePath,
    String? mainName,
  });

  bool? get log;
  String? get corePath;
  String? get mainName;
}

class FFmpeg {}

FFmpeg createFFmpeg(CreateFFmpegParam? createFFmpeg) =>
    throw UnsupportedError('createFFmpeg not supported on this platform');

Future<Uint8List> fetchFile(String uri) =>
    throw UnsupportedError('fetchFile not supported on this platform');
