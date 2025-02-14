CREATE OR REPLACE TRIGGER GE_TRG_AFUPDE_GEDPLANTIOBJE
 AFTER UPDATE OR DELETE ON GED_PLANTILLAOBJETOS
FOR EACH ROW
--
--   FECHA:27/03/2002
--

BEGIN
IF DELETING THEN
	INSERT INTO geh_plantillaobjetos (
	cod_operadora,
	cod_modulo,
	nom_frame,
	nom_objeto,
	ind_objeto,
	nom_ejecutable,
	flg_estado,
	des_objeto,
	frame_padre,
	flg_accion,
	fec_ultmod_h,
	nom_usuario,
	fec_historia_h)
	VALUES (
	:old.cod_operadora,
	:old.cod_modulo,
	:old.nom_frame,
	:old.nom_objeto,
	:old.ind_objeto,
	:old.nom_ejecutable,
	:old.flg_estado,
	:old.des_objeto,
	:old.frame_padre,
	'E',
	:old.fec_ultmod_h,
	:old.nom_usuario,
	 sysdate);
ELSIF UPDATING THEN
	INSERT INTO geh_plantillaobjetos (
	cod_operadora,
	cod_modulo,
	nom_frame,
	nom_objeto,
	ind_objeto,
	nom_ejecutable,
	flg_estado,
	des_objeto,
	frame_padre,
	flg_accion,
	fec_ultmod_h,
	nom_usuario,
	fec_historia_h)
	VALUES (
	:old.cod_operadora,
	:old.cod_modulo,
	:old.nom_frame,
	:old.nom_objeto,
	:old.ind_objeto,
	:old.nom_ejecutable,
	:old.flg_estado,
	:old.des_objeto,
	:old.frame_padre,
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
