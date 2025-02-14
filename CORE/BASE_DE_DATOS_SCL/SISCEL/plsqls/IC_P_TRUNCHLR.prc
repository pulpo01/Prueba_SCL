CREATE OR REPLACE PROCEDURE        IC_P_TRUNCHLR
 IS
v_cursor   number;
v_begin  varchar2(100);
v_borra_hlr varchar2(100);
begin
v_cursor:=DBMS_SQL.OPEN_CURSOR;
v_borra_hlr:= 'TRUNCATE TABLE ICG_HLR';
begin
 DBMS_SQL.parse(v_cursor,v_borra_hlr,DBMS_SQL.v7);
end;
DBMS_SQL.CLOSE_CURSOR(v_cursor);
END;
/
SHOW ERRORS
