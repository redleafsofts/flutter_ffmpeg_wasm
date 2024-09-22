## 1.0.3
- Added single thread wasm implementation. - PR#23

## 1.0.2
- Bump dependencies - js
- Added example to create gif - PR#11

## 1.0.1
- Updated Repo Link.

## 1.0.0

- Thanks to maRci002
- Breaking Changes.
- Refactored API to use `Future` instead of `promiseToFuture` calls
- `createFFmpeg` now uses `CreateFFmpegParam`
- `ffmpeg.run` now handles `List<String>`
- `ffmpeg.runCommand` added to use one-liner command
- `ffmpeg.setProgress` now requires `ProgressParam` callback
- `ffmpeg.setLogger` now requires `LoggerParam` callback
- `ffmpeg.unlink` added to free up memory
- `ffmpeg.readDir` to read files which are handled by ffmpeg
- Updated documentation
- Updated example

## 0.0.1

- Initial Release.