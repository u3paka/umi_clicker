<template>
  <v-carousel height="400"
      max="100">
    <v-carousel-item
      v-for="(item,i) in items"
      :key="i"
      :src="item.src"
      reverse-transition="fade"
      transition="fade"
    ></v-carousel-item>
  </v-carousel>
</template>

<script>
export default {
    data(){
        return{
            items: [
                { src: 'https://pbs.twimg.com/profile_images/1105385952858370048/cPPgDFC-_400x400.jpg'}
            ]
        }
    }
};
</script>

<style>
</style>
