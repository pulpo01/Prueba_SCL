CREATE OR REPLACE PROCEDURE CO_CANCELAREGU (vp_Cod_cliente     IN  NUMBER    ,  vp_Imp_pago         IN NUMBER   ,
                                            vp_Fecha_efec      IN  VARCHAR2  ,  vp_Cod_banco        IN VARCHAR2 ,
                                            vp_OriPago         IN  NUMBER    ,  vp_CauPago          IN NUMBER   ,
                                            vp_Emp_recauda     IN  VARCHAR2  ,
                                            vp_OutGlosa        OUT VARCHAR2  ,  vp_OutRetorno       OUT NUMBER  ) IS

v_sqlcode           VARCHAR2(10);
v_sqlerrm           VARCHAR2(255);
vp_Gls_Error        VARCHAR2(255);

iDecimal            NUMBER(2);
dTotal_pago         NUMBER(14,4);
dSaldo              NUMBER(14,4);
g_monto             CO_CARTERA.IMPORTE_DEBE%TYPE;
g_monto_concepto    CO_CARTERA.IMPORTE_DEBE%TYPE;

sNom_proceso        CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
lCod_cliente        GA_ABOCEL.COD_CLIENTE%TYPE;

iTipDocAnt          CO_CARTERA.COD_TIPDOCUM%TYPE;
iVendAgenAnt        CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE;
sLetraAnt           CO_CARTERA.LETRA%TYPE;
iCodCentAnt         CO_CARTERA.COD_CENTREMI%TYPE;
lNumSecAnt          CO_CARTERA.NUM_SECUENCI%TYPE;
lNumFolioAnt        CO_CARTERA.NUM_FOLIO%TYPE;
lPref_PlazaAnt      CO_CARTERA.PREF_PLAZA%TYPE;
iSecCuotAnt         CO_CARTERA.SEC_CUOTA%TYPE;

dSaldoAux           CO_CARTERA.IMPORTE_DEBE%TYPE;
sCod_OperadorAbono  CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono     CO_CARTERA.COD_PLAZA%TYPE;

lNum_secuenci       CO_CARTERA.NUM_SECUENCI%TYPE;
iCod_Docum          CO_CARTERA.COD_TIPDOCUM%TYPE;
iCod_vendedor       CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE;
sLetra_Car          CO_CARTERA.LETRA%TYPE;
lCod_centremi       CO_CARTERA.COD_CENTREMI%TYPE;
lCod_concepto       CO_CARTERA.COD_CONCEPTO%TYPE;
lColumna            CO_CARTERA.COLUMNA%TYPE;

lhNum_secuenci       CO_CARTERA.NUM_SECUENCI%TYPE;
lhCod_tipdocum       CO_CARTERA.COD_TIPDOCUM%TYPE;
lhCod_vendedor       CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE;
lhLetra              CO_CARTERA.LETRA%TYPE;
lhCod_centremi       CO_CARTERA.COD_CENTREMI%TYPE;
lhSec_cuota          CO_CARTERA.COD_CONCEPTO%TYPE;

lhFolio              CO_CARTERA.NUM_FOLIO%TYPE;
lhPref_Plaza         CO_CARTERA.PREF_PLAZA%TYPE;
lhSec_CuotaAnt       CO_CARTERA.SEC_CUOTA%TYPE;
vRetorno             PLS_INTEGER;
lMonto               CO_CARTERA.IMPORTE_DEBE%TYPE;

/********************   ARREGLO PARA CO_CARTERA  **********************************************/
i BINARY_INTEGER := 0;
TYPE TipRegCartera IS RECORD (
        DES_ABREVIADA           GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
        COD_TIPDOCUM            CO_CARTERA.COD_TIPDOCUM%TYPE    ,
        COD_VENDEDOR_AGENTE     CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE,
        LETRA                   CO_CARTERA.LETRA%TYPE,
        COD_CENTREMI            CO_CARTERA.COD_CENTREMI%TYPE,
        NUM_SECUENCI            CO_CARTERA.NUM_SECUENCI%TYPE,
        NUM_FOLIO               CO_CARTERA.NUM_FOLIO%TYPE,
        PREF_PLAZA              CO_CARTERA.PREF_PLAZA%TYPE,
        FEC_EFECTIVIDAD         VARCHAR2(10),
        FEC_VENCIMIE            VARCHAR2(10),
        NUM_VENTA               CO_CARTERA.NUM_VENTA%TYPE,
        IND_CONTADO             CO_CARTERA.IND_CONTADO%TYPE,
        SEC_CUOTA               CO_CARTERA.SEC_CUOTA%TYPE,
        IND_FACTURADO           CO_CARTERA.IND_FACTURADO%TYPE,
        NUM_CUOTA               CO_CARTERA.NUM_CUOTA%TYPE,
        SW                      VARCHAR2(2),
        MONTO                   NUMBER(18,4),
        COD_OPERADORA           CO_CARTERA.COD_OPERADORA_SCL%TYPE,
        COD_PLAZA               CO_CARTERA.COD_PLAZA%TYPE);
TYPE TipTab_CO_CARTERA   IS TABLE  OF  TipRegCartera INDEX BY  BINARY_INTEGER;
Tab_CARGA_CARTERA        TipTab_CO_CARTERA;

