CREATE OR REPLACE PACKAGE ge_logutil_pg AS
   PROCEDURE clean_log;
   PROCEDURE clean_log(en_dias NUMBER);
END;
/
SHOW ERRORS
