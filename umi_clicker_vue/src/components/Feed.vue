

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
          label="うみうみの想いを共有しよう！！"
          solo
          :rules="[rules.required]"
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
                <v-flex xs2 text-xs-right class="grey--text">{{comment.relative_str}}</v-flex>
              </v-layout>
            </v-card-title>
            <v-card-text class="headline">{{comment.message}}</v-card-text>
          </v-card>

        </v-timeline-item>
      </v-slide-x-transition>
    </v-timeline>
    
    <v-snackbar top v-model="snackbar.show" :color="snackbar.color" :timeout="3150">
      {{ snackbar.text }}
      <v-btn dark flat @click="snackbar.show = false">Close</v-btn>
    </v-snackbar>
  </v-container>
</template>

<script>
import { Socket } from "phoenix-socket";
import axios from "axios";

var moment = require("moment");

export default {
  props: ["username"],
  mounted() {
    let socket = new Socket("wss://profuse-outgoing-boubou.gigalixirapp.com/socket");

    // let socket = new Socket("ws://localhost:4000/socket");
    socket.connect();

    this.channel = socket.channel("room:chat", { user: this.username });

    this.channel
      .join()
      .receive("ok", resp => {
        this.comments = resp.timeline;
        console.log("Chat Joined successfully");
      })
      .receive("error", resp => {
        console.log("Chat Unable to join", resp);
      });

    this.channel.on("new_comment_added", payload => {
      console.log("from phoenix UserStream", payload);
      this.comments = payload.timeline;
    });

    this.channel.on("comment_add_success", payload =>{
      this.posting = false;
      this.message = "";
      this.snackbar.show = true;
      this.snackbar.color = "success";
      this.snackbar.text = `コメント送信完了うみ！
      うみうみポイント${payload.point}点獲得！`;
    })
  },
  computed: {
    reversedComments() {
      return this.comments.slice().reverse();
    }
  },
  data() {
    return {
      comments: [],
      message: "",
      snackbar: {
        show: false,
        color: "",
        text: ""
      },
      posting: false,
      rules: {
        length: len => v =>
          (v || "").length >= len ||
          `Invalid character length, required ${len}`,
        required: v => !!v || "空白はダメです。"
      }
    };
  },
  methods: {
    addComment() {
      if (this.message.length == 0) {
        this.snackbar.show = true;
        this.snackbar.color = "error";
        this.snackbar.text = "コメント空欄は送信できません。";
        return;
      }
      let comment = {
        username: this.username,
        message: this.message
      };
      this.posting = true;
      this.channel.push("new_comment", { comment: comment });
    }
  }
};
</script>

<style>
</style>
