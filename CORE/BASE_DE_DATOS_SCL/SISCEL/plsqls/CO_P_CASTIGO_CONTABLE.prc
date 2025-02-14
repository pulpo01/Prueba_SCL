CREATE OR REPLACE PROCEDURE Co_P_Castigo_Contable IS
--
      v_FecDesde          DATE;
      v_FecHasta          DATE;
      ihMinimo            GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
      ihMaximo            GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
      ihOk                NUMBER(1);
      ihFolio             CO_PAGOSCONC.NUM_FOLIO%TYPE;
      ihCodCliente        FA_HISTDOCU.COD_CLIENTE%TYPE;
      dhFecha             CO_PAGOSCONC.FEC_CANCELACION%TYPE;
      ihImporte           CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
      I                   CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
--
      v_CastCont          NUMBER(1) := 1;
      v_CastRecu          NUMBER(1) := 2;
      v_CastElim          NUMBER(1) := 3;
      v_Cero              NUMBER(1) := 0;
      v_TreintayNueve     NUMBER(2) := 39;
--
      v_Sequencia         NUMBER;
--
      CURSOR PagosRecientes IS
      SELECT  B.NUM_FOLIO AS FOLIO, A.COD_CLIENTE AS CLIENTE, TRUNC(B.FEC_CANCELACION) AS FECHA, B.IMP_CONCEPTO AS IMPORTE, B.COD_TIPDOCREL AS DOCUMENTO, Ve_Ofpriventa_Fn(A.COD_CLIENTE) AS OFICINA
      FROM FA_HISTDOCU A, CO_PAGOSCONC B
      WHERE B.FEC_CANCELACION BETWEEN v_FecDesde AND v_FecHasta
      AND   B.COD_TIPDOCUM IN (8,33)
      AND   B.NUM_SECUREL = A.NUM_SECUENCI (+)
      AND   B.COD_TIPDOCREL = A.COD_TIPDOCUM (+)
      AND   B.COD_AGENTEREL = A.COD_VENDEDOR_AGENTE (+)
      AND   B.LETRA_REL  = A.LETRA (+)
      AND   B.COD_CENTRREL = A.COD_CENTREMI ;
--
      TYPE TipoArregloCastigos IS TABLE OF CO_CASTIGO_CONTABLE%ROWTYPE INDEX BY  BINARY_INTEGER;
      CastigosRecuperados  TipoArregloCastigos;
--
--
BEGIN
--
--
   SELECT  TRUNC(SYSDATE)-(1/24/60/60)
   INTO v_FecHasta -- Siempre es las 23:59:59 de ayer (termino del dia), por defecto como fecha hasta
   FROM dual;
--
--
-- 1: CASTIGOS CONTABLES  ---------------------------------------------------------------
--
   v_Sequencia := fnSeqCasCon;          -- Obtiene la secuencia del proceso Castigo Contable
--
   SELECT NVL(TRUNC(MAX(fec_proceso)),TRUNC(SYSDATE-1))
   INTO v_FecDesde
   FROM CO_PROC_ACUM_CASCON
   WHERE tip_movimien = v_CastCont ;
--
   INSERT INTO CO_PROC_ACUM_CASCON      -- Inserta registro en la cabecera
   (num_proceso,tip_movimien,fec_proceso,usuario_proceso,FEC_TERMINO)
   SELECT v_Sequencia,v_CastCont,SYSDATE,USER,NULL
   FROM dual;
--
   COMMIT;
--
   INSERT INTO CO_CASTIGO_CONTABLE      -- Inserta el detalle de los castigos contables
   (num_proceso,fec_proceso, fec_transaccion,tip_movimien,importe,cod_tipdocum,cod_apertura)
   SELECT v_Sequencia, TRUNC(SYSDATE), TRUNC(c.fec_efectividad) AS fec_transaccion, v_CastCont AS tip_movimien,
   SUM(a.imp_concepto) AS importe, a.cod_tipdocrel AS cod_tipdocum, Ve_Ofpriventa_Fn(c.cod_cliente) AS cod_apertura
   FROM co_pagosconc a, co_pagos c
   WHERE a.cod_tipdocum = c.cod_tipdocum
   AND a.letra=c.letra
   AND a.cod_vendedor_agente=c.cod_vendedor_agente
   AND a.cod_centremi=c.cod_centremi
   AND a.num_secuenci = c.num_secuenci
   AND c.cod_tipdocum=v_TreintayNueve
   AND TRUNC(c.fec_efectividad) BETWEEN v_FecDesde AND v_FecHasta
   GROUP BY a.cod_tipdocrel,TRUNC(c.fec_efectividad), Ve_Ofpriventa_Fn(c.cod_cliente);
--
   UPDATE CO_PROC_ACUM_CASCON
   SET FEC_TERMINO = SYSDATE
   WHERE NUM_PROCESO = v_Sequencia
   AND TIP_MOVIMIEN = v_CastCont ;
--
   COMMIT;
--
-- 3 : CASTIGOS ELIMINADOS  -------------------------------------------------------------
--
--
   v_Sequencia := fnSeqCasCon;          -- Obtiene la secuencia del proceso Castigo Contable
--
   SELECT NVL(TRUNC(MAX(fec_proceso)),TRUNC(SYSDATE-1))
   INTO v_FecDesde
   FROM CO_PROC_ACUM_CASCON
   WHERE tip_movimien = v_CastRecu ;
--
   INSERT INTO CO_PROC_ACUM_CASCON      -- Inserta registro en la cabecera
   (num_proceso,tip_movimien,fec_proceso,usuario_proceso,FEC_TERMINO)
   SELECT v_Sequencia,v_CastElim,SYSDATE,USER,NULL
   FROM dual;
--
   COMMIT;
