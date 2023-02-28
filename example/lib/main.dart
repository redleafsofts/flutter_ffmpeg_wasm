import 'package:flutter/material.dart';
import 'dart:js_util';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'FFmpeg - WAsm'),
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
            const Text(
              'FFmpeg flutter web',
            ),
            Text(
              'Is FFmpeg loaded $isLoaded and selected $selectedFile',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            OutlinedButton(
                onPressed: loadFFmpeg, child: const Text("Load FFmpeg")),
            OutlinedButton(
                onPressed: isLoaded ? pickFile : null,
                child: const Text("Pick File")),
            OutlinedButton(
                onPressed: selectedFile == null ? null : extractFirstFrame,
                child: const Text("Extract First Frame")),
            OutlinedButton(
                onPressed: selectedFile == null ? null : createPreviewVideo,
                child: const Text("Create Preview Image")),
            Text("Conversion Status : $conversionStatus"),
            OutlinedButton(
                onPressed: selectedFile == null ? null : create720PQualityVideo,
                child: const Text("Create 720P Quality Videos")),
            OutlinedButton(
                onPressed: selectedFile == null ? null : create480PQualityVideo,
                child: const Text("Create 480P Quality Videos")),
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
        true, "https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js");
    await promiseToFuture(ffmpeg.load());
    checkLoaded();
  }

  void checkLoaded() {
    setState(() {
      isLoaded = ffmpeg.isLoaded();
    });
  }

  void pickFile() async {
    filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (filePickerResult != null &&
        filePickerResult!.files.single.bytes != null) {
      /// Writes File to memory
      ffmpeg.writeFile(
          'writeFile', 'input.mp4', filePickerResult!.files.single.bytes);

      setState(() {
        selectedFile = filePickerResult!.files.single.name;
      });
    }
  }

  /// Extracts First Frame from video
  void extractFirstFrame() async {
    await promiseToFuture(ffmpeg.run7("-i", "input.mp4", '-vf',
        'select=\'eq(n,0)\'', '-vsync', '0', 'frame1.webp'));
    var data = ffmpeg.readFile('readFile', 'frame1.webp');
    js.context.callMethod("webSaveAs", [
      html.Blob([data]),
      "frame1.webp"
    ]);
  }

  /// Creates Preview Image of Video
  void createPreviewVideo() async {
    await promiseToFuture(ffmpeg.run13("-i", "input.mp4", '-t', '5.0', '-ss',
        '2.0', '-s', '480x720', '-f', 'webp', '-r', '5', 'previewWebp.webp'));
    var previewWebpData = ffmpeg.readFile('readFile', 'previewWebp.webp');
    js.context.callMethod("webSaveAs", [
      html.Blob([previewWebpData]),
      "previewWebp.webp"
    ]);
  }

  void create720PQualityVideo() async {
    setState(() {
      conversionStatus = "Started";
    });
    await promiseToFuture(ffmpeg.run7("-i", "input.mp4", '-s', '720x1280',
        '-c:a', 'copy', '720P_output.mp4'));
    setState(() {
      conversionStatus = "Saving";
    });
    var hqVideo = ffmpeg.readFile('readFile', '720P_output.mp4');
    setState(() {
      conversionStatus = "Downloading";
    });
    js.context.callMethod("webSaveAs", [
      html.Blob([hqVideo]),
      "720P_output.mp4"
    ]);
    setState(() {
      conversionStatus = "Completed";
    });
  }

  void create480PQualityVideo() async {
    setState(() {
      conversionStatus = "Started";
    });
    await promiseToFuture(ffmpeg.run7(
        "-i", "input.mp4", '-s', '480x720', '-c:a', 'copy', '480P_output.mp4'));
    setState(() {
      conversionStatus = "Saving";
    });
    var hqVideo = ffmpeg.readFile('readFile', '480P_output.mp4');
    setState(() {
      conversionStatus = "Downloading";
    });
    js.context.callMethod("webSaveAs", [
      html.Blob([hqVideo]),
      "480P_output.mp4"
    ]);
    setState(() {
      conversionStatus = "Completed";
    });
  }
}
