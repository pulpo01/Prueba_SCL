CREATE OR REPLACE TRIGGER ICR_BEIN_HISTCOM
BEFORE INSERT
ON ICR_HISTCOMPROC
FOR EACH ROW

DECLARE
  V_SENTENCIA VARCHAR2(1024):= NULL;
  V_TABLA VARCHAR2(17):= '000000';
  cursor_name INTEGER;
  rows INTEGER;
BEGIN
  cursor_name := dbms_sql.open_cursor;
  V_TABLA := 'ICR_HISTCOM' || TO_CHAR(:NEW.FEC_HISTORICO,'MMYYYY');
  V_SENTENCIA := 'INSERT INTO ' || V_TABLA ||
                 ' (NUM_MOVIMIENTO,NUM_ORDEN,FEC_HISTORICO,COD_LENGUAJE,
                    COD_CENTRAL,COD_SISTEMA,FEC_INGRESO,FEC_EJECUCION,
                    DES_COMANDO,DES_RESPUESTA,COD_COMANDO)
                    VALUES (:x1,:x2,:x3,:x4,:x5,:x6,:x7,:x8,:x9,:x10,:x11)';
  dbms_output.put_line ('Sentencia: ' || V_SENTENCIA);
  dbms_sql.parse(cursor_name,V_SENTENCIA,dbms_sql.v7);
  dbms_sql.bind_variable(cursor_name,'x1',:NEW.NUM_MOVIMIENTO);
  dbms_sql.bind_variable(cursor_name,'x2',:NEW.NUM_ORDEN);
  dbms_sql.bind_variable(cursor_name,'x3',SYSDATE);
  dbms_sql.bind_variable(cursor_name,'x4',:NEW.COD_LENGUAJE);
  dbms_sql.bind_variable(cursor_name,'x5',:NEW.COD_CENTRAL);
  dbms_sql.bind_variable(cursor_name,'x6',:NEW.COD_SISTEMA);
  dbms_sql.bind_variable(cursor_name,'x7',:NEW.FEC_INGRESO);
  dbms_sql.bind_variable(cursor_name,'x8',:NEW.FEC_EJECUCION);
  dbms_sql.bind_variable(cursor_name,'x9',:NEW.DES_COMANDO);
  dbms_sql.bind_variable(cursor_name,'x10',:NEW.DES_RESPUESTA);
  dbms_sql.bind_variable(cursor_name,'x11',:NEW.COD_COMANDO);
  rows := dbms_sql.execute(cursor_name);
  dbms_sql.close_cursor(cursor_name);
  :new.cod_act := 'BO';
  EXCEPTION WHEN OTHERS THEN
    dbms_sql.close_cursor(cursor_name);
    RAISE_APPLICATION_ERROR
   (-20006,'ERROR TRIGGER ICR_BEIN_HISTCOM: '||
    V_TABLA ||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
