-- ========================================================
-- CoffeeWallet2 Supabase 資料庫初始化腳本
-- 請將此腳本複製到 Supabase Dashboard -> SQL Editor 執行
-- ========================================================

-- 強制設定當前會話為可讀寫 (防止部分 Supabase 池化連接處於唯讀狀態)
SET default_transaction_read_only = off;

-- 1. 建立咖啡品項資料表 (coffee_items)
CREATE TABLE IF NOT EXISTS public.coffee_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    total_purchased INTEGER NOT NULL DEFAULT 0,
    total_redeemed INTEGER NOT NULL DEFAULT 0,
    category TEXT DEFAULT '美式系列',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 建立取杯與加購歷程紀錄表 (coffee_logs)
CREATE TABLE IF NOT EXISTS public.coffee_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    item_id UUID REFERENCES public.coffee_items(id) ON DELETE CASCADE,
    item_name TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('redeem', 'topup', 'create')), -- redeem=取杯, topup=加購, create=新增品項
    quantity INTEGER NOT NULL,
    note TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 啟動 Row Level Security (RLS)
ALTER TABLE public.coffee_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.coffee_logs ENABLE ROW LEVEL SECURITY;

-- 4. 允許 Anon (公開角色) 讀寫 (配合網頁端的 URL 金鑰驗證)
DROP POLICY IF EXISTS "Allow public read and write access" ON public.coffee_items;
CREATE POLICY "Allow public read and write access" ON public.coffee_items
    FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read and write access" ON public.coffee_logs;
CREATE POLICY "Allow public read and write access" ON public.coffee_logs
    FOR ALL USING (true) WITH CHECK (true);

-- 5. 插入初始預購咖啡資料
INSERT INTO public.coffee_items (name, total_purchased, total_redeemed, category)
VALUES 
    ('大杯美式', 15, 0, '美式系列'),
    ('特大美式', 25, 0, '美式系列'),
    ('大杯特選美式', 23, 0, '特選系列')
ON CONFLICT DO NOTHING;

-- 6. 插入初始歷程紀錄
INSERT INTO public.coffee_logs (item_name, type, quantity, note)
VALUES 
    ('大杯美式', 'create', 15, '初始預購 15 杯'),
    ('特大美式', 'create', 25, '初始預購 25 杯'),
    ('大杯特選美式', 'create', 23, '初始預購 23 杯');
