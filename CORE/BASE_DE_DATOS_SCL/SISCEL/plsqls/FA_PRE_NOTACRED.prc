CREATE OR REPLACE PROCEDURE          "FA_PRE_NOTACRED" (vp_secuencia_ga    IN VARCHAR2,
 											vp_ind_ordentotal  IN VARCHAR2,
 											vp_tipo_tabla      IN VARCHAR2,
 											vp_cod_cliente     IN VARCHAR2,
 											vp_num_proceso     IN VARCHAR2)
IS
oficina         	VARCHAR2(2);
vendedor            NUMBER(6);
snumseq             NUMBER(12);
Lnumseq             NUMBER(12);
lseqnue             NUMBER(12);
vp_letra            GE_LETRAS.LETRA%TYPE;
cantidad            NUMBER(12);
producto            NUMBER(2);
vp_ordentotal       NUMBER(12);
vp_des_cadena       VARCHAR2(255);
vp_error            NUMBER(2);
usuario             VARCHAR2(30);
gls_error           VARCHAR2(100);
fecha               VARCHAR(10);
sFecInicio          VARCHAR(10);
sFecFin             VARCHAR(10);
VP_SQLCODE          VARCHAR2(5);
VP_SQLERRM          VARCHAR2(50);
cod_concepto        FA_CONCEPTOS.COD_CONCEPTO%TYPE;
fec_emision         VARCHAR(10);
vp_cod_catimpos     GE_DATOSGENER.COD_CATIMPOS%TYPE;
 --GE_LETRAS.COD_CATIMPOS%TYPE;
cod_tipdocum        FA_HISTDOCU.COD_TIPDOCUM%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra              FA_HISTDOCU.LETRA%TYPE;
scentremi           FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci           FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio        FA_HISTDOCU.NUM_FOLIO%TYPE;
Acum_netograv       FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv     FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva            FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom         FA_HISTDOCU.COD_PLANCOM%TYPE;
vp_imp_maximo       FA_CONTROLNC.imp_maximo%TYPE;
centremi            NUMBER(4);
srowid              VARCHAR(18);
vp_num_dias         FA_CONTROLNC.num_dias%TYPE;
stotaplicado        NUMBER(14,4);
stotal1             NUMBER(14,4);
ind_supertel        FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo            FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla            VARCHAR2(20);
ins_ajuste          VARCHAR2(2000);
cursor_name         NUMBER;
rows_processed      INTEGER;
abrir               NUMBER;
moneda              VARCHAR2(3);
ERROR_PROCESO EXCEPTION;
BEGIN
          vp_error := 0;
          moneda := FA_FN_CODMONFACT;
          abrir := 0;
          usuario := '';
          gls_error := '';
        IF vp_ind_ordentotal IS NULL OR vp_ind_ordentotal = '' THEN
                vp_error := 1;
                gls_error := 'Error. Falta ingresar Ind.Ordentotal en parametros de entrada.';
                RAISE ERROR_PROCESO;
        END IF;
        IF vp_tipo_tabla IS NULL OR vp_tipo_tabla = '' THEN
                vp_error := 1;
                gls_error := 'Error. Falta ingresar Tipo Tabla en parametros de entrada.';
                RAISE ERROR_PROCESO;
        END IF;
        IF vp_cod_cliente IS NULL OR vp_cod_cliente = '' THEN
                vp_error := 1;
                gls_error := 'Error. Falta ingresar Cliente en parametros de entrada.';
                RAISE ERROR_PROCESO;
        END IF;
        vp_ordentotal := TO_NUMBER(vp_ind_ordentotal);
------- bGetAgenteNOT
        IF vp_tipo_tabla = 'H' THEN
                SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                       COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                       ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT
                INTO   fec_emision, vp_cod_catimpos, cod_tipdocum, cod_vendedor_agente, sletra,
                       scentremi, ssecuenci, vp_num_folio, acum_netograv,
                       acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo
                FROM   FA_HISTDOCU
                WHERE  IND_ORDENTOTAL = vp_ordentotal;
                SELECT FA_HISTCONC INTO vp_tabla
                FROM   FA_ENLACEHIST
                WHERE  COD_CICLFACT = vp_ciclo;
        ELSE
                SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                       COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                       ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT
                INTO   fec_emision, vp_cod_catimpos, cod_tipdocum, cod_vendedor_agente, sletra,
                       scentremi, ssecuenci, vp_num_folio, acum_netograv,
                       acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo
                FROM   FA_FACTDOCU_NOCICLO
                WHERE  IND_ORDENTOTAL = vp_ordentotal;
        END IF;
         IF vp_num_folio <= 0  THEN
                     vp_error := 2;
                gls_error := 'Error. Documento no tiene asociado nzm.folio.';
                RAISE ERROR_PROCESO;
        END IF;
