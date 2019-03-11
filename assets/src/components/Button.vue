<template>
  <div>
    <h2>{{sum}}</h2>
    <v-btn class="mx-0" depressed @click="addClick">Umi!</v-btn>
    <v-btn class="mx-0" depressed @click="explosion">緊急停止ボタン</v-btn>
  </div>
</template>

<script>
import { Socket } from "phoenix-socket";
export default {
  props: ["username"],
  mounted() {
    let socket = new Socket("ws://localhost:4000/socket");
    socket.connect();

    this.channel = socket.channel("room:chat", {});

    this.channel
      .join()
      .receive("ok", resp => {
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
  data() {
    return {
      sum: 0,
      user_sum: 0
    };
  },
  methods: {
    addClick() {
      this.channel.push("new_click", { user: this.username, count: 1 });
    },
    explosion() {
      this.channel.push("explosion", { user: this.username });
    }
  }
};
</script>

<style>
</style>
