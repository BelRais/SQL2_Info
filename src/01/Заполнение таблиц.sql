
call import_data_from_csv_to_peers(';');
call import_data_from_csv_to_friends(';');
call import_data_from_csv_to_recommendations(';');
call import_data_from_csv_to_tasks(';');
call import_data_from_csv_to_timetracking(';');

--1 --OK
call task_p2p(name_checking:='sellersh', name_who_checking:='deannven',
    task_is:='C1',state_is:='Start',
    time_is:='13:00:00');
call task_p2p(name_checking:='sellersh', name_who_checking:='deannven',
    task_is:='C1',state_is:='Success',
    time_is:='13:00:00');

--2 --PEER
call task_p2p(name_checking:='deannven', name_who_checking:='ninetalm',
    task_is:='C1',state_is:='Start',
    time_is:='12:00:00');
call task_p2p(name_checking:='deannven', name_who_checking:='ninetalm',
    task_is:='C1',state_is:='Failure',
    time_is:='12:30:00');

--3 --VERTER
call task_p2p(name_checking:='georgean', name_who_checking:='ninetalm',
    task_is:='C1',state_is:='Start',
    time_is:='12:00:00');
call task_p2p(name_checking:='georgean', name_who_checking:='ninetalm',
    task_is:='C1',state_is:='Success',
    time_is:='12:00:00');

--4 -peer
call task_p2p(name_checking:='umberbun', name_who_checking:='deannven',
    task_is:='C1',state_is:='Start',
    time_is:='14:00:00');
call task_p2p(name_checking:='umberbun', name_who_checking:='deannven',
    task_is:='C1',state_is:='Failure',
    time_is:='14:20:00');

--5 ok
call task_p2p(name_checking:='ninetalm', name_who_checking:='deannven',
    task_is:='C1',state_is:='Start',
    time_is:='14:45:00');
call task_p2p(name_checking:='ninetalm', name_who_checking:='deannven',
    task_is:='C1',state_is:='Success',
    time_is:='15:00:00');

--6 ok
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Start',
    time_is:='16:30:00');
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Success',
    time_is:='17:00:00');

--7 ok
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Start',
    time_is:='17:30:00');
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Success',
    time_is:='18:00:00');

-- 8 verter
call task_p2p(name_checking:='deannven', name_who_checking:='dimasik',
    task_is:='C2',state_is:='Start',
    time_is:='11:00:00');
call task_p2p(name_checking:='deannven', name_who_checking:='dimasik',
    task_is:='C2',state_is:='Success',
    time_is:='11:20:00');

-- 9 ok
call task_p2p(name_checking:='georgean', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Start',
    time_is:='11:30:00');
call task_p2p(name_checking:='georgean', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Success',
    time_is:='11:40:00');

-- 10 ok
call task_p2p(name_checking:='umberbun', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Start',
    time_is:='12:00:00');
call task_p2p(name_checking:='umberbun', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Success',
    time_is:='12:20:00');

-- 11 ok
call task_p2p(name_checking:='georgean', name_who_checking:='oraoraora',
    task_is:='C2',state_is:='Start',
    time_is:='12:30:00');
call task_p2p(name_checking:='georgean', name_who_checking:='oraoraora',
    task_is:='C2',state_is:='Success',
    time_is:='13:00:00');

-- 12 ok
call task_p2p(name_checking:='umberbun', name_who_checking:='deannven',
    task_is:='C2',state_is:='Start',
    time_is:='12:30:00');
call task_p2p(name_checking:='umberbun', name_who_checking:='deannven',
    task_is:='C2',state_is:='Failure',
    time_is:='13:00:00');
-- 13 verter
call task_p2p(name_checking:='georgean', name_who_checking:='ninetalm',
    task_is:='CPP1',state_is:='Start',
    time_is:='09:00:00');
call task_p2p(name_checking:='georgean', name_who_checking:='ninetalm',
    task_is:='CPP1',state_is:='Success',
    time_is:='09:30:00');

-- 14 ok
call task_p2p(name_checking:='deannven', name_who_checking:='dimasik',
    task_is:='C2',state_is:='Start',
    time_is:='09:00:00');
call task_p2p(name_checking:='deannven', name_who_checking:='dimasik',
    task_is:='C2',state_is:='Success',
    time_is:='09:30:00');

-- 15 ok
call task_p2p(name_checking:='deannven', name_who_checking:='georgean',
    task_is:='CPP1',state_is:='Start',
    time_is:='10:00:00');
