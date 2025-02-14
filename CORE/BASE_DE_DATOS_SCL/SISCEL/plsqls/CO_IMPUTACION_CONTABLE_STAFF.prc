CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Staff
(p_nNumProcPasoCob_Arg	IN NUMBER	/* Numero de Paso Cobros */
,p_nCodEvento_Arg		IN NUMBER	/* SAAM-20030404 Numero de Evento */
,p_vIdLote_Arg			IN VARCHAR2	/* SAAM-20030404 Id de Lote */
,p_vFecEmision_Arg		IN VARCHAR2	/* SAAM-20030404 Fecha Emision */
,p_vCodOperadora_Arg	IN VARCHAR2	/* SAAM-20030404 Codigo Operadora*/
,p_vCodCiclo_Arg	    IN VARCHAR2	/* SAAM-20030404 Ciclo*/
) IS
TYPE EmpCurTyp IS REF CURSOR;
Cursor_Oficinas  EmpCurTyp;

TERMINO_CON_ERROR       EXCEPTION;

/* Variables */
v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_nNumDecimales		NUMBER(2) := 0;
v_vTipoApertura		VARCHAR2(40);
v_vIdLote			SC_ENT_LOTE.ID_LOTE%TYPE;             -- VARCHAR2(30)
v_vTablaTecno 	    VARCHAR2(50);
v_vTablaConc		VARCHAR2(50);
v_vSQL				VARCHAR2(5000);
v_vCodOficina		VARCHAR2(2);
v_vImporte			NUMBER(14,4);
v_vCausaPago		NUMBER(2);
v_vCodCiclo			NUMBER(8);

