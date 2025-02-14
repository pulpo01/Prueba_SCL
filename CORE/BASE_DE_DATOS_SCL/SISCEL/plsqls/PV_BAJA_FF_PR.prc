CREATE OR REPLACE procedure PV_BAJA_FF_PR
(                         VP_CLIENTE IN NUMBER,
                          VP_ABONADO IN NUMBER,
                          VP_ERROR IN OUT VARCHAR2)
IS
--
-- *************************************************************
-- * procedimiento      : PV_BAJA_FF_PR
-- * Descripcisn        : Procedimiento que realiza borrado de registros de ga_numespabo
-- *                      de los enlaces que tienen que ver con abonado que se da de baja
-- * Fecha de creacion  : 26-08-2003
-- * Responsable        : Alejandro Hott - Soporte - CH-140820031203
-- *************************************************************
--
--
  CURSOR CUR_FF IS
	SELECT NUM_ABONADO,NUM_CELULAR
	FROM GA_ABOCEL WHERE COD_CLIENTE = VP_CLIENTE
	AND NUM_ABONADO != VP_ABONADO
	AND COD_SITUACION = 'AAA';
  	V_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
BEGIN
   BEGIN
   	SELECT NUM_CELULAR INTO V_CELULAR
   	FROM GA_ABOCEL WHERE NUM_ABONADO = VP_ABONADO;
   	DELETE GA_NUMESPABO WHERE
   	NUM_ABONADO = VP_ABONADO;
   EXCEPTION
   	WHEN NO_DATA_FOUND THEN
   	     dbms_output.put_line('Datos no encontrados');
   	WHEN OTHERS THEN
   	     dbms_output.put_line('Error desconocido');
   END;
   FOR C1 IN CUR_FF LOOP
   	BEGIN
	    DELETE GA_NUMESPABO
	    WHERE NUM_ABONADO = C1.NUM_ABONADO
	    AND NUM_TELEFESP = V_CELULAR;
   	EXCEPTION
   	    WHEN NO_DATA_FOUND THEN
   		dbms_output.put_line('Datos no encontrados para borrar en GA_NUMESPABO');
   	    WHEN OTHERS THEN
   	    	dbms_output.put_line('Error desconocido al borrar en GA_NUMESPABO');
   	END;
   END LOOP;
 /*INICIO CH-110920031315 12-09-2003 Marcelo Miranda
   UPDATE GA_INTARCEL
   SET IND_FRIENDS = 0
   WHERE NUM_ABONADO = VP_ABONADO
   AND COD_CLIENTE = VP_CLIENTE;
  FIN CH-110920031315 12-09-2003 Marcelo Miranda*/
   VP_ERROR := '0';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
         VP_ERROR := '4';
   WHEN OTHERS THEN
        VP_ERROR := '4';
END;
/
SHOW ERRORS
