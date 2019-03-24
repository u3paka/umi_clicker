<template>
  <div>
    <Button :username="username"/>
    <v-container style="max-width: 400px;" v-bind:style="{ backgroundImage: 'url(' + image + ')' }"><>
      <v-layout>
        <v-flex>
          <v-text-field v-model="username" label="Name" placeholder="名無し"></v-text-field>
        </v-flex>
        <v-flex xs2 text-xs-right>
          <a
            href="https://twitter.com/share?ref_src=twsrc%5Etfw"
            class="twitter-share-button"
            data-size="large"
            data-text="うみうみ♪"
            data-url="https://happybirthday2019.umiumi.net"
            data-hashtags="園田海未生誕祭2019"
            data-lang="ja"
            data-show-count="false"
          >Tweet</a>
        </v-flex>
      </v-layout>
    </v-container>
    <!-- <Carousel></Carousel> -->
    <Feed :username="username"/>
  </div>
</template>

<script>
import Button from "../components/Button.vue";
import Feed from "../components/Feed.vue";
import Carousel from "../components/Carousel.vue";

export default {
  name: "app",
  data() {
    return {
      username: "名無しの海未キチ",
      title: "祝 海未ちゃんの誕生日！！！(工事中)"
    };
  },
  components: {
    Button,
    Feed,
    Carousel
  }
};
</script>

<style>

</style>
