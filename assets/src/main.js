import Vue from 'vue'
import App from './App.vue'

import Vuetify from 'vuetify'

Vue.use(Vuetify)
import 'vuetify/dist/vuetify.min.css'

Vue.config.productionTip = false

// let socket = new Socket("ws://localhost:4000/socket");
//     socket.connect();

new Vue({
  render: h => h(App),
}).$mount('#app')
