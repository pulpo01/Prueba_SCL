CREATE OR REPLACE TRIGGER icm_beup_movimiento
BEFORE UPDATE
OF COD_ESTADO
ON ICM_MOVIMIENTO
FOR EACH ROW
 
WHEN (
NEW.COD_ESTADO=0 OR NEW.COD_ESTADO=10       OR OLD.IND_BLOQUEO <>  NEW.IND_BLOQUEO
      )
DECLARE
 V_TABLA VARCHAR2(25):=NULL;
        V_COD_PRD GE_DATOSGENER.PROD_TREK%TYPE;
        V_OLD_MMOV ICM_MOVIMIENTO%ROWTYPE;
        V_NEW_MMOV ICM_MOVIMIENTO%ROWTYPE;
  BEGIN
  BEGIN
  IF :NEW.COD_ESTADO = 0 OR :NEW.COD_ESTADO = 10 THEN
    V_TABLA:='GE_DATOSGENER';
    SELECT PROD_TREK INTO V_COD_PRD
      FROM GE_DATOSGENER;
    V_NEW_MMOV.NUM_MOVIMIENTO   := :NEW.NUM_MOVIMIENTO;
    V_NEW_MMOV.NUM_ABONADO      := :NEW.NUM_ABONADO;
    V_NEW_MMOV.COD_ACTUACION    := :NEW.COD_ACTUACION;
    V_NEW_MMOV.COD_ACTABO       := :NEW.COD_ACTABO;
    V_NEW_MMOV.COD_CENTRAL      := :NEW.COD_CENTRAL;
    V_NEW_MMOV.COD_CENTRAL_NUE  := :NEW.COD_CENTRAL_NUE;
    V_NEW_MMOV.COD_MODULO       := :NEW.COD_MODULO;
    V_NEW_MMOV.COD_ESTADO       := :NEW.COD_ESTADO;
    V_NEW_MMOV.DES_RESPUESTA    := :NEW.DES_RESPUESTA;
    V_NEW_MMOV.NUM_INTENTOS     := :NEW.NUM_INTENTOS;
    V_NEW_MMOV.FEC_INGRESO      := :NEW.FEC_INGRESO;
    V_NEW_MMOV.NOM_USUARORA     := :NEW.NOM_USUARORA;
    V_NEW_MMOV.FEC_LECTURA      := :NEW.FEC_LECTURA;
    V_NEW_MMOV.FEC_EJECUCION    := :NEW.FEC_EJECUCION;
    V_NEW_MMOV.COD_SERVICIOS    := :NEW.COD_SERVICIOS;
    V_NEW_MMOV.COD_SUSPREHA     := :NEW.COD_SUSPREHA;
    V_NEW_MMOV.NUM_MOVPOS       := :NEW.NUM_MOVPOS;
    V_NEW_MMOV.NUM_MAN          := :NEW.NUM_MAN;
    V_NEW_MMOV.NUM_MAN_NUE      := :NEW.NUM_MAN_NUE;
    V_NEW_MMOV.NUM_SERIE        := :NEW.NUM_SERIE;
    V_NEW_MMOV.NUM_SERIE_NUE    := :NEW.NUM_SERIE_NUE;
    V_NEW_MMOV.TIP_TERMINAL     := :NEW.TIP_TERMINAL;
    V_NEW_MMOV.TIP_TERMINAL_NUE := :NEW.TIP_TERMINAL_NUE;
    V_NEW_MMOV.COD_MODELO       := :NEW.COD_MODELO;
    V_NEW_MMOV.COD_MODELO_NUE   := :NEW.COD_MODELO_NUE;
    V_NEW_MMOV.DIR_X25          := :NEW.DIR_X25;
    V_NEW_MMOV.DIR_X25_NUE      := :NEW.DIR_X25_NUE;
    V_OLD_MMOV.NUM_MOVIMIENTO   := :OLD.NUM_MOVIMIENTO;
    V_OLD_MMOV.NUM_ABONADO      := :OLD.NUM_ABONADO;
    V_OLD_MMOV.COD_ACTUACION    := :OLD.COD_ACTUACION;
    V_OLD_MMOV.COD_ACTABO       := :OLD.COD_ACTABO;
    V_OLD_MMOV.COD_CENTRAL      := :OLD.COD_CENTRAL;
    V_OLD_MMOV.COD_CENTRAL_NUE  := :OLD.COD_CENTRAL_NUE;
    V_OLD_MMOV.COD_MODULO       := :OLD.COD_MODULO;
    V_OLD_MMOV.COD_ESTADO       := :OLD.COD_ESTADO;
    V_OLD_MMOV.DES_RESPUESTA    := :OLD.DES_RESPUESTA;
    V_OLD_MMOV.NUM_INTENTOS     := :OLD.NUM_INTENTOS;
    V_OLD_MMOV.FEC_INGRESO      := :OLD.FEC_INGRESO;
    V_OLD_MMOV.NOM_USUARORA     := :OLD.NOM_USUARORA;
    V_OLD_MMOV.FEC_LECTURA      := :OLD.FEC_LECTURA;
    V_OLD_MMOV.FEC_EJECUCION    := :OLD.FEC_EJECUCION;
    V_OLD_MMOV.COD_SERVICIOS    := :OLD.COD_SERVICIOS;
    V_OLD_MMOV.COD_SUSPREHA     := :OLD.COD_SUSPREHA;
    V_OLD_MMOV.NUM_MOVPOS       := :OLD.NUM_MOVPOS;
    V_OLD_MMOV.NUM_MAN          := :OLD.NUM_MAN;
    V_OLD_MMOV.NUM_MAN_NUE      := :OLD.NUM_MAN_NUE;
    V_OLD_MMOV.NUM_SERIE        := :OLD.NUM_SERIE;
    V_OLD_MMOV.NUM_SERIE_NUE    := :OLD.NUM_SERIE_NUE;
    V_OLD_MMOV.TIP_TERMINAL     := :OLD.TIP_TERMINAL;
    V_OLD_MMOV.TIP_TERMINAL_NUE := :OLD.TIP_TERMINAL_NUE;
    V_OLD_MMOV.COD_MODELO       := :OLD.COD_MODELO;
    V_OLD_MMOV.COD_MODELO_NUE   := :OLD.COD_MODELO_NUE;
    V_OLD_MMOV.DIR_X25          := :OLD.DIR_X25;
    V_OLD_MMOV.DIR_X25_NUE      := :OLD.DIR_X25_NUE;
    V_TABLA:='P_IC_PASOHM';
    IC_PASOH.P_IC_PASOHM(V_COD_PRD,V_OLD_MMOV,V_NEW_MMOV);
--  ELIF :OLD.IND_BLOQUEO <> :NEW.IND_BLOQUEO THEN
  ELSE
     V_TABLA:='ICM_COMPROC';
     UPDATE ICM_COMPROC SET IND_BLOQUEO = :NEW.IND_BLOQUEO
      WHERE NUM_MOVIMIENTO = :OLD.NUM_MOVIMIENTO;
  END IF;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR
   (-20002,'ERROR TRIGGER ICM_BEUP_MOVIMIENTO: '||
    V_TABLA||' ORA'||TO_CHAR(SQLCODE),TRUE);
  END;
END;
/
SHOW ERRORS
