CREATE OR REPLACE PROCEDURE        IC_P_TRUNC_ICGPREPAGO
 IS
v_cursor   number;
v_begin  varchar2(100);
v_command varchar2(100);
begin
v_cursor:=DBMS_SQL.OPEN_CURSOR;
v_command:= 'TRUNCATE TABLE ICG_PREPAGO';
begin
 DBMS_SQL.parse(v_cursor,v_command,DBMS_SQL.v7);
end;
DBMS_SQL.CLOSE_CURSOR(v_cursor);
END;
/
SHOW ERRORS
