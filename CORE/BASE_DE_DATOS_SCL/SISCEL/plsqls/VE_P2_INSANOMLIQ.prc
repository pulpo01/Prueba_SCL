CREATE OR REPLACE PROCEDURE        VE_P2_INSANOMLIQ
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
--dbms_output.put_line('Num_anomalia      '|| to_char( vp_anomliq));
--dbms_output.put_line('Num Liquidacion   '|| to_char( vp_liquidacion));
--dbms_output.put_line('Mensaje           '|| vp_mensaje);
--dbms_output.put_line('Procedure         '|| vp_procedure);
--dbms_output.put_line('Tabla             '|| vp_tabla);
--dbms_output.put_line('Accion            '|| vp_accion);
--dbms_output.put_line('Sqlcode           '|| vp_sqlcode);
--dbms_output.put_line('Sqlerrm           '|| vp_sqlerrm);
INSERT INTO VE_ANOMLIQ (
 NUM_ANOMALIA, NUM_LIQUIDACION, DES_MENSAJE, NOM_PROCEDURE, NOM_TABLA,
 IND_ACCION,  COD_SQLCODE, DES_SQLERRM )
VALUES (
 VE_SEQ_ANOMLIQ.NEXTVAL,  vp_liquidacion, vp_mensaje,  vp_procedure, vp_tabla,
 vp_accion,  vp_sqlcode,  vp_sqlerrm );
END ve_p2_insanomliq;
/
SHOW ERRORS
