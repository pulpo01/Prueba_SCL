CREATE OR REPLACE PROCEDURE co_p_pago_parciales_factura (
   vp_cliente                    IN              co_cartera.cod_cliente%TYPE,
   vp_num_secuenci               IN              co_cartera.num_secuenci%TYPE,
   vp_cod_tipdocum               IN              co_cartera.cod_tipdocum%TYPE,
   vp_cod_vendedor_agente        IN              co_cartera.cod_vendedor_agente%TYPE,
   vp_letra                      IN              co_cartera.letra%TYPE,
   vp_cod_centremi               IN              co_cartera.cod_centremi%TYPE,
   vp_num_secuenci_pago          IN              co_cartera.num_secuenci%TYPE,
   vp_cod_tipdocum_pago          IN              co_cartera.cod_tipdocum%TYPE,
   vp_cod_vendedor_agente_pago   IN              co_cartera.cod_vendedor_agente%TYPE,
   vp_letra_pago                 IN              co_cartera.letra%TYPE,
   vp_cod_centremi_pago          IN              co_cartera.cod_centremi%TYPE,
   vp_monto                      IN              co_cartera.importe_debe%TYPE,
   vp_num_cuota                  IN              co_cartera.sec_cuota%TYPE,
   vp_fec_pago_cliente           IN              VARCHAR2,
   /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   /*                   Desc   :  Parametro opcional */
   vp_num_abonado                IN              co_cartera.num_abonado%TYPE DEFAULT NULL
   /* XO-200509070609 Fin   */
   )
IS
/*
<Documentación TipoDoc = "Función">
    <Elemento>
        <Nombre = "co_p_pago_parciales_factura"></Nombre>
        <Lenguaje="PL/SQL"></Lenguage>
        <Fecha="20-04-2005"></Fecha>
        <Versión="2.0.0"></Version>
        <Versión="2.1.0"></Version>
        <Modificaciones="29/06/2006 inc CO-200606200200"></Modificaciones>
        <Diseñador="Marcelo Quiroz"></Diseñador>
        <Programador="Claudio Machuca"></Programador>
        <Ambiente="DEIMOS"></Ambiente>
        <Retorno="0 - Exito 1-Fracaso "></Retorno>
        <Descripción>Realiza la aplicacion de pagos parciales
                     Se incorpora el concepto de proporcionalidad del pago
                     para cancelar todos los conceptos con una parte del pago
                     Se incorpora un indicador para saber que conceptos se pueden cancelar
                     proporcionalmente y cuales se deben camcelar por completo
        </Descripción>
        <Parámetros>
            <Entrada>
                <param nom="vp_cliente" Tipo="NUMBER">Cliente</param>
                <param nom="vp_num_secuenci" Tipo="NUMBER">Numero Secuencia Emision</param>
                <param nom="vp_cod_tipdocum" Tipo="NUMBER">Tipo Documento Emision</param>
                <param nom="vp_cod_vendedor_agente" Tipo="NUMBER">Agente Documento Emision</param>
                <param nom="vp_letra" Tipo="STRING">Letra Documento Emision</param>
                <param nom="vp_cod_centremi" Tipo="NUMBER">Oficina Emision</param>
                <param nom="vp_num_secuenci_pago" Tipo="NUMBER">Secuencia</param>
                <param nom="vp_cod_tipdocum_pago" Tipo="NUMBER">Tipo de Documento</param>
                <param nom="vp_cod_vendedor_agente_pago" Tipo="NUMBER">Agente</param>
                <param nom="vp_letra_pago" Tipo="STRING">Letra de Documento de Pago</param>
                <param nom="vp_cod_centremi_pago" Tipo="NUMBER">Oficina de Pago</param>
                <param nom="vp_monto" Tipo="NUMBER">Monto Cancelado</param>
                <param nom="vp_num_cuota" Tipo="NUMBER">Numero de Cuota</param>
                <param nom="vp_fec_pago_cliente" Tipo="STRING">Fecha de cancelacion</param>
            </Entrada>
            <Salida>
        </Parámetros>
    </Elemento>
</Documentación>
*/
/* Constantes */
   cn_0                     NUMBER (1)                      := 0;
   cn_1                     NUMBER (1)                      := 1;
   cn_pago_total            NUMBER (1)                      := 0;
   cn_100                   NUMBER (3)                      := 100;
   cv_nomtabla              VARCHAR2 (10)                   := 'CO_CARTERA';
   cv_nomcolumna            VARCHAR2 (12)                   := 'COD_TIPDOCUM';
   cn_indfacturado          co_cartera.ind_facturado%TYPE   := 1;
   cn_conceptocastigo       co_cartera.cod_concepto%TYPE    := 6;
   cn_conceptoabono         co_cartera.cod_concepto%TYPE    := 2;
