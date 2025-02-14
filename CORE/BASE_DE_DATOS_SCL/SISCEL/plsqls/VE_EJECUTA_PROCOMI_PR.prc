CREATE OR REPLACE PROCEDURE VE_EJECUTA_PROCOMI_PR( P_NNUMVENTA IN NUMBER )

IS
--
--Desarrollo :   Optimizacion del Circuito de la venta
--Procedure  :   VE_EJECUTA_PROCOMI_PR -
--Descripcion:   Proceso que ejecuta procesos omitidos
--Parametros :   Numero de la Venta
--Retorno    :   O_ERROR
--               '0'   se hizo todo correcto
--               '1'   se produjeron errores
--
--Ejemplo v_ProcOmitido:
--VE_REGULA_DATOS_PROCESOS_PR('56327116','GAC1034','O',2753906,'','','PA','','',:1,:2) --
--DBMS_OUTPUT.PUT_LINE('PL :' || v_ProcOmitido);

v_Orden       VE_PROCESOSOMITIDOS_TO.ORDEN%TYPE;
v_FecActCen   GA_ABOCEL.FEC_ACTCEN%TYPE;
v_ProcOmitido VE_PROCESOSOMITIDOS_TO.PROCEDIMIENTO%TYPE;

v_bProcesar  BOOLEAN;
v_bSinError  BOOLEAN;
v_sCodError  VARCHAR2(2);
v_sDesError  VARCHAR2(200);
v_sPL        VARCHAR2(300);
v_Secuencia  NUMBER;


CURSOR c_cada_abonados IS
SELECT FEC_ACTCEN
  FROM GA_ABOCEL
 WHERE NUM_VENTA = P_NNUMVENTA;

CURSOR c_cada_proc IS
SELECT ORDEN, PROCEDIMIENTO
  FROM VE_PROCESOSOMITIDOS_TO
 WHERE NUM_VENTA = P_NNUMVENTA
ORDER BY ORDEN;

BEGIN

	 v_bProcesar:=TRUE;

	-- preparando cursor para carga de arreglo cod_paramdir
	--Revisa que todos sus abonados esten activados en centrales --
	OPEN c_cada_abonados;
	LOOP
		FETCH c_cada_abonados INTO v_FecActCen;
		EXIT WHEN c_cada_abonados%NOTFOUND;
		BEGIN
			IF v_FecActCen IS NULL THEN
			   v_bProcesar:=FALSE;		   --No esta activo no se procesa los omitidos aun --
			END IF;
		END;
	END LOOP;
	CLOSE c_cada_abonados;

	IF v_bProcesar THEN

	 	--Estan Actualizados
		OPEN c_cada_proc;
		LOOP

			FETCH c_cada_proc INTO v_Orden, v_ProcOmitido;
			EXIT WHEN c_cada_proc%NOTFOUND;
			BEGIN

			    --Obtencion secuencia en ga_transacabo
				SELECT GA_SEQ_TRANSACABO.NEXTVAL
				INTO v_Secuencia
				FROM DUAL;

			 	 v_sPL := 'BEGIN ' || v_ProcOmitido || '; END;' ;

				 -- en caso de error
				 --     actualizar observaciones en el registro
				 --todo ok se elimina registro

				BEGIN
					EXECUTE IMMEDIATE v_sPL USING IN v_Secuencia, OUT v_sCodError, OUT v_sDesError;

					v_bSinError:= v_sCodError = '0' or v_sCodError = '' or v_sCodError is null;

				EXCEPTION
					WHEN OTHERS THEN
					   v_bSinError:= FALSE;
					   --v_sCodError:= SQLCODE;
					   v_sDesError:= SQLERRM;

						UPDATE VE_PROCESOSOMITIDOS_TO
						   SET OBSERVACION = SUBSTR('Error :' || v_sCodError || ' ' || v_sDesError,1,99)
						 WHERE NUM_VENTA = P_NNUMVENTA
						   AND ORDEN = v_Orden;

					   RAISE_APPLICATION_ERROR  (-20002,'ERROR EN PL (VE_EJECUTA_PROCOMI_PR): ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
				END;

				IF v_bSinError THEN

					DELETE FROM VE_PROCESOSOMITIDOS_TO
					 WHERE NUM_VENTA = P_NNUMVENTA
					   AND ORDEN = v_Orden;

				ELSE

					UPDATE VE_PROCESOSOMITIDOS_TO
					   SET OBSERVACION = SUBSTR('Error :' || v_sCodError || ' ' || v_sDesError,1,99)
					 WHERE NUM_VENTA = P_NNUMVENTA
					   AND ORDEN = v_Orden;

				    RAISE_APPLICATION_ERROR  (-20002,'ERROR EN PL (VE_EJECUTA_PROCOMI_PR): ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

				END IF;

			END;
		END LOOP;
		CLOSE c_cada_proc;

	END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
        NULL;
   WHEN OTHERS THEN
   	   RAISE_APPLICATION_ERROR  (-20002,'ERROR EN PL (VE_EJECUTA_PROCOMI_PR): ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
       NULL;
END VE_EJECUTA_PROCOMI_PR;
/
SHOW ERRORS
