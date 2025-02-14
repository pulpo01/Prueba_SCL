CREATE OR REPLACE PROCEDURE        FA_PROC_NCBAJAS(
	piNumProceso 	IN NUMBER,
	piCodCliente 	IN NUMBER,
	piNumAbonado 	IN NUMBER,
	pszFecBaja   	IN VARCHAR2,
	piIndActuac  	IN NUMBER,
	pszUser       	IN VARCHAR2,
	piCodCiclFact	IN NUMBER
)IS
    CURSOR CursorDOS (iNumFolio NUMBER, piCodCliente NUMBER, piNumAbonado NUMBER)
    IS SELECT
		COD_CONCEPTO,
		COLUMNA,
		IMP_CONCEPTO,
		IMP_FACTURABLE
	FROM FA_AJUSTECONC
	WHERE NUM_FOLIO    = iNumFolio
	  AND COD_CLIENTE  = piCodCliente
	  AND NUM_ABONADO  = piNumAbonado;

	TYPE TypRecConcepto is RECORD (
   		iIndOrdentotal	NUMBER(12),
	   	iNumFolio		NUMBER(12),
	   	iCodCliente		NUMBER(8),
	   	iNumAbonado		NUMBER(8),
	   	iCodConcepto	NUMBER(4),
		iColumna		NUMBER(8),
	   	iImpConcepto	NUMBER(14,4),
	   	iNCAplicada     NUMBER(14,4),
	   	iImpAplica		NUMBER(14,4),
	   	iImpRebaja		NUMBER(14,4),
	   	szCodTipDocum	VARCHAR2(2),
		iIndConsidera	NUMBER(1),	/* 1:SI 0:NO */
		iIndCargoBasico	NUMBER(1));	/* 1:SI 0:NO */

   	TYPE TypTabConcepto IS TABLE OF TypRecConcepto
   	INDEX BY BINARY_INTEGER;
/*
	piCodCliente    NUMBER(8);
	piNumAbonado	NUMBER(8);
	pszFecBaja		VARCHAR2(10);
	piIndActuac		NUMBER(1);
	piNumProceso	NUMBER(8);
	pszUSer			VARCHAR2(30);
*/


/* ----------------------------------------------------------------- */
/* PROCESO PARA LA EMISION DE NOTAS DE CREDITO POR BAJA DE SERVICIO O*/
/* CAMBIO DE PLAN TARIFARIO, EN REGIMEN DE CONCEPTOS DE CARGOS       */
/* RECURRENTES CON MODALIDAD DE COBRO ANTICIPADO.                    */
/* ----------------------------------------------------------------- */
/* PARAMETROS:                                                       */
/* 	piCodCliente: 	Codigo del cliente al quese le hace la baja.     */
/* 	piNumAbonado:	Numero de abonado quees dado de baja.             */
/*	pszFecBaja  :	Fecha de la baja enformato : YYYYMMDD            */
/*	piIndActuac :	Indicador de actuacion parala emision de la      */
/* 					NC. 1: emision por baja. Se consideran todos     */
/*					los cargos recurrentes de la factura.            */
/*					    2: emision por cambio de plan inmediato.     */
/* 					la NC es emitida solo sobre los conceptos de     */
/*					cargo basico presentes en la factura.            */
/* 	piNumProceso:	Secuencia de numero de proceso para gestiom a    */
/*					traves de la tabla ga_transacabo.                */
/* 	pszUser:		Usuario de la Solicitud.                         */
/*  piCodCiclFact:	Ciclo de Facturacion del documento a rebajar.    */
/* ----------------------------------------------------------------- */
/* dise?ada por  : FABIAN AEDO RAMIREZ (ANALISTA DE FACTURACION).    */
/* programada por: PATRICIO GONZALEZ   (ANALISTA PROGRAMADOR).       */
/*                 FABIAN AEDO RAMIREZ (ANALISTA DE FACTURACION).    */
/* MARZO 27 DEL 2002.                                                */
/* ----------------------------------------------------------------- */
/* SALIDAS                                                           */
/* RETORNO 0: -> SALIDA EXITOSA DEL PROCESO. SE EMITE N.C.           */
/* RETORNO 1: -> SALIDA CON ERROR.                                   */
/* retorno 2: -> SALIDA EXITOSA. NO EXISTE FACTURA. QUEDA PENDIENTE  */
/* ----------------------------------------------------------------- */
/* CONSTANTES DE USO GENERAL                                         */
/* ----------------------------------------------------------------- */
	iErr0	NUMBER(2) := 0;	/* SALIDA EXITOSA DEL PROCESO.           */
	iErr1	NUMBER(2) := 1;	/* ERROR GRAVE. SE ABORTA LA EJECUCION.  */
	iErr2	NUMBER(2) := 2;	/* SALIDA EXITOSA. NO EXISTE FACTURA.    */
