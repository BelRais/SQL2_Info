CREATE OR REPLACE PROCEDURE task_p2p (name_checking char(60), name_who_checking char(60),
       task_is char(60), state_is char(60), time_is time)
AS $$
BEGIN
    IF (state_is = 'Start') then
        insert into checks values ((select case when max(id)+1 is NULL then 1 else max(id)+1 end from checks), name_checking, task_is, now()::date);
        --temp_id = (select max(id) from checks);
        insert into p2p values ((select case when max(id)+1 is NULL then 1 else max(id)+1 end from p2p), (select max(id) from checks),name_who_checking, state_is, time_is);
    end if;
    If ((state_is = 'Success') or state_is = 'Failure') then
        insert into p2p values ((select case when max(id)+1 is NULL then 1 else max(id)+1 end from p2p), (select max("check") from p2p join checks on p2p."check" = checks.id where p2p.checkingpeer = name_who_checking and p2p.state = 'Start' and checks.peer = name_checking),name_who_checking, state_is, time_is);
    end if;
END;
$$ LANGUAGE plpgsql;

--call task_p2p(name_checking:='test_1', name_who_checking:='tester',task_is:='taskss',state_is:='Start',time_is:='12:00:00');
--call task_p2p(name_checking:='test_1', name_who_checking:='tester',task_is:='taskss',state_is:='Failure',time_is:='13:00:00');


--select max("check") from p2p join checks on p2p."check" = checks.id where p2p.checkingpeer = 'umberbun' and p2p.state = 'Start' and checks.peer = 'deannven'