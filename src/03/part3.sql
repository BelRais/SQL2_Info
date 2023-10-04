--Задание 1--
CREATE OR REPLACE FUNCTION func_for_task_1_part_3()
RETURNS TABLE (Peer1 varchar, Peer2 varchar, pointsAmount numeric)
as $$
    begin
    RETURN QUERY
with t as (
select
    a.*
from (select t1.checkingpeer as peer1,
             t1.checkedpeer  as peer2,
             t1.pointsamount as p1,
             t2.pointsamount as p2
      from transferredpoints t1
               join transferredpoints t2 on t1.checkingpeer = t2.checkedpeer and t1.checkedpeer = t2.checkingpeer
) a where a.peer1 > a.peer2
),
t2 as (
select distinct
t1.checkingpeer as peer1,
t1.checkedpeer  as peer2,
t1.pointsamount as p1,
0 as p2
from transferredpoints t1
left join t on (t1.checkingpeer = t.peer1 and t1.checkedpeer = t.peer2) or
               (t.peer1 = t1.checkedpeer and t.peer2 = t1.checkingpeer)
where t.peer1 is NULL
),
t_agr as (
select
*
from t
union
select
*
from t2)
select
t_agr.peer1,
t_agr.peer2,
t_agr.p1 - t_agr.p2 as PointsAmount
from t_agr
;
end;
$$
language plpgsql;

--select * from func_for_task_1_part_3()

--Задание 2--

CREATE OR REPLACE FUNCTION func_for_task_2_part_3()
RETURNS TABLE (Peer1 varchar, Peer2 varchar, pointsAmount numeric)
as $$
    begin
    RETURN QUERY
select
peer,
task,
xpamount xp
from checks
join xp on checks.id = xp."check";
end;
$$
language plpgsql;

--select * from func_for_task_2_part_3()

--Задание 3
CREATE OR REPLACE FUNCTION func_for_task_3_part_3(is_date date)
RETURNS TABLE (Peer varchar)
as $$
    begin
    RETURN QUERY
with t_input as (
    select distinct
    t.peer,
    count(*) over (partition by t.peer, t.date, t.state) count_input
    from timetracking t
    where t.date = is_date and t.state = 1
),
t_output as (
    select distinct
    t.peer,
    count(*) over (partition by t.peer, t.date, t.state) count_output
    from timetracking t
    where t.date = is_date and t.state = 2
)

select distinct
t_main.peer
from timetracking t_main
left join t_input on t_main.peer = t_input.peer
left join t_output on t_main.peer = t_output.peer
where (case when t_input.count_input is null then 0 else t_input.count_input end) -
      (case when t_output.count_output is null then 0 else t_output.count_output end) > 0;
end;
$$
language plpgsql;

--select * from func_for_task_3_part_3('2023-09-21');

--Задание 4
CREATE OR REPLACE FUNCTION func_for_task_4_part_3()
RETURNS TABLE (Peer varchar, PointsChange numeric)
as $$
    begin
    RETURN QUERY
with t_left as (
select
t1.checkingpeer as peer,
t1.checkedpeer,
t1.pointsamount amount,
case when t2.pointsamount is null then 0 else t2.pointsamount end lost
from transferredpoints t1
left join transferredpoints t2 on t1.checkingpeer = t2.checkedpeer and t1.checkedpeer = t2.checkingpeer
),
t_left_agr as (
select
t_left.peer,
sum(t_left.amount - t_left.lost) as PointsChange
from t_left
group by t_left.peer
),
t_right as (
select
t1.checkedpeer as peer,
t1.checkingpeer,
t1.pointsamount lost_r,
case when t2.pointsamount is null then 0 else t2.pointsamount end amount_r
from transferredpoints t1
left join transferredpoints t2 on t1.checkedpeer = t2.checkingpeer and t1.checkingpeer = t2.checkedpeer
),
t_right_agr as (
select
t_right.peer,
sum(t_right.amount_r - t_right.lost_r) as PointsChange
from t_right
group by t_right.peer
)
select
case when t_left_agr.peer is null then t_right_agr.peer else t_left_agr.peer end as Peer,
case when t_left_agr.PointsChange is null then t_right_agr.PointsChange else t_left_agr.PointsChange end as PointsChange
from t_left_agr
full outer join t_right_agr on t_left_agr.peer = t_right_agr.peer
order by PointsChange desc;
end;
$$
language plpgsql;

