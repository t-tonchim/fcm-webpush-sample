self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});

self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});

self.addEventListener('push', function(event) {
  console.log('Push message received', event);
  console.log(event.data.json())
  const { data } = event.data.json();
  const { message, tag, url } = data;

  event.waitUntil(
    self.registration.showNotification('Push event Received', {
      body: message,
      tag,
      data: { url }
    })
  );

  console.log(message);
});

self.addEventListener("notificationclick", function(event) {
  const { url } = event.notification.data
  clients.openWindow(url)
  event.notification.close();
}, false);
