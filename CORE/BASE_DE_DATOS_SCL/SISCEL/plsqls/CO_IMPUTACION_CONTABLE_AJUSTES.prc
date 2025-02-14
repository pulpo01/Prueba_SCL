CREATE OR REPLACE PROCEDURE CO_IMPUTACION_CONTABLE_AJUSTES
(p_nCodEvento		IN NUMBER       /* Codigo Evento    */
,p_nCodTipDocum		IN NUMBER       /* Tipo Documento   */
,p_vIdLote			IN VARCHAR2     /* Id.Lote          */
,p_vPeriodo			IN VARCHAR2     /* Periodo Contable */
,p_vCodOperadoraScl	IN VARCHAR2     /* Codigo Operadora */
)IS

/* Variables */
v_nCodError			SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_vDesError			SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_nLenConcepto			SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_vIdLoteCom			SC_ENT_CAB_LOTE.ID_LOTE%TYPE;
v_vTipoApertura			GED_PARAMETROS.VAL_PARAMETRO%TYPE;
v_vCodOficina			GE_CLIENTES.COD_OFICINA%TYPE;

/*Cursor de Oficinas */
CURSOR CURSOR_OFICINASAJUSTES IS
	SELECT DISTINCT B.COD_OFICINA
	  FROM CO_AJUSTES A, GE_CLIENTES B
	 WHERE A.COD_TIPDOCUM  = p_nCodTipDocum
	   AND TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYYMMDD' ) = p_vIdLote
	   AND A.FEC_IMPCONTAJUMAS IS NULL                       /* que no se ha contabilizado como ajuste */
	   AND A.IND_PROCESADO = 1
	   AND A.COD_OPERADORA_SCL = p_vCodOperadoraScl
	   AND A.COD_OPERADORA_SCL = B.COD_OPERADORA
	   AND A.COD_CLIENTE = B.COD_CLIENTE
	GROUP BY B.COD_OFICINA;


/* ******************************************************************************************** */
/* (0) * MODULO PRINCIPAL    																	*/
/* ******************************************************************************************** */

