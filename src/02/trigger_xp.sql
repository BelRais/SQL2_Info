CREATE OR REPLACE FUNCTION func_for_tirgger_xp() RETURNS TRIGGER
as $$
    declare
        task_max numeric;
        task_is_done bool;
    begin
        task_max = (
            select distinct
            t1.maxxp
            from tasks t1
            join checks t2 on t1.title = t2.task
            join xp t3 on t2.id = new."check"
                       );
        if (task_max < new.xpamount) then
            raise exception 'Ошибка! ХР за проверку больше максимально установленного ХР за данную проверку';
        end if;
        task_is_done = (select case
        when
        (select count(*)
        from p2p t1
        full join verter t2 on t1."check" = t2."check" and t2.state = 'Failure'
        where (t1.state = 'Failure' or t2.state = 'Failure') and t1."check" = new."check") > 0 then true
        else false
        end
        );
        if task_is_done = true then
            raise exception 'Ошибка! Проверка была провалена';
        end if;
        return new;
    end;
$$
language plpgsql;

CREATE TRIGGER trigger_xp after INSERT ON xp
    FOR EACH ROW EXECUTE PROCEDURE func_for_tirgger_xp();

--insert into xp values (6,1,99); --true
--insert into xp values (6,2,99); --false
--insert into xp values (6,3,99); --false
--insert into xp values (6,1,199); --false
