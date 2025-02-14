CREATE OR REPLACE FUNCTION CO_FN_CAJON_COBRANZA
(
v_pCodCliente IN NUMBER,
v_pIndGrupo IN VARCHAR2,
v_pTipoCajon IN VARCHAR2 DEFAULT NULL
)
return VARCHAR2 IS
--
-- *****************************************************************************************
-- * Funcion            : CO_FN_CAJON_COBRANZA
-- * Salida             : VARCHAR2
-- * Descripcion        : Devolver los cajones de cobranza de los documentos de un cliente,
-- *					: distribuidos de acuerdo a los parametros recibidos.
-- * Parametros			: v_pCodCliente	Cliente consultado.
-- *					  v_pIndGrupo	Distribucion de los documentos en los respectivos
-- *					                cajones de cobranza
-- *					  v_pTipoCajon	Enumeracion de cajones o saldo en los cajones
-- * Fecha de creacion  : 10-04-2003
-- * Responsable        : Manuel Garcia.
-- *****************************************************************************************

v_vIndGrupo	 VARCHAR2(1);
v_vTipoCajon VARCHAR2(1);
v_nRows		 NUMBER := 0;
v_nRetorno	 VARCHAR2(1000);
--
v_nDeudaT NUMBER := 0;
v_nCajon1 NUMBER := 0;
v_nCajon2 NUMBER := 0;
v_nCajon3 NUMBER := 0;
v_nCajon4 NUMBER := 0;
v_nCajon5 NUMBER := 0;

/* Cambio por Variables bind */
szValorCero      VARCHAR2(1) := '0';
szValorUno       VARCHAR2(1) := '1';
szValorDos       VARCHAR2(1) := '2';
szValorTres      VARCHAR2(1) := '3';
szValorCuatro    VARCHAR2(1) := '4';
szValorCinco     VARCHAR2(1) := '5';
szCo_cartera     VARCHAR2(10):= 'CO_CARTERA';
szCod_tipdocum   VARCHAR2(12):= 'COD_TIPDOCUM';
szCod_modulo     VARCHAR2(2) := 'CO';
szCajon_cobranza VARCHAR2(14):= 'CAJON_COBRANZA';
iNumberCero 	  NUMBER := 0;
iNumberUno		  NUMBER := 1;
iNumberDos		  NUMBER := 2;
iNumberTres      NUMBER := 3;
iNumberCuatro    NUMBER := 4;
iNumberCinco     NUMBER := 5;
szLetraD         VARCHAR2(1) := 'D';
szLetraT         VARCHAR2(1) := 'T';
szLetraS         VARCHAR2(1) := 'S';
szLetrasSC       VARCHAR2(2) := 'SC';
szLetraA         VARCHAR2(1) := 'A';
--
CURSOR cDetalle IS
SELECT DECODE( COD_CAJON, szValorCero, szValorCero, szValorUno, szValorUno, szValorDos, szValorDos, szValorTres, szValorTres, szValorCuatro, szValorCuatro, szValorCinco ) COD_CAJON, MONTO
FROM (
      SELECT NUM_FOLIO,
			 COD_TIPDOCUM,
			 TO_CHAR( TRUNC( MONTHS_BETWEEN( SYSDATE - 1, FEC_VENCIMIE ) + 1 ) ) COD_CAJON,
			 FEC_VENCIMIE,
			 ( IMPORTE_DEBE - IMPORTE_HABER ) MONTO
      FROM  CO_CARTERA
      WHERE COD_CLIENTE  = v_pCodCliente
      AND   IND_FACTURADO= iNumberUno
      AND   FEC_VENCIMIE < TRUNC( SYSDATE )
      AND   COD_CONCEPTO != iNumberDos
      AND   COD_TIPDOCUM NOT IN ( SELECT TO_NUMBER( COD_VALOR )
                                  FROM CO_CODIGOS
                                  WHERE NOM_TABLA  = szCo_cartera
                                  AND   NOM_COLUMNA= szCod_tipdocum )
      UNION
      SELECT NUM_FOLIO,
			 COD_TIPDOCUM,
			 szValorCero COD_CAJON,
			 FEC_VENCIMIE,
			 ( IMPORTE_DEBE - IMPORTE_HABER ) MONTO
      FROM  CO_CARTERA
      WHERE COD_CLIENTE   = v_pCodCliente
      AND   IND_FACTURADO = iNumberUno
      AND   FEC_VENCIMIE >= TRUNC( SYSDATE )
      AND   COD_CONCEPTO != iNumberDos
      AND   COD_TIPDOCUM NOT IN ( SELECT TO_NUMBER( COD_VALOR )
									FROM CO_CODIGOS
								   WHERE NOM_TABLA  = szCo_cartera
								     AND NOM_COLUMNA= szCod_tipdocum )
      ORDER BY FEC_VENCIMIE DESC
	   );