call task_p2p(name_checking:='deannven', name_who_checking:='georgean',
    task_is:='CPP1',state_is:='Success',
    time_is:='10:30:00');

-- 16 ok (no verter)
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='SQL1',state_is:='Start',
    time_is:='12:00:00');
call task_p2p(name_checking:='deannven', name_who_checking:='umberbun',
    task_is:='SQL1',state_is:='Success',
    time_is:='13:00:00');

-- 17 ok (C1 for dr test)
call task_p2p(name_checking:='peer_for_dr', name_who_checking:='deannven',
    task_is:='C1',state_is:='Start',
    time_is:='14:00:00');
call task_p2p(name_checking:='peer_for_dr', name_who_checking:='deannven',
    task_is:='C1',state_is:='Success',
    time_is:='14:30:00');

-- 18 ok (C1 for dr test) -- faile
call task_p2p(name_checking:='peer_for_dr2', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Start',
    time_is:='14:00:00');
call task_p2p(name_checking:='peer_for_dr2', name_who_checking:='umberbun',
    task_is:='C1',state_is:='Failure',
    time_is:='14:30:00');

-- 19 ok (C1 for dr test) -- verter failse
call task_p2p(name_checking:='peer_for_dr3', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Start',
    time_is:='15:00:00');
call task_p2p(name_checking:='peer_for_dr3', name_who_checking:='dimasik',
    task_is:='C1',state_is:='Success',
    time_is:='15:30:00');


-- for verter -- 1
call task_verter( name_is_checking :='sellersh',task_is := 'C1',
    state_is := 'Start',time_is:='14:26:00');
call task_verter( name_is_checking :='sellersh',task_is := 'C1',
    state_is := 'Success',time_is:='14:30:00');

--for verter -- 3
call task_verter( name_is_checking :='georgean',task_is := 'C1',
    state_is := 'Start',time_is:='13:33:00');
call task_verter( name_is_checking :='georgean',task_is := 'C1',
    state_is := 'Success',time_is:='13:34:00');

--for verter -- 5 ok
call task_verter( name_is_checking :='ninetalm',task_is := 'C1',
    state_is := 'Start',time_is:='16:01:00');
call task_verter( name_is_checking :='ninetalm',task_is := 'C1',
    state_is := 'Success',time_is:='16:02:00');

--for verter -- 6 ok
call task_verter( name_is_checking :='deannven',task_is := 'C1',
    state_is := 'Start',time_is:='17:31:00');
call task_verter( name_is_checking :='deannven',task_is := 'C1',
    state_is := 'Success',time_is:='17:32:00');

--for verter -- 7 ok
call task_verter( name_is_checking :='deannven',task_is := 'C1',
    state_is := 'Start',time_is:='18:01:00');
call task_verter( name_is_checking :='deannven',task_is := 'C1',
    state_is := 'Success',time_is:='18:02:00');

--for verter -- 8 ne ok
call task_verter( name_is_checking :='deannven',task_is := 'C2',
    state_is := 'Start',time_is:='11:21:00');
call task_verter( name_is_checking :='deannven',task_is := 'C2',
    state_is := 'Failure',time_is:='11:22:00');

--for verter -- 9 ok
call task_verter( name_is_checking :='georgean',task_is := 'C1',
    state_is := 'Start',time_is:='11:41:00');
call task_verter( name_is_checking :='georgean',task_is := 'C1',
    state_is := 'Success',time_is:='11:42:00');

--for verter -- 10 ok
call task_verter( name_is_checking :='umberbun',task_is := 'C1',
    state_is := 'Start',time_is:='12:21:00');
call task_verter( name_is_checking :='umberbun',task_is := 'C1',
    state_is := 'Success',time_is:='12:22:00');

--for verter -- 11 ok
call task_verter( name_is_checking :='georgean',task_is := 'C2',
    state_is := 'Start',time_is:='13:01:00');
call task_verter( name_is_checking :='georgean',task_is := 'C2',
    state_is := 'Success',time_is:='13:02:00');

-- for verter -- 13 ne ok
call task_verter( name_is_checking :='georgean',task_is := 'CPP1',
    state_is := 'Start',time_is:='09:31:00');
call task_verter( name_is_checking :='georgean',task_is := 'CPP1',
    state_is := 'Failure',time_is:='09:32:00');

-- for verter -- 14 ok
call task_verter( name_is_checking :='deannven',task_is := 'C2',
    state_is := 'Start',time_is:='09:31:00');
call task_verter( name_is_checking :='deannven',task_is := 'C2',
    state_is := 'Success',time_is:='09:32:00');