/*****************  CURSOR PARA CARTERA Co_Cartera03 ********************************************/
CURSOR Co_Cartera03 IS
SELECT /*+ INDEX (CO_CARTERA AK_CO_CARTERA_GE_CLIENTES) */
        B.DES_ABREVIADA             DES_ABREVIADA,
        A.COD_TIPDOCUM              COD_TIPDOCUM,
        A.COD_VENDEDOR_AGENTE       COD_VENDEDOR_AGENTE,
        A.LETRA                     LETRA,
        A.COD_CENTREMI              COD_CENTREMI,
        A.NUM_SECUENCI              NUM_SECUENCI,
        A.NUM_FOLIO                 NUM_FOLIO,
        A.PREF_PLAZA                PREF_PLAZA,
        TO_CHAR(A.FEC_EFECTIVIDAD,'DD-MM-YYYY') FEC_EFECTIVIDAD,
        TO_CHAR(A.FEC_VENCIMIE,'DD-MM-YYYY')    FEC_VENCIMIE,
        NVL(A.NUM_VENTA,0)          NUM_VENTA,
        A.IND_CONTADO               IND_CONTADO,
        NVL(A.SEC_CUOTA,-1)         SEC_CUOTA,
        A.IND_FACTURADO             IND_FACTURADO,
        NVL(A.NUM_CUOTA,0)          NUM_CUOTA,
        ''                          SW,
        0                           MONTO,
        A.COD_OPERADORA_SCL         COD_OPERADORA,
        A.COD_PLAZA                 COD_PLAZA
FROM    CO_CARTERA A, GE_TIPDOCUMEN B
WHERE   A.COD_CLIENTE   = lCod_cliente
AND     A.COD_TIPDOCUM  = B.COD_TIPDOCUM
--AND     A.COD_TIPDOCUM  NOT IN (5,39,59,60,61,62,64,83)
AND     A.COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
					   	   	  	FROM CO_CODIGOS
								WHERE NOM_TABLA = 'CO_CARTERA'
								AND NOM_COLUMNA = 'COD_TIPDOCUM')
AND     A.COD_CONCEPTO NOT IN (2,6)
AND     A.IND_FACTURADO = 1
--ORDER BY  A.COD_TIPDOCUM, A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.PREF_PLAZA ASC, A.SEC_CUOTA ASC;
ORDER BY  A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.SEC_CUOTA ASC;

CURSOR c_tab IS
    SELECT *
    FROM   CO_CARTERA
    WHERE  COD_CLIENTE          = lCod_cliente
    AND    NUM_SECUENCI         = lhNum_secuenci
    AND    COD_TIPDOCUM         = lhCod_tipdocum
    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
    AND    LETRA                = lhLetra
    AND    COD_CENTREMI         = lhCod_centremi
    AND    SEC_CUOTA            = lhSec_cuota; --Tab_CARGA_CARTERA(i).SEC_CUOTA;

CURSOR c_tab1 IS
    SELECT *
    FROM   CO_CARTERA
    WHERE  COD_CLIENTE          = lCod_cliente
    AND    NUM_SECUENCI         = lhNum_secuenci
    AND    COD_TIPDOCUM         = lhCod_tipdocum
    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
    AND    LETRA                = lhLetra
    AND    COD_CENTREMI         = lhCod_centremi
    AND    (SEC_CUOTA            IS NULL OR SEC_CUOTA = 0);

CURSOR c_DocReg IS
SELECT  A.NUM_SECUENCI , A.COD_TIPDOCUM ,
        A.COD_VENDEDOR_AGENTE,
        A.LETRA        , A.COD_CENTREMI ,
        A.COD_CONCEPTO , A.COLUMNA
FROM    CO_CARTERA A, GE_TIPDOCUMEN B
WHERE   A.COD_CLIENTE   = lCod_cliente
AND     A.COD_TIPDOCUM  = B.COD_TIPDOCUM
AND     A.COD_TIPDOCUM  = 83
AND     A.IND_FACTURADO = 1
AND		A.FEC_EFECTIVIDAD = TO_DATE(vp_Fecha_efec,'DD-MM-YYYY')
AND		A.IMPORTE_HABER = GE_PAC_GENERAL.REDONDEA(vp_Imp_pago, iDecimal, 0);


