CREATE OR REPLACE PACKAGE BODY Co_Aplica_Pago_Distribuidor_PG IS
Procedure CO_P_APLICA_PAGO (lCod_cliente  IN NUMBER ,
    			    vp_Imp_pago   IN NUMBER,
    			    vp_folio 	  IN NUMBER ,
    			    vp_plaza      IN VARCHAR2,
    			    vp_OutGlosa   OUT VARCHAR2,
    			    vp_OutRetorno OUT NUMBER  ) IS
lSecCompago         NUMBER(12);
lPref_Plaza         CO_CARTERA.PREF_PLAZA%TYPE;
lSec_Pago           NUMBER(12);
vp_Secu_Compago   NUMBER(12);
lNumSecuenciCon     NUMBER(12);
iDecimal            NUMBER(2);
vRetorno            NUMBER(10);
v_sqlcode           VARCHAR2(10);
v_sqlerrm           VARCHAR2(255);
vp_Gls_Error        VARCHAR2(255);
dTotal_pago         NUMBER(14,4);
dSaldo              NUMBER(14,4);
dSaldoAux           NUMBER(14,4);
sPasoFolio          VARCHAR2(30);
sPasoFolio2         VARCHAR2(30);
iPos1               NUMBER(5);
iPos2               NUMBER(5);
iPos3               NUMBER(5);
iPos4               NUMBER(5);
vp_retorno		    NUMBER;
lNum_Folio          CO_CARTERA.NUM_FOLIO%TYPE;
--vp_folio                 CO_CARTERA.NUM_FOLIO%TYPE;
--vp_Imp_pago     CO_CARTERA.IMPORTE_DEBE%TYPE;
vp_Fecha_efec   VARCHAR2(22);
lPref_Plaza2        CO_CARTERA.PREF_PLAZA%TYPE;
vp_Pref_Plaza     CO_CARTERA.PREF_PLAZA%TYPE;
sNom_User           CO_CAJEROS.NOM_USUARORA%TYPE;
sNom_proceso        CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
--lCod_cliente        GA_ABOCEL.COD_CLIENTE%TYPE;
sCodProducto        GE_DATOSGENER.PROD_GENERAL%TYPE;
iCod_caja           CO_EMPRESAS_REX.COD_CAJA%TYPE;
vp_Cod_Oficina      CO_EMPRESAS_REX.COD_OFICINA%TYPE;
sCod_Operadora      CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
iDocumPago          CO_DATGEN.DOC_COMPAGO%TYPE;
iDoc_Pago           CO_DATGEN.DOC_PAGO%TYPE;
iDoc_Factcontado    CO_DATGEN.DOC_FACTCONTADO%TYPE;
iConcep_Pag         CO_DATGEN.CONCEP_PAG%TYPE;
iAgenteInterno      CO_DATGEN.AGENTE_INTERNO%TYPE;
sLetraCobros        CO_DATGEN.LETRA_COBROS%TYPE;
iTipDocAnt          CO_CARTERA.COD_TIPDOCUM%TYPE;
iVendAgenAnt        CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE;
sLetraAnt           CO_CARTERA.LETRA%TYPE;
iCodCentAnt         CO_CARTERA.COD_CENTREMI%TYPE;
lNumSecAnt          CO_CARTERA.NUM_SECUENCI%TYPE;
lNumFolioAnt        CO_CARTERA.NUM_FOLIO%TYPE;
lNumPrefijo_PlazaAnt CO_CARTERA.PREF_PLAZA%TYPE;
iSecCuotAnt         CO_CARTERA.SEC_CUOTA%TYPE;
sCod_OperadorAbono  CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono     CO_CARTERA.COD_PLAZA%TYPE;
szVal_Param         GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sCod_Oficina        CO_EMPRESAS_REX.COD_OFICINA%TYPE;
iCantidad				 NUMBER(2);