--
   INSERT INTO CO_CASTIGO_CONTABLE
   (num_proceso,fec_proceso, fec_transaccion,tip_movimien,importe,cod_tipdocum,COD_APERTURA)
   SELECT fnSeqCasCon,TRUNC(SYSDATE), TRUNC(c.fec_efectividad) AS fec_transaccion, v_CastElim AS tip_movimien, SUM(a.imp_concepto) AS importe, a.cod_tipdocrel AS cod_tipdocum, Ve_Ofpriventa_Fn(c.cod_cliente) AS COD_APERTURA
   FROM co_histpgoconelim_x_cascon a, co_histpgoelim_x_cascon c
   WHERE a.cod_tipdocum = c.cod_tipdocum
   AND a.letra=c.letra
   AND a.cod_vendedor_agente=c.cod_vendedor_agente
   AND a.cod_centremi=c.cod_centremi
   AND a.num_secuenci = c.num_secuenci
   AND TRUNC(c.fec_efectividad) BETWEEN v_FecDesde AND v_FecHasta
   GROUP BY a.cod_tipdocrel,TRUNC(c.fec_efectividad),Ve_Ofpriventa_Fn(c.cod_cliente);
--
   UPDATE CO_PROC_ACUM_CASCON
   SET FEC_TERMINO = SYSDATE
   WHERE NUM_PROCESO = v_Sequencia
   AND TIP_MOVIMIEN = v_CastElim ;
--
   COMMIT;
--
-- 2 : CASTIGOS RECUPERADOS -------------------------------------------------------------
--
--
   v_Sequencia := fnSeqCasCon;          -- Obtiene la secuencia del proceso Castigo Contable
--
   SELECT NVL(TRUNC(MAX(fec_proceso)),TRUNC(SYSDATE-1))
   INTO v_FecDesde
   FROM CO_PROC_ACUM_CASCON
   WHERE tip_movimien = v_CastRecu ;
--
   INSERT INTO CO_PROC_ACUM_CASCON      -- Inserta registro en la cabecera
   (num_proceso,tip_movimien,fec_proceso,usuario_proceso,FEC_TERMINO)
   SELECT v_Sequencia,v_CastRecu,SYSDATE,USER,NULL
   FROM dual;
--
   COMMIT;
--
   SELECT MIN(cod_tipdocum), MAX(cod_tipdocum)
   INTO ihMinimo, ihMaximo
   FROM GE_TIPDOCUMEN ;
--
   FOR I IN ihMinimo .. ihMaximo LOOP  -- Prepara el Array de Acumulacion.
      CastigosRecuperados(I).importe := 0    ;
   END LOOP;
--
   FOR BB IN PagosRecientes LOOP  -- Se revisan todos los pagos efectuados en el periodo Desde-Hasta
      ihOk := 0                    ;
      ihFolio :=      BB.FOLIO     ;
      ihCodCliente := BB.CLIENTE   ;
      dhFecha :=      BB.FECHA     ;
      ihImporte :=    BB.IMPORTE   ;
      I :=            BB.DOCUMENTO ;
--
      SELECT COUNT(*)
      INTO ihOk
      FROM CO_CANCELADOS C
      WHERE  C.COD_CLIENTE = ihCodCliente
      AND   C.NUM_SECUENCI > v_Cero
      AND   C.COD_TIPDOCUM = v_TreintayNueve
      AND   C.NUM_FOLIO = ihFolio ;
--
      IF (ihOk > 0) THEN  -- Si el documento que se pago recientemente tiene asociado un castigo contable (pago total)
         -- Se acumula
         CastigosRecuperados(I).importe := CastigosRecuperados(I).importe + ihImporte    ;
         CastigosRecuperados(I).fec_transaccion := dhFecha ;
		 CastigosRecuperados(I).COD_APERTURA := BB.oficina ;
      ELSE -- No lo encontro entre los pagos totales, lo busco en los pagos parciales
         ihOk := 0;
--
         SELECT COUNT(*)
         INTO ihOk
         FROM CO_CARTERA D
         WHERE D.COD_CLIENTE  = ihCodCliente
         AND   D.NUM_SECUENCI > v_Cero
         AND   D.COD_TIPDOCUM = v_TreintayNueve
         AND   D.NUM_FOLIO = ihFolio;
--
         IF (ihOk > 0) THEN -- Si el documento que se pago recientemente tiene asociado un castigo contable (pago parcial)
            -- Se acumula
            CastigosRecuperados(I).importe := CastigosRecuperados(I).importe + ihImporte    ;
            CastigosRecuperados(I).fec_transaccion := dhFecha ;
		    CastigosRecuperados(I).COD_APERTURA := BB.oficina ;
         END IF;
      END IF;
   END LOOP;
--
   FOR I IN ihMinimo .. ihMaximo LOOP
      IF ( CastigosRecuperados(I).importe > 0 ) THEN  -- Inserta los acumulados significativos
         INSERT INTO CO_CASTIGO_CONTABLE
         ( num_proceso,fec_proceso, fec_transaccion,tip_movimien,importe,cod_tipdocum, COD_APERTURA )
         VALUES
         ( v_Sequencia , TRUNC(SYSDATE), CastigosRecuperados(I).fec_transaccion, v_CastRecu, CastigosRecuperados(I).importe,I,CastigosRecuperados(I).COD_APERTURA );
      END IF;
   END LOOP ;
--
   UPDATE CO_PROC_ACUM_CASCON
   SET FEC_TERMINO = SYSDATE
   WHERE NUM_PROCESO = v_Sequencia
   AND TIP_MOVIMIEN = v_CastRecu ;
--
   COMMIT;
--
--
--
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error general en proceso');
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
--
END Co_P_Castigo_Contable;
/
SHOW ERRORS
