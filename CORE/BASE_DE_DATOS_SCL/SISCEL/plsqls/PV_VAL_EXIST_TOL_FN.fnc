CREATE OR REPLACE FUNCTION PV_VAL_EXIST_TOL_FN RETURN VARCHAR2 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * FUNCION            : PV_VAL_EXIST_TOL_FN
-- * Descripcion        : Retorna TRUE o FALSE dependiendo si esta Tol On-Line (Si = true)
-- * Fecha de creacion  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************
		sVALOR GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		BEGIN
		   SELECT VAL_PARAMETRO INTO sVALOR FROM ged_parametros WHERE nom_parametro = 'IND_TOL';
					IF sVALOR = 'S' THEN
					   RETURN 'TRUE';
					ELSE
					   RETURN 'FALSE';
					END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       RETURN 'FALSE';
     WHEN OTHERS THEN
       RETURN 'ERROR';
END PV_VAL_EXIST_TOL_FN;
/
SHOW ERRORS
