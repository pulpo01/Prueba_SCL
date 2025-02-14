CREATE OR REPLACE PROCEDURE p_select_actuacion(
  v_actuacion IN OUT ga_actabo.cod_actcen%TYPE ,
  p_terminal  IN al_tipos_terminales.tip_terminal%TYPE,
  v_Central   IN icg_central.cod_central%TYPE)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : p_select_actuacion
-- * Descripcisn        : Proceso seleccionar actuacion
-- * Fecha de creacisn  : Febrero 2000
-- * Responsable        : Thomas Armstrong (DMR Consulting)
-- *************************************************************

  v_CodSimGsm  al_tipos_terminales.tip_terminal%TYPE;
  v_tecnologia al_Tecnologia.cod_tecnologia%TYPE;

BEGIN
   SELECT val_parametro
   INTO  v_CodSimGsm
   FROM ged_parametros
   WHERE cod_producto=1 AND
         cod_modulo='AL' AND
                 nom_parametro='COD_SIMCARD_GSM';
   BEGIN
	    SELECT cod_tecnologia
		  INTO   v_tecnologia
		  FROM   icg_central
	     WHERE  cod_central = v_central;
		EXCEPTION
    	   WHEN NO_DATA_FOUND THEN
	   	v_tecnologia := null;
   END;

   IF ( p_terminal = v_CodSimGsm ) THEN
   	  BEGIN
		 SELECT cod_actcen
		 INTO   v_actuacion
		 FROM   ga_actabo
		 WHERE  cod_modulo ='AL'
		 AND    cod_producto = 1
	     AND    cod_tecnologia =v_tecnologia
		 AND    cod_actabo ='DG';
      EXCEPTION
    	WHEN NO_DATA_FOUND THEN
    	v_actuacion := null;
      END;
   ELSE
   	   BEGIN
		 SELECT cod_actcen
		 INTO   v_actuacion
		 FROM   ga_actabo
		 WHERE  cod_modulo ='AL'
		 AND    cod_producto = 1
	     AND    cod_tecnologia =v_tecnologia
		 AND    cod_actabo ='MI';
      EXCEPTION
    	WHEN NO_DATA_FOUND THEN
    	v_actuacion := null;
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20199,'Error Captura Actuacion Central');
END p_select_actuacion;
/
SHOW ERRORS
