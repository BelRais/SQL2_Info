CREATE OR REPLACE PROCEDURE export_data_from_recommendations_to_csv (p_csv_delimiter CHAR(1))
AS $$
DECLARE
    v_csv_path TEXT := 'C:\Program Files\PostgreSQL\15\data\to_recommendations.csv';
    v_copy_query TEXT;
BEGIN
    v_copy_query := 'COPY recommendations TO ''' || v_csv_path || ''' WITH NULL '''' DELIMITER ''' || p_csv_delimiter || ''' CSV HEADER;';
    EXECUTE v_copy_query;
END;
$$ LANGUAGE plpgsql;

--Call export_data_from_recommendations_to_csv(';');