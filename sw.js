/**
 * TAFAZZUL CONSTITUTION - ADVANCED SERVICE WORKER
 * Cache-first strategy for complete offline access and PWABuilder score.
 */

const CACHE_NAME = "tafazzul-constitution-v2";

const ASSETS_TO_CACHE = [
  "./",
  "./index.html",
  "./manifest.json",
  "./icon-192.png",
  "./icon-512.png",
  "./css/style.css",
  "./js/app.js",
  "./js/data/constitution_data.js",
  "./js/data/hindi_translations.js",
  "./js/services/storage.js",
  "./js/services/i18n.js",
  "./js/services/supabase.js",
  "./js/services/db.js",
  "./js/components/navbar.js",
  "./js/components/search.js",
  "./js/components/home.js",
  "./js/components/article-detail.js",
  "./js/components/parts.js",
  "./js/components/articles-list.js",
  "./js/components/preamble.js",
  "./js/components/rights.js",
  "./js/components/duties.js",
  "./js/components/dpsp.js",
  "./js/components/schedules.js",
  "./js/components/amendments.js",
  "./js/components/bookmarks.js",
  "./js/components/recent.js",
  "./js/components/data-manager.js",
  "./js/components/about.js"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }
        })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      if (cachedResponse) {
        return cachedResponse;
      }
      return fetch(event.request).then((networkResponse) => {
        if (!networkResponse || networkResponse.status !== 200 || networkResponse.type !== "basic") {
          return networkResponse;
        }
        const responseToCache = networkResponse.clone();
        caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, responseToCache);
        });
        return networkResponse;
      }).catch(() => {
        // Fallback to index.html for navigation requests when offline
        if (event.request.mode === "navigate") {
          return caches.match("./index.html");
        }
      });
    })
  );
});
