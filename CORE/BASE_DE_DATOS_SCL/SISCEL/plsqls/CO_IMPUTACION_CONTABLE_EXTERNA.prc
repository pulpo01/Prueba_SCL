CREATE OR REPLACE PROCEDURE Co_Imputacion_Contable_Externa
(p_vCodOriPago_Arg		IN VARCHAR2   /* Codigo Origen de Pago  */
,p_vCodRecExt_Arg		IN VARCHAR2   /* Numero de proceso      */
,p_vIdLote				IN VARCHAR2   /* Identificador del Lote */
,p_vCodOperadoraScl		IN VARCHAR2   /* Codigo Operadora       */
,p_vPerContable			IN VARCHAR2   /* Periodo Contable       */
,p_vIndBatch            IN NUMBER     /* Indicador Batch		** Soporte RyC TM-200503031294 04-03-2005 capc */
,p_vFec_Historico		IN VARCHAR2   /* Fecha Historico TO_CHAR(FEC_HISTORICO,'DD-MM-YYYY hh24:mi:ss') */
) IS

v_nCodOriPago		CO_RECAUDAEXT.COD_ORIPAGO%TYPE;
v_nCodRecExt		CO_RECAUDAEXT.COD_RECEXT%TYPE;
v_nCodEvento		SC_EVENTO.COD_EVENTO%TYPE;
v_nDesError			SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nDesError2		SC_ERROR_INGRESO.DES_ERROR%TYPE;
dhImpValor			CO_RECAUDAEXT.IMP_VALOR%TYPE;
v_nLenConcepto3		SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_nLenConcepto4		SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_nExiste			SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;

/* Soporte RyC TM-200503031294 04-03-2005 capc */
/*CURSOR CURSOR_OPER  IS
SELECT IMP_VALOR,
 	   IMP_VALOR_ANOM
  FROM CO_RECAUDAEXT
 WHERE COD_RECEXT = v_nCodRecExt
   AND COD_OPERADORA = p_vCodOperadoraScl
   AND FEC_IMPUTCONTABLE IS NULL;*/

CURSOR CURSOR_OPER IS
  SELECT IMP_PAGO
  FROM CO_HINTERFAZ_EXTERNA
 WHERE COD_RECEXT = v_nCodRecExt
   AND IMP_PAGO > 0
   AND IND_BATCH = p_vIndBatch
   and FEC_HISTORICO = TO_date(p_vFec_Historico, 'DD-MM-YYYY hh24:mi:ss');


