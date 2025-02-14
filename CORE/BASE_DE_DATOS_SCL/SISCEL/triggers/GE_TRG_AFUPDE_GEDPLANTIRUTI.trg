CREATE OR REPLACE TRIGGER GE_TRG_AFUPDE_GEDPLANTIRUTI
AFTER DELETE OR UPDATE ON GED_PLANTILLARUTINAS
FOR EACH ROW
--
--   FECHA:27/03/2002
--

BEGIN
IF DELETING THEN
	INSERT INTO geh_plantillarutinas (
	cod_operadora,
	cod_modulo,
	num_correlativo,
	nom_rutina,
	cod_rutina,
	flg_estado,
	des_rutina,
	flg_accion,
	fec_ultmod_h,
	nom_usuario,
	fec_historia_h)
	VALUES
	(:old.cod_operadora,
	:old.cod_modulo,
	:old.num_correlativo,
	:old.nom_rutina,
	:old.cod_rutina,
	:old.flg_estado,
	:old.des_rutina,
	'E',
	:old.fec_ultmod_h,
	:old.nom_usuario,
	 sysdate);
ELSIF UPDATING THEN
	INSERT INTO geh_plantillarutinas (
	cod_operadora,
	cod_modulo,
	num_correlativo,
	nom_rutina,
	cod_rutina,
	flg_estado,
	des_rutina,
	flg_accion,
	fec_ultmod_h,
	nom_usuario,
	fec_historia_h)
	VALUES(
	:old.cod_operadora,
	:old.cod_modulo,
	:old.num_correlativo,
	:old.nom_rutina,
	:old.cod_rutina,
	:old.flg_estado,
	:old.des_rutina,
	'M',
	:old.fec_ultmod_h,
	:old.nom_usuario,
	 sysdate);
END IF;
	EXCEPTION
	WHEN OTHERS THEN
	NULL;
END;
/
SHOW ERRORS
