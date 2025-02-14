CREATE OR REPLACE PROCEDURE pv_InscribeBaja_pr (
	   	  		  							   	 NumAbonado 		IN NUMBER,
												 Error			    OUT VARCHAR,
	   	  		  								 Evento             OUT VARCHAR2,
												 DesError           OUT VARCHAR2
												 ) IS





   ERRO_AGREGA_INTERFAZ EXCEPTION;
   ERROR_MOD_PREPAGO    EXCEPTION;
   ERROR_MOD_POSTPAGO   EXCEPTION;
   NOT_DATA_ABONADO     EXCEPTION;




FUNCTION Graba_Error (NOM_TABLA   IN  VARCHAR2,
                      NumError    IN  NUMBER,
					  Descripcion IN  VARCHAR2,
					  EVENTO      OUT NUMBER
					  )  RETURN BOOLEAN IS

sNumProceso   VARCHAR2(25);
sTerminal     VARCHAR2(25);

BEGIN


   SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
   INTO sNumProceso, sTerminal
   FROM V$SESSION
   WHERE username = user AND status = 'ACTIVE';

   EVENTO:=GE_ERRORES_PG.GRABAR(0, 'PV','Error al recuperar el tipo de plan', '1',	user, sNumProceso,	sTerminal,
   'PL pv_InscribeBaja', NOM_TABLA, NumError, Descripcion);



		RETURN TRUE;

		EXCEPTION
          WHEN NO_DATA_FOUND THEN
		  	   RETURN FALSE;

		  WHEN OTHERS THEN
			  RETURN FALSE;


END Graba_Error;





FUNCTION PostPago(NumeroAbonado IN VARCHAR2)  RETURN BOOLEAN IS

v_codtiplan   VARCHAR2(5);

BEGIN


		SELECT b.cod_tiplan
        INTO   v_codtiplan
        FROM   ga_abocel a,
               ta_plantarif b
        WHERE  a.cod_producto = b.cod_producto
        AND    a.cod_plantarif = b.cod_plantarif
        AND    a.num_abonado = NumeroAbonado
    	AND   (b.cod_tiplan = ( SELECT VAL_PARAMETRO
    		       		        FROM   GED_PARAMETROS
    		    			    WHERE  COD_PRODUCTO  = 1
    		   				    AND    COD_MODULO    = 'GA'
    		   				    AND    NOM_PARAMETRO = 'TIPOPOSTPAGO')
    		  OR
    		  b.cod_tiplan = ( SELECT VAL_PARAMETRO
    					       FROM   GED_PARAMETROS
    						   WHERE  COD_PRODUCTO  = 1
    						   AND    COD_MODULO    = 'GA'
    						   AND    NOM_PARAMETRO = 'TIPOHIBRIDO'))
        AND (a.cod_situacion = 'AAA' or a.cod_situacion = 'SAA')
    	AND a.ind_disp = 1;


		RETURN TRUE;

		EXCEPTION
          WHEN NO_DATA_FOUND THEN
		  	   RETURN FALSE;

		  WHEN OTHERS THEN
			  RAISE_APPLICATION_ERROR(-20100,'No es Posible Recuperar Abonado');


END PostPago;



FUNCTION PrePago(NumeroAbonado IN VARCHAR2)  RETURN BOOLEAN IS

v_codtiplan   VARCHAR2(5);

BEGIN


		SELECT b.cod_tiplan
     		  INTO   v_codtiplan
              FROM   ga_aboamist a,
   		             ta_plantarif b
              WHERE  a.cod_producto = b.cod_producto
              AND    a.cod_plantarif = b.cod_plantarif
              AND    a.num_abonado = NumeroAbonado
   			  AND    b.cod_tiplan = ( SELECT VAL_PARAMETRO
   						              FROM   GED_PARAMETROS
   							          WHERE  COD_PRODUCTO  = 1
   							          AND    COD_MODULO    = 'GA'
   							          AND    NOM_PARAMETRO = 'TIPOPREPAGO')
   			  AND  ( a.cod_situacion = 'AAA' or a.cod_situacion = 'SAA')
   			  AND    a.ind_disp = 1;


       RETURN TRUE;

	   EXCEPTION
          WHEN NO_DATA_FOUND THEN
		  	   RETURN FALSE;

		  WHEN OTHERS THEN
		  	   RAISE_APPLICATION_ERROR(-20100,'No es Posible Recuperar Abonado');

