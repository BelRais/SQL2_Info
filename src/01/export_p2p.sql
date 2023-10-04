CREATE OR REPLACE PROCEDURE export_data_from_p2p_to_csv (p_csv_delimiter CHAR(1))
AS $$
DECLARE
    v_csv_path TEXT := 'C:\Program Files\PostgreSQL\15\data\to_p2p.csv';
    v_copy_query TEXT;
BEGIN
    v_copy_query := 'COPY p2p TO ''' || v_csv_path || ''' WITH NULL '''' DELIMITER ''' || p_csv_delimiter || ''' CSV HEADER;';
    EXECUTE v_copy_query;
END;
$$ LANGUAGE plpgsql;

--call export_data_from_p2p_to_csv(';')