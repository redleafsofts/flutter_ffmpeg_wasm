import 'dart:html' as html;
import 'dart:js' as js;

import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFmpeg - WASM Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'FFmpeg - WASM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FFmpeg ffmpeg;
  bool isLoaded = false;
  String? selectedFile;
  String? conversionStatus;

  FilePickerResult? filePickerResult;

  final progress = ValueNotifier<double?>(null);
  final statistics = ValueNotifier<String?>(null);

  @override
  void dispose() {
    progress.dispose();
    statistics.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Is FFmpeg loaded $isLoaded and selected $selectedFile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            OutlinedButton(
              onPressed: loadFFmpeg,
              child: const Text('Load FFmpeg'),
            ),
            OutlinedButton(
              onPressed: isLoaded ? pickFile : null,
              child: const Text('Pick File'),
            ),
            OutlinedButton(
              onPressed: selectedFile == null ? null : extractFirstFrame,
              child: const Text('Extract First Frame'),
            ),
            OutlinedButton(
              onPressed: selectedFile == null ? null : createPreviewVideo,
              child: const Text('Create Preview Image'),
            ),
            Text('Conversion Status : $conversionStatus'),
            OutlinedButton(
              onPressed: selectedFile == null ? null : create720PQualityVideo,
              child: const Text('Create 720P Quality Videos'),
            ),
            OutlinedButton(
              onPressed: selectedFile == null ? null : create480PQualityVideo,
              child: const Text('Create 480P Quality Videos'),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: progress,
              builder: (context, value, child) {
                return value == null
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Exporting ${(value * 100).ceil()}%'),
                          const SizedBox(width: 6),
                          const CircularProgressIndicator(),
                        ],
                      );
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: statistics,
              builder: (context, value, child) {
                return value == null
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value),
                          const SizedBox(width: 6),
                          const CircularProgressIndicator(),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkLoaded,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> loadFFmpeg() async {
    ffmpeg = createFFmpeg(
      CreateFFmpegParam(
        log: true,
        corePath: 'https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js',
      ),
    );

    ffmpeg.setProgress(_onProgressHandler);
    ffmpeg.setLogger(_onLogHandler);

    await ffmpeg.load();

    checkLoaded();
  }

  void checkLoaded() {
    setState(() {
      isLoaded = ffmpeg.isLoaded();
    });
  }

  Future<void> pickFile() async {
    filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (filePickerResult != null &&
        filePickerResult!.files.single.bytes != null) {
      /// Writes File to memory
      ffmpeg.writeFile('input.mp4', filePickerResult!.files.single.bytes!);

      setState(() {
        selectedFile = filePickerResult!.files.single.name;
      });
    }
  }

  /// Extracts First Frame from video
  Future<void> extractFirstFrame() async {
    await ffmpeg.run([
      '-i',
      'input.mp4',
      '-vf',
      "select='eq(n,0)'",
      '-vsync',
      '0',
      'frame1.webp'
    ]);
    final data = ffmpeg.readFile('frame1.webp');
    js.context.callMethod('webSaveAs', [
      html.Blob([data]),
      'frame1.webp'
    ]);
  }

  /// Creates Preview Image of Video
  Future<void> createPreviewVideo() async {
    await ffmpeg.run([
      '-i',
      'input.mp4',
      '-t',
      '5.0',
      '-ss',
      '2.0',
      '-s',
      '480x720',
      '-f',
      'webp',
      '-r',
      '5',
      'previewWebp.webp'
    ]);
    final previewWebpData = ffmpeg.readFile('previewWebp.webp');
    js.context.callMethod('webSaveAs', [
      html.Blob([previewWebpData]),
      'previewWebp.webp'
    ]);
  }

  Future<void> create720PQualityVideo() async {
    setState(() {
      conversionStatus = 'Started';
    });
    await ffmpeg.run([
      '-i',
      'input.mp4',
      '-s',
      '720x1280',
      '-c:a',
      'copy',
      '720P_output.mp4'
    ]);
    setState(() {
      conversionStatus = 'Saving';
    });
    final hqVideo = ffmpeg.readFile('720P_output.mp4');
    setState(() {
      conversionStatus = 'Downloading';
    });
    js.context.callMethod('webSaveAs', [
      html.Blob([hqVideo]),
      '720P_output.mp4'
    ]);
    setState(() {
      conversionStatus = 'Completed';
    });
  }

  Future<void> create480PQualityVideo() async {
    setState(() {
      conversionStatus = 'Started';
    });
    await ffmpeg.run([
      '-i',
      'input.mp4',
      '-s',
      '480x720',
      '-c:a',
      'copy',
      '480P_output.mp4'
    ]);
    setState(() {
      conversionStatus = 'Saving';
    });
    final hqVideo = ffmpeg.readFile('480P_output.mp4');
    setState(() {
      conversionStatus = 'Downloading';
    });
    js.context.callMethod('webSaveAs', [
      html.Blob([hqVideo]),
      '480P_output.mp4'
    ]);
    setState(() {
      conversionStatus = 'Completed';
    });
  }

  void _onProgressHandler(ProgressParam progress) {
    final isDone = progress.ratio >= 1;

    this.progress.value = isDone ? null : progress.ratio;
    if (isDone) {
      statistics.value = null;
    }
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

        statistics.value =
            'frame: $frame, fps: $fps, q: $q, size: $size, time: $time, bitrate: $bitrate$bitrateUnit, speed: $speed';
      }
    }
  }
}
