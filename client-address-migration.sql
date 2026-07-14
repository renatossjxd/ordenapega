-- Ejecutar una sola vez en Supabase > SQL Editor.
alter table public.clients
add column if not exists address text default '';