------- bValnotaCred
        SELECT COUNT(NUM_FOLIO) INTO cantidad
        FROM   FA_AJUSTES
        WHERE  NUM_FOLIO = vp_num_folio
        AND    COD_CLIENTE = vp_cod_cliente
        AND    ACUM_NETOGRAVNC > 0;
        IF cantidad != 0 THEN
                     vp_error := 6;
                gls_error := 'Error. Factura Ya tiene notas de cridito anteriores.';
                RAISE ERROR_PROCESO;
        END IF;
        SELECT  COUNT(*) INTO cantidad
        FROM    FA_INTERVENTA
        WHERE   num_folio = vp_num_folio AND
                cod_tipdocum = 25         AND
                TO_NUMBER(COD_ESTADO) < 2;
        IF cantidad > 0 THEN
                     vp_error := 3;
                gls_error := 'Error. Documento tiene pendiente la emisisn de Nota de Cridito.';
                RAISE ERROR_PROCESO;
        END IF;
        IF (ind_Supertel = '1') AND (cod_tipdocum = '2') THEN
                     vp_error := 4;
                gls_error := 'Error. Factura Corresponde a Supertelefono, No es posible generar Nota de Credito';
                RAISE ERROR_PROCESO;
        END IF;
        IF cod_vendedor_agente IS NULL THEN
                     vp_error := 5;
                gls_error := 'Error. Documento no tiene asociado un vendedor.';
                RAISE ERROR_PROCESO;
        END IF;
------- bSQLInsertAjuste
        SELECT COUNT(*) INTO cantidad
        FROM   FA_AJUSTES
        WHERE  NUM_FOLIO = vp_num_folio
        AND    COD_CLIENTE = vp_cod_cliente;
        IF cantidad <= 0 THEN
                INSERT INTO FA_AJUSTES
                (NUM_FOLIO         ,
                ACUM_NETONOGRAVORIG,
                 ACUM_NETONOGRAVNC  ,
                 ACUM_NETONOGRAVND ,
                 ACUM_NETOGRAVORIG,
                ACUM_NETOGRAVNC  ,
                 ACUM_NETOGRAVND  ,
                 COD_PLANCOM      ,
                 COD_CATIMPOS     ,
                 ACUM_IVAORIG     ,
                 ACUM_IVANC       ,
                 ACUM_IVAND       ,
                 COD_CLIENTE        )
                VALUES
                (vp_num_folio,
                 acum_netograv,
                 0,
                 0,
                 acum_netonograv,
                 0,
                 0,
                 cod_plancom,
                 vp_cod_catimpos,
                  acum_iva,
                  0,
                  0,
                  vp_cod_cliente);
