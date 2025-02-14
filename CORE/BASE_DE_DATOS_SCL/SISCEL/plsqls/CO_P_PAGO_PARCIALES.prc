CREATE OR REPLACE PROCEDURE CO_P_PAGO_PARCIALES
(
  VP_CLIENTE                  IN VARCHAR2 ,
  VP_NUM_SECUENCI             IN VARCHAR2 ,
  VP_COD_TIPDOCUM             IN VARCHAR2 ,
  VP_COD_VENDEDOR_AGENTE      IN VARCHAR2 ,
  VP_LETRA                    IN VARCHAR2 ,
  VP_COD_CENTREMI             IN VARCHAR2 ,
  VP_NUM_SECUENCI_PAGO        IN VARCHAR2 ,
  VP_COD_TIPDOCUM_PAGO        IN VARCHAR2 ,
  VP_COD_VENDEDOR_AGENTE_PAGO IN VARCHAR2 ,
  VP_LETRA_PAGO               IN VARCHAR2 ,
  VP_COD_CENTREMI_PAGO        IN VARCHAR2
)
IS
  g_cod_cliente              co_cartera.cod_cliente%TYPE;
  g_num_secuenci             co_cartera.num_secuenci%TYPE;
  g_cod_tipdocum             co_cartera.cod_tipdocum%TYPE;
  g_cod_vendedor_agente      co_cartera.cod_vendedor_agente%TYPE;
  g_letra                    co_cartera.letra%TYPE;
  g_cod_centremi             co_cartera.cod_centremi%TYPE;
  g_total_cartera            co_cartera.importe_debe%TYPE;
  mi_ciclo                   co_pagcartera%ROWTYPE;
 g_cod_centremi_pago         co_cartera.cod_centremi%TYPE;
 g_num_secuenci_pago         co_cartera.num_secuenci%TYPE;
 g_cod_tipdocum_pago         co_cartera.cod_tipdocum%TYPE;
 g_cod_vendedor_agente_pago  co_cartera.cod_vendedor_agente%TYPE;
 g_letra_pago                co_cartera.letra%TYPE;
   CURSOR c_tab IS
     SELECT  a.*
       FROM  co_pagcartera a
       WHERE cod_cliente          = g_cod_cliente
         AND num_secuenci         = g_num_secuenci
         AND cod_tipdocum         = g_cod_tipdocum
         AND cod_vendedor_agente  = g_cod_vendedor_agente
         AND letra                = g_letra
         AND cod_centremi         = g_cod_centremi
         AND importe_debe         <> 0;
   ERROR_PROCESO EXCEPTION;
  BEGIN
      g_cod_cliente              := to_number(vp_cliente);
      g_num_secuenci             := to_number(vp_num_secuenci);
      g_cod_tipdocum             := to_number(vp_cod_tipdocum);
      g_cod_vendedor_agente      := to_number(vp_cod_vendedor_agente);
      g_letra                    := vp_letra;
      g_cod_centremi             := to_number(vp_cod_centremi);
      g_num_secuenci_pago        := to_number(vp_num_secuenci_pago);
      g_cod_tipdocum_pago        := to_number(vp_cod_tipdocum_pago);
      g_cod_vendedor_agente_pago := to_number(vp_cod_vendedor_agente_pago);
      g_letra_pago               := vp_letra_pago;
      g_cod_centremi_pago        := to_number(vp_cod_centremi_pago);
      INSERT INTO co_cancelados
               (
                 COD_CLIENTE              ,
                 COD_TIPDOCUM             ,
                 COD_CENTREMI             ,
                 NUM_SECUENCI             ,
                 COD_VENDEDOR_AGENTE      ,
                 LETRA                    ,
                 COD_CONCEPTO             ,
                 COLUMNA                  ,
                 COD_PRODUCTO             ,
                 IMPORTE_HABER            ,
                 NUM_TRANSACCION          ,
                 IMPORTE_DEBE             ,
                 IND_CONTADO              ,
                 IND_FACTURADO            ,
                 FEC_EFECTIVIDAD          ,
                 FEC_CANCELACION          ,
                 IND_PORTADOR             ,
                 FEC_PAGO                 ,
                 FEC_CADUCIDA             ,
                 FEC_ANTIGUEDAD           ,
                 FEC_VENCIMIE             ,
                 NUM_CUOTA                ,
                 SEC_CUOTA                ,
                 NUM_VENTA                ,
                 NUM_ABONADO              ,
                 NUM_FOLIO                ,
                                 PREF_PLAZA                               ,
                 NUM_FOLIOCTC
                                    )
          SELECT
                 COD_CLIENTE              ,
                 COD_TIPDOCUM             ,
                 COD_CENTREMI             ,
                 NUM_SECUENCI             ,
                 COD_VENDEDOR_AGENTE      ,
                 LETRA                    ,
                 COD_CONCEPTO             ,
                 COLUMNA                  ,
                 COD_PRODUCTO             ,
                 IMPORTE_DEBE-IMPORTE_HABER,
                 0                        ,
                 IMPORTE_DEBE-IMPORTE_HABER,
                 IND_CONTADO              ,
                 IND_FACTURADO            ,
                 FEC_EFECTIVIDAD          ,
                 SYSDATE                  ,
                 0                        ,
                 SYSDATE                  ,
                 --FEC_PAGO                 ,
                 FEC_CADUCIDA             ,
                 FEC_ANTIGUEDAD           ,
                 FEC_VENCIMIE             ,
                 NUM_CUOTA                ,
                 SEC_CUOTA                ,
                 NUM_VENTA                ,
                 NUM_ABONADO              ,
                 NUM_FOLIO                ,
                                 PREF_PLAZA                               ,
                 NUM_FOLIOCTC
           FROM CO_CARTERA
           WHERE cod_cliente          = g_cod_cliente
             AND num_secuenci         = g_num_secuenci
             AND cod_tipdocum         = g_cod_tipdocum
             AND cod_vendedor_agente  = g_cod_vendedor_agente
             AND letra                = g_letra
             AND cod_centremi         = g_cod_centremi
             AND num_abonado not in ( select num_abonado
                                        from co_pagcartera );
      INSERT INTO CO_PAGOSCONC
              (
                COD_TIPDOCUM                 ,
                COD_CENTREMI                 ,
                NUM_SECUENCI                 ,
                COD_VENDEDOR_AGENTE          ,
                NUM_SECUREL                  ,
                LETRA                        ,
                IMP_CONCEPTO                 ,
                COD_PRODUCTO                 ,
                COD_TIPDOCREL                ,
                COD_AGENTEREL                ,
                NUM_TRANSACCION              ,
                LETRA_REL                    ,
                COD_CENTRREL                 ,
                COD_CONCEPTO                 ,
                COLUMNA                      ,
                NUM_ABONADO                  ,
                NUM_FOLIO                    ,
                                PREF_PLAZA                                       ,
                NUM_CUOTA                    ,
                SEC_CUOTA                    ,
                NUM_VENTA                    ,
                NUM_FOLIOCTC
              )
      SELECT
                g_cod_tipdocum_pago         ,
                g_cod_centremi_pago         ,
                g_num_secuenci_pago         ,
                g_cod_vendedor_agente_pago  ,
                NUM_SECUENCI                ,
                g_letra_pago                ,
                IMPORTE_DEBE-IMPORTE_HABER  ,
                COD_PRODUCTO                ,
                COD_TIPDOCUM                ,
                COD_VENDEDOR_AGENTE         ,
                NUM_TRANSACCION             ,
                LETRA                       ,
                COD_CENTREMI                ,
                COD_CONCEPTO                ,
                COLUMNA                     ,
                NUM_ABONADO                 ,
                NUM_FOLIO                   ,
                                PREF_PLAZA                                      ,
                NUM_CUOTA                   ,
                SEC_CUOTA                   ,
                NUM_VENTA                   ,
                NUM_FOLIOCTC
          FROM CO_CARTERA
        WHERE cod_cliente          = g_cod_cliente
          AND num_secuenci         = g_num_secuenci
          AND cod_tipdocum         = g_cod_tipdocum
          AND cod_vendedor_agente  = g_cod_vendedor_agente
          AND letra                = g_letra
          AND cod_centremi         = g_cod_centremi
          AND num_abonado not in ( select num_abonado
                                     from co_pagcartera );
       DELETE FROM CO_CARTERA
        WHERE cod_cliente          = g_cod_cliente
          AND num_secuenci         = g_num_secuenci
          AND cod_tipdocum         = g_cod_tipdocum
          AND cod_vendedor_agente  = g_cod_vendedor_agente
          AND letra                = g_letra
          AND cod_centremi         = g_cod_centremi
          AND num_abonado not in ( select num_abonado
                                     from co_pagcartera );
       FOR R IN c_tab LOOP
           mi_ciclo:=R;
           g_total_cartera := 0;
           SELECT SUM(importe_debe-importe_haber)
             INTO g_total_cartera
             FROM co_cartera
             WHERE cod_cliente          = g_cod_cliente
               AND num_secuenci         = g_num_secuenci
               AND cod_tipdocum         = g_cod_tipdocum
               AND cod_vendedor_agente  = g_cod_vendedor_agente
               AND letra                = g_letra
               AND cod_centremi         = g_cod_centremi
               AND num_abonado          = mi_ciclo.num_abonado
               AND cod_concepto         = mi_ciclo.cod_concepto;
           IF ( mi_ciclo.importe_debe >= g_total_cartera ) THEN
               INSERT INTO co_cancelados
                   (
                     COD_CLIENTE              ,
                     COD_TIPDOCUM             ,
                     COD_CENTREMI             ,
                     NUM_SECUENCI             ,
                     COD_VENDEDOR_AGENTE      ,
                     LETRA                    ,
                     COD_CONCEPTO             ,
                     COLUMNA                  ,
                     COD_PRODUCTO             ,
                     IMPORTE_HABER            ,
                     NUM_TRANSACCION          ,
                     IMPORTE_DEBE             ,
                     IND_CONTADO              ,
                     IND_FACTURADO            ,
                     FEC_EFECTIVIDAD          ,
                     FEC_CANCELACION          ,
                     IND_PORTADOR             ,
                     FEC_PAGO                 ,
                     FEC_CADUCIDA             ,
                     FEC_ANTIGUEDAD           ,
                     FEC_VENCIMIE             ,
                     NUM_CUOTA                ,
                     SEC_CUOTA                ,
                     NUM_VENTA                ,
                     NUM_ABONADO              ,
                     NUM_FOLIO                ,
                                         PREF_PLAZA                               ,
                     NUM_FOLIOCTC
                                        )
                SELECT
                     COD_CLIENTE              ,
                     COD_TIPDOCUM             ,
                     COD_CENTREMI             ,
                     NUM_SECUENCI             ,
                     COD_VENDEDOR_AGENTE      ,
                     LETRA                    ,
                     COD_CONCEPTO             ,
                     COLUMNA                  ,
                     COD_PRODUCTO             ,
                     IMPORTE_DEBE              ,
                     0                        ,
                     IMPORTE_DEBE              ,
                     IND_CONTADO              ,
                     IND_FACTURADO            ,
                     FEC_EFECTIVIDAD          ,
                     SYSDATE                  ,
                     0                        ,
                     SYSDATE                  ,
                     --FEC_PAGO                 ,
                     FEC_CADUCIDA             ,
                     FEC_ANTIGUEDAD           ,
                     FEC_VENCIMIE             ,
                     NUM_CUOTA                ,
                     SEC_CUOTA                ,
                     NUM_VENTA                ,
                     NUM_ABONADO              ,
                     NUM_FOLIO                ,
                                         PREF_PLAZA                               ,
                     NUM_FOLIOCTC
               FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = g_num_secuenci
                 AND cod_tipdocum         = g_cod_tipdocum
                 AND cod_vendedor_agente  = g_cod_vendedor_agente
                 AND letra                = g_letra
                 AND cod_centremi         = g_cod_centremi
                 AND num_abonado          = mi_ciclo.num_abonado
                 AND cod_concepto         = mi_ciclo.cod_concepto;
             INSERT INTO CO_PAGOSCONC
              (
                       COD_TIPDOCUM                 ,
                       COD_CENTREMI                 ,
                       NUM_SECUENCI                 ,
                       COD_VENDEDOR_AGENTE          ,
                       NUM_SECUREL                  ,
                       LETRA                        ,
                       IMP_CONCEPTO                 ,
                       COD_PRODUCTO                 ,
                       COD_TIPDOCREL                ,
                       COD_AGENTEREL                ,
                       NUM_TRANSACCION              ,
                       LETRA_REL                    ,
                       COD_CENTRREL                 ,
                       COD_CONCEPTO                 ,
                       COLUMNA                      ,
                       NUM_ABONADO                  ,
                       NUM_FOLIO                    ,
                                           PREF_PLAZA                                   ,
                       NUM_CUOTA                    ,
                       SEC_CUOTA                    ,
                       NUM_VENTA                    ,
                       NUM_FOLIOCTC
                     )
                    SELECT
                       g_cod_tipdocum_pago         ,
                       g_cod_centremi_pago         ,
                       g_num_secuenci_pago         ,
                       g_cod_vendedor_agente_pago  ,
                       NUM_SECUENCI                ,
                       g_letra_pago                ,
                       IMPORTE_DEBE-IMPORTE_HABER  ,
                       COD_PRODUCTO                ,
                       COD_TIPDOCUM                ,
                       COD_VENDEDOR_AGENTE         ,
                       NUM_TRANSACCION             ,
                       LETRA                       ,
                       COD_CENTREMI                ,
                       COD_CONCEPTO                ,
                       COLUMNA                     ,
                       NUM_ABONADO                 ,
                       NUM_FOLIO                   ,
                                           PREF_PLAZA                              ,
                       NUM_CUOTA                   ,
                       SEC_CUOTA                   ,
                       NUM_VENTA                   ,
                       NUM_FOLIOCTC
                FROM CO_CARTERA
                WHERE cod_cliente          = g_cod_cliente
                  AND num_secuenci         = g_num_secuenci
                  AND cod_tipdocum         = g_cod_tipdocum
                  AND cod_vendedor_agente  = g_cod_vendedor_agente
                  AND letra                = g_letra
                  AND cod_centremi         = g_cod_centremi
                  AND num_abonado          = mi_ciclo.num_abonado
                  AND cod_concepto         = mi_ciclo.cod_concepto;
               DELETE FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = g_num_secuenci
                 AND cod_tipdocum         = g_cod_tipdocum
                 AND cod_vendedor_agente  = g_cod_vendedor_agente
                 AND letra                = g_letra
                 AND cod_centremi         = g_cod_centremi
                 AND num_abonado          = mi_ciclo.num_abonado
                 AND cod_concepto         = mi_ciclo.cod_concepto;
           ELSE
               UPDATE CO_CARTERA
                 SET importe_haber =importe_haber + mi_ciclo.importe_debe
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = g_num_secuenci
                 AND cod_tipdocum         = g_cod_tipdocum
                 AND cod_vendedor_agente  = g_cod_vendedor_agente
                 AND letra                = g_letra
                 AND cod_centremi         = g_cod_centremi
                 AND num_abonado          = mi_ciclo.num_abonado
                 AND cod_concepto         = mi_ciclo.cod_concepto;
             INSERT INTO CO_PAGOSCONC
              (
                       COD_TIPDOCUM                 ,
                       COD_CENTREMI                 ,
                       NUM_SECUENCI                 ,
                       COD_VENDEDOR_AGENTE          ,
                       NUM_SECUREL                  ,
                       LETRA                        ,
                       IMP_CONCEPTO                 ,
                       COD_PRODUCTO                 ,
                       COD_TIPDOCREL                ,
                       COD_AGENTEREL                ,
                       NUM_TRANSACCION              ,
                       LETRA_REL                    ,
                       COD_CENTRREL                 ,
                       COD_CONCEPTO                 ,
                       COLUMNA                      ,
                       NUM_ABONADO                  ,
                       NUM_FOLIO                    ,
                                           PREF_PLAZA                                   ,
                       NUM_CUOTA                    ,
                       SEC_CUOTA                    ,
                       NUM_VENTA                    ,
                       NUM_FOLIOCTC
                     )
                    SELECT
                       g_cod_tipdocum_pago         ,
                       g_cod_centremi_pago         ,
                       g_num_secuenci_pago         ,
                       g_cod_vendedor_agente_pago  ,
                       NUM_SECUENCI                ,
                       g_letra_pago                ,
                       mi_ciclo.importe_debe       ,
                       COD_PRODUCTO                ,
                       COD_TIPDOCUM                ,
                       COD_VENDEDOR_AGENTE         ,
                       NUM_TRANSACCION             ,
                       LETRA                       ,
                       COD_CENTREMI                ,
                       COD_CONCEPTO                ,
                       COLUMNA                     ,
                       NUM_ABONADO                 ,
                       NUM_FOLIO                   ,
                                           PREF_PLAZA                              ,
                       NUM_CUOTA                   ,
                       SEC_CUOTA                   ,
                       NUM_VENTA                   ,
                       NUM_FOLIOCTC
                FROM CO_CARTERA
                WHERE cod_cliente          = g_cod_cliente
                  AND num_secuenci         = g_num_secuenci
                  AND cod_tipdocum         = g_cod_tipdocum
                  AND cod_vendedor_agente  = g_cod_vendedor_agente
                  AND letra                = g_letra
                  AND cod_centremi         = g_cod_centremi
                  AND num_abonado          = mi_ciclo.num_abonado
                  AND cod_concepto         = mi_ciclo.cod_concepto;
           END IF;
       END LOOP;
  END;
/
SHOW ERRORS
