CREATE OR REPLACE PROCEDURE pv_ActivaSolBaja_pr(
			  							p_CodModulo		   IN pv_iorserv.cod_modulo%TYPE,	 --codigo de modulo
										p_numFicha	       IN pv_iorserv.id_gestor%TYPE, 	 --Numero de ficha enviada desde el gestor de retenciones
										p_Usuario 		   IN VARCHAR2,	 --Usuario
										Error			   OUT VARCHAR2,
	   	  		  						Evento             OUT VARCHAR2,
										DesError           OUT VARCHAR2
										)

		/******************************************************************************
		AUTOR    : ALEJANDRA MONTEALEGRE G
		AREA     : GERENCIA DESARROLLO
		EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
		VERSION	 : 1.0
		******************************************************************************/

	IS
		ERROR_PROCESO EXCEPTION;

		v_nNum_OOSS 	  pv_iorserv.NUM_OS%TYPE;
		INSTANCIA         EXCEPTION;
		SOLIBAJA          EXCEPTION;
		NOOSS             EXCEPTION;







/*******************************************************************************************************************/
/*******************************************************************************************************************/
/* Funcion Graba_Error: Esta funcion Graba un Error en la BD            										   */
/*																												   */
/*******************************************************************************************************************/
/*******************************************************************************************************************/

   FUNCTION Graba_Error (NOM_TABLA   IN  VARCHAR2,
                      NumError    IN  NUMBER,
					  Descripcion IN  VARCHAR2,
					  Usuario     IN  VARCHAR2,
					  EVENTO      OUT NUMBER
					  )  RETURN BOOLEAN IS

   sNumProceso   VARCHAR2(25);
   sTerminal     VARCHAR2(50);

   BEGIN


   		SELECT NVL(process,'NO PROCESS'), NVL(terminal,'NO TERMINAL')
   		INTO sNumProceso, sTerminal
   		FROM V$SESSION
   		WHERE username = Usuario AND status = 'ACTIVE';

   		EVENTO:=GE_ERRORES_PG.GRABAR(0, 'PV', 'Ejecucion Procedimiento de Activacion de Solictud de baja: pv_ActivaSolBaja_pr', '1',
		                             Usuario, sNumProceso, sTerminal, 'PL pv_ActivaSolBaja_pr', NOM_TABLA, NumError, Descripcion);

		RETURN TRUE;

		EXCEPTION

		WHEN NO_DATA_FOUND THEN
		  	 RETURN FALSE;

		WHEN OTHERS THEN
		     RETURN FALSE;

   END Graba_Error;


/*******************************************************************************************************************/
/*******************************************************************************************************************/
/* Funcion RecuperaNOOSS: Esta funcion Recupera un numero de OOSS	     										   */
/*																												   */
/*******************************************************************************************************************/
/*******************************************************************************************************************/

   FUNCTION RecuperaNOOSS (CodModulo   IN  VARCHAR2,
                           NumFicha    IN  NUMBER,
					       NumOOSS     OUT NUMBER
					      )  RETURN BOOLEAN IS
   BEGIN

        SELECT num_os
		INTO NumOOSS
		FROM PV_IORSERV
		WHERE cod_modulo = CodModulo
		AND id_gestor = p_numFicha;


		RETURN TRUE;

		EXCEPTION

		WHEN NO_DATA_FOUND THEN
		  	 RETURN FALSE;

		WHEN OTHERS THEN
		     RETURN FALSE;

	END RecuperaNOOSS;



/*******************************************************************************************************************/
/*******************************************************************************************************************/
/* Funcion RecuperaNOOSS: Esta funcion Modifica	 Solicitudes de Baja de Abonado    		    					   */
/*																												   */
/*******************************************************************************************************************/
/*******************************************************************************************************************/

   FUNCTION ModificarSolicitudbaja (NumOOSS IN NUMBER) RETURN BOOLEAN IS

   BEGIN

        UPDATE pv_solicitud_bajas_to
		SET cod_estado = '10'
		WHERE num_os = NumOOSS;


		RETURN TRUE;

		EXCEPTION

		WHEN OTHERS THEN
		     RETURN FALSE;

	END ModificarSolicitudbaja;


/*******************************************************************************************************************/
/*******************************************************************************************************************/
/* Funcion ModificarInstanciasOOSS: Esta funcion Modifica Instancias De Ordenes De Servicio	    				   */
/*																												   */
/*******************************************************************************************************************/
/*******************************************************************************************************************/

    FUNCTION ModificarInstanciasOOSS (NumOOSS IN NUMBER) RETURN BOOLEAN IS

    BEGIN

        	UPDATE pv_iorserv
			SET cod_estado = '10'
			WHERE num_os = NumOOSS;


		RETURN TRUE;

		EXCEPTION

		WHEN OTHERS THEN
		     RETURN FALSE;

	END ModificarInstanciasOOSS;




	BEGIN

		IF RecuperaNOOSS(p_CodModulo, p_numFicha, v_nNum_OOSS) THEN

		   IF ModificarSolicitudbaja(v_nNum_OOSS) THEN

		   	  IF NOT ModificarInstanciasOOSS(v_nNum_OOSS) THEN

				 RAISE INSTANCIA;

			  END IF;

		   ELSE

			   RAISE SOLIBAJA;

		   END IF;

		ELSE

			RAISE NOOSS;

		END IF;

	EXCEPTION
	    WHEN INSTANCIA THEN
		BEGIN
   			 Error       := 'Falso';
	   		 DesError    := 'No se Puede Modificar Instancias De Ordenes De Servicio.';

			 IF NOT Graba_Error('PV_IORSERV', -20330, DesError, p_Usuario, Evento) THEN
		   	 	RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
			 END IF;
        END;

		WHEN SOLIBAJA THEN
		BEGIN
   			 Error       := 'Falso';
	   		 DesError    := 'No se Puede Modificar Solicitud Baja Abonado.';

			 IF NOT Graba_Error('PV_SOLICITUD_BAJAS_TO', -20331, DesError, p_Usuario, Evento) THEN
		   	 	RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
			 END IF;
        END;

        WHEN NOOSS THEN
	    BEGIN
			 Error       := 'Falso';
	   		 DesError    := 'No se Puede Obtener OOSS';

			 IF NOT Graba_Error('PV_IORSERV', -20332, DesError, p_Usuario, Evento) THEN
		   	 	RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
			 END IF;
        END;
	END pv_ActivaSolBaja_pr;
/
SHOW ERRORS
