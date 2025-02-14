CREATE OR REPLACE PROCEDURE Pv_Pr_Abominutos(
    nNUM_ABONADO  	   IN NUMBER,	   -- Numero de Abonado
	nCOD_CICLO  	   IN NUMBER,	   -- Codigo de Ciclo Abonado
	nNUM_PERAFEC 	   IN NUMBER, 	   -- Numero de Periodos Afectos
	nNUM_MINUTOS  	   IN NUMBER,	   -- Numero de Minutos
	vNOM_USUARORA  	   IN VARCHAR2,    -- Usuario Responsable
	vTIP_PLANTARIF     IN VARCHAR2,    -- Tipo de Plan Tarifario
    vCOD_PLANTARIF     IN VARCHAR2,    -- Codigo de Plan Tarifario
	nCOD_VENDEDOR      IN NUMBER,	   -- Codigo de Vendedor
	vACTUACION 		   IN VARCHAR2,    -- Codigo de Actuacion
	nNUM_OOSS 		   IN NUMBER,      -- Numero de Solicitud de OOSS
	sCOD_OPER		   IN VARCHAR2,	   -- Tipo de Operacion Agregar o Actualizar
	nCOD_EMPRESA	   IN NUMBER,	   -- Codigo de Empresa
	nERROR			   OUT NUMBER,     -- Codigo de Error
	vMsgError		   OUT VARCHAR2    -- Mensaje de Error
)
IS

  	-- Declaraciones

    nCodCiclFact	 FA_CICLFACT.COD_CICLFACT%TYPE;  	  -- almacena periodo actual de facturacion
	nNumError 		 NUMBER (1);    					  -- numero de error
	nMinutos		 GA_DTOSTARIF.NUM_MINUTOS%TYPE;		  -- Minutos a Asignar
	sMsgError 		 VARCHAR2(50);  					  -- Mensaje de error
	vCodSujeto		 GA_ABOCEL.NUM_ABONADO%TYPE;		  -- Sujeto Empresa o Abonado
	vFecSys			 DATE;								  -- Fecha Sistema
	sRowid			 ROWID;

	sNOM_TABLA 	 	 GA_ERRORES.NOM_TABLA%TYPE;			  -- Tabla
	sNOM_PROC	 	 GA_ERRORES.NOM_PROC%TYPE;			  -- Nombre Proceso
	sCOD_ACT	 	 GA_ERRORES.COD_ACT%TYPE;			  -- Accion
	sCOD_SQLCODE 	 GA_ERRORES.COD_SQLCODE%TYPE;		  -- Codigo Error Oracle
	sCOD_SQLERRM 	 GA_ERRORES.COD_SQLERRM%TYPE;		  -- Mensaje Error Oracle

	ERROR_PROCESO 	 EXCEPTION;

    CURSOR cur_ciclfact IS
	SELECT COD_CICLFACT
	FROM FA_CICLFACT
	WHERE COD_CICLO = nCOD_CICLO
	AND TRUNC(FEC_DESDELLAM) > TRUNC(SYSDATE)
	AND IND_FACTURACION = 0
	AND ROWNUM <= nNUM_PERAFEC
	ORDER BY FEC_DESDELLAM;


