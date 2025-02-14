CREATE OR REPLACE PROCEDURE pv_AnulaSolBaja_pr( p_CodModulo IN pv_iorserv.cod_modulo%TYPE,	 --codigo de modulo
							  					p_numFicha  IN pv_iorserv.id_gestor%TYPE, 	 --Numero de ficha enviada desde el gestor de retenciones
							  					p_Usuario   IN VARCHAR2, --Usuario
												Error			   OUT VARCHAR2,
												Evento             OUT VARCHAR2,
												DesError           OUT VARCHAR2
																			  	) IS
v_nNum_OOSS 	  pv_iorserv.NUM_OS%TYPE;

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

	BEGIN

	    SELECT num_os
	    INTO v_nNum_OOSS
	    FROM PV_IORSERV
	    WHERE cod_modulo = p_CodModulo
	    AND id_gestor = p_numFicha;

	    UPDATE pv_solicitud_bajas_to
	    SET cod_estado = '3'
	    WHERE num_os = v_nNum_OOSS;

		EXCEPTION
    			 WHEN NO_DATA_FOUND THEN
	   			 BEGIN

	   	   		 	  Error := 'Falso';
	   				  DesError := 'No se encontro el numero de OOSS para la Ficha y Modulo entregados';

            		  IF NOT Graba_Error('PV_IORSERV', -20300, DesError, p_Usuario, Evento) THEN
		   	   		  	 RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
					  END IF;
	   			 END;

    	   		 WHEN OTHERS THEN
		 		 BEGIN

	   	 	  	 	  Error := 'Falso';
	   		  		  DesError := SQLERRM;

	   	 	  		  IF NOT Graba_Error('PV_SOLICITUD_BAJAS_TO', SQLCODE, DesError, p_Usuario, Evento) THEN
		   	   	 	  	 RAISE_APPLICATION_ERROR(-20098,'No es Posible Grabar el Error');
			  		  END IF;

	   END;
END;
/
SHOW ERRORS