/* ----------------------------------------------------------------- */
/* VARIABLES DEL PROCESO.                                            */
/* ----------------------------------------------------------------- */
	stConcepto		TypTabConcepto;
	stConc_Ind		BINARY_INTEGER := 0;

	rcDatosGener	FA_DATOSGENER%ROWTYPE;
	iCursor			INTEGER;
	CursorInsert	INTEGER;
	iNumFolio		FA_HISTDOCU.NUM_FOLIO%TYPE := 0;
	iCodError		NUMBER(2) := 0;
	iDesError		VARCHAR2(60);
	szCodPlanTarif	GA_INTARCEL.COD_PLANTARIF%TYPE;
	iCodCiclo		GA_INTARCEL.COD_CICLO%TYPE;
	szCodTipDocum	FA_HISTDOCU.COD_TIPDOCUM%TYPE;
	iIndOrdenTotal	FA_HISTDOCU.IND_ORDENTOTAL%TYPE;
	szSqlText		VARCHAR2(500);
	iCodConcepto	FA_NCPARCIAL.COD_CONCEPTO%TYPE;
	iImpConcepto	FA_NCPARCIAL.IMP_CONCEPTO%TYPE;
	iColumna		FA_NCPARCIAL.COLUMNA%TYPE;
	iResul			NUMBER(4);
	i				NUMBER(4);
	iDiasPeriodo	NUMBER(8);
	iDiasNC			NUMBER(2);
	iFactor			NUMBER(14,4);
	iMtoNC			NUMBER(14,4);
	iImpMaxUsuario	NUMBER(8);
	iSecuencia		NUMBER(8);
	iSecuencia2		NUMBER(8);
	iExisteNC		NUMBER(2) := 1;
	iCodRetorno		NUMBER(1);
	szDesCadena		VARCHAR(255);
	ERROR_PROCESO 	EXCEPTION;
BEGIN
/* ----------------------------------------------------------------- */
/* -- Validacion de Parametros de entrada                            */
/* ----------------------------------------------------------------- */
	IF piCodCliente is null or  piCodCliente = 0 THEN
	        iCodError := iErr1;
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        RAISE ERROR_PROCESO;
	END IF;

	IF  pszFecBaja is null or  pszFecBaja = '' THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	    	RAISE ERROR_PROCESO;
    	END IF;

	IF piNumAbonado is null or  piNumAbonado < 0 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF piIndActuac is null or  piIndActuac < 1 or piIndActuac > 2 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF pszUser is null or  pszUser = '' THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
    	END IF;

	IF piNumProceso is null or  piNumProceso <= 0 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
   	END IF;

	IF piCodCiclFact is null or  piCodCiclFact <= 0 THEN
	        iDesError := 'ERROR EN PARAMETROS DE ENTRADA. ';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
   	END IF;


/* ----------------------------------------------------------------- */
/* Recupera datos desde la tabla ge_datosgener.                      */
/* ----------------------------------------------------------------- */
	BEGIN
		SELECT *
		INTO rcDatosGener
		FROM FA_DATOSGENER;
	EXCEPTION
		WHEN OTHERS THEN
	        iDesError :='NO PUEDE RECUPERAR DATOSGENER.';
	        iCodError := iErr1;
	        RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Recupera el ciclo del cliente abonado                             */