--------------- bSQLInsertConc
                IF vp_tipo_tabla = 'N' THEN
                        INSERT INTO FA_AJUSTECONC
                        (NUM_FOLIO, COD_CONCEPTO, COLUMNA,
                        COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA,
                        IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
                        COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR,
                        IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
                        DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE,
                        MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION,
                        FLAG_IMPUES, FLAG_DTO, COD_CLIENTE)
                        SELECT vp_num_folio, a.COD_CONCEPTO,
                        a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, a.IMP_CONCEPTO ,moneda,
                        a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA,
                        a.COD_CIUDAD, b.COD_MODULO,
                        a.NUM_UNIDADES, a.NUM_SERIEMEC,
                        a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE,
                        a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR,
                        a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA,
                        a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA,
                        a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES,
                        a.FLAG_DTO, c.COD_CLIENTE
                        FROM  FA_CONCEPTOS         b,
                              FA_FACTDOCU_NOCICLO  c,
                              FA_FACTCONC_NOCICLO  a
                        WHERE a.IND_ORDENTOTAL =  vp_ordentotal AND
                              a.COD_CONCEPTO   =  b.COD_CONCEPTO   AND
                              a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL AND
                              a.COD_TIPCONCE   <> 1                AND
                              a.COD_TIPCONCE   <> 2;
                        UPDATE FA_AJUSTECONC A
                        SET    IMP_FACTURABLE = (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE
                                                   FROM FA_FACTCONC_NOCICLO B
                                                  WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                                    AND B.COD_TIPCONCE = 2
                                                    AND A.COD_CONCEPTO = B.COD_CONCEREL
                                                    AND A.COLUMNA = B.COLUMNA_REL),
                        	   IMP_CONCEPTO = (SELECT A.IMP_CONCEPTO + B.IMP_CONCEPTO
                                                   FROM FA_FACTCONC_NOCICLO B
                                                  WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                                    AND B.COD_TIPCONCE = 2
                                                    AND A.COD_CONCEPTO = B.COD_CONCEREL
                                                    AND A.COLUMNA = B.COLUMNA_REL)
                        WHERE  A.NUM_FOLIO = vp_num_folio
                          AND  A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL
                                                    FROM FA_FACTCONC_NOCICLO B
                                                   WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                                     AND B.COD_TIPCONCE = 2
                                                     AND A.COD_CONCEPTO = B.COD_CONCEREL
                                                     AND A.COLUMNA = B.COLUMNA_REL);
                ELSE
                        ins_ajuste := 'INSERT INTO FA_AJUSTECONC ';
                        ins_ajuste := ins_ajuste || '(NUM_FOLIO, COD_CONCEPTO, COLUMNA, ';
                        ins_ajuste := ins_ajuste || 'COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA, ';
                        ins_ajuste := ins_ajuste || 'IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD, ';
                        ins_ajuste := ins_ajuste || 'COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR, ';
                        ins_ajuste := ins_ajuste || 'IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR, ';
                        ins_ajuste := ins_ajuste || 'DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE, ';
                        ins_ajuste := ins_ajuste || 'MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION, ';
                        ins_ajuste := ins_ajuste || 'FLAG_IMPUES, FLAG_DTO, COD_CLIENTE) ';
                        ins_ajuste := ins_ajuste || 'SELECT c.num_folio, a.COD_CONCEPTO, ';
                        ins_ajuste := ins_ajuste || 'a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, a.IMP_CONCEPTO, ' || RTRIM(moneda) || ', ';
                        ins_ajuste := ins_ajuste || 'a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA, ';
                        ins_ajuste := ins_ajuste || 'a.COD_CIUDAD, b.COD_MODULO, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_UNIDADES, a.NUM_SERIEMEC, ';
                        ins_ajuste := ins_ajuste || 'a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE, ';
                        ins_ajuste := ins_ajuste || 'a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR, ';
                        ins_ajuste := ins_ajuste || 'a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES, ';
                        ins_ajuste := ins_ajuste || 'a.FLAG_DTO, c.COD_CLIENTE ';
                        ins_ajuste := ins_ajuste || 'FROM  FA_CONCEPTOS         b, ';
                        ins_ajuste := ins_ajuste || '      FA_HISTDOCU          c, ';
                        ins_ajuste := ins_ajuste || '     ' || RTRIM(vp_tabla) || ' a  ';
                        ins_ajuste := ins_ajuste || 'WHERE a.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_CONCEPTO   =  b.COD_CONCEPTO     AND ';
                        ins_ajuste := ins_ajuste || '      a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL   AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 1                  AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 2                      ';
                        cursor_name := dbms_sql.open_cursor;
                        dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
                        rows_processed := dbms_sql.EXECUTE(cursor_name);
                        dbms_sql.close_cursor(cursor_name);
                        ins_ajuste := '';
                        ins_ajuste := 'UPDATE FA_AJUSTECONC A ';
                        ins_ajuste := ins_ajuste || 'SET    IMP_FACTURABLE =  (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE ';
                        ins_ajuste := ins_ajuste || '                          FROM   ' || RTRIM(vp_tabla) || ' B ';
                        ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
                        ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2                   AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL), ';
                        ins_ajuste := ins_ajuste || '		IMP_CONCEPTO =  (SELECT A.IMP_CONCEPTO + B.IMP_CONCEPTO ';
                        ins_ajuste := ins_ajuste || '                          FROM   ' || RTRIM(vp_tabla) || ' B ';
                        ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
                        ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2                   AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
                        ins_ajuste := ins_ajuste || 'WHERE  A.NUM_FOLIO = ' || RTRIM(TO_CHAR(vp_num_folio)) || ' AND ';
                        ins_ajuste := ins_ajuste || '       A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL ';
                        ins_ajuste := ins_ajuste || '                          FROM   ' || RTRIM(vp_tabla) || ' B ';
                        ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
                        ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2                   AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
                        ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
                        cursor_name := dbms_sql.open_cursor;
                        dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
                        rows_processed := dbms_sql.EXECUTE(cursor_name);
                        dbms_sql.close_cursor(cursor_name);
                END IF;
        END IF;
