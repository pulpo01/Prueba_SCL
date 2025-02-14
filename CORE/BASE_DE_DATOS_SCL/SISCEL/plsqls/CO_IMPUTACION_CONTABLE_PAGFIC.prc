CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Pagfic
(p_nNumProcPasoCob_Arg		IN NUMBER		/* Numero de Paso Cobros */
,p_nCodEvento				IN NUMBER 	    /* Codigo Evento */
,p_vIdLote					IN VARCHAR2
,p_vPerContable				IN VARCHAR2
,p_vCodOperadoraScl			IN VARCHAR2
,p_vCodCiclo_Arg	        IN VARCHAR2	/* SAAM-20030404 Ciclo*/
) IS
TYPE EmpCurTyp IS REF CURSOR;
Cursor_Oficinas  EmpCurTyp;

TERMINO_CON_ERROR           EXCEPTION;

/* Variables */
v_vCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
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
	IF ( p_nNumProcPasoCob_Arg  IS NULL )  THEN
		RAISE_APPLICATION_ERROR(-20101, 'Parametro de Paso Cobro con valor Null');
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
	    v_vIdLote := p_vIdLote;

		v_vSQL := 'SELECT G.COD_OFICINA_PRINCIPAL AS COD_OFICINA, ';
		v_vSQL := v_vSQL ||'  GE_PAC_GENERAL.REDONDEA(SUM ( F.IMP_FACTURABLE * ( G.PRC_TECNOLOGIA / 100 )),'||v_nNumDecimales||',0) AS IMP_CONCEPTO ';
		v_vSQL := v_vSQL ||'  , E.COD_CAUPAGO AS COD_CAUPAGO ';
		v_vSQL := v_vSQL ||'  FROM '||v_vTablaConc||' F, '||v_vTablaTecno||' G , ';
		v_vSQL := v_vSQL ||'  		( SELECT A.IND_ORDENTOTAL AS IND_ORDENTOTAL ,NVL(C.COD_CAUPAGO, H.CAUPAGO_REGALO) AS COD_CAUPAGO ';
		v_vSQL := v_vSQL ||' 		  		 FROM CO_CAUSASPAGO C, GE_MODVENTA B, FA_HISTDOCU A, CO_DATGEN H ';
		v_vSQL := v_vSQL ||' 				 WHERE A.NUM_PROCPASOCOBRO = '||p_nNumProcPasoCob_Arg||'';
		v_vSQL := v_vSQL ||' 				 AND A.COD_MODVENTA = B.COD_MODVENTA ';
		v_vSQL := v_vSQL ||' 				 AND B.IND_PAGADO = 1 ';
		v_vSQL := v_vSQL ||' 				 AND B.COD_CAUPAGO = C.COD_CAUPAGO(+) ';
		v_vSQL := v_vSQL ||'   				 AND A.IND_FACTUR != 0 ';
		v_vSQL := v_vSQL ||'   				 AND A.COD_OPERADORA = '''||p_vCodOperadoraScl||'''';
		v_vSQL := v_vSQL ||'   				 AND TO_CHAR(A.FEC_EMISION, '||'''YYYYMM'''||') ='''||p_vPerContable||'''';
		v_vSQL := v_vSQL ||'   				 AND A.NUM_FOLIO IN ( SELECT UNIQUE D.NUM_FOLIO ';
		v_vSQL := v_vSQL ||'						  		 		FROM CO_CANCELADOS D';
		v_vSQL := v_vSQL ||'						 		 		WHERE A.COD_CLIENTE = D.COD_CLIENTE';
		v_vSQL := v_vSQL ||'						   		 		AND D.COD_OPERADORA_SCL = A.COD_OPERADORA';
		v_vSQL := v_vSQL ||'						   		 		AND D.NUM_FOLIO  IN ( SELECT B.NUM_FOLIO ';
		v_vSQL := v_vSQL ||'												  FROM CO_PAGOSCONC B ,CO_PAGOS A ';
		v_vSQL := v_vSQL ||'												 WHERE A.COD_CLIENTE = D.COD_CLIENTE';
		v_vSQL := v_vSQL ||'												   AND A.NUM_SECUENCI = B.NUM_SECUENCI';
		v_vSQL := v_vSQL ||'												   AND A.COD_TIPDOCUM = B.COD_TIPDOCUM';
		v_vSQL := v_vSQL ||'												   AND A.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE';
		v_vSQL := v_vSQL ||'												   AND B.NUM_FOLIO = D.NUM_FOLIO';
		v_vSQL := v_vSQL ||'												   AND B.COD_OPERADORA_SCL = D.COD_OPERADORA_SCL ) )';
		v_vSQL := v_vSQL ||'	     )  E ';
		v_vSQL := v_vSQL ||'  WHERE G.IND_ORDENTOTAL =  E.IND_ORDENTOTAL ';
		v_vSQL := v_vSQL ||'  AND F.IND_ORDENTOTAL = G.IND_ORDENTOTAL ';
		v_vSQL := v_vSQL ||'  AND F.COD_CONCEPTO = G.COD_CONCEPTO ';
		v_vSQL := v_vSQL ||'  AND F.COLUMNA = G.COLUMNA ';
		v_vSQL := v_vSQL ||'  GROUP BY E.COD_CAUPAGO, G.COD_OFICINA_PRINCIPAL ';

	IF v_vTipoApertura = 'OFICINA' THEN
	OPEN Cursor_Oficinas FOR v_vSQL ;
	 LOOP
	   FETCH Cursor_Oficinas  INTO v_vCodOficina, v_vImporte,v_vCausaPago ;
	    EXIT WHEN Cursor_Oficinas%NOTFOUND;

		v_vIdLote := p_vIdLote  || '/' || v_vCodOficina;

		/* IMPUTACION PAGOS FICTICIOS GENERADOS EN PASOCOBROS*/
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
			p_nCodEvento,
			v_vIdLote,
			p_vPerContable,
			USER,
			SYSDATE,
			p_vCodOperadoraScl
		);

		INSERT INTO SC_COBROS_LOTE_TD
		(
			COD_EVENTO,
			NUM_PROCPASOCOBRO,
			ID_LOTE
		)
		VALUES
		(
			p_nCodEvento,
			p_nNumProcPasoCob_Arg,
			v_vIdLote
		);
		/* DETALLE NoCiclos*/

		INSERT INTO SC_ENT_LOTE
		(
			COD_EVENTO,
			ID_LOTE   ,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			COD_OPERADORA_SCL
		)
		VALUES
		(
			p_nCodEvento,
			v_vIdLote,
			Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_CAUSASPAGO', v_vCausaPago, 'GE_OFICINAS',v_vCodOficina ),
			v_vImporte,
			p_vCodOperadoraScl
		);

		/* LLamada de PL de Interface Contable */
		Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLote, p_vCodOperadoraScl );
     END LOOP; --CURSOR Cursor_Oficinas
	 CLOSE Cursor_Oficinas;

		v_vCodError := 0;

		SELECT COUNT(1)
		  INTO v_vCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento
		   AND ID_LOTE LIKE p_vIdLote ||  '/%'
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

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
			p_nCodEvento,
			p_vIdLote,
			p_vPerContable,
			USER,
			TRUNC(SYSDATE),
			p_vCodOperadoraScl
		);

		INSERT INTO SC_COBROS_LOTE_TD
		(
			COD_EVENTO,
			NUM_PROCPASOCOBRO,
			ID_LOTE
		)
		VALUES
		(
			p_nCodEvento,
			p_nNumProcPasoCob_Arg,
			p_vIdLote
		);

		INSERT INTO SC_ENT_LOTE
		(
			COD_EVENTO,
			ID_LOTE   ,
			COD_CONCEPTO,
			IMP_MOVIMIENTO,
			COD_OPERADORA_SCL
		)
		SELECT p_nCodEvento														  						AS COD_EVENTO,
			   p_vIdLote														 						AS ID_LOTE,
			   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_CAUSASPAGO', NVL(C.COD_CAUPAGO,H.CAUPAGO_REGALO))   AS COD_CONCEPTO,
			   SUM( GE_PAC_GENERAL.REDONDEA( A.TOT_FACTURA, v_nNumDecimales, 0 ) ) 						AS IMP_CONCEPTO,
			   p_vCodOperadoraScl                               				 						AS COD_OPERADORA_SCL
		  FROM CO_CAUSASPAGO C, GE_MODVENTA B, FA_HISTDOCU A , CO_DATGEN H
		 WHERE A.NUM_PROCPASOCOBRO = p_nNumProcPasoCob_Arg
		   AND A.COD_MODVENTA = B.COD_MODVENTA
		   AND B.IND_PAGADO = 1
		   AND B.COD_CAUPAGO = C.COD_CAUPAGO(+)
		   AND A.COD_OPERADORA = p_vCodOperadoraScl
		   AND A.IND_FACTUR != 0
		   AND TO_CHAR(A.FEC_EMISION, 'YYYYMM') = p_vPerContable
		   AND A.NUM_FOLIO IN ( SELECT UNIQUE D.NUM_FOLIO
								  FROM CO_CANCELADOS D
								 WHERE A.COD_CLIENTE = D.COD_CLIENTE
								   AND D.COD_OPERADORA_SCL = A.COD_OPERADORA
								   AND D.NUM_FOLIO  IN ( SELECT B.NUM_FOLIO
								   						   FROM CO_PAGOSCONC B ,CO_PAGOS A
														  WHERE A.COD_CLIENTE = D.COD_CLIENTE
														    AND A.NUM_SECUENCI = B.NUM_SECUENCI
														    AND A.COD_TIPDOCUM = B.COD_TIPDOCUM
														    AND A.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE
														    AND B.NUM_FOLIO = D.NUM_FOLIO
														    AND B.COD_OPERADORA_SCL = D.COD_OPERADORA_SCL ) )
		GROUP BY C.COD_CAUPAGO, H.CAUPAGO_REGALO;

		/* LLamada de PL de Interface Contable */
		Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLote, p_vCodOperadoraScl );
		v_vCodError := 0;

		SELECT COUNT(1)
		  INTO v_vCodError
		  FROM SC_ERROR_INGRESO
		 WHERE COD_EVENTO = p_nCodEvento
		   AND ID_LOTE = p_vIdLote
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	END IF;

	IF v_vCodError = 0 THEN

		/* ACTUALIZO PASOCOBROS EN SU FECHA DE IMPUTACION CONTABLE */
		   UPDATE FA_REPDETALLE_TO
		   SET FEC_IMPCONTPAGOS = SYSDATE
		 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCob_Arg
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	END IF;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE( 'Proceso Termino Ok' );

END Co_Imputacion_Contable_Pagfic;
/
SHOW ERRORS
