CREATE OR REPLACE PROCEDURE task_verter (name_is_checking char(60),
       task_is char(60), state_is char(60), time_is time)
AS $$
    declare
        keys numeric;
BEGIN
    keys = (select t1.id from checks t1
            join p2p t2 on t1.id = t2."check"
            where t1.task = task_is and t2.state = 'Success' and t1.peer = name_is_checking and t2.time < time_is order by t2.time desc limit 1);
    insert into verter values ((select case when max(id)+1 is NULL then 1 else max(id)+1 end from verter),keys,state_is,time_is);
END;
$$ LANGUAGE plpgsql;

/*
call task_verter( name_is_checking := 'sellersh',task_is := 'Task_1',
    state_is := 'Success',time_is:='14:30:00')
*/