/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */
BEGIN
    /* VALIDA_ARGUMENTOS */
    IF( p_vCodOriPago_Arg  IS NULL ) OR ( p_vCodRecExt_Arg  IS NULL ) THEN
       RAISE_APPLICATION_ERROR( -20101, 'No se aceptan valores en null' );
    END IF;

    v_nCodRecExt := TO_NUMBER( p_vCodRecExt_Arg );
    v_nCodOriPago := TO_NUMBER( p_vCodOriPago_Arg );

	v_nCodEvento := 3;

    SELECT B.LEN_CONCEPTO
      INTO v_nLenConcepto3
      FROM SC_EVENTO A, SC_DOMINIO_CTO B
     WHERE A.COD_DOMINIO_CTO = B.COD_DOMINIO_CTO
       AND A.COD_EVENTO = v_nCodEvento;

    INSERT INTO SC_ENT_CAB_LOTE
    (
		COD_EVENTO,
		ID_LOTE,
		PER_CONTABLE,
		NOM_USUARIO_LOTE,
		FEC_LOTE,
		COD_OPERADORA_SCL
	)
	SELECT DISTINCT
           v_nCodEvento     	COD_EVENTO,
           p_vIdLote        	ID_LOTE,
           p_vPerContable		PER_CONTABLE,
           USER             	NOM_USUARIO_LOTE,
           SYSDATE          	FEC_LOTE,
           p_vCodOperadoraScl   COD_OPERADORA
      FROM CO_RECAUDAEXT
     WHERE COD_ORIPAGO = v_nCodOriPago
       AND COD_RECEXT = v_nCodRecExt
       AND IMP_VALOR > 0
       AND FEC_IMPUTCONTABLE  IS NULL
	   AND COD_OPERADORA = p_vCodOperadoraScl;

	v_nCodEvento := 4;

    SELECT B.LEN_CONCEPTO
      INTO v_nLenConcepto4
      FROM SC_EVENTO A, SC_DOMINIO_CTO B
     WHERE A.COD_DOMINIO_CTO = B.COD_DOMINIO_CTO
       AND A.COD_EVENTO = v_nCodEvento;

    INSERT INTO SC_ENT_CAB_LOTE
   	(
		COD_EVENTO,
		ID_LOTE,
		PER_CONTABLE,
		NOM_USUARIO_LOTE,
		FEC_LOTE,
		COD_OPERADORA_SCL
	)
	SELECT DISTINCT
		   v_nCodEvento                   COD_EVENTO,
		   p_vIdLote                      ID_LOTE,
		   TO_CHAR( FEC_VALOR, 'YYYYMM' ) PER_CONTABLE,
		   USER                           NOM_USUARIO_LOTE,
		   SYSDATE                        FEC_LOTE,
		   COD_OPERADORA                  COD_OPERADORA
	  FROM CO_RECAUDAEXT
	 WHERE COD_ORIPAGO = v_nCodOriPago
	   AND COD_RECEXT = v_nCodRecExt
	   AND IMP_VALOR_ANOM > 0
	   AND FEC_IMPUTCONTABLE  IS NULL
	   AND COD_OPERADORA = p_vCodOperadoraScl;

	COMMIT;

	FOR X IN CURSOR_OPER LOOP

		IF X.IMP_PAGO > 0 THEN

			v_nCodEvento := 3;

			INSERT INTO SC_ENT_LOTE
			(
				COD_EVENTO,
				ID_LOTE,
				COD_CONCEPTO,
				IMP_MOVIMIENTO,
				COD_OPERADORA_SCL
			)
			VALUES
			(
				v_nCodEvento,
				p_vIdLote,
				Sc_Conceptogrp_Fn( v_nCodEvento, 'CO_ORIGENPAGO', v_nCodOriPago ),
				X.IMP_PAGO,
				p_vCodOperadoraScl
			);

		END IF;

		COMMIT;
		/* Soporte RyC TM-200503031294 04-03-2005 capc */
		/*IF X.IMP_VALOR_ANOM > 0	AND X.BATCH = p_vIndBatch THEN

			v_nCodEvento := 4;

			INSERT INTO SC_ENT_LOTE
			(
				COD_EVENTO,
				ID_LOTE,
				COD_CONCEPTO,
				IMP_MOVIMIENTO,
				COD_OPERADORA_SCL
			)
			VALUES
			(
				v_nCodEvento,
				p_vIdLote,
				Sc_Conceptogrp_Fn( v_nCodEvento, 'CO_ORIGENPAGO', v_nCodOriPago ),
				X.IMP_VALOR_ANOM,
				p_vCodOperadoraScl
			);

			COMMIT;

		END IF;*/

	END LOOP ;

    v_nCodEvento := 3;

    SELECT COUNT(1)
      INTO v_nExiste
      FROM SC_ENT_LOTE
     WHERE COD_EVENTO = v_nCodEvento
       AND ID_LOTE = p_vIdLote
       AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

    v_nDesError := 0;
    /* Evento Pagos correctos de TECAS */
    IF v_nExiste > 0 THEN

           Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), p_vIdLote, p_vCodOperadoraScl );

           SELECT COUNT(1)
             INTO v_nDesError
             FROM SC_ERROR_INGRESO
            WHERE COD_EVENTO = v_nCodEvento
              AND ID_LOTE = p_vIdLote
              AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

    END IF;

    v_nCodEvento := 4;

    SELECT COUNT(1)
      INTO v_nExiste
	  FROM SC_ENT_LOTE
     WHERE COD_EVENTO = v_nCodEvento
       AND ID_LOTE = p_vIdLote
       AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

    v_nDesError2 := 0;

    /* Evento Pagos anomalos de TECAS */
    IF v_nExiste > 0 THEN

           Sc_P_Ingresa_Lote( TO_CHAR( v_nCodEvento ), p_vIdLote, p_vCodOperadoraScl );

           SELECT COUNT(1)
             INTO v_nDesError2
             FROM SC_ERROR_INGRESO
            WHERE COD_EVENTO = v_nCodEvento
              AND ID_LOTE = p_vIdLote
	          AND COD_OPERADORA_SCL = p_vCodOperadoraScl;
    END IF;

    IF v_nDesError = 0 AND  v_nDesError2 = 0 THEN

       /* ACTUALIZO TRANSACCION DE CO_RECAUDAEXT EN SU FECHA DE IMPUTACION CONTABLE */

	   IF p_vIndBatch = 1 THEN

	       UPDATE CO_RECAUDAEXT
	          SET FEC_IMPUTCONTABLE = SYSDATE
	        WHERE ROWID IN (SELECT DISTINCT A.ROWID
				  		    FROM CO_RECAUDAEXT A, CO_HINTERFAZ_EXTERNA B
							WHERE A.COD_RECEXT = v_nCodRecExt
	   						AND A.COD_RECEXT = B.COD_RECEXT
	   		 			    AND A.COD_OPERADORA = p_vCodOperadoraScl
	   						AND B.IND_BATCH = p_vIndBatch
	   						AND A.FEC_IMPUTCONTABLE IS NULL
	   						AND A.IMP_VALOR NOT IN (SELECT IMP_PAGO FROM CO_ANOMALIA_EXTERNA
	   	   			   	   	   					    WHERE COD_RECEXT = v_nCodRecExt)
							);
		ELSIF p_vIndBatch = 0 THEN

	       UPDATE CO_RECAUDAEXT
	          SET FEC_IMPUTCONTABLE = SYSDATE
	        WHERE ROWID IN (SELECT DISTINCT A.ROWID
				  		    FROM CO_RECAUDAEXT A, CO_HINTERFAZ_EXTERNA B
							WHERE A.COD_RECEXT = v_nCodRecExt
	   						AND A.COD_RECEXT = B.COD_RECEXT
	   		 			    AND A.COD_OPERADORA = p_vCodOperadoraScl
	   						AND B.IND_BATCH = p_vIndBatch
	   						AND A.FEC_IMPUTCONTABLE IS NULL
	   						AND A.IMP_VALOR IN (SELECT IMP_PAGO FROM CO_ANOMALIA_EXTERNA
	   	   			   	   	   					    WHERE COD_RECEXT = v_nCodRecExt)
							);
		 END IF;

/*       UPDATE CO_RECAUDAEXT
          SET FEC_IMPUTCONTABLE = SYSDATE
        WHERE COD_ORIPAGO = v_nCodOriPago
          AND COD_RECEXT = v_nCodRecExt
          AND COD_OPERADORA = p_vCodOperadoraScl;
*/

    ELSE

       /* INGRESO DE LOTE GENERO ERROR */
       RAISE_APPLICATION_ERROR( -20102, 'Error al generar Imputacion contable Recaudacisn Externa Teca PL SC_P_INGRESA_LOTE' );

    END IF;

    COMMIT;

END Co_Imputacion_Contable_Externa;
/
SHOW ERRORS