--select * from func_for_task_4_part_3()

--Задание 5
CREATE OR REPLACE FUNCTION func_for_task_5_part_3()
RETURNS TABLE (Peer varchar, PointsChange numeric)
as $$
    begin
    RETURN QUERY
with t_input as (
select
t.peer1,
sum(t.pointsAmount) as points_input
from func_for_task_1_part_3() t
group by t.peer1
),
t_output as (
select
t.peer2,
sum(t.pointsamount) as points_output
from func_for_task_1_part_3() t
group by t.peer2
)
select
a.Peer,
a.points_input - a.points_output as PointsChange
from (
select
case when t_input.peer1 is null then t_output.Peer2 else peer1 end as Peer,
case when t_input.points_input is null then 0 else t_input.points_input end as points_input,
case when t_output.points_output is null then 0 else t_output.points_output end as points_output
from t_input
full outer join t_output on t_output.Peer2 = t_input.Peer1
) a
order by PointsChange desc;
end;
$$
language plpgsql;

--select * from func_for_task_5_part_3()

--Задание 6
CREATE OR REPLACE FUNCTION func_for_task_6_part_3()
RETURNS TABLE (day date, Task varchar)
as $$
    begin
    RETURN QUERY
select
aa.day,
aa.task
from
(
select
a.day,
a.task,
a.count_of_task,
max(a.count_of_task) over (partition by a.day) max_c
from (
select distinct
t.date as day,
t.task,
count(t.task) over (partition by t.date, t.task) count_of_task
from checks t
) a
) aa
where aa.count_of_task = aa.max_c;
end;
$$
language plpgsql;

--select * from func_for_task_6_part_3()

--Задание 7
CREATE OR REPLACE FUNCTION func_for_task_7_part_3(is_task varchar)
RETURNS TABLE (Peer varchar, Day date)
as $$
declare
    pattern text := concat(is_task,'[0-9]');
begin
RETURN QUERY
with t_lask_pattern_task as (
select
is_task as blok,
max(REGEXP_SUBSTR(title,'\d+$')) as last_task
from tasks t
WHERE t.title similar to pattern
)
select
checks.peer,
checks.date
from xp
join checks on xp."check" = checks.id
where (select concat(blok,last_task) from t_lask_pattern_task) = checks.task
;
end;
$$
language plpgsql;

--select * from func_for_task_7_part_3('C');

--Задание 8
CREATE OR REPLACE FUNCTION func_for_task_8_part_3()
RETURNS TABLE (Peer varchar, RecommendedPeer varchar)
as $$
begin
RETURN QUERY
with t_list as (
select p.nickname,
case when f.peer1 = p.nickname then f.peer2
when f.peer2 = p.nickname then f.peer1
end as f
from peers p
join friends f on p.nickname = f.peer1 or p.nickname = f.peer2
),
t_count as (
select
t_list.*,
r.recommendedpeer,
count(*) over (partition by t_list.nickname, r.recommendedpeer) counts
from t_list
join recommendations r on t_list.f = r.peer
),
t_agr as (
select
a.*
from (
select
t.*,
max(t.counts) over (partition by t.nickname) max_s
from t_count t
) a
where a.max_s = a.counts
)

select distinct
a.nickname as Peer,
a.recommendedpeer as RecommendedPeer
from t_agr a
;
end;
$$
language plpgsql;

--select * from func_for_task_8_part_3()