/* Variables de Trabajo  */
   gn_decimal               NUMBER (28, 4)                  := 0;
   gn_totreg                NUMBER (10)                     := 0;
   gn_i                     NUMBER (10)                     := 0;
   gn_primer_proporcional   NUMBER (10)                     := 0;
   gn_monto_cancelado       NUMBER (28, 4)                  := 0;
   gn_saldo_distribuir      NUMBER (28, 4)                  := 0;
   gn_deuda_distribucion    NUMBER (28, 4)                  := 0;
   gn_total                 NUMBER (28, 4)                  := 0;
   gn_suma_porcentaje       NUMBER (28, 4)                  := 0;
   --gn_porcentaje            NUMBER (10, 4)                  := 0;
   gn_porcentaje            NUMBER (15, 4)                  := 0;  /* 05-12-2005 DVergara Se modifica largo de variable RA-200511280206  */
/* Parametros a ser utilizado por el programa  */

/* Cursor de Trabajo
  20050420 - Se unifica cursor, para traer todos los datos que necesita el package
  se elimina condicion SEC_CUOTA IS NULL, porque no es parte de la llave
  20050614 - Se optimiza cursor, se modifica NOT IN por NOT EXISTS. Modificacion
  temporal en espera de respuesta de MOD_REQ
*/

   CURSOR c_cartera
   IS
      SELECT   /*+ INDEX(A PK_CO_CARTERA) */
                a.cod_centremi          , a.cod_cliente , a.cod_concepto,
                a.cod_operadora_scl     , a.cod_plaza   , a.cod_producto,
                a.cod_tipdocum          , a.cod_vendedor_agente, a.columna,
                a.fec_antiguedad        , a.fec_caducida, a.fec_efectividad,
                a.fec_vencimie          , a.importe_debe, a.ind_contado,
                a.ind_facturado         , a.letra               , a.num_abonado, a.num_cuota,
                a.num_folio                     , a.num_folioctc, a.num_secuenci,
                a.num_transaccion       , a.num_venta   , a.importe_haber,
                a.pref_plaza            , a.ROWID               , a.sec_cuota, b.ind_porcentaje,
                b.orden_can
          FROM co_cartera a, co_conceptos b
         WHERE a.cod_cliente    = vp_cliente
           AND a.num_secuenci   = vp_num_secuenci
           AND a.cod_tipdocum   = vp_cod_tipdocum
           AND a.cod_vendedor_agente = vp_cod_vendedor_agente
           AND a.letra                  = vp_letra
           AND a.cod_centremi   = vp_cod_centremi
           AND (a.sec_cuota = vp_num_cuota or a.sec_cuota is null)     -- CAGV CO-200606200200 29/06/2006
           AND a.cod_concepto   >= cn_0
           AND a.columna                >= cn_0
           AND a.cod_concepto   = b.cod_concepto
                   AND NOT EXISTS (SELECT 1
                                                         FROM co_codigos cod
                                                        WHERE cod.cod_valor   = a.cod_tipdocum
                                                          AND cod.nom_columna = cv_nomcolumna
                                                          AND cod.nom_tabla   = cv_nomtabla)
