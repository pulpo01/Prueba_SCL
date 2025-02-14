CREATE OR REPLACE TRIGGER GE_TRG_GA_ABOCEL_SITUA_AFUP
AFTER UPDATE OF COD_SITUACION
ON GA_ABOCEL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

 	v_modificacionUser		GE_MODILEUSU%rowtype;
 	v_modificacionUser_username	GE_MODILEUSU.nom_usuario%type ;
	v_modificacionUser_osuser	GE_MODILEUSU.nom_usuarioso%type ;
	v_modificacionUser_program	GE_MODILEUSU.nom_ejecutable%type ;
	v_modificacionUser_module	GE_MODILEUSU.cod_modulo%type ;

/* Soporte RyC CGLagosTM-0573*/
ERROR_PROCESO EXCEPTION;
BEGIN
  BEGIN
    SELECT username,   osuser,   program,   module
    INTO	v_modificacionUser_username,
    		v_modificacionUser_osuser,
    		v_modificacionUser_program,
    		v_modificacionUser_module
    FROM   v$session
    WHERE  audsid = userenv('sessionid')
    AND    (module is not null or program = 'TOAD.exe')
    AND    osuser != 'oracle01';
     /* Soporte RyC CGLagosTM-0573*/
     EXCEPTION
           WHEN NO_DATA_FOUND THEN
           RAISE ERROR_PROCESO;
    END;

      v_modificacionUser.nom_tabla	:= 'GA_ABOCEL';
      v_modificacionUser.nom_columna	:= 'COD_SITUACION';
      v_modificacionUser.tip_movimiento	:= 'U';
      v_modificacionUser.nom_usuario	:= v_modificacionUser_username;
      v_modificacionUser.nom_usuarioso	:= v_modificacionUser_osuser;
      v_modificacionUser.fec_movimiento	:= sysdate;
      v_modificacionUser.nom_ejecutable	:= v_modificacionUser_program;
      v_modificacionUser.cod_modulo	:= v_modificacionUser_module;
      v_modificacionUser.val_antes	:= :OLD.COD_SITUACION;
      v_modificacionUser.val_despues	:= :NEW.COD_SITUACION;
      v_modificacionUser.gls_adicional	:= NULL;

     INSERT INTO GE_MODILEUSU
     (
           		NOM_TABLA		,NOM_COLUMNA	,	TIP_MOVIMIENTO		,
           		NOM_USUARIO		,NOM_USUARIOSO	,	FEC_MOVIMIENTO		,
           		NOM_EJECUTABLE		,COD_MODULO	,	VAL_ANTES		,
           		VAL_DESPUES		,GLS_ADICIONAL	)
     VALUES	(	v_modificacionUser.NOM_TABLA	,
			v_modificacionUser.NOM_COLUMNA	,
			v_modificacionUser.TIP_MOVIMIENTO,
			v_modificacionUser.NOM_USUARIO	,
			v_modificacionUser.NOM_USUARIOSO,
			v_modificacionUser.FEC_MOVIMIENTO,
			v_modificacionUser.NOM_EJECUTABLE,
			v_modificacionUser.COD_MODULO	,
			v_modificacionUser.VAL_ANTES	,
			v_modificacionUser.VAL_DESPUES	,
			v_modificacionUser.GLS_ADICIONAL) ;

     /* Soporte RyC CGLagosTM-0573*/
     EXCEPTION
            WHEN ERROR_PROCESO THEN
            NULL;

END GE_TRG_GA_ABOCEL_SITUA_AFUP;
/
SHOW ERRORS