--Задание 9
CREATE OR REPLACE FUNCTION func_for_task_9_part_3(is_block_1 varchar, is_block_2 varchar)
RETURNS TABLE (StartedBlock1 numeric, StartedBlock2 numeric, StartedBothBlocks numeric, DidntStartAnyBlock numeric)
as $$
begin
RETURN QUERY
with t_all_block as (
select distinct
t_p.nickname,
REGEXP_SUBSTR(t_c.task,'^[A-Z]{1,}') as block
from peers t_p
left join checks t_c on t_p.nickname = t_c.peer
),
t_all_block_count as (
select
(select count(*) from peers) as count_all_peers,
count(*) over (partition by nickname, block) as count_peer_on_block,
*
from t_all_block
),
t_Both as (
select
t_1.nickname,
t_1.count_all_peers,
t_1.count_peer_on_block
from t_all_block_count t_1
join t_all_block_count t_2 on t_1.nickname = t_2.nickname and
t_1.block = is_block_1 and t_2.block = is_block_2
),
only_1 as (
select
t_1.nickname,
t_1.count_all_peers,
t_1.count_peer_on_block
from t_all_block_count t_1
left join t_Both t_2 on t_1.nickname = t_2.nickname
where t_2.nickname is null and t_1.block = is_block_1
),
only_2 as (
select
t_1.nickname,
t_1.count_all_peers,
t_1.count_peer_on_block
from t_all_block_count t_1
left join t_Both t_2 on t_1.nickname = t_2.nickname
where t_2.nickname is null and t_1.block = is_block_2
),
dont_do as (
select distinct
t_1.nickname,
t_1.count_all_peers,
t_1.count_peer_on_block
from t_all_block_count t_1
left join (
select * from only_1
union
select * from only_2
union
select * from t_Both
) t_2 on t_1.nickname = t_2.nickname
where t_2.nickname is null
)
select
case when a.StartedBlock1 is null then 0 else a.StartedBlock1 end as StartedBlock1,
case when a.StartedBlock2 is null then 0 else a.StartedBlock2 end as StartedBlock2,
case when a.StartedBothBlocks is null then 0 else a.StartedBothBlocks end as StartedBothBlocks,
case when a.DidntStartAnyBlock is null then 0 else a.DidntStartAnyBlock end as DidntStartAnyBlock
from (
select
(select
a.sum_1 * 1.0 / a.count_all_peers * 100
from (
select distinct
sum(t.count_peer_on_block) over () as sum_1,
t.count_all_peers
from only_1 t
) a) as StartedBlock1,
(select
a.sum_2 * 1.0 / a.count_all_peers * 100
from (
select distinct
sum(t.count_peer_on_block) over () as sum_2,
t.count_all_peers
from only_2 t
) a) as StartedBlock2,
(select
a.sum_Both * 1.0 / a.count_all_peers * 100
from (
select distinct
sum(t.count_peer_on_block) over () as sum_Both,
t.count_all_peers
from t_Both t
) a) as StartedBothBlocks,
(select
a.sum_dont_do * 1.0 / a.count_all_peers * 100
from (
select distinct
sum(t.count_peer_on_block) over () as sum_dont_do,
t.count_all_peers
from dont_do t
) a) as DidntStartAnyBlock
) a
;
end;
$$
language plpgsql;

--select * from func_for_task_9_part_3('SQL','ww')

--Задание 10

CREATE OR REPLACE FUNCTION func_for_task_10_part_3()
RETURNS TABLE (SuccessfulChecks numeric, UnsuccessfulChecks numeric)
as $$
begin
RETURN QUERY
with t_main as (
select
COUNT(*) over () sum_dr,
t_2.peer,
t_1.birthday,
t_2.date,
t_2.id,
t_2.task
from peers t_1
join checks t_2 on t_1.nickname = t_2.peer and (EXTRACT(day FROM t_1.birthday) = EXTRACT(day FROM t_2.date)
                                                    and EXTRACT(month FROM birthday) = EXTRACT(month FROM t_2.date))
),
t_done as (
select
t_m.*,
t_2.xpamount,
count(t_2.xpamount) over () sum_done_dr
from t_main t_m
left join xp t_2 on t_m.id = t_2."check"
)
select
round(t.sum_done_dr * 1.0 / t.sum_dr * 100, 2) SuccessfulChecks,
round((t.sum_dr - t.sum_done_dr) * 1.0 / t.sum_dr * 100, 2) UnsuccessfulChecks
from t_done t
;
end;
$$
language plpgsql;