/* ----------------------------------------------------------------- */
   	BEGIN
		SELECT DISTINCT A.COD_PLANTARIF, A.COD_CICLO
		INTO szCodPlanTarif, iCodCiclo
		FROM GA_INTARCEL A
		WHERE A.COD_CLIENTE  =  piCodCliente
		AND A.NUM_ABONADO    =  piNumAbonado
		AND A.FEC_DESDE     <= TO_DATE(pszFecBaja,'YYYYMMDD')
		AND (A.FEC_HASTA    >= TO_DATE(pszFecBaja,'YYYYMMDD') OR A.FEC_HASTA IS NULL);
	EXCEPTION
		WHEN OTHERS THEN
		    iDesError :='NO EXISTE REGISTRO EN GA_INTARCEL.';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Recupera documento desde FA_HISTDOCU.                             */
/* ----------------------------------------------------------------- */
	BEGIN
		SELECT NUM_FOLIO, IND_ORDENTOTAL, COD_TIPDOCUM
		INTO iNumFolio, iIndOrdenTotal, szCodTipDocum
		FROM FA_HISTDOCU
		WHERE COD_CLIENTE = piCodCliente
		AND COD_CICLFACT = piCodCiclFact
		AND COD_TIPDOCUM IN (SELECT UNIQUE COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN
			WHERE IND_CICLO = 1);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		    iDesError :='NO EXISTE FACTURA O DOCUMENTO DE CICLO. QUEDA PENDIENTE';
			iCodError := iErr2;
			RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/*-- El Numero de Folio debe ser mayor a cero.                       */
/* ----------------------------------------------------------------- */
	IF iNumFolio <= 0  THEN
		iDesError :='FOLIO DE LA FACTURA DEBE SER > 0.';
     	iCodError := iErr1;
		RAISE ERROR_PROCESO;
    END IF;
/* ----------------------------------------------------------------- */
/* -- Se recupera las cantidad de dias del ciclo y la cantidad de    */
/* -- dias que se deben devolver al cliente.                         */
/* ----------------------------------------------------------------- */
	BEGIN
		SELECT DIA_PERIODO,TRUNC(FEC_HASTACFIJOS - TO_DATE(pszFecBaja, 'YYYYMMDD'))
		INTO iDiasPeriodo, iDiasNC
		FROM FA_CICLFACT
		WHERE COD_CICLFACT = piCodCiclFact;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			iDesError :='NO HAY DATOS EN FA_CILFACT.';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;

/* -- Calcula el factor usado para calcular el monto por el cual se hara la NC */
	iFactor := iDiasNC / iDiasPeriodo;

/* ----------------------------------------------------------------- */
/* -- Extraccion de Detalle del Documento de la Tabla:               */
/* -- FA_HISTCONC_<Ciclo>                                            */
/* -- SOLO CONCEPTOS RECURRENTES                                     */
/* ----------------------------------------------------------------- */
	BEGIN
		szSqlText := '';
		szSqlText := 'SELECT A.COD_CONCEPTO, A.COLUMNA, A.IMP_CONCEPTO ';
		szSqlText := szSqlText || 'FROM FA_HISTCONC_' || rtrim(to_char(piCodCiclFact)) || ' A, FA_CONCEPTOS B ';
       	szSqlText := szSqlText || 'WHERE A.IND_ORDENTOTAL = ' || rtrim(to_char(iIndOrdenTotal))|| ' ';
       	szSqlText := szSqlText || 'AND A.NUM_ABONADO = ' || rtrim(to_char(piNumAbonado))|| ' ';
       	szSqlText := szSqlText || 'AND A.COD_CONCEPTO = B.COD_CONCEPTO ';
       	szSqlText := szSqlText || 'AND B.IND_RECURRENTE = 1';
/* ----------------------------------------------------------------- */
/* -- Prepara un cursor para obtener los conceptos.                  */
/* ----------------------------------------------------------------- */
		iCursor := DBMS_SQL.OPEN_CURSOR;

		DBMS_SQL.PARSE(iCursor, szSqlText, DBMS_SQL.V7);
		DBMS_SQL.DEFINE_COLUMN(iCursor, 1, iCodConcepto);
		DBMS_SQL.DEFINE_COLUMN(iCursor, 2, iColumna);
		DBMS_SQL.DEFINE_COLUMN(iCursor, 3, iImpConcepto);

		iResul := DBMS_SQL.EXECUTE(iCursor);
		i := 0;
		LOOP
			IF DBMS_SQL.FETCH_ROWS(iCursor) > 0 THEN
