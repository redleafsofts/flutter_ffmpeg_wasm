# ffmpeg_wasm
ffmpeg.wasm for Flutter web.

## Getting started

Add below src script in `index.html` file's head tag.

```html
<script src='https://unpkg.com/@ffmpeg/ffmpeg@0.11.6/dist/ffmpeg.min.js'></script>
```

To run
```shell
flutter run -d chrome --web-browser-flag "--enable-features=SharedArrayBuffer"
```

While deploying add these headers.

```shell
Cross-Origin-Embedder-Policy: require-corp
Cross-Origin-Opener-Policy: same-origin
```

For Firebase Hosting add below in `firebase.json`

```json
{
  "hosting": {
    "headers": [ {
      "key": "Cross-Origin-Embedder-Policy",
      "value": "require-corp"
    }, {
      "key": "Cross-Origin-Opener-Policy",
      "value": "same-origin"
    } ]
  }
}
```

## Usage

Supported Browsers - https://caniuse.com/sharedarraybuffer

Before accessing any method first need to `createFFmpeg` and `load()`