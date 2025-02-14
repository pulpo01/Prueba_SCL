CREATE OR REPLACE PROCEDURE        GE_PR_INSPLANTILLAOBJETOS(
p_cod_operadora IN GED_PLANTILLAOBJETOS.cod_operadora%TYPE,
p_cod_modulo IN GED_PLANTILLAOBJETOS.cod_modulo%TYPE,
p_nom_frame IN GED_PLANTILLAOBJETOS.nom_frame%TYPE,
p_nom_objeto IN GED_PLANTILLAOBJETOS.nom_objeto%TYPE,
p_ind_objeto IN GED_PLANTILLAOBJETOS.ind_objeto%TYPE,
p_nom_ejecutable IN GED_PLANTILLAOBJETOS.nom_ejecutable%TYPE,
p_flg_estado IN GED_PLANTILLAOBJETOS.flg_estado%TYPE,
p_des_objeto IN GED_PLANTILLAOBJETOS.des_objeto%TYPE,
p_nom_usuario IN GED_PLANTILLAOBJETOS.nom_usuario%TYPE,
p_frame_padre IN GED_PLANTILLAOBJETOS.frame_padre%TYPE )
IS
-- Procedimiento que es llamado desde Visual Basic
-- y que ingresa a la GED_PLANTILLAOBJETOS tantos registros como operadoras SCL existan
-- con el fin de guardar consistencia y evitar caidas en el codigo
-- Creacion : 11 de Junio de 2002
-- Autor : Alejandra Montealegre
   iNumCorr NUMBER;
   vDescError VARCHAR2 (50);
   dFecha DATE;
   sCodOpe VARCHAR2(5);
--
   CURSOR cOperadoras IS
        SELECT cod_operadora_scl FROM ge_operadora_scl
        WHERE cod_operadora_scl <> Ge_Fn_Operadora_Scl();
--
BEGIN
   SELECT SYSDATE INTO dFecha FROM dual;
-- Inserta registro de VB en la tabla
   INSERT INTO GED_PLANTILLAOBJETOS (
                cod_operadora,cod_modulo,nom_frame,nom_objeto,
                ind_objeto,nom_ejecutable,flg_estado,
                des_objeto,fec_ultmod_h,nom_usuario,frame_padre)
   VALUES(
                p_cod_operadora,p_cod_modulo,p_nom_frame,p_nom_objeto,
                p_ind_objeto,p_nom_ejecutable,p_flg_estado,
                p_des_objeto,   dFecha, p_nom_usuario,p_frame_padre     );
-- Busca las otras operadoras SCL para insertar registros con el mismo modulo
-- y correlativo,con el fin de dejarlas reservadas y en estado false (inhabilitado para uso)
   OPEN cOperadoras;
   LOOP
                FETCH cOperadoras INTO sCodOpe;
                EXIT WHEN cOperadoras%NOTFOUND;
                BEGIN
                         INSERT INTO GED_PLANTILLAOBJETOS(
                                cod_operadora,cod_modulo,nom_frame,nom_objeto,
                                ind_objeto,nom_ejecutable,flg_estado,
                                des_objeto,fec_ultmod_h,nom_usuario,frame_padre)
                         VALUES (sCodOpe,p_cod_modulo,p_nom_frame,p_nom_objeto,
                                        p_ind_objeto,p_nom_ejecutable,'FALSE',
                                        p_des_objeto,dFecha,p_nom_usuario,p_frame_padre);
                END;
   END LOOP;
   CLOSE cOperadoras;
   COMMIT;
--
   EXCEPTION
   WHEN INVALID_CURSOR THEN
          vDescError := 'Operacion ilegal con Cursor Procedimiento';
      RAISE_APPLICATION_ERROR(-20001, vDescError);
   WHEN DUP_VAL_ON_INDEX THEN
          vDescError := 'Registro ya existente en la tabla GED_PLANTILLAOBJETOS';
      RAISE_APPLICATION_ERROR(-20002, vDescError);
   WHEN NO_DATA_FOUND THEN
          vDescError := 'No existen registros en la tabla GE_OPERADORA_SCL';
      RAISE_APPLICATION_ERROR(-20003, vDescError);
   WHEN OTHERS THEN
          vDescError := 'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
      RAISE_APPLICATION_ERROR(-20004, vDescError);
END;
/
SHOW ERRORS
