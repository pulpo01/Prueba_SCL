CREATE OR REPLACE PROCEDURE SC_AJUSTA_CONCEPTO_PR
(p_nNumProcPasoCobro	IN NUMBER		/* Numero de Paso a Cobros */
,p_vCodOperadoraScl		IN VARCHAR2		/* Codigo de Operadora */
) IS

v_nTotOperadora		FA_REPDETALLE_TO.TOT_OPERADORA%TYPE;
v_nTotConceptos		FA_DETPASOCOBROS.IMP_CONCEPTO%TYPE;
v_vRowid			VARCHAR2(19);
v_nDiferencia		FA_DETPASOCOBROS.IMP_CONCEPTO%TYPE;

BEGIN
	/* recuperamos el importe de la tabla de Detalle de Paso a Cobros */
	SELECT TOT_OPERADORA
	  INTO v_nTotOperadora
	  FROM FA_REPDETALLE_TO
	 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCobro
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	/* recuperamos el importe de los conceptos */
	SELECT SUM( IMP_CONCEPTO )
	  INTO v_nTotConceptos
	  FROM FA_DETPASOCOBROS
	 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCobro
	   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	/* si hay diferencia para los valores obtenidos, realizamos el ajuste al mayor concepto */
	IF v_nTotOperadora <> v_nTotConceptos THEN

		/* sacamos la diferencia */
		v_nDiferencia := v_nTotOperadora - v_nTotConceptos;

		/* buscamos el concepto mayor */
		SELECT ROWIDTOCHAR( ROWID )
		  INTO v_vRowid
		  FROM FA_DETPASOCOBROS
		 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCobro
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
		   AND ROUND( IMP_CONCEPTO ) IN ( 	SELECT MAX( ROUND( IMP_CONCEPTO ) )
											  FROM FA_DETPASOCOBROS
											 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCobro
											   AND COD_OPERADORA_SCL = p_vCodOperadoraScl )
		   AND ROWNUM < 2;

		/* ajustamos el concepto */
		UPDATE FA_DETPASOCOBROS
		   SET IMP_CONCEPTO = IMP_CONCEPTO + v_nDiferencia
		 WHERE ROWID = v_vRowid;

		/* registramos el importe del ajuste */
		UPDATE FA_REPDETALLE_TO
		   SET MTO_AJUSTE = v_nDiferencia
		 WHERE NUM_PROCPASOCOBRO = p_nNumProcPasoCobro
		   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

	END IF;

	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR( -20107, 'ERROR INESPERADO EN PL SC_AJUSTE_CONCEPTO : ORA-' || TO_CHAR(SQLCODE) || '.', TRUE );
END SC_AJUSTA_CONCEPTO_PR;
/
SHOW ERRORS
