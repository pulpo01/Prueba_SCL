CREATE OR REPLACE FUNCTION FA_VAL_USUARIO_NCTOTAL_FN(
V_CODCLIENTE IN   VARCHAR2,
V_ORDENTOTAL IN   NUMBER) RETURN VARCHAR2 IS

vp_error          NUMBER(2);
gls_error         VARCHAR2(250);
ImpMax_Usuario    FA_CONTROLNC.IMP_MAXIMO%type;
dTotalAplicado    FA_APLICADONC.TOT_APLICADO%type;
AcumTotal         FA_HISTDOCU.Acum_NetoGrav%TYPE;
sFormatoFecha     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
usuario	          VARCHAR2(30);
fecha             VARCHAR(10);

ERROR_PROCESO     EXCEPTION;

BEGIN
        -- Recupera formato de fecha
        sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');

	    -- Recupera Usuario y Fecha actual
        BEGIN
       		SELECT USER, RTRIM(TO_CHAR(SYSDATE, sFormatofecha)) INTO usuario, fecha
			FROM   DUAL;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
                 vp_error := 2;
				 gls_error := 'Error.No se puede obtener la fecha actual Msj1';
				 RETURN gls_error;
                 RAISE ERROR_PROCESO;
			WHEN OTHERS THEN
		    	 vp_error := 2;
		         gls_error := 'Problemas al recuperar Usuario y Fecha actual de "DUAL". ERROR : ['|| to_char(SQLCODE)||']=['||SQLERRM||']';
			     RETURN gls_error;
		         RAISE ERROR_PROCESO;
		END;


        -- Recupera el Importe Maximo del Usuario para generar Notas de credito
		BEGIN
		    SELECT Imp_Maximo INTO ImpMax_Usuario FROM FA_CONTROLNC
	        WHERE Nom_Usuario = usuario                      AND
			      FEC_DESDE <= TO_DATE(fecha,sFormatoFecha)  AND
				  FEC_HASTA >= TO_DATE(fecha,sFormatoFecha);
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			     vp_error := 2;
			     gls_error := 'Error. Usuario ' || usuario || ' no tiene importe maximo para NC asignado Msj2';
				 RETURN gls_error;
			     RAISE ERROR_PROCESO;

			WHEN OTHERS THEN
		    	 vp_error := 2;
		         gls_error := 'Error al recuperar el importe maximo del usuario para generar N.Credito en tabla "FA_CONTROLNC". ERROR : ['|| to_char(SQLCODE)||']=['||SQLERRM||']';
				 RETURN gls_error;
		         RAISE ERROR_PROCESO;
        END;

		BEGIN
	        -- Recupera el monto aplicado de NC del usuario para un cliente determinado.
		    SELECT Tot_Aplicado INTO dTotalAplicado FROM FA_APLICADONC
	        WHERE Nom_Usuario = usuario                       AND
			      Cod_Cliente = V_CODCLIENTE                  AND
			      Fec_Inicio <= TO_DATE(fecha,sFormatoFecha)  AND
				  Fec_Fin    >= TO_DATE(fecha,sFormatoFecha);
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
			     dTotalAplicado := 0;

			WHEN OTHERS THEN
			     vp_error := 2;
			     gls_error := 'Problemas al recuperar Total aplicado de "FA_APLICADONC". ERROR : ['|| to_char(SQLCODE)||']=['||SQLERRM||']';
				 RETURN gls_error;
			     RAISE ERROR_PROCESO;
		END;

	    BEGIN
		    SELECT (Acum_NetoGrav + Acum_NetoNoGrav ) into AcumTotal
	    	FROM   FA_HISTDOCU
			Where Ind_OrdenTotal = V_ORDENTOTAL
			UNION ALL
			SELECT (Acum_NetoGrav + Acum_NetoNoGrav)
			FROM   FA_FACTDOCU_NOCICLO
			Where Ind_OrdenTotal = V_ORDENTOTAL;
	    EXCEPTION
			WHEN NO_DATA_FOUND THEN
			     vp_error := 2;
			     gls_error := 'Error. No se pudo recuperar montos originales del documento con Orden Total =' || V_ORDENTOTAL || ' Msj4';
				 RETURN gls_error;
			     RAISE ERROR_PROCESO;

			WHEN OTHERS THEN
	    	 vp_error := 2;
	         gls_error := 'Problemas al recuperar montos facturables en "FA_HISTDODU". ERROR : ['|| to_char(SQLCODE)||']=['||SQLERRM||']';
		     RETURN gls_error;
	         RAISE ERROR_PROCESO;
	    END;

	    IF AcumTotal + dTotalAplicado > ImpMax_Usuario THEN
		   vp_error := 2;
		   gls_error := 'Error. Se ha sobrepasado en el Limite Importe de NC para el Usuario (Cliente-Periodo) Msj5';
		   RETURN gls_error;
		   RAISE ERROR_PROCESO;
		ELSE
	  	   RETURN 'OK';
	    END IF;

	    RAISE ERROR_PROCESO;

EXCEPTION

		WHEN ERROR_PROCESO THEN
  	    IF vp_error = 0 THEN
             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(V_ORDENTOTAL), vp_error, gls_error);
        ELSE
             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(V_ORDENTOTAL), vp_error, gls_error);
        END IF;

		WHEN DUP_VAL_ON_INDEX THEN
             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(V_ORDENTOTAL), 1, 'Duplicado');
        WHEN NO_DATA_FOUND THEN
             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(V_ORDENTOTAL), 1, 'Datos No Fueron Encontrados');
        WHEN OTHERS THEN
 	         gls_error := 'Error en PL : "FA_VAL_USUARIO_NCTOTAL_FN". ERROR=[' || to_char(SQLCODE)||']=['||SQLERRM||']';
       	     INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(V_ORDENTOTAL), 1, gls_error);


END FA_VAL_USUARIO_NCTOTAL_FN;
/
SHOW ERRORS
