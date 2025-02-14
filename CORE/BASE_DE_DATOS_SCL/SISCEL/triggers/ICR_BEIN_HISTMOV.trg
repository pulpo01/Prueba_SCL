CREATE OR REPLACE TRIGGER icr_bein_histmov
BEFORE INSERT
ON ICR_HISTMOVIMIENTO
FOR EACH ROW

DECLARE
  V_SENTENCIA VARCHAR2(1024):= NULL;
  V_TABLA VARCHAR2(17):= '000000';
  cursor_name INTEGER;
  rows INTEGER;
BEGIN
  cursor_name := dbms_sql.open_cursor;
  V_TABLA := 'ICR_HISTMOV' || TO_CHAR(:NEW.FEC_HISTORICO,'MMYYYY');
  V_SENTENCIA := 'INSERT INTO ' || V_TABLA ||
                 ' (NUM_MOVIMIENTO,FEC_HISTORICO,NUM_ABONADO,COD_ACTUACION,
                    NOM_USUARORA,COD_ESTADO,COD_MODULO,NUM_INTENTOS,
                    FEC_INGRESO,DES_RESPUESTA,FEC_LECTURA,FEC_EJECUCION,
                    COD_CENTRAL,COD_CENTRAL_NUE,NUM_RADIO,NUM_RADIO_NUE,
                    COD_SERVICIOS,COD_SUSPREHA,
                    NUM_MOVPOS,COD_ACTABO,TIP_TERMINAL,TIP_TERMINAL_NUE)
                    VALUES (:x1,:x2,:x3,:x4,:x5,:x6,:x7,:x8,:x9,:x10,:x11,
                    :x12,:x13,:x14,:x15,:x16,:x17,:x18,:x19,:x20,:x21,:x22)';
  dbms_output.put_line ('Sentencia: ' || V_SENTENCIA);
  dbms_sql.parse(cursor_name,V_SENTENCIA,dbms_sql.v7);
  dbms_sql.bind_variable(cursor_name,'x1',:NEW.NUM_MOVIMIENTO);
  dbms_sql.bind_variable(cursor_name,'x2',SYSDATE);
  dbms_sql.bind_variable(cursor_name,'x3',:NEW.NUM_ABONADO);
  dbms_sql.bind_variable(cursor_name,'x4',:NEW.COD_ACTUACION);
  dbms_sql.bind_variable(cursor_name,'x5',:NEW.NOM_USUARORA);
  dbms_sql.bind_variable(cursor_name,'x6',:NEW.COD_ESTADO);
  dbms_sql.bind_variable(cursor_name,'x7',:NEW.COD_MODULO);
  dbms_sql.bind_variable(cursor_name,'x8',:NEW.NUM_INTENTOS);
  dbms_sql.bind_variable(cursor_name,'x9',:NEW.FEC_INGRESO);
  dbms_sql.bind_variable(cursor_name,'x10',:NEW.DES_RESPUESTA);
  dbms_sql.bind_variable(cursor_name,'x11',:NEW.FEC_LECTURA);
  dbms_sql.bind_variable(cursor_name,'x12',:NEW.FEC_EJECUCION);
  dbms_sql.bind_variable(cursor_name,'x13',:NEW.COD_CENTRAL);
  dbms_sql.bind_variable(cursor_name,'x14',:NEW.COD_CENTRAL_NUE);
  dbms_sql.bind_variable(cursor_name,'x15',:NEW.NUM_RADIO);
  dbms_sql.bind_variable(cursor_name,'x16',:NEW.NUM_RADIO_NUE);
  dbms_sql.bind_variable(cursor_name,'x17',:NEW.COD_SERVICIOS);
  dbms_sql.bind_variable(cursor_name,'x18',:NEW.COD_SUSPREHA);
  dbms_sql.bind_variable(cursor_name,'x19',:NEW.NUM_MOVPOS);
  dbms_sql.bind_variable(cursor_name,'x20',:NEW.COD_ACTABO);
  dbms_sql.bind_variable(cursor_name,'x21',:NEW.TIP_TERMINAL);
  dbms_sql.bind_variable(cursor_name,'x22',:NEW.TIP_TERMINAL_NUE);
  rows := dbms_sql.execute(cursor_name);
  dbms_sql.close_cursor(cursor_name);
  :new.cod_act := 'BO';
  EXCEPTION WHEN OTHERS THEN
    dbms_sql.close_cursor(cursor_name);
    RAISE_APPLICATION_ERROR
   (-20006,'ERROR TRIGGER ICR_BEIN_HISTMOV: '||
    V_TABLA ||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
