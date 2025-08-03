<template>
  <div class="news-cards-container">
    <div v-if="loading" class="status-message">
      正在載入新聞資料...
    </div>

    <div v-else-if="error" class="status-message error-message">
      {{ error }}
    </div>

    <template v-else>
      <div v-for="card in newsCards" :key="card.id" class="news-card">
        <img :src="card.image" :alt="card.title" class="card-image" />
        <div class="card-content">
          <h3 class="card-title">{{ card.title }}</h3>
          <!-- <p class="card-description">{{ card.description }}</p> -->
          <div class="description-container">
            <img src="../assets/robot.svg" alt="AI icon" width="20" height="20" class="ai-icon" />{{ card.description }}
          </div>
          <a :href="card.news_url" target="_blank" class="card-link">查看新聞</a>
        </div>
      </div>
      <div v-if="newsCards.length === 0" class="status-message">
        目前沒有新聞可以顯示。
      </div>
    </template>
  </div>
</template>

<script>
import axios from 'axios';
import { API_URL } from '@/utils/config';
export default {
  name: 'NewsCards',
  data() {
    return {
      newsCards: [],
      loading: false,
      error: null,
    };
  },
  methods: {
    async fetchNewsCards() {
      this.loading = true;
      this.error = null;
      try {
        const response = await axios.get(`${API_URL}/api/news`);
        this.newsCards = response.data;
      } catch (error) {
        this.error = '無法載入新聞資料，請稍後再試。';
        console.error('API 呼叫失敗:', error);
      } finally {
        this.loading = false;
      }
    },
  },
  mounted() {
    this.fetchNewsCards();
  },
};
</script>

<style scoped>
.news-cards-container {
  display: grid;
  grid-template-columns: repeat(1, 1fr);
  gap: 20px;
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.news-card {
  background-color: #fff;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  display: flex;
  flex-direction: column;
}

.news-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card-image {
  width: 100%;
  height: auto;
  object-fit: cover;
}

.card-content {
  padding: 16px;
  flex-grow: 1;
}

.card-title {
  margin-top: 0;
  font-size: 1.25rem;
  color: #333;
}

.card-description {
  margin-bottom: 0;
  font-size: 1rem;
  color: #666;
}
.status-message {
  grid-column: 1 / -1;
  text-align: center;
  padding: 40px 20px;
  font-size: 1.2rem;
  color: #666;
}

.error-message {
  color: #d9534f;
  font-weight: bold;
}

/* 在平板電腦上 (600px 以上)，顯示 2 欄 */
@media (min-width: 600px) {
  .news-cards-container {
    grid-template-columns: repeat(2, 1fr);
  }
}

/* 在中型螢幕上 (900px 以上)，顯示 3 欄 */
@media (min-width: 900px) {
  .news-cards-container {
    grid-template-columns: repeat(3, 1fr);
  }
}

/* 在大型螢幕上 (1200px 以上)，顯示 4 欄 */
@media (min-width: 1200px) {
  .news-cards-container {
    grid-template-columns: repeat(4, 1fr);
  }
}
</style>