'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b98616acb29b6ac36b520960dc5b1ddd",
"assets/AssetManifest.bin.json": "06b500f16895e5361720c6725ebf30a7",
"assets/AssetManifest.json": "4d28a582c9e15e8f72c23bb742e92d72",
"assets/assets/fonts/Inter-Bold.ttf": "91e5aee8f44952c0c14475c910c89bb8",
"assets/assets/fonts/Inter-ExtraBold.ttf": "bd9525f1099e9f5845f6aef2956e9fb8",
"assets/assets/fonts/Inter-ExtraLight.ttf": "909744bbb5a7ede41ce522a1507e952c",
"assets/assets/fonts/Inter-Light.ttf": "6ffbefc66468b90d7af1cbe1e9f13430",
"assets/assets/fonts/Inter-Medium.ttf": "5ff1f2a9a78730d7d0c309320ff3c9c7",
"assets/assets/fonts/Inter-Regular.ttf": "515cae74eee4925d56e6ac70c25fc0f6",
"assets/assets/fonts/Inter-SemiBold.ttf": "ec60b23f3405050f546f4765a9e90fec",
"assets/assets/fonts/Inter-Thin.ttf": "35b7cf4cc47ac526b745c7c29d885f60",
"assets/assets/icons/alarm_icon.svg": "edeb6b249696ed1fc23caaa4b198275e",
"assets/assets/icons/arrow_back_icon.svg": "5ed1bd2f40631293c78934accfde5beb",
"assets/assets/icons/bold_icon.svg": "5e4b85b8b00dca5e2b114fb94d7ceef0",
"assets/assets/icons/close_icon.svg": "e7edc7011c036bf27b7212e633bd787f",
"assets/assets/icons/copy_icon.svg": "0eec3472d000e6ccf1aed6be294a7230",
"assets/assets/icons/csv.svg": "7b31bb022d1f247de39dcbf1da65e7fa",
"assets/assets/icons/highlight_icon.svg": "5765dd0c3abf84c5ca25d901b7e4f7a3",
"assets/assets/icons/pause_icon.svg": "532ce2f0cb48a02ab466abc33b1a6d12",
"assets/assets/icons/pdf.svg": "5294e31e1e0914a7d41c857023086542",
"assets/assets/icons/play_icon.svg": "ac98e984dad4222def23f8c5b392793c",
"assets/assets/icons/translate_icon.svg": "759456e330e85843e2de31a119c41175",
"assets/assets/icons/underline_icon.svg": "6ea5e7c558deca07dce889745fe62f8b",
"assets/assets/images/logo.png": "b96dd6d6b7776fc07fcdc4ef9b19341f",
"assets/assets/images/logo_1x.svg": "5701b7558ea6262b1fb4a2f8a3667ad6",
"assets/assets/images/logo_bg.png": "d1e2a7c642d4ea3481b730fe2ccb55b3",
"assets/FontManifest.json": "534f3ef8c5f3ce4147e85d2ced563506",
"assets/fonts/MaterialIcons-Regular.otf": "0c536188371fa90e6abbc8e71b06338e",
"assets/NOTICES": "79b957621adeec8f07a0d05d60380533",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "825e75415ebd366b740bb49659d7a5c6",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_sound/assets/js/async_processor.js": "1665e1cb34d59d2769956d2f14290274",
"assets/packages/flutter_sound/assets/js/tau_web.js": "32cc693445f561133647b10d1b97ca07",
"assets/packages/flutter_sound_web/howler/howler.js": "3030c6101d2f8078546711db0d1a24e9",
"assets/packages/flutter_sound_web/src/flutter_sound.js": "3c26fcc60917c4cbaa6a30a231f7d4d8",
"assets/packages/flutter_sound_web/src/flutter_sound_player.js": "b14f8d190230d77c02ffc51ce962ce80",
"assets/packages/flutter_sound_web/src/flutter_sound_recorder.js": "0ec45f8c46d7ddb18691714c0c7348c8",
"assets/packages/flutter_sound_web/src/flutter_sound_stream_processor.js": "48d52b8f36a769ea0e90cf9e58eddfa7",
"assets/packages/quill_native_bridge_linux/assets/xclip": "d37b0dbbc8341839cde83d351f96279e",
"assets/packages/record_web/assets/js/record.fixwebmduration.js": "1f0108ea80c8951ba702ced40cf8cdce",
"assets/packages/record_web/assets/js/record.worklet.js": "356bcfeddb8a625e3e2ba43ddf1cc13e",
"assets/packages/syncfusion_flutter_datepicker/assets/fonts/Roboto-Medium.ttf": "7d752fb726f5ece291e2e522fcecf86d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"favicon.png": "193d57e89bd74733fcba40c7944dc24a",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "42f75b4d5806bcb6d466554f1b7a082f",
"icons/Icon-192.png": "2d795b80842dc4afbf6440b71ed556b7",
"icons/Icon-512.png": "0fc4a90c5b82a794e7fe75ce833ba158",
"icons/Icon-maskable-192.png": "2d795b80842dc4afbf6440b71ed556b7",
"icons/Icon-maskable-512.png": "0fc4a90c5b82a794e7fe75ce833ba158",
"index.html": "275cfb680aed0d091d12c4038d3e7c3c",
"/": "275cfb680aed0d091d12c4038d3e7c3c",
"logo_1x.svg": "5701b7558ea6262b1fb4a2f8a3667ad6",
"main.dart.js": "536f8ca432b2339acd483159fb633f18",
"manifest.json": "428d5b6173c77f028fcd37477be785d4",
"version.json": "5a780bdfdd8117f7ebdd77b27d460e3a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