/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
	/* VALIDA_ARGUMENTOS */
	IF( p_nNumProcPasoCob_Arg  IS NULL )  THEN
		RAISE_APPLICATION_ERROR( -20101, 'Parametro de Paso Cobro con valor Null' );
	END IF;

	SELECT GE_PAC_GENERAL.PARAM_GENERAL( 'NUM_DECIMAL' )
	  INTO v_nNumDecimales
	  FROM DUAL;

	-- Indicador de Apertura
	SELECT VAL_PARAMETRO
		INTO v_vTipoApertura
	  	FROM GED_PARAMETROS
	    WHERE COD_MODULO = 'SC'
	    AND NOM_PARAMETRO = 'IND_APERTURA';

		IF( p_vCodCiclo_Arg = 0 ) THEN
			v_vCodCiclo := 19010102;
		END IF;

		SELECT FA_TECNOLOGIAS_TH, FA_HISTCONC
		  INTO v_vTablaTecno, v_vTablaConc
		  FROM FA_ENLACEHIST
		  WHERE COD_CICLFACT = v_vCodCiclo;


	    v_vTipoApertura := TRIM (v_vTipoApertura);
	    v_vIdLote := p_vIdLote_Arg;

		v_vSQL := 'SELECT G.COD_OFICINA_PRINCIPAL AS COD_OFICINA, ';
		v_vSQL := v_vSQL ||'  GE_PAC_GENERAL.REDONDEA(SUM ( F.IMP_FACTURABLE * ( G.PRC_TECNOLOGIA / 100 )),'||v_nNumDecimales||',0) AS IMP_CONCEPTO ';
		v_vSQL := v_vSQL ||'  , E.COD_CAUPAGO AS COD_CAUPAGO ';
		v_vSQL := v_vSQL ||'  FROM '||v_vTablaConc||' F, '||v_vTablaTecno||' G ';
		v_vSQL := v_vSQL ||'  		( SELECT A.IND_ORDENTOTAL AS IND_ORDENTOTAL ,NVL(C.COD_CAUPAGO, H.CAUPAGO_STAFF) AS COD_CAUPAGO ';
		v_vSQL := v_vSQL ||' 		  		 FROM CO_CAUSASPAGO C, GE_MODVENTA B, FA_HISTDOCU A, CO_DATGEN H ';
		v_vSQL := v_vSQL ||' 				 WHERE A.NUM_PROCPASOCOBRO = '||p_nNumProcPasoCob_Arg||'';
		v_vSQL := v_vSQL ||' 				 AND A.COD_MODVENTA = B.COD_MODVENTA ';
		v_vSQL := v_vSQL ||' 				 AND B.COD_CAUPAGO = C.COD_CAUPAGO(+) ';
		v_vSQL := v_vSQL ||'   				 AND A.IND_FACTUR = 0';
		v_vSQL := v_vSQL ||'   				 AND A.COD_OPERADORA = '''||p_vCodOperadora_Arg||'''';
		v_vSQL := v_vSQL ||'   				 AND TO_CHAR(A.FEC_EMISION, '||'''YYYYMM'''||') ='''||p_vFecEmision_Arg||'''';
		v_vSQL := v_vSQL ||'   				 AND A.NUM_FOLIO IN (	SELECT UNIQUE D.NUM_FOLIO';
		v_vSQL := v_vSQL ||'						  		 		FROM CO_CANCELADOS D';
		v_vSQL := v_vSQL ||'						 		 		WHERE A.COD_CLIENTE=D.COD_CLIENTE';
		v_vSQL := v_vSQL ||'						   		 		AND D.COD_OPERADORA_SCL = A.COD_OPERADORA';
		v_vSQL := v_vSQL ||'						   		 		AND D.NUM_FOLIO IN (	SELECT B.NUM_FOLIO';
		v_vSQL := v_vSQL ||'												  FROM CO_PAGOSCONC B ,CO_PAGOS C';
		v_vSQL := v_vSQL ||'												 WHERE C.COD_CLIENTE = D.COD_CLIENTE';
		v_vSQL := v_vSQL ||'												   AND C.NUM_SECUENCI = B.NUM_SECUENCI';
		v_vSQL := v_vSQL ||'												   AND C.COD_TIPDOCUM = B.COD_TIPDOCUM';
		v_vSQL := v_vSQL ||'												   AND C.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE';
		v_vSQL := v_vSQL ||'												   AND B.NUM_FOLIO = D.NUM_FOLIO';
		v_vSQL := v_vSQL ||'												   AND B.COD_OPERADORA_SCL = D.COD_OPERADORA_SCL';
		v_vSQL := v_vSQL ||'												   AND C.COD_TIPDOCUM = 34 ) )';
		v_vSQL := v_vSQL ||'	     ) E ';
		v_vSQL := v_vSQL ||'  WHERE G.IND_ORDENTOTAL = E.IND_ORDENTOTAL ';
		v_vSQL := v_vSQL ||'  AND F.IND_ORDENTOTAL = G.IND_ORDENTOTAL ';
		v_vSQL := v_vSQL ||'  AND F.COD_CONCEPTO = G.COD_CONCEPTO ';
		v_vSQL := v_vSQL ||'  AND F.COLUMNA = G.COLUMNA ';
		v_vSQL := v_vSQL ||'  GROUP BY E.COD_CAUPAGO,G.COD_OFICINA_PRINCIPAL ';

	IF v_vTipoApertura = 'OFICINA' THEN
	OPEN Cursor_Oficinas FOR v_vSQL ;
	 LOOP
	   FETCH Cursor_Oficinas  INTO v_vCodOficina, v_vImporte, v_vCausaPago ;
	    EXIT WHEN Cursor_Oficinas%NOTFOUND;

		v_vIdLote := p_vIdLote_Arg  || '/' || v_vCodOficina;

		/* ENCABEZADO SC_ENT_CAB_LOTE*/
		INSERT INTO SC_ENT_CAB_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			PER_CONTABLE,
			NOM_USUARIO_LOTE,
			FEC_LOTE,
			COD_OPERADORA_SCL
		)
		VALUES
		(
			p_nCodEvento_Arg,
			v_vIdLote,
			TO_NUMBER( p_vFecEmision_Arg ),
			USER,
			SYSDATE,
			p_vCodOperadora_Arg
		); /* SAAM-20030404 */

		INSERT INTO SC_COBROS_LOTE_TD
		(
			COD_EVENTO,
			NUM_PROCPASOCOBRO,
			ID_LOTE
		)
		VALUES
		(
			p_nCodEvento_Arg,
			p_nNumProcPasoCob_Arg,
			v_vIdLote
		);

		/* DETALLE NoCiclos*/
		INSERT INTO SC_ENT_LOTE /* SAAM-20030404  */
		(
			COD_EVENTO,
			ID_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			COD_OPERADORA_SCL
		)
		VALUES
		(
			p_nCodEvento_Arg,
			v_vIdLote,
			 Sc_Conceptogrp_Fn( p_nCodEvento_Arg, 'CO_CAUSASPAGO', v_vCausaPago, 'GE_OFICINAS',v_vCodOficina ),
			v_vImporte,
			p_vCodOperadora_Arg
		);

		/* LLamada de PL de Interface Contable */
		/* SAAM-20030404 */
		Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento_Arg ), v_vIdLote, p_vCodOperadora_Arg );
     END LOOP; --CURSOR Cursor_Oficinas
	 CLOSE Cursor_Oficinas;

		v_nCodError := 0;

		SELECT COUNT(*)
		  INTO v_nCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento_Arg
		   AND ID_LOTE LIKE p_vIdLote_Arg ||  '/%'
		   AND COD_OPERADORA_SCL = p_vCodOperadora_Arg;

	ELSE
		/* ENCABEZADO SC_ENT_CAB_LOTE*/
		INSERT INTO SC_ENT_CAB_LOTE
		(
			COD_EVENTO,
			ID_LOTE,
			PER_CONTABLE,
			NOM_USUARIO_LOTE,
			FEC_LOTE,
			COD_OPERADORA_SCL
		)
		VALUES
		(
			p_nCodEvento_Arg,
			v_vIdLote,
			TO_NUMBER( p_vFecEmision_Arg ),
			USER,
			SYSDATE,
			p_vCodOperadora_Arg
		); /* SAAM-20030404 */

		INSERT INTO SC_COBROS_LOTE_TD
		(
			COD_EVENTO,
			NUM_PROCPASOCOBRO,
			ID_LOTE
		)
		VALUES
		(
			p_nCodEvento_Arg,
			p_nNumProcPasoCob_Arg,
			v_vIdLote
		);

		INSERT INTO SC_ENT_LOTE /* SAAM-20030404  */
		(
			COD_EVENTO,
			ID_LOTE,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			COD_OPERADORA_SCL
		)
		SELECT p_nCodEvento_Arg													   	   						 AS COD_EVENTO,
			   v_vIdLote													 	   							 AS ID_LOTE,
			   Sc_Conceptogrp_Fn( p_nCodEvento_Arg, 'CO_CAUSASPAGO', NVL(C.COD_CAUPAGO,H.CAUPAGO_STAFF) )	 AS COD_CONCEPTO,
			   SUM( GE_PAC_GENERAL.REDONDEA( A.TOT_FACTURA , v_nNumDecimales, 0 ) )  				  	 	 AS IMP_CONCEPTO,
			   p_vCodOperadora_Arg												   							 AS COD_OPERADORA
		  FROM FA_HISTDOCU A, CO_CAUSASPAGO C, GE_MODVENTA B, CO_DATGEN H
		 WHERE A.NUM_PROCPASOCOBRO = p_nNumProcPasoCob_Arg
		   AND A.COD_MODVENTA = B.COD_MODVENTA
		   AND B.COD_CAUPAGO = C.COD_CAUPAGO(+)
		   AND A.IND_FACTUR = 0
		   AND A.COD_OPERADORA = p_vCodOperadora_Arg
		   AND TO_CHAR(A.FEC_EMISION, 'YYYYMM') = p_vFecEmision_Arg
		   AND A.NUM_FOLIO IN (	SELECT UNIQUE D.NUM_FOLIO
								  FROM CO_CANCELADOS D
								 WHERE A.COD_CLIENTE=D.COD_CLIENTE
								   AND D.COD_OPERADORA_SCL = A.COD_OPERADORA
								   AND D.NUM_FOLIO IN (	SELECT B.NUM_FOLIO
														  FROM CO_PAGOSCONC B ,CO_PAGOS C
														 WHERE C.COD_CLIENTE = D.COD_CLIENTE
														   AND C.NUM_SECUENCI = B.NUM_SECUENCI
														   AND C.COD_TIPDOCUM = B.COD_TIPDOCUM
														   AND C.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE
														   AND B.NUM_FOLIO = D.NUM_FOLIO
														   AND B.COD_OPERADORA_SCL = D.COD_OPERADORA_SCL
														   AND C.COD_TIPDOCUM = 34 ) )
		GROUP BY  C.COD_CAUPAGO,H.CAUPAGO_REGALO;
		/* LLamada de PL de Interface Contable */
		/* SAAM-20030404 */
		Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento_Arg ), v_vIdLote, p_vCodOperadora_Arg );

		v_nCodError := 0;

		SELECT COUNT(*)
		  INTO v_nCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento_Arg
		   AND ID_LOTE = p_vIdLote_Arg
		   AND COD_OPERADORA_SCL = p_vCodOperadora_Arg;

	END IF;

	IF v_nCodError = 0 THEN
		/* ACTUALIZO PASOCOBROS EN SU FECHA DE IMPUTACION CONTABLE (PAGFO STAFF) */
		UPDATE FA_REPDETALLE_TO
		   SET FEC_IMPCONTSTAFF = SYSDATE
		 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCob_Arg
		   AND COD_OPERADORA_SCL = p_vCodOperadora_Arg;
	END IF;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE( 'Proceso Termino Ok' );

END Co_Imputacion_Contable_Staff;
/
SHOW ERRORS
