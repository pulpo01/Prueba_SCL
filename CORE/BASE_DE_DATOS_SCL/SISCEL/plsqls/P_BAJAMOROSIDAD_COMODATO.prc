CREATE OR REPLACE PROCEDURE
P_BAJAMOROSIDAD_COMODATO(V_ABONADO IN  GA_ABOCEL.NUM_ABONADO%TYPE,
VP_ERROR OUT VARCHAR2) IS
V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
V_FEC_RECARGA  VARCHAR2(20);
V_PRESTADO GA_ABOCEL.IND_EQPRESTADO%TYPE;
V_SERIE	   GA_ABOCEL.NUM_SERIE%TYPE;
V_ESTADO  AL_SERIES.COD_ESTADO%TYPE;
V_IND_CAUSA  GAD_PLAZO_DEVDIF.IND_CAUSA%TYPE;
V_CAUSA_BAJA GAD_PLAZO_DEVDIF.COD_CAUSA%TYPE;
V_CANAL_VTA GAD_PLAZO_DEVDIF.COD_CANAL_VTA%TYPE;
V_TIPCONTRATO GA_ABOCEL.COD_TIPCONTRATO%TYPE;
V_PRODUCTO GA_ABOCEL.COD_PRODUCTO%TYPE;
V_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
V_MESES  GAD_PLAZO_DEVDIF.NUM_MESES%TYPE;
V_CATEGORIA VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
V_DIAS GAD_PLAZO_DEVDIF.DIAS_DEVOLUCION%TYPE;
V_FEC_MAXIMA DATE;
NOM_USUAELIM VARCHAR2(30);
V_OPERACION VARCHAR2(2);
V_SIGUE NUMBER(1);
BEGIN
		-- DEVUELVE 0: PROCESO OK
		-- DEVUELVE 1: SI NO ES COMODATO
		-- DEVUELVE 2: SI EXISTE ERROR
		V_OPERACION:='BM';
		V_SIGUE:=1;
		BEGIN
		-- EVALUA SI ES COMODATO
		   SELECT NVL(IND_EQPRESTADO,0),NUM_SERIE,COD_CLIENTE,COD_TIPCONTRATO,
		   		  COD_PRODUCTO,COD_PLANTARIF
		   INTO V_PRESTADO,V_SERIE,V_CLIENTE,V_TIPCONTRATO,V_PRODUCTO,
		   		V_PLANTARIF
		   FROM GA_ABOCEL
		   WHERE NUM_ABONADO =V_ABONADO;
		   IF V_PRESTADO <> 1 THEN
		      VP_ERROR:='1';
			  V_SIGUE:=0;
		   END IF;
		EXCEPTION
		   WHEN NO_DATA_FOUND THEN
		       VP_ERROR:='2';
		END;
		IF V_SIGUE=1 THEN
		   			BEGIN
		   			 SELECT USER INTO NOM_USUAELIM FROM DUAL;
		   			 SELECT VAL_PARAMETRO INTO V_IND_CAUSA
		   			 FROM GED_PARAMETROS
		   			 WHERE COD_MODULO='GA'
		   			 AND NOM_PARAMETRO='BAJA_POR_MOROSIDAD';
		   			 SELECT VAL_PARAMETRO INTO V_CAUSA_BAJA
		   			 FROM GED_PARAMETROS
		   			 WHERE COD_MODULO='GA'
		   			 AND NOM_PARAMETRO='CAUSA_BAJA_POR_MOROS';
		   			 SELECT VAL_PARAMETRO INTO V_CANAL_VTA
		   			 FROM GED_PARAMETROS
		   			 WHERE COD_MODULO='GA'
		   			 AND NOM_PARAMETRO='CANAL_VTA_INTERNO';
		   			 SELECT NUM_MESES INTO V_MESES
		   			 FROM GA_PERCONTRATO
		   			 WHERE COD_PRODUCTO=V_PRODUCTO
		   			 AND COD_TIPCONTRATO=V_TIPCONTRATO;
		   			 SELECT COD_CATEGORIA INTO V_CATEGORIA
		   			 FROM VE_CATPLANTARIF
		   			 WHERE COD_PLANTARIF=V_PLANTARIF;
					 EXCEPTION
		   			 	   WHEN NO_DATA_FOUND THEN
		   				   		VP_ERROR:='2';
								V_SIGUE:=0;
					END;
					IF V_SIGUE = 1 THEN
					BEGIN
		   	   		   SELECT COD_ESTADO INTO V_ESTADO
		   	   		   FROM AL_SERIES
		   	   		   WHERE NUM_SERIE=V_SERIE;
			   		   IF V_ESTADO = 8 THEN  --TEMPORAL
			   	   	   BEGIN
			   	   	   --RECUPERA DIAS DE DEVOLUCION
				   		SELECT DIAS_DEVOLUCION INTO V_DIAS
				   		FROM GAD_PLAZO_DEVDIF
				   		WHERE COD_TIPCONTRATO=V_TIPCONTRATO
				   		AND NUM_MESES=V_MESES
				   		AND COD_OPERACION=V_OPERACION
				   		AND IND_CAUSA =V_IND_CAUSA
				   		AND COD_CAUSA =V_CAUSA_BAJA
				   		AND COD_CATEGORIA=V_CATEGORIA
				   		AND COD_CANAL_VTA=V_CANAL_VTA
				   		AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);
			   	   	EXCEPTION
			   		WHEN NO_DATA_FOUND THEN
						V_DIAS:=0;
				    	WHEN OTHERS THEN
						VP_ERROR:='2';
						V_SIGUE:=0 ;
			   	   	END;
					IF V_SIGUE = 1 then
						BEGIN
				   		V_FEC_MAXIMA:= SYSDATE + V_DIAS;
				   		INSERT INTO GAT_EQUIPOS_DEVDIF
				   		(COD_CLIENTE,NUM_ABONADO,NUM_SERIE,COD_TIPMOV,
						COD_OPERACION,COD_CAUSA,FEC_INGRESO,NOM_USUARIO,
						COD_ESTADO_DEV,FEC_MAXIMA_DEV)
				   		VALUES (V_CLIENTE,V_ABONADO,V_SERIE,'1',V_OPERACION,
						V_CAUSA_BAJA,SYSDATE, NOM_USUAELIM,'ND',V_FEC_MAXIMA);
 				        VP_ERROR:='0';
				   	   EXCEPTION
				   		WHEN NO_DATA_FOUND THEN
							 VP_ERROR:='2';
					    WHEN OTHERS THEN
							 VP_ERROR:='2';
						V_SIGUE:=0;
				   	   END;
					END IF;
					   END IF; --ESTADO TEMPORAL
				EXCEPTION
		   			WHEN NO_DATA_FOUND THEN
					 VP_ERROR:='2';
					 V_SIGUE:=0;
				END;
				END IF;
		END IF;
END;
/
SHOW ERRORS
