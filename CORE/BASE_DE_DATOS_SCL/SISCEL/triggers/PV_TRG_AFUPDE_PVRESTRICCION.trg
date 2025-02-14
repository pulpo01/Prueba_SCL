CREATE OR REPLACE TRIGGER PV_TRG_AFUPDE_PVRESTRICCION
AFTER DELETE OR UPDATE ON PVT_RESTRICCIONES
FOR EACH ROW
--
--   FECHA:09/05/2002
--

BEGIN
IF DELETING THEN
	INSERT INTO pvh_restricciones (
	cod_modulo,
        cod_producto,
	num_restriccion,
	tip_rutina,
	nom_rutina,
	des_rutina,
        param_restric,
	fec_ultmod,
	nom_usuario,
	flg_accion,
	fec_historia)
	VALUES
	(:old.cod_modulo,
        :old.cod_producto,
	:old.num_restriccion,
	:old.tip_rutina,
	:old.nom_rutina,
	:old.des_rutina,
	:old.param_restric,
	:old.fec_ultmod,
	:old.nom_usuario,
	'E',
	 sysdate);
ELSIF UPDATING THEN
	INSERT INTO pvh_restricciones (
	cod_modulo,
        cod_producto,
	num_restriccion,
	tip_rutina,
	nom_rutina,
	des_rutina,
	param_restric,
	fec_ultmod,
	nom_usuario,
	flg_accion,
	fec_historia)
	VALUES
	(:old.cod_modulo,
        :old.cod_producto,
	:old.num_restriccion,
	:old.tip_rutina,
	:old.nom_rutina,
	:old.des_rutina,
	:old.param_restric,
	:old.fec_ultmod,
	:old.nom_usuario,
	'M',
	 sysdate);
END IF;
	EXCEPTION
	WHEN OTHERS THEN
	NULL;
END PV_TRG_AFUPDE_PVRESTRICCION;
/
SHOW ERRORS
