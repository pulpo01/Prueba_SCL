CREATE OR REPLACE PROCEDURE P_Alta_Infaccel
 (VP_ABONADO IN NUMBER,
                           VP_INDACREC IN VARCHAR2,
                           VP_CLIENTE IN NUMBER,
                           VP_CELULAR IN NUMBER,
                           VP_CICLO IN NUMBER,
                           VP_PROCALTA IN NUMBER,
                           VP_AGENTE IN NUMBER,
                           VP_SUPERTEL IN NUMBER,
                           VP_TELEFIJA IN VARCHAR2,
                           VP_FECALTA IN DATE,
                           VP_VENTA IN NUMBER,
                           VP_INDFACT IN NUMBER,
                           VP_FINCONTRA IN DATE,
                           VP_FECSYS IN DATE,
                           VP_OPREDFIJA IN NUMBER,
                           VP_PROC IN OUT VARCHAR2,
                           VP_TABLA IN OUT VARCHAR2,
                           VP_ACT IN OUT VARCHAR2,
                           VP_SQLCODE IN OUT VARCHAR2,
                           VP_SQLERRM IN OUT VARCHAR2,
                           VP_ERROR IN OUT VARCHAR2)
IS
-- ***************************************************************************
-- *   VERSION 1.0 , INCIDENCIA RA-200512160336, [MEPT SOPORTE 21-12-2005]   *
-- ***************************************************************************
-- Procedimiento que inserta datos en la tabla de interfase
-- Abonados/Facturacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--

  V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
  V_CLIENTE_AG VE_VENDEDORES.COD_CLIENTE%TYPE;
  V_CLIENTE GA_INFACCEL.COD_CLIENTE%TYPE;
  V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
  V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
  V_DETALLE GA_INFACCEL.IND_DETALLE%TYPE;
  V_CODDET GA_DATOSGENER.COD_DETCEL%TYPE;
  V_CUOTAS GE_MODVENTA.IND_CUOTAS%TYPE;
  V_INDARRIENDO NUMBER(1) := 0;
  V_INDCUOTAS NUMBER(1) := 0;
  V_CARGOS NUMBER := 0;
  V_USO AL_USOS.COD_USO%TYPE;
  V_CARGOPRO NUMBER := 1;
  V_CARGOPROOPER NUMBER := 1;  -- PARAMETRO DE PROPORCIONALIDAD GLOBAL POR OPERADORA Inc. RA-200512160337
  V_CCONTROL NUMBER := 0;
  V_USOCONTROL AL_USOS.COD_USO%TYPE;
  VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
  VP_FECBAJA GA_INFACCEL.FEC_BAJA%TYPE;
  VP_ACTUAC GA_INFACCEL.IND_ACTUAC%TYPE;
  VP_CLIENTE_INFAC GA_INFACCEL.COD_CLIENTE%TYPE;
  V_FECAUX	        NUMBER;
  V_PLANTARIF_DEALER    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_CARGOBASICO_DEALER  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_PLANTARIF_DIRECTO   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_CARGOBASICO_DIRECTO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_NUMHORAS	        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_TIPOHIBRIDO		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_INDCOBRO		GA_CAUSAREC.IND_COBRO%TYPE;
  V_CLIENTE_INTERNO	GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  VP_FECBAJARECHAZO GA_INFACCEL.FEC_BAJA%TYPE;
  VP_FECALTARECHAZO GA_INFACCEL.FEC_ALTA%TYPE;
  VP_GRUPO_SERV GA_GRUPOS_SERVSUP.COD_GRUPO%TYPE;
  IND_VALOR NUMBER;
  V_PLANTARIF	ga_abOCEL.COD_PLANTARIF%TYPE;
  V_TIPLAN	 TA_PLANTARIF.COD_TIPLAN%TYPE;
  V_PRODUCTO GA_ABOCEL.COD_PRODUCTO%TYPE;
  V_PROPORCS TA_PLANTARIF.IND_PROPORCS%TYPE;
  V_OPERAPROPORVTA GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_OPERCARGOPRO  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  V_FECALTA_ABO GA_ABOCEL.FEC_ALTA%TYPE;--HPG
  ERROR_PROCESO EXCEPTION;
BEGIN
    VP_PROC := 'P_ALTA_INFACCEL';
    VP_TABLA := 'GA_DATOSGENER';
    VP_ACT := 'S';
    SELECT COD_DETCEL, COD_USOCONTROLADA  INTO V_CODDET, V_USOCONTROL
    FROM GA_DATOSGENER;
    IF VP_INDACREC = 'R' THEN
       VP_TABLA := 'VE_VENDEDORES';
       SELECT COD_CLIENTE
       INTO V_CLIENTE_AG
       FROM VE_VENDEDORES
       WHERE COD_VENDEDOR = VP_AGENTE;

	   VP_TABLA := 'GE_CLIENTES';
       SELECT COD_CICLO
       INTO V_CICLO
       FROM GE_CLIENTES
       WHERE COD_CLIENTE = V_CLIENTE_AG;
    ELSE
       V_CICLO := VP_CICLO;
    END IF;
