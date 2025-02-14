CREATE OR REPLACE PROCEDURE CO_DESAPLICA_PAGO_DGH( vpIn_Comprobante IN NUMBER   ,
                                                                                       vpIn_Pref_Plaza  IN VARCHAR2 , vpIn_TipDocPag  IN NUMBER,
                                                                                       vpIn_CodAgenPag  IN NUMBER   , vpIn_LetraPag   IN VARCHAR2,
                                                                                       vpIn_CentrEmiPag IN NUMBER   , vpIn_Motivo         IN NUMBER,
                                                                                       vpIn_TipoPago    IN NUMBER   , vp_Emp_Recauda  IN VARCHAR2,
                                                                                       vp_Cod_Caja_Rec  IN NUMBER   , vp_Cod_Moneda       IN VARCHAR2,
                                                                                       vp_Num_ejercicio IN VARCHAR2 , vp_Num_Transac  IN NUMBER,
                                                                                       vp_fecha_efec    IN VARCHAR2 ,
                                                                                       vp_outGlosa      OUT VARCHAR2, vp_outRetorno   OUT NUMBER) IS
/* SOPORTE 02-12-2003 Se agrega vp_fecha_efec por Homologacion HB-0216 de Incidencia MA-171120030293*/
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
bOutRetorno     BOOLEAN:=TRUE;
dAcumPagos              NUMBER(14,4) :=0;
iContReg                NUMBER(10)   :=0;
dImpDebeGlob    NUMBER(18,4) :=0;
iInd_PagoCons   NUMBER(1):=0;
vp_Cod_Oficina  CO_EMPRESAS_REX.COD_OFICINA%TYPE;
vp_Cod_Caja             CO_EMPRESAS_REX.COD_CAJA%TYPE;
sNom_User       CO_CAJEROS.NOM_USUARORA%TYPE;
iCod_cliente    CO_PAGOS.COD_CLIENTE%TYPE;
iNum_secuenci   CO_PAGOS.NUM_SECUENCI%TYPE;
iCod_tipdocum   CO_PAGOS.COD_TIPDOCUM%TYPE;
iCod_centremi   CO_PAGOS.COD_CENTREMI%TYPE;
iCod_vendedor   CO_PAGOS.COD_VENDEDOR_AGENTE%TYPE;
sLetra          CO_PAGOS.LETRA%TYPE;
dImportePago    CO_PAGOS.IMP_PAGO%TYPE;
dImpPago                CO_PAGOS.IMP_PAGO%TYPE;
iPgNum_secu     CO_PAGOSCONC.NUM_SECUREL%TYPE;
iPgCod_tipdoc   CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
iPgCod_agente   CO_PAGOSCONC.COD_AGENTEREL%TYPE;
sPgLetra                CO_PAGOSCONC.LETRA_REL%TYPE;
iPgCod_centr    CO_PAGOSCONC.COD_CENTRREL%TYPE;
dPgImp_conce    CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
iPgCod_conce    CO_PAGOSCONC.COD_CONCEPTO%TYPE;
iPgColumna      CO_PAGOSCONC.COLUMNA%TYPE;
iPgNum_venta    CO_PAGOSCONC.NUM_VENTA%TYPE;
iDocPago                CO_DATGEN.DOC_PAGO%TYPE;
lNumCargo               CO_INTERESAPLI.NUM_CARGO%TYPE;
lNumCargoCob    CO_INTERCOBAPLI.NUM_CARGO%TYPE;

CURSOR DOCS IS
SELECT COD_CLIENTE, NUM_SECUENCI, IMP_PAGO, COD_TIPDOCUM,
       COD_CENTREMI, COD_VENDEDOR_AGENTE   , LETRA
FROM   CO_PAGOS
WHERE  NUM_COMPAGO =  vpIn_Comprobante
AND    PREF_PLAZA  =  vpIn_Pref_Plaza;

