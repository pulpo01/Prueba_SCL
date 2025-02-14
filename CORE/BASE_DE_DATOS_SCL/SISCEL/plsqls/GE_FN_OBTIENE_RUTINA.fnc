CREATE OR REPLACE FUNCTION        GE_FN_OBTIENE_RUTINA (v_modulo VARCHAR2, v_correlativo NUMBER, v_flg_estado VARCHAR2, v_cod_rutina VARCHAR2) RETURN VARCHAR2
IS
-- Funcion que obtiene el nombre de una rutina a partir del modulo, correlativo,
-- estado y tipo de rutina
-- Creacion : 25 de mayo de 2002
-- Autor Doris Soto A.
--
   v_nom_rutina   ged_plantillarutinas.nom_rutina%TYPE;
BEGIN
-- Selecciona rutina a ejecutar y valida su existencia
SELECT nom_rutina
   INTO v_nom_rutina
   FROM ged_plantillarutinas
   WHERE cod_operadora = ge_fn_operadora_scl()
     AND cod_modulo = v_modulo
     AND num_correlativo = v_correlativo
         AND flg_estado = v_flg_estado
         AND cod_rutina = v_cod_rutina;
IF SQLCODE <> 0 THEN
     v_nom_rutina := 'ERROR';
END IF;
RETURN v_nom_rutina;
-- Control de errores
   EXCEPTION
   WHEN OTHERS THEN
      RETURN 'ERROR';
END;
/
SHOW ERRORS
