CREATE OR REPLACE PROCEDURE        VE_P2_LIQUIDA_TRAFICO(
vp_fecha_inicial  IN         DATE,
vp_fecha_final    IN         DATE
)
IS
--*** CONSTANTES ***
vp_E                         VARCHAR2(1) := 'E';
vp_AC                        VARCHAR2(2) := 'AC';
vp_AAA                       VARCHAR2(3) := 'AAA';
vp_ABP                       VARCHAR2(3) := 'ABP';
vp_ACP                       VARCHAR2(3) := 'ACP';
vp_CNP                       VARCHAR2(3) := 'CNP';
vp_CSP                       VARCHAR2(3) := 'CSP';
vp_RTP                       VARCHAR2(3) := 'RTP';
vp_BF                        VARCHAR2(2) := 'BF';
vp_CF                        VARCHAR2(2) := 'CF';
vp_CC                        VARCHAR2(2) := 'CC';
vp_0                         NUMBER(1)   := 0;
vp_1                         NUMBER(1)   := 1;
vp_10                        VARCHAR2(2) := '10';
vp_fecha_vigencia_comisiones DATE := TO_DATE('19970201','YYYYMMDD');
--*** VARIABLES PARA QUERY DINAMICO
vp_cursorid                  INTEGER;
vp_select                    VARCHAR2(300);
vp_nada	                     INTEGER;
--*** VARIABLES PARA MENSAJE DE ERROR ***
vp_mensaje                   VARCHAR2(120):= ' ';
vp_procedure                 VARCHAR2(30) := 'VE_P2_LIQUIDA_TRAFICO';
vp_tabla                     VARCHAR2(30);
vp_accion                    VARCHAR2(1);
vp_sqlcode                   VARCHAR2(10);
vp_sqlerrm                   VARCHAR2(70);
--*** VARIABLES AUXILIARES ***
vp_cod_vendedor              VE_VENDEDORES.COD_VENDEDOR%TYPE := 0;
vp_cod_tipcomis              VE_TIPCOMIS.COD_TIPCOMIS%TYPE;
vp_cod_ctoliq                VE_CTOLIQ.COD_CTOLIQ%TYPE;
vp_imp_porcentaje            NUMBER;
vp_tip_plantarif             TA_PLANTARIF.TIP_PLANTARIF%TYPE;
vp_cod_cliente               VE_TMP_ABONADOSDEALER.COD_CLIENTE%TYPE;
vp_num_abonado               VE_TMP_ABONADOSDEALER.NUM_ABONADO%TYPE;
vp_num_liquidacion           VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE;
vp_tot_clientes              VE_RESTRAFICO.TOT_CLIENTES%TYPE;
vp_tot_abonados              VE_RESTRAFICO.TOT_ABONADOS%TYPE;
vp_importe_trafico           VE_RESTRAFICO.IMPORTE_PAGOS%TYPE;
vp_imp_cargo_basico          VE_RESTRAFICO.IMPORTE_PAGOS%TYPE;
vp_importe_total             VE_RESTRAFICO.IMPORTE_PAGOS%TYPE;
vp_importe_resultado         VE_RESTRAFICO.IMPORTE_TRAFICO%TYPE;
vp_cod_ciclfact              FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_ind_ordentotal            FA_HISTDOCU.IND_ORDENTOTAL%TYPE;
vp_ind_pasocobro             FA_HISTDOCU.IND_PASOCOBRO%TYPE;
vp_ind_anulada               FA_HISTDOCU.IND_ANULADA%TYPE;
vp_num_folio                 FA_HISTDOCU.NUM_FOLIO%TYPE;
vp_tabla_detalle             VARCHAR2(30);
--*** FACTURAS POR CLIENTE - ABONADO ***
CURSOR C1 IS
   SELECT TMP1.COD_VENDEDOR, TMP1.COD_TIPCOMIS, TMP1.COD_CTOLIQ, TMP1.IMP_PORCENTAJE,
          TMP1.COD_CLIENTE, TMP1.NUM_ABONADO, TMP1.NUM_ABONADOS_PLAN, TMP1.TIP_PLANTARIF,
          TMP4.NUM_SECUENCI, TMP4.COD_TIPDOCUM, TMP4.COD_VENDEDOR_AGENTE, TMP4.LETRA,
          TMP4.COD_CENTREMI
    FROM VE_TMP_PAGOSLIQCLIENTE TMP4, VE_TMP_ABONADOSDEALER TMP1
    WHERE TMP1.COD_CLIENTE = TMP4.COD_CLIENTE
   ORDER BY TMP1.COD_VENDEDOR, TMP1.TIP_PLANTARIF, TMP1.COD_CLIENTE, TMP1.NUM_ABONADO;
