CREATE OR REPLACE FUNCTION FA_REGENERA_FACTURA_FN(vp_ind_ordentotal  IN VARCHAR2)
RETURN VARCHAR2
IS
PRAGMA AUTONOMOUS_TRANSACTION;
oficina             VARCHAR2(2);
secuencia_ga        NUMBER;
vendedor            NUMBER(6);
snumseq             NUMBER(12);
lseqnue             NUMBER(12);
vp_letra            GE_LETRAS.LETRA%TYPE;
cantidad            NUMBER(12);
vp_ordentotal       NUMBER(12);
vp_cod_modgener     VARCHAR2(3);
vp_cod_tipmovimien  NUMBER(2);
vp_error            NUMBER(2);
usuario             VARCHAR2(30);
gls_error           VARCHAR2(250);
fecha               VARCHAR(10);
fec_emision         VARCHAR(10);
vp_cod_catimpos     GE_DATOSGENER.COD_CATIMPOS%TYPE;
vp_cod_tipdocum     FA_HISTDOCU.COD_TIPDOCUM%TYPE;
vp_cod_cliente      FA_HISTDOCU.COD_CLIENTE%TYPE;
vp_categoria_trib   GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
vp_cod_modventa     FA_HISTDOCU.COD_MODVENTA%TYPE;
vp_num_proceso      FA_PROCESOS.NUM_PROCESO%TYPE;
vp_secuencia_ga     GA_TRANSACABO.NUM_TRANSACCION%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra              FA_HISTDOCU.LETRA%TYPE;
scentremi           FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci           FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio        FA_HISTDOCU.NUM_FOLIO%TYPE;
vp_pref_plaza       FA_HISTDOCU.PREF_PLAZA%TYPE;
vp_tip_foliacion    VARCHAR2(1);
Acum_netograv       FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv     FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva            FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom         FA_HISTDOCU.COD_PLANCOM%TYPE;
centremi            NUMBER(4);
ind_supertel        FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo            FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla            VARCHAR2(20);
moneda              VARCHAR2(3);
cod_retorno         NUMBER;
des_cadena          VARCHAR2(255);
vp_entrada          VARCHAR2(1);
vp_cantidad         NUMBER(4);
AcumNetoGravOrig    NUMBER(14,4);
AcumNetoNoGravOrig  NUMBER(14,4);
AcumIvaOrig         NUMBER(14,4);
AcumNetoGravNC      NUMBER(14,4);
AcumNetoNoGravNC    NUMBER(14,4);
AcumIvaNC           NUMBER(14,4);
TotalFacturaOrig    NUMBER(14,4);
TotalNCredito       NUMBER(14,4);
sFormatoFecha       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
ERROR_PROCESO EXCEPTION;
-- errores de variables IN vp_error := 1;
-- errores de select vp_error := 2;
-- errores de insert vp_error := 3;
-- errores de update vp_error := 4;
-- el ultimo fue Msj20,
BEGIN
     vp_error := 0;
     moneda := FA_FN_CODMONFACT;
     usuario := '';
     gls_error := gls_error||'Termino Ok';
     -- Obtiene nro de proceso y secuencia_ga --
     SELECT FA_SEQ_NUMPRO.NEXTVAL INTO vp_num_proceso
     FROM   DUAL;
     SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO vp_secuencia_ga
     FROM   DUAL;
     IF vp_ind_ordentotal IS NULL OR vp_ind_ordentotal = '' THEN
        vp_error := 1;
        gls_error := 'Error. Falta ingresar Ind.Ordentotal en parametros de entrada.';
        RAISE ERROR_PROCESO;
     END IF;
     vp_ordentotal := TO_NUMBER(vp_ind_ordentotal);
     -- recupera datos de la factura --
     BEGIN
          SELECT COD_CLIENTE, COD_MODVENTA, FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA,
                 COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                 ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, PREF_PLAZA
          INTO   vp_cod_cliente, vp_cod_modventa, fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
                 scentremi, ssecuenci, vp_num_folio, acum_netograv,
                 acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo, vp_pref_plaza
          FROM   FA_HISTDOCU
          WHERE  IND_ORDENTOTAL = vp_ordentotal;
     EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   BEGIN
                        SELECT COD_CLIENTE, COD_MODVENTA, FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                               COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                               ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, PREF_PLAZA
                        INTO   vp_cod_cliente, vp_cod_modventa, fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
                               scentremi, ssecuenci, vp_num_folio, acum_netograv,
                               acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo, vp_pref_plaza
                        FROM   FA_FACTDOCU_NOCICLO
                        WHERE  IND_ORDENTOTAL = vp_ordentotal;
                        EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                      vp_error := 2;
                                      gls_error := 'Error. No encontro datos en tabla FA_FACTDOCU_NOCICLO Msj1';
                                      RAISE ERROR_PROCESO;
                   END;
     END;
     -- recupera categoria tributaria del cliente --
     BEGIN
          SELECT COD_CATRIBUT
          INTO vp_categoria_trib
          FROM GA_CATRIBUTCLIE
          WHERE COD_CLIENTE = vp_cod_cliente;
                EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              vp_error := 2;
                              gls_error := 'Error. No se pudo obtener la categoria tributarma del cliente Msj2';
                              RAISE ERROR_PROCESO;
     END;
     --validar si se hizo la nota de credito por el total de la factura --
     BEGIN
          SELECT acum_netogravorig, acum_netonogravorig, acum_ivaorig,
                 acum_netogravnc, acum_netonogravnc, acum_ivanc
          INTO AcumNetoGravOrig, AcumNetoNoGravOrig, AcumIvaOrig,
               AcumNetoGravNC, AcumNetoNoGravNC, AcumIvaNC
          FROM fa_ajustes
          WHERE num_folio = vp_num_folio
          AND pref_plaza = vp_pref_plaza
          AND cod_cliente = vp_cod_cliente
          AND cod_tipdocum = vp_cod_tipdocum;
     EXCEPTION
          WHEN NO_DATA_FOUND THEN
               -- Inicio modificacion by SAQL/Soporte 03/01/2005 - RA-200512290457
               -- vp_error := 2;
               -- gls_error := 'Error. No existe Nota de Cridito por el total del documento Msj3';
               -- RAISE ERROR_PROCESO;
               AcumNetoGravOrig := 0;
               AcumNetoNoGravOrig := 0;
               AcumIvaOrig := 0;
               AcumNetoGravNC := 0;
               AcumNetoNoGravNC := 0;
               AcumIvaNC := 0;
               -- Fin modificacion by SAQL/Soporte 03/01/2005 - RA-200512290457
     END;
     TotalFacturaOrig := AcumNetoGravOrig + AcumNetoNoGravOrig + AcumIvaOrig;
     TotalNCredito :=  AcumNetoGravNC + AcumNetoNoGravNC + AcumIvaNC;
     -- Inicio modificacion by SAQL/Soporte 03/01/2005 - RA-200512290457
     -- IF TotalFacturaOrig <> TotalNcredito then
        -- vp_error := 5;
        -- gls_error := 'Error. No se ha generado Nota de Cridito por el total del documento Msj4';
        -- RAISE ERROR_PROCESO;
     -- END IF;
     -- Fin modificacion by SAQL/Soporte 03/01/2005 - RA-200512290457
     SELECT  COUNT(*) INTO cantidad
     FROM    FA_INTERFACT
     WHERE   num_foliorel = vp_num_folio AND
             pref_plazarel = vp_pref_plaza  AND
             cod_tipmovimien = 25        AND
             cod_estadoc < 200;
     IF cantidad > 0 THEN
        vp_error := 5;
        gls_error := 'Error. Documento tiene pendiente la emisisn de Nota de Cridito Msj5';
        RAISE ERROR_PROCESO;
     END IF;
     IF vp_num_folio <= 0  THEN
        vp_error := 5;
        gls_error := 'Error. Documento no tiene asociado nzm.folio Msj6';
        RAISE ERROR_PROCESO;
     END IF;
     IF vp_pref_plaza = ''  THEN
        vp_error := 5;
        gls_error := 'Error. Documento no tiene asociado prefijo de plaza Msj7';
        RAISE ERROR_PROCESO;
     END IF;
     IF cod_vendedor_agente IS NULL THEN
        vp_error := 5;
        gls_error := 'Error. Documento no tiene asociado un vendedor Msj8';
        RAISE ERROR_PROCESO;
     END IF;
     -- sSecuenciaEmi --
     SELECT FA_SEQ_MISCELANEA.NEXTVAL INTO snumseq
     FROM   DUAL;
     snumseq := snumseq + 1;
     sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
     BEGIN
          SELECT USER, RTRIM(TO_CHAR(SYSDATE, sFormatofecha)) INTO usuario, fecha
          FROM   DUAL;
          EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        vp_error := 2;
                        gls_error := 'Error.No se puede obtener la fecha actual Msj9';
                        RAISE ERROR_PROCESO;
     END;
     BEGIN
          SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina
          FROM   GE_SEG_USUARIO
          WHERE  NOM_USUARIO = usuario;
     EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   vp_error := 2;
                   gls_error := 'Error. No se pudo obtener el codigo del vendedor y la oficina Msj10';
     END;
     IF vendedor = -1 OR oficina = ' ' THEN
        SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina
        FROM   GE_DATOSGENER;
        IF vendedor = -1 OR oficina = ' ' THEN
           vp_error := 5;
           gls_error := 'Error.El vendedor no existe en tabla de seguridad de usuarios Msj11';
           RAISE ERROR_PROCESO;
        END IF;
     END IF;
     -- bGetLetraAG --
     vp_letra:=sletra;
     --BEGIN
     --     SELECT LETRA INTO vp_letra
     --     FROM   GE_LETRAS
     --     WHERE  COD_CATIMPOS = vp_cod_catimpos AND COD_TIPDOCUM = vp_cod_tipdocum;
     --     EXCEPTION
     --              WHEN NO_DATA_FOUND THEN
     --                   vp_error := 2;
     --                   gls_error := 'Error.No se encontraron datos de la letra de la categoria impositiva Msj13';
     --                   RAISE ERROR_PROCESO;
     --END;
     --IF vp_letra = ' ' THEN
     --   vp_error := 5;
     --   gls_error := 'Error. Categorma impositiva no tiene asociada Letra en tabla GE_LETRAS Msj14';
     --   RAISE ERROR_PROCESO;
     --END IF;
     -- bInsertProceso --
     BEGIN
          INSERT INTO FA_PROCESOS( NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                 COD_CENTREMI, FEC_EFECTIVIDAD, NOM_USUARORA,
                 LETRAAG, NUM_SECUAG, COD_TIPDOCNOT, COD_VENDEDOR_AGENTENOT,
                 LETRANOT, COD_CENTRNOT, NUM_SECUNOT, IND_ESTADO, COD_CICLFACT, IND_NOTACREDC)
          VALUES (TO_NUMBER(vp_num_proceso), vp_cod_tipdocum, vendedor,
                 scentremi, SYSDATE, usuario,
                 vp_letra, snumseq, vp_cod_tipdocum, cod_vendedor_agente,
                 sletra, scentremi, ssecuenci, NULL, NULL, 0);
          EXCEPTION
                   WHEN OTHERS THEN
                        vp_error := 3;
                        gls_error := 'Error.No se pudo insertar datos en tabla FA_PROCESOS Msj15';
                        RAISE ERROR_PROCESO;
     END;
     -- bInsertPrefactura --
     BEGIN
          INSERT INTO FA_PREFACTURA
                 (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO, COLUMNA,
                 COD_PRODUCTO, COD_MONEDA, FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
                 IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
                 COD_MODULO, COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,
                 COD_TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,
                 NUM_TERMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,NUM_VENTA,
                 NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPERTEL,NUM_PAQUETE,IND_CUOTA,
                 NUM_CUOTAS, ORD_CUOTA, COD_TIPDOCUM)
                 SELECT TO_NUMBER(vp_num_proceso),  TO_NUMBER(vp_cod_cliente), a.COD_CONCEPTO, a.COLUMNA, a.COD_PRODUCTO,
                        moneda,a.FEC_VALOR, a.FEC_EFECTIVIDAD,
                        a.IMP_CONCEPTO, a.IMP_FACTURABLE, 0, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD,
                        a.COD_MODULO, b.COD_PLANCOM, a.IND_FACTUR, b.COD_CATIMPOS, a.COD_PORTADOR,
                        0, a.COD_TIPCONCE, 1, NULL, NULL, NULL, a.NUM_ABONADO, NULL, NULL,
                        a.NUM_SERIEMEC, a.NUM_SERIELE, a.FLAG_IMPUES, a.FLAG_DTO, a.NUM_VENTA,
                        a.NUM_TRANSACCION, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.IND_SUPERTEL,
                        a.NUM_PAQUETE, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, B.COD_TIPDOCUM
                 FROM FA_AJUSTECONC a, FA_AJUSTES b
                 WHERE a.NUM_FOLIO = vp_num_folio     AND
                       a.PREF_PLAZA = vp_pref_plaza   AND
                       a.COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
                       b.COD_TIPDOCUM = vp_cod_tipdocum AND
                       a.NUM_FOLIO = b.NUM_FOLIO   AND
                       a.PREF_PLAZA = b.PREF_PLAZA AND
                       a.COD_CLIENTE = b.COD_CLIENTE AND
                       a.COD_TIPDOCUM = b.COD_TIPDOCUM;
          EXCEPTION
                   WHEN OTHERS THEN
                        vp_error := 3;
                        gls_error := 'Error.No se pudo insertar en tabla FA_PREFACTURA Msj16';
                        RAISE ERROR_PROCESO;
     END;
     lSeqNue := sNumSeq + 1;
     -- bUpdSecuencia --
     BEGIN
          UPDATE  GE_SECUENCIASEMI
          SET     NUM_SECUENCI = lSeqNue
          WHERE   COD_TIPDOCUM = vp_cod_tipdocum AND
                  COD_CENTREMI = scentremi AND
                  LETRA = vp_letra; -- GE_LETRAS
     EXCEPTION
              WHEN OTHERS THEN
                   vp_error := 4;
                   gls_error := 'Error.No se pudo actualizar tabla GE_SECUENCIASEMI Msj17';
                   RAISE ERROR_PROCESO;
     END;

     SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO secuencia_ga
     FROM   DUAL;

     BEGIN
          SELECT tip_foliacion
          INTO vp_tip_foliacion
          FROM ge_tipdocumen
          WHERE cod_tipdocum = vp_cod_tipdocum;
     EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   vp_error := 2;
                   Gls_error := 'Error.No se pudo recuperar csdigo tipo foliacion de tabla GE_TIPDOCUMEN Msj18';
                   RAISE ERROR_PROCESO;
     END;

     BEGIN

        SELECT A.COD_MODGENER,A.COD_TIPMOVIMIEN INTO vp_cod_modgener, vp_cod_tipmovimien
          FROM
          FA_GENCENTREMI A ,
          FA_TIPMOVIMIEN B
          WHERE A.COD_CENTREMI = scentremi AND
                A.COD_CATRIBUT = vp_categoria_trib AND
                A.COD_MODVENTA = TO_NUMBER(vp_cod_modventa) AND
                A.TIP_FOLIACION = vp_tip_foliacion AND
                b.COD_TIPDOCUM=vp_cod_tipdocum AND
                B.COD_TIPIMPOSITIVA=vp_cod_catimpos   AND
                A.COD_CATRIBUT      =B.COD_CATRIBUT        AND
                A.COD_MODVENTA      =B.COD_MODVENTA        AND
                A.COD_TIPMOVIMIEN    =B.COD_TIPMOVIMIEN   AND
                A.TIP_FOLIACION     =B.TIP_FOLIACION;


     EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   vp_error := 2;
                   gls_error := 'Error.No se pudo recuperar datos de tabla FA_GENCENTREMI Msj19';
                   RAISE ERROR_PROCESO;
     END;

     FA_INS_INTERFACT (
        TO_CHAR(secuencia_ga),   --vp_secuencia_ga    IN VARCHAR2,
        vp_num_proceso,          --vp_num_proceso     IN VARCHAR2,
        '0',                     --vp_num_venta       IN VARCHAR2,
        vp_cod_modgener,         --vp_cod_modgener    IN VARCHAR2,
        vp_cod_tipmovimien,      --vp_cod_tipmovimien IN VARCHAR2,
        vp_categoria_trib,       --vp_cod_catribut    IN VARCHAR2,
        TO_CHAR(vp_num_folio),   --vp_num_folio       IN VARCHAR2,
        '100',                   --vp_cod_estadoc     IN VARCHAR2,
        '3',                     --vp_cod_estproc     IN VARCHAR2,
        fecha,                   --vp_fec_vencimiento IN VARCHAR2,
        vp_entrada,              --vp_salida_proc     IN OUT VARCHAR2,
        vp_cod_modventa,         --vp_cod_modventa    IN VARCHAR2,
        0,                       --vp_num_cuotas      IN VARCHAR2,
        '',                      --vp_pref_plaza_rel  IN VARCHAR2
        vp_tip_foliacion,        --vp_tip_foliacion   IN VARCHAR2
        vp_cod_tipdocum          --vp_cod_tipdocum    IN VARCHAR2
        );


     SELECT COD_RETORNO, DES_CADENA INTO cod_retorno, des_cadena
     FROM   ga_transacabo
     WHERE  num_transaccion = secuencia_ga;
     IF cod_retorno != 0 THEN
        vp_error := 5;
        gls_error := 'Error. No se pudo ejecutar PL FA_INS_INTERFACT Secuencia = '||TO_CHAR(secuencia_ga)||' Msj20';
        RAISE ERROR_PROCESO;
     ELSE
         DELETE FROM ga_transacabo WHERE num_transaccion = secuencia_ga;
     END IF;
     COMMIT;
     RETURN vp_num_proceso;
     RAISE ERROR_PROCESO;
     EXCEPTION
              WHEN ERROR_PROCESO THEN
                ROLLBACK;
                   DBMS_OUTPUT.Put_Line('ERROR_PROCESO');
                   IF vp_error != 0 THEN
                        DBMS_OUTPUT.Put_Line('vp_error!=0:1');
                   END IF;
                   IF vp_error = 0 THEN
                      DBMS_OUTPUT.Put_Line('vp_error==0');
                      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                      VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
                   ELSE
                       DBMS_OUTPUT.Put_Line('vp_error!=0:2 NUM_TRANSACCION=('||vp_secuencia_ga||')COD_RETORNO=('||vp_error||')DES_CADENA=('||gls_error||')');
                       INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                       VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
                   END IF;
                   COMMIT;
                   RETURN '-1';
              WHEN DUP_VAL_ON_INDEX THEN
                ROLLBACK;
                   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                   VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
                   COMMIT;
                   RETURN '-1';
              WHEN NO_DATA_FOUND THEN
              ROLLBACK;
                   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                   VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Datos No Fueron Encontrados');
                   COMMIT;
                   RETURN '-1';
              WHEN OTHERS THEN
                    ROLLBACK;
                   DBMS_OUTPUT.Put_Line('OTHERS');
                   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                   VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Otros Errores No Esperados');
                   COMMIT;
                   RETURN '-1';
END FA_REGENERA_FACTURA_FN;
/
SHOW ERRORS
