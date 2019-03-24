<template>
  <div>
    <h2>現在の海未ちゃん数：{{rounded_sum}}</h2>
    <h3>あなたの貢献：{{rounded_usersum}}</h3>

    <v-btn class="mx-0" depressed @click="addClick">うみみ！！</v-btn>
  </div>
</template>

<script>
import { Socket } from "phoenix-socket";
export default {
  props: ["username"],
  mounted() {
    let socket = new Socket("wss://profuse-outgoing-boubou.gigalixirapp.com/socket");

    // let socket = new Socket("ws://localhost:4000/socket");

    socket.connect();

    this.channel = socket.channel("room:chat", {user: this.username});

    this.channel
      .join()
      .receive("ok", resp => {
        this.sum = resp.fav.sum
        this.user_sum = resp.fav.user_sum
        console.log("KVS Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("KVS Unable to join", resp);
      });

    this.channel.on("new_click_added", payload => {
      console.log("from phoenix KVS", payload);

      this.sum = payload.sum;
      this.user_sum = payload.user_sum;
    });
  },
  computed: {
    rounded_sum() {
      return Math.round(this.sum * 10) / 10;
    },
    rounded_usersum() {
      return Math.round(this.user_sum * 10) / 10;
    }
  },
  data() {
    return {
      sum: 0,
      user_sum: 0
    };
  },
  methods: {
    addClick() {
      this.channel.push("new_click", { user: this.username, count: 3.15 });
    },
    explosion() {
      this.channel.push("explosion", { user: this.username });
    }
  }
};
</script>

<style>
</style>
