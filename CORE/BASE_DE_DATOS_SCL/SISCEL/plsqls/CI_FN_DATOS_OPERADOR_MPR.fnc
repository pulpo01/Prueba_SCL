CREATE OR REPLACE FUNCTION        ci_fn_datos_operador_mpr (v_nom_usuario varchar2)
RETURN VARCHAR2 IS
--   error EXCEPTION;
   v_datos_operador VARCHAR2(500);

BEGIN
--
    SELECT g1.nom_operador || ';' || g2.des_oficina || ';' || g3.des_pueblo || ';' || g1.cod_oficina
        INTO v_datos_operador
        FROM  ge_direcciones g4, ge_pueblos g3, ge_oficinas g2, ge_seg_usuario g1
        WHERE g1.nom_usuario = v_nom_usuario
        AND   g1.cod_oficina = g2.cod_oficina
        AND   g2.cod_direccion = g4.cod_direccion
        AND   g4.cod_pueblo = g3.cod_pueblo;

-- ****************************************************
RETURN v_datos_operador;

--*********************************************************
   EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR ci_fn_datos_operador_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR ci_fn_datos_operador_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR ci_fn_datos_operador_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
