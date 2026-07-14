-- Ejecutar UNA VEZ en Supabase > SQL Editor para activar pruebas y suscripciones.
alter table public.profiles add column if not exists subscription_status text not null default 'trialing';
alter table public.profiles add column if not exists trial_ends_at timestamptz not null default (now() + interval '14 days');
alter table public.profiles add column if not exists subscription_id text default '';
alter table public.profiles add column if not exists subscription_ends_at timestamptz;
alter table public.profiles add constraint profiles_subscription_status_check check (subscription_status in ('trialing','active','past_due','canceled','expired'));

-- El navegador puede editar solamente datos comerciales, nunca el estado de pago.
revoke insert, update on public.profiles from authenticated;
grant insert (user_id,business_name,owner_name,rut,phone,email,address,business_type,logo_url,updated_at) on public.profiles to authenticated;
grant update (business_name,owner_name,rut,phone,email,address,business_type,logo_url,updated_at) on public.profiles to authenticated;
grant select on public.profiles to authenticated;

-- Solo un backend seguro/webhook podrá cambiar estas columnas de facturación.
comment on column public.profiles.subscription_status is 'Modificar únicamente mediante service role desde webhook seguro';
