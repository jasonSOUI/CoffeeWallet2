# ☕ CoffeeWallet2 - 超商記杯與取杯紀錄系統

一個極簡、質感深色玻璃擬態 (Dark Glassmorphic) 的單頁 Web 應用程式 (SPA)，專為超商/咖啡館「預購記杯與每日領取」設計。

支援部署於 **GitHub Pages**，並以 **Supabase PostgreSQL** 為後端資料庫。

---

## 🌟 核心特色

1. **超商記杯卡片管理**：顯示總預購數、已領取數與剩餘杯數進度條。
2. **⚡ 每日特快取杯專區**：置頂顯示最近使用過且有剩餘數量的熱門品項，單手一鍵極速扣杯 (-1)。
3. **🔢 多杯扣除 & 門市備註**：幫同事/朋友一次拿 2 杯以上時，可快選數量並輸入門市名稱。
4. **✨ 動態新增品項與加購**：隨時新增全新咖啡品項（如「特大拿鐵 30 杯」）或針對舊品項加購。
5. **🔒 Supabase 安全驗證**：透過 Supabase Anon Key 直連後端資料庫，無需繁瑣設定即可安全存取。
6. **📜 取杯歷程時間軸與刪除**：記錄每次取杯的時間、數量與備註；每筆歷程資料均可點擊刪除，並自動同步校正與復原剩餘杯數。

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

## 🔑 開始使用

首次開啟網頁時，點擊右上方 **⚙️ 設定** 圖示（或在初次連線設定畫面），填入您的 `Supabase URL` 與 `Supabase Anon Key` 即可開始使用！

也可以使用包含設定參數的 URL 進行一鍵設定：
```text
https://<YOUR_GITHUB_USERNAME>.github.io/CoffeeWallet2/?setup_url=YOUR_SUPABASE_URL&setup_anon=YOUR_ANON_KEY
```