/********************   ARREGLO PARA CO_CARTERA  **********************************************/
i BINARY_INTEGER := 0;
TYPE TipRegCartera IS RECORD (
        DES_ABREVIADA                   GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
        COD_TIPDOCUM                    CO_CARTERA.COD_TIPDOCUM%TYPE    ,
        COD_VENDEDOR_AGENTE             CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE,
        LETRA                           CO_CARTERA.LETRA%TYPE,
        COD_CENTREMI                    CO_CARTERA.COD_CENTREMI%TYPE,
        NUM_SECUENCI                    CO_CARTERA.NUM_SECUENCI%TYPE,
        NUM_FOLIO                       CO_CARTERA.NUM_FOLIO%TYPE,
        PREF_PLAZA                      CO_CARTERA.PREF_PLAZA%TYPE,
        FEC_EFECTIVIDAD                 VARCHAR2(10),
        FEC_VENCIMIE                    VARCHAR2(10),
        NUM_VENTA                       CO_CARTERA.NUM_VENTA%TYPE,
        IND_CONTADO                     CO_CARTERA.IND_CONTADO%TYPE,
        SEC_CUOTA                       CO_CARTERA.SEC_CUOTA%TYPE,
        IND_FACTURADO                   CO_CARTERA.IND_FACTURADO%TYPE,
        NUM_CUOTA                       CO_CARTERA.NUM_CUOTA%TYPE,
        SW                              VARCHAR2(2),
        MONTO                           NUMBER(18,4),
        COD_OPERADORA                   CO_CARTERA.COD_OPERADORA_SCL%TYPE,
        COD_PLAZA                       CO_CARTERA.COD_PLAZA%TYPE);
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
        NVL(A.NUM_VENTA,-1)         NUM_VENTA,
        A.IND_CONTADO               IND_CONTADO,
        NVL(A.SEC_CUOTA,-1)         SEC_CUOTA,
        A.IND_FACTURADO             IND_FACTURADO,
        NVL(A.NUM_CUOTA,-1)         NUM_CUOTA,
        ''                          SW,
        0                           MONTO,
        A.COD_OPERADORA_SCL         COD_OPERADORA,
        A.COD_PLAZA                 COD_PLAZA
FROM    CO_CARTERA A, GE_TIPDOCUMEN B
WHERE   A.COD_CLIENTE   = lCod_cliente
AND     A.NUM_FOLIO     = vp_folio
AND     A.PREF_PLAZA    = vp_plaza
AND     A.COD_TIPDOCUM  = B.COD_TIPDOCUM
--AND     A.COD_TIPDOCUM  NOT IN (5,39,59,60,61,62,64)
AND     A.COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
					   	   	  	FROM CO_CODIGOS
								WHERE NOM_TABLA = 'CO_CARTERA'
								AND NOM_COLUMNA = 'COD_TIPDOCUM')
AND     A.COD_CONCEPTO NOT IN (2,6)
AND     A.IND_FACTURADO = 1
--ORDER BY  A.COD_TIPDOCUM, A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.PREF_PLAZA ASC, A.SEC_CUOTA ASC;
ORDER BY  A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.SEC_CUOTA ASC;

