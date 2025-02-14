CREATE OR REPLACE PROCEDURE PV_PR_INSMOVIMIENTOS(

    nNUM_OS		   	   IN NUMBER,	   -- Numero de Abonado
	dFEC_EJECUCION	   IN DATE,		   -- Fecha de Ejecución
	nORD_COMANDO	   IN NUMBER,	   --
	vCOD_ACTABO		   IN VARCHAR2,	   -- Código de Actuación
	vCOD_SERVICIO	   IN VARCHAR2,	   -- Código de Servicio
	nCOD_ERROR		   OUT VARCHAR2,     -- Codigo de Error
	vMEN_ERROR		   OUT VARCHAR2    -- Mensaje de Error

)
IS

	--PV_PR_INSMOVIMIENTOS; v1.1; RA-200601030468: German Espinoza Z; 06/01/2006

  	-- Declaraciones
	sNOM_PROC		 VARCHAR2(50);  -- número de error
	sCOD_SQLCODE	 NUMBER;		-- Mensaje de error
	vFila			 ROWID;

	--RA-200601030468: German Espinoza Z; 06/01/2006
	--vValParam		 VARCHAR2(2);
	vValParam		 pv_movimientos.carga%TYPE;
	--FIN/RA-200601030468: German Espinoza Z; 06/01/2006

	nIndEstado 		 NUMBER(1);
	nValor_carga	 NUMBER;   -- Modificación - XO-200510170892 - 20-10-2005 - JJR.-
	nExiste_Valor_carga	 NUMBER;   -- Modificación - XO-200510170892 - 20-10-2005 - JJR.-

	ERROR_PROCESO 	 EXCEPTION;

BEGIN
	 nValor_carga := 0;-- Modificación - XO-200510170892 - 20-10-2005 - JJR.-
	 nExiste_Valor_carga := 0;-- Modificación - XO-200510170892 - 20-10-2005 - JJR.-
   	 nCOD_ERROR := '0';
	 vMEN_ERROR	 := 'Operación Exitosa';

	 BEGIN

   	 	  nCOD_ERROR := '1';
	 	  vMEN_ERROR := 'Antes de Obtención de Parametro';

	 	  PV_PR_DEVVALPARAM('GA',1,'ESTADOMOVBATCH',vValParam);

		  nIndEstado:=to_number(vValParam);

		  -- Inicio Modificación - XO-200510170892 - 20-10-2005 - JJR.-
		  PV_PR_DEVVALPARAM('GA',1,'CARGA_PV_MOVIMIENTOS',vValParam);

		  nValor_carga:=to_number(vValParam);
		  -- Fin Modificación - XO-200510170892 - 20-10-2005 - JJR.-

   	 	  nCOD_ERROR := '2';
	 	  vMEN_ERROR := 'Antes de Busqueda en PV_MOVIMIENTOS';

	 	  --SELECT ROWID -- Modificación - XO-200510170892 - 20-10-2005 - JJR.-
		  --INTO vFila	 -- Modificación - XO-200510170892 - 20-10-2005 - JJR.-
		  SELECT ROWID, NVL(CARGA,0)
		  INTO vFila, nExiste_Valor_carga
		  FROM PV_MOVIMIENTOS
		  WHERE NUM_OS=nNUM_OS
		  AND ORD_COMANDO=nORD_COMANDO;

   	 	  nCOD_ERROR := '3';
	 	  vMEN_ERROR := 'Antes de Actualizar en PV_MOVIMIENTOS';

		  -- Inicio Modificación - XO-200510170892 - 20-10-2005 - JJR.-
		  IF vCOD_ACTABO = 'AM' AND nExiste_Valor_carga < 1 THEN
		  	 	UPDATE PV_MOVIMIENTOS
		  	  		 SET F_EJECUCION=SYSDATE,
				 	 COD_ACTABO=vCOD_ACTABO,
					 COD_SERVICIO=vCOD_SERVICIO,
					 IND_ESTADO=nIndEstado,
					 CARGA = nValor_carga
			 		 WHERE ROWID=vFila;
		  ELSE
		  	  UPDATE PV_MOVIMIENTOS
		  	  		 SET F_EJECUCION=SYSDATE,
				 	 COD_ACTABO=vCOD_ACTABO,
					 COD_SERVICIO=vCOD_SERVICIO,
					 IND_ESTADO=nIndEstado
			  WHERE ROWID=vFila;
		  END IF;
		  -- Fin Modificación - XO-200510170892 - 20-10-2005 - JJR.-
	 EXCEPTION
	 	  WHEN NO_DATA_FOUND THEN
		  BEGIN

		     	  nCOD_ERROR := '4';
	 	  		  vMEN_ERROR := 'Antes de Insertar en PV_MOVIMIENTOS';

				  -- Inicio Modificación - XO-200510170892 - 20-10-2005 - JJR.-
				  IF vCOD_ACTABO = 'AM' THEN
		  		  	   INSERT INTO pv_movimientos(num_os,f_ejecucion,ord_comando,cod_actabo,
		  		  	   cod_servicio,ind_estado,fec_expira,resp_central,num_movimiento, carga)
				  	   VALUES(nNUM_OS,SYSDATE, nORD_COMANDO,vCOD_ACTABO,vCOD_SERVICIO,nIndEstado,NULL, NULL,NULL,nValor_carga);
				  ELSE
		  		  	   INSERT INTO pv_movimientos(num_os,f_ejecucion,ord_comando,cod_actabo,
		  		  	   cod_servicio,ind_estado,fec_expira,resp_central,num_movimiento)
				  	   VALUES(nNUM_OS,SYSDATE, nORD_COMANDO,vCOD_ACTABO,vCOD_SERVICIO,nIndEstado,NULL, NULL,NULL);
				  END IF;
				  -- Fin Modificación - XO-200510170892 - 20-10-2005 - JJR.-
		  EXCEPTION
		  		WHEN OTHERS THEN
					 RAISE ERROR_PROCESO;
		  END;
	END;

   	nCOD_ERROR := '0';
	vMEN_ERROR := 'Operación Exitosa';

EXCEPTION

     WHEN ERROR_PROCESO THEN
	 	  ROLLBACK;


END PV_PR_INSMOVIMIENTOS;
/
SHOW ERRORS
