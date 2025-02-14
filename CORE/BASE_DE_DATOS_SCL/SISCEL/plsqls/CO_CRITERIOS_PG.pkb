CREATE OR REPLACE PACKAGE BODY        CO_CRITERIOS_PG IS


FUNCTION CO_VERSION_FN RETURN VARCHAR2 IS
sVersionFinal CHAR(3);
 BEGIN
  sVersionFinal := CO_CRITERIOS_PG.sVersion;
  RETURN sVersionFinal;
END CO_VERSION_FN;

FUNCTION CO_VERIFAUTCOMITECOBEXT_FN(lCodCliente IN NUMBER,sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica si el cliente dado cuenta con la autorizacion debida del
--                   comite para ser enviado a cobranza externa
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = "S"  : Se Cumplio el Criterio
--                                             = "N"  : No se Cumplio el Criterio

nCuentaAutorizaciones NUMBER(5) := 0;
sCodGestion VARCHAR2(3) := '50';
BEGIN
	sValRetorno := 'N';

    SELECT COUNT(1)
    INTO nCuentaAutorizaciones
    FROM CO_GESTION
    WHERE COD_CLIENTE = lCodCliente
    AND COD_GESTION = sCodGestion;

	IF nCuentaAutorizaciones > 0 THEN
	   sValRetorno := 'S';
	END IF;

	RETURN 'OK';

EXCEPTION
    WHEN OTHERS THEN
		 RETURN 'SQL';
--		 RAISE_APPLICATION_ERROR(-20104,'ERROR CO_VERIFAUTCOMITECOBEXT_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);

END CO_VERIFAUTCOMITECOBEXT_FN;

FUNCTION CO_VERIFCLIENTESUSP_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica si todos los abonados asociados al cliente dado estan
--                   suspendidos (cod_situacion = 'SAA' )
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                           Valor de Retono = "S"  : Se Cumplio el Criterio
--                                           = "N"  : No se Cumplio el Criterio

lNoSusp  NUMBER(5)   := 0; /* Cantidad de Abonados NO SUSPENDIDOS del cliente */
iAmistar PLS_INTEGER := 3; /* Definicion de uso amistar de abonado celular */
BEGIN
	sValRetorno := 'N';

   SELECT COUNT(1)
    INTO lNoSusp
    FROM
    (
        SELECT /*+ AK_GA_ABOCEL_CLIENTE */
               NUM_ABONADO, COD_SITUACION
        FROM   GA_ABOCEL
        WHERE  COD_CLIENTE = lCodCliente
        AND    COD_USO != iAmistar
        UNION ALL
        SELECT /*+ AK_GA_ABOBEEP_CLIENTE */
               NUM_ABONADO,  COD_SITUACION
        FROM   GA_ABOBEEP
        WHERE  COD_CLIENTE = lCodCliente
    )
    WHERE COD_SITUACION NOT IN ('SAA','STP','BAA');

	IF lNoSusp > 0 THEN
	   sValRetorno := 'S';
	END IF;

	RETURN 'OK';
EXCEPTION
    WHEN OTHERS THEN
		 RETURN 'SQL';
--		 RAISE_APPLICATION_ERROR(-20104,'ERROR CO_VERIFAUTCOMITECOBEXT_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_VERIFCLIENTESUSP_FN;

FUNCTION CO_CONTRDIGIT_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  	Determina si el Rut tiene para sus cuentas, y estas, para sus abonados,
--    				    los contratos digitalizados.
--    Recibe      :  	Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  	"S" si, estan digitalizados.
--                      "N" no, no estan todos digitalizados.

iCode_Returned PLS_INTEGER := 0;
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sNumIdentAux GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
lCodCuenta GA_ABOCEL.COD_CUENTA%TYPE;
--sNumContrato VARCHAR2(20);
sNumContrato VARCHAR2(22); --INCIDENCIA XM-200503100256 CAMBIOS EN ANEXO Y NUMERO DE CONTRATO capc 10-03-2005
sCadAux VARCHAR2(100);
nPos NUMBER(2) := 0;
iError PLS_INTEGER := 0;
bChar BOOLEAN := FALSE;
iLong NUMBER(2) := 0;
nCntCont NUMBER(5) := 0;
CURSOR curCuentas IS
	SELECT 	DISTINCT COD_CUENTA
	FROM   	GA_CUENTAS
	WHERE  	COD_TIPIDENT = sCodTipIdent
	AND		NUM_IDENT = sNumIdent;

CURSOR curAboCuenta IS
	SELECT	UNIQUE NUM_CONTRATO
	FROM	GA_ABOCEL
	WHERE   COD_CUENTA	= lCodCuenta
	UNION
    SELECT	UNIQUE NUM_CONTRATO
	FROM	GA_ABOBEEP
	WHERE   COD_CUENTA	= lCodCuenta;
BEGIN

	sValRetorno := 'N'; /*XM-200412200216  24-12-2004  Soporte RyC capc*/

	/* se busca el numero de rut del cliente examinado */
	BEGIN
	SELECT 	NUM_IDENT,
			LPAD(REPLACE( NUM_IDENT,'-', '' ), 9, '0' ),
			COD_TIPIDENT
	INTO	sNumIdent,
			sNumIdentAux,
			sCodTipIdent
	FROM 	CO_MOROSOS
	WHERE   COD_CLIENTE = lCodCliente;
	EXCEPTION
		WHEN OTHERS THEN
			 RETURN 'SQL';
		END;

	/* se seleccionan todas las cuentas del rut seleccionado */
	FOR rReg IN curCuentas LOOP
		lCodCuenta := rReg.COD_CUENTA;
		iError := 0;
		/* se obtienen todos los abonados celulares y beepers de la cuenta */
		FOR rRegAbo IN curAboCuenta LOOP
			sNumContrato := rRegAbo.NUM_CONTRATO;
			IF SUBSTR(sNumContrato,3,1) = '-' THEN
			   nPos := INSTR(sNumContrato,'-', 4, 1);
			   sCadAux := SUBSTR(sNumContrato, 4 ,nPos - 4);
			   sNumContrato := sCadAux;
			END IF;
			/* comprobamos si la cadena de contrato tiene caracteres alfanumericos */
			iLong := LENGTH(sNumContrato);
			FOR i IN 1..iLong LOOP
				IF SUBSTR(sNumContrato,i,1) <'0' OR SUBSTR(sNumContrato,i,1) >'9' THEN
				   bChar := TRUE;
				   EXIT;
				END IF;
			END LOOP;
			IF  bChar THEN /* si tiene caracteres alfanumericos no examinamos mas */
				iCode_Returned := 0;
				EXIT;
			ELSE /* si el contrato cumple con las validaciones verificamos su existencia en la tabla local */
				BEGIN
				SELECT 	COUNT(1)
			 	INTO	nCntCont
			 	FROM	COT_CONTDIGI
			 	WHERE   NUM_IDENT		= Trim(sNumIdentAux)
			 	AND     NUM_CONTRATO    = TO_NUMBER(sNumContrato );
				EXCEPTION
					WHEN OTHERS THEN
						 iError := 1;
						 EXIT;
					END;
				/* no esta digitalizado en la base local */
				IF nCntCont = 0 THEN
				   	iCode_Returned := 0;
				   	EXIT;
				ELSE
					iCode_Returned := 1;
				END IF;
			END IF;
		END LOOP; --curAboCuenta

		IF iError = 1 OR iCode_Returned = 0 THEN /* se sale si hay error o un contrato no digitalizado */
		   EXIT;
		END IF;
	END LOOP; --curCuentas

	IF iError = 1 THEN
	   RETURN 'SQL'; /* Hubo un Error */
	ELSE
		IF iCode_Returned = 1 THEN  /* todos estan digitalizados */
	   	   	 sValRetorno := 'S';
		 ELSE
		 	 sValRetorno := 'N';
		 END IF;
	END IF;

	RETURN 'OK';

EXCEPTION
	WHEN OTHERS THEN
		 RETURN 'SQL';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_CONTRDIGIT_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_CONTRDIGIT_FN;

FUNCTION CO_OBTGESTCLI_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Obtiene el codigo de gestion asociado al cliente dado,
--                   retornandolo en un string.

--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = Rut del cliente o 0
iError PLS_INTEGER := 0;
BEGIN
	 sValRetorno := '0';
	 iError := CO_CRITERIOS_PG.CO_GETCODGESTCLIE_FN(lCodCliente,sValRetorno);

	 IF iError = 0 THEN /*No encontro el rut */
	 	RETURN 'NOCOD';
	 ELSE
	 	IF iError < 0 THEN /* error oracle */
           RETURN 'SQL';
	 	END IF;
	 END IF;

	 RETURN 'OK';

END CO_OBTGESTCLI_FN;

FUNCTION CO_GETCODGESTCLIE_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN PLS_INTEGER IS
--    Descripcion :  Obtiene el Codigo de Gestion de un Cliente dado  (numerico)
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  -1 -> Ocurrio un error de oracle ( queda registrado en el log )
--	  			  	 0   -> No se encontraron Datos
--                   1   -> Se evaluo el criterio correctamente
--	  			  	 Valor de Retorno = Codigo de gestion de un cliente dado

sCodGestClie CO_MOROSOS.COD_GESTION%TYPE;
BEGIN
	sValRetorno := '';

	SELECT 	COD_GESTION
    INTO 	sValRetorno
    FROM 	CO_MOROSOS
    WHERE 	COD_CLIENTE = lCodCliente;

	RETURN 1;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
		 RETURN 0;
         --RAISE_APPLICATION_ERROR(-20102,'ERROR CO_GETCODGESTCLIE_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRO PUNTO DE GESTION');
	WHEN OTHERS THEN
		 RETURN -1;
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_GETCODGESTCLIE_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_GETCODGESTCLIE_FN;



FUNCTION CO_INTENPAGO_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  	Determina si hubo pagos, en la co_pagos, para un cliente dado, dentro de
--    				un determinado periodo.
--    Recibe      :  	by Val -> Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  	"SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   	"OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "S" hubo intencion, en caso contrario "N".

lNumDias FAD_PARAMETROS.VAL_NUMERICO%TYPE;
lCntOcur NUMBER(5);
sOut VARCHAR2(1);
sRetorno VARCHAR(100);
BEGIN
	sValRetorno := '0';
	IF NOT(CO_CRITERIOS_PG.CO_BUSCAFADPARAMETROS_FN(5,'NUMBER','CO',sRetorno)) THEN
	   RETURN 'SQL';
	END IF;

	lNumDias := TO_NUMBER(sRetorno);

	SELECT 	COUNT(*)
	INTO	lCntOcur
	FROM   	CO_PAGOS
	WHERE  	COD_CLIENTE = lCodCliente
	AND     FEC_EFECTIVIDAD >= SYSDATE - lNumDias;

	IF lCntOcur = 0 THEN
	    sValRetorno := 'N';
	ELSE
		sValRetorno := 'S';
	END IF;

	RETURN 'OK';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
		 RETURN 'SQL';
         --RAISE_APPLICATION_ERROR(-20102,'ERROR CO_INTENPAGO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRO PARAMETROS EN FAD_PARAMETROS');
	WHEN OTHERS THEN
		 RETURN 'SQL';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_INTENPAGO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_INTENPAGO_FN;

FUNCTION CO_NOTASCREDNOINTER_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Valida si el cliente tiene notas de crédito no intercaladas
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "GRCLI" , "NATUR" , Perfil o " "

lCantNC NUMBER(5);
sOut VARCHAR2(1);
BEGIN

	sValRetorno := 'N';
    SELECT COUNT(1)
    INTO lCantNC
    FROM FA_FACTDOCU_NOCICLO
    WHERE COD_CLIENTE = lCodCliente
       AND COD_TIPDOCUM = 25
       AND IND_PASOCOBRO = 0
       AND IND_ANULADA = 0;

	IF lCantNC > 0 THEN
	 	sValRetorno := 'S';
	END IF;

	RETURN 'OK';

EXCEPTION
	WHEN OTHERS THEN
		 RETURN 'SQL';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_NOTASCREDNOINTER_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_NOTASCREDNOINTER_FN;

FUNCTION CO_GETPERFIL_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN BOOLEAN IS
/* ============================================================================= */
/* Obtiene el Perfil del Cliente   Retorna FALSE si no puede determinarlo        */
/* ============================================================================= */
sCodCategoria VARCHAR2(6);
lCategoria NUMBER(1) := 1;
BEGIN

	BEGIN
    SELECT TO_CHAR( COD_CATEGORIA )
    INTO   sCodCategoria
    FROM   GE_CLIENTES
    WHERE  COD_CLIENTE = lCodCliente
	AND    COD_CATEGORIA IS NOT NULL;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		lCategoria := 0;
	WHEN OTHERS THEN
		lCategoria := 1;
	END;

	IF lCategoria = 0 THEN
	   BEGIN
		SELECT 	COD_CATCUENTA
		INTO 	sCodCategoria
		FROM 	CO_CATCUENTAS
		WHERE  	COD_CLIENTE = lCodCliente
		AND   	( FEC_HASTA IS NULL OR
			  	( TRUNC(FEC_HASTA) = TO_DATE('31123000','DDMMYYYY') ) )
		AND 	COD_CATCUENTA NOT IN ('PYMES','GRCLI');
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 lCategoria := 1;
		WHEN OTHERS THEN /* Verifica errores sql */
			 lCategoria := 2;
		END;

		IF lCategoria = 1 THEN
		   sValRetorno := 'ENA';
		ELSE
			IF lCategoria = 2 THEN
			   RETURN FALSE;
			ELSE
		    	sValRetorno := sCodCategoria;
			END IF;
		END IF;
	ELSE
		IF lCategoria = 1 THEN /* Verifica errores sql */
		   RETURN FALSE;
		ELSE
			BEGIN
			SELECT	NVL( SUBSTR( DES_VALOR, 1, 5 ), ' ' )
			INTO	sValRetorno
			FROM	CO_CODIGOS
			WHERE   NOM_TABLA	= 'GE_CLIENTES'
			AND		NOM_COLUMNA = 'COD_CATEGORIA'
			AND     TO_NUMBER( COD_VALOR )  = TO_NUMBER( sCodCategoria );
			EXCEPTION
			WHEN OTHERS THEN
				 RETURN FALSE;
			END;
		END IF;
	END IF;

	RETURN TRUE;

END CO_GETPERFIL_FN;

FUNCTION CO_PERFILCLI_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Obtiene el Perfil de la cuenta del cliente
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "GRCLI" , "NATUR" , Perfil o " "
BEGIN
		sValRetorno:= ' ';
		IF NOT(CO_CRITERIOS_PG.CO_GETPERFIL_FN(lCodCliente, sValRetorno)) THEN
		   RETURN 'SQL';
		ELSE
			RETURN 'OK';
		END IF;

END CO_PERFILCLI_FN;

FUNCTION CO_RECLAMOSPEND_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  	Determina si el cliente tiene reclamos pendientes.
--    Recibe      :  	Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  	"SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   	"OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "S" hay pendientes, en caso contrario "N".
--    Se modifica query agregando tabla RE_RECLCOB por incidencia XO-200509280756 Soporte RyC 30-09-2005 capc
lNumRecl NUMBER(5);
BEGIN

-- Inicio XO-200509280756
	SELECT 	SUM(NRO_RECL)
	INTO	lNumRecl
	FROM
		(
			SELECT COUNT(1) AS NRO_RECL
			FROM   RE_RECLAMOS A, RE_RECLCOB B
			WHERE  A.COD_CLIENTE = lCodCliente
			AND B.COD_VIGENCIA='V'
			AND A.TIP_RECLAMO = B.TIP_INCIDENCIA
			UNION ALL
			SELECT COUNT(1) AS NRO_RECL
			FROM   RE_HRECLAMOS A, RE_RECLCOB B
			WHERE  A.COD_CLIENTE = lCodCliente
			AND    A.COD_ESTADO NOT IN ( 'CER', 'RCE' )
			AND B.COD_VIGENCIA='V'
			AND A.TIP_RECLAMO = B.TIP_INCIDENCIA
		);
-- Fin XO-200509280756
	IF lNumRecl = 0 THEN
	   sValRetorno := 'N';
	ELSE
		sValRetorno := 'S';
	END IF;

	RETURN 'OK';

EXCEPTION
	WHEN OTHERS THEN
		 RETURN 'SQL';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CCO_RECLAMOSPEND_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);

END CO_RECLAMOSPEND_FN;

FUNCTION CO_OBTRUTCLI_FN(lCodCliente IN NUMBER,sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Obtiene el rut asociado al cliente dado, retornandolo en un string
--                   con forma de numero sin el digito verificador.
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = Rut del cliente o 0
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
lPos NUMBER(2);
iError PLS_INTEGER;
BEGIN
	sValRetorno := '0';
	--Obtiene el rut de un cliente dado
	iError := CO_CRITERIOS_PG.CO_GETRUTCLIENTE_FN(lCodCliente,sNumIdent,sCodTipIdent);
	IF iError = 0 THEN
	   RETURN 'NORUT';
	ELSE
		IF iError < 0 THEN
		   RETURN 'SQL';
		END IF;
	END IF;

	/* Verifico si el rut recuperado trae digito verificador ( asumo despues del '-' ) */
	lPos := INSTR(sNumIdent,'-',1);
    IF lPos = 0 THEN    /* no tiene '-' lo retorno tal cual */
		sValRetorno := sNumIdent;
	ELSE /* retorno el valor antes del '-' */
		sValRetorno := SUBSTR(sNumIdent,1,lPos-1);
	END IF;

	RETURN 'OK';
END CO_OBTRUTCLI_FN;

FUNCTION CO_RUTMETROPOLITANO_FN(lCodCliente IN NUMBER, iRetorno OUT PLS_INTEGER) RETURN PLS_INTEGER IS
--    Descripcion :  Verifica si alguno de los abonados del cliente tiene direccion de
--                   correspondencia en la region metropolitana
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  -1 -> Ocurrio un error de oracle ( queda registrado en el log )
--                   0-> Fue imposible determinar el rut del cliente dado
--                   1   -> Se evaluo el criterio correctamente
--                             Valor de Retono = 1 : Se Cumplio el Criterio
--                                             = 0  : No se Cumplio el Criterio
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
iDirCorrespondencia PLS_INTEGER := 3;
lMetropolitana NUMBER(2) := 13;
iCrit PLS_INTEGER := 0;
iError PLS_INTEGER;
CURSOR curRegClientes IS
SELECT /*+ AK_GE_CLIENTE_IDENTIFICACION */
      A.COD_CLIENTE, C.COD_REGION
FROM GE_DIRECCIONES C, GA_DIRECCLI B, GE_CLIENTES A
WHERE A.NUM_IDENT        = sNumIdent
	  AND A.COD_TIPIDENT     = sCodTipIdent
	  AND B.COD_CLIENTE      = A.COD_CLIENTE
	  AND B.COD_TIPDIRECCION = iDirCorrespondencia
	  AND C.COD_DIRECCION    = B.COD_DIRECCION;

BEGIN
	 iRetorno := 0;
	 iError := CO_CRITERIOS_PG.CO_GETRUTCLIENTE_FN(lCodCliente,sNumIdent,sCodTipIdent);
	 IF iError != 1 THEN
	 	RETURN iError; /* 0: Rut NotFound, -1:Error Oracle */
	 END IF;
	 iError := 0;
	 /* Obtiene todos los clientes asociados a ese Rut y la region de sus respectivas direcciones de correspondencia */
	 FOR rReg IN curRegClientes LOOP
		 IF TO_NUMBER(rReg.COD_REGION) = lMetropolitana THEN
		 	iCrit := 1;
			EXIT;
		 END IF;
	 END LOOP;
	 iRetorno := iCrit;
	 RETURN 1;

END CO_RUTMETROPOLITANO_FN;

FUNCTION CO_VERIFRUTSTGO_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica si alguno de los abonados del cliente tiene direccion de
--                   correspondencia en la region metropolitana
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = "S"  : Se Cumplio el Criterio
--                                             = "N"  : No se Cumplio el Criterio
iCrit PLS_INTEGER := 0;
iRespuesta PLS_INTEGER;
BEGIN

	 iRespuesta := CO_CRITERIOS_PG.CO_RUTMETROPOLITANO_FN(lCodCliente,iCrit);
	 IF iCrit = 1 THEN
	 	sValRetorno := 'S';
	 ELSE
	 	sValRetorno := 'N';
	 END IF;

	 IF iRespuesta = 1 THEN
	 	RETURN 'OK';
	 ELSE
	 	IF iRespuesta = 0 THEN
	 	   RETURN 'NORUT';
		ELSE
			RETURN 'SQL';
		END IF;
	 END IF;

END CO_VERIFRUTSTGO_FN;

FUNCTION CO_GETRUTCLIENTE_FN(lCodCliente IN NUMBER, sNumIdent OUT VARCHAR2, sCodTipIdent OUT VARCHAR2) RETURN PLS_INTEGER IS
/* ============================================================================= */
/* Retorna el rut de un cliente dado                                             */
/* ============================================================================= */
BEGIN
	 sNumIdent := '';
	 sCodTipIdent := '';

	 SELECT NUM_IDENT, COD_TIPIDENT
	  INTO sNumIdent, sCodTipIdent
	  FROM GE_CLIENTES
	 WHERE COD_CLIENTE = lCodCliente;

	 RETURN 1;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
		 RETURN 0;
         --RAISE_APPLICATION_ERROR(-20102,'ERROR CO_GETRUTCLIENTE_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRO IDENTIFICACION CLIENTE');
	WHEN OTHERS THEN
		 RETURN -1;
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_GETRUTCLIENTE_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_GETRUTCLIENTE_FN;

FUNCTION CO_SALDOCLI_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Determina cual es el Saldo en la CO_MOROSOS de un Cliente en Particular
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  Monto del Saldo,sin decimales.

dMtoSaldo CO_CARTERA.IMPORTE_DEBE%TYPE;
dMtoAux CO_CARTERA.IMPORTE_DEBE%TYPE;
sFecAux VARCHAR(8);
iDecimal NUMBER; --Decimales por Operadora.

BEGIN
	 sValRetorno := '0';
	 IF NOT(CO_CRITERIOS_PG.CO_GETSALDOCLIENTE_FN(lCodCliente, dMtoSaldo, dMtoAux, sFecAux)) THEN
	 	RETURN 'SQL';
	 END IF;

   iDecimal:=GE_PAC_GENERAL.PARAM_GENERAL('num_decimal');

	 sValRetorno := GE_PAC_GENERAL.REDONDEA(dMtoSaldo,iDecimal,0);
	 RETURN 'OK';

END CO_SALDOCLI_FN;

FUNCTION CO_GETSALDOCLIENTE_FN(lCodCliente IN NUMBER, sSaldoVenc OUT NUMBER, sSaldoNoVenc OUT NUMBER, sFecVencimiento OUT VARCHAR2) RETURN BOOLEAN IS
/* ============================================================================= */
/* Obtiene el saldo en la CO_MOROSOS dado el Cliente                             */
/* ============================================================================= */
iIndFacturado PLS_INTEGER := 1;
BEGIN
	BEGIN
    SELECT TO_CHAR(MIN(FEC_VENCIMIE),'YYYYMMDD')
      INTO sFecVencimiento
      FROM CO_CARTERA
     WHERE COD_CLIENTE   = lCodCliente
       AND IND_FACTURADO = iIndFacturado
       AND FEC_VENCIMIE < TRUNC(SYSDATE)
	   AND COD_CONCEPTO != 2
	   AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA = 'CO_CARTERA'
									AND		NOM_COLUMNA = 'COD_TIPDOCUM' );
	EXCEPTION
	WHEN OTHERS THEN
		 RETURN FALSE;
	END;

	BEGIN
    SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
      INTO sSaldoVenc
      FROM CO_CARTERA
     WHERE COD_CLIENTE   = lCodCliente
       AND IND_FACTURADO = iIndFacturado
       AND FEC_VENCIMIE < TRUNC(SYSDATE)
	   AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA = 'CO_CARTERA'
									AND		NOM_COLUMNA = 'COD_TIPDOCUM'	);
	EXCEPTION
	WHEN OTHERS THEN
		 RETURN FALSE;
	END;

	BEGIN
    SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
      INTO sSaldoNoVenc
      FROM CO_CARTERA
     WHERE COD_CLIENTE   = lCodCliente
       AND IND_FACTURADO = iIndFacturado
       AND FEC_VENCIMIE >= TRUNC(SYSDATE)
	   AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA = 'CO_CARTERA'
									AND		NOM_COLUMNA = 'COD_TIPDOCUM'	);
	EXCEPTION
	WHEN OTHERS THEN
		 RETURN FALSE;
	END;

	RETURN TRUE;

