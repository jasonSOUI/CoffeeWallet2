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
    ('大杯特選美式', 51, 6,  '特選系列'),
    ('特大濃萃美式', 25, 9,  '濃萃系列'),
    ('黑糖珍珠撞奶', 14, 0,  '特調系列'),
    ('特大美式',     7,  1,  '美式系列'),
    ('大杯拿鐵',     1,  0,  '拿鐵系列'),
    ('大杯濃萃美式', 2,  1,  '濃萃系列'),
    ('冰淇淋紅茶',   1,  0,  '特調系列')
ON CONFLICT DO NOTHING;

-- 6. 插入初始歷程紀錄
INSERT INTO public.coffee_logs (item_name, type, quantity, note)
VALUES 
    ('大杯特選美式', 'create', 51, '初始購入 51 杯'),
    ('大杯特選美式', 'redeem', 6,  '初始已取 6 杯'),
    ('特大濃萃美式', 'create', 25, '初始購入 25 杯'),
    ('特大濃萃美式', 'redeem', 9,  '初始已取 9 杯'),
    ('黑糖珍珠撞奶', 'create', 14, '初始購入 14 杯'),
    ('特大美式',     'create', 7,  '初始購入 7 杯'),
    ('特大美式',     'redeem', 1,  '初始已取 1 杯'),
    ('大杯拿鐵',     'create', 1,  '初始購入 1 杯'),
    ('大杯濃萃美式', 'create', 2,  '初始購入 2 杯'),
    ('大杯濃萃美式', 'redeem', 1,  '初始已取 1 杯'),
    ('冰淇淋紅茶',   'create', 1,  '初始購入 1 杯');
