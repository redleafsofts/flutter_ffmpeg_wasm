# ffmpeg_wasm

[`ffmpeg.wasm`](https://github.com/ffmpegwasm/ffmpeg.wasm) for Flutter web.

## Installation

### Development

Add the following src script in the `head` tag of the `index.html` file:

```html
<script src="https://unpkg.com/@ffmpeg/ffmpeg@0.11.6/dist/ffmpeg.min.js" crossorigin="anonymous" async></script>
```

**Run shell**

```shell
flutter run -d chrome --web-browser-flag --enable-features=SharedArrayBuffer
```

**Android Studio**

`Run` -> `Edit Configurations...` -> `Create / edit your Flutter Configuration` -> `Additional run args:`
```shell
--web-browser-flag --enable-features=SharedArrayBuffer
```

**Visual Studio Code**

Create / edit your `launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Example",
      "request": "launch",
      "type": "dart",
      "args": [
        "--web-browser-flag",
        "--enable-features=SharedArrayBuffer"
      ]
    }
  ]
}
```

### Production

Add the following src script in the `head` tag of the `index.html` file:

```html
<script src="https://unpkg.com/@ffmpeg/ffmpeg@0.11.6/dist/ffmpeg.min.js" crossorigin="anonymous" async></script>
```

The document _`index.html`_ should contain these headers:

```shell
Cross-Origin-Embedder-Policy: require-corp
Cross-Origin-Opener-Policy: same-origin
```

**For Firebase Hosting add below in `firebase.json`**

```json
{
  "hosting": {
     "headers": [
        {
          "source": "**",
          "headers": [
            {
              "key": "Cross-Origin-Embedder-Policy",
              "value": "require-corp"
            },
            {
              "key": "Cross-Origin-Opener-Policy",
              "value": "same-origin"
            }
          ]
        }
     ]
  }
}
```

**For Node.js Express**

```js
app.use(express.static(staticDir, {
  setHeaders: (res, filePath) => {
    const fileName = path.basename(filePath);

    if (fileName === 'index.html') {
      res.setHeader('Cross-Origin-Embedder-Policy', 'require-corp');
      res.setHeader('Cross-Origin-Opener-Policy', 'same-origin');
    }
  }
}));
```

**Importing scripts from other domains**

The response should contain the proper `Cross-Origin-Embedder-Policy: require-corp` / `Cross-Origin-Opener-Policy: same-origin` headers, and the client should add `crossorigin="anonymous"` to the script element: `<script src="..." crossorigin="anonymous" async></script>`. Otherwise, you will get the following error:

> GET https://unpkg.com/canvaskit-wasm@0.37.1/bin/canvaskit.js net::ERR_BLOCKED_BY_RESPONSE.NotSameOriginAfterDefaultedToSameOriginByCoep 200

In this case, if you don't own the CDN which provides the script, you should download it and serve it from your own CDN that provides those headers or put it in your static directory.

Since Flutter uses external `canvaskit` source when the app is in production, you should serve your own `canvaskit` (_note: when you are using `--web-renderer html` this is not a problem_):

This is the easiest way to download the `canvaskit` version which is used by flutter and also defines local `canvaskit` path:

```shell
#!/bin/sh
# Download CanvasKit
flutter build web
canvaskitLocation=$(grep canvaskit-wasm build/web/main.dart.js | sed -e 's|.*https|https|' -e 's|/bin.*|/bin/|' | uniq)
echo "Downloading CanvasKit from $canvaskitLocation"
curl -o build/web/canvaskit.js "$canvaskitLocation/canvaskit.js"
curl -o build/web/canvaskit.wasm "$canvaskitLocation/canvaskit.wasm"
# Configure flutter web to use local canvaskit
flutter build web --dart-define=FLUTTER_WEB_CANVASKIT_URL=/
```

_Note_: When importing a script from another domain, it's recommended to use `localhost` origin or `https` protocol. Otherwise, you may encounter the following error:

> The `Cross-Origin-Opener-Policy` header has been ignored, because the origin was untrustworthy. It was defined either in the final response or a redirect. Please deliver the response using the `HTTPS` protocol. You can also use the `'localhost'` origin instead. See https://www.w3.org/TR/powerful-features/#potentially-trustworthy-origin and [https://html.spec.whatwg.org/#the-cross-origin-opener-policy-header.](https://html.spec.whatwg.org/#the-cross-origin-opener-policy-header.%22)

## Usage

Before accessing any methods first need to `createFFmpeg()` and `load()`.

### Create FFmpeg instance

```dart
// Note: CreateFFmpegParam is optional and and corePath is also optional
FFmpeg ffmpeg = createFFmpeg(CreateFFmpegParam(log: true, corePath: 'https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js'));
```

To use a local `corePath`, do the following (in this case, you should provide these resources in your static directory: `ffmpeg.min.js` / `ffmpeg-core.js` / `ffmpeg-core.wasm` / `ffmpeg-core.worker.js`):

```dart
// suppose ffmpeg-core lives under https://myserver.com/ffmpeg/ffmpeg-core.js
final url = Uri.base.resolve('ffmpeg/ffmpeg-core.js').toString();
FFmpeg ffmpeg = createFFmpeg(CreateFFmpegParam(corePath: url));
```

### Use FFmpeg instance

```dart
Future<Uint8List> exportVideo(Uint8List input) async {
  // Note you can always reuse the same ffmpeg instance
  FFmpeg? ffmpeg;
  try {
    ffmpeg = createFFmpeg(CreateFFmpegParam(log: true));
    ffmpeg.setLogger(_onLogHandler);
    ffmpeg.setProgress(_onProgressHandler);

    // Check ffmpeg.isLoaded() before ffmpeg.load() if you are reusing the same instance
    if (!ffmpeg.isLoaded()) {
      await ffmpeg.load();
    }

    const inputFile = 'input.mp4';
    const outputFile = 'output.mp4';

    ffmpeg.writeFile(inputFile, input);

    // Equals to: await ffmpeg.run(['-i', inputFile, '-s', '1920x1080', outputFile]);
    await ffmpeg.runCommand('-i $inputFile -s 1920x1080 $outputFile');

    final data = ffmpeg.readFile(outputFile);
    return data;
  } finally {
    // Do not call exit if you want to reuse same ffmpeg instance
    // When you call exit the temporary files are deleted from MEMFS
    // If you are working with multiple inputs you can free any of the via: ffmpeg.unlink('my_input.mp4')
    ffmpeg?.exit();
  }
}

void _onProgressHandler(ProgressParam progress) {
  print('Progress: ${progress.ratio * 100}%');
}

static final regex = RegExp(
  r'frame\s*=\s*(\d+)\s+fps\s*=\s*(\d+(?:\.\d+)?)\s+q\s*=\s*([\d.-]+)\s+L?size\s*=\s*(\d+)\w*\s+time\s*=\s*([\d:\.]+)\s+bitrate\s*=\s*([\d.]+)\s*(\w+)/s\s+speed\s*=\s*([\d.]+)x',
);

void _onLogHandler(LoggerParam logger) {
  if (logger.type == 'fferr') {
    final match = regex.firstMatch(logger.message);

    if (match != null) {
      // indicates the number of frames that have been processed so far.
      final frame = match.group(1);
      // is the current frame rate
      final fps = match.group(2);
      // stands for quality 0.0 indicating lossless compression, other values indicating that there is some lossy compression happening
      final q = match.group(3);
      // indicates the size of the output file so far
      final size = match.group(4);
      // is the time that has elapsed since the beginning of the conversion
      final time = match.group(5);
      // is the current output bitrate
      final bitrate = match.group(6);
      // for instance: 'kbits/s'
      final bitrateUnit = match.group(7);
      // is the speed at which the conversion is happening, relative to real-time
      final speed = match.group(8);

      print('frame: $frame, fps: $fps, q: $q, size: $size, time: $time, bitrate: $bitrate$bitrateUnit, speed: $speed');
    }
  }
}
```

### Usage with [`video_player`](https://pub.dev/packages/video_player) package

The easiest way is to add a dependency to the [`cross_file`](https://pub.dev/packages/cross_file) package, import it, and then use the `VideoPlayerController.network` constructor to create a controller.

```dart
import 'package:cross_file/cross_file.dart';

final exportBytes = await exportVideo(inputBytes);
final xFile = XFile.fromData(exportBytes);

final controller = VideoPlayerController.network(xFile.path);
```

Supported Browsers - https://caniuse.com/sharedarraybuffer