END CO_GETSALDOCLIENTE_FN;

FUNCTION CO_SALDORUT_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Determina cual es el Saldo total en la CO_MOROSOS de un Rut
--                   ( Se consideran todos los clientes de ese rut en la tabla )
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  Monto del Saldo,sin decimales.
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
iError PLS_INTEGER;
dSaldoVencido CO_CARTERA.IMPORTE_DEBE%TYPE;
BEGIN
	 iError := 0;
	 iError := CO_CRITERIOS_PG.CO_GETRUTCLIENTE_FN(lCodCliente, sNumIdent, sCodTipIdent);
	 IF iError = 0 THEN  /*No encontro el rut */
	 	RETURN 'NORUT';
	 ELSE
	 	IF iError < 0 THEN /* error oracle */
		 	RETURN 'SQL';
		END IF;
	 END IF;

	 IF NOT(CO_CRITERIOS_PG.CO_GETSALDOPORRUT_FN(sNumIdent, sCodTipIdent, dSaldoVencido)) THEN
	 	RETURN 'SQL';
	 ELSE
	 	 sValRetorno := dSaldoVencido;
	 	 RETURN 'OK';
	 END IF;
END CO_SALDORUT_FN;

FUNCTION CO_GETSALDOPORRUT_FN(sNumIdent IN VARCHAR2, sCodTipIdent IN VARCHAR, dMontoSaldo OUT NUMBER) RETURN BOOLEAN IS
/*-Obtiene el Saldo en la Cta. Cte. de los Clientes que asocia ese rut -*/