BEGIN

	IF( p_vCodOperadoraScl IS NULL ) /*or ( szhPlaza  IS NULL )*/  THEN

		INSERT INTO SC_ERROR_INGRESO
		(
			COD_EVENTO,
			ID_LOTE,
			COD_ERROR,
			FEC_ERROR,
			DES_ERROR,
			COD_OPERADORA_SCL
		)
		VALUES
		(
			p_nCodEvento,
			p_vIdLote,
			99,
			SYSDATE,
			'OPERADORA Y/O PLAZA NULO',
			'NEx'
		);
		COMMIT;
	ELSE

		SELECT B.LEN_CONCEPTO
		  INTO v_nLenConcepto
		  FROM SC_EVENTO A, SC_DOMINIO_CTO B
		 WHERE A.COD_DOMINIO_CTO = B.COD_DOMINIO_CTO
		   AND A.COD_EVENTO = p_nCodEvento;

		-- Obtiene Indicador de Apertura
		SELECT VAL_PARAMETRO
		  INTO v_vTipoApertura
		  FROM GED_PARAMETROS
		 WHERE COD_MODULO = 'SC'
		   AND NOM_PARAMETRO = 'IND_APERTURA';

		v_vTipoApertura := TRIM( v_vTipoApertura );

		IF v_vTipoApertura = 'OFICINA' THEN
	  	   FOR OFICINAS IN CURSOR_OFICINASAJUSTES LOOP
	   	   	v_vCodOficina := OFICINAS.COD_OFICINA;
	   	   	v_vIdLoteCom := p_vIdLote || '/' || v_vCodOficina;

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
				v_vIdLoteCom,
				p_vPeriodo,
				USER,
				SYSDATE,
				p_vCodOperadoraScl
			);
			IF p_nCodEvento = 62 THEN /*Ajuste Sencillo Nota de Credito*/
				INSERT INTO SC_ENT_LOTE
				(
					COD_EVENTO,
					ID_LOTE,
					COD_CONCEPTO,
					IMP_MOVIMIENTO,
					COD_OPERADORA_SCL
				)
				SELECT p_nCodEvento AS COD_EVENTO,
					   p_vIdLote || DECODE( v_vTipoApertura, 'OFICINA', '/' || B.COD_OFICINA) AS ID_LOTE,
					   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPAJUSTENC', COD_TIPAJUSTE, 'GE_OFICINAS', v_vCodOficina ) AS COD_CONCEPTO,
					   SUM(A.IMPORTE_DEBE ) AS IMP_CONCEPTO,
					   A.COD_OPERADORA_SCL AS COD_OPERADORA_SCL
				  FROM CO_AJUSTES A, GE_CLIENTES B
				 WHERE A.COD_TIPDOCUM  = p_nCodTipDocum
				   AND TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYYMMDD' ) = p_vIdLote
				   AND A.FEC_IMPCONTAJUMAS IS NULL                       /* que no se ha contabilizado como ajuste */
				   AND A.IND_PROCESADO = 1
				   AND A.COD_OPERADORA_SCL = p_vCodOperadoraScl
				   AND A.COD_CLIENTE = B.COD_CLIENTE
				   AND B.COD_OFICINA = v_vCodOficina
				   AND A.COD_OPERADORA_SCL = B.COD_OPERADORA
				GROUP BY A.COD_TIPAJUSTE, TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYYMMDD' ), A.COD_OPERADORA_SCL, B.COD_OFICINA;
			ELSE
				INSERT INTO SC_ENT_LOTE
				(
					COD_EVENTO,
					ID_LOTE,
					COD_CONCEPTO,
					IMP_MOVIMIENTO,
					COD_OPERADORA_SCL
				)
				SELECT p_nCodEvento AS COD_EVENTO,
					   p_vIdLote || DECODE( v_vTipoApertura, 'OFICINA', '/' || B.COD_OFICINA) AS ID_LOTE,
					   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPAJUSTEND', COD_TIPAJUSTE, 'GE_OFICINAS', v_vCodOficina ) AS COD_CONCEPTO,
					   SUM( A.IMPORTE_DEBE ) AS IMP_CONCEPTO,
					   A.COD_OPERADORA_SCL AS COD_OPERADORA_SCL
				  FROM CO_AJUSTES A, GE_CLIENTES B
				 WHERE A.COD_TIPDOCUM  = p_nCodTipDocum
				   AND TO_CHAR( A.FEC_EFECTIVIDAD, 'YYYYMMDD' ) = p_vIdLote
				   AND A.FEC_IMPCONTAJUMAS IS NULL                       /* que no se ha contabilizado como ajuste */
				   AND A.IND_PROCESADO = 1
				   AND A.COD_OPERADORA_SCL = p_vCodOperadoraScl
				   AND A.COD_CLIENTE = B.COD_CLIENTE
				   AND B.COD_OFICINA = v_vCodOficina
				   AND A.COD_OPERADORA_SCL = B.COD_OPERADORA
				GROUP BY A.COD_TIPAJUSTE, TO_CHAR( A.FEC_EFECTIVIDAD, 'YYYYMMDD' ), A.COD_OPERADORA_SCL, B.COD_OFICINA;
			END IF;

				Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLoteCom, p_vCodOperadoraScl );
		   END LOOP;
			v_nCodError := 0;

			SELECT COUNT(1)
			  INTO v_nCodError
			  FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = p_nCodEvento
			   AND ID_LOTE LIKE p_vIdLote || '/%'
			   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;

		ELSE
			v_vIdLoteCom := p_vIdLote;
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
				v_vIdLoteCom,
				p_vPeriodo,
				USER,
				SYSDATE,
				p_vCodOperadoraScl
			);

			/* DETALLE AJUSTES */
			IF p_nCodEvento = 62 THEN /*Ajuste Sencillo Nota de Credito*/
			    INSERT INTO SC_ENT_LOTE
				(
					COD_EVENTO,
					ID_LOTE,
					COD_CONCEPTO,
					IMP_MOVIMIENTO,
					COD_OPERADORA_SCL
				)
				SELECT p_nCodEvento AS COD_EVENTO,
					   p_vIdLote AS ID_LOTE,
					   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPAJUSTENC', COD_TIPAJUSTE, 'GE_OFICINAS', v_vCodOficina ) AS COD_CONCEPTO,
					   SUM( IMPORTE_DEBE ) AS IMP_CONCEPTO,
					   COD_OPERADORA_SCL AS COD_OPERADORA_SCL
				  FROM CO_AJUSTES A
				 WHERE FEC_IMPCONTAJUMAS IS NULL                       /* que no se ha contabilizado como ajuste */
				   AND TO_CHAR( FEC_EFECTIVIDAD, 'YYYYMMDD' ) = v_vIdLoteCom
				   AND COD_TIPDOCUM  = p_nCodTipDocum
				   AND IND_PROCESADO = 1
				   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
				GROUP BY COD_TIPAJUSTE, TO_CHAR( FEC_EFECTIVIDAD, 'YYYYMMDD' ), COD_OPERADORA_SCL;
			ELSE
				INSERT INTO SC_ENT_LOTE
				(
					COD_EVENTO,
					ID_LOTE,
					COD_CONCEPTO,
					IMP_MOVIMIENTO,
					COD_OPERADORA_SCL
				)
				SELECT p_nCodEvento AS COD_EVENTO,
					   p_vIdLote AS ID_LOTE,
					   Sc_Conceptogrp_Fn( p_nCodEvento, 'CO_TIPAJUSTEND', COD_TIPAJUSTE, 'GE_OFICINAS', v_vCodOficina ) AS COD_CONCEPTO,
					   SUM( IMPORTE_DEBE ) AS IMP_CONCEPTO,
					   COD_OPERADORA_SCL AS COD_OPERADORA_SCL
				  FROM CO_AJUSTES A
				 WHERE FEC_IMPCONTAJUMAS IS NULL                       /* que no se ha contabilizado como ajuste */
				   AND TO_CHAR( FEC_EFECTIVIDAD, 'YYYYMMDD' ) = v_vIdLoteCom
				   AND COD_TIPDOCUM  = p_nCodTipDocum
				   AND IND_PROCESADO = 1
				   AND COD_OPERADORA_SCL = p_vCodOperadoraScl
				GROUP BY COD_TIPAJUSTE, TO_CHAR( FEC_EFECTIVIDAD, 'YYYYMMDD' ), COD_OPERADORA_SCL;
			END IF;

			Sc_P_Ingresa_Lote( TO_CHAR( p_nCodEvento ), v_vIdLoteCom, p_vCodOperadoraScl );

			v_nCodError := 0;

			SELECT COUNT(1)
			  INTO v_nCodError
			  FROM SC_ERROR_INGRESO
			 WHERE COD_EVENTO = p_nCodEvento
			   AND ID_LOTE = v_vIdLoteCom
			   AND COD_OPERADORA_SCL = p_vCodOperadoraScl;
		END IF;
		IF v_nCodError = 0 THEN
				/* ACTUALIZO PASOCOBROS EN SU FECHA DE IMPUTACION CONTABLE (AJUSTE SENCILLO MASIVO) */
				UPDATE CO_AJUSTES
				SET FEC_IMPCONTAJUMAS = SYSDATE
				WHERE FEC_IMPCONTAJUMAS IS NULL
				AND TO_CHAR( FEC_EFECTIVIDAD, 'YYYYMMDD' ) = p_vIdLote
				AND COD_TIPDOCUM = p_nCodTipDocum
				AND IND_PROCESADO = 1
				AND COD_OPERADORA_SCL = p_vCodOperadoraScl;
		END IF;

	END IF;
	COMMIT;

	DBMS_OUTPUT.PUT_LINE( 'Proceso Termino Ok' );

END CO_IMPUTACION_CONTABLE_AJUSTES;
/
SHOW ERRORS
