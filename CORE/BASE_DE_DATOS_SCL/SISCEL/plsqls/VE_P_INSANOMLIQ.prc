CREATE OR REPLACE PROCEDURE        VE_P_INSANOMLIQ(
  vp_liquidacion IN NUMBER ,
  vp_mensaje IN VARCHAR2 ,
  vp_procedure IN VARCHAR2 ,
  vp_tabla IN VARCHAR2 ,
  vp_accion IN VARCHAR2 ,
  vp_sqlcode IN VARCHAR2 ,
  vp_sqlerrm IN VARCHAR2 ,
  vp_anomliq OUT NUMBER )
IS
BEGIN
SELECT VE_SEQ_ANOMLIQ.NEXTVAL
INTO  vp_anomliq
FROM  DUAL;
INSERT INTO VE_ANOMLIQ (
 NUM_ANOMALIA, NUM_LIQUIDACION, DES_MENSAJE, NOM_PROCEDURE, NOM_TABLA,
 IND_ACCION,  COD_SQLCODE, DES_SQLERRM )
VALUES (
 vp_anomliq,  vp_liquidacion, vp_mensaje,  vp_procedure, vp_tabla,
 vp_accion,  vp_sqlcode,  vp_sqlerrm );
END;
/
SHOW ERRORS
