CREATE OR REPLACE TRIGGER CO_TRG_CO_PAGOS
AFTER DELETE ON CO_PAGOS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  v_modificacionUser      GE_MODILEUSU%ROWTYPE;
  v_modificacionUser_username GE_MODILEUSU.nom_usuario%TYPE ;
 v_modificacionUser_osuser GE_MODILEUSU.nom_usuarioso%TYPE ;
 v_modificacionUser_program GE_MODILEUSU.nom_ejecutable%TYPE ;
 v_modificacionUser_module GE_MODILEUSU.cod_modulo%TYPE ;
 v_modificacionUser_fecha GE_MODILEUSU.fec_movimiento%TYPE ;

ERROR_PROCESO EXCEPTION;
BEGIN
  BEGIN
    SELECT username,   osuser,   program,   MODULE
    INTO v_modificacionUser_username,
      v_modificacionUser_osuser,
      v_modificacionUser_program,
      v_modificacionUser_module
    FROM   v$session
    WHERE  audsid = USERENV('sessionid');
    EXCEPTION
           WHEN NO_DATA_FOUND THEN
           RAISE ERROR_PROCESO;
    END;
 SELECT sysdate
 INTO v_modificacionUser_fecha
 FROM dual;

    v_modificacionUser.nom_tabla     := 'CO_PAGOS';
    v_modificacionUser.nom_columna     := 'NUM_SECUENCI';
    v_modificacionUser.tip_movimiento := 'D';
    v_modificacionUser.nom_usuario     := v_modificacionUser_username;
    v_modificacionUser.nom_usuarioso := v_modificacionUser_osuser;
    v_modificacionUser.fec_movimiento := v_modificacionUser_fecha;
    v_modificacionUser.nom_ejecutable := v_modificacionUser_program;
    v_modificacionUser.cod_modulo     := v_modificacionUser_module;
    v_modificacionUser.val_antes     := :OLD.NUM_SECUENCI;
    v_modificacionUser.val_despues     := NULL;
    v_modificacionUser.gls_adicional := 'SE ELIMINO REGISTRO';
     INSERT INTO GE_MODILEUSU
     (
             NOM_TABLA  ,NOM_COLUMNA , TIP_MOVIMIENTO  ,
             NOM_USUARIO  ,NOM_USUARIOSO , FEC_MOVIMIENTO  ,
             NOM_EJECUTABLE  ,COD_MODULO , VAL_ANTES  ,
             VAL_DESPUES  ,GLS_ADICIONAL )
     VALUES ( v_modificacionUser.NOM_TABLA ,
   v_modificacionUser.NOM_COLUMNA ,
   v_modificacionUser.TIP_MOVIMIENTO,
   v_modificacionUser.NOM_USUARIO ,
   v_modificacionUser.NOM_USUARIOSO,
   v_modificacionUser.FEC_MOVIMIENTO,
   v_modificacionUser.NOM_EJECUTABLE,
   v_modificacionUser.COD_MODULO ,
   v_modificacionUser.VAL_ANTES ,
   v_modificacionUser.VAL_DESPUES ,
   v_modificacionUser.GLS_ADICIONAL) ;
     EXCEPTION
            WHEN ERROR_PROCESO THEN
            NULL;
END CO_TRG_CO_PAGOS;
/