--
cDetalleDocto	cDetalle%ROWTYPE;
--
ERROR_PROCESO EXCEPTION;
--
BEGIN
	--
	v_nRetorno := '';
	v_vIndGrupo := '';
	v_vTipoCajon := '';
	--
   IF v_pIndGrupo IS NULL THEN
      BEGIN
         SELECT VAL_PARAMETRO
           INTO v_vIndGrupo
           FROM GED_PARAMETROS
          WHERE NOM_PARAMETRO= szCajon_cobranza
            AND COD_MODULO   = szCod_modulo;
         EXCEPTION
             WHEN NO_DATA_FOUND THEN
					 v_vIndGrupo := szLetraT;
      END;
   ELSE
      BEGIN
		   v_vIndGrupo := v_pIndGrupo;
      END;
   END IF;
	--
   IF v_pTipoCajon IS NULL THEN
      BEGIN
		  v_vTipoCajon := szLetraD;
      END;
   ELSE
      BEGIN
		  v_vTipoCajon := v_pTipoCajon;
      END;
   END IF;
	--
   IF v_vIndGrupo = szLetraT THEN
      BEGIN
      FOR cDetalleDocto IN cDetalle LOOP
         IF v_vTipoCajon = szLetraD THEN
			v_nRetorno := v_nRetorno || cDetalleDocto.COD_CAJON;
		 ELSE
			IF cDetalleDocto.COD_CAJON = szValorUno THEN
				v_nCajon1 := v_nCajon1 + cDetalleDocto.MONTO;
			ELSIF cDetalleDocto.COD_CAJON = szValorDos THEN
				v_nCajon2 := v_nCajon2 + cDetalleDocto.MONTO;
			ELSIF cDetalleDocto.COD_CAJON = szValorTres THEN
				v_nCajon3 := v_nCajon3 + cDetalleDocto.MONTO;
			ELSIF cDetalleDocto.COD_CAJON = szValorCuatro THEN
				v_nCajon4 := v_nCajon4 + cDetalleDocto.MONTO;
			ELSIF cDetalleDocto.COD_CAJON = szValorCinco THEN
				v_nCajon5 := v_nCajon5 + cDetalleDocto.MONTO;
			END IF;
         END IF;
      END LOOP;
		--
      IF v_vTipoCajon = szLetraD AND v_nRetorno IS NULL THEN
         BEGIN
			   v_nRetorno := szLetrasSC;
         END;
      END IF;
		--
      IF v_vTipoCajon = szLetraS THEN
         BEGIN
			   v_nRetorno := TO_CHAR( v_nCajon1 ) || ';' || TO_CHAR( v_nCajon2 ) || ';' || TO_CHAR( v_nCajon3 ) || ';' ||
						        TO_CHAR( v_nCajon4 ) || ';' || TO_CHAR( v_nCajon5 );
         END;
      END IF;
      END;
   ELSIF v_vIndGrupo = szLetraA THEN
      BEGIN
         SELECT COUNT(1),
				DECODE( TRUNC( MONTHS_BETWEEN( SYSDATE - 1, MIN( FEC_VENCIMIE ) ) + 1 ), szValorCero, szValorCero, szValorUno, szValorUno, szValorDos, szValorDos, szValorTres, szValorTres, szValorCuatro, szValorCuatro, szValorCinco) ,
				NVL( SUM( IMPORTE_DEBE - IMPORTE_HABER ), 0 )
           INTO v_nRows, v_nRetorno, v_nDeudaT
           FROM CO_CARTERA
          WHERE COD_CLIENTE = v_pCodCliente
            AND IND_FACTURADO = iNumberUno
            AND COD_CONCEPTO != iNumberDos
            AND COD_TIPDOCUM NOT IN ( SELECT TO_NUMBER( COD_VALOR )
		  							       FROM CO_CODIGOS
									       WHERE NOM_TABLA = szCo_cartera
									       AND NOM_COLUMNA = szCod_tipdocum );

	      IF v_nRows = iNumberCero THEN
	         BEGIN
	            IF v_vTipoCajon = szLetraD THEN
	               BEGIN
					     v_nRetorno := szLetrasSC;
	               END;
	            ELSE
					   BEGIN
					      v_nRetorno := TO_CHAR( v_nCajon1 ) || ';' || TO_CHAR( v_nCajon2 ) || ';' || TO_CHAR( v_nCajon3 ) || ';' ||
								           TO_CHAR( v_nCajon4 ) || ';' || TO_CHAR( v_nCajon5 );
	               END;
	            END IF;
	         END;
	      ELSE
	         BEGIN
		         IF v_vTipoCajon = szLetraS THEN

		            IF v_nRetorno = iNumberUno THEN
							v_nCajon1 := v_nDeudaT;
		            ELSIF v_nRetorno = iNumberDos THEN
							v_nCajon2 := v_nDeudaT;
		            ELSIF v_nRetorno = iNumberTres THEN
							v_nCajon3 := v_nDeudaT;
		            ELSIF v_nRetorno = iNumberCuatro THEN
							v_nCajon4 := v_nDeudaT;
		            ELSIF v_nRetorno = iNumberCinco THEN
							v_nCajon5 := v_nDeudaT;
		            END IF;
						--
						v_nRetorno := TO_CHAR( v_nCajon1 ) || ';' || TO_CHAR( v_nCajon2 ) || ';' || TO_CHAR( v_nCajon3 ) || ';' ||
									  TO_CHAR( v_nCajon4 ) || ';' || TO_CHAR( v_nCajon5 );
		         END IF;
	         END;
	      END IF;
      END;
   END IF;

   RETURN v_nRetorno;

END;
/
SHOW ERRORS
