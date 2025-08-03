# 第一階段: 編譯 Vue 應用
# 使用一個包含 Node.js 的映像檔來構建專案
FROM node:20-alpine AS build

# 設定工作目錄
WORKDIR /app

# 將 package.json 和 package-lock.json 複製到工作目錄中
# 這樣做可以利用 Docker 快取，如果依賴沒有變動，就不需要重新安裝
COPY package*.json ./

# 安裝依賴
RUN npm install

# 將所有專案檔案複製到工作目錄
COPY . .

# 運行建置命令，生成靜態檔案到 dist 目錄
RUN npm run build


# 第二階段: 建立輕量級的 Web 伺服器映像檔
# 使用一個輕量級的 Web 伺服器，這裡推薦 Nginx
FROM nginx:stable-alpine

# 將第一階段產生的靜態檔案複製到 Nginx 的網頁根目錄
COPY --from=build /app/dist /usr/share/nginx/html

# 暴露 Nginx 預設的 80 port
EXPOSE 80

# 啟動 Nginx 伺服器
CMD ["nginx", "-g", "daemon off;"]