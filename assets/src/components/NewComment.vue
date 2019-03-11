<template>
  <div>
    <v-input v-model="form.username" />  
    <v-textarea
      auto-grow
      counter
      v-model="form.body"
      hide-details
      flat
      label="Leave a comment..."
      solo
      @keydown.enter="addComment"
    >
      <template slot="append">
        <v-btn class="mx-0" depressed @click="addComment">Post</v-btn>
      </template>
    </v-textarea>
  </div>
</template>

<script>
import { Socket } from "phoenix-socket";

export default {
  mounted() {
    // Connect to the websocket server
    let socket = new Socket("ws://localhost:4000/socket");
    socket.connect();
    // Join in the links channel
    this.channel = socket.channel("room:chat", {});
    this.channel
      .join()
      .receive("ok", resp => {
        console.log("NewLink Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("NewLink Unable to join", resp);
      });
  },
  data() {
    return {
      form: {
        username: "",
        body: ""
      }
    };
  },
  methods: {
    addComment() {
      let comment = {
        username: this.form.username,
        body: this.form.body
      };
      this.channel.push("new_comment", { comment: comment });
    }
  }
};
</script>

<style>
</style>