dMtoSaldo CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
dMtoSaldoParcial CO_CARTERA.IMPORTE_DEBE%TYPE := 0 ;
dMtoAux CO_CARTERA.IMPORTE_DEBE%TYPE := 0 ;
sFecAux VARCHAR2(8);
iError PLS_INTEGER := 0;
CURSOR curRuts IS
	SELECT	COD_CLIENTE
	FROM	GE_CLIENTES
	WHERE	COD_TIPIDENT = sCodTipIdent
	AND		NUM_IDENT = sNumIdent;

BEGIN
	 dMtoSaldo := 0;
	 FOR rReg IN curRuts LOOP
	 	 dMtoSaldoParcial := 0;
		 IF NOT(CO_CRITERIOS_PG.CO_GETSALDOCLIENTE_FN(rReg.COD_CLIENTE, dMtoSaldoParcial, dMtoAux, sFecAux)) THEN
		 	iError := 1;
			EXIT;
		 ELSE
		 	dMtoSaldo := dMtoSaldo + dMtoSaldoParcial;
		 END IF;
	 END LOOP;
	 IF iError = 1 THEN
	 	RETURN FALSE;
	 ELSE
	 	 dMontoSaldo := dMtoSaldo;
		 RETURN TRUE;
	 END IF;

END CO_GETSALDOPORRUT_FN;

