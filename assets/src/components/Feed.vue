

<template>
  <v-container style="max-width: 600px;">
    <v-timeline dense clipped>
      <v-timeline-item fill-dot class="white--text mb-5" color="orange" large>
        <span slot="icon">Input</span>
        <v-textarea
          auto-grow
          counter
          v-model="message"
          hide-details
          label="Leave a comment..."
          solo
          @keydown.enter="addComment"
        >
          <template slot="append">
            <v-btn class="mx-0" depressed @click="addComment">Post</v-btn>
          </template>
        </v-textarea>
      </v-timeline-item>

      <v-slide-x-transition group>
        <v-timeline-item
          v-for="comment in reversedComments"
          :key="comment.time"
          class="mb-3"
          color="blue"
          small
        >
          <v-card>
            <v-card-title class="lighten-2">
              <v-layout>
                <v-flex text-xs-left class="font-weight-light">@{{comment.username}}</v-flex>
                <v-flex xs2 text-xs-right class="grey--text" >{{comment.relative_str}}</v-flex>
              </v-layout>
            </v-card-title>
            <v-card-text class="headline">{{comment.message}}</v-card-text>
          </v-card>

          <!-- <v-layout justify-space-between>
            <div class="caption">@{{comment.username}}</div>
            <v-flex xs7 v-text="comment.message"></v-flex>
            <v-flex xs5 text-xs-right v-text="comment.relative_str"></v-flex>
          </v-layout>-->
        </v-timeline-item>
      </v-slide-x-transition>
    </v-timeline>
  </v-container>
</template>

<script>
import { Socket } from "phoenix-socket";
import axios from 'axios';

import NewComment from "../components/NewComment.vue";
var moment = require("moment");

export default {
  components: {
    NewComment
  },
  props: ["username"],
  mounted() {
    let socket = new Socket("ws://localhost:4000/socket");
    socket.connect();

    this.channel = socket.channel("room:chat", {});

    this.channel
      .join()
      .receive("ok", resp => {
        console.log("Chat Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("Chat Unable to join", resp);
      });

    this.channel.on("new_comment_added", payload => {
      console.log("from phoenix", payload);
      this.comments = payload.timeline;
    });

  },
  computed: {
    reversedComments() {
      return this.comments.slice().reverse();
    }
  },
  data() {
    return {
      comments: [],
      message: ""
    };
  },
  methods: {
    fetch(){
        axios.get()
    },
    addComment() {
      let comment = {
        username: this.username,
        message: this.message
      };
      this.channel.push("new_comment", { comment: comment });
    }
  }
};
</script>

<style>
</style>
