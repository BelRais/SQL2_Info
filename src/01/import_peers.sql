CREATE OR REPLACE PROCEDURE import_data_from_csv_to_peers (p_csv_delimiter CHAR(1))
AS $$
DECLARE
    v_csv_path TEXT := 'C:\Program Files\PostgreSQL\15\data\to_peers.csv';
    v_copy_query TEXT;
BEGIN
    v_copy_query := 'COPY peers FROM ''' || v_csv_path || ''' WITH NULL '''' DELIMITER ''' || p_csv_delimiter || ''' CSV HEADER;';
    EXECUTE v_copy_query;
END;
$$ LANGUAGE plpgsql;

--call import_data_from_csv_to_peers(';');
