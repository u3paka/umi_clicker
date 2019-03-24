<template>
  <div id="app">
    <v-app>
      <v-toolbar app color="indigo" dark>
        <v-toolbar-title>海未誕2019</v-toolbar-title>
        <v-spacer></v-spacer>
        <a href="https://twitter.com/u3paka">作者@u3paka</a>
      </v-toolbar>

      <v-content>
        <v-container fluid>
          <v-parallax dark src="https://profuse-outgoing-boubou.gigalixirapp.com/img/happyCake.jpg">
            <div class="body">
              <h1>海未ちゃん！誕生日おめでとう！</h1>
            </div>
          </v-parallax>


          <router-view></router-view>
        </v-container>
      </v-content>
    </v-app>
  </div>
</template>

<script>

export default {
  name: "app",
  data() {
    return {
      username: '名無しの海未キチ'
    };
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
  background-image : 'https://pbs.twimg.com/media/D1qn2kdUcAAxULQ.jpg:large'
}
</style>