-- for verter -- 15 ok
call task_verter( name_is_checking :='deannven',task_is := 'CPP1',
    state_is := 'Start',time_is:='10:31:00');
call task_verter( name_is_checking :='deannven',task_is := 'CPP1',
    state_is := 'Success',time_is:='10:32:00');

-- for verter -- 17 ok dr test
call task_verter( name_is_checking :='peer_for_dr',task_is := 'C1',
    state_is := 'Start',time_is:='14:31:00');
call task_verter( name_is_checking :='peer_for_dr',task_is := 'C1',
    state_is := 'Success',time_is:='14:32:00');

-- for verter -- 18 ok dr test
call task_verter( name_is_checking :='peer_for_dr2',task_is := 'C1',
    state_is := 'Start',time_is:='14:31:00');
call task_verter( name_is_checking :='peer_for_dr2',task_is := 'C1',
    state_is := 'Success',time_is:='14:32:00');

-- for verter -- 19 ok dr test false
call task_verter( name_is_checking :='peer_for_dr3',task_is := 'C1',
    state_is := 'Start',time_is:='15:31:00');
call task_verter( name_is_checking :='peer_for_dr3',task_is := 'C1',
    state_is := 'Failure',time_is:='15:32:00');


--for xp check
insert into xp values (1,1,95);
insert into xp values (2,5,100);
insert into xp values (3,6,80);
insert into xp values (4,7,100);
insert into xp values (5,9,90);
insert into xp values (6,10,90);
insert into xp values (7,11,190);
insert into xp values (8,14,190);
insert into xp values (9,15,290);
insert into xp values (10,16,800);
insert into xp values (11,17,100);


/*
--for timetracking
insert into timetracking values (1, 'georgean', '2023-09-21','9:00:00',1);
insert into timetracking values (2, 'umberbun', '2023-09-21','9:00:00',1);
insert into timetracking values (3, 'sellersh', '2023-09-21','10:00:00',1);
insert into timetracking values (4, 'deannven', '2023-09-21','10:00:00',1);
insert into timetracking values (5, 'georgean', '2023-09-21','12:00:00',2);
insert into timetracking values (6, 'umberbun', '2023-09-21','12:00:00',2);
insert into timetracking values (7, 'georgean', '2023-09-21','13:00:00',1);
insert into timetracking values (8, 'umberbun', '2023-09-21','13:00:00',1);
insert into timetracking values (9, 'georgean', '2023-09-21','15:00:00',2);
insert into timetracking values (10, 'deannven', '2023-09-21','15:10:00',2);
insert into timetracking values (11, 'umberbun', '2023-09-21','15:00:00',2);
insert into timetracking values (12, 'georgean', '2023-09-21','17:00:00',1);
insert into timetracking values (13, 'umberbun', '2023-09-21','17:00:00',1);
insert into timetracking values (14, 'georgean', '2023-09-21','21:00:00',2);
insert into timetracking values (15, 'sellersh', '2023-09-22','7:00:00',2);
insert into timetracking values (16, 'umberbun', '2023-09-22','9:00:00',2);

--25.09.2023
insert into timetracking values (17, 'deannven', '2023-09-25','9:00:00',1);
insert into timetracking values (18, 'deannven', '2023-09-25','22:00:00',2);
insert into timetracking values (19, 'georgean', '2023-09-25','5:00:00',1);
insert into timetracking values (20, 'georgean', '2023-09-25','16:00:00',2);
insert into timetracking values (21, 'umberbun', '2023-09-25','10:00:00',1);
insert into timetracking values (22, 'umberbun', '2023-09-25','19:00:00',2);

--26.09.2023
insert into timetracking values (23, 'peer_for_dr', '2023-09-26', '9:00:00', 1); -- 2 кейс
insert into timetracking values (24, 'peer_for_dr', '2023-09-26', '11:00:00', 2);
insert into timetracking values (25, 'peer_for_dr', '2023-09-27', '13:00:00', 1);
insert into timetracking values (26, 'peer_for_dr', '2023-09-27', '19:00:00', 2);

insert into timetracking values (27, 'peer_for_dr2', '2023-09-26', '19:00:00', 1); -- 1 кейс
insert into timetracking values (28, 'peer_for_dr2', '2023-09-26', '22:00:00', 2);
insert into timetracking values (29, 'peer_for_dr2', '2023-09-27', '13:00:00', 1);
insert into timetracking values (30, 'peer_for_dr2', '2023-09-27', '22:00:00', 2);

*/