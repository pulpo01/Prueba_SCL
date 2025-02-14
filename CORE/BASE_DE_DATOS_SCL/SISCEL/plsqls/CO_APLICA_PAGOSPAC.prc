CREATE OR REPLACE PROCEDURE Co_Aplica_Pagospac(vp_FechaValor            IN VARCHAR2,    vp_Cod_Banco            IN VARCHAR2,
                                               vp_Cod_Respuesta         IN NUMBER,      vp_Cod_Respuesta2       IN NUMBER,
                                               vp_OutGlosa              OUT VARCHAR2,   vp_OutRetorno           OUT NUMBER) IS

vp_insertar             NUMBER;
vp_error                NUMBER(5);
vp_gls_error            VARCHAR2(255);
sNom_proceso            VARCHAR2(50);
sDesc_Sql               VARCHAR2(150);
lOutSecuencia           NUMBER  (10);
sOutGlosaError          VARCHAR2(255);
iOriPago                CO_DATGEN.ORI_PAC%TYPE;
iCauPago                CO_DATGEN.CAU_PAC%TYPE;

vp_Secu_Compago         NUMBER;
vp_Pref_Plaza           VARCHAR2(3);

lCodCliente             CO_PAGOSPAC.COD_CLIENTE%TYPE;
iCodTipDocum            CO_PAGOSPAC.COD_TIPDOCUM%TYPE;
iCodCentremi            CO_PAGOSPAC.COD_CENTREMI%TYPE;
lNumSecuenci            CO_PAGOSPAC.NUM_SECUENCI%TYPE;
lCodAgente              CO_PAGOSPAC.COD_VENDEDOR_AGENTE%TYPE;
sLetra                  CO_PAGOSPAC.LETRA%TYPE;
dImporteDebe            CO_PAGOSPAC.IMPORTE_DEBE%TYPE;
vp_cod_oficina          VARCHAR2(2);
vpFechaCancela          VARCHAR2(10);

vSecu_Compago           NUMBER(11);
vPref_Plaza             VARCHAR2(11);
vOutGlosa               VARCHAR2(255);
vOutRetorno             NUMBER(10);

/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
vp_batch        VARCHAR2(20);
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

/* CURSORES */
CURSOR PAGOSPAC IS
        SELECT
                COD_CLIENTE ,           COD_TIPDOCUM ,          COD_CENTREMI,
                NUM_SECUENCI,           COD_VENDEDOR_AGENTE,
                LETRA       ,           IMPORTE_DEBE
        FROM
                CO_PAGOSPAC
        WHERE
                FEC_VALOR=TO_DATE(vpFechaCancela,'DD-MM-YYYY')
                AND COD_BANCO           = vp_Cod_Banco
                AND IND_PROCESADO       = 1
                AND IND_CANCELADO       = 0
                AND COD_RESPUBANCO      = vp_Cod_Respuesta;

ERROR_PROCESO EXCEPTION;
BEGIN
        sNom_proceso:='CO_APLICA_PAGOSPAC';
        vp_error:=-1;

/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
        SELECT VAL_PARAMETRO
                INTO vp_batch
        FROM
                GED_PARAMETROS
        WHERE
                NOM_PARAMETRO='APLICA_PAGOSBATCH';

        /* Obtiene los datos generales 1 */
        sDesc_Sql:='SELECT ORI_PAC, CAU_PAC FROM CO_DATGEN';
        IF (vp_Cod_respuesta2=1) THEN
                SELECT  ORI_PAC        , CAU_PAC , TO_CHAR(TO_DATE(vp_FechaValor,'DD-MON-YYYY'),'DD-MM-YYYY')
                        INTO   iOriPago       , iCauPago , vpFechaCancela
                FROM   CO_DATGEN;
        ELSE
                SELECT  ORI_PAC        , CAU_PAC , TO_CHAR(TO_DATE(vp_FechaValor,'DD-MM-YYYY'),'DD-MM-YYYY')
                        INTO   iOriPago       , iCauPago , vpFechaCancela
                FROM   CO_DATGEN;
        END IF;
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

        /*Obtiene Oficina 2 */
        sDesc_Sql:='SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
        SELECT VAL_PARAMETRO
                INTO vp_cod_oficina
        FROM GED_PARAMETROS
        WHERE
                NOM_PARAMETRO = 'OFICINA_FOLIO'
                AND COD_MODULO = 'RE';

        /*Obtiene otros 3 */
        IF vp_cod_oficina = '0' THEN
                vp_cod_oficina := 'RE';
        END IF;

