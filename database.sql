-- Ejecute todo este archivo una sola vez en Supabase > SQL Editor.
create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  business_name text not null default 'Mi negocio', owner_name text default '',
  rut text default '', phone text default '', email text default '', address text default '',
  business_type text default 'Otro servicio', logo_url text default '', updated_at timestamptz default now()
);
create table if not exists public.clients (
  id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
  name text not null, rut text default '', phone text default '', email text default '', created_at timestamptz default now()
);
create table if not exists public.quotes (
  id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
  number bigint not null, client_id uuid references public.clients(id) on delete set null,
  title text not null, issue_date date not null default current_date, valid_days int not null default 15,
  items jsonb not null default '[]', notes text default '', net numeric not null default 0,
  tax numeric not null default 0, total numeric not null default 0, paid numeric not null default 0,
  status text not null default 'cotizacion' check (status in ('cotizacion','aceptado','parcial','pagado')),
  created_at timestamptz default now(), unique(user_id, number)
);
alter table public.profiles enable row level security; alter table public.clients enable row level security; alter table public.quotes enable row level security;
create policy "profile own select" on public.profiles for select using ((select auth.uid()) = user_id);
create policy "profile own insert" on public.profiles for insert with check ((select auth.uid()) = user_id);
create policy "profile own update" on public.profiles for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "clients own all" on public.clients for all using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "quotes own all" on public.quotes for all using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create index if not exists clients_user_id_idx on public.clients(user_id); create index if not exists quotes_user_id_idx on public.quotes(user_id);
insert into storage.buckets (id,name,public) values ('business-logos','business-logos',true) on conflict (id) do update set public=true;
create policy "logo own insert" on storage.objects for insert to authenticated with check (bucket_id='business-logos' and (storage.foldername(name))[1]=(select auth.uid())::text);
create policy "logo own update" on storage.objects for update to authenticated using (bucket_id='business-logos' and (storage.foldername(name))[1]=(select auth.uid())::text);
create policy "logo public read" on storage.objects for select using (bucket_id='business-logos');