--SELECCIONAMOS EL USO PARA COMPROBAR QUE SE A DE CUENTA CONTROLADA
    SELECT COD_USO,COD_PLANTARIF,COD_PRODUCTO, FEC_ALTA
	INTO V_USO,V_PLANTARIF,V_PRODUCTO, V_FECALTA_ABO  FROM GA_ABOCEL
    WHERE NUM_ABONADO = VP_ABONADO;

    IF V_USO = V_USOCONTROL OR V_USO= 15 THEN
       V_CCONTROL :=  1;
    ELSE
       V_CCONTROL :=  0;
    END IF;

--SELECCIONA EL PARAMETRO OPERADORADORA CARGO PRORRATEABLE
	SELECT TRIM(VAL_PARAMETRO) INTO V_OPERCARGOPRO
	FROM GED_PARAMETROS WHERE NOM_PARAMETRO = 'OPER_CARG_PRORRATEAB';


--SELECCIONA EL PARAMETRO TIPO DE PLAN TARIFARIO HIBRIDO
	SELECT TRIM(VAL_PARAMETRO) INTO V_TIPOHIBRIDO
	FROM GED_PARAMETROS WHERE NOM_PARAMETRO = 'TIPOHIBRIDO';


    SELECT COD_TIPLAN,DECODE(IND_PROPORCS,1,0,0,1,2,0)
    INTO V_TIPLAN, V_PROPORCS
    FROM TA_PLANTARIF WHERE COD_PRODUCTO=V_PRODUCTO
     AND COD_PLANTARIF =V_PLANTARIF;

--SELECCIONA EL PARAMETRO GLOBAL DE PROPORCIONALIDAD POR OPERADORA; INICIO RA-200512160337
      SELECT VAL_NUMERICO INTO V_CARGOPROOPER
      FROM FAD_PARAMETROS WHERE COD_PARAMETRO = 303;

      IF V_CARGOPROOPER = '0' THEN
          V_CARGOPRO := V_CARGOPROOPER;
      ELSE
          IF V_OPERCARGOPRO = '0' THEN
                IF V_TIPLAN = V_TIPOHIBRIDO THEN
                  V_CARGOPRO := V_OPERCARGOPRO;
                END IF;
          END IF;
      END IF;
--  FIN RA-200512160337


