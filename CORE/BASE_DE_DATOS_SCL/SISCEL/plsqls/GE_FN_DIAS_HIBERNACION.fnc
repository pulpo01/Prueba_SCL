CREATE OR REPLACE FUNCTION        ge_fn_dias_hibernacion (v_cod_uso IN NUMBER) RETURN number
IS
-- *************************************************************
-- * Funcion        : ge_dias_hibernacion
-- * Salida         : Dias de hibernacion
-- * Descripcion    : Obtiene los dias de hibernacion para un uso de celular en
-- *                  particular
-- * Fecha de creacion  : Mayo 2002
-- * Responsable    :
-- *************************************************************
     dias_Hibernacion NUMBER;
BEGIN
	    SELECT  num_dias_hibernacion INTO dias_Hibernacion
	    FROM al_usos a
	    WHERE a.COD_USO = v_cod_uso;

	    RETURN dias_Hibernacion;

END;
/
SHOW ERRORS
