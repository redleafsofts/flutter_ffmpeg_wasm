import 'package:ffmpeg_wasm/src/ffmpeg.dart';
import 'package:js/js.dart';

extension FFmpegExtension on FFmpeg {
  /// Load FFmpeg core wasm module. Call this only once.
  ///
  /// Typically the load() func might take few seconds to minutes to complete, better to do it as early as possible.
  @JS('load')
  external dynamic load();

  /// API to check where the core is loaded.
  @JS('isLoaded')
  external bool isLoaded();

  /// e.g. To create preview gif
  ///
  /// ```dart
  /// ffmpeg.run("-i", "test.mp4", '-t', '2.5', '-ss', '2.0', '-f', 'gif', "thumb.gif")
  /// ```
  ///
  @JS('run')
  external dynamic createPreview(String a, String b, String c, String d,
      String e, String f, String g, String h, String i);

  /// Write file to In-Memory File System (MEMFS).
  @JS('FS')
  external dynamic writeFile(String method, String fileName, dynamic data);

  /// Read file from MEMFS.
  @JS('FS')
  external dynamic readFile(String method, String fileName);

  /// Kill the execution of the program, also remove MEMFS to free memory
  @JS('exit')
  external void exit();

  @JS('setProgress')
  external void setProgress();

  @JS('setLogger')
  external void setLogger();

  @JS('setLogging')
  external void setLogging();
}

/// FFmpeg's run method extension.
///
/// Since there's no support for varargs in dart here we created multiple functions.
extension FFmpegRunExtension on FFmpeg {

  /// run with 1 argument
  @JS('run')
  external dynamic run1(String a);

  /// run with 2 arguments
  @JS('run')
  external dynamic run2(String a, String b);

  /// run with 3 arguments
  @JS('run')
  external dynamic run3(String a, String b, String c);

  /// run with 4 arguments
  @JS('run')
  external dynamic run4(String a, String b, String c, String d);

  /// run with 5 arguments
  @JS('run')
  external dynamic run5(String a, String b, String c, String d, String e);

  /// run with 6 arguments
  @JS('run')
  external dynamic run6(
      String a, String b, String c, String d, String e, String f);

  /// run with 7 arguments
  @JS('run')
  external dynamic run7(
      String a, String b, String c, String d, String e, String f, String g);

  /// run with 8 arguments
  @JS('run')
  external dynamic run8(String a, String b, String c, String d, String e,
      String f, String g, String h);

  /// run with 9 arguments
  @JS('run')
  external dynamic run9(String a, String b, String c, String d, String e,
      String f, String g, String h, String i);

  /// run with 10 arguments
  @JS('run')
  external dynamic run10(String a, String b, String c, String d, String e,
      String f, String g, String h, String i, String j);

  /// run with 11 arguments
  @JS('run')
  external dynamic run11(String a, String b, String c, String d, String e,
      String f, String g, String h, String i, String j, String k);

  /// run with 12 arguments
  @JS('run')
  external dynamic run12(String a, String b, String c, String d, String e,
      String f, String g, String h, String i, String j, String k, String l);

  /// run with 13 arguments
  @JS('run')
  external dynamic run13(
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
      String m);

  /// run with 14 arguments
  @JS('run')
  external dynamic run14(
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
      String n);

  /// run with 15 arguments
  @JS('run')
  external dynamic run15(
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
      String o);

  /// run with 16 arguments
  @JS('run')
  external dynamic run16(
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
      String p);

  /// run with 17 arguments
  @JS('run')
  external dynamic run17(
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
      String q);

  /// run with 18 arguments
  @JS('run')
  external dynamic run18(
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
      String r);

  /// run with 19 arguments
  @JS('run')
  external dynamic run19(
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
      String s);

  /// run with 20 arguments
  @JS('run')
  external dynamic run20(
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
      String t);

  /// run with 21 arguments
  @JS('run')
  external dynamic run21(
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
      String u);

  /// run with 22 arguments
  @JS('run')
  external dynamic run22(
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
      String v);

  /// run with 23 arguments
  @JS('run')
  external dynamic run23(
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
      String w);

  /// run with 24 arguments
  @JS('run')
  external dynamic run24(
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
      String x);

  /// run with 25 arguments
  @JS('run')
  external dynamic run25(
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
      String y);

  /// run with 26 arguments
  @JS('run')
  external dynamic run26(
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
      String z);

  /// run with 27 arguments
  @JS('run')
  external dynamic run27(
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
      String aa);

  /// run with 28 arguments
  @JS('run')
  external dynamic run28(
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
      String ab);

  /// run with 29 arguments
  @JS('run')
  external dynamic run29(
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
      String ac);

  /// run with 30 arguments
  @JS('run')
  external dynamic run30(
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
      String ad);

  /// run with 31 arguments
  @JS('run')
  external dynamic run31(
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
      String ae);

  /// run with 32 arguments
  @JS('run')
  external dynamic run32(
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
      String af);
}
