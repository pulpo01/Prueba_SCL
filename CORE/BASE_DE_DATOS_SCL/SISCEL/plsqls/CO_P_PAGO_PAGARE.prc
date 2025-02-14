CREATE OR REPLACE PROCEDURE        CO_P_PAGO_PAGARE(
  VP_CLIENTE                  IN VARCHAR2 ,
  VP_NUM_PAGARE               IN VARCHAR2 ,
  VP_NUM_SECUENCI_PAGO        IN VARCHAR2 ,
  VP_COD_TIPDOCUM_PAGO        IN VARCHAR2 ,
  VP_COD_VENDEDOR_AGENTE_PAGO IN VARCHAR2 ,
  VP_LETRA_PAGO               IN VARCHAR2 ,
  VP_COD_CENTREMI_PAGO        IN VARCHAR2,
  VP_MONTO                    IN VARCHAR2
)
IS
  g_cod_cliente              co_cartera.cod_cliente%TYPE;
  g_num_pagare               co_pagare.num_pagare%TYPE;
  mi_ciclo                   co_cuotapagare%ROWTYPE;
  g_cod_centremi_pago         co_cartera.cod_centremi%TYPE;
  g_num_secuenci_pago         co_cartera.num_secuenci%TYPE;
  g_cod_tipdocum_pago         co_cartera.cod_tipdocum%TYPE;
  g_cod_vendedor_agente_pago  co_cartera.cod_vendedor_agente%TYPE;
  g_letra_pago                co_cartera.letra%TYPE;
   CURSOR c_tab IS
     SELECT  *
       FROM  co_cuotapagare
       WHERE num_pagare           = g_num_pagare;
   ERROR_PROCESO EXCEPTION;
  BEGIN
      g_cod_cliente              := to_number(vp_cliente);
      g_num_pagare               := to_number(vp_num_pagare);
      g_num_secuenci_pago        := to_number(vp_num_secuenci_pago);
      g_cod_tipdocum_pago        := to_number(vp_cod_tipdocum_pago);
      g_cod_vendedor_agente_pago := to_number(vp_cod_vendedor_agente_pago);
      g_letra_pago               := vp_letra_pago;
      g_cod_centremi_pago        := to_number(vp_cod_centremi_pago);
       FOR R IN c_tab LOOP
          mi_ciclo:=R;
              UPDATE co_pagare
                 SET ind_proceso = 1,
                     fec_cancela = SYSDATE
              WHERE NUM_PAGARE = g_num_pagare;
              if mi_ciclo.sec_cuota is NOT NULL then
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
                     IMPORTE_DEBE,
                     0                        ,
                     IMPORTE_DEBE,
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
                     NUM_FOLIOCTC
               FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = mi_ciclo.num_secuenci
                 AND cod_tipdocum         = mi_ciclo.cod_tipdocum
                 AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
                 AND letra                = mi_ciclo.letra
                 AND cod_centremi         = mi_ciclo.cod_centremi
                 AND sec_cuota            = mi_ciclo.sec_cuota
                 AND cod_concepto       not in ( 22,88,71,20, 23);
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
                    NUM_CUOTA                   ,
                    SEC_CUOTA                   ,
                    NUM_VENTA                   ,
                    NUM_FOLIOCTC
              FROM CO_CARTERA
            WHERE cod_cliente          = g_cod_cliente
              AND num_secuenci         = mi_ciclo.num_secuenci
              AND cod_tipdocum         = mi_ciclo.cod_tipdocum
              AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
              AND letra                = mi_ciclo.letra
              AND cod_centremi         = mi_ciclo.cod_centremi
              AND sec_cuota            = mi_ciclo.sec_cuota
              AND cod_concepto       not in ( 22,88,71,20, 23);
              DELETE FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = mi_ciclo.num_secuenci
                 AND cod_tipdocum         = mi_ciclo.cod_tipdocum
                 AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
                 AND letra                = mi_ciclo.letra
                 AND cod_centremi         = mi_ciclo.cod_centremi
                 AND sec_cuota            = mi_ciclo.sec_cuota
                 AND cod_concepto       not in ( 22,88,71,20, 23);
            ELSE
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
                     IMPORTE_DEBE,
                     0                        ,
                     IMPORTE_DEBE,
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
                     NUM_FOLIOCTC
               FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = mi_ciclo.num_secuenci
                 AND cod_tipdocum         = mi_ciclo.cod_tipdocum
                 AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
                 AND letra                = mi_ciclo.letra
                 AND cod_centremi         = mi_ciclo.cod_centremi
                 AND sec_cuota            is NULL
                 AND cod_concepto       not in ( 22,88,71,20, 23);
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
                    NUM_CUOTA                   ,
                    SEC_CUOTA                   ,
                    NUM_VENTA                   ,
                    NUM_FOLIOCTC
              FROM CO_CARTERA
            WHERE cod_cliente          = g_cod_cliente
              AND num_secuenci         = mi_ciclo.num_secuenci
              AND cod_tipdocum         = mi_ciclo.cod_tipdocum
              AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
              AND letra                = mi_ciclo.letra
              AND cod_centremi         = mi_ciclo.cod_centremi
              AND sec_cuota            is NULL
              AND cod_concepto       not in ( 22,88,71,20, 23);
              DELETE FROM CO_CARTERA
               WHERE cod_cliente          = g_cod_cliente
                 AND num_secuenci         = mi_ciclo.num_secuenci
                 AND cod_tipdocum         = mi_ciclo.cod_tipdocum
                 AND cod_vendedor_agente  = mi_ciclo.cod_vendedor_agente
                 AND letra                = mi_ciclo.letra
                 AND cod_centremi         = mi_ciclo.cod_centremi
                 AND sec_cuota            is NULL
                 AND cod_concepto       not in ( 22,88,71,20, 23);
           end if;
       END LOOP;
  END;
/
SHOW ERRORS