------- sSecuenciaEmi
        SELECT FA_SEQ_CREDITO.NEXTVAL INTO snumseq
        FROM   DUAL;
        snumseq := snumseq + 1;
        SELECT USER, RTRIM(TO_CHAR(SYSDATE, 'dd-mm-yyyy')) INTO usuario, fecha
        FROM   DUAL;
        SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina
        FROM   GE_SEG_USUARIO
        WHERE  NOM_USUARIO = usuario;
        IF vendedor = -1 OR oficina = ' ' THEN
               SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina
               FROM   GE_DATOSGENER;
               IF vendedor = ' ' OR oficina = ' ' THEN
                            vp_error := 9;
                        gls_error := 'Error. No existe vendedor.';
                        RAISE ERROR_PROCESO;
               END IF;
        END IF;
        SELECT COD_CENTREMI INTO centremi
        FROM   AL_DOCUM_SUCURSAL
        WHERE  COD_TIPDOCUM = 25 AND
               COD_OFICINA = oficina;
------- bGetLetraAG
        SELECT LETRA INTO vp_letra
        FROM   GE_LETRAS
        WHERE  COD_CATIMPOS = vp_cod_catimpos
        AND    COD_TIPDOCUM = 25;
        IF vp_letra = ' ' THEN
                     vp_error := 7;
                gls_error := 'Error. Categorma impositiva no tiene asociada Letra (GE_LETRAS).';
                RAISE ERROR_PROCESO;
        END IF;
--- bInsertProceso
        INSERT INTO FA_PROCESOS(NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                                COD_CENTREMI, FEC_EFECTIVIDAD, NOM_USUARORA,
                                LETRAAG, NUM_SECUAG, COD_TIPDOCNOT, COD_VENDEDOR_AGENTENOT,
                                LETRANOT, COD_CENTRNOT, NUM_SECUNOT, IND_ESTADO, COD_CICLFACT, IND_NOTACREDC)
        VALUES (TO_NUMBER(vp_num_proceso), 25, vendedor,
                centremi, fec_emision, usuario,
                vp_letra, snumseq, cod_tipdocum, cod_vendedor_agente,
                sletra, scentremi, ssecuenci, NULL, NULL, 0
                );
------- bUpdConc_tot
        UPDATE  FA_AJUSTECONC
        SET     IMP_CONCEPTO = IMP_FACTURABLE
        WHERE   NUM_FOLIO    = vp_Num_Folio AND
                COD_CLIENTE  = TO_NUMBER(vp_cod_cliente);
------- bInsertPrefactura
        INSERT INTO FA_PREFACTURA
        (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO, COLUMNA,
        COD_PRODUCTO, COD_MONEDA, FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
        IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
        COD_MODULO, COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,
        COD_TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,
        NUM_TERMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,NUM_VENTA,
        NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPERTEL,NUM_PAQUETE,IND_CUOTA,
        NUM_CUOTAS, ORD_CUOTA)
        SELECT TO_NUMBER(vp_num_proceso),  TO_NUMBER(vp_cod_cliente), a.COD_CONCEPTO, a.COLUMNA, a.COD_PRODUCTO,
                moneda,a.FEC_VALOR, a.FEC_EFECTIVIDAD,
                 a.IMP_CONCEPTO, a.IMP_FACTURABLE, 0, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD,
                 a.COD_MODULO, b.COD_PLANCOM, a.IND_FACTUR, b.COD_CATIMPOS, a.COD_PORTADOR,
                 0, a.COD_TIPCONCE, 1, NULL, NULL, NULL, a.NUM_ABONADO, NULL, NULL,
                 a.NUM_SERIEMEC, a.NUM_SERIELE, a.FLAG_IMPUES, a.FLAG_DTO, a.NUM_VENTA,
                 a.NUM_TRANSACCION, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.IND_SUPERTEL,
                a.NUM_PAQUETE, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA
        FROM    FA_AJUSTECONC a, FA_AJUSTES b
        WHERE   a.NUM_FOLIO = vp_num_folio     AND
                a.COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
                 a.NUM_FOLIO = b.NUM_FOLIO   AND
        a.COD_CLIENTE = b.COD_CLIENTE;