ERROR_PROCESO EXCEPTION ;
/****** Inicio  ******/
BEGIN

    vp_Gls_Error := '';

    sNom_proceso :='Co_Aplica_Pago_Distribuidor_PG. Cliente : '||lCod_cliente;
    vp_Secu_Compago:=0;
    vp_Pref_Plaza  :=' ';
    vp_retorno :=0;

    vp_Gls_Error := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
    SELECT Ge_Pac_General.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;

	SELECT COUNT(1) INTO iCantidad FROM CO_CARTERA
    WHERE   COD_CLIENTE   = lCod_cliente
    AND     NUM_FOLIO     = vp_folio
   AND    PREF_PLAZA    = vp_plaza;

   IF iCantidad =0 THEN
        vp_Gls_Error := 'No se encontraron facturas en la cartera para cliente: '||lCod_cliente;
        RAISE ERROR_PROCESO;
	END IF;

    vp_Gls_Error := 'select sysdate' ;
    SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') INTO vp_Fecha_efec FROM dual;

    vp_Gls_Error := 'Fn_Obtiene_Plazacliente. Cliente : '||lCod_cliente;
    SELECT Fn_Obtiene_Plazacliente(lCod_cliente)
    INTO   sCod_PlazaAbono
    FROM   DUAL;

    /***** Selecciona Codigo de Oficina, Caja y Nombre de usuario ****/
    vp_Gls_Error := 'Select CO_EMPRESA_REX';
    SELECT A.COD_OFICINA    , A.COD_CAJA  , B.NOM_USUARORA, A.COD_OPERADORA_SCL
    INTO   vp_Cod_Oficina   , iCod_caja   , sNom_User, sCod_Operadora
    FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
    WHERE  A.EMP_RECAUDADORA = 'RDB'
    AND    A.COD_OFICINA     = B.COD_OFICINA
    AND    A.COD_CAJA        = B.COD_CAJA;

    /*Obtiene Oficina*/
    vp_Gls_Error :='SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
    SELECT VAL_PARAMETRO
    INTO   szVal_Param
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO = 'OFICINA_FOLIO'
    AND    COD_MODULO = 'RE';

    vp_Gls_Error :='IF szVal_Param != "0" THEN';
    IF szVal_Param != '0' THEN
       sCod_Oficina:=szVal_Param;
    ELSE
       sCod_Oficina:=vp_Cod_Oficina;
    END IF;

    /**** Datos Generales ****/
    vp_Gls_Error := 'Select CO_DATGEN.';
    SELECT DOC_PAGO  , DOC_COMPAGO, DOC_FACTCONTADO , CONCEP_PAG , AGENTE_INTERNO, LETRA_COBROS
    INTO   iDoc_Pago , iDocumPago , iDoc_Factcontado, iConcep_Pag, iAgenteInterno, sLetraCobros
    FROM   CO_DATGEN;

    vp_Gls_Error := 'SELECT PROD_GENERAL FROM GE_DATOSGENER.';
    SELECT PROD_GENERAL
    INTO   sCodProducto
    FROM   GE_DATOSGENER;

    vp_Gls_Error := 'SELECT COD_OPERADORA. Cliente : '||lCod_cliente;
    SELECT COD_OPERADORA
    INTO   sCod_OperadorAbono
    FROM   GE_CLIENTES
    WHERE  COD_CLIENTE = lCod_cliente;


    /*****  Selecciona diversas secuencias *****/
    vp_Gls_Error := 'Select CO_SEQ_PAGO.NEXTVAL(1).';
    SELECT CO_SEQ_PAGO.NEXTVAL
    INTO   lSec_Pago
    FROM   DUAL;

    --Secuencia de Comprobante de Pago
    vp_Gls_Error := 'FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN. NO SE ENCONTRARON FOLIOS DISPONIBLES.';
    SELECT Fa_Foliacion_Pg.FA_CONSUME_FOLIO_FN(iDoc_Pago,NULL,sCod_oficina,sCod_Operadora,NULL,NULL,NULL,SYSDATE,1)
    INTO   sPasoFolio
    FROM   DUAL;

    --Separa Datos entregados por la funcion anterior
    iPos1             := INSTR(sPasoFolio,';',1);
    iPos2             := LENGTH(sPasoFolio) - iPos1;
    sPasoFolio2       := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
    iPos3             := INSTR(sPasoFolio2,';',1);
    iPos4             := LENGTH(sPasoFolio2)- iPos3;
    lSecCompago       := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
    lPref_Plaza       := SUBSTR(sPasoFolio2,1,iPos3 - 1);

    dTotal_pago:=TO_NUMBER(vp_Imp_pago);

    IF dTotal_pago > 0 THEN

        /******   Insertar en Co_pagos  ******/
        vp_Gls_Error := 'INSERT INTO CO_PAGOS.';
        INSERT INTO CO_PAGOS
               (COD_TIPDOCUM    , COD_VENDEDOR_AGENTE   , LETRA           , COD_CENTREMI,
                NUM_SECUENCI    , COD_CLIENTE           , IMP_PAGO        , FEC_EFECTIVIDAD,
                COD_CAJA        , FEC_VALOR             , NOM_USUARORA    , COD_FORPAGO,
                COD_SISPAGO     , COD_ORIPAGO           , COD_CAUPAGO     , COD_BANCO,
                COD_TIPTARJETA  , COD_SUCURSAL          , CTA_CORRIENTE   , NUM_TARJETA,
                DES_PAGO        , NUM_COMPAGO           , PREF_PLAZA)
      --VALUES (iDoc_Pago       , 100001                , 'X'             , 1           ,
        VALUES (iDoc_Pago       , iAgenteInterno        , sLetraCobros    , 1           ,
                lSec_Pago       , lCod_cliente          , Ge_Pac_General.REDONDEA(vp_Imp_pago, iDecimal, 0), SYSDATE,
                iCod_caja       , SYSDATE		, sNom_User, 0  ,
                --TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS'), sNom_User, 0  ,
                3               , 2                     , 1               , NULL        ,
                NULL            , NULL                  , NULL       , NULL                ,
                'Pago Efectuado por Distribuidor'   , lSecCompago     , lPref_Plaza);
		vp_retorno:=1;
        /********** Procesa Co_Cartera *******/
        i :=0;
        iTipDocAnt  := 0;
        iVendAgenAnt:= 0;
        sLetraAnt   := '';
        iCodCentAnt := 0;
        lNumSecAnt  := 0;
        lNumFolioAnt:= 0;
        lNumPrefijo_PlazaAnt := 0;
        iSecCuotAnt := 0;
        dSaldoAux   := 0;

        vp_Gls_Error := 'Recorre Cursor Co_Cartera03.';
        BEGIN

            FOR rReg IN Co_Cartera03 LOOP

                IF rReg.SEC_CUOTA < 0 THEN rReg.SEC_CUOTA:=NULL; END IF;
                IF rReg.NUM_VENTA < 0 THEN rReg.NUM_VENTA:=NULL; END IF;
                IF rReg.NUM_CUOTA < 0 THEN rReg.NUM_CUOTA:=NULL; END IF;

                IF rReg.COD_TIPDOCUM = iTipDocAnt AND rReg.COD_VENDEDOR_AGENTE = iVendAgenAnt AND rReg.LETRA = sLetraAnt
                                                  AND rReg.COD_CENTREMI = iCodCentAnt         AND rReg.NUM_SECUENCI = lNumSecAnt
                                                  AND rReg.NUM_FOLIO = lNumFolioAnt           AND rReg.PREF_PLAZA = lNumPrefijo_PlazaAnt
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
                        lNumPrefijo_PlazaAnt := rReg.PREF_PLAZA;
                        iSecCuotAnt := rReg.SEC_CUOTA;

                        /***** Si el pago tiene cuotas *****/
                        IF iSecCuotAnt IS NOT NULL THEN
                            BEGIN
                                vp_Gls_Error := 'SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) FROM CO_CARTERA(1).';
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
                                AND     PREF_PLAZA   = lNumPrefijo_PlazaAnt
                                AND     SEC_CUOTA    = iSecCuotAnt ;
                            END;
                        ELSE
                            BEGIN
                                vp_Gls_Error := 'SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) FROM CO_CARTERA(2).';
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
                                AND     PREF_PLAZA   = lNumPrefijo_PlazaAnt;

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

    /*****  Si quedo saldo se genera abono *****/
    IF dTotal_pago > 0 THEN
        BEGIN

            --Obtiene Secuencia de Pago
            vp_gls_error := 'Select CO_SEQ_PAGO.NEXTVAL FROM DUAL(2).';
            SELECT CO_SEQ_PAGO.NEXTVAL
            INTO   lNumSecuenciCon
            FROM   DUAL;

            vp_Gls_Error := 'FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN. NO SE ENCONTRARON FOLIOS DISPONIBLES.';
            SELECT Fa_Foliacion_Pg.FA_CONSUME_FOLIO_FN(iDoc_Pago,NULL,sCod_oficina,sCod_Operadora,NULL,NULL,NULL,SYSDATE,1)
            INTO   sPasoFolio
            FROM   DUAL;

            --Separa Datos entregados por la funcisn anterior
            iPos1                 := INSTR(sPasoFolio,';',1);
            iPos2                 := LENGTH(sPasoFolio) - iPos1;
            sPasoFolio2           := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
            iPos3                 := INSTR(sPasoFolio2,';',1);
            iPos4                 := LENGTH(sPasoFolio2)- iPos3;
            lNum_Folio            := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
            lPref_Plaza2          := SUBSTR(sPasoFolio2,1,iPos3 - 1);

            vp_Gls_Error := 'INSERT INTO CO_SECARTERA(1).';
            INSERT INTO CO_SECARTERA
                   (COD_TIPDOCUM    , COD_VENDEDOR_AGENTE , LETRA   , COD_CENTREMI,
                    NUM_SECUENCI    , COD_CONCEPTO        , COLUMNA )
            VALUES (iDoc_Pago       , iAgenteInterno      ,  sLetraCobros , 1    ,
                    lNumSecuenciCon , iConcep_Pag         , 1                     );
			vp_retorno:=1;
            vp_Gls_Error := 'INSERTA ABONO EN CO_CARTERA.';
            INSERT INTO CO_CARTERA
                   (COD_CLIENTE         , COD_TIPDOCUM              , COD_CENTREMI      ,
                    NUM_SECUENCI        , COD_VENDEDOR_AGENTE       , LETRA             ,
                    COD_CONCEPTO        , COLUMNA                   , COD_PRODUCTO      ,
                    IMPORTE_DEBE        , IMPORTE_HABER             , IND_CONTADO       ,
                    IND_FACTURADO       , FEC_EFECTIVIDAD           , FEC_VENCIMIE      ,
                    FEC_CADUCIDA        , FEC_ANTIGUEDAD            , FEC_PAGO          ,
                    NUM_ABONADO         , NUM_FOLIO                 , PREF_PLAZA        ,
                    NUM_CUOTA           , SEC_CUOTA                 , NUM_FOLIOCTC      ,
                    NUM_VENTA           , COD_OPERADORA_SCL         , COD_PLAZA         )
            VALUES (lCod_cliente        , iDoc_Pago                 , 1                 ,
                    lNumSecuenciCon     , iAgenteInterno            , sLetraCobros      ,
                    iConcep_Pag         , 1                         , 5                 ,
                    Ge_Pac_General.REDONDEA(dSaldoAux, iDecimal, 0) ,
                    Ge_Pac_General.REDONDEA(vp_Imp_pago,iDecimal,0) , 0                 ,
                    1                   , SYSDATE                   , TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS'),
                    TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS')  ,
                    TO_DATE(vp_Fecha_efec,'DD-MM-YYYY HH24:MI:SS')  , SYSDATE           ,
                    0                   , lNum_Folio                , lPref_Plaza2      ,
                    0                   , 0                         , 0                 ,
                    0                   , sCod_OperadorAbono        , sCod_PlazaAbono   );

            vp_Gls_Error := 'INSERT ABONO EN CO_PAGOSCONC. Secuencia : '||lSec_Pago;
            INSERT INTO CO_PAGOSCONC
                   (COD_TIPDOCUM        , COD_CENTREMI      , NUM_SECUENCI      ,
                    COD_VENDEDOR_AGENTE , LETRA             , IMP_CONCEPTO      ,
                    COD_PRODUCTO        , COD_TIPDOCREL     , COD_AGENTEREL     ,
                    LETRA_REL           , COD_CENTRREL      , NUM_SECUREL       ,
                    COD_CONCEPTO        , COLUMNA           , NUM_ABONADO       ,
                    NUM_FOLIO           , PREF_PLAZA        , NUM_CUOTA         ,
                    SEC_CUOTA           , NUM_FOLIOCTC      , NUM_VENTA         ,
                    COD_OPERADORA_SCL   , COD_PLAZA         )
            VALUES (iDoc_Pago           , 1                 , lSec_Pago         ,
                    iAgenteInterno      , sLetraCobros      , Ge_Pac_General.REDONDEA(dTotal_pago, iDecimal, 0),
                    sCodProducto        , iDoc_Pago         , iAgenteInterno    ,
                    sLetraCobros        , 1                 , lNumSecuenciCon   ,
                    iConcep_Pag         , 1                 , 0                 ,
                    lNum_Folio          , lPref_Plaza2      , 0                 ,
                    0                   , 0                 , 0                 ,
                    sCod_OperadorAbono  , sCod_PlazaAbono   );

        END;
    END IF;



IF Tab_CARGA_CARTERA(i).SW='SI' THEN
               BEGIN
                   vp_Gls_Error := 'LLAMADA A PL CO_P_PAGO_ENTERO.';
                   --CO_P_PAGO_ENTERO(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,'1',lSec_Pago,iDoc_Pago,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,'X','1',Tab_CARGA_CARTERA(i).SEC_CUOTA, vp_Fecha_efec);
                   Co_P_Pago_Entero(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,'1',lSec_Pago,iDoc_Pago, iAgenteInterno , sLetraCobros ,'1',Tab_CARGA_CARTERA(i).SEC_CUOTA, vp_Fecha_efec);
                   vp_Gls_Error := 'LLAMADA A PL CO_CASTIGOS_EXTERNOS (Ent).';

                   Co_Castigos_Externos(lCod_cliente, Tab_CARGA_CARTERA(i).NUM_FOLIO, Tab_CARGA_CARTERA(i).PREF_PLAZA, vp_Fecha_efec, Tab_CARGA_CARTERA(i).MONTO, 0, Tab_CARGA_CARTERA(i).SEC_CUOTA, vRetorno );
                   IF vRetorno !=0 THEN
                      RAISE ERROR_PROCESO;
                   END IF;

               END;
            ELSE
               BEGIN
                    vp_Gls_Error := 'LLAMADA A PL CO_P_PAGO_PARCIALES_FACTURA.';
                    --CO_P_PAGO_PARCIALES_FACTURA(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,'1',lSec_Pago,iDoc_Pago,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,'1',Tab_CARGA_CARTERA(i).MONTO,Tab_CARGA_CARTERA(i).SEC_CUOTA , vp_Fecha_efec);
                    Co_P_Pago_Parciales_Factura(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,'1',lSec_Pago,iDoc_Pago, iAgenteInterno ,sLetraCobros,'1',Tab_CARGA_CARTERA(i).MONTO,Tab_CARGA_CARTERA(i).SEC_CUOTA , vp_Fecha_efec);
                    vp_Gls_Error := 'LLAMADA A PL CO_CASTIGOS_EXTERNOS (Parc).';

                    Co_Castigos_Externos(lCod_cliente, Tab_CARGA_CARTERA(i).NUM_FOLIO, Tab_CARGA_CARTERA(i).PREF_PLAZA, vp_Fecha_efec, Tab_CARGA_CARTERA(i).MONTO, 1, Tab_CARGA_CARTERA(i).SEC_CUOTA, vRetorno );
                    IF vRetorno !=0 THEN
                        RAISE ERROR_PROCESO;
                    END IF;


               END;
            END IF;

    vp_Secu_Compago:=lSecCompago;
    vp_Pref_Plaza  :=lPref_Plaza;
    vp_OutRetorno:=0;
    vp_OutGlosa  :='OK';

EXCEPTION
    WHEN ERROR_PROCESO THEN
         IF vp_retorno != 0 THEN
                 ROLLBACK;
         END IF;
         ROLLBACK;
         vp_OutRetorno := 1;
         vp_OutGlosa  := 'Error de Proceso : '||vp_Gls_Error;
         v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - ';
         v_sqlcode := SQLCODE;
     WHEN OTHERS THEN
	 IF vp_retorno != 0 THEN
                 ROLLBACK;
         END IF;
         ROLLBACK;
         vp_OutRetorno := 1;
         vp_OutGlosa  := 'Error Sql : '||SQLERRM||' '||vp_Gls_Error;
         v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
         v_sqlcode := SQLCODE;

END Co_P_APLICA_PAGO;

Procedure CO_P_BUSCA_PAGOS IS

 lCod_clientePrincipal CO_CARTERA.COD_CLIENTE%TYPE;
 vp_Imp_pagoPrincipal  CO_CARTERA.IMPORTE_DEBE%TYPE;
 vp_folioPrincipal     CO_CARTERA.NUM_FOLIO%TYPE;
 vp_plazaPrincipal     CO_CARTERA.PREF_PLAZA%TYPE;
 vp_OutGlosaPrincipal    VARCHAR2(200);
 vp_OutRetornoPrincipal  NUMBER(2);
/*****************  CURSOR PARA BUSCAR LOS PAGOS ********************************************/
CURSOR CO_DISTRIBUIDOR IS
SELECT COD_CLIENTE , NUM_FOLIO, PREF_PLAZA , IMPORTE_PAGO   FROM CO_PAGO_DISTRIBUIDOR_TO
WHERE IND_CANCELADO=0;

BEGIN
FOR rPrin IN CO_DISTRIBUIDOR LOOP
    vp_Gls_Error := '';
    lCod_clientePrincipal := rPrin.COD_CLIENTE;
    vp_Imp_pagoPrincipal  := rPrin.IMPORTE_PAGO;
    vp_folioPrincipal     := rPrin.NUM_FOLIO;
    vp_plazaPrincipal     := rPrin.PREF_PLAZA;

    CO_P_APLICA_PAGO(lCod_clientePrincipal, vp_Imp_pagoPrincipal , vp_folioPrincipal ,vp_plazaPrincipal,  vp_OutGlosaPrincipal,  vp_OutRetornoPrincipal);
    IF vp_OutRetornoPrincipal != 0 THEN
    BEGIN
	UPDATE CO_PAGO_DISTRIBUIDOR_TO SET
	DESC_ERROR = vp_OutGlosaPrincipal ,
	FECHA_ERROR  = SYSDATE,
	 IND_CANCELADO = -1
	WHERE  COD_CLIENTE  = lCod_clientePrincipal
	AND    NUM_FOLIO =    vp_folioPrincipal
	AND    PREF_PLAZA =   vp_plazaPrincipal;
    END;
    ELSE
    BEGIN
        vp_Gls_Error := 'ACTUALIZA PAGO REALIZADO.';
	UPDATE CO_PAGO_DISTRIBUIDOR_TO SET
	       IND_CANCELADO = 1,
	       FECHA_PAGO    = SYSDATE
	WHERE  COD_CLIENTE  = lCod_clientePrincipal
	AND    NUM_FOLIO =    vp_folioPrincipal
	AND    PREF_PLAZA =   vp_plazaPrincipal;
    END;
    END IF;
COMMIT;
END LOOP;
END ;

END Co_Aplica_Pago_Distribuidor_PG;
/
SHOW ERRORS
