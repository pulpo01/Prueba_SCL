CREATE OR REPLACE PACKAGE BODY ge_logutil_pg AS
   PROCEDURE clean_log IS
   BEGIN
       EXECUTE IMMEDIATE 'truncate table log_table_to';
   END;
   PROCEDURE clean_log(en_dias NUMBER) IS
   BEGIN
       DELETE FROM GE_LOGTABLE_TO WHERE fecha < TRUNC(SYSDATE)-en_dias;
   END;
END;
/
SHOW ERRORS
