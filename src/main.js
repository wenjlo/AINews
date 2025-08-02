// import { createApp } from 'vue'
// import App from './App.vue'

// createApp(App).mount('#app')

// main.js
import { createApp } from 'vue';
import App from './App.vue';
import 'vuetify/styles'; // 引入 Vuetify 的樣式
import { createVuetify } from 'vuetify';
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';

const vuetify = createVuetify({
  components,
  directives,
});

createApp(App).use(vuetify).mount('#app');