FUNCTION CO_VERIFCLIBLOQ_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica que todos los abonados de un cliente estan bloqueados, en
--                   caso contrario no se cumple el criterio.
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = "S"  : Se Cumplio el Criterio
--                                             = "N"  : No se Cumplio el Criterio

nContadorNoBloqueados NUMBER(5) := 0;
BEGIN
	sValRetorno := 'N';

    SELECT COUNT(NUM_ABONADO)
    INTO nContadorNoBloqueados
    FROM (
			SELECT NUM_ABONADO
            FROM   FA_CICLFACT A, GA_INFACCEL I
            WHERE  I.COD_CLIENTE = lCodCliente
            AND    I.IND_BLOQUEO != 1
            AND    A.COD_CICLFACT = I.COD_CICLFACT
            AND    A.IND_FACTURACION = 0
            UNION ALL
            SELECT NUM_ABONADO
            FROM   FA_CICLFACT C, GA_INFACBEEP I
            WHERE  I.COD_CLIENTE = lCodCliente
            AND    I.IND_BLOQUEO != 1
            AND    C.COD_CICLFACT = I.COD_CICLFACT
            AND    C.IND_FACTURACION = 0
         );

	IF nContadorNoBloqueados = 0 THEN
	   sValRetorno := 'S';
	END IF;

	RETURN 'OK';