--select * from func_for_task_10_part_3()

--Задание 11
CREATE OR REPLACE FUNCTION func_for_task_11_part_3(is_task_1 varchar, is_task_2 varchar, is_task_3 varchar)
RETURNS TABLE (Peer varchar)
as $$
begin
RETURN QUERY
with t_list_per as (
select
t_1.nickname,
t_2.title
from peers t_1
cross join tasks t_2
),
t_main as (
select
list.nickname,
list.title,
t_1.id,
t_2.xpamount
from t_list_per list
left join checks t_1 on list.nickname = t_1.peer and list.title = t_1.task
left join xp t_2 on t_1.id = t_2."check"
),
t_done_1_and_2 as (
select distinct
t_1.nickname
from (
select distinct
t.*
from t_main t
where t.title = is_task_1 and t.xpamount is not NULL
) tt
join t_main t_1 on tt.nickname = t_1.nickname
where t_1.title = is_task_2 and t_1.xpamount is not NULL
),
t_done_3 as (
select
t_1.nickname,
t_1.title,
t_1.id,
t_1.xpamount
from t_main t_1
join t_done_1_and_2 t_2 on t_1.nickname = t_2.nickname
where t_1.title = is_task_3 and t_1.xpamount is null
)
select distinct
t.nickname
from t_done_3 t
;
end;
$$
language plpgsql;

select * from func_for_task_11_part_3('C1','C2','CPP1');

--Задание 12

CREATE OR REPLACE FUNCTION func_for_task_12_part_3()
RETURNS TABLE (Task varchar, PrevCount integer)
as $$
begin
RETURN QUERY
WITH recursive task_hierarchy(title, parent, n) AS (
    SELECT tasks.title, tasks.parenttask, 0
    FROM tasks
    WHERE tasks.parenttask IS NULL
    UNION ALL
    SELECT tasks.title, task_hierarchy.title, n+1
    FROM task_hierarchy INNER JOIN tasks ON tasks.parenttask = task_hierarchy.title
    )
SELECT title, n FROM task_hierarchy
;
end;
$$
language plpgsql;

--select * from func_for_task_12_part_3()

--Задание 13

CREATE OR REPLACE FUNCTION func_for_task_13_part_3(is_num numeric)
RETURNS TABLE (Date date)
as $$
begin
if is_num <= 0 then
    raise exception 'Ошибка! Введите правильное число дней от 1';
end if;
RETURN QUERY
WITH recursive task_hierarchy(date, peer,row_for_date,xp_trigger, n) AS (
with t as (
select
t_1.id,
t_1.peer,
t_1.task,
t_2.state,
t_1.date,
t_2.time,
row_number() over (partition by t_1.date order by t_2.time, t_1.peer) row_for_date,
t_3.xpamount,
t_4.maxxp,
case when t_3.xpamount / t_4.maxxp >= 0.8 then 1
else 0
end as xp_trigger
from checks t_1
join p2p t_2 on t_1.id = t_2."check"
join tasks t_4 on t_4.title = t_1.task
left join xp t_3 on t_3."check" = t_1.id
where state != 'Start'
)
select t.date,t.peer,t.row_for_date, t.xp_trigger, 0 from t
UNION ALL
select t.date,
       t.peer,
       t.row_for_date,
       t.xp_trigger,
       case
        when t.xp_trigger = 0 then 0
        else n+1
        end as n
from t
INNER JOIN task_hierarchy ON t.date = task_hierarchy.date and t.row_for_date = task_hierarchy.row_for_date+1

)
select distinct
aaa.date
from (
select
aa.date,
case
when aa.max_n >= is_num then 1
else 0
end as flag
from (
select distinct
a.date,
max(a.n) over (partition by a.date) as max_n
from (
SELECT t.date, t.peer, t.row_for_date,t.xp_trigger, t.n FROM task_hierarchy t
) a
) aa
) aaa
where flag = 1
;
end;
$$
language plpgsql;

