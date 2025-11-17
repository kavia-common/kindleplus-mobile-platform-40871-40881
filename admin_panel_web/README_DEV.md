# admin_panel_web — Web Dev Speed Tips

This guide summarizes quick commands and flags to speed up Flutter Web development and build times for the admin panel.

## 1) One‑time setup / refresh
- Ensure web support is enabled:
  - flutter config --enable-web
- Precache web artifacts (reduces first-run latency):
  - flutter precache --web

## 2) Fastest dev loop (Chrome + HTML renderer)
HTML renderer typically starts faster and hot-reloads quicker.

- flutter run -d chrome --web-renderer=html

Tips:
- Close other Chrome instances or use Incognito to reduce extension overhead.
- If you see slow rebuilds, try a quick cache refresh:
  - flutter clean && flutter pub get

## 3) CanvasKit performance (with CDN)
Use CanvasKit for heavier UIs/charts if you need better rendering consistency. Load CanvasKit from a CDN to speed startup:

- Development (CanvasKit + CDN):
  - flutter run -d chrome --web-renderer=canvaskit \
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://unpkg.com/canvaskit-wasm@latest/bin/

- Production (CanvasKit + CDN):
  - flutter build web --release --web-renderer=canvaskit --web-resources-cdn \
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://unpkg.com/canvaskit-wasm@latest/bin/

Notes:
- --web-resources-cdn tells Flutter to reference some web resources from a CDN when possible.
- You can pin a specific CanvasKit version by replacing `latest` with a known version (e.g., 0.39.1).

## 4) Release build profiles
- Smallest build / broadest compatibility (HTML renderer):
  - flutter build web --release --web-renderer=html

- WASM control (if your Flutter/Dart SDK exposes the flag):
  - Prefer JS (dart2js) for compatibility over wasm:
    - flutter build web --release --web-renderer=html --no-wasm
  - Prefer wasm (if your environment benefits from it):
    - flutter build web --release --web-renderer=canvaskit --wasm

(Flags `--wasm`/`--no-wasm` availability can vary by Flutter/Dart version. If unsupported, omit them.)

## 5) Misc tips
- To reduce source-map overhead in production:
  - flutter build web --release --web-renderer=html --no-source-maps
- Rebuild only when dependencies change:
  - Keep pubspec.yaml lean; avoid mobile-only packages for web.

## 6) Why sqflite was removed
`sqflite` is Android/iOS only and not used by this web admin panel. Removing it reduces plugin graph resolution and avoids unnecessary mobile plugins during dependency resolution for web.
