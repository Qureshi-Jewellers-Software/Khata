-- Mera Khata: Supabase SQL Editor mein ek dafa chalayein
create table if not exists public.khata (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.khata enable row level security;
drop policy if exists "khata own select" on public.khata;
drop policy if exists "khata own insert" on public.khata;
drop policy if exists "khata own update" on public.khata;
create policy "khata own select" on public.khata for select to authenticated using (auth.uid() = user_id);
create policy "khata own insert" on public.khata for insert to authenticated with check (auth.uid() = user_id);
create policy "khata own update" on public.khata for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