------- bControlPeriodo
        vp_imp_maximo := 0;
        vp_num_dias := 0;
        SELECT  IMP_MAXIMO, NUM_DIAS
                INTO vp_imp_maximo, vp_num_dias
        FROM    FA_CONTROLNC
        WHERE   NOM_USUARIO = usuario AND
                FEC_DESDE <= SYSDATE  AND
                FEC_HASTA >= SYSDATE;
        SELECT COUNT(*) INTO CANTIDAD
        FROM    fa_aplicadonc
        WHERE   NOM_USUARIO = usuario  AND
                COD_CLIENTE = TO_NUMBER(vp_cod_cliente)  AND
                FEC_INICIO <= SYSDATE      AND
                FEC_FIN >= SYSDATE;
        IF CANTIDAD <= 0 THEN
--------------- bInsertAplicadoNC
                INSERT INTO FA_APLICADONC(NOM_USUARIO, COD_CLIENTE, FEC_INICIO, FEC_FIN, TOT_APLICADO)
                VALUES ( usuario, TO_NUMBER(vp_cod_cliente),
                         TO_DATE(TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                         TO_DATE(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MONTH')-1/86400, 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                         acum_netograv
                        );
        ELSE
                SELECT  ROWID, TOT_APLICADO, TO_CHAR(FEC_INICIO, 'DD/MM/YYYY'), TO_CHAR(FEC_FIN, 'DD/MM/YYYY')
                        INTO srowid, sTotAplicado, sFecInicio, sFecFin
                FROM    FA_APLICADONC
                WHERE   NOM_USUARIO = usuario  AND
                        COD_CLIENTE = TO_NUMBER(vp_cod_cliente)  AND
                        FEC_INICIO <= SYSDATE      AND
                        FEC_FIN >= SYSDATE;
                stotal1 := acum_netograv + sTotAplicado;
                IF stotal1 <= vp_imp_maximo THEN
                        UPDATE FA_APLICADONC
                        SET    TOT_APLICADO = TOT_APLICADO + acum_netograv
                        WHERE  ROWID = sRowid;
                ELSE
                            vp_error := 8;
                        gls_error := 'Error. Se ha sobrepasado el Lmmite Importe para el Usuario.';
                        RAISE ERROR_PROCESO;
                END IF;
        END IF;
        lSeqNue := sNumSeq + 1;
------- bUpdSecuencia
        UPDATE  GE_SECUENCIASEMI
        SET     NUM_SECUENCI = lSeqNue
        WHERE   COD_TIPDOCUM = 25       AND
                COD_CENTREMI = centremi AND
                LETRA = vp_letra; -- GE_LETRAS
        INSERT INTO FA_INTERVENTA
        ( NUM_PROCESO, NUM_VENTA, COD_ESTADO, COD_ESTPROC,
          COD_TIPDOCUM, NUM_FOLIO, IND_GENERACION,IND_IMPRESION, IND_EJECUCION,
          FEC_PROCESO, FEC_ESTADO, NOM_USUARIO )
        VALUES
        ( TO_NUMBER(vp_num_proceso), 0, '1', '0', '25', vp_num_folio, '1', '1', '0',
          SYSDATE, SYSDATE , usuario );
--        UPDATE sp_notasc
--        SET    procesado = '1'
--        WHERE  cod_cliente = vp_cod_cliente and
--               ind_ordentotal = vp_ordentotal;
--
         RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           IF vp_error != 0 THEN
                ROLLBACK;
           END IF;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 10, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 11, 'Datos No Fueron Encontrados');
      WHEN OTHERS THEN
           ROLLBACK;
                 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 12, 'Otros Errores No Esperados');
END FA_PRE_NOTACRED;
/
SHOW ERRORS
