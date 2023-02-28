/// ffmpeg.wasm for Flutter web.
library ffmpeg_wasm;

export 'src/ffmpeg.dart' if (dart.library.io) 'src/none/ffmpeg.dart';
export 'src/ffmpeg_extension.dart'
    if (dart.library.io) 'src/none/ffmpeg_extension.dart';
