create table platforms(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null, url text, username text,
  created_at timestamptz default now());
create table lectures(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  platform_id uuid not null references platforms on delete cascade,
  title text not null, teacher text, release_date date, url text,
  status text not null default 'todo' check (status in ('todo','prog','done')),
  created_at timestamptz default now());
alter table platforms enable row level security;
alter table lectures enable row level security;
create policy own_platforms on platforms for all using (user_id=auth.uid()) with check (user_id=auth.uid());
create policy own_lectures on lectures for all using (user_id=auth.uid()) with check (user_id=auth.uid());