/* ----------------------------------------------------------------- */
/*			-- Valores para insertar en la tabla temporal            */
/* ----------------------------------------------------------------- */
				DBMS_SQL.COLUMN_VALUE(iCursor, 1, iCodConcepto);
				DBMS_SQL.COLUMN_VALUE(iCursor, 2, iColumna);
				DBMS_SQL.COLUMN_VALUE(iCursor, 3, iImpConcepto);

				stConcepto(i).iIndOrdenTotal	:= iIndOrdenTotal;
				stConcepto(i).iNumFolio		:= iNumFolio;
				stConcepto(i).iCodCliente	:= piCodCliente;
				stConcepto(i).iNumAbonado	:= piNumAbonado;
				stConcepto(i).iCodConcepto	:= iCodConcepto;
				stConcepto(i).iColumna		:= iColumna;
				stConcepto(i).iImpConcepto	:= iImpConcepto;
				stConcepto(i).iNCAplicada	:= 0;
				stConcepto(i).iImpAplica	:= iImpConcepto;
				stConcepto(i).iImpRebaja	:= 0;
				stConcepto(i).szCodTipDocum	:= szCodTipDocum;
				stConcepto(i).iIndConsidera	:= 1;
				i := i + 1;
			ELSE
				DBMS_SQL.CLOSE_CURSOR(iCursor);
				EXIT;
			END IF;
		END LOOP;
		stConc_Ind := i - 1;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError :='NO PUDO LLENAR ESTRUCTURA CONCEPTOS.';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Recorre arreglo de concepto, para validar:                        */
/* -- PONE TIPO DE CONCEPTO CB Y NO CB.                              */
/* -- que tengan modalidad de cobro anticipado.                      */
/* -- IndActuac versus conceptos.                                    */
/* ----------------------------------------------------------------- */
	FOR i IN 0..stConc_Ind LOOP
		IF stConcepto(i).iCodConcepto = rcDatosGener.COD_ABONOCEL OR
		   stConcepto(i).iCodConcepto = rcDatosGener.COD_ABONOBEEP OR
		   stConcepto(i).iCodConcepto = rcDatosGener.COD_ABONOTREK OR
		   stConcepto(i).iCodConcepto = rcDatosGener.COD_ABONOTRUNK THEN
			stConcepto(i).iIndCargoBasico := 1;
		ELSE
			stConcepto(i).iIndCargoBasico := 0;
		END IF;

		DECLARE
			vp_TipoCobro FA_GRUPOCOB.TIP_COBRO%TYPE;
		BEGIN

			SELECT A.TIP_COBRO INTO vp_TipoCobro
			FROM FA_GRUPOCOB A,FA_CONCEPTOS B
			WHERE B.COD_CONCEPTO = stConcepto(i).iCodConcepto
			AND B.COD_CONCEPTO   = A.COD_CONCEPTO
			AND B.COD_PRODUCTO   = A.COD_PRODUCTO
			AND A.COD_CICLO      = iCodCiclo
			AND TO_DATE(pszFecBaja,'YYYYMMDD') BETWEEN A.FEC_DESDE AND A.FEC_HASTA;

			IF vp_TipoCobro = 0 then /* COBRO VENCIDO...*/
				stConcepto(i).iIndConsidera := 0;		-- PGonzaleg (i)
			END IF;
		EXCEPTION
			WHEN OTHERS THEN
				iDesError :='NO PUEDE DETERMINAR TIPO DE COBRO.';
				iCodError := iErr1;
				RAISE ERROR_PROCESO;
		END;
/* ----------------------------------------------------------------- */
/* DETERMINA SI CONSIDERA EL CONCEPTO EN FUNCION DE LA ACTUACION.    */
/* SI ES DISTINTO DE CARGO BASICO Y SE TRATA DE UN CAMBIO DE PLAN... */
/* NO LO CONSIDERARA.EL CARGO BASICO SIEMPRE LO CONSIDERA.           */
/* ----------------------------------------------------------------- */
		IF stConcepto(i).iIndCargoBasico = 0 AND piIndActuac = 2 THEN
			stConcepto(i).iIndConsidera := 0;
		END IF;
	END LOOP;
