-- HARMONY 가족 전용 보안 설정
-- Supabase SQL Editor에서 이 파일 내용을 한 번 실행하세요.

-- 기존 공개 접근 차단
alter table public.channels enable row level security;
alter table public.videos enable row level security;
alter table public.comments enable row level security;
alter table public.favorites enable row level security;
alter table public.notifications enable row level security;

-- 기존 정책 제거
drop policy if exists "HARMONY family channels" on public.channels;
drop policy if exists "HARMONY family videos" on public.videos;
drop policy if exists "HARMONY family comments" on public.comments;
drop policy if exists "HARMONY family favorites" on public.favorites;
drop policy if exists "HARMONY family notifications" on public.notifications;

-- 로그인한 가족만 접근
create policy "HARMONY family channels"
on public.channels
for all
to authenticated
using (true)
with check (true);

create policy "HARMONY family videos"
on public.videos
for all
to authenticated
using (true)
with check (true);

create policy "HARMONY family comments"
on public.comments
for all
to authenticated
using (true)
with check (true);

create policy "HARMONY family favorites"
on public.favorites
for all
to authenticated
using (true)
with check (true);

create policy "HARMONY family notifications"
on public.notifications
for all
to authenticated
using (true)
with check (true);

-- Storage 공개 접근 차단
update storage.buckets
set public = false
where id = 'videos';

-- Storage 기존 정책 제거
drop policy if exists "HARMONY video uploads" on storage.objects;
drop policy if exists "HARMONY video reads" on storage.objects;
drop policy if exists "HARMONY family video upload" on storage.objects;
drop policy if exists "HARMONY family video read" on storage.objects;

-- 로그인한 가족만 영상 업로드/읽기
create policy "HARMONY family video upload"
on storage.objects
for insert
to authenticated
with check (bucket_id = 'videos');

create policy "HARMONY family video read"
on storage.objects
for select
to authenticated
using (bucket_id = 'videos');

create policy "HARMONY family video delete"
on storage.objects
for delete
to authenticated
using (bucket_id = 'videos');