C1_FACTURA_ABONADO           C1%ROWTYPE;
--
BEGIN
   DELETE FROM VE_TMP_ABONADOSDEALER;
   COMMIT;
   DELETE FROM VE_TMP_CLIENTESDEALER;
   COMMIT;
   DELETE FROM VE_TMP_PAGOSCLIENTE;
   COMMIT;
   DELETE FROM VE_TMP_PAGOSLIQCLIENTE;
   COMMIT;
--
--*** GENERACION DE TABLA ABONADOS POR MASTER DEALER ***
--
   BEGIN
      vp_tabla := 'VE_TMP_ABONADOSDEALER';
      vp_accion := 'I';
      INSERT
       INTO VE_TMP_ABONADOSDEALER(COD_VENDEDOR, COD_TIPCOMIS, COD_CTOLIQ, IMP_PORCENTAJE, COD_CLIENTE,
                                  NUM_ABONADO, NUM_ABONADOS_PLAN, TIP_PLANTARIF)
       SELECT VE_VENDEDORES_RAIZ.COD_VENDEDOR,
              VE_VENDEDORES_RAIZ.COD_TIPCOMIS,
              70101,
              5,
              GA_ABOCEL.COD_CLIENTE,
              GA_ABOCEL.NUM_ABONADO,
              DECODE(NVL(TA_PLANTARIF.NUM_ABONADOS,1),0,1,NVL(TA_PLANTARIF.NUM_ABONADOS,1)),
              TA_PLANTARIF.TIP_PLANTARIF
        FROM TA_PLANTARIF,
             GA_ABOCEL,
             GA_VENTAS,
             VE_VENDEDORES,
             VE_VENDEDORES VE_VENDEDORES_RAIZ
        WHERE
-- ******************************************************************************************************
              GA_VENTAS.FEC_VENTA              >= vp_fecha_vigencia_comisiones   /* !!! FECHA FIJA !!! */
-- ******************************************************************************************************
          AND GA_ABOCEL.COD_SITUACION          IN (vp_AAA, vp_ABP, vp_ACP, vp_CNP, vp_CSP, vp_RTP)
          AND GA_ABOCEL.COD_ESTADO             NOT IN (vp_BF, vp_CF, vp_CC)
          AND TA_PLANTARIF.COD_PLANTARIF       = GA_ABOCEL.COD_PLANTARIF
          AND TA_PLANTARIF.COD_PRODUCTO        = GA_ABOCEL.COD_PRODUCTO
          AND GA_ABOCEL.NUM_VENTA              = GA_VENTAS.NUM_VENTA
          AND GA_VENTAS.IND_ESTVENTA           = vp_AC
          AND GA_VENTAS.COD_VENDEDOR           = VE_VENDEDORES.COD_VENDEDOR
          AND VE_VENDEDORES.COD_VENDE_RAIZ     = VE_VENDEDORES_RAIZ.COD_VENDEDOR
          AND NVL(VE_VENDEDORES_RAIZ.FEC_FINCONTRATO, TO_DATE('30001231','YYYYMMDD')) >= vp_fecha_final
          AND VE_VENDEDORES_RAIZ.COD_TIPCOMIS  = vp_10;
      COMMIT;
   EXCEPTION
    WHEN OTHERS THEN
       vp_mensaje := '[1] '||TO_CHAR(vp_fecha_inicial,'YYYY/MM/DD')
                           ||' - '||TO_CHAR(vp_fecha_final,'YYYY/MM/DD');
       vp_sqlcode := sqlcode;
       vp_sqlerrm := sqlerrm;
       VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
   END; -- Generacion de tabla abonados por master dealer
