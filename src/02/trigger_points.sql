CREATE OR REPLACE FUNCTION func_for_tirgger_TransferredPoints() RETURNS TRIGGER
as $$
    declare
        per char(60);
        flag bool;
    begin
        per = (
        select peer from checks t1
        join p2p t2 on t1.id = new."check" and t2.checkingpeer = new.checkingpeer and new.state = 'Start'
        order by t2.time desc limit 1
        );
        flag  = (select case when count(*) > 0 then false else true end from transferredpoints where checkingpeer = new.checkingpeer and checkedpeer = per);
        if (new.state = 'Start' and flag = true) then
            insert into transferredpoints values ((select case when max(id)+1 is NULL then 1 else max(id)+1 end from transferredpoints),
                                                  new.checkingpeer,
                                                  per,
                                                  1);
        end if;
        if (new.state = 'Start' and flag = false) then
            update transferredpoints
            set pointsamount = (select pointsamount from transferredpoints where checkingpeer = new.checkingpeer and checkedpeer = per) + 1
            where checkedpeer = per and checkingpeer = new.checkingpeer;
        end if;
    return new;
    end;
$$
language plpgsql;

CREATE TRIGGER trigger_TransferredPoints after INSERT ON p2p
    FOR EACH ROW EXECUTE PROCEDURE func_for_tirgger_TransferredPoints();


select case when count(*) > 0 then false else true end from transferredpoints where checkingpeer = 'ninetalm' and checkedpeer = (select peer from checks t1
join p2p t2 on t1.id = t2."check" and t2.checkingpeer = 'ninetalm' and state = 'Start')


/*
insert into p2p values (11,1,'test','Start','2:00:00');
insert into p2p values (12,1,'test','Success','3:00:00');

insert into p2p values (13,1,'test','Start','4:00:00');
insert into p2p values (14,1,'test','Success','3:00:00');
*/