/*           AND a.cod_tipdocum NOT IN (
                  SELECT TO_NUMBER (cod.cod_valor)
                    FROM co_codigos cod
                   WHERE cod.nom_tabla = cv_nomtabla
                     AND cod.nom_columna = cv_nomcolumna)*/
           AND a.cod_concepto NOT IN (cn_conceptoabono, cn_conceptocastigo)
      ORDER BY a.ind_facturado desc ,a.fec_vencimie asc,b.ind_porcentaje, b.orden_can, a.cod_concepto;  --197775

   /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   /*                   Desc   : Cursor obtiene documento del abonado */
   CURSOR c_carteraabonado
   IS
      SELECT   /*+ INDEX(A PK_CO_CARTERA) */
                a.cod_centremi          , a.cod_cliente , a.cod_concepto,
                a.cod_operadora_scl     , a.cod_plaza   , a.cod_producto,
                a.cod_tipdocum          , a.cod_vendedor_agente, a.columna,
                a.fec_antiguedad        , a.fec_caducida, a.fec_efectividad,
                a.fec_vencimie          , a.importe_debe, a.ind_contado,
                a.ind_facturado         , a.letra               , a.num_abonado, a.num_cuota,
                a.num_folio                     , a.num_folioctc, a.num_secuenci,
                a.num_transaccion       , a.num_venta   , a.importe_haber,
                a.pref_plaza            , a.ROWID               , a.sec_cuota, b.ind_porcentaje,
                b.orden_can
          FROM co_cartera a, co_conceptos b
         WHERE a.cod_cliente    = vp_cliente
           AND a.num_abonado    = vp_num_abonado
           AND a.num_secuenci   = vp_num_secuenci
           AND a.cod_tipdocum   = vp_cod_tipdocum
           AND a.cod_vendedor_agente = vp_cod_vendedor_agente
           AND a.letra                  = vp_letra
           AND a.cod_centremi   = vp_cod_centremi
           AND (a.sec_cuota = vp_num_cuota or a.sec_cuota is null)     -- CAGV CO-200606200200 29/06/2006
           AND a.cod_concepto   >= cn_0
           AND a.columna                >= cn_0
           AND a.cod_concepto   = b.cod_concepto
                   AND NOT EXISTS (SELECT 1
                                                         FROM co_codigos cod
                                                        WHERE cod.cod_valor   = a.cod_tipdocum
                                                          AND cod.nom_columna = cv_nomcolumna
                                                          AND cod.nom_tabla   = cv_nomtabla)
           AND a.cod_concepto NOT IN (cn_conceptoabono, cn_conceptocastigo)
      ORDER BY a.ind_facturado desc ,a.fec_vencimie asc,b.ind_porcentaje, b.orden_can, a.cod_concepto; --197775
    /* XO-200509070609 Fin   */
--Mig
/* Buffer de los datos leidos  */
   reg_cartera              c_cartera%ROWTYPE;

