/**
 * CONSTITUTION OF INDIA - SERVICE WORKER
 * Cache-first offline strategy ensuring 100% offline availability of constitutional data.
 */

const CACHE_NAME = "indian-constitution-v1";
const ASSETS_TO_CACHE = [
  "./",
  "./index.html",
  "./css/style.css",
  "./js/data/constitution_data.js",
  "./js/data/hindi_translations.js",
  "./js/services/storage.js",
  "./js/services/db.js",
  "./js/components/navbar.js",
  "./js/components/search.js",
  "./js/components/article-detail.js",
  "./js/components/preamble.js",
  "./js/components/parts.js",
  "./js/components/articles-list.js",
  "./js/components/schedules.js",
  "./js/components/rights.js",
  "./js/components/duties.js",
  "./js/components/dpsp.js",
  "./js/components/amendments.js",
  "./js/components/bookmarks.js",
  "./js/components/recent.js",
  "./js/components/data-manager.js",
  "./js/components/about.js",
  "./js/components/home.js",
  "./js/app.js",
  "./manifest.json"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
  self.skipWaiting();
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(name => {
          if (name !== CACHE_NAME) {
            return caches.delete(name);
          }
        })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});
