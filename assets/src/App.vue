<template>
  <div id="app">
    <div class="siimple-h2">{{ title }}</div>
    <div class="body">
      <v-text-field v-model="username" label="Name" placeholder="名無し" outline></v-text-field>
      <Button :username="username" />
      <Feed :username="username" />
    </div>
  </div>
</template>

<script>
import Button from "../src/components/Button.vue";
import Feed from "../src/components/Feed.vue";

export default {
  name: "app",
  data() {
    return {
      username: '名無しの海未キチ',
      title: "chat test！！！"
    };
  },
  components: {
    Button,
    Feed
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
}
</style>