/* ----------------------------------------------------------------- */
/*	-- Busca Notas de Credito ya Procesadas.                         */
/* ----------------------------------------------------------------- */
	DECLARE
		iCantidad NUMBER(3);
	BEGIN
		SELECT COUNT(*)
		INTO iCantidad
		FROM FA_AJUSTES
		WHERE NUM_FOLIO = iNumFolio
		AND COD_CLIENTE = piCodCliente;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			iExisteNC := 0;
		WHEN OTHERS THEN
			iDesError :='ERROR AL RECUPERAR NC YA PROCESADA';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;

	dbms_output.put_line ('EXISTE NC = '|| TO_CHAR(iExisteNC));
/* ----------------------------------------------------------------- */
/* Busca, dentro de las NC los conceptos que se requieran...         */
/* ----------------------------------------------------------------- */
	IF iExisteNC >= 1 THEN
		i := 0;
		FOR x IN CursorDOS (iNumFolio, piCodCliente, piNumAbonado) LOOP
			FOR i IN 0..stConc_Ind LOOP
				IF stConcepto(i).iCodConcepto = x.COD_CONCEPTO AND x.IMP_CONCEPTO <> 0 THEN
					stConcepto(i).iNCAplicada := x.IMP_CONCEPTO;
				END IF;

			END LOOP;
		END LOOP;
	END IF;
/* ----------------------------------------------------------------- */
/* Actualiza los montos sobre los que se aplicara la rebaja.         */
/* y aplica la rebaja, en funcion del factor.                        */
/* ----------------------------------------------------------------- */
	iMtoNC := 0;
	FOR i IN 0..stConc_Ind LOOP
		stConcepto(i).iImpAplica := stConcepto(i).iImpConcepto - stConcepto(i).iNCAplicada;
		IF stConcepto(i).iIndConsidera = 1 THEN
			stConcepto(i).iImpRebaja := iFactor * stConcepto(i).iImpConcepto;
			IF stConcepto(i).iImpRebaja >= stConcepto(i).iImpAplica THEN
				stConcepto(i).iImpRebaja := stConcepto(i).iImpAplica;
			END IF;
		ELSE
			stConcepto(i).iImpRebaja := 0;
		END IF;

		IF stConcepto(i).iImpRebaja = 0 THEN
			stConcepto(i).iIndConsidera := 0;
		END IF;
		iMtoNC := iMtoNC + stConcepto(i).iImpRebaja;
	END LOOP;
	IF iMtoNC = 0 THEN
		iDesError := 'MONTO DE LA NC ES 0. NO SE EMITE.';
		iCodError := iErr1;
		RAISE ERROR_PROCESO;
	END IF;
/* ----------------------------------------------------------------- */
/* Valida los permisos del usuario por monto de NC.                  */
/* ----------------------------------------------------------------- */
	iImpMaxUsuario :=0;
	BEGIN
		SELECT NVL(IMP_MAXIMO,0)
		INTO iImpMaxUsuario
		FROM FA_CONTROLNC
		WHERE NOM_USUARIO = USER
		AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
	EXCEPTION
		WHEN OTHERS THEN
			iImpMaxUsuario :=0;
	END;

	IF iImpMaxUsuario < iMtoNC THEN
		iDesError :='ERROR POR NO DISPONER DE PERMISO POR MONTO';
		iCodError := iErr1;
		RAISE ERROR_PROCESO;
	END IF;
