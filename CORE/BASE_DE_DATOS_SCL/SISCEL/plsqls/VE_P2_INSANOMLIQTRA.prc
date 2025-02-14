CREATE OR REPLACE PROCEDURE        VE_P2_INSANOMLIQTRA
(
  vp_liquidacion IN NUMBER ,
  vp_mensaje IN VARCHAR2 ,
  vp_procedure IN VARCHAR2 ,
  vp_tabla IN VARCHAR2 ,
  vp_accion IN VARCHAR2 ,
  vp_sqlcode IN VARCHAR2 ,
  vp_sqlerrm IN VARCHAR2
)
IS
BEGIN
INSERT INTO VE_ANOMLIQTRA (
 NUM_ANOMALIA, NUM_LIQUIDACION, DES_MENSAJE, NOM_PROCEDURE, NOM_TABLA,
 IND_ACCION,  COD_SQLCODE, DES_SQLERRM )
VALUES (
 VE_SEQ_ANOMLIQTRA.NEXTVAL,  vp_liquidacion, vp_mensaje,  vp_procedure, vp_tabla,
 vp_accion,  vp_sqlcode,  vp_sqlerrm );
END VE_P2_insanomliqtra;
/
SHOW ERRORS