--SELECCIONA EL PARAMETRO OPERADORADORA PARA PROPORCIONALIDAD PLANES FREEDOM
	SELECT TRIM(VAL_PARAMETRO) INTO V_OPERAPROPORVTA
	FROM GED_PARAMETROS WHERE NOM_PARAMETRO = 'IND_OPERPROPCVTA';
	IF V_OPERAPROPORVTA = 'FALSE' THEN
           V_PROPORCS := 1;
	END IF;

    VP_TABLA := 'FA_CICLFACT';
    SELECT COD_CICLFACT INTO V_CICLFACT
    FROM FA_CICLFACT
    WHERE COD_CICLO = V_CICLO
          AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
    BEGIN
       VP_GRUPO_SERV:='DETLLAM';
       VP_TABLA := 'GA_SERVSUPLABO';
       IND_VALOR := 3;
       SELECT NUM_ABONADO INTO VAR1
       FROM GA_SERVSUPLABO A, GA_GRUPOS_SERVSUP B
       WHERE NUM_ABONADO=VP_ABONADO
	   AND B.COD_GRUPO=VP_GRUPO_SERV
	   AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
       AND A.COD_SERVICIO =B.COD_SERVICIO
	   AND IND_ESTADO < IND_VALOR;
	   V_DETALLE := 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             V_DETALLE := 0;
        WHEN OTHERS THEN
             VP_ERROR := '4';
             RAISE ERROR_PROCESO;
    END;
    VP_TABLA := 'GA_VENTAS';
    VP_ACT := 'J';
    SELECT B.IND_CUOTAS INTO V_CUOTAS
    FROM GA_VENTAS A,GE_MODVENTA B
    WHERE A.NUM_VENTA = VP_VENTA
    AND A.COD_MODVENTA = B.COD_MODVENTA;
    BEGIN
       VP_TABLA := 'GE_CARGOS';
       VP_ACT := 'S';
       SELECT NUM_ABONADO INTO VAR1
       FROM GE_CARGOS
       WHERE NUM_ABONADO = VP_ABONADO;
       V_CARGOS := 1;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
            V_CARGOS := 0;
       WHEN TOO_MANY_ROWS THEN
            V_CARGOS := 1;
       WHEN OTHERS THEN
            VP_ERROR := '4';
            RAISE ERROR_PROCESO;
    END;
    IF V_CUOTAS = 1 THEN
       V_INDCUOTAS := 1;
    ELSIF V_CUOTAS = 2 THEN
          V_INDARRIENDO := 1;
          IF VP_INDACREC = 'R' THEN
             P_MODIFICA_CUOTAS(VP_ABONADO,V_CLIENTE_AG,VP_PROC,VP_TABLA,VP_ACT,
                               VP_SQLCODE,VP_SQLERRM,VP_ERROR);
             IF VP_ERROR <> '0' THEN
                VP_ERROR := '4';
                RAISE ERROR_PROCESO;
              END IF;
              VP_PROC := 'P_ALTA_INFACCEL';
          END IF;
    ELSE
          V_INDCUOTAS := 0;
          V_INDARRIENDO := 0;
    END IF;
    VP_TABLA := 'INFACCEL';
    VP_ACT := 'I';
    IND_VALOR := 0;
    IF VP_INDACREC = 'R' THEN
    BEGIN
       	VP_CLIENTE_INFAC := V_CLIENTE_AG;
       	VP_FECBAJA := VP_FECSYS;
       	VP_ACTUAC := 5;
		SELECT VAL_PARAMETRO/24
		INTO V_NUMHORAS
		FROM GED_PARAMETROS
      	WHERE  NOM_PARAMETRO = 'NUM_HORAS'
             AND COD_PRODUCTO = 1
             AND COD_MODULO = 'GA';
		SELECT VAL_PARAMETRO
		INTO V_CLIENTE_INTERNO
		FROM GED_PARAMETROS
      	WHERE NOM_PARAMETRO = 'COD_CLIENTEINTERNO'
      	AND COD_PRODUCTO = 1
      	AND COD_MODULO = 'GA';
 		VP_TABLA := 'GA_CAUSAREC';
     	SELECT  IND_COBRO
      	INTO V_INDCOBRO
      	FROM GA_CAUSAREC
      	WHERE COD_CAUSAREC =(SELECT COD_CAUSAREC
      	FROM GA_ABOCEL A, GA_VENTAS B
		WHERE A.NUM_VENTA=B.NUM_VENTA
		AND A.NUM_ABONADO=VP_ABONADO);
       -- Indicador de Cobro verdadero.
       IF V_INDCOBRO=1 THEN
          V_FECAUX := VP_FECBAJA - V_FECALTA_ABO; --VP_FECALTA;
		  IF (V_FECAUX > V_NUMHORAS) THEN
            -- Se generan dos registros, periodo > 48 hrs.
            -- cliente Vendedor
               V_CLIENTE := V_CLIENTE_AG;
               VP_FECBAJARECHAZO := V_FECALTA_ABO + V_NUMHORAS;
	    	   SELECT C.COD_CICLFACT
               INTO V_CICLFACT
               FROM GE_CLIENTES B,FA_CICLFACT C
               WHERE B.COD_CLIENTE=V_CLIENTE
               AND C.COD_CICLO = B.COD_CICLO
               AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
    	       INSERT INTO GA_INFACCEL
           	   (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
               FEC_ALTA,FEC_BAJA,NUM_CELULAR,
               IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
               IND_DETALLE,IND_FACTUR,IND_CUOTAS,
               IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
               IND_SUPERTEL,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,
	   		   IND_CUENCONTROLADA)
			   VALUES (V_CLIENTE,VP_ABONADO,V_CICLFACT,V_FECALTA_ABO,
               VP_FECBAJARECHAZO,VP_CELULAR,VP_ACTUAC,VP_FINCONTRA,1,
               V_DETALLE,VP_INDFACT,V_INDCUOTAS,V_INDARRIENDO,V_CARGOS,IND_VALOR,
               VP_SUPERTEL,VP_TELEFIJA,VP_OPREDFIJA, V_CARGOPRO,V_CCONTROL);
    		   -- Cliente Interno
		   	   -- V_FECAUX := VP_FECBAJA - VP_FECALTA;
           	    V_CLIENTE := TO_NUMBER(V_CLIENTE_INTERNO);
				VP_FECALTARECHAZO := VP_FECBAJARECHAZO + (1/(24*60*60));
	    		SELECT C.COD_CICLFACT
           		INTO V_CICLFACT
            	FROM GE_CLIENTES B,FA_CICLFACT C
            	WHERE B.COD_CLIENTE=V_CLIENTE
            	AND C.COD_CICLO = B.COD_CICLO
            	AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
    	    	INSERT INTO GA_INFACCEL
           		(COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
            	FEC_ALTA,FEC_BAJA,NUM_CELULAR,
            	IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            	IND_DETALLE,IND_FACTUR,IND_CUOTAS,
            	IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
            	IND_SUPERTEL,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,
	    		IND_CUENCONTROLADA)
    	    	VALUES (V_CLIENTE,VP_ABONADO,V_CICLFACT,VP_FECALTARECHAZO,
            	VP_FECBAJA,VP_CELULAR,VP_ACTUAC,VP_FINCONTRA,1,V_DETALLE,VP_INDFACT,
	    		V_INDCUOTAS,V_INDARRIENDO,V_CARGOS,IND_VALOR,
            	VP_SUPERTEL,VP_TELEFIJA,VP_OPREDFIJA, V_CARGOPRO,V_CCONTROL);
    	  ELSE
          		-- CLiente Vendedor
            	V_CLIENTE := V_CLIENTE_AG;
	    		SELECT C.COD_CICLFACT
            	INTO V_CICLFACT
            	FROM GE_CLIENTES B,FA_CICLFACT C
            	WHERE B.COD_CLIENTE=V_CLIENTE
            	AND C.COD_CICLO = B.COD_CICLO
            	AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
    	    	INSERT INTO GA_INFACCEL
            	(COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
            	FEC_ALTA,FEC_BAJA,NUM_CELULAR,
            	IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            	IND_DETALLE,IND_FACTUR,IND_CUOTAS,
            	IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
            	IND_SUPERTEL,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,
				IND_CUENCONTROLADA)
    	    	VALUES (V_CLIENTE,VP_ABONADO,V_CICLFACT,V_FECALTA_ABO,
            	VP_FECBAJA,VP_CELULAR,VP_ACTUAC,VP_FINCONTRA,1,
            	V_DETALLE,VP_INDFACT,V_INDCUOTAS,V_INDARRIENDO,V_CARGOS,IND_VALOR,
            	VP_SUPERTEL,VP_TELEFIJA,VP_OPREDFIJA, V_CARGOPRO,V_CCONTROL);
		  END IF; -- diferencia horaria
       ELSE -- Ind Cobro de Causa de rechazo =0
           --Cliente Interno
            V_CLIENTE := V_CLIENTE_INTERNO;
	   		SELECT C.COD_CICLFACT
            INTO V_CICLFACT
            FROM GE_CLIENTES B,FA_CICLFACT C
            WHERE B.COD_CLIENTE=V_CLIENTE
            AND C.COD_CICLO = B.COD_CICLO
            AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
    	    INSERT INTO GA_INFACCEL
           	(COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
            FEC_ALTA,FEC_BAJA,NUM_CELULAR,
            IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            IND_DETALLE,IND_FACTUR,IND_CUOTAS,
            IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
            IND_SUPERTEL,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,
	    	IND_CUENCONTROLADA)
    	    VALUES (V_CLIENTE,VP_ABONADO,V_CICLFACT,V_FECALTA_ABO,
            VP_FECBAJA,VP_CELULAR,VP_ACTUAC,VP_FINCONTRA,1,
            V_DETALLE,VP_INDFACT,V_INDCUOTAS,V_INDARRIENDO,V_CARGOS,IND_VALOR,
            VP_SUPERTEL,VP_TELEFIJA,VP_OPREDFIJA, V_CARGOPRO,V_CCONTROL);
       END IF;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
           RAISE ERROR_PROCESO;
    END;
    ELSE  --Aceptacion Venta
  		  VP_CLIENTE_INFAC := VP_CLIENTE;
   		  VP_FECBAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
    	  VP_ACTUAC := 1;
    	  INSERT INTO GA_INFACCEL
           (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
            FEC_ALTA,FEC_BAJA,NUM_CELULAR,
            IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
            IND_DETALLE,IND_FACTUR,IND_CUOTAS,
            IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
            IND_SUPERTEL,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,
	    	IND_CUENCONTROLADA)
    		VALUES (VP_CLIENTE_INFAC,VP_ABONADO,V_CICLFACT,V_FECALTA_ABO,VP_FECBAJA,
	    	VP_CELULAR,VP_ACTUAC,VP_FINCONTRA,V_PROPORCS,V_DETALLE,VP_INDFACT,
	    	V_INDCUOTAS,V_INDARRIENDO,V_CARGOS,IND_VALOR,
            VP_SUPERTEL,VP_TELEFIJA,VP_OPREDFIJA, V_CARGOPRO,V_CCONTROL);
    END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        IF VP_SQLCODE IS NULL THEN
           VP_SQLCODE := SQLCODE;
           VP_SQLERRM := SQLERRM;
        END IF;
        VP_ERROR := '4';
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
