-- OrdenaPega: historial seguro de abonos y pagos.
-- Esta migración solo agrega una tabla; no elimina ni modifica registros existentes.

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  quote_id uuid not null references public.quotes(id) on delete cascade,
  amount bigint not null check (amount > 0),
  method text not null default 'transferencia'
    check (method in ('efectivo', 'transferencia', 'tarjeta', 'otro')),
  note text not null default '',
  paid_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.payments enable row level security;

drop policy if exists "payments own all" on public.payments;
create policy "payments own all"
on public.payments
for all
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

create index if not exists payments_user_id_idx
  on public.payments(user_id);

create index if not exists payments_quote_id_paid_at_idx
  on public.payments(quote_id, paid_at desc);

comment on table public.payments is
  'Abonos y pagos de cotizaciones, aislados por usuario mediante RLS.';
