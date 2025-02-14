CREATE OR REPLACE PROCEDURE FA_PROC_PRE_NCBAJAS (
	piCodCliente 	IN NUMBER,
	piNumAbonado 	IN NUMBER,
	pszFecBaja   	IN VARCHAR2,
	piIndActuac  	IN NUMBER,
	pszUser       	IN VARCHAR2,
	piNumProceso 	IN NUMBER,
	piOrigenSolic	IN NUMBER
) IS

/* ----------------------------------------------------------------- */
/* PROCESO PARA LA GENERACION DE SOLICITUDES DE NOTAS DE CREDITO POR */
/* BAJA DE SERVICIO O CAMBIO DE PLAN TARIFARIO, EN REGIMEN DE        */
/* CONCEPTOS DE CARGOS RECURRENTES CON MODALIDAD DE COBRO ANTICIPADO.*/
/* ----------------------------------------------------------------- */
/* PARAMETROS:                                                       */
/* 	piCodCliente: 	Codigo del cliente al quese le hace la baja.     */
/* 	piNumAbonado:	Numero de abonado que es dado de baja.           */
/*	pszFecBaja  :	Fecha de la baja enformato : YYYYMMDD            */
/*	piIndActuac :	Indicador de actuacion parala emision de la      */
/* 					NC. 1: emision por baja. Se consideran todos     */
/*					los cargos recurrentes de la factura.            */
/*					    2: emision por cambio de plan inmediato.     */
/* 					la NC es emitida solo sobre los conceptos de     */
/*					cargo basico presentes en la factura.            */
/* 	piNumProceso:	Secuencia de numero de proceso para gestiom a    */
/*					traves de la tabla ga_transacabo.                */
/* 	piOrigenSolic:	Origen de la Solicitud. Usuario o Proceso de Fact*/
/*					0: Proceso de Baja o Cambio de Plan.             */
/*					1: Proceso de Reliquidacion (scheduler).         */
/* 	pszUser:		Usuario de la Solicitud.                         */
/* ----------------------------------------------------------------- */
/* diseñada por  : FABIAN AEDO RAMIREZ (ANALISTA DE FACTURACION).    */
/* programada por: PATRICIO GONZALEZ   (ANALISTA PROGRAMADOR).       */
/*                 FABIAN AEDO RAMIREZ (ANALISTA DE FACTURACION).    */
/* MARZO 27 DEL 2002.                                                */
/* ----------------------------------------------------------------- */
/* PROCESO:                                                          */
/* 1.- RECIBE PARAMETROS E INSERTA UNA SOLICITUD EN TABLA DE SOLIC.  */
/*     (FAT_SOLICNCBAJAS).                                           */
/* 2.- EJECUTA PROCEDIMIENTO DE EMISION DE NOTA DE CREDITO.          */
/* 3.- DE ACUERDO AL RESULTADO DEL PROCESO, REALIZA:                 */
/*     RETORNO 0: EMISION OK : PASA SOLICITUD A HISTORICOS.          */
/*                Y RETORNA 0. (OK).                                 */
/*     RETORNO 1: NO ENCONTRO FACTURACION CICLO. POR LO QUE EVALUA   */
/*                ORIGEN DE LA SOLICITUD. ORIGEN 0: POST VENTA, LUEGO*/
/*                INFORMA QUE SOLICITUD QUEDA PENDIENTE, RETORNA 1.  */
/*                SI ORIGEN ES 1 (CICLOS), PASA LA SOLICITUD A HIST. */
/*                CON GLOSA EXPLICATIVA QUE NO SE EMITIO LA NC.      */
/* ----------------------------------------------------------------- */

/* ----------------------------------------------------------------- */
/* CONSTANTES DE USO GENERAL                                         */
/* ----------------------------------------------------------------- */
	iErr0	NUMBER(2) := 0;	/* SALIDA EXITOSA DEL PROCESO.           */
	iErr1	NUMBER(2) := 1;	/* ERROR NO ENCONTRO FACTURA DE CICLO.   */
	iErr2	NUMBER(2) := 2;	/* ERROR. EL PROCESO SE ABORTA.          */
/* ----------------------------------------------------------------- */
/* VARIABLES GLOBALES                                                */
/* ----------------------------------------------------------------- */
	iCodError		NUMBER(2) := 0;
	iDesError		VARCHAR2(60);
	iSecuencia2		NUMBER(8);
	iCodRetorno		NUMBER(1);
	szDesCadena		VARCHAR(255);
	ERROR_PROCESO 	EXCEPTION;

	iCodCiclFact    FA_CICLFACT.COD_CICLFACT%TYPE; /* Agregada por PGonzaleg 10-04-2002 */
BEGIN