BEGIN

	 -- Inicializacion de Variables

   	 nNumError := 0;
	 sMsgError := 'Operacion Exitosa';
	 sNOM_PROC:='ABONO_MINUTOS';
	 vFecSys:=SYSDATE;


	 -- Seleccion del Sujeto

	 IF vTIP_PLANTARIF ='E' THEN
	 BEGIN

	 	  vCodSujeto:=nCOD_EMPRESA; -- Empresa

	 	  nNumError := 1;
		  sMsgError := 'Error al ingresar datos en GA_MODCLI';
		  sNOM_TABLA:='GA_MODCLI';
		  sCOD_ACT:='I';

		  INSERT INTO GA_MODCLI(COD_CLIENTE, COD_TIPMODI, FEC_MODIFICA, COD_EMPRESA,
		  COD_PLANTARIF, COD_CARGOBASICO,COD_CICLO,NOM_USUARORA,NUM_OS, NUM_CICLOS,
		  NUM_MINUTOS)
		  SELECT A.COD_CLIENTE, vACTUACION, vFecSys,vCodSujeto,A.COD_PLANTARIF,
		  B.COD_CARGOBASICO,A.COD_CICLO,vNOM_USUARORA,nNUM_OOSS,nNUM_PERAFEC,
		  nNUM_MINUTOS
		  FROM GA_EMPRESA A, TA_PLANTARIF B
		  WHERE A.COD_EMPRESA=vCodSujeto
		  AND A.COD_PRODUCTO=B.COD_PRODUCTO
		  AND A.COD_PLANTARIF=B.COD_PLANTARIF;

	EXCEPTION
		WHEN OTHERS THEN

			 RAISE ERROR_PROCESO;
	END;
	ELSE
	BEGIN

	 	vCodSujeto:=nNUM_ABONADO; --Abonado

	 	-- Ingresar datos a GA_MODABOCEL para Consulta

	 	nNumError := 2;
		sMsgError := 'Error al ingresar datos en GA_MODABOCEL';
		sNOM_TABLA:='GA_MODABOCEL';
		sCOD_ACT:='I';

		INSERT INTO GA_MODABOCEL(NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NUM_CELULAR,
		TIP_PLANTARIF, COD_PLANTARIF,COD_CARGOBASICO,COD_CICLO,COD_TIPCONTRATO,
		IND_EQPRESTADO,NOM_USUARORA,NUM_OS, NUM_CICLOS,NUM_MINUTOS)
		SELECT vCodSujeto, vACTUACION, SYSDATE, NUM_CELULAR,
		TIP_PLANTARIF,COD_PLANTARIF,COD_CARGOBASICO,COD_CICLO,COD_TIPCONTRATO,
		IND_EQPRESTADO,vNOM_USUARORA,nNUM_OOSS,nNUM_PERAFEC, nNUM_MINUTOS
		FROM GA_ABOCEL A
		WHERE NUM_ABONADO=vCodSujeto;


    EXCEPTION

		WHEN OTHERS THEN
			RAISE ERROR_PROCESO;
    END;
	END IF;


   	 -- Obtencion de periodo actual de facturacion

     BEGIN

    	nNumError := 3;
		sMsgError := 'Error al obtener periodo actual de Facturacion';
		sNOM_TABLA:='FA_CICLFACT';
		sCOD_ACT:='S';

		SELECT COD_CICLFACT
		INTO nCodCiclFact
		FROM FA_CICLFACT
		WHERE COD_CICLO = nCOD_CICLO
    	AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

	 EXCEPTION
			 WHEN OTHERS THEN
				  RAISE ERROR_PROCESO;
	 END;

	 -- Seleccion de Operacion

	 IF sCOD_OPER ='AC' THEN
 	 BEGIN

	 	  -- Los datos a actualizar se traspsan a  GA_HDTOSTARIF

	   	  nNumError := 4;
	   	  sMsgError := 'Error en Ingreso GA_HDTOSTARIF';
 	   	  sNOM_TABLA:='GA_HDTOSTARIF';
		  sCOD_ACT:='I';

	   	  INSERT INTO GA_HDTOSTARIF (NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS, TIP_PLANTARIF,
	   	  COD_VENDEDOR, NOM_USUARORA, FEC_GRABACION, FEC_BAJA)
	   	  SELECT NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS, TIP_PLANTARIF,
	   	  COD_VENDEDOR, NOM_USUARORA, FEC_GRABACION, SYSDATE
	   	  FROM GA_DTOSTARIF
	   	  WHERE NUM_ABONADO = nNUM_ABONADO
	   	  AND COD_CICLFACT <> nCodCiclFact
		  AND ROWNUM <= nNUM_PERAFEC;

		  -- Eliminacion de Registros desde GA_DTOSTARIF

	   	  nNumError := 5;
       	  sMsgError := 'Error al Eliminar Registro en GA_DTOSTARIF';
	  	  sNOM_TABLA:='GA_DTOSTARIF';
		  sCOD_ACT:='D';

	   	  DELETE GA_DTOSTARIF
	   	  WHERE NUM_ABONADO = nNUM_ABONADO
	   	  AND COD_CICLFACT <> nCodCiclFact
		  AND ROWNUM <= nNUM_PERAFEC;

		  --Ingreso de nuevos registros

 	  	  OPEN cur_ciclfact;
		  LOOP

		  	  FETCH cur_ciclfact INTO nCODCICLFACT;
			  EXIT WHEN cur_ciclfact%NOTFOUND;

			  BEGIN

			  	   nNumError := 6;
       		 	   sMsgError := 'Error al Insertar en GA_DTOSTARIF';
	  		 	   sNOM_TABLA:='GA_DTOSTARIF';
			 	   sCOD_ACT:='I';

       	  		   INSERT INTO GA_DTOSTARIF	(NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS,
           		   TIP_PLANTARIF, COD_VENDEDOR, NOM_USUARORA,FEC_GRABACION)
				   VALUES (vCodSujeto, nCODCICLFACT, nNUM_MINUTOS,vTIP_PLANTARIF,
				   nCOD_VENDEDOR, vNOM_USUARORA,vFecSys);

			  EXCEPTION
			  		   WHEN OTHERS THEN
					   		RAISE ERROR_PROCESO;
			  END;

		  END LOOP;

	 EXCEPTION
		  WHEN OTHERS THEN
			  RAISE ERROR_PROCESO;
     END;

	 ELSE -- Operacion Agregar AG

	  	  OPEN cur_ciclfact;
		  LOOP

		  	  FETCH cur_ciclfact INTO nCODCICLFACT;
			  EXIT WHEN cur_ciclfact%NOTFOUND;

  			  BEGIN

			  	   --Busqueda de registro exitente para agregar minutos

			  	   nNumError := 7;
       		 	   sMsgError := 'Error, Seleccionar desde GA_DTOSTARIF, Oper:ACT';
	  		 	   sNOM_TABLA:='GA_DTOSTARIF';
			 	   sCOD_ACT:='S';

   			  	   SELECT ROWID
			  	   INTO sRowid
			  	   FROM GA_DTOSTARIF
			  	   WHERE  NUM_ABONADO=vCodSujeto
			  	   AND COD_CICLFACT=nCODCICLFACT;

			  	   nNumError := 8;
       		 	   sMsgError := 'Error al Actualizar GA_DTOSTARIF,Oper:ACT';
	  		 	   sNOM_TABLA:='GA_DTOSTARIF';
			 	   sCOD_ACT:='U';

				   UPDATE GA_DTOSTARIF
				   		SET NUM_MINUTOS=NUM_MINUTOS + nNUM_MINUTOS,
							COD_VENDEDOR=nCOD_VENDEDOR,
							NOM_USUARORA=vNOM_USUARORA,
							FEC_GRABACION=vFecSys
				   WHERE ROWID=sRowid;

			  EXCEPTION

			  	   WHEN NO_DATA_FOUND THEN

				   		BEGIN

							 -- No existe periodo, se ingresa registro

				   			 nNumError := 9;
       		 	   			 sMsgError := 'Error al Insertar en GA_DTOSTARIF';
	  		 	   			 sNOM_TABLA:='GA_DTOSTARIF';
			 	   			 sCOD_ACT:='I';

       	  		   			 INSERT INTO GA_DTOSTARIF	(NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS,
           		   			 TIP_PLANTARIF, COD_VENDEDOR, NOM_USUARORA,FEC_GRABACION)
				   			 VALUES (vCodSujeto, nCODCICLFACT, nNUM_MINUTOS,vTIP_PLANTARIF,
				   			 nCOD_VENDEDOR, vNOM_USUARORA,SYSDATE );

				   		EXCEPTION

				   	  		WHEN OTHERS THEN
					  	   		 RAISE ERROR_PROCESO;
				   		END;

					WHEN OTHERS THEN

			  			 RAISE ERROR_PROCESO;
			  END;

		  END LOOP;
	 END IF; -- Operacion

 	nNumError:=0;
	sMsgError:='Operacion Exitosa';
	nERROR:=nNumError;
	vMsgError:=sMsgError;


EXCEPTION

	  WHEN ERROR_PROCESO THEN

	  	   ROLLBACK;
		   sCOD_SQLCODE:=SQLCODE;
		   sCOD_SQLERRM:=SQLERRM;

		   INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
		   NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
		   VALUES(vACTUACION,nNUM_ABONADO,SYSDATE,1,sNOM_PROC,sNOM_TABLA,sCOD_ACT,
		   sCOD_SQLCODE,sCOD_SQLERRM);

		   COMMIT;

		   nERROR:=nNumError;
		   vMsgError:=sMsgError;
END;
/
SHOW ERRORS
