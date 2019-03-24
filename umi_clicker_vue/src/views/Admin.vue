<template>
  <v-container>
    <v-card>
      <v-textarea solo name="input-7-4" label="Json" value="{}" v-model="form"></v-textarea>
      <v-card-actions>
        <v-btn @click="postRestore">Restoreする</v-btn>
      </v-card-actions>
    </v-card>
    <v-spacer></v-spacer>
    <v-card>
      {{dump}}
      <v-card-actions>
        <v-btn @click="getDump">Dumpする</v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      dump: {},
      form: ""
    };
  },
  methods: {
    getDump() {
      axios.get("http://profuse-outgoing-boubou.gigalixirapp.com/datastore/dump").then(v => {
        this.dump = v.data;
      });
    },
    postRestore() {
      console.log(this.form);
      axios
        .post("http://profuse-outgoing-boubou.gigalixirapp.com/datastore/restore", { data: this.form })
        .then(v => {
          console.log(v);
        });
    }
  }
};
</script>

<style>
</style>
