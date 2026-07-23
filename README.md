# ☕ CoffeeWallet2 - 超商記杯與取杯紀錄系統

一個極簡、質感深色玻璃擬態 (Dark Glassmorphic) 的單頁 Web 應用程式 (SPA)，專為超商/咖啡館「預購記杯與每日領取」設計。

支援部署於 **GitHub Pages**，並以 **Supabase PostgreSQL** 為後端資料庫，透過 **URL 金鑰 (`?key=...`)** 確保您的記杯隱私與存取權限。

---

## 🌟 核心特色

1. **超商記杯卡片管理**：顯示總預購數、已領取數與剩餘杯數進度條（預設包含：大杯美式 15 杯、特大美式 25 杯、大杯特選美式 23 杯）。
2. **⚡ 一鍵快速扣杯 (-1)**：早上取杯時手機點一下立刻扣減。
3. **🔢 多杯扣除 & 門市備註**：幫同事/朋友一次拿 2 杯以上時，可快選數量並輸入門市名稱。
4. **✨ 動態新增品項與加購**：隨時新增全新咖啡品項（如「特大拿鐵 30 杯」）或針對舊品項加購。
5. **🔒 URL 金鑰驗證 (Master Key)**：網址帶有 `?key=YOUR_SECRET` 才能解鎖存取，無金鑰或錯誤金鑰自動阻擋。
6. **📜 取杯歷程時間軸**：記錄每次取杯的時間、數量與備註，支援誤觸復原。

---

## 🚀 Supabase 設定步驟 (只需要 2 分鐘)

### 1. 申請與建立專案
1. 前往 [Supabase 官網](https://supabase.com) 註冊並建立一個免費專案（Free Project）。
2. 進入專案後，在左側選單點選 **SQL Editor**。

### 2. 執行資料庫建立腳本
1. 開啟本專案的 `supabase_setup.sql` 檔案並複製全部內容。
2. 貼入 Supabase 的 **SQL Editor** 並點擊 **Run** 執行。
3. 執行成功後會自動建立 `coffee_items` 與 `coffee_logs` 兩張表並寫入初始資料。

### 3. 取得 API Key
1. 在 Supabase 左側選單點選 **Project Settings** -> **API**。
2. 複製以下兩個值：
   * **Project URL**（例如：`https://xxxx.supabase.co`）
   * **anon public Key**（一長串 `eyJhbG...`）

---

## 🌐 部署至 GitHub Pages 步驟

1. 在 GitHub 上建立一個新的公開儲存庫（Repository），命名為 `CoffeeWallet2`。
2. 將本專案的所有檔案（`index.html` 等）推送到 GitHub `main` 分支。
3. 進入 GitHub Repository 的 **Settings** -> **Pages**。
4. 在 **Build and deployment** 中，Source 選擇 **Deploy from a branch**，Branch 選擇 `main` / `/(root)`，點擊 **Save**。
5. 數分鐘後即可取得您的專屬網址，例如：
   `https://<YOUR_GITHUB_USERNAME>.github.io/CoffeeWallet2/`

---

## 🔑 開始使用與存取網址

開啟網頁時，請在網址後方加上您設定的 Master Key 參數（預設為 `coffee123`）：

```text
https://<YOUR_GITHUB_USERNAME>.github.io/CoffeeWallet2/?key=coffee123
```

首次載入時，點擊右上方 **⚙️ 設定** 圖示，填入您的 `Supabase URL` 與 `Supabase Anon Key` 即可開始使用！