EXCEPTION
	WHEN OTHERS THEN
		 RETURN 'SQL';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_VERIFCLIBLOQ_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_VERIFCLIBLOQ_FN;

FUNCTION CO_VERIFPAC_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  	Determina si el cliente tiene contratado algún PAC (Pago Automático de Cuenta)
--    Recibe      :  	Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  	"SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   	"OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "S" hay pendientes, en caso contrario "N".
nPac NUMBER(5);
sOut VARCHAR2(1);
BEGIN

	SELECT	COUNT(1)
	INTO	nPac
	FROM	CO_UNIPAC
	WHERE	COD_CLIENTE = lCodCliente;

	IF nPac > 0 THEN
	    sValRetorno := 'S';
	ELSE
		sValRetorno := 'N';
	END IF;

	RETURN 'OK';

EXCEPTION
	WHEN OTHERS THEN
		 RETURN 'ERRDT';
		 --RAISE_APPLICATION_ERROR(-20104,'ERROR CO_VERIFPAC_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
END CO_VERIFPAC_FN;

FUNCTION CO_VERIFRUTBAJA_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica que todos los abonados de todos los clientes de un rut
--                   especifico estan de baja, en caso contrario no se cumple el criterio
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = "S"  : Se Cumplio el Criterio
--                                             = "N"  : No se Cumplio el Criterio
nContadorNoDadosDeBaja NUMBER(5) := 0;
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
sOut VARCHAR2(1) := 'N';
iError PLS_INTEGER;
BEGIN
	 iError := CO_CRITERIOS_PG.CO_GETRUTCLIENTE_FN(lCodCliente, sNumIdent, sCodTipIdent);
	 IF iError = 0 THEN /* No encontro el rut */
	 	RETURN 'NORUT';
	 ELSE
	 	 IF iError < 0 THEN  /* Error oracle */
		 	RETURN 'SQL';
		 END IF;
	 END IF;

	 sValRetorno := 'N';

	 BEGIN
	 SELECT COUNT(1)
     INTO nContadorNoDadosDeBaja
     FROM (
            	SELECT NUM_ABONADO
            	FROM   GA_ABOCEL B, GE_CLIENTES C
            	WHERE  C.NUM_IDENT = sNumIdent
            	AND    C.COD_TIPIDENT = sCodTipIdent
            	AND    B.COD_CLIENTE = C.COD_CLIENTE
            	AND    B.COD_SITUACION != 'BA'
            	UNION ALL
            	SELECT NUM_ABONADO
            	FROM   GA_ABOBEEP A, GE_CLIENTES D
            	WHERE  D.NUM_IDENT = sNumIdent
            	AND    D.COD_TIPIDENT = sCodTipIdent
            	AND    A.COD_CLIENTE = D.COD_CLIENTE
            	AND    A.COD_SITUACION != 'BA'
         	) ;
	 EXCEPTION
	 	WHEN OTHERS THEN
			 RETURN 'SQL';
		END;

	IF nContadorNoDadosDeBaja = 0 THEN
	   sValRetorno := 'S';
	END IF;

	RETURN 'OK';

END CO_VERIFRUTBAJA_FN;

FUNCTION CO_VERIFRUTBLOQ_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripcion :  Verifica que todos los abonados de todos los clientes de un rut
--                   especifico estan bloqueados,en caso contrario no se cumple el criterio
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "NORUT"-> Fue imposible determinar el rut del cliente dado
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono = "S"  : Se Cumplio el Criterio
--                                             = "N"  : No se Cumplio el Criterio
nContadorNoBloqueados NUMBER(5) := 0;
sNumIdent GE_CLIENTES.NUM_IDENT%TYPE;
sCodTipIdent GE_CLIENTES.COD_TIPIDENT%TYPE;
iError PLS_INTEGER;
BEGIN

	 sValRetorno := 'N';
	 iError := CO_CRITERIOS_PG.CO_GETRUTCLIENTE_FN(lCodCliente, sNumIdent, sCodTipIdent);
	 IF iError = 0 THEN /* No encontro el rut */
	 	RETURN 'NORUT';
	 ELSE
	 	 IF iError < 0 THEN /* Error oracle */
		 	RETURN 'SQL';
		 END IF;
	 END IF;

	BEGIN
    SELECT COUNT(1)
    INTO nContadorNoBloqueados
    FROM (
            SELECT NUM_ABONADO
            FROM   FA_CICLFACT A, GA_INFACCEL B, GE_CLIENTES C
            WHERE  C.NUM_IDENT =    sNumIdent
            AND    C.COD_TIPIDENT = sCodTipIdent
            AND    B.COD_CLIENTE = C.COD_CLIENTE
            AND    B.IND_BLOQUEO != 1
            AND    A.COD_CICLFACT = B.COD_CICLFACT
            AND    A.IND_FACTURACION = 0
           UNION ALL
            SELECT NUM_ABONADO
            FROM   FA_CICLFACT D, GA_INFACBEEP E, GE_CLIENTES F
            WHERE  F.NUM_IDENT =    sNumIdent
            AND    F.COD_TIPIDENT = sCodTipIdent
            AND    E.COD_CLIENTE = F.COD_CLIENTE
            AND    E.IND_BLOQUEO != 1
            AND    D.COD_CICLFACT = E.COD_CICLFACT
            AND    D.IND_FACTURACION = 0 ) ;
    EXCEPTION
		WHEN OTHERS THEN
			 RETURN 'SQL';
		END;

	IF nContadorNoBloqueados = 0 THEN
	   sValRetorno := 'S';
	END IF;

	RETURN 'OK';

END CO_VERIFRUTBLOQ_FN;

FUNCTION CO_BUSCAFADPARAMETROS_FN(lCodParam IN NUMBER, sTipCampo IN VARCHAR2, sCodModulo IN VARCHAR2,sOut OUT VARCHAR2) RETURN BOOLEAN IS

BEGIN
	BEGIN
	SELECT DECODE ( sTipCampo, 	'DATE'  	, TO_CHAR( VAL_FECHA   , 'yyyymmdddd' ),
								'NUMBER'  	, TO_CHAR( VAL_NUMERICO, '9999999999' ),
								'VARCHAR2'	, VAL_CARACTER )
	INTO    sOut
	FROM    FAD_PARAMETROS
	WHERE   COD_PARAMETRO = lCodParam
	AND     TIP_PARAMETRO = sTipCampo
	AND     COD_MODULO    = sCodModulo;
	EXCEPTION
		WHEN OTHERS THEN
			RETURN FALSE;
		END;
	RETURN TRUE;
END CO_BUSCAFADPARAMETROS_FN;

/* Inicio Incidencia 116004 - 02.12.2009 - TMG-TMS */
/* ============================================================================= */
FUNCTION CO_COLORCLI_FN(lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN VARCHAR2 IS
--    Descripción :  Obtiene el Color del cliente
--    Recibe      :  Cod Cliente      (Sobre el cual se verifica el criterio)
--    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
--                   "OK"   -> Se evaluo el criterio correctamente
--                             Valor de Retono =  "ROJO" , "ORO" , ETC
BEGIN
		sValRetorno:= ' ';

		IF NOT (CO_CRITERIOS_PG.CO_GETCOLOR_FN (lCodCliente, sValRetorno)) THEN
		   RETURN 'SQL';
		ELSE
		   RETURN 'OK';
		END IF;

END CO_COLORCLI_FN;

/* Fin Incidencia 130999 - 22.04.2010 - TMG-TMS */
FUNCTION CO_GETCOLOR_FN (lCodCliente IN NUMBER, sValRetorno OUT VARCHAR2) RETURN BOOLEAN IS
/* ============================================================================= */
/* Obtiene el COLOR del Cliente   Retorna FALSE si no puede determinarlo         */
/* ============================================================================= */

BEGIN

    BEGIN
         SELECT DES_COLOR   
           INTO sValRetorno
           FROM GE_COLOR_TD A
          WHERE EXISTS (SELECT 1
                        FROM   GE_CLIENTES B
                        WHERE  B.COD_CLIENTE = lCodCliente
                        AND    B.COD_COLOR   = A.COD_COLOR);
         EXCEPTION                        
         WHEN NO_DATA_FOUND THEN         
              SELECT DES_COLOR              
                INTO sValRetorno
                FROM GE_COLOR_TD A
               WHERE EXISTS (SELECT 1
                             FROM   GED_PARAMETROS B
                             WHERE  NOM_PARAMETRO   = 'COLOR_DEFAULT'
                             AND    B.VAL_PARAMETRO = A.COD_COLOR);              
         WHEN OTHERS THEN
              RETURN FALSE;
    END;

    RETURN TRUE;
END CO_GETCOLOR_FN;

/* Fin Incidencia 130999 - 22.04.2010 - TMG-TMS */
/* Fin Incidencia 116004 - 02.12.2009 - TMG-TMS */


END CO_CRITERIOS_PG; -- Package Body CO_CRITERIOS_PG
/
SHOW ERRORS
