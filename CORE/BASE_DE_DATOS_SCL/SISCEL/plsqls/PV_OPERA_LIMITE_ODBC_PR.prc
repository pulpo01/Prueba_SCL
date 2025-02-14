CREATE OR REPLACE PROCEDURE PV_OPERA_LIMITE_ODBC_PR(
        pnNumTransaccion IN NUMBER,
        pnSujeto        IN  NUMBER,
        pvTipSujeto     IN  VARCHAR2,
        pvFecDesde      IN  VARCHAR2,
        pvFecHasta      IN  VARCHAR2,
        pvCodActabo     IN  VARCHAR2,
        pvCodPlantarif  IN  VARCHAR2,
        pvTipMovimiento IN  VARCHAR2
)
IS
        pvCodValor      VARCHAR2(200);
        pvErrorAplic    VARCHAR2(200);
        pvErrorGlosa    VARCHAR2(200);
        pvErrorOra      VARCHAR2(200);
        pvErrorOraGlosa VARCHAR2(200);
        pvTrace         VARCHAR2(200);
BEGIN
        PVCODVALOR := NULL;
        PVERRORAPLIC := NULL;
        PVERRORGLOSA := NULL;
        PVERRORORA := NULL;
        PVERRORORAGLOSA := NULL;
        PVTRACE := NULL;

        PV_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR(pnSujeto,
                                                pvTipSujeto,
                                                                                        pvFecDesde,
                                                                                        pvFecHasta,
                                                                                        pvCodActabo,
                                                                                        pvCodPlantarif,
                                                                                        pvTipMovimiento,
                                                                                        pvCodValor,
                                                                                        pvErrorAplic,
                                                                                        pvErrorGlosa,
                                                                                        pvErrorOra,
                                                                                        pvErrorOraGlosa,
                                                                                        pvTrace);

        IF pvCodValor = 'TRUE'
        THEN
                INSERT INTO GA_TRANSACABO
                (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                VALUES
                (pnNumTransaccion,0,NULL);
        ELSE
                INSERT INTO GA_TRANSACABO
                (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                VALUES
                --(pnNumTransaccion,4,pvErrorOraGlosa);--COL-36620|09-01-2007|EFR
                (pnNumTransaccion, 4, SUBSTR(pvErrorOraGlosa || pvTrace, 1, 250));--COL-36620|09-01-2007|EFR
        END IF;

END PV_OPERA_LIMITE_ODBC_PR;
/
SHOW ERRORS