END PrePago;


FUNCTION ModificaPrePago(NumeroAbonado IN VARCHAR2)  RETURN BOOLEAN IS
BEGIN

	   UPDATE ga_aboamist
   	   SET    cod_situacion = 'BAP',
   	   fec_ultmod = sysdate
   	   WHERE  num_abonado = NumeroAbonado;



       RETURN TRUE;

	   EXCEPTION
	   WHEN OTHERS THEN
        	BEGIN
           		 RETURN FALSE;
			END;

END ModificaPrePago;


FUNCTION ModificaPosPago(NumeroAbonado IN VARCHAR2)  RETURN BOOLEAN IS
BEGIN

	   UPDATE ga_abocel
       SET cod_situacion = 'BAP',
       fec_ultmod = sysdate
       WHERE num_abonado = NumeroAbonado;



       RETURN TRUE;

	   EXCEPTION
	   WHEN OTHERS THEN

          RETURN FALSE;

END ModificaPosPago;


FUNCTION AgregaInterfaz(NumeroAbonado IN VARCHAR2)  RETURN BOOLEAN IS
BEGIN

	   INSERT INTO pv_interfaz_prepago_to(num_abonado, fec_ejecucion, cod_estado, cod_actabo,
	   fec_proceso, nom_usuario, cod_causa, ind_central)
	   VALUES(NumeroAbonado, sysdate, 0, 'BP', sysdate, user, '10', 1);



       RETURN TRUE;

	   EXCEPTION
	   WHEN OTHERS THEN
          RETURN FALSE;

END AgregaInterfaz;


   BEGIN


		IF PrePago(NumAbonado) THEN

		      IF ModificaPrePago(NumAbonado) Then

			  	 IF NOT AgregaInterfaz(NumAbonado) THEN

				 	 RAISE ERRO_AGREGA_INTERFAZ;

				 END IF;

			  ELSE

			  	  RAISE ERROR_MOD_PREPAGO;

			  END IF;

		ELSIF PostPago(NumAbonado) THEN

			 IF ModificaPosPago(NumAbonado) THEN

			 	IF NOT AgregaInterfaz(NumAbonado) THEN

				   RAISE ERRO_AGREGA_INTERFAZ;

				END IF;

			 ELSE

			 	 RAISE ERROR_MOD_POSTPAGO;

			 END IF;

		ELSE

			RAISE NOT_DATA_ABONADO;

		END IF;


   EXCEPTION

   WHEN NOT_DATA_ABONADO     THEN
   BEGIN
   		Error       := 'Falso';
	   	DesError    := 'No se Encontraron Datos para el Abonado';

		IF NOT Graba_Error('GA_ABOAMIST - GA_ABOCEL', -20001, DesError, Evento) THEN
		   RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		END IF;

   END;

   WHEN ERRO_AGREGA_INTERFAZ THEN
   BEGIN

   		Error       := 'Falso';
	   	DesError    := 'No es Posible Agregar la Interfaz de Prepago';

		IF NOT Graba_Error('PV_INTERFAZ_PREPAGO_TO', -20002, DesError, Evento) THEN
		   RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		END IF;

   END;

   WHEN ERROR_MOD_PREPAGO    THEN
   BEGIN
   		Error       := 'Falso';
	   	DesError    := 'No es Posible Modificar la Situacion de Abonado Prepago';

		IF NOT Graba_Error('GA_ABOAMIST', -20003, DesError, Evento) THEN
		   RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		END IF;

   END;

   WHEN ERROR_MOD_POSTPAGO   THEN
   BEGIN
   		Error       := 'Falso';
	   	DesError    := 'No es Posible Modificar la Situacion de Abonado PostPago';

		IF NOT Graba_Error('GA_ABOCEL', -20004, DesError, Evento) THEN
		   RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		END IF;

   END;

   WHEN OTHERS THEN
   BEGIN
   		Error := 'Falso';
		DesError := SQLERRM;

		IF NOT Graba_Error('GA_ABOCEL', SQLCODE, DesError, Evento) THEN
		   RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
		END IF;
   END;



END;
/
SHOW ERRORS