/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
        IF (vp_Cod_Respuesta2=1) THEN
                IF (RTRIM(vp_batch)='0') THEN
                        /* Pago para un cliente */
                        sDesc_Sql:='OPEN PAGOSPAC';
                        OPEN PAGOSPAC;
                        LOOP
                                sDesc_Sql:='FETCH PAGOSPAC';
                                FETCH PAGOSPAC INTO  lCodCliente , iCodTipDocum , iCodCentremi , lNumSecuenci , lCodAgente , sLetra , dImporteDebe ;
                                EXIT WHEN PAGOSPAC%NOTFOUND;
                                sDesc_Sql:='Llamada a PL CO_APLICAPAGO_UNIVERSAL';
                                Co_Aplicapago_Universal(
                                        'PAC',          lCodCliente,    dImporteDebe,   vpFechaCancela, vp_Cod_Banco,
                                        iOriPago,       iCauPago,       'PAC',          vp_cod_oficina, NULL,
                                        NULL,           NULL,           NULL,           NULL,           NULL,
                                        NULL,           NULL,           NULL,           NULL,           NULL,
                                        NULL,           NULL,           0,              NULL,           0,
                                        NULL,           NULL,           NULL,           NULL,           NULL,
                                        NULL,           NULL,           vp_Secu_Compago,vp_Pref_Plaza,  vp_OutGlosa,
                                        vp_OutRetorno);
                                IF (vp_OutRetorno!=0) THEN
                                        BEGIN
                                                RAISE ERROR_PROCESO;
                                        END;
                                ELSE
                                        /* Actualiza campo Ind_cancelado en Co_PagosPac - bfnDBUpdIndCancePac() */
                                        sDesc_Sql:='UPDATE  CO_PAGOSPAC  SET. Cliente : '||lCodCliente;
                                        UPDATE  CO_PAGOSPAC  SET
                                                IND_CANCELADO = 1,
                                                IND_CORREO = 1,
                                                IND_SMS = 1,
                                                NOM_USUARORA = user,    /* Dvergara Sop.RyC 14-04-2005. TM-200504111337. Se actualiza usuario en CO_PAGOSPAC.*/
                                                FEC_PROCESO  = SYSDATE  /* Dvergara Sop.RyC 14-04-2005. TM-200504111337. Se actualiza fecha de proceso en CO_PAGOSPAC */
                                        WHERE   FEC_VALOR = TO_DATE(vpFechaCancela,'DD-MM-YYYY')
                                                AND     COD_BANCO    = vp_Cod_Banco
                                                AND     COD_CLIENTE  = lCodCliente
                                                AND     COD_TIPDOCUM = iCodTipDocum
                                                AND     COD_CENTREMI = iCodCentremi
                                                AND     NUM_SECUENCI = lNumSecuenci
                                                AND     COD_VENDEDOR_AGENTE = lCodAgente
                                                AND     LETRA        = sLetra      ;
                                END IF;
                        END LOOP;
                ELSE
                        SELECT
                                COUNT(*)
                        INTO
                                vp_insertar
                        FROM
                                CO_PAC_COLASBATCH_TD
                        WHERE
                                FEC_VALOR=TO_DATE(vpFechaCancela,'DD-MM-YYYY')
                                AND
                                RTRIM(COD_BANCO)=vp_Cod_Banco;

                        IF (vp_insertar=0) THEN
                                INSERT INTO CO_PAC_COLASBATCH_TD
                                        (FEC_VALOR, COD_BANCO, IND_PROCESADO, COD_ESTADO)
                                VALUES
                                        (TO_DATE(vpFechaCancela,'DD-MM-YYYY'),vp_Cod_Banco,1 ,0 );
                        END IF;
                END IF;
        ELSE
                /* Pago para un cliente */
                sDesc_Sql:='OPEN PAGOSPAC';
                OPEN PAGOSPAC;
                LOOP
                        sDesc_Sql:='FETCH PAGOSPAC';
                        FETCH PAGOSPAC INTO  lCodCliente , iCodTipDocum , iCodCentremi , lNumSecuenci , lCodAgente , sLetra , dImporteDebe ;
                        EXIT WHEN PAGOSPAC%NOTFOUND;
                        sDesc_Sql:='Llamada a PL CO_APLICAPAGO_UNIVERSAL';
                        Co_Aplicapago_Universal(
                                'PAC',          lCodCliente,    dImporteDebe,   vpFechaCancela, vp_Cod_Banco,
                                iOriPago,       iCauPago,       'PAC',          vp_cod_oficina, NULL,
                                NULL,           NULL,           NULL,           NULL,           NULL,
                                NULL,           NULL,           NULL,           NULL,           NULL,
                                NULL,           NULL,           0,              NULL,           0,
                                NULL,           NULL,           NULL,           NULL,           NULL,
                                NULL,           NULL,           vp_Secu_Compago,vp_Pref_Plaza,  vp_OutGlosa,
                                vp_OutRetorno);
                        IF (vp_OutRetorno!=0) THEN
                                BEGIN
                                        RAISE ERROR_PROCESO;
                                END;
                        ELSE
                                /* Actualiza campo Ind_cancelado en Co_PagosPac - bfnDBUpdIndCancePac() */
                                sDesc_Sql:='UPDATE  CO_PAGOSPAC  SET. Cliente : '||lCodCliente;
                                UPDATE  CO_PAGOSPAC  SET
                                        IND_CANCELADO = 1,
                                        IND_CORREO = 1,
                                        IND_SMS = 1,
                                        NOM_USUARORA = user,    /* HM-200503100027 RyC CGLagos 11-03-2005. Se homologa incidencia TM-200502041248*/
                                        FEC_PROCESO  = SYSDATE          /* HM-200503100027 RyC CGLagos 11-03-2005. Se homologa incidencia TM-200502041248*/
                                WHERE   FEC_VALOR = TO_DATE(vp_FechaValor,'DD-MM-YYYY')
                                        AND     COD_BANCO    = vp_Cod_Banco
                                        AND     COD_CLIENTE  = lCodCliente
                                        AND     COD_TIPDOCUM = iCodTipDocum
                                        AND     COD_CENTREMI = iCodCentremi
                                        AND     NUM_SECUENCI = lNumSecuenci
                                        AND     COD_VENDEDOR_AGENTE = lCodAgente
                                        AND     LETRA        = sLetra      ;
                        END IF;
                END LOOP;
        END IF;
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

        vp_OutRetorno:= 0;
        vp_OutGlosa  := 'OK';

/*************************************************************************
        INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
        COMMIT;
/*************************************************************************
        FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

EXCEPTION
        WHEN ERROR_PROCESO THEN
                ROLLBACK;
                IF (vp_Cod_Respuesta2=1) THEN
                        vp_OutRetorno := -1;
                END IF;
                vp_gls_error:='Error de Proceso - '||SQLERRM;
                vp_error := SQLCODE;
                INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
                        VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                COMMIT;
        WHEN NO_DATA_FOUND THEN
                ROLLBACK;
                vp_OutRetorno := -100;
                vp_OutGlosa  := 'Error Sql : '||SQLERRM;
                vp_gls_error := 'No Hay Datos - ' || SQLERRM;
                vp_error := SQLCODE;
                INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
                        VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql , vp_gls_error);
                COMMIT;
        WHEN OTHERS THEN
                ROLLBACK;
                vp_OutRetorno := -999;
                vp_OutGlosa  := 'Error Sql : '||SQLERRM;
                vp_gls_error := 'Otros Errores - ' || SQLERRM;
                vp_error := SQLCODE;
                INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
                        VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                COMMIT;
END Co_Aplica_Pagospac;
/
SHOW ERRORS