--
--*** GENERACION DE TABLA CLIENTES DE MASTER DEALER ***
--
   BEGIN
      vp_tabla := 'VE_TMP_CLIENTESDEALER';
      vp_accion := 'I';
      INSERT INTO VE_TMP_CLIENTESDEALER
        SELECT DISTINCT COD_CLIENTE
        FROM VE_TMP_ABONADOSDEALER;
      COMMIT;
   EXCEPTION
    WHEN OTHERS THEN
       vp_mensaje := '[2] ';
       vp_sqlcode := sqlcode;
       vp_sqlerrm := sqlerrm;
       VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
   END; -- Generacion de tabla clientes de master dealer
--
--*** GENERACION DE TABLA PAGOS POR CLIENTE
--
--*** 1? Inserta pagos por cliente desde cobranzas
   BEGIN
      vp_tabla := 'VE_TMP_PAGOSCLIENTE';
      vp_accion := 'I';
      INSERT
       INTO VE_TMP_PAGOSCLIENTE(COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                                LETRA, COD_CENTREMI)
       SELECT TMP2.COD_CLIENTE, CAN.NUM_SECUENCI, CAN.COD_TIPDOCUM, CAN.COD_VENDEDOR_AGENTE,
              CAN.LETRA, CAN.COD_CENTREMI
        FROM CO_CANCELADOS CAN, VE_TMP_CLIENTESDEALER TMP2
        WHERE TMP2.COD_CLIENTE =  CAN.COD_CLIENTE
          AND CAN.COD_TIPDOCUM IN (2, 23, 40, 36, 43) -- facturas de ciclo afecta, de cierre,
                                                      -- de ciclo exenta, boletas de ciclo afecta
                                                      -- y de ciclo exenta
          AND CAN.FEC_CANCELACION  >= vp_fecha_inicial
          AND CAN.FEC_CANCELACION  <  vp_fecha_final
          AND CAN.ROWID = (SELECT CAN1.ROWID  FROM CO_CANCELADOS CAN1
                            WHERE CAN.NUM_SECUENCI         = CAN1.NUM_SECUENCI
                              AND CAN.COD_TIPDOCUM         = CAN1.COD_TIPDOCUM
                              AND CAN.COD_VENDEDOR_AGENTE  = CAN1.COD_VENDEDOR_AGENTE
                              AND CAN.LETRA                = CAN1.LETRA
                              AND CAN.COD_CENTREMI         = CAN1.COD_CENTREMI
                              AND ROWNUM = vp_1
                           );
      COMMIT;
   EXCEPTION
    WHEN OTHERS THEN
       vp_mensaje := '[3] '||TO_CHAR(vp_fecha_inicial,'YYYY/MM/DD')
                             ||' - '||TO_CHAR(vp_fecha_final,'YYYY/MM/DD');
       vp_sqlcode := sqlcode;
       vp_sqlerrm := sqlerrm;
       VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
   END; -- Inserta pagos por cliente desde cobranzas
--*** 2? Selecciona solo pagos que liquidan una factura (o sea que ya no estan en cartera)
   BEGIN
      vp_tabla := 'VE_TMP_PAGOSLIQCLIENTE';
      vp_accion := 'I';
      INSERT
       INTO VE_TMP_PAGOSLIQCLIENTE(COD_CLIENTE, NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                                   LETRA, COD_CENTREMI)
       SELECT TMP3.COD_CLIENTE, TMP3.NUM_SECUENCI, TMP3.COD_TIPDOCUM, TMP3.COD_VENDEDOR_AGENTE,
              TMP3.LETRA, TMP3.COD_CENTREMI
        FROM VE_TMP_PAGOSCLIENTE TMP3
        WHERE NOT EXISTS (SELECT CAR.COD_CLIENTE FROM CO_CARTERA CAR
                           WHERE TMP3.NUM_SECUENCI         = CAR.NUM_SECUENCI
                             AND TMP3.COD_TIPDOCUM         = CAR.COD_TIPDOCUM
                             AND TMP3.COD_VENDEDOR_AGENTE  = CAR.COD_VENDEDOR_AGENTE
                             AND TMP3.LETRA                = CAR.LETRA
                             AND TMP3.COD_CENTREMI         = CAR.COD_CENTREMI
                             AND ROWNUM = vp_1
                          );
      COMMIT;
   EXCEPTION
    WHEN OTHERS THEN
       vp_mensaje := '[3.5] '||TO_CHAR(vp_fecha_inicial,'YYYY/MM/DD')
                           ||' - '||TO_CHAR(vp_fecha_final,'YYYY/MM/DD');
       vp_sqlcode := sqlcode;
       vp_sqlerrm := sqlerrm;
       VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
   END; -- Selecciona solo pagos que liquidan una factura
