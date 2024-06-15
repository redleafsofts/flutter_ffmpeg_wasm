import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:typed_data';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  late Future<List<Uint8List>> dashFramesFuture;

  @override
  void initState() {
    dashFramesFuture = _genDashFrames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
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
              Image.network(
                "https://images.pexels.com/photos/276267/pexels-photo-276267.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                height: 96,
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                width: 500,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                  future: dashFramesFuture,
                  builder: (ctx,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (ctx,index){
                          return Container(
                            height: 100,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Image.memory(snapshot.data![index]),
                          );
                        },
                        separatorBuilder: (ctx,index){
                          return const SizedBox(width: 8,);
                        },
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: isLoaded ?  ()=>createGif() : null, child: const Text('Create Gif from frames'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkLoaded,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    progress.dispose();
    statistics.dispose();
    super.dispose();
  }

  Future<void> loadFFmpeg() async {
    ffmpeg = createFFmpeg(
      CreateFFmpegParam(
        log: true,
        corePath: "https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js",
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


  /// It will create gif from png frames
  Future<void> createGif() async {

    for (int i = 0; i <= 43; i++) {
      final ByteData data = await rootBundle.load(i < 10 ? 'flutter_dash_frames/flutter_dash_00$i.png' : 'flutter_dash_frames/flutter_dash_0$i.png');
      final file = data.buffer.asUint8List();
      ffmpeg.writeFile(i < 10 ? 'flutter_dash_00$i.png' : 'flutter_dash_0$i.png', file);
    }

    await ffmpeg.run([
      '-framerate',
      '30',
      '-i',
      'flutter_dash_%03d.png',
      '-vf',
      'palettegen',
      'palette.png',
    ]);
    await ffmpeg.run([
      '-framerate',
      '30',
      '-i',
      'flutter_dash_%03d.png',
      '-i',
      'palette.png',
      '-filter_complex',
      '[0:v][1:v]paletteuse',
      'flutter_dash.gif',
    ]);
    final previewWebpData = ffmpeg.readFile('flutter_dash.gif');
    js.context.callMethod('webSaveAs', [
      html.Blob([previewWebpData]),
      'flutter_dash.gif'
    ]);
  }

  ///It will generate List of frames to show in ui
  Future<List<Uint8List>> _genDashFrames()async{
    List<Uint8List> frames = [];
    for (int i = 0; i <= 43; i++) {
      final ByteData data = await rootBundle.load(i < 10 ? 'flutter_dash_frames/flutter_dash_00$i.png' : 'flutter_dash_frames/flutter_dash_0$i.png');
      final image = data.buffer.asUint8List();
      frames.add(image);
    }
    return frames;
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