/* Estructura de Tabla a Utilizar para el prorrateo */
   TYPE t_cobranza IS RECORD (
      t_cod_centremi          co_cartera.cod_centremi%TYPE,
      t_cod_cliente           co_cartera.cod_cliente%TYPE,
      t_cod_concepto          co_cartera.cod_concepto%TYPE,
      t_cod_operadora_scl     co_cartera.cod_operadora_scl%TYPE,
      t_cod_plaza             co_cartera.cod_plaza%TYPE,
      t_cod_producto          co_cartera.cod_producto%TYPE,
      t_cod_tipdocum          co_cartera.cod_tipdocum%TYPE,
      t_cod_vendedor_agente   co_cartera.cod_vendedor_agente%TYPE,
      t_columna               co_cartera.columna%TYPE,
      t_fec_antiguedad        co_cartera.fec_antiguedad%TYPE,
      t_fec_caducida          co_cartera.fec_caducida%TYPE,
      t_fec_efectividad       co_cartera.fec_efectividad%TYPE,
      t_fec_vencimie          co_cartera.fec_vencimie%TYPE,
      t_importe_debe          co_cartera.importe_debe%TYPE,
      t_ind_contado           co_cartera.ind_contado%TYPE,
      t_ind_facturado         co_cartera.ind_facturado%TYPE,
      t_letra                 co_cartera.letra%TYPE,
      t_num_abonado           co_cartera.num_abonado%TYPE,
      t_num_cuota             co_cartera.num_cuota%TYPE,
      t_num_folio             co_cartera.num_folio%TYPE,
      t_num_folioctc          co_cartera.num_folioctc%TYPE,
      t_num_secuenci          co_cartera.num_secuenci%TYPE,
      t_num_transaccion       co_cartera.num_transaccion%TYPE,
      t_num_venta             co_cartera.num_venta%TYPE,
      t_monto_concepto        co_cartera.importe_debe%TYPE,
      t_pref_plaza            co_cartera.pref_plaza%TYPE,
      t_sec_cuota             co_cartera.sec_cuota%TYPE,
/*  CAMPOS ADICIONALES PARA PRORRATEO Y CONTROL DEL PAGO */
      t_ind_porcentaje        NUMBER (1),
      t_rowid                 ROWID,
      t_porc_deuda            co_cartera.importe_debe%TYPE, -- INDICA % SOBRE DEUDA A APLICAR AL PAGO
      t_pago_aplicado         co_cartera.importe_debe%TYPE, -- MONTO APLICADO
      t_ult_aplica            co_cartera.ind_contado%TYPE -- INDICA ULTIMO APLICADO (AJUSTE FINAL)
   );

-- declaracion de tabla PL/SQL
   TYPE tab_matriz IS TABLE OF t_cobranza
      INDEX BY BINARY_INTEGER;

-- declaracion de matriz como variable del tipo tabla de registros tipo T_cobranza
   matriz                   tab_matriz;
/* Cuerpo principal del programa */
BEGIN
/* ASIGNACION DECIMALES PARA REDONDEO Y LECTURA PARAMETROS DE ENTRADA */
   gn_decimal := ge_pac_general.param_general ('num_decimal');
   gn_monto_cancelado := vp_monto; -- Conservo monto total cancelado, para efectos de calculo
/* ETAPA 1 - LECTURA DE LOS DATOS Y LLENADO DE LA MATRIZ  */
   IF vp_monto <= 0 THEN
          RETURN;
   END IF;

   /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   /*                   Desc   : Determina cursor a utilizar en base al parametro opcional */
   /*                   OPEN c_cartera;*/
   if vp_num_abonado is null then
                OPEN c_cartera;
   else
                OPEN c_carteraabonado;
   end if;
   /* XO-200509070609 Fin   */

   LOOP
   /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   /*                   Desc   : Determina fertch a utilizar en base al parametro opcional */
   /*   FETCH c_cartera INTO reg_cartera;
        EXIT WHEN c_cartera%NOTFOUND;*/
      if vp_num_abonado is null then
        FETCH c_cartera INTO reg_cartera;
        EXIT WHEN c_cartera%NOTFOUND;
      else
        FETCH c_carteraabonado INTO reg_cartera;
        EXIT WHEN c_carteraabonado%NOTFOUND;
      end if;
   /* XO-200509070609 Fin   */

      gn_totreg := gn_totreg + 1;
------------------------------
--Llenando matriz
------------------------------
      gn_i := gn_i + 1;