CURSOR DOCS_PGCONC IS
SELECT NVL(NUM_SECUREL,-1) ,   NVL(COD_TIPDOCREL,-1),   NVL(COD_AGENTEREL,-1),   NVL(LETRA_REL,' '),
           NVL(COD_CENTRREL,-1),   NVL(IMP_CONCEPTO,-1) ,   NVL(COD_CONCEPTO,-1) ,   NVL(COLUMNA,-1)  , NVL(NUM_VENTA,-1)
FROM   CO_PAGOSCONC
WHERE  NUM_SECUENCI       = iNum_secuenci
AND    COD_TIPDOCUM       = iCod_tipdocum
AND    COD_CENTREMI       = iCod_centremi
AND    COD_VENDEDOR_AGENTE= iCod_vendedor
AND    LETRA              = sLetra  ;

CURSOR DOCS_CARGOSMORA IS
SELECT NUM_CARGO
FROM   CO_INTERESAPLI
WHERE  COD_TIPDOCUM    = vpIn_TipDocPag
AND    COD_CENTREMI    = vpIn_CentrEmiPag
AND    NUM_SECUENCI    = iNum_secuenci
AND    COD_VENDEDOR_AGENTE = vpIn_CodAgenPag
AND    LETRA           = vpIn_LetraPag
AND    NUM_CARGO                > 0;

CURSOR DOCS_INTERCOBAPLI IS
SELECT DISTINCT(NUM_CARGO)
FROM   CO_INTERCOBAPLI
WHERE  COD_TIPDOCUM    = vpIn_TipDocPag
AND    COD_CENTREMI    = vpIn_CentrEmiPag
AND    NUM_SECUENCI    = iNum_secuenci
AND    COD_VENDEDOR_AGENTE = vpIn_CodAgenPag
AND    LETRA           = vpIn_LetraPag
AND    NUM_CARGO                > 0;

