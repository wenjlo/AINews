<template>
  <div class="news-cards-container">
    <div v-for="card in newsCards" :key="card.id" class="news-card">
      <img :src="card.image" :alt="card.title" class="card-image" />
      <div class="card-content">
        <h3 class="card-title">{{ card.title }}</h3>
        <p class="card-description">{{ card.description }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NewsCards',
  data() {
    return {
      // 建立 4x4 共 16 筆新聞卡片資料
      newsCards: [
        { id: 1, title: '新聞標題 1', description: '這是第一則新聞的簡短描述，內容精彩。', image: 'https://cdn2.ettoday.net/images/8221/d8221047.jpg' },
        { id: 2, title: '新聞標題 2', description: '第二則新聞的描述，帶給你最新資訊。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+2' },
        { id: 3, title: '新聞標題 3', description: '這則新聞內容豐富，值得一讀。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+3' },
        { id: 4, title: '新聞標題 4', description: '第四則新聞的重點整理，快速了解。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+4' },
        { id: 5, title: '新聞標題 5', description: '這是第五則新聞的簡短描述。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+5' },
        { id: 6, title: '新聞標題 6', description: '第六則新聞的最新進展。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+6' },
        { id: 7, title: '新聞標題 7', description: '第七則新聞的深度解析。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+7' },
        { id: 8, title: '新聞標題 8', description: '第八則新聞的獨家報導。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+8' },
        { id: 9, title: '新聞標題 9', description: '第九則新聞的簡短描述。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+9' },
        { id: 10, title: '新聞標題 10', description: '第十則新聞的內容更新。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+10' },
        { id: 11, title: '新聞標題 11', description: '第十一則新聞的摘要。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+11' },
        { id: 12, title: '新聞標題 12', description: '第十二則新聞的重點。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+12' },
        { id: 13, title: '新聞標題 13', description: '第十三則新聞的簡短描述。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+13' },
        { id: 14, title: '新聞標題 14', description: '第十四則新聞的深度報導。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+14' },
        { id: 15, title: '新聞標題 15', description: '第十五則新聞的最新消息。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+15' },
        { id: 16, title: '新聞標題 16', description: '第十六則新聞的最終結論。', image: 'https://via.placeholder.com/400x250/1976D2/FFFFFF?text=News+16' },
      ],
    };
  },
};
</script>

<style scoped>
.news-cards-container {
  /* 預設在行動裝置上，卡片垂直排列 */
  display: grid;
  grid-template-columns: repeat(1, 1fr);
  gap: 20px;
  padding: 20px;
  max-width: 1200px; /* 限制最大寬度，讓內容不會太寬 */
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
  object-fit: cover; /* 確保圖片不變形 */
}

.card-content {
  padding: 16px;
  flex-grow: 1; /* 讓內容區塊可以填滿剩餘空間 */
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