/* LA MATRIZ QUEDA CARGADA EN ORDEN 1- REGISTROS QUE SE CANCELAN 100% y 2 - PRIORIDAD APLICACION */
      matriz (gn_i).t_cod_centremi := reg_cartera.cod_centremi;
      matriz (gn_i).t_cod_cliente := reg_cartera.cod_cliente;
      matriz (gn_i).t_cod_concepto := reg_cartera.cod_concepto;
      matriz (gn_i).t_cod_operadora_scl := reg_cartera.cod_operadora_scl;
      matriz (gn_i).t_cod_plaza := reg_cartera.cod_plaza;
      matriz (gn_i).t_cod_producto := reg_cartera.cod_producto;
      matriz (gn_i).t_cod_tipdocum := reg_cartera.cod_tipdocum;
      matriz (gn_i).t_cod_vendedor_agente := reg_cartera.cod_vendedor_agente;
      matriz (gn_i).t_columna := reg_cartera.columna;
      matriz (gn_i).t_fec_antiguedad := reg_cartera.fec_antiguedad;
      matriz (gn_i).t_fec_caducida := reg_cartera.fec_caducida;
      matriz (gn_i).t_fec_efectividad := reg_cartera.fec_efectividad;
      matriz (gn_i).t_fec_vencimie := reg_cartera.fec_vencimie;
      matriz (gn_i).t_importe_debe := reg_cartera.importe_debe;
      matriz (gn_i).t_ind_contado := reg_cartera.ind_contado;
      matriz (gn_i).t_ind_facturado := reg_cartera.ind_facturado;
      matriz (gn_i).t_letra := reg_cartera.letra;
      matriz (gn_i).t_num_abonado := reg_cartera.num_abonado;
      matriz (gn_i).t_num_cuota := reg_cartera.num_cuota;
      matriz (gn_i).t_num_folio := reg_cartera.num_folio;
      matriz (gn_i).t_num_folioctc := reg_cartera.num_folioctc;
      matriz (gn_i).t_num_secuenci := reg_cartera.num_secuenci;
      matriz (gn_i).t_num_transaccion := reg_cartera.num_transaccion;
      matriz (gn_i).t_num_venta := reg_cartera.num_venta;
      matriz (gn_i).t_monto_concepto :=
                          reg_cartera.importe_debe
                          - reg_cartera.importe_haber;
      matriz (gn_i).t_pref_plaza := reg_cartera.pref_plaza;
      matriz (gn_i).t_rowid := reg_cartera.ROWID;
      matriz (gn_i).t_sec_cuota := reg_cartera.sec_cuota;
      matriz (gn_i).t_ind_porcentaje := reg_cartera.ind_porcentaje;
      matriz (gn_i).t_porc_deuda := cn_0;
      matriz (gn_i).t_pago_aplicado := cn_0;
      matriz (gn_i).t_ult_aplica := cn_0;
   END LOOP;

   if vp_num_abonado is null then
                CLOSE c_cartera;
   else
                CLOSE c_carteraabonado;
   end if;