/* ----------------------------------------------------------------- */
/* Lista el contenido de la estructura de Conceptos..                */
/* ----------------------------------------------------------------- */
/*		dbms_output.put_line('-------------------------------------------------' );
		FOR i IN 0..stConc_Ind LOOP
			dbms_output.put_line('stConcepto(i).iIndOrdentotal  	: ' || stConcepto(i).iIndOrdentotal );
			dbms_output.put_line('stConcepto(i).iNumFolio       	: ' || stConcepto(i).iNumFolio      );
			dbms_output.put_line('stConcepto(i).iCodCliente     	: ' || stConcepto(i).iCodCliente    );
			dbms_output.put_line('stConcepto(i).iNumAbonado   	: ' || stConcepto(i).iNumAbonado    );
			dbms_output.put_line('stConcepto(i).iCodConcepto	: ' || stConcepto(i).iCodConcepto   );
			dbms_output.put_line('stConcepto(i).iColumna 	 	: ' || stConcepto(i).iColumna       );
			dbms_output.put_line('stConcepto(i).iImpConcepto  	: ' || stConcepto(i).iImpConcepto   );
			dbms_output.put_line('stConcepto(i).iImpAplica  	: ' || stConcepto(i).iImpAplica     );
			dbms_output.put_line('stConcepto(i).iImpRebaja  	: ' || stConcepto(i).iImpRebaja     );
			dbms_output.put_line('stConcepto(i).szCodTipDocum  	: ' || stConcepto(i).szCodTipDocum  );
			dbms_output.put_line('stConcepto(i).iIndConsidera  	: ' || stConcepto(i).iIndConsidera  );
			dbms_output.put_line('stConcepto(i).iIndCargoBasico  	: ' || stConcepto(i).iIndCargoBasico);
			dbms_output.put_line('stConcepto(i).iNCAplicada  	: ' || stConcepto(i).iNCAplicada);
			dbms_output.put_line('---------------------------------------------------------' );
			dbms_output.put_line('---------------------------------------------------------' );
		END LOOP;
*/
/* ----------------------------------------------------------------- */
/* Recupera los valores de las secuencias.                           */
/* ----------------------------------------------------------------- */
	BEGIN
		SELECT FA_SEQ_NCPARCIAL.NEXTVAL
		INTO iSecuencia
		FROM DUAL;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError :='ERROR SELECCIONANDO SECUENCIA';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;
	BEGIN
		SELECT GA_SEQ_TRANSACABO.NEXTVAL
		INTO iSecuencia2
		FROM DUAL;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError :='ERROR SELECCIONANDO SECUENCIA';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;
/* ----------------------------------------------------------------- */
/* Inserta los registros que correspondan en la tabla FA_NCPARCIAL.  */
/* ----------------------------------------------------------------- */
	FOR i IN 0..stConc_Ind LOOP
		IF stConcepto(i).iIndConsidera = 1 THEN
			BEGIN
				INSERT INTO FA_NCPARCIAL (NUM_SECUENCIA, COD_CLIENTE, IND_ORDENTOTAL,
				COD_TIPDOCUM, COD_CONCEPTO, COLUMNA, IMP_CONCEPTO, FLG_EMINC,
				FEC_SOLICITUD, NOM_USUARIO)	VALUES (iSecuencia , stConcepto(i).iCodCliente,
				stConcepto(i).iIndOrdentotal ,stConcepto(i).szCodTipDocum ,stConcepto(i).iCodConcepto ,
				stConcepto(i).iColumna ,stConcepto(i).iImpRebaja ,0 , SYSDATE, pszUser);
			EXCEPTION
				WHEN OTHERS THEN
					iDesError :='ERROR INSERTANDO EN FA_NCPARCIAL.';
					iCodError := iErr1;
					RAISE ERROR_PROCESO;
			END;
		END IF;
	END LOOP;
/* ----------------------------------------------------------------- */
/* Ejecuta procedure almacenado  FA_PRE_NOTACREDPARCIAL              */
/* ----------------------------------------------------------------- */
	FA_PRE_NOTACREDPARCIAL(iSecuencia2,iSecuencia);
	iCodRetorno := 0;
	szDesCadena := '';
	BEGIN
		SELECT COD_RETORNO, DES_CADENA
		INTO iCodRetorno, szDesCadena
		FROM GA_TRANSACABO
		WHERE NUM_TRANSACCION = iSecuencia2;
	EXCEPTION
		WHEN OTHERS THEN
			iDesError := 'ERROR RECUPERANDO DATOS DE NOTA DE CREDITO.';
			iCodError := iErr1;
			RAISE ERROR_PROCESO;
	END;
	IF iCodRetorno != 0  THEN
		iCodError := iErr1;
	ELSE
		iCodError := iErr0;
	END IF;
	iDesError := szDesCadena;
	RAISE ERROR_PROCESO;
EXCEPTION
	WHEN ERROR_PROCESO THEN
		INSERT INTO GA_TRANSACABO VALUES (piNumProceso,iCodError,iDesError);
	WHEN OTHERS THEN
		INSERT INTO GA_TRANSACABO VALUES (piNumProceso,iCodError,iDesError);
END FA_PROC_NCBAJAS;
/
SHOW ERRORS
