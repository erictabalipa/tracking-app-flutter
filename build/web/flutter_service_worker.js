'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "aff37e4e23e27569b764da3cc7470eb5",
"index.html": "6be116b81a6d0b6b16cc152721d4780f",
"/": "6be116b81a6d0b6b16cc152721d4780f",
"main.dart.js": "eecd8c786592eb04a42c0f5cd0de8f0b",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "01bb9aec61df5157fa0cde593316b8db",
"assets/AssetManifest.json": "8563b6cb1f38b4f8eee1acbff122a512",
"assets/NOTICES": "cb3538645c74796d1d548cbaf4f9ee9e",
"assets/FontManifest.json": "7cf26a4cdfbf03563ee8f6e2b92a43b6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/grupo-pinho-logo.png": "a6b5a453cabbd410f8eaa6ad73cbd1d6",
"assets/assets/images/sigra-express-logo.png": "d60cb16c11e52bb289ec21c0e3fe31a7",
"assets/assets/images/sigraweb-logo.png": "f6a814341865e70991e417f55eae1356",
"assets/assets/images/login-background.jpeg": "f551fe98dfe0a703cf4a4021cd6ca25c",
"assets/assets/images/iphone-14.jpeg": "84ca66d679cfbd54e8e5b7726190e306",
"assets/assets/images/head-beats.jpeg": "63b8f9e2a58525ac9dfa12ec38c948f2",
"assets/assets/images/profile-test.jpeg": "2b4a60a4ff903b4f7be51fe7b1a816a9",
"assets/assets/images/sigraweb-macos-icon.png": "3a99747d52808acfe823c62e01b23322",
"assets/assets/images/sigraweb-icon.png": "b0c66773e7e03943c27d87f59636eb53",
"assets/assets/fonts/Mulish-LightItalic.ttf": "b0f92221b66f6a89d94a35b4894bd711",
"assets/assets/fonts/Lexend-Regular.ttf": "08de0f5b6a1ce618dcf440deb748a474",
"assets/assets/fonts/Oswald-Bold.ttf": "452bfeb5bf78e71cc3cd6e720ac24bd4",
"assets/assets/fonts/Mulish-ExtraBoldItalic.ttf": "0fd05194939a8d519a3959c060d5c9f2",
"assets/assets/fonts/Mulish-Italic.ttf": "3e6c2d08d53bb71d49a6c954ad99ad1b",
"assets/assets/fonts/Mulish-Regular.ttf": "31423d3904a79ab8fccbad8c31f0c645",
"assets/assets/fonts/Mulish-Black.ttf": "4116253eadb2611951c2085ba73ad636",
"assets/assets/fonts/Oswald-Medium.ttf": "14cf874b374ca47427bbceb4b2373c3a",
"assets/assets/fonts/Mulish-BlackItalic.ttf": "fc91cb43f89445d25fff1ee198265f52",
"assets/assets/fonts/Mulish-SemiBoldItalic.ttf": "0561dfcf7f0119ef58000381ed386575",
"assets/assets/fonts/Mulish-ExtraLightItalic.ttf": "bd34845e05e1b706cb743d17e3036da9",
"assets/assets/fonts/Lexend-ExtraLight.ttf": "ad025b54765095b1128801183e88e891",
"assets/assets/fonts/Mulish-Bold.ttf": "987e18dffd501e760afdbea36a4dbeed",
"assets/assets/fonts/Oswald-Regular.ttf": "a7ccbd3cd9a9ff21ec41086dcc23ebe6",
"assets/assets/fonts/Lexend-Light.ttf": "5ccc760b1df3d024ef4deebe3c83cbc8",
"assets/assets/fonts/Mulish-Light.ttf": "4c3f41a7fb1e614785fa5edda23d7906",
"assets/assets/fonts/Mulish-ExtraBold.ttf": "f4c4920f1de354965565fa1509f5aeae",
"assets/assets/fonts/Mulish-ExtraLight.ttf": "a3fd685c31ee5dce9fce87f7b55a24a0",
"assets/assets/fonts/Mulish-Medium.ttf": "4df899b7abe1a8fc831ac4867d4e6a37",
"assets/assets/fonts/poppins/Poppins-ExtraLight.ttf": "6f8391bbdaeaa540388796c858dfd8ca",
"assets/assets/fonts/poppins/Poppins-ExtraLightItalic.ttf": "a9bed017984a258097841902b696a7a6",
"assets/assets/fonts/poppins/Poppins-BoldItalic.ttf": "19406f767addf00d2ea82cdc9ab104ce",
"assets/assets/fonts/poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/poppins/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/poppins/Poppins-SemiBoldItalic.ttf": "9841f3d906521f7479a5ba70612aa8c8",
"assets/assets/fonts/poppins/Poppins-ExtraBoldItalic.ttf": "8afe4dc13b83b66fec0ea671419954cc",
"assets/assets/fonts/poppins/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/poppins/Poppins-BlackItalic.ttf": "e9c5c588e39d0765d30bcd6594734102",
"assets/assets/fonts/poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/poppins/Poppins-LightItalic.ttf": "0613c488cf7911af70db821bdd05dfc4",
"assets/assets/fonts/poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/poppins/Poppins-Black.ttf": "14d00dab1f6802e787183ecab5cce85e",
"assets/assets/fonts/poppins/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/assets/fonts/poppins/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"assets/assets/fonts/poppins/Poppins-MediumItalic.ttf": "cf5ba39d9ac24652e25df8c291121506",
"assets/assets/fonts/Mulish-MediumItalic.ttf": "7b5ec96749fae1de17999d65424e328c",
"assets/assets/fonts/Mulish-SemiBold.ttf": "922e5ae520dbced208a37bbfd3184b82",
"assets/assets/fonts/Lexend-Medium.ttf": "c4237ab62c1639b308e830d8fff542e8",
"assets/assets/fonts/Mulish-BoldItalic.ttf": "cdf040e31d4b799279d1f1e9cdcaa63f",
"assets/assets/fonts/Oswald-Light.ttf": "6ee38c23e5466cb24e844b1c345d610d",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
