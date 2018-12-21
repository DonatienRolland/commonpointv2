import 'mapbox-gl/dist/mapbox-gl.css'
import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';
import 'mapbox-gl/dist/mapbox-gl.css'
// ADD THIS LINE 👇 (styling)
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'
// ADD THIS LINE 👇 (js)
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

if (mapElement) { // only build a map if there's a div#map to inject into
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10',
    center: [2.333333, 48.866667],
    zoom: 13
  });

  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken
  }));

  const markers = JSON.parse(mapElement.dataset.markers);
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .addTo(map);
  })
  if (markers.length === 0) {r
    map.setZoom(1);
  } else if (markers.length === 1) {
    map.setZoom(14);
    map.setCenter([markers[0].lng, markers[0].lat]);
  } else {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
    });
    map.fitBounds(bounds, { duration: 0, padding: 75 })
  }

  const addressInput = document.getElementById('evenement_address');
  if (addressInput) {
    var input = mapElement.getElementsByTagName('input')[0]
    input.value = addressInput.value
    input.addEventListener('change', function (){
      addressInput.value = input.value
    })
  }
}


