<template>
  <div class="news-cards-container">
    <div v-if="loading && newsCards.length === 0" class="status-message">
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
          <div class="description-container">
            <img src="../assets/robot.svg" alt="AI icon" width="20" height="20" class="ai-icon" />
            {{ card.description }}
          </div>
          <a :href="card.news_url" target="_blank" class="card-link">查看來源</a>
        </div>
      </div>
      
      <div v-if="newsCards.length === 0" class="status-message">
        目前沒有新聞可以顯示。
      </div>
    </template>

    <div v-if="loading && newsCards.length > 0" class="status-message">
      正在載入更多新聞...
    </div>

    <div v-if="!hasMore && newsCards.length > 0 && !loading" class="status-message">
      已載入所有新聞。
    </div>
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
      page: 1, 
      hasMore: true, 
      apiUrl: `${API_URL}/api/news`,
    };
  },
  methods: {
    async fetchNewsCards() {
      if (this.loading || !this.hasMore) return; 
      
      // 在開始載入前，將 loading 設為 true
      this.loading = true;
      
      // 只有當 newsCards 陣列為空時，才清除之前的錯誤訊息
      if (this.newsCards.length === 0) {
        this.error = null;
      }
      
      try {
        const response = await axios.get(this.apiUrl, {
          params: { page: this.page }
        });
        
        // 根據你提供的後端結構，取得資料和分頁資訊
        const { news, pagination } = response.data.data;
        const newCards = news ? JSON.parse(news) : [];
        
        if (newCards.length > 0) {
          this.newsCards = [...this.newsCards, ...newCards];
          this.page += 1;
          
          // 根據後端回傳的 hasMore 字串，將其轉換為布林值
          this.hasMore = pagination.hasMore == true;

          // 使用 $nextTick 確保 DOM 更新後，再檢查是否需要自動載入更多
          this.$nextTick(() => {
            const bottomOfPage = document.documentElement.offsetHeight;
            const windowHeight = window.innerHeight;
            
            // 如果頁面內容高度小於或等於視窗高度，且還有更多資料，則再次呼叫
            if (bottomOfPage <= windowHeight && this.hasMore) {
              this.fetchNewsCards();
            }
          });
          
        } else {
          this.hasMore = false;
        }

      } catch (error) {
        // 如果是初次載入失敗，才顯示錯誤訊息
        if (this.newsCards.length === 0) {
          this.error = '無法載入新聞資料，請稍後再試。';
        }
        console.error('API 呼叫失敗:', error);
        this.hasMore = false; 
      } finally {
        this.loading = false;
      }
    },
    
    handleScroll() {
      if (!this.hasMore || this.loading) {
        return;
      }
      
      const scrollPosition = window.innerHeight + window.scrollY;
      const bottomOfPage = document.documentElement.offsetHeight;
      
      if (scrollPosition + 100 >= bottomOfPage) {
        this.fetchNewsCards();
      }
    },
  },
  mounted() {
    this.fetchNewsCards();
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
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
    border: 1px solid #ccc;
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

.description-container {
  display: flex;
  align-items: flex-start;
  font-size: 1rem;
  color: #666;
  margin-top: 8px;
  line-height: 1.5;
}

.ai-icon {
  margin-right: 8px;
  flex-shrink: 0;
}

.card-link {
  display: inline-block;
  margin-top: 16px;
  padding: 8px 16px;
  background-color: #007bff;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.3s ease;
}

.card-link:hover {
  background-color: #0056b3;
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

@media (min-width: 600px) {
  .news-cards-container {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 900px) {
  .news-cards-container {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1200px) {
  .news-cards-container {
    grid-template-columns: repeat(4, 1fr);
  }
}
</style>