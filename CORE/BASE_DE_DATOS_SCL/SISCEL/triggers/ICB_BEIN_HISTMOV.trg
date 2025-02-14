CREATE OR REPLACE TRIGGER ICB_BEIN_HISTMOV
 before INSERT
 on ICB_HISTMOVIMIENTO
 FOR EACH ROW

DECLARE
  V_SENTENCIA VARCHAR2(1024):= NULL;
  V_TABLA VARCHAR2(17):= '000000';
  cursor_name INTEGER;
  rows INTEGER;
BEGIN
  cursor_name := dbms_sql.open_cursor;
  V_TABLA := 'ICB_HISTMOV' || TO_CHAR(:NEW.FEC_HISTORICO,'MMYYYY');
  V_SENTENCIA := 'INSERT INTO ' || V_TABLA ||
                 ' (NUM_MOVIMIENTO,FEC_HISTORICO,NUM_ABONADO,COD_ACTUACION,
                    NOM_USUARORA,COD_ESTADO,COD_MODULO,NUM_INTENTOS,
                    FEC_INGRESO,DES_RESPUESTA,FEC_LECTURA,FEC_EJECUCION,
                    COD_CENTRAL,COD_CENTRAL_NUE,TS,ID,ID_NUE,CC,
                    PRO,VEL,FRE,COB,
                    NOM,GM1,GM2,GM3,GM4,
                    GM5,NUM_IDENT,STA,MARP,
                    MODP,NSER,TCUE,
                    COD_SERVICIOS,COD_SUSPREHA,
                    NUM_MOVPOS,COD_ACTABO,TIP_TERMINAL,TGRP,EMP,
                    COD_MENSAJE,PARAM1_MENS,PARAM2_MENS,PARAM3_MENS)
                    VALUES (:x1,:x2,:x3,:x4,:x5,:x6,:x7,:x8,:x9,
                    :x10,:x11,:x12,:x13,:x14,:x15,:x16,:x17,:x18,:x20,
                    :x21,:x22,:x23,:x24,:x25,:x26,:x27,:x28,:x29,:x30,:x31,
                    :x32,:x33,:x34,:x35,:x36,:x37,:x38,:x39,:x40,:x41,:x42,
                    :x43,:x44,:x45,:x46)';
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
  dbms_sql.bind_variable(cursor_name,'x15',:NEW.TS);
  dbms_sql.bind_variable(cursor_name,'x16',:NEW.ID);
  dbms_sql.bind_variable(cursor_name,'x17',:NEW.ID_NUE);
  dbms_sql.bind_variable(cursor_name,'x18',:NEW.CC);
--  dbms_sql.bind_variable(cursor_name,'x19',:NEW.TP);
  dbms_sql.bind_variable(cursor_name,'x20',:NEW.PRO);
  dbms_sql.bind_variable(cursor_name,'x21',:NEW.VEL);
  dbms_sql.bind_variable(cursor_name,'x22',:NEW.FRE);
  dbms_sql.bind_variable(cursor_name,'x23',:NEW.COB);
  dbms_sql.bind_variable(cursor_name,'x24',:NEW.NOM);
  dbms_sql.bind_variable(cursor_name,'x25',:NEW.GM1);
  dbms_sql.bind_variable(cursor_name,'x26',:NEW.GM2);
  dbms_sql.bind_variable(cursor_name,'x27',:NEW.GM3);
  dbms_sql.bind_variable(cursor_name,'x28',:NEW.GM4);
  dbms_sql.bind_variable(cursor_name,'x29',:NEW.GM5);
  dbms_sql.bind_variable(cursor_name,'x30',:NEW.NUM_IDENT);
  dbms_sql.bind_variable(cursor_name,'x31',:NEW.STA);
  dbms_sql.bind_variable(cursor_name,'x32',:NEW.MARP);
  dbms_sql.bind_variable(cursor_name,'x33',:NEW.MODP);
  dbms_sql.bind_variable(cursor_name,'x34',:NEW.NSER);
  dbms_sql.bind_variable(cursor_name,'x35',:NEW.TCUE);
  dbms_sql.bind_variable(cursor_name,'x36',:NEW.COD_SERVICIOS);
  dbms_sql.bind_variable(cursor_name,'x37',:NEW.COD_SUSPREHA);
  dbms_sql.bind_variable(cursor_name,'x38',:NEW.NUM_MOVPOS);
  dbms_sql.bind_variable(cursor_name,'x39',:NEW.COD_ACTABO);
  dbms_sql.bind_variable(cursor_name,'x40',:NEW.TIP_TERMINAL);
  dbms_sql.bind_variable(cursor_name,'x41',:NEW.TGRP);
  dbms_sql.bind_variable(cursor_name,'x42',:NEW.EMP);
  dbms_sql.bind_variable(cursor_name,'x43',:NEW.COD_MENSAJE);
  dbms_sql.bind_variable(cursor_name,'x44',:NEW.PARAM1_MENS);
  dbms_sql.bind_variable(cursor_name,'x45',:NEW.PARAM2_MENS);
  dbms_sql.bind_variable(cursor_name,'x46',:NEW.PARAM3_MENS);
  rows := dbms_sql.execute(cursor_name);
  dbms_sql.close_cursor(cursor_name);
  :new.cod_act := 'BO';
  EXCEPTION WHEN OTHERS THEN
    dbms_sql.close_cursor(cursor_name);
    RAISE_APPLICATION_ERROR  (-20006,'ERROR TRIGGER ICB_BEIN_HISTMOV:
'||V_TABLA||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