/* ----------------------------------------------------------------- */
/* -- Validacion de Parametros de entrada                            */
/* ----------------------------------------------------------------- */
	IF piCodCliente is null or  piCodCliente = 0 THEN
	        iCodError := iErr2;
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        RAISE ERROR_PROCESO;
	END IF;

	IF  pszFecBaja is null or  pszFecBaja = '' THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	    	RAISE ERROR_PROCESO;
    	END IF;

	IF piNumAbonado is null or  piNumAbonado < 0 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF piIndActuac is null or  piIndActuac < 1 or piIndActuac > 2 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF pszUser is null or  pszUser = '' THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF piNumProceso is null or  piNumProceso <= 0 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
   	END IF;

	IF piOrigenSolic is null or  piOrigenSolic < 0 or piOrigenSolic > 1 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
   	END IF;

/* -------------------------------------------------------------------- */
/* -- OBTIENE CICLO DE FACTURACION PARA DOCUMENTO SOBRE EL QUE HARA LA  */
/* -- REBAJA O NOTA DE CREDITO.                                         */
/* -------------------------------------------------------------------- */
   	BEGIN
   		SELECT B.COD_CICLFACT
   		INTO iCodCiclfact
		FROM GA_INTARCEL A,FA_CICLFACT B
		WHERE A.COD_CLIENTE  =  piCodCliente
		AND A.NUM_ABONADO    =  piNumAbonado
		AND (A.FEC_HASTA    >  TO_DATE(pszFecBaja,'YYYYMMDD') OR A.FEC_HASTA IS NULL)
		AND A.FEC_DESDE     <= TO_DATE(pszFecBaja,'YYYYMMDD')
		AND A.COD_CICLO      = B.COD_CICLO
		AND B.FEC_EMISION    = (SELECT MAX(X.FEC_EMISION) FROM FA_CICLFACT X 
			WHERE X.COD_CICLO   = B.COD_CICLO
			  AND X.FEC_EMISION < TO_DATE(pszFecBaja,'YYYYMMDD'));
   	EXCEPTION
   		WHEN OTHERS THEN
   			iDesError :='ERROR OBTENIENDO CODIGO DEL CICLO DE FACTURACION.';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
   	END;
/* ----------------------------------------------------------------- */
/* -- VALIDA QUE LAS FECHAS DE ALTA Y DE BAJA DEL ABONADO NO CORRES- */
/* -- PONDAN AL MISMO CICLO, YA QUE DE SER ASI, NO SE PUEDE EMITIR   */
/* -- NOTA DE CREDITO.                                               */
/* ----------------------------------------------------------------- */
	DECLARE
		v_aux	NUMBER(1);
	BEGIN
		SELECT COUNT(*) INTO v_aux
		FROM GA_ABOCEL A,FA_CICLFACT B
		WHERE A.NUM_ABONADO = piNumAbonado
		AND B.COD_CICLFACT = iCodCiclfact
		AND A.FEC_ALTA >= B.FEC_DESDECFIJOS
		AND A.FEC_BAJA <= B.FEC_HASTACFIJOS;
		IF v_aux > 0 THEN
			BEGIN
	   			iDesError :='FECHAS DE ALTA Y BAJA DEL ABONADO, DENTRO DEL CICLO.';
		        iCodError := iErr2;
				INSERT INTO FAH_SOLICNCBAJA (
					   COD_CLIENTE, 		NUM_ABONADO,
					   COD_CICLFACT, 		FEC_SOLICITUD,
					   NUM_PROCESO,			FEC_PROCESO,
					   FLG_EMISION,			NOM_USUARIO_SOLIC,
					   FEC_ULTMOD,			GLS_EMISION,
					   NOM_USUARIO )
				VALUES (piCodCliente,		piNumAbonado,
					   iCodCiclfact,		TO_DATE(pszFecBaja,'YYYYMMDD'),
					   0,					SYSDATE,
					   0,					pszUser,
					   SYSDATE,				iDesError,
					   USER);
			EXCEPTION
				WHEN OTHERS THEN
		   			iDesError :='ERROR GUARDANDO DATOS EN HISTORICO.';
			        iCodError := iErr2;
			        RAISE ERROR_PROCESO;
			END;
	        RAISE ERROR_PROCESO;
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
   			iDesError :='ERROR VALIDANDO FECHAS DE ALTA Y BAJA RESPECTO DEL CICLO.';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
	END;
	
/* ----------------------------------------------------------------- */
/* -- almacena la solicitud en tabla de solicutdes.                  */
/* ----------------------------------------------------------------- */
	BEGIN
		INSERT INTO FAT_SOLICNCBAJA (
			   COD_CLIENTE, 		NUM_ABONADO,
			   COD_CICLFACT, 		FEC_SOLICITUD,
			   NUM_PROCESO,			FEC_PROCESO,
			   FLG_EMISION,			NOM_USUARIO_SOLIC,
			   FEC_ULTMOD,			NOM_USUARIO )
		VALUES (piCodCliente,		piNumAbonado,
			   iCodCiclfact,		TO_DATE(pszFecBaja,'YYYYMMDD'),
			   0,					SYSDATE,
			   0,					pszUser,
			   SYSDATE,				USER);
	EXCEPTION
		WHEN OTHERS THEN
		    iDesError :='ERROR EN INSERCION EN FAT_SOLICNCBAJA.';
	        iCodError := iErr2;
	        RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Recupera el valor de la secuencia de GA_TRANSACABO.               */
