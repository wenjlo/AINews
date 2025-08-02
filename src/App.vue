<template>
  <div id="app">
    <h1>AI 新聞摘要</h1>
    <NewsCards />
  </div>
</template>

<script>
import NewsCards from './components/NewsCard.vue';

export default {
  name: 'App',
  components: {
    NewsCards,
  },
};
</script>

<style>
/* 全域樣式 */
body {
  font-family: Arial, sans-serif;
  background-color: #f4f4f9;
  margin: 0;
}
h1 {
  text-align: center;
  margin-top: 20px;
}
</style>