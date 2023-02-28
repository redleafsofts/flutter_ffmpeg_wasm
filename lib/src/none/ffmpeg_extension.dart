import '../../ffmpeg_wasm.dart';

extension FFmpegExtension on FFmpeg {
  /// Load FFmpeg core wasm module. Call this only once.
  dynamic load() =>
      throw UnsupportedError('load not supported on this platform');

  /// API to check where the core is loaded.
  bool isLoaded() =>
      throw UnsupportedError('isLoaded not supported on this platform');

  dynamic convertVideo(String a, String b, String c, String d, String e,
          String f, String g, String h, String i) =>
      throw UnsupportedError('convertVideo not supported on this platform');

  dynamic createThumb(String a, String b, String c, String d, String e,
          String f, String g, String h, String i) =>
      throw UnsupportedError('createThumb not supported on this platform');

  /// e.g. To create preview gif
  ///
  /// ```dart
  /// ffmpeg.run("-i", "test.mp4", '-t', '2.5', '-ss', '2.0', '-f', 'gif', "thumb.gif")
  /// ```
  dynamic createPreview(String a, String b, String c, String d, String e,
          String f, String g, String h, String i) =>
      throw UnsupportedError('createPreview not supported on this platform');

  dynamic writeFile(String method, String fileName, dynamic data) =>
      throw UnsupportedError('writeFile not supported on this platform');

  dynamic readFile(String method, String fileName) =>
      throw UnsupportedError('readFile not supported on this platform');

  void exit() => throw UnsupportedError('exit not supported on this platform');

  void setProgress() =>
      throw UnsupportedError('setProgress not supported on this platform');
  void setLogger() =>
      throw UnsupportedError('setLogger not supported on this platform');
  void setLogging() =>
      throw UnsupportedError('setLogging not supported on this platform');
}

extension FFmpegRunExtension on FFmpeg {
  dynamic run1(String a) =>
      throw UnsupportedError('run1 not supported on this platform');
  dynamic run2(String a, String b) =>
      throw UnsupportedError('run2 not supported on this platform');
  dynamic run3(String a, String b, String c) =>
      throw UnsupportedError('run3 not supported on this platform');
  dynamic run4(String a, String b, String c, String d) =>
      throw UnsupportedError('run4 not supported on this platform');
  dynamic run5(String a, String b, String c, String d, String e) =>
      throw UnsupportedError('run5 not supported on this platform');
  dynamic run6(String a, String b, String c, String d, String e, String f) =>
      throw UnsupportedError('run6 not supported on this platform');
  dynamic run7(String a, String b, String c, String d, String e, String f,
          String g) =>
      throw UnsupportedError('run7 not supported on this platform');
  dynamic run8(String a, String b, String c, String d, String e, String f,
          String g, String h) =>
      throw UnsupportedError('run8 not supported on this platform');
  dynamic run9(String a, String b, String c, String d, String e, String f,
          String g, String h, String i) =>
      throw UnsupportedError('run9 not supported on this platform');
  dynamic run10(String a, String b, String c, String d, String e, String f,
          String g, String h, String i, String j) =>
      throw UnsupportedError('run10 not supported on this platform');
  dynamic run11(String a, String b, String c, String d, String e, String f,
          String g, String h, String i, String j, String k) =>
      throw UnsupportedError('run11 not supported on this platform');
  dynamic run12(String a, String b, String c, String d, String e, String f,
          String g, String h, String i, String j, String k, String l) =>
      throw UnsupportedError('run12 not supported on this platform');
  dynamic run13(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m) =>
      throw UnsupportedError('run13 not supported on this platform');
  dynamic run14(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n) =>
      throw UnsupportedError('run14 not supported on this platform');
  dynamic run15(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o) =>
      throw UnsupportedError('run15 not supported on this platform');
  dynamic run16(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p) =>
      throw UnsupportedError('run16 not supported on this platform');
  dynamic run17(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q) =>
      throw UnsupportedError('run17 not supported on this platform');
  dynamic run18(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r) =>
      throw UnsupportedError('run18 not supported on this platform');
  dynamic run19(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s) =>
      throw UnsupportedError('run19 not supported on this platform');
  dynamic run20(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t) =>
      throw UnsupportedError('run20 not supported on this platform');
  dynamic run21(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u) =>
      throw UnsupportedError('run21 not supported on this platform');
  dynamic run22(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v) =>
      throw UnsupportedError('run22 not supported on this platform');
  dynamic run23(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w) =>
      throw UnsupportedError('run23 not supported on this platform');
  dynamic run24(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x) =>
      throw UnsupportedError('run24 not supported on this platform');
  dynamic run25(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y) =>
      throw UnsupportedError('run25 not supported on this platform');
  dynamic run26(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z) =>
      throw UnsupportedError('run26 not supported on this platform');
  dynamic run27(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa) =>
      throw UnsupportedError('run27 not supported on this platform');
  dynamic run28(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa,
          String ab) =>
      throw UnsupportedError('run28 not supported on this platform');
  dynamic run29(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa,
          String ab,
          String ac) =>
      throw UnsupportedError('run29 not supported on this platform');
  dynamic run30(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa,
          String ab,
          String ac,
          String ad) =>
      throw UnsupportedError('run30 not supported on this platform');
  dynamic run31(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa,
          String ab,
          String ac,
          String ad,
          String ae) =>
      throw UnsupportedError('run31 not supported on this platform');
  dynamic run32(
          String a,
          String b,
          String c,
          String d,
          String e,
          String f,
          String g,
          String h,
          String i,
          String j,
          String k,
          String l,
          String m,
          String n,
          String o,
          String p,
          String q,
          String r,
          String s,
          String t,
          String u,
          String v,
          String w,
          String x,
          String y,
          String z,
          String aa,
          String ab,
          String ac,
          String ad,
          String ae,
          String af) =>
      throw UnsupportedError('run32 not supported on this platform');
}