/* ----------------------------------------------------------------- */
	BEGIN
		SELECT GA_SEQ_TRANSACABO.NEXTVAL
		INTO iSecuencia2
		FROM DUAL;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError :='ERROR SELECCIONANDO SECUENCIA';
			iCodError := iErr2;
			RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Ejecuta procedure almacenado  FA_PROC_NCBAJAS                     */
/* ----------------------------------------------------------------- */
	FA_PROC_NCBAJAS(piCodCliente,piNumAbonado,pszFecBaja,piIndActuac,pszUser,iSecuencia2,iCodCiclFact);
	iCodRetorno := 0;
	szDesCadena := '';
	BEGIN
		SELECT COD_RETORNO, DES_CADENA
		INTO iCodRetorno, szDesCadena
		FROM GA_TRANSACABO
		WHERE NUM_TRANSACCION = iSecuencia2;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError :='ERROR EN RETORNO DESDE FA_PROC_NCBAJA.';
			iCodError := iErr2;
			RAISE ERROR_PROCESO;
	END;
	IF iCodRetorno = 0 THEN
		DECLARE
			szSqlText	VARCHAR2(500);
			iResul		INTEGER;
		BEGIN
			szSqlText := 'INSERT INTO FAH_SOLICNCBAJA (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,FEC_SOLICITUD, ';
			szSqlText := szSqlText||'NUM_PROCESO,FEC_PROCESO,FLG_EMISION,NOM_USUARIO_SOLIC,FEC_ULTMOD,NOM_USUARIO) ';
			szSqlText := szSqlText||'SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,FEC_SOLICITUD, ';
			szSqlText := szSqlText||szDesCadena||',SYSDATE,1,NOM_USUARIO_SOLIC,SYSDATE,'''||USER||''' ';
			szSqlText := szSqlText||'FROM FAT_SOLICNCBAJA ';
			szSqlText := szSqlText||'WHERE COD_CLIENTE ='||TO_CHAR(piCodCliente)||' ';
			szSqlText := szSqlText||'AND NUM_ABONADO   = '||TO_CHAR(piNumAbonado)||' ';
			szSqlText := szSqlText||'AND FEC_SOLICITUD = TO_DATE('||pszFecBaja||',''YYYYMMDD'')'; 
			iCursor := DBMS_SQL.OPEN_CURSOR;
			DBMS_SQL.PARSE(iCursor, szSqlText, DBMS_SQL.V7);
			iResul := DBMS_SQL.EXECUTE(iCursor);
		EXCEPTION
			WHEN OTHERS THEN
				iDesError :='ERROR TRASPASANDO REGISTRO A HISTORICOS';
				iCodError := iErr2;
				RAISE ERROR_PROCESO;
		END;
/* ----------------------------------------------------------------- */
/* Ejecuta procedure almacenado  FA_PROC_NCBAJA                      */
/* ----------------------------------------------------------------- */
		BEGIN
			DELETE FROM FAT_SOLICNCBAJA
			WHERE COD_CLIENTE = piCodCliente
			AND NUM_ABONADO   = piNumAbonado
			AND FEC_SOLICITUD = TO_DATE(pszFecBaja,'YYYYMMDD');  /* FEC_BAJA por FEC_SOLICITUD por PGonzlaeg 10-04-2002 */
		EXCEPTION
			WHEN OTHERS THEN
				iDesError :='ERROR BORRANDO REGISTRO DE FAT_SOLICNCBAJAS.';
				iCodError := iErr2;
				RAISE ERROR_PROCESO;
		END;
	ELSIF iCodRetorno = 1  THEN
		iDesError :='NO ENCONTRO LA FACTURA DE CICLO, QUEDA PENDIENTE.';
		iCodError := iErr1;
		RAISE ERROR_PROCESO;
	ELSE
		iDesError :=szDesCadena;
		iCodError := iErr2;
		RAISE ERROR_PROCESO;
	END IF;
	iCodError := iErr0;
	iDesError :='SALIDA EXITOSA DEL PROCESO.';
	RAISE ERROR_PROCESO;
EXCEPTION
	WHEN ERROR_PROCESO THEN
		IF iCodError != 0 THEN
			ROLLBACK;
		END IF;
		INSERT INTO GA_TRANSACABO VALUES (piNumProceso,iCodError,iDesError);
		COMMIT;
	WHEN OTHERS THEN
		ROLLBACK;
		INSERT INTO GA_TRANSACABO VALUES (piNumProceso,iCodError,iDesError);
		COMMIT;
END FA_PROC_PRE_NCBAJAS;