ERROR_PROCESO EXCEPTION;
BEGIN
    sNom_proceso:='CO_DESAPLICA_PAGO';
        bOutRetorno := TRUE;
        vp_error:= -1;

        sDesc_Sql:='SELECT OFICINA,CAJA,USUARIO';
    SELECT A.COD_OFICINA, A.COD_CAJA, B.NOM_USUARORA
    INTO   vp_Cod_Oficina, vp_Cod_Caja , sNom_User
    FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
    WHERE  A.EMP_RECAUDADORA = vp_Emp_Recauda
    AND    A.COD_OFICINA     = B.COD_OFICINA
    AND    A.COD_CAJA        = B.COD_CAJA;

        sDesc_Sql:='SELECT DOC_PAGO FROM CO_DATGEN';
    SELECT DOC_PAGO INTO iDocPago FROM CO_DATGEN;
        sDesc_Sql:='DELETE FROM CO_CARTERA';

    DELETE FROM CO_CARTERA
    WHERE NUM_SECUENCI IN   (SELECT UNIQUE C.NUM_SECUENCI  FROM CO_DOCUMENTOS C, CO_MOVIMIENTOSCAJA B
                                                         WHERE  B.NUM_COMPAGO   = vpIn_Comprobante  AND   B.PREF_PLAZA     = vpIn_Pref_Plaza
                                                         AND    B.NUM_CHEQUE   IS NOT NULL
                                                         AND    B.COD_BANCO     = C.COD_BANCO       AND    B.CTA_CORRIENTE = C.CTA_CORRIENTE
                                                         AND    C.NUM_DOCUMENTO > 0                 AND    C.NUM_SECUENCI  >= 0)
    AND COD_TIPDOCUM = 59;

        sDesc_Sql:='DELETE FROM CO_DET_DOCUMENTOS';
    DELETE FROM CO_DET_DOCUMENTOS
    WHERE NUM_SECUENCI_DOC IN (SELECT UNIQUE C.NUM_SECUENCI  FROM CO_DOCUMENTOS C, CO_MOVIMIENTOSCAJA B
                                                           WHERE  B.NUM_COMPAGO   = vpIn_Comprobante AND   B.PREF_PLAZA    = vpIn_Pref_Plaza
                                                           AND    B.NUM_CHEQUE   IS NOT NULL
                               AND    B.COD_BANCO     = C.COD_BANCO              AND    B.CTA_CORRIENTE = C.CTA_CORRIENTE
                               AND    C.NUM_DOCUMENTO > 0                                AND    C.NUM_SECUENCI  >= 0)
    AND    NUM_SECUENCI  >= 0 ;

        sDesc_Sql:='DELETE FROM CO_DOCUMENTOS';
    DELETE FROM CO_DOCUMENTOS
    WHERE NUM_SECUENCI IN  ( SELECT UNIQUE C.NUM_SECUENCI  FROM CO_DOCUMENTOS C, CO_MOVIMIENTOSCAJA B
                                                     WHERE  B.NUM_COMPAGO   = vpIn_Comprobante  AND   B.PREF_PLAZA         = vpIn_Pref_Plaza
                                                         AND    B.NUM_CHEQUE   IS NOT NULL
                                                         AND    B.COD_BANCO     = C.COD_BANCO       AND   B.CTA_CORRIENTE = C.CTA_CORRIENTE
                                                         AND    C.NUM_DOCUMENTO > 0                                 AND   C.NUM_SECUENCI  >=0)
    AND COD_TIPDOCUM = 59;

    OPEN DOCS;
    LOOP
      BEGIN
        sDesc_Sql:='FETCH DOCS';
        FETCH DOCS INTO iCod_cliente, iNum_secuenci, dImportePago, iCod_tipdocum,
                        iCod_centremi, iCod_vendedor, sLetra ;
        EXIT WHEN DOCS%NOTFOUND;
        IF iInd_PagoCons = 0 THEN
           CO_DESPAGCONSUMO(vp_Cod_Oficina, vp_Cod_Caja, dImportePago, vp_Cod_Moneda, vpIn_Comprobante, vpIn_Pref_Plaza, vpIn_TipoPago, vp_Num_ejercicio, bOutRetorno);
           IF bOutRetorno = FALSE THEN
              sDesc_Sql:='Error en PL CO_DESPAGCONSUMO';
                  RAISE ERROR_PROCESO;
           END IF;
           iInd_PagoCons:=1;
        END IF;

        sDesc_Sql:='INSERT INTO CO_DESAPAGOS';
        INSERT INTO CO_DESAPAGOS (
               COD_TIPDOCUM  , COD_CENTREMI   , NUM_SECUENCI , COD_VENDEDOR_AGENTE, LETRA        , COD_CLIENTE  ,
               IMP_PAGO      , FEC_EFECTIVIDAD, FEC_VALOR    , NOM_USUARORA       , COD_FORPAGO  , COD_SISPAGO  ,
               COD_ORIPAGO   , COD_CAUPAGO    , FEC_DESAPLICA, NOM_USUARIOSDESAP  , TIP_DESAPLICA, COD_BANCO    ,
               COD_TIPTARJETA, COD_CAJA       , COD_SUCURSAL , CTA_CORRIENTE      , NUM_TARJETA  , DES_PAGO     ,PREF_PLAZA   )
        SELECT COD_TIPDOCUM  , COD_CENTREMI   , NUM_SECUENCI , COD_VENDEDOR_AGENTE, LETRA        , COD_CLIENTE  ,
               IMP_PAGO      , FEC_EFECTIVIDAD, FEC_VALOR    , NOM_USUARORA       , COD_FORPAGO  , COD_SISPAGO  ,
               COD_ORIPAGO   , COD_CAUPAGO    , SYSDATE      , sNom_User          , vpIn_Motivo  , COD_BANCO    ,
               COD_TIPTARJETA, COD_CAJA       , COD_SUCURSAL , CTA_CORRIENTE      , NUM_TARJETA  , DES_PAGO     , PREF_PLAZA
        FROM   CO_PAGOS
        WHERE  NUM_SECUENCI       = iNum_secuenci
        AND    COD_TIPDOCUM       = iCod_tipdocum
        AND    COD_CENTREMI       = iCod_centremi
        AND    COD_VENDEDOR_AGENTE= iCod_vendedor
        AND    LETRA              = sLetra  ;

        sDesc_Sql:='INSERT INTO CO_DESAPAGOSCONC';
        INSERT INTO CO_DESAPAGOSCONC (
               COD_TIPDOCUM , COD_CENTREMI , NUM_SECUENCI     , COD_VENDEDOR_AGENTE, LETRA          , IMP_CONCEPTO,
               COD_PRODUCTO , NUM_SECUREL  , COD_TIPDOCREL    , COD_AGENTEREL      , NUM_TRANSACCION, LETRA_REL   ,
               COD_CENTRREL , COD_CONCEPTO , COLUMNA          , NUM_ABONADO        , NUM_FOLIO      , NUM_CUOTA   ,
               SEC_CUOTA    , NUM_VENTA    , COD_OPERADORA_SCL, COD_PLAZA          , PREF_PLAZA     )
        SELECT COD_TIPDOCUM , COD_CENTREMI , NUM_SECUENCI     , COD_VENDEDOR_AGENTE, LETRA          , IMP_CONCEPTO,
               COD_PRODUCTO , NUM_SECUREL  , COD_TIPDOCREL    , COD_AGENTEREL      , NUM_TRANSACCION, LETRA_REL   ,
               COD_CENTRREL , COD_CONCEPTO , COLUMNA          , NUM_ABONADO        , NUM_FOLIO      , NUM_CUOTA   ,
               SEC_CUOTA    , NUM_VENTA    , COD_OPERADORA_SCL, COD_PLAZA          , PREF_PLAZA
        FROM   CO_PAGOSCONC
        WHERE  NUM_SECUENCI       = iNum_secuenci
        AND    COD_TIPDOCUM       = iCod_tipdocum
        AND    COD_CENTREMI       = iCod_centremi
        AND    COD_VENDEDOR_AGENTE= iCod_vendedor
        AND    LETRA              = sLetra  ;

        sDesc_Sql:='SELECT IMP_PAGO FROM CO_PAGOS';
        SELECT IMP_PAGO  INTO   dImpPago
        FROM   CO_PAGOS
        WHERE  NUM_SECUENCI       = iNum_secuenci
        AND    COD_TIPDOCUM       = iCod_tipdocum
        AND    COD_CENTREMI       = iCod_centremi
        AND    COD_VENDEDOR_AGENTE= iCod_vendedor
        AND    LETRA              = sLetra  ;

        OPEN DOCS_PGCONC;
        dAcumPagos := 0;
        LOOP
            sDesc_Sql:='FETCH DOCS_PGCONC';
            FETCH DOCS_PGCONC
            INTO iPgNum_secu, iPgCod_tipdoc, iPgCod_agente, sPgLetra, iPgCod_centr,
                dPgImp_conce, iPgCod_conce, iPgColumna, iPgNum_venta;
            EXIT WHEN DOCS_PGCONC%NOTFOUND;

            dAcumPagos := dAcumPagos + dPgImp_conce;
            iContReg := iContReg + 1;
            IF  (iPgCod_tipdoc = -1) AND (iPgNum_venta != -1) THEN
                BEGIN
                    sDesc_Sql:='DELETE FROM CO_CARTEVENTA';
                    DELETE FROM CO_CARTEVENTA  WHERE NUM_VENTA = iPgNum_venta;
                    sDesc_Sql:='UPDATE GA_VENTAS SET';
                    UPDATE GA_VENTAS SET IND_PASOCOB = 0 WHERE NUM_VENTA = iPgNum_venta;
                END;
            ELSE
                BEGIN
                   Co_SelectCo_Cancelados(iPgCod_tipdoc, iPgCod_centr, iPgNum_secu, iPgCod_agente,
                                          sPgLetra, iPgCod_conce, iPgColumna, dImpDebeGlob) ;
                   IF dImpDebeGlob = -99999999 THEN
                      sDesc_Sql:='Error en PL Co_SelectCo_Cancelados 1';
                      RAISE ERROR_PROCESO;
                   ELSIF dImpDebeGlob = -99999000 THEN
                          BEGIN

                        IF iPgCod_tipdoc = 8 THEN
                            sDesc_Sql:='Error DELETE FROM   CO_CARTERA';
                            DELETE FROM   CO_CARTERA
                            WHERE  COD_TIPDOCUM    = iPgCod_tipdoc
                            AND    COD_CENTREMI    = iPgCod_centr
                            AND    NUM_SECUENCI    = iPgNum_secu
                            AND    COD_VENDEDOR_AGENTE = iPgCod_agente
                            AND    LETRA           = sPgLetra
                            AND    COD_CONCEPTO    = iPgCod_conce
                            AND    COLUMNA         = iPgColumna;

                        ELSE
                            Co_UpdateCo_Cartera(iPgCod_tipdoc, iPgCod_centr, iPgNum_secu, iPgCod_agente,
                                                sPgLetra, iPgCod_conce, iPgColumna,dPgImp_conce, bOutRetorno);

                            IF bOutRetorno = FALSE THEN
                               sDesc_Sql:='Error en PL Co_UpdateCo_Cartera';
                               RAISE ERROR_PROCESO;
                            END IF;
                        END IF;

                      END;
                   ELSE
                          BEGIN
                        Co_InsertCo_Cartera(iPgCod_tipdoc, iPgCod_centr, iPgNum_secu, iPgCod_agente,
                                            sPgLetra, iPgCod_conce, iPgColumna, dPgImp_conce, bOutRetorno);
                        IF bOutRetorno = FALSE THEN
                           sDesc_Sql:='Error en PL Co_InsertCo_Cartera 1';
                           RAISE ERROR_PROCESO;
                        END IF;
                        IF dImpDebeGlob > dPgImp_conce THEN
                           BEGIN
                                sDesc_Sql:='Error UPDATE CO_CARTERA SET';
                                UPDATE CO_CARTERA SET
                                       IMPORTE_HABER = dImpDebeGlob - dPgImp_conce
                                WHERE  COD_TIPDOCUM    = iPgCod_tipdoc
                                AND    COD_CENTREMI    = iPgCod_centr
                                AND    NUM_SECUENCI    = iPgNum_secu
                                AND    COD_VENDEDOR_AGENTE = iPgCod_agente
                                AND    LETRA           = sPgLetra
                                AND    COD_CONCEPTO    = iPgCod_conce
                                AND    COLUMNA         = iPgColumna;
                           END;
                        END IF;
                        Co_DeleteCo_Cancelados(iPgCod_tipdoc, iPgCod_centr, iPgNum_secu, iPgCod_agente,
                                               sPgLetra, iPgCod_conce, iPgColumna, bOutRetorno);
                        IF bOutRetorno = FALSE THEN
                           sDesc_Sql:='Error en PL Co_DeleteCo_Cancelados 1';
                           RAISE ERROR_PROCESO;
                        END IF;
                          END;
                   END IF;
                END;
            END IF;
        END LOOP;
        CLOSE DOCS_PGCONC;
        IF iContReg != 0 THEN
            IF dAcumPagos != dImportePago THEN
               sDesc_Sql:='Error en Cuadratura de Importe entre Pagos y Pagosconc';
               RAISE ERROR_PROCESO;
            END IF;
            sDesc_Sql:='DELETE FROM CO_PAGOS';
            DELETE FROM CO_PAGOS
            WHERE  NUM_SECUENCI       = iNum_secuenci
            AND    COD_TIPDOCUM       = iCod_tipdocum
            AND    COD_CENTREMI       = iCod_centremi
            AND    COD_VENDEDOR_AGENTE= iCod_vendedor
            AND    LETRA              = sLetra  ;

                sDesc_Sql   :='DELETE FROM CO_PAGOSCONC';
            DELETE FROM CO_PAGOSCONC
            WHERE  NUM_SECUENCI       = iNum_secuenci
            AND    COD_TIPDOCUM       = iCod_tipdocum
            AND    COD_CENTREMI       = iCod_centremi
            AND    COD_VENDEDOR_AGENTE= iCod_vendedor
            AND    LETRA              = sLetra  ;

            OPEN DOCS_CARGOSMORA;
            LOOP
               sDesc_Sql:='FETCH DOCS_CARGOSMORA';
               FETCH DOCS_CARGOSMORA INTO lNumCargo;
               EXIT WHEN DOCS_CARGOSMORA%NOTFOUND;

               sDesc_Sql:='DELETE FROM GE_CARGOS';
               DELETE FROM GE_CARGOS WHERE NUM_CARGO = lNumCargo;
            END LOOP;
            CLOSE DOCS_CARGOSMORA;

            sDesc_Sql:='DELETE FROM  CO_INTERESAPLI';
            DELETE FROM CO_INTERESAPLI
            WHERE  NUM_SECUENCI            = iNum_secuenci
			AND    COD_TIPDOCUM            = vpIn_TipDocPag
            AND    COD_VENDEDOR_AGENTE     = vpIn_CodAgenPag
			AND    LETRA                   = vpIn_LetraPag
            AND    COD_CENTREMI            = vpIn_CentrEmiPag;

            OPEN DOCS_INTERCOBAPLI;
            LOOP
               sDesc_Sql:='FETCH DOCS_INTERCOBAPLI';
               FETCH DOCS_INTERCOBAPLI INTO lNumCargoCob;
               EXIT WHEN DOCS_INTERCOBAPLI%NOTFOUND;
               sDesc_Sql:='DELETE FROM GE_CARGOS';
               DELETE FROM GE_CARGOS WHERE NUM_CARGO = lNumCargoCob;
            END LOOP;
            CLOSE DOCS_INTERCOBAPLI;

            sDesc_Sql:='DELETE FROM  CO_INTERCOBAPLI';
            DELETE FROM  CO_INTERCOBAPLI
            WHERE  NUM_SECUENCI            = iNum_secuenci
			AND    COD_TIPDOCUM            = vpIn_TipDocPag
            AND    COD_VENDEDOR_AGENTE     = vpIn_CodAgenPag
			AND    LETRA                   = vpIn_LetraPag
            AND    COD_CENTREMI            = vpIn_CentrEmiPag;
        END IF;
      END;
    END LOOP;

    sDesc_Sql:='UPDATE CO_INTERFAZ_PAGOS SET COD_ESTADO = PRO';
    UPDATE CO_INTERFAZ_PAGOS SET
           COD_ESTADO = 'PRO'
    WHERE  EMP_RECAUDADORA = vp_Emp_Recauda
    /* SOPORTE 02-12-2003 SE AGREGA COD_CAJA_RECAUDA Y FEC_EFECTIVIDAD por Homologacion HB-0216 de Incidencia MA-171120030293*/
    AND    COD_CAJA_RECAUDA = vp_Cod_Caja_Rec
    AND    FEC_EFECTIVIDAD  = TO_DATE(vp_fecha_efec,'DD-MM-YYYY HH24:MI:SS')
    AND    NUM_TRANSACCION = vp_Num_Transac
    AND    TIP_TRANSACCION = 'R';

        vp_outRetorno := 0;
        vp_outGlosa  := 'OK';
    COMMIT;

    EXCEPTION
        WHEN ERROR_PROCESO THEN
             ROLLBACK;
                         vp_outRetorno := 1;
                         vp_outGlosa  := 'Error Sql : '||sqlerrm;
                         vp_gls_error:='Error de Proceso';
                     vp_error := SQLCODE;
             INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
             VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                         COMMIT;
        WHEN NO_DATA_FOUND THEN
             ROLLBACK;
                         vp_outRetorno := 1;
                         vp_outGlosa  := 'Error Sql : '||sqlerrm;
                     vp_gls_error := 'No Hay Datos - ' || SQLERRM;
                     vp_error := SQLCODE;
             INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
             VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql , vp_gls_error);
                         COMMIT;
        WHEN OTHERS THEN
             ROLLBACK;
                         vp_outRetorno := 1;
                         vp_outGlosa  := 'Error Sql : '||sqlerrm;
                     vp_gls_error := 'Otros Errores - ' || SQLERRM;
                     vp_error := SQLCODE;
             INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
             VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                         COMMIT;
END CO_DESAPLICA_PAGO_DGH;
/
SHOW ERRORS