select * from func_for_task_13_part_3(-1);

--Задание 14

CREATE OR REPLACE FUNCTION func_for_task_14_part_3()
RETURNS TABLE (Peer varchar, XP numeric)
as $$
begin
RETURN QUERY
select distinct
aa.peer,
aa.sum_xp as XP
from (
select distinct
a.peer,
sum_xp,
max(a.sum_xp) over () max_xp
from (
select distinct
checks.peer,
sum(xp.xpamount) over (partition by checks.peer) as sum_xp
from xp
join checks on xp."check" = "checks".id
) a
) aa
where aa.sum_xp = aa.max_xp
;
end;
$$
language plpgsql;

--select * from func_for_task_14_part_3()

--Задание 15

CREATE OR REPLACE FUNCTION func_for_task_15_part_3(is_time time, is_sw numeric)
RETURNS TABLE (Peer varchar)
as $$
begin
RETURN QUERY
with t_main as (
select
t.peer,
t.date,
count(*) over (partition by t.peer) sw
from timetracking t
where t.time > is_time and t.state = 1
--order by date
)
select distinct
t.peer
from t_main t
where t.sw >= is_sw
;
end;
$$
language plpgsql;

--select * from func_for_task_15_part_3('9:00:00',1);

--Задание 16

CREATE OR REPLACE FUNCTION func_for_task_16_part_3(is_date integer, is_sw numeric)
RETURNS TABLE (Peer varchar)
as $$
begin
RETURN QUERY
with t_main as (
select
t.peer,
t.date,
count(*) over (partition by t.peer) sw
from timetracking t
where t.date between now()::date - is_date and now()::date and t.state = 2
--order by date
)
select distinct
t.peer
from t_main t
where t.sw >= is_sw
;
end;
$$
language plpgsql;

--select * from func_for_task_16_part_3(5,1);

--Задание 17

CREATE OR REPLACE FUNCTION func_for_task_17_part_3()
RETURNS TABLE (Month text, EarlyEntries numeric)
as $$
begin
RETURN QUERY
with t_main as (
select
a.*
from (
select
t_1.peer,
t_1.date,
to_char(t_1.date, 'Month') t_1_date_m,
t_1.time,
t_1.state,
to_char(t_2.birthday, 'Month') birthday_m,
t_2.birthday
from timetracking t_1
join peers t_2 on t_1.peer = t_2.nickname
) a
where a.t_1_date_m = a.birthday_m and a.state = 1
),
t_all_input as (
select distinct
t.t_1_date_m,
count(*) over (partition by t.t_1_date_m) as all_input
from t_main t
),
t_time_input as (
select distinct
t.t_1_date_m,
count(*) over (partition by t.t_1_date_m) as all_input
from t_main t
where t.time < '12:00:00'
),
t_for_agr as (
select
t_1.t_1_date_m,
t_1.all_input,
case when t_2.all_input is null then 0 else t_2.all_input end only_time_input
from t_all_input t_1
left join t_time_input t_2 on t_1.t_1_date_m = t_2.t_1_date_m
),
t_done as (
select
t.t_1_date_m,
t.only_time_input * 1.0 / t.all_input * 100 as EarlyEntries
from t_for_agr t
)
select a.month_name "Month",
       case when t_2.EarlyEntries is null then 0 else t_2.EarlyEntries end as EarlyEntries
from (
SELECT to_char(generate_series('2000-01-01'::date, '2000-12-01'::date, '1 month'), 'Month') AS month_name) a
left join t_done t_2 on a.month_name = t_2.t_1_date_m
;
end;
$$
language plpgsql;

--select * from func_for_task_17_part_3()