--
OPEN C1;
-- Prepara el cursor para query dinamico
vp_cursorid := DBMS_SQL.OPEN_CURSOR;
LOOP
    FETCH C1 INTO C1_FACTURA_ABONADO;
    EXIT WHEN C1%NOTFOUND;
    IF C1_FACTURA_ABONADO.COD_VENDEDOR <> vp_cod_vendedor OR
       C1_FACTURA_ABONADO.TIP_PLANTARIF <> vp_tip_plantarif THEN  /* Si cambia vendedor o cambia tipo de plan*/
       IF vp_cod_vendedor <> 0 THEN  /* si no es el primer vendedor:           */
--
--    *** GRABAR RESULTADO DEL VENDEDOR ANTERIOR ***
--
          BEGIN
             vp_importe_total := ROUND(vp_importe_total,0);
             vp_importe_resultado := vp_importe_total * vp_imp_porcentaje / 100.0;
             vp_tabla := 'VE_RESTRAFICO';
             vp_accion := 'I';
             INSERT
              INTO VE_RESTRAFICO(TIP_PLANTARIF, NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR,
                                 COD_CTOLIQ, FEC_INILIQ, FEC_FINLIQ, FEC_LIQUIDACION,
                                 TOT_CLIENTES, TOT_ABONADOS, IMPORTE_PAGOS, IMPORTE_TRAFICO)
              VALUES(vp_tip_plantarif, vp_num_liquidacion, vp_cod_tipcomis, vp_cod_vendedor,
                     vp_cod_ctoliq, vp_fecha_inicial, vp_fecha_final, sysdate,
                     vp_tot_clientes, vp_tot_abonados, vp_importe_total, vp_importe_resultado);
          EXCEPTION WHEN OTHERS THEN
             vp_mensaje := '[5] '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR,'99999999')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_ABONADO,'99999999')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_SECUENCI,'99999999')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_TIPDOCUM,'99')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR_AGENTE,'999999')
                           ||' - '||C1_FACTURA_ABONADO.LETRA
                           ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CENTREMI,'9999');
             vp_sqlcode := sqlcode;
             vp_sqlerrm := sqlerrm;
             VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
          END; -- grabar resultado del vendedor anterior
       END IF;
--
-- *** COMIENZA PROCESO DE UN NUEVO VENDEDOR vp_cod_vendedor Y/O PLAN TARIFARIO***
--
       vp_cod_vendedor := C1_FACTURA_ABONADO.COD_VENDEDOR;
       vp_cod_tipcomis := C1_FACTURA_ABONADO.COD_TIPCOMIS;
       vp_cod_ctoliq := C1_FACTURA_ABONADO.COD_CTOLIQ;
       vp_tip_plantarif := C1_FACTURA_ABONADO.TIP_PLANTARIF;
       vp_imp_porcentaje := C1_FACTURA_ABONADO.IMP_PORCENTAJE;
       SELECT VE_SEQ_LIQTRAFICO.NEXTVAL INTO vp_num_liquidacion FROM DUAL;
       vp_cod_cliente := 0;
       vp_num_abonado := 0;
       vp_tot_clientes := 0;
       vp_tot_abonados := 0;
       vp_importe_total := 0;
    END IF;
--
-- *** PROCESO POR CADA FACTURA DEL PAR CLIENTE - ABONADO ***
--
-- 1? Acceso a cabecera de la factura
    BEGIN
       vp_tabla := 'FA_HISTDOCU';
       vp_accion := 'S';
       SELECT COD_CICLFACT, IND_ORDENTOTAL, IND_PASOCOBRO, IND_ANULADA, NUM_FOLIO
        INTO vp_cod_ciclfact, vp_ind_ordentotal, vp_ind_pasocobro, vp_ind_anulada, vp_num_folio
        FROM FA_HISTDOCU
        WHERE COD_CENTREMI  = C1_FACTURA_ABONADO.COD_CENTREMI
          AND LETRA         = C1_FACTURA_ABONADO.LETRA
          AND COD_VENDEDOR_AGENTE = C1_FACTURA_ABONADO.COD_VENDEDOR_AGENTE
          AND COD_TIPDOCUM  = C1_FACTURA_ABONADO.COD_TIPDOCUM
          AND NUM_SECUENCI  = C1_FACTURA_ABONADO.NUM_SECUENCI;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       vp_mensaje := '[6] '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_ABONADO,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_SECUENCI,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_TIPDOCUM,'99')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR_AGENTE,'999999')
                    ||' - '||C1_FACTURA_ABONADO.LETRA
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CENTREMI,'9999');
       vp_ind_pasocobro := vp_0;
       vp_ind_anulada   := vp_1;
       vp_num_folio     := vp_1;
       vp_sqlcode := sqlcode;
       vp_sqlerrm := sqlerrm;
       VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
    END; -- Acceso a cabecera de la factura
-- 2? Procesa la factura solo si cumple las condiciones que la hacen valida y legal
    IF vp_ind_pasocobro = vp_1 AND vp_ind_anulada = vp_0 AND vp_num_folio <> vp_0 THEN
--     Determina tabla detalle y construye y ejecuta el query dinamico
       BEGIN
          vp_tabla := 'FA_ENLACEHIST';
          vp_accion := 'S';
          SELECT FA_HISTCONC
           INTO vp_tabla_detalle
           FROM FA_ENLACEHIST
           WHERE COD_CICLFACT = vp_cod_ciclfact;
--    Construye query dinamico: suma conceptos de trafico de la factura para el abonado
          vp_select := 'SELECT NVL(SUM(DET.IMP_FACTURABLE),0) ';
          vp_select := vp_select||'FROM VE_FACCTO FAC, '||vp_tabla_detalle||' DET ';
          vp_select := vp_select||'WHERE FAC.COD_CTOFAC = :var1 ';
          vp_select := vp_select||'AND FAC.COD_CONCEPTO = DET.COD_CONCEPTO ';
          vp_select := vp_select||'AND DET.NUM_ABONADO = :var2 ';
          vp_select := vp_select||'AND DET.IND_ORDENTOTAL = :var3';
          DBMS_SQL.PARSE(vp_cursorid, vp_select, DBMS_SQL.V7);
          DBMS_SQL.DEFINE_COLUMN(vp_cursorid, 1, vp_importe_trafico);
          DBMS_SQL.BIND_VARIABLE(vp_cursorid, 'var1', vp_1);
          DBMS_SQL.BIND_VARIABLE(vp_cursorid, 'var2', C1_FACTURA_ABONADO.NUM_ABONADO);
          DBMS_SQL.BIND_VARIABLE(vp_cursorid, 'var3', vp_ind_ordentotal);
--    Ejecuta query dinamico
          vp_tabla := vp_tabla_detalle;
          vp_accion := 'S';
          vp_nada := DBMS_SQL.EXECUTE(vp_cursorid);
--    Recupera la columna de la fila del cursor
          IF DBMS_SQL.FETCH_ROWS(vp_cursorid) > 0 THEN
             DBMS_SQL.COLUMN_VALUE(vp_cursorid, 1, vp_importe_trafico);
          ELSE
             vp_importe_trafico := 0;
          END IF;
--    Se suma el monto facturado por trafico al total del vendedor (caso planes individuales incluye cargo basico)
          vp_importe_total := vp_importe_total + vp_importe_trafico;
--
          IF C1_FACTURA_ABONADO.TIP_PLANTARIF = vp_E THEN
--    Construye query dinamico: obtiene concepto cargo basico PARA PLANES EMPRESA (abonado 0)
             vp_select := 'SELECT NVL(DET.IMP_FACTURABLE,0) ';
             vp_select := vp_select||'FROM '||vp_tabla_detalle||' DET ';
             vp_select := vp_select||'WHERE DET.COD_CONCEPTO  = 25 ';
             vp_select := vp_select||'AND DET.NUM_ABONADO = 0 ';
             vp_select := vp_select||'AND DET.IND_ORDENTOTAL = :var3';
             DBMS_SQL.PARSE(vp_cursorid, vp_select, DBMS_SQL.V7);
             DBMS_SQL.DEFINE_COLUMN(vp_cursorid, 1, vp_imp_cargo_basico);
             DBMS_SQL.BIND_VARIABLE(vp_cursorid, 'var3', vp_ind_ordentotal);
--    Ejecuta query dinamico
             vp_tabla := vp_tabla_detalle;
             vp_accion := 'S';
             vp_nada := DBMS_SQL.EXECUTE(vp_cursorid);
--    Recupera la columna de la fila del cursor
             IF DBMS_SQL.FETCH_ROWS(vp_cursorid) > 0 THEN
                DBMS_SQL.COLUMN_VALUE(vp_cursorid, 1, vp_imp_cargo_basico);
--    Suma el cargo basico de planes empresa, prorrateado c/r al total de abonados del plan
                vp_importe_total := vp_importe_total + (vp_imp_cargo_basico/C1_FACTURA_ABONADO.NUM_ABONADOS_PLAN);
             END IF;
          END IF;
--    Se suma cada cliente del vendedor
          IF C1_FACTURA_ABONADO.COD_CLIENTE <> vp_cod_cliente THEN
             vp_tot_clientes := vp_tot_clientes + 1;
             vp_cod_cliente := C1_FACTURA_ABONADO.COD_CLIENTE;
          END IF;
--    Se suma cada abonado del vendedor
          IF C1_FACTURA_ABONADO.NUM_ABONADO <> vp_num_abonado THEN
             vp_tot_abonados := vp_tot_abonados + 1;
             vp_num_abonado := C1_FACTURA_ABONADO.NUM_ABONADO;
          END IF;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          vp_mensaje := '[7] '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR,'99999999')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_ABONADO,'99999999')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_SECUENCI,'99999999')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_TIPDOCUM,'99')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR_AGENTE,'999999')
                       ||' - '||C1_FACTURA_ABONADO.LETRA
                       ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CENTREMI,'9999');
          vp_sqlcode := sqlcode;
          vp_sqlerrm := sqlerrm;
          VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
       END; -- Determina tabla detalle y construye y ejecuta el query dinamico
    END IF;
END LOOP;
--
-- *** SE GRABA EL ULTIMO RESULTADO ***
--
IF vp_cod_vendedor <> 0 THEN /* Si al menos se proceso un vendedor:            */
                             /* grabar resultado del ultimo vendedor procesado */
   BEGIN
      vp_importe_total := ROUND(vp_importe_total,0);
      vp_importe_resultado := vp_importe_total * vp_imp_porcentaje / 100.0;
      vp_tabla := 'VE_RESTRAFICO';
      vp_accion := 'I';
      INSERT
       INTO VE_RESTRAFICO(TIP_PLANTARIF, NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR,
                          COD_CTOLIQ, FEC_INILIQ, FEC_FINLIQ, FEC_LIQUIDACION,
                          TOT_CLIENTES, TOT_ABONADOS, IMPORTE_PAGOS, IMPORTE_TRAFICO)
       VALUES(vp_tip_plantarif, vp_num_liquidacion, vp_cod_tipcomis, vp_cod_vendedor,
              vp_cod_ctoliq, vp_fecha_inicial, vp_fecha_final, sysdate,
              vp_tot_clientes, vp_tot_abonados, vp_importe_total, vp_importe_resultado);
   EXCEPTION WHEN OTHERS THEN
      vp_mensaje := '[8] '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_ABONADO,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.NUM_SECUENCI,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_TIPDOCUM,'99')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CLIENTE,'99999999')
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_VENDEDOR_AGENTE,'999999')
                    ||' - '||C1_FACTURA_ABONADO.LETRA
                    ||' - '||TO_CHAR(C1_FACTURA_ABONADO.COD_CENTREMI,'9999');
      vp_sqlcode := sqlcode;
      vp_sqlerrm := sqlerrm;
      VE_P2_insanomliqtra(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
      DBMS_SQL.CLOSE_CURSOR(vp_cursorid);
   END;
END IF;
-- Cierra cursores
DBMS_SQL.CLOSE_CURSOR(vp_cursorid);
CLOSE C1;
--
COMMIT;
--
END VE_P2_LIQUIDA_TRAFICO;
/
SHOW ERRORS