ERROR_PROCESO EXCEPTION ;
/****** Inicio  ******/
BEGIN
    vp_Gls_Error := '';
    sNom_proceso :='CO_CANCELAREGU';

    lCod_cliente:=vp_Cod_cliente;
    dTotal_pago:=TO_NUMBER(vp_Imp_pago);

    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;


    IF dTotal_pago > 0 THEN

        i :=0;
        iTipDocAnt  := 0;
        iVendAgenAnt:= 0;
        sLetraAnt   := '';
        iCodCentAnt := 0;
        lNumSecAnt  := 0;
        lNumFolioAnt:= 0;
        lPref_PlazaAnt:= '';
        iSecCuotAnt := 0;
        dSaldoAux   := 0;

        vp_Gls_Error := 'Recorre Cursor Co_Cartera03.';
        BEGIN
            FOR rReg IN Co_Cartera03 LOOP

                IF rReg.COD_TIPDOCUM = iTipDocAnt AND rReg.COD_VENDEDOR_AGENTE = iVendAgenAnt AND rReg.LETRA = sLetraAnt
                                                  AND rReg.COD_CENTREMI = iCodCentAnt         AND rReg.NUM_SECUENCI = lNumSecAnt
                                                  AND rReg.NUM_FOLIO = lNumFolioAnt           AND rReg.PREF_PLAZA = lPref_PlazaAnt
                                                  AND rReg.SEC_CUOTA = iSecCuotAnt THEN
                    BEGIN
                        vp_Gls_Error := 'No Hace Nada.';
                    END;
                ELSE
                    BEGIN
                        iTipDocAnt  := rReg.COD_TIPDOCUM;
                        iVendAgenAnt:= rReg.COD_VENDEDOR_AGENTE;
                        sLetraAnt   := rReg.LETRA;
                        iCodCentAnt := rReg.COD_CENTREMI;
                        lNumSecAnt  := rReg.NUM_SECUENCI;
                        lNumFolioAnt:= rReg.NUM_FOLIO;
                        lPref_PlazaAnt:= rReg.PREF_PLAZA;
                        iSecCuotAnt := rReg.SEC_CUOTA;

                        /***** Si el pago tiene cuotas *****/
                        IF iSecCuotAnt > -1 THEN
                           BEGIN
                                vp_Gls_Error := 'SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) FROM CO_CARTERA(1). Cliente : '||lCod_cliente;
                                SELECT  NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
                                INTO    dSaldo
                                FROM    CO_CARTERA
                                WHERE   COD_CLIENTE  = lCod_cliente
                                AND     COD_TIPDOCUM = iTipDocAnt
                                AND     COD_CENTREMI = iCodCentAnt
                                AND     NUM_SECUENCI = lNumSecAnt
                                AND     COD_VENDEDOR_AGENTE = iVendAgenAnt
                                AND     LETRA        = sLetraAnt
                                AND     NUM_FOLIO    = lNumFolioAnt
                                AND     PREF_PLAZA   = lPref_PlazaAnt
                                AND     SEC_CUOTA    = iSecCuotAnt ;
                           END;
                         ELSE
                            BEGIN
                                vp_Gls_Error := 'SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) FROM CO_CARTERA(2). Cliente : '||lCod_cliente;
                                SELECT  NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
                                INTO    dSaldo
                                FROM    CO_CARTERA
                                WHERE   COD_CLIENTE  = lCod_cliente
                                AND     COD_TIPDOCUM = iTipDocAnt
                                AND     COD_CENTREMI = iCodCentAnt
                                AND     NUM_SECUENCI = lNumSecAnt
                                AND     COD_VENDEDOR_AGENTE = iVendAgenAnt
                                AND     LETRA        = sLetraAnt
                                AND     NUM_FOLIO    = lNumFolioAnt
                                AND     PREF_PLAZA   = lPref_PlazaAnt;
                            END;
                         END IF;

                         IF (dSaldo > 0) AND (dTotal_pago > 0) THEN
                              BEGIN
                                i := i + 1 ;
                                Tab_CARGA_CARTERA(i).DES_ABREVIADA        := rReg.DES_ABREVIADA ;
                                Tab_CARGA_CARTERA(i).COD_TIPDOCUM         := rReg.COD_TIPDOCUM ;
                                Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE  := rReg.COD_VENDEDOR_AGENTE ;
                                Tab_CARGA_CARTERA(i).LETRA                := rReg.LETRA ;
                                Tab_CARGA_CARTERA(i).COD_CENTREMI         := rReg.COD_CENTREMI ;
                                Tab_CARGA_CARTERA(i).NUM_SECUENCI         := rReg.NUM_SECUENCI ;
                                Tab_CARGA_CARTERA(i).NUM_FOLIO            := rReg.NUM_FOLIO ;
                                Tab_CARGA_CARTERA(i).PREF_PLAZA           := rReg.PREF_PLAZA ;
                                Tab_CARGA_CARTERA(i).FEC_EFECTIVIDAD      := rReg.FEC_EFECTIVIDAD ;
                                Tab_CARGA_CARTERA(i).FEC_VENCIMIE         := rReg.FEC_VENCIMIE ;
                                Tab_CARGA_CARTERA(i).NUM_VENTA            := rReg.NUM_VENTA;
                                Tab_CARGA_CARTERA(i).IND_CONTADO          := rReg.IND_CONTADO;
                                Tab_CARGA_CARTERA(i).SEC_CUOTA            := rReg.SEC_CUOTA;
                                Tab_CARGA_CARTERA(i).IND_FACTURADO        := rReg.IND_FACTURADO;
                                Tab_CARGA_CARTERA(i).NUM_CUOTA            := rReg.NUM_CUOTA;
                                Tab_CARGA_CARTERA(i).COD_OPERADORA        := rReg.COD_OPERADORA;
                                Tab_CARGA_CARTERA(i).COD_PLAZA            := rReg.COD_PLAZA;

                                IF dTotal_pago >= dSaldo THEN
                                   Tab_CARGA_CARTERA(i).MONTO   := dSaldo;
                                   Tab_CARGA_CARTERA(i).SW      :='SI';
                                   dTotal_pago:= dTotal_pago - dSaldo;
                                   dSaldoAux:=dSaldoAux + dSaldo;
                                ELSE
                                   Tab_CARGA_CARTERA(i).MONTO   := dTotal_pago;
                                   Tab_CARGA_CARTERA(i).SW      :='NO';
                                   g_monto := to_number(dTotal_pago);
                                   dTotal_pago:= dTotal_pago - dSaldo;
                                   EXIT;
                                END IF;
                              END;
                        END IF;
                    END;
                END IF;
            END LOOP;
        END;
    END IF;


    i:=Tab_CARGA_CARTERA.LAST;
    IF i > 0 THEN
        i:=1;

		lhFolio         := 0;
		lhPref_Plaza    := '';
		lMonto          := 0;
		lhSec_CuotaAnt  := 0;
        FOR i IN Tab_CARGA_CARTERA.FIRST .. Tab_CARGA_CARTERA.LAST LOOP

	        IF i=1 THEN
		        lhFolio         := Tab_CARGA_CARTERA(i).NUM_FOLIO;
		        lhPref_Plaza    := Tab_CARGA_CARTERA(i).PREF_PLAZA;
		        lMonto          := 0;
				lhSec_CuotaAnt  := Tab_CARGA_CARTERA(i).SEC_CUOTA;
			END IF;
            lhNum_secuenci  := Tab_CARGA_CARTERA(i).NUM_SECUENCI ;
            lhCod_tipdocum  := Tab_CARGA_CARTERA(i).COD_TIPDOCUM ;
            lhCod_vendedor  := Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE ;
            lhLetra         := Tab_CARGA_CARTERA(i).LETRA ;
            lhCod_centremi  := Tab_CARGA_CARTERA(i).COD_CENTREMI ;
            lhSec_cuota     := Tab_CARGA_CARTERA(i).SEC_CUOTA;

            IF Tab_CARGA_CARTERA(i).SW='SI' THEN
               BEGIN
                    /* Pago entero */
                    IF TO_NUMBER(Tab_CARGA_CARTERA(i).NUM_CUOTA) != -1 THEN



                        vp_OutRetorno := 999;
                        vp_Gls_Error := 'INSERT INTO CO_CANCELADOS (Pago Ent).';
                        INSERT INTO CO_CANCELADOS (
                               COD_CLIENTE   ,  COD_TIPDOCUM   , COD_CENTREMI   ,  NUM_SECUENCI      ,  COD_VENDEDOR_AGENTE , LETRA          ,
                               COD_CONCEPTO  ,  COLUMNA        , COD_PRODUCTO   ,  IMPORTE_HABER     ,  NUM_TRANSACCION     , IMPORTE_DEBE   ,
                               IND_CONTADO   ,  IND_FACTURADO  , FEC_EFECTIVIDAD,  FEC_CANCELACION   ,  IND_PORTADOR        , FEC_PAGO       ,
                               FEC_CADUCIDA  ,  FEC_ANTIGUEDAD , FEC_VENCIMIE   ,  NUM_CUOTA         ,  SEC_CUOTA           , NUM_VENTA      ,
                               NUM_ABONADO   ,  NUM_FOLIO      , PREF_PLAZA             ,  NUM_FOLIOCTC          ,  COD_OPERADORA_SCL   , COD_PLAZA              )
                        SELECT COD_CLIENTE   ,  COD_TIPDOCUM   , COD_CENTREMI   ,  NUM_SECUENCI      ,  COD_VENDEDOR_AGENTE , LETRA          ,
                               COD_CONCEPTO  ,  COLUMNA        , COD_PRODUCTO   ,  IMPORTE_DEBE      ,  0                   , IMPORTE_DEBE   ,
                               IND_CONTADO   ,  IND_FACTURADO  , FEC_EFECTIVIDAD,  TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS') , 0  ,
                               SYSDATE       ,  FEC_CADUCIDA   , FEC_ANTIGUEDAD ,  FEC_VENCIMIE      ,  NUM_CUOTA           , SEC_CUOTA      ,
                               NUM_VENTA     ,  NUM_ABONADO    , NUM_FOLIO      ,  PREF_PLAZA        ,  NUM_FOLIOCTC        ,
                               COD_OPERADORA_SCL   , COD_PLAZA
                        FROM   CO_CARTERA
                        WHERE  NVL(COD_CLIENTE,COD_CLIENTE) = lCod_cliente
                        AND    NUM_SECUENCI                     = lhNum_secuenci
                        AND    COD_TIPDOCUM                     = lhCod_tipdocum
                        AND    COD_VENDEDOR_AGENTE              = lhCod_vendedor
                        AND    LETRA                            = lhLetra
                        AND    COD_CENTREMI                     = lhCod_centremi
                        AND    SEC_CUOTA                        = lhSec_cuota   ;

                        vp_Gls_Error := 'DELETE FROM CO_CARTERA (Pago Ent).';
                        DELETE FROM CO_CARTERA
                        WHERE  NVL(COD_CLIENTE,COD_CLIENTE)  = lCod_cliente
                        AND    NUM_SECUENCI                      = lhNum_secuenci
                        AND    COD_TIPDOCUM                      = lhCod_tipdocum
                        AND    COD_VENDEDOR_AGENTE               = lhCod_vendedor
                        AND    LETRA                             = lhLetra
                        AND    COD_CENTREMI                      = lhCod_centremi
                        AND    SEC_CUOTA                         = lhSec_cuota   ;
                    ELSE
                        vp_OutRetorno := 999;
                        vp_Gls_Error := 'INSERT INTO CO_CANCELADOS II(Pago Ent).';
                        INSERT INTO CO_CANCELADOS (
                               COD_CLIENTE   ,  COD_TIPDOCUM   , COD_CENTREMI   ,  NUM_SECUENCI      ,  COD_VENDEDOR_AGENTE , LETRA          ,
                               COD_CONCEPTO  ,  COLUMNA        , COD_PRODUCTO   ,  IMPORTE_HABER     ,  NUM_TRANSACCION     , IMPORTE_DEBE   ,
                               IND_CONTADO   ,  IND_FACTURADO  , FEC_EFECTIVIDAD,  FEC_CANCELACION   ,  IND_PORTADOR        , FEC_PAGO       ,
                               FEC_CADUCIDA  ,  FEC_ANTIGUEDAD , FEC_VENCIMIE   ,  NUM_CUOTA         ,  SEC_CUOTA           , NUM_VENTA      ,
                               NUM_ABONADO   ,  NUM_FOLIO      , PREF_PLAZA             ,  NUM_FOLIOCTC          ,  COD_OPERADORA_SCL   , COD_PLAZA              )
                        SELECT COD_CLIENTE   ,  COD_TIPDOCUM   , COD_CENTREMI   ,  NUM_SECUENCI      ,  COD_VENDEDOR_AGENTE , LETRA          ,
                               COD_CONCEPTO  ,  COLUMNA        , COD_PRODUCTO   ,  IMPORTE_DEBE      ,  0                   , IMPORTE_DEBE   ,
                               IND_CONTADO   ,  IND_FACTURADO  , FEC_EFECTIVIDAD,  TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS') , 0  ,
                               SYSDATE       ,  FEC_CADUCIDA   , FEC_ANTIGUEDAD ,  FEC_VENCIMIE      ,  NUM_CUOTA           , SEC_CUOTA      ,
                               NUM_VENTA     ,  NUM_ABONADO    , NUM_FOLIO      ,  PREF_PLAZA        ,  NUM_FOLIOCTC        ,
                               COD_OPERADORA_SCL   , COD_PLAZA
                        FROM   CO_CARTERA
                        WHERE  NVL(COD_CLIENTE,COD_CLIENTE) = lCod_cliente
                        AND    NUM_SECUENCI                 = lhNum_secuenci
                        AND    COD_TIPDOCUM                 = lhCod_tipdocum
                        AND    COD_VENDEDOR_AGENTE          = lhCod_vendedor
                        AND    LETRA                        = lhLetra
                        AND    COD_CENTREMI                 = lhCod_centremi
                        AND    (SEC_CUOTA                   IS NULL OR SEC_CUOTA = 0);

                        vp_Gls_Error := 'DELETE FROM CO_CARTERA II(Pago Ent).';
                        DELETE FROM CO_CARTERA
                        WHERE  NVL(COD_CLIENTE,COD_CLIENTE) = lCod_cliente
                        AND    NUM_SECUENCI                 = lhNum_secuenci
                        AND    COD_TIPDOCUM                 = lhCod_tipdocum
                        AND    COD_VENDEDOR_AGENTE          = lhCod_vendedor
                        AND    LETRA                        = lhLetra
                        AND    COD_CENTREMI                 = lhCod_centremi
                        AND    (SEC_CUOTA                   IS NULL OR SEC_CUOTA = 0);
                    END IF;

                END;
            ELSE
               /* Pago Parcial */
               BEGIN
                    --g_monto := to_number(dTotal_pago);
                    IF TO_NUMBER(Tab_CARGA_CARTERA(i).NUM_CUOTA) != 0 THEN

                        IF ( g_monto > 0 AND g_monto IS NOT NULL ) THEN
                            FOR R IN c_tab LOOP

                                g_monto_concepto := R.importe_debe - R.importe_haber;
                                IF (g_monto >= g_monto_concepto ) THEN
                                    g_monto := g_monto - g_monto_concepto;

                                    vp_OutRetorno := 999;
                                    vp_Gls_Error := 'INSERT INTO CO_CANCELADOS (Pago Parc.).';
                                    INSERT INTO CO_CANCELADOS
                                           (COD_CLIENTE        ,COD_TIPDOCUM       ,COD_CENTREMI       ,NUM_SECUENCI       ,COD_VENDEDOR_AGENTE,
                                            LETRA              ,COD_CONCEPTO       ,COLUMNA            ,COD_PRODUCTO       ,IMPORTE_DEBE       ,
                                            NUM_TRANSACCION    ,IMPORTE_HABER      ,IND_CONTADO        ,IND_FACTURADO      ,FEC_EFECTIVIDAD    ,
                                            FEC_CANCELACION    ,IND_PORTADOR       ,FEC_PAGO           ,FEC_CADUCIDA       ,FEC_ANTIGUEDAD     ,
                                            FEC_VENCIMIE       ,NUM_CUOTA          ,SEC_CUOTA          ,NUM_VENTA          ,NUM_ABONADO        ,
                                            NUM_FOLIO          ,PREF_PLAZA         ,NUM_FOLIOCTC       ,COD_OPERADORA_SCL  ,COD_PLAZA )
                                    SELECT  COD_CLIENTE        ,COD_TIPDOCUM       ,COD_CENTREMI       ,NUM_SECUENCI       ,COD_VENDEDOR_AGENTE,
                                            LETRA              ,COD_CONCEPTO       ,COLUMNA            ,COD_PRODUCTO       ,IMPORTE_DEBE        ,
                                            0                  ,IMPORTE_DEBE       ,IND_CONTADO        ,IND_FACTURADO      ,FEC_EFECTIVIDAD    ,
                                            TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS')             ,
                                            0                  ,SYSDATE            ,FEC_CADUCIDA       ,FEC_ANTIGUEDAD     ,
                                            FEC_VENCIMIE       ,NUM_CUOTA          ,SEC_CUOTA          ,NUM_VENTA          ,NUM_ABONADO        ,
                                            NUM_FOLIO          ,PREF_PLAZA         ,NUM_FOLIOCTC       ,COD_OPERADORA_SCL  ,COD_PLAZA
                                    FROM    CO_CARTERA
                                    WHERE   COD_CLIENTE          = lCod_cliente
                                    AND     NUM_SECUENCI         = lhNum_secuenci
                                    AND     COD_TIPDOCUM         = lhCod_tipdocum
                                    AND     COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND     LETRA                = lhLetra
                                    AND     COD_CENTREMI         = lhCod_centremi
                                    AND     NUM_ABONADO          = R.NUM_ABONADO
                                    AND     COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND     COLUMNA              = R.COLUMNA
                                    AND     SEC_CUOTA            = R.SEC_CUOTA;

                                    vp_Gls_Error := 'DELETE FROM CO_CARTERA (Pago Parc.).';
                                    DELETE FROM CO_CARTERA
                                    WHERE  COD_CLIENTE          = lCod_cliente
                                    AND    NUM_SECUENCI         = lhNum_secuenci
                                    AND    COD_TIPDOCUM         = lhCod_tipdocum
                                    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND    LETRA                = lhLetra
                                    AND    COD_CENTREMI         = lhCod_centremi
                                    AND    NUM_ABONADO          = R.NUM_ABONADO
                                    AND    COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND    COLUMNA              = R.COLUMNA
                                    AND    SEC_CUOTA            = R.SEC_CUOTA;

                                ELSE

                                    vp_OutRetorno := 999;
                                    vp_Gls_Error := 'UPDATE CO_CARTERA SET (Pago Parc.).';
                                    UPDATE CO_CARTERA SET
                                           IMPORTE_HABER = IMPORTE_HABER + GE_PAC_GENERAL.REDONDEA(g_monto, iDecimal, 0)
                                    WHERE  COD_CLIENTE          = lCod_cliente
                                    AND    NUM_SECUENCI         = lhNum_secuenci
                                    AND    COD_TIPDOCUM         = lhCod_tipdocum
                                    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND    LETRA                = lhLetra
                                    AND    COD_CENTREMI         = lhCod_centremi
                                    AND    NUM_ABONADO          = R.NUM_ABONADO
                                    AND    COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND    COLUMNA              = R.COLUMNA
                                    AND    SEC_CUOTA            = R.SEC_CUOTA;

                                    EXIT;
                                END IF;
                            END LOOP;
                        END IF;
                    ELSE
                        IF ( g_monto > 0 AND g_monto IS NOT NULL ) THEN
                            FOR R IN c_tab1 LOOP

                                R:=R;
                                g_monto_concepto := R.importe_debe - R.importe_haber;
                                IF (g_monto >= g_monto_concepto ) THEN
                                    g_monto := g_monto - g_monto_concepto;

                                    vp_OutRetorno := 999;
                                    vp_Gls_Error := 'INSERT INTO CO_CANCELADOS II(Pago Parc.).';
                                    INSERT INTO CO_CANCELADOS
                                           (COD_CLIENTE       ,COD_TIPDOCUM       ,COD_CENTREMI       ,NUM_SECUENCI       ,COD_VENDEDOR_AGENTE,
                                            LETRA              ,COD_CONCEPTO       ,COLUMNA            ,COD_PRODUCTO       ,IMPORTE_DEBE       ,
                                            NUM_TRANSACCION    ,IMPORTE_HABER      ,IND_CONTADO        ,IND_FACTURADO      ,FEC_EFECTIVIDAD    ,
                                            FEC_CANCELACION    ,IND_PORTADOR       ,FEC_PAGO           ,FEC_CADUCIDA       ,FEC_ANTIGUEDAD     ,
                                            FEC_VENCIMIE       ,NUM_CUOTA          ,SEC_CUOTA          ,NUM_VENTA          ,NUM_ABONADO        ,
                                            NUM_FOLIO          ,PREF_PLAZA                 ,NUM_FOLIOCTC       ,COD_OPERADORA_SCL  ,COD_PLAZA)
                                    SELECT  COD_CLIENTE        ,COD_TIPDOCUM       ,COD_CENTREMI       ,NUM_SECUENCI       ,COD_VENDEDOR_AGENTE,
                                            LETRA              ,COD_CONCEPTO       ,COLUMNA            ,COD_PRODUCTO       ,IMPORTE_DEBE       ,
                                            0                  ,IMPORTE_DEBE       ,IND_CONTADO        ,IND_FACTURADO      ,FEC_EFECTIVIDAD    ,
                                            TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS')       ,
                                            0                  ,SYSDATE            ,FEC_CADUCIDA       ,FEC_ANTIGUEDAD     ,
                                            FEC_VENCIMIE       ,NUM_CUOTA          ,SEC_CUOTA          ,NUM_VENTA          ,NUM_ABONADO        ,
                                            NUM_FOLIO          ,PREF_PLAZA                 ,NUM_FOLIOCTC           ,COD_OPERADORA_SCL  ,COD_PLAZA
                                    FROM    CO_CARTERA
                                    WHERE   COD_CLIENTE          = lCod_cliente
                                    AND     NUM_SECUENCI         = lhNum_secuenci
                                    AND     COD_TIPDOCUM         = lhCod_tipdocum
                                    AND     COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND     LETRA                = lhLetra
                                    AND     COD_CENTREMI         = lhCod_centremi
                                    AND     NUM_ABONADO          = R.NUM_ABONADO
                                    AND     COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND     COLUMNA              = R.COLUMNA
                                    AND     (SEC_CUOTA           IS NULL OR SEC_CUOTA = 0);

                                    vp_Gls_Error := 'DELETE FROM CO_CARTERA II(Pago Parc.).';
                                    DELETE FROM CO_CARTERA
                                    WHERE  COD_CLIENTE          = lCod_cliente
                                    AND    NUM_SECUENCI         = lhNum_secuenci
                                    AND    COD_TIPDOCUM         = lhCod_tipdocum
                                    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND    LETRA                = lhLetra
                                    AND    COD_CENTREMI         = lhCod_centremi
                                    AND    NUM_ABONADO          = R.NUM_ABONADO
                                    AND    COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND    COLUMNA              = R.COLUMNA
                                    AND    (SEC_CUOTA           IS NULL OR SEC_CUOTA = 0);

                                ELSE

                                    vp_OutRetorno := 999;
                                    vp_Gls_Error := 'UPDATE CO_CARTERA SET II(Pago Parc.).';
                                    UPDATE CO_CARTERA SET
                                           IMPORTE_HABER = IMPORTE_HABER + GE_PAC_GENERAL.REDONDEA(g_monto, iDecimal, 0)
                                    WHERE  COD_CLIENTE          = lCod_cliente
                                    AND    NUM_SECUENCI         = lhNum_secuenci
                                    AND    COD_TIPDOCUM         = lhCod_tipdocum
                                    AND    COD_VENDEDOR_AGENTE  = lhCod_vendedor
                                    AND    LETRA                = lhLetra
                                    AND    COD_CENTREMI         = lhCod_centremi
                                    AND    NUM_ABONADO          = R.NUM_ABONADO
                                    AND    COD_CONCEPTO         = R.COD_CONCEPTO
                                    AND    COLUMNA              = R.COLUMNA
                                    AND    (SEC_CUOTA           IS NULL OR SEC_CUOTA = 0);

                                    EXIT;

                                END IF;
                            END LOOP;
                        END IF;
                    END IF;
               END;

            END IF;

			--Si Cambia de Documento, Calcula el Castigo Contable del Anterior
			IF Tab_CARGA_CARTERA(i).NUM_FOLIO <> lhFolio or Tab_CARGA_CARTERA(i).PREF_PLAZA<>lhPref_Plaza or Tab_CARGA_CARTERA(i).SEC_CUOTA <>lhSec_CuotaAnt THEN
				vp_Gls_Error := 'CO_CASTIGOS_EXTERNOS (Pago Ent),';
				CO_CASTIGOS_EXTERNOS(lCod_cliente,lhFolio, lhPref_Plaza,TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS'),lMonto ,1,lhSec_CuotaAnt,vRetorno);
				lMonto := 0;
			END IF;
			lMonto          := lMonto + Tab_CARGA_CARTERA(i).MONTO;
            lhFolio         := Tab_CARGA_CARTERA(i).NUM_FOLIO;
			lhPref_Plaza    := Tab_CARGA_CARTERA(i).PREF_PLAZA;
			lhSec_CuotaAnt  := Tab_CARGA_CARTERA(i).SEC_CUOTA;

        END LOOP;

		--Castigo Contable del ultimo Documento Pagado
		vp_Gls_Error := 'CO_CASTIGOS_EXTERNOS (Pago Ent),';
		CO_CASTIGOS_EXTERNOS(lCod_cliente,lhFolio, lhPref_Plaza,TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS'),lMonto ,1,lhSec_CuotaAnt,vRetorno);


    END IF;

	--83
    vp_Gls_Error := 'FOR Reg IN c_DocReg';
    FOR Reg IN c_DocReg LOOP

        vp_Gls_Error := 'c_DocReg ==> lCod_cliente:'||lCod_cliente||'  NUM_SECUENCI:'||Reg.NUM_SECUENCI;
        IF (dTotal_pago = 0 AND dSaldoAux > 0) OR  (dTotal_pago < 1 AND dSaldo > 0) THEN

            vp_OutRetorno := 999;
            vp_Gls_Error := 'INSERT INTO CO_CANCELADOS (Total_pago=0,SaldoAux>0 )';
            INSERT INTO CO_CANCELADOS
                  (COD_CLIENTE      ,COD_TIPDOCUM    ,COD_CENTREMI      ,NUM_SECUENCI    ,COD_VENDEDOR_AGENTE ,
                   LETRA            ,COD_CONCEPTO    ,COLUMNA           ,COD_PRODUCTO    ,IMPORTE_DEBE        ,
                   NUM_TRANSACCION  ,IMPORTE_HABER   ,IND_CONTADO       ,IND_FACTURADO   ,FEC_EFECTIVIDAD     ,
                   FEC_CANCELACION  ,IND_PORTADOR    ,FEC_PAGO          ,FEC_CADUCIDA    ,FEC_ANTIGUEDAD      ,
                   FEC_VENCIMIE     ,NUM_CUOTA       ,SEC_CUOTA         ,NUM_VENTA       ,NUM_ABONADO         ,
                   NUM_FOLIO        ,PREF_PLAZA      ,NUM_FOLIOCTC      ,COD_OPERADORA_SCL ,COD_PLAZA       )
            SELECT COD_CLIENTE      ,COD_TIPDOCUM    ,COD_CENTREMI      ,NUM_SECUENCI    ,COD_VENDEDOR_AGENTE ,
                   LETRA            ,COD_CONCEPTO    ,COLUMNA           ,COD_PRODUCTO    ,IMPORTE_HABER       ,
                   0                ,IMPORTE_HABER   ,IND_CONTADO       ,IND_FACTURADO   ,FEC_EFECTIVIDAD     ,
                   TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS')       ,
                   0                ,SYSDATE         ,FEC_CADUCIDA      ,FEC_ANTIGUEDAD  ,
                   FEC_VENCIMIE     ,NUM_CUOTA       ,SEC_CUOTA         ,NUM_VENTA       ,NUM_ABONADO         ,
                   NUM_FOLIO        ,PREF_PLAZA      ,NUM_FOLIOCTC      ,COD_OPERADORA_SCL ,COD_PLAZA
            FROM   CO_CARTERA
            WHERE  COD_CLIENTE   = lCod_cliente
            AND    NUM_SECUENCI  = Reg.NUM_SECUENCI
            AND    COD_TIPDOCUM  = Reg.COD_TIPDOCUM
            AND    COD_VENDEDOR_AGENTE = Reg.COD_VENDEDOR_AGENTE
            AND    LETRA         = Reg.LETRA
            AND    COD_CENTREMI  = Reg.COD_CENTREMI
            AND    COD_CONCEPTO  = Reg.COD_CONCEPTO
            AND    COLUMNA       = Reg.COLUMNA      ;


            vp_Gls_Error := 'DELETE FROM CO_CARTERA (Total_pago=0,SaldoAux>0 )';
            DELETE FROM CO_CARTERA
            WHERE  COD_CLIENTE   = lCod_cliente
            AND    NUM_SECUENCI  = Reg.NUM_SECUENCI
            AND    COD_TIPDOCUM  = Reg.COD_TIPDOCUM
            AND    COD_VENDEDOR_AGENTE = Reg.COD_VENDEDOR_AGENTE
            AND    LETRA         = Reg.LETRA
            AND    COD_CENTREMI  = Reg.COD_CENTREMI
            AND    COD_CONCEPTO  = Reg.COD_CONCEPTO
            AND    COLUMNA       = Reg.COLUMNA      ;

        ELSIF dSaldoAux > 0 THEN

            vp_OutRetorno := 999;
            vp_Gls_Error := 'UPDATE CO_CARTERA SET (SaldoAux>0 )';
            UPDATE CO_CARTERA SET
                   IMPORTE_DEBE  = dSaldoAux
            WHERE  COD_CLIENTE   = lCod_cliente
            AND    NUM_SECUENCI  = Reg.NUM_SECUENCI
            AND    COD_TIPDOCUM  = Reg.COD_TIPDOCUM
            AND    COD_VENDEDOR_AGENTE = Reg.COD_VENDEDOR_AGENTE
            AND    LETRA         = Reg.LETRA
            AND    COD_CENTREMI  = Reg.COD_CENTREMI
            AND    COD_CONCEPTO  = Reg.COD_CONCEPTO
            AND    COLUMNA       = Reg.COLUMNA      ;

        END IF;

		--SOPORTE, Solo Elimina o Actualiza un documento de Regularizacion
		EXIT;

    END LOOP;

    vp_OutRetorno:=0;
    vp_OutGlosa  :='OK';
    COMMIT;

EXCEPTION
    WHEN ERROR_PROCESO THEN
         ROLLBACK;
         vp_OutRetorno := 1;
         vp_OutGlosa  := 'Error de Proceso : '||vp_Gls_Error;
         v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - ';
         v_sqlcode := SQLCODE;
         INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
         VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
         COMMIT;
    WHEN NO_DATA_FOUND THEN
         IF vp_OutRetorno > 1 THEN
            ROLLBACK;
         END IF;
         vp_OutRetorno := 1;
         vp_OutGlosa  := 'Error Sql : '||sqlerrm;
         v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || sqlerrm;
         v_sqlcode := SQLCODE;
         INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
         VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
         COMMIT;
    WHEN OTHERS THEN
         ROLLBACK;
         vp_OutRetorno := 1;
         vp_OutGlosa  := 'Error Sql : '||sqlerrm;
         v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || sqlerrm;
         v_sqlcode := SQLCODE;
         INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
         VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
         COMMIT;
END CO_CANCELAREGU;
/
SHOW ERRORS