/* ETAPA 2 -
   - APLICA PAGO TOTAL A REGISTROS CON IND_PORCENTAJE = cn_0
      * REBAJA PAGO REALIZADO
   - PARA LOS REGISTROS CON IND_PORCENTAJE = cn_1 (APLICA PROPORCIONALIDAD)
      * SUMA TOTAL DEUDA
   - MARCA ULTIMO REGISTRO CON APLICACION DE PORCENTAJE
*/
   FOR gn_i IN 1 .. gn_totreg
   LOOP
      IF matriz (gn_i).t_ind_porcentaje = cn_pago_total
      THEN
         gn_total := gn_total + 1;

         IF gn_monto_cancelado = cn_0
         THEN
            /* Si no alcanza el pago y el concepto se paga en su totalidad,
               no se rechaza el pago, se acepta el monto pagado */
            NULL; -- No hay acciones a aplicar, no aplica pago
         ELSE
            IF gn_monto_cancelado < matriz (gn_i).t_monto_concepto
            THEN
               /* Si no alcanza el pago y el concepto se paga en su totalidad,
               no se rechaza el pago, se acepta el monto pagado */
               matriz (gn_i).t_pago_aplicado :=
                            matriz (gn_i).t_pago_aplicado
                            + gn_monto_cancelado;
               gn_monto_cancelado := 0; -- aplico saldo restante y dejo saldo en 0
            ELSE
               matriz (gn_i).t_pago_aplicado :=
                                               matriz (gn_i).t_monto_concepto; -- cancelo concepto
               gn_monto_cancelado :=
                           gn_monto_cancelado
                           - matriz (gn_i).t_monto_concepto; -- rebajo saldo
            END IF;
         END IF;
      ELSE -- ANALIZA LOS REGISTROS CON PAGO PROPORCIONAL
         gn_deuda_distribucion :=
                        gn_deuda_distribucion
                        + matriz (gn_i).t_monto_concepto; -- sumo deuda a distribuir

         IF gn_primer_proporcional = cn_0
         THEN
            gn_primer_proporcional := gn_i; -- guardo puntero al primer concepto a aplicar %
         END IF;

         IF gn_i = gn_totreg
         THEN
            matriz (gn_i).t_ult_aplica := cn_1; -- marco registro a ajustar
         END IF;
      END IF;
   END LOOP;

   IF gn_deuda_distribucion > cn_0 AND gn_monto_cancelado > 0
   THEN
      gn_saldo_distribuir := gn_monto_cancelado;
      gn_suma_porcentaje := 0;

/* ETAPA 3 DISTRIBUIR SALDO
   - CALCULA PORCENTAJE A APLICAR
   - CALCULA PAGO A APLICAR
   - PARA ULTIMO REGISTRO; LOS CALCULOS SON SOBRE DIFERENCIAS, PARA AJUSTAR RESULTADO
*/
      FOR gn_i IN gn_primer_proporcional .. gn_totreg
      LOOP
--             calculo porcentaje a aplicar
         IF matriz (gn_i).t_ult_aplica = cn_0 -- si es 0, no aplico ajuste
         THEN
            gn_porcentaje :=
                  (matriz (gn_i).t_monto_concepto / gn_deuda_distribucion
                  )
                * cn_100;
            matriz (gn_i).t_porc_deuda :=
                     ge_pac_general.redondea (gn_porcentaje, gn_decimal, cn_0);
            gn_suma_porcentaje :=
                                gn_suma_porcentaje
                                + matriz (gn_i).t_porc_deuda;

--          calculo monto a pagar
            /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
            /*                   Desc   : Obtiene calculo monto a pagar con todos los decimales */
            /* gn_porcentaje := (matriz (gn_i).t_porc_deuda * gn_saldo_distribuir)/ cn_100; */
            gn_porcentaje := (((matriz (gn_i).t_monto_concepto / gn_deuda_distribucion))* gn_saldo_distribuir);
            /* XO-200509070609 Fin   */
            matriz (gn_i).t_pago_aplicado :=
                     ge_pac_general.redondea (gn_porcentaje, gn_decimal, cn_0); -- aplico proporcionalidad al pago
            gn_monto_cancelado :=
                             gn_monto_cancelado
                             - matriz (gn_i).t_pago_aplicado;
         ELSE
            matriz (gn_i).t_porc_deuda := cn_100 - gn_suma_porcentaje; -- resta directa para sumar 100
--           calculo monto a pagar
            matriz (gn_i).t_pago_aplicado := gn_monto_cancelado; -- resta para ajustar saldo
         END IF;
      END LOOP;
   END IF;

