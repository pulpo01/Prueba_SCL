CREATE OR REPLACE PROCEDURE        GE_PR_INSPLANTILLARUTINAS(
p_CodOpe IN GED_PLANTILLARUTINAS.COD_OPERADORA%TYPE,
p_CodMod IN GED_PLANTILLARUTINAS.COD_MODULO%TYPE,
p_NomRut IN GED_PLANTILLARUTINAS.NOM_RUTINA%TYPE,
p_CodRut IN GED_PLANTILLARUTINAS.COD_RUTINA%TYPE,
p_FlgEst IN GED_PLANTILLARUTINAS.FLG_ESTADO%TYPE,
p_DesRut IN GED_PLANTILLARUTINAS.DES_RUTINA%TYPE,
p_NomUsu IN GED_PLANTILLARUTINAS.NOM_USUARIO%TYPE )
IS
-- Procedimiento que es llamado desde Visual Basic
-- y que ingresa a la ged_plantillarutinas tantos registros como operadoras SCL existan
-- con el fin de guardar consistencia y evitar caidas en el codigo
-- Creacion : 4 de abril de 2002
-- Autor : Alejandra Montealegre
--
   error_proceso EXCEPTION;
   iNumCorr NUMBER;
   vDescError VARCHAR2 (50);
   dFecha DATE;
-- *******************Cursores*************************
   CURSOR cOperadoras IS
	SELECT cod_operadora_scl FROM ge_operadora_scl
	WHERE cod_operadora_scl <> Ge_Fn_Operadora_Scl();
-- ****************************************************
   sCodOpe VARCHAR2(5);
BEGIN
   SELECT SYSDATE INTO dFecha FROM dual;
--  Selecciona maximo numero correlativo por Operadora y Modulo
   SELECT NVL(MAX(NUM_CORRELATIVO),0) + 1
   INTO iNumCorr
   FROM GED_PLANTILLARUTINAS
   WHERE COD_OPERADORA = p_CodOpe
     AND COD_MODULO = p_CodMod;
-- Inserta registro de VB en la tabla
   INSERT INTO GED_PLANTILLARUTINAS (
		cod_operadora,	cod_modulo,		num_correlativo,
		nom_rutina,		cod_rutina,	flg_estado,
		des_rutina,		fec_ultmod_h,	nom_usuario)
   VALUES(
		p_CodOpe,		p_CodMod,	iNumCorr,
		p_NomRut,		p_CodRut,	p_FlgEst,
		p_DesRut,		dFecha,		p_NomUsu	);
-- Busca las otras operadoras SCL para insertar registros con el mismo modulo
-- y correlativo,con el fin de dejarlas reservadas y en estado false (inhabilitado para uso)
   OPEN cOperadoras;
   LOOP
		FETCH cOperadoras INTO sCodOpe;
		EXIT WHEN cOperadoras%NOTFOUND;
		BEGIN
			 INSERT INTO GED_PLANTILLARUTINAS
			 VALUES (sCodOpe,p_CodMod,iNumCorr,'RESERVADA',p_CodRut,'FALSE','RESERVADA',dFecha,p_NomUsu);
		END;
   END LOOP;
   CLOSE cOperadoras;
   COMMIT;
--
   EXCEPTION
   WHEN error_proceso THEN
   	  vDescError := 'No se pudo obtener el maximo correlativo desde la tabla';
      RAISE_APPLICATION_ERROR(-20001, vDescError);
   WHEN DUP_VAL_ON_INDEX THEN
   	  vDescError := 'Registro ya existente en la tabla';
      RAISE_APPLICATION_ERROR(-20002, vDescError);
   WHEN NO_DATA_FOUND THEN
   	  vDescError := 'No existen registros en la tabla';
      RAISE_APPLICATION_ERROR(-20003, vDescError);
   WHEN OTHERS THEN
   	  vDescError := 'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
      RAISE_APPLICATION_ERROR(-20004, vDescError);
END Ge_Pr_Insplantillarutinas;
/
SHOW ERRORS