/* ETAPA 4 -
   - ACTUALIZO BASE SEGUN SE APLICO PAGO TOTAL O PARCIAL
*/
   FOR gn_i IN 1 .. gn_totreg
   LOOP
      IF matriz (gn_i).t_pago_aplicado =
                                  matriz (gn_i).t_monto_concepto -- Pago total
      THEN
         -- INSERT EN CO_CANCELADOS
         -- INSERT EN CO_PAGOSCONC
         -- DELETE EN  CO_CARTERA
         BEGIN
            INSERT INTO co_cancelados
                        (cod_cliente,
                         cod_tipdocum,
                         cod_centremi,
                         num_secuenci,
                         cod_vendedor_agente,
                         letra,
                         cod_concepto,
                         columna,
                         cod_producto,
                         importe_debe, num_transaccion,
                         importe_haber,
                         ind_contado,
                         ind_facturado,
                         fec_efectividad,
                         fec_cancelacion,
                         ind_portador, fec_pago, fec_caducida,
                         fec_antiguedad,
                         fec_vencimie,
                         num_cuota,
                         sec_cuota,
                         num_venta,
                         num_abonado,
                         num_folio,
                         pref_plaza,
                         num_folioctc,
                         cod_operadora_scl,
                         cod_plaza
                        )
                 VALUES (matriz (gn_i).t_cod_cliente,
                         matriz (gn_i).t_cod_tipdocum,
                         matriz (gn_i).t_cod_centremi,
                         matriz (gn_i).t_num_secuenci,
                         matriz (gn_i).t_cod_vendedor_agente,
                         matriz (gn_i).t_letra,
                         matriz (gn_i).t_cod_concepto,
                         matriz (gn_i).t_columna,
                         matriz (gn_i).t_cod_producto,
                         matriz (gn_i).t_importe_debe, cn_0,
                         matriz (gn_i).t_importe_debe,
                         matriz (gn_i).t_ind_contado,
                         matriz (gn_i).t_ind_facturado,
                         matriz (gn_i).t_fec_efectividad,
                         TO_DATE (vp_fec_pago_cliente, 'DD-MM-YYYY HH24:MI:SS'),
                         cn_0, SYSDATE, matriz (gn_i).t_fec_caducida,
                         matriz (gn_i).t_fec_antiguedad,
                         matriz (gn_i).t_fec_vencimie,
                         matriz (gn_i).t_num_cuota,
                         matriz (gn_i).t_sec_cuota,
                         matriz (gn_i).t_num_venta,
                         matriz (gn_i).t_num_abonado,
                         matriz (gn_i).t_num_folio,
                         matriz (gn_i).t_pref_plaza,
                         matriz (gn_i).t_num_folioctc,
                         matriz (gn_i).t_cod_operadora_scl,
                         matriz (gn_i).t_cod_plaza
                        );
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               ROLLBACK;
               RETURN;
            WHEN OTHERS
            THEN
               ROLLBACK;
               RETURN;
         END;

         BEGIN
            INSERT INTO co_pagosconc
                        (cod_tipdocum, cod_centremi,
                         num_secuenci, cod_vendedor_agente,
                         num_securel, letra,
                         imp_concepto,
                         cod_producto,
                         cod_tipdocrel,
                         cod_agenterel,
                         num_transaccion,
                         letra_rel,
                         cod_centrrel,
                         cod_concepto,
                         columna,
                         num_abonado,
                         num_folio,
                         pref_plaza,
                         num_cuota,
                         sec_cuota,
                         num_venta,
                         num_folioctc,
                         cod_operadora_scl,
                         cod_plaza
                        )
                 VALUES (vp_cod_tipdocum_pago, vp_cod_centremi_pago,
                         vp_num_secuenci_pago, vp_cod_vendedor_agente_pago,
                         matriz (gn_i).t_num_secuenci, vp_letra_pago,
                         ge_pac_general.redondea (matriz (gn_i).t_monto_concepto,
                                                  gn_decimal,
                                                  0
                                                 ),
                         matriz (gn_i).t_cod_producto,
                         matriz (gn_i).t_cod_tipdocum,
                         matriz (gn_i).t_cod_vendedor_agente,
                         matriz (gn_i).t_num_transaccion,
                         matriz (gn_i).t_letra,
                         matriz (gn_i).t_cod_centremi,
                         matriz (gn_i).t_cod_concepto,
                         matriz (gn_i).t_columna,
                         matriz (gn_i).t_num_abonado,
                         matriz (gn_i).t_num_folio,
                         matriz (gn_i).t_pref_plaza,
                         matriz (gn_i).t_num_cuota,
                         matriz (gn_i).t_sec_cuota,
                         matriz (gn_i).t_num_venta,
                         matriz (gn_i).t_num_folioctc,
                         matriz (gn_i).t_cod_operadora_scl,
                         matriz (gn_i).t_cod_plaza
                        );
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               ROLLBACK;
               RETURN;
            WHEN OTHERS
            THEN
               ROLLBACK;
               RETURN;
         END;

         BEGIN
            DELETE FROM co_cartera
                  WHERE ROWID = matriz (gn_i).t_rowid;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               ROLLBACK;
               RETURN;
            WHEN OTHERS
            THEN
               ROLLBACK;
               RETURN;
         END;
      ELSE
         -- INSERT EN CO_PAGOSCONC
         -- UPDATE EN CO_CARTERA
         BEGIN
                        IF (matriz (gn_i).t_pago_aplicado > 0 ) THEN
            INSERT INTO co_pagosconc
                        (cod_tipdocum, cod_centremi,
                         num_secuenci, cod_vendedor_agente,
                         num_securel, letra,
                         imp_concepto,
                         cod_producto,
                         cod_tipdocrel,
                         cod_agenterel,
                         num_transaccion,
                         letra_rel,
                         cod_centrrel,
                         cod_concepto,
                         columna,
                         num_abonado,
                         num_folio,
                         pref_plaza,
                         num_cuota,
                         sec_cuota,
                         num_venta,
                         num_folioctc,
                         cod_operadora_scl,
                         cod_plaza
                        )
                 VALUES (vp_cod_tipdocum_pago, vp_cod_centremi_pago,
                         vp_num_secuenci_pago, vp_cod_vendedor_agente_pago,
                         matriz (gn_i).t_num_secuenci, vp_letra_pago,
                         ge_pac_general.redondea (matriz (gn_i).t_pago_aplicado,gn_decimal,0),
                         matriz (gn_i).t_cod_producto,
                         matriz (gn_i).t_cod_tipdocum,
                         matriz (gn_i).t_cod_vendedor_agente,
                         matriz (gn_i).t_num_transaccion,
                         matriz (gn_i).t_letra,
                         matriz (gn_i).t_cod_centremi,
                         matriz (gn_i).t_cod_concepto,
                         matriz (gn_i).t_columna,
                         matriz (gn_i).t_num_abonado,
                         matriz (gn_i).t_num_folio,
                         matriz (gn_i).t_pref_plaza,
                         matriz (gn_i).t_num_cuota,
                         matriz (gn_i).t_sec_cuota,
                         matriz (gn_i).t_num_venta,
                         matriz (gn_i).t_num_folioctc,
                         matriz (gn_i).t_cod_operadora_scl,
                         matriz (gn_i).t_cod_plaza
                        );
                        END IF;
                 EXCEPTION
                    WHEN DUP_VAL_ON_INDEX
                    THEN
                       ROLLBACK;
                       RETURN;
                    WHEN OTHERS
                    THEN
                       ROLLBACK;
                       RETURN;
         END;

         BEGIN
                        IF (matriz (gn_i).t_pago_aplicado > 0 ) THEN
                    UPDATE co_cartera
                       SET importe_haber = importe_haber + ge_pac_general.redondea (matriz (gn_i).t_pago_aplicado,gn_decimal,0)
                     WHERE ROWID = matriz (gn_i).t_rowid;
                        END IF;
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       ROLLBACK;
                       RETURN;
                    WHEN OTHERS
                    THEN
                       ROLLBACK;
                       RETURN;
         END;
      END IF;
   END LOOP;
END co_p_pago_parciales_factura;
/
SHOW ERRORS
