CREATE OR REPLACE PROCEDURE CO_DEPOSITO_VALORES(vp_cod_emp     IN VARCHAR2 , vp_num_ejercicio  IN VARCHAR2,
                                                vp_outGlosa    OUT NOCOPY VARCHAR2, vp_outRetorno     OUT NOCOPY NUMBER) IS
sUsuario         VARCHAR2(30);
iFechayyyymmdd      NUMBER(8);
iInd_dias           NUMBER(3);
vp_error            NUMBER(5);
vp_count            NUMBER(3);
vp_gls_error        VARCHAR2(255);
i                   NUMBER(10);
j                   NUMBER(10);
k                   NUMBER(10);
iTip_movcaja        NUMBER(3);
sNom_proceso        VARCHAR2(50);
sDesc_Sql           VARCHAR2(250);
vp_num_deposito     VARCHAR2(25);
iNum_Secu           NUMBER(20);

sCod_Operadora  CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
sCod_Plaza       CO_EMPRESAS_REX.COD_PLAZA%TYPE;

szVal_Param_Depo    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
szCod_Banco         GE_BANCO_CTA_CTE.COD_BANCO%TYPE;
szNum_Cta_Cte       GE_BANCO_CTA_CTE.NUM_CTA_CTE%TYPE;
dEfec_cambio        CO_EFECTIVO_CAJAS.EFEC_CAMBIO%TYPE;
sCod_oficina        CO_EMPRESAS_REX.COD_OFICINA%TYPE;
iCod_caja           CO_EMPRESAS_REX.COD_CAJA%TYPE;
iTip_valor          CO_TIPVALOR.TIP_VALOR%TYPE;
sCod_Moneda   CO_TIPVALOR.COD_MONEDA%TYPE;
iTip_ValorMov       CO_MOVIMIENTOSCAJA.TIP_VALOR%TYPE;
iNum_Secumov        CO_MOVIMIENTOSCAJA.NUM_SECUMOV%TYPE;
sNum_Ejercicio      CO_MOVIMIENTOSCAJA.NUM_EJERCICIO%TYPE;
sCod_Banco          CO_MOVIMIENTOSCAJA.COD_BANCO%TYPE;
sCod_Sucursal       CO_MOVIMIENTOSCAJA.COD_SUCURSAL%TYPE;
sCta_Corriente      CO_MOVIMIENTOSCAJA.CTA_CORRIENTE%TYPE;
sNum_Cheque         CO_MOVIMIENTOSCAJA.NUM_CHEQUE%TYPE;
sfec_Cheque         CO_MOVIMIENTOSCAJA.FEC_CHEQUE%TYPE;
sCod_Tiptarjeta     CO_MOVIMIENTOSCAJA.COD_TIPTARJETA%TYPE;
sNum_Tarjeta        CO_MOVIMIENTOSCAJA.NUM_TARJETA%TYPE;
sCod_Autoriza       CO_MOVIMIENTOSCAJA.COD_AUTORIZA%TYPE;
sFec_Efectividad    CO_MOVIMIENTOSCAJA.FEC_EFECTIVIDAD%TYPE;
sDes_Tipvalor       CO_TIPVALOR.DES_TIPVALOR%TYPE;
sDes_Banco          GE_BANCOS.DES_BANCO%TYPE;
sDes_Tiptarjeta     GE_TIPTARJETAS.DES_TIPTARJETA%TYPE;

TYPE TipRegCheques IS RECORD
(
        DES_TIPVALOR            CO_TIPVALOR.DES_TIPVALOR%TYPE,
  IMPORTE                 CO_MOVIMIENTOSCAJA.IMPORTE%TYPE,
        TIP_VALOR               CO_MOVIMIENTOSCAJA.TIP_VALOR%TYPE,
        NUM_SECUMOV             CO_MOVIMIENTOSCAJA.NUM_SECUMOV%TYPE,
        NUM_EJERCICIO           CO_MOVIMIENTOSCAJA.NUM_EJERCICIO%TYPE,
        COD_BANCO               CO_MOVIMIENTOSCAJA.COD_BANCO%TYPE,
        COD_SUCURSAL            CO_MOVIMIENTOSCAJA.COD_SUCURSAL%TYPE,
        CTA_CORRIENTE           CO_MOVIMIENTOSCAJA.CTA_CORRIENTE%TYPE,
        NUM_CHEQUE              CO_MOVIMIENTOSCAJA.NUM_CHEQUE%TYPE,
        COD_TIPTARJETA          CO_MOVIMIENTOSCAJA.COD_TIPTARJETA%TYPE,
  NUM_TARJETA             CO_MOVIMIENTOSCAJA.NUM_TARJETA%TYPE,
  COD_AUTORIZA            CO_MOVIMIENTOSCAJA.COD_AUTORIZA%TYPE,
  COD_MONEDA    CO_MOVIMIENTOSCAJA.COD_MONEDA%TYPE,
  COD_OPERADORA_SCL  CO_MOVIMIENTOSCAJA.COD_OPERADORA_SCL%TYPE,
  COD_PLAZA    CO_MOVIMIENTOSCAJA.COD_PLAZA%TYPE,
     DES_BANCO               GE_BANCOS.DES_BANCO%TYPE,
  DES_TIPTARJETA          GE_TIPTARJETAS.DES_TIPTARJETA%TYPE
);

TYPE TipTab_Cheques IS TABLE OF TipRegCheques INDEX BY
BINARY_INTEGER;
Registro_Cheques        TipTab_Cheques;

CURSOR C_Documentos IS
SELECT B.DES_TIPVALOR AS DES_TIPVALOR, A.IMPORTE AS IMPORTE, A.TIP_VALOR AS TIP_VALOR,
      A.NUM_SECUMOV AS NUM_SECUMOV, A.NUM_EJERCICIO AS NUM_EJERCICIO, A.COD_BANCO AS COD_BANCO,
      A.COD_SUCURSAL AS COD_SUCURSAL, A.CTA_CORRIENTE AS CTA_CORRIENTE, A.NUM_CHEQUE AS NUM_CHEQUE,
      A.COD_TIPTARJETA AS COD_TIPTARJETA, A.NUM_TARJETA AS NUM_TARJETA, A.COD_AUTORIZA AS COD_AUTORIZA,
   A.COD_MONEDA AS COD_MONEDA, A.COD_OPERADORA_SCL AS COD_OPERADORA_SCL, A.COD_PLAZA AS COD_PLAZA,
      C.DES_BANCO AS DES_BANCO, D.DES_TIPTARJETA AS DES_TIPTARJETA
FROM  CO_MOVIMIENTOSCAJA A, CO_TIPVALOR B, GE_BANCOS C, GE_TIPTARJETAS D
WHERE A.COD_OFICINA = sCod_Oficina
AND   A.COD_CAJA    = iCod_Caja
AND   A.IND_DEPOSITO= 0
AND   A.IND_CIERRE  = 0
AND   A.TIP_VALOR   IN (4, 12)
AND ( A.TIP_MOVCAJA = 6 OR A.TIP_MOVCAJA = 7
      OR A.TIP_MOVCAJA = 9 OR A.TIP_MOVCAJA = 8 )
AND   A.NUM_EJERCICIO = vp_num_ejercicio
AND   A.IND_ERRONEO = 0
AND   A.TIP_VALOR   = B.TIP_VALOR
AND   B.IND_EFECTIVO= 0
AND   B.IND_OC      = 0
AND   A.COD_BANCO   = C.COD_BANCO (+)
AND   A.COD_TIPTARJETA = D.COD_TIPTARJETA (+)
ORDER BY A.TIP_VALOR, A.COD_BANCO, A.COD_TIPTARJETA;

/********/
CURSOR c1 IS
SELECT TIP_VALOR, COD_MONEDA
FROM CO_TIPVALOR
WHERE IND_EFECTIVO=1;

CURSOR c2 IS
    SELECT EFEC_CAMBIO, COD_OPERADORA_SCL,COD_PLAZA
    FROM   CO_EFECTIVO_CAJAS
    WHERE  COD_OFICINA  = sCod_Oficina
    AND    COD_CAJA     = iCod_Caja
    AND    NUM_EJERCICIO= vp_num_ejercicio
    AND    COD_MONEDA   = sCod_Moneda ;
/*******/

ERROR_PROCESO EXCEPTION;
BEGIN
 sNom_proceso := 'CO_DEPOSITO_VALORES';

 sDesc_Sql := 'SELECT COD_OFICINA FROM CO_EMPRESAS_REX (Validando Parametro de entrada Cod_Caja)  Cod_Parametro:'||vp_cod_emp;
    SELECT A.COD_OFICINA  , A.COD_CAJA, B.NOM_USUARORA, TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD'))
    INTO   sCod_oficina   , iCod_caja , sUsuario      , iFechayyyymmdd
    FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
    WHERE  A.EMP_RECAUDADORA = vp_cod_emp
    AND    A.COD_CAJA        = B.COD_CAJA
    AND    A.COD_OFICINA     = B.COD_OFICINA;

    sDesc_Sql := 'SELECT CODIGO BANCO DESDE GED_PARAMETROS';
    SELECT VAL_PARAMETRO
    INTO   szVal_Param_Depo
    FROM   GED_PARAMETROS
    WHERE  COD_MODULO = 'RE'
    AND    NOM_PARAMETRO = 'DEPO_'||vp_cod_emp;

    SELECT COD_BANCO , NUM_CTA_CTE
    INTO   szCod_Banco , szNum_Cta_Cte
    FROM   GE_BANCO_CTA_CTE
    WHERE  COD_CTA_CTE = szVal_Param_Depo;

 /**   sDesc_Sql := 'SELECT TIP_VALOR FROM CO_TIPVALOR ';
    SELECT TIP_VALOR, COD_MONEDA
    INTO   iTip_valor, sCod_Moneda
    FROM   CO_TIPVALOR
    WHERE  IND_EFECTIVO = 1;
    IF iTip_valor != 1 THEN
       vp_error := iTip_valor;
       vp_gls_error := 'Error. El Tipo de Valor es distinto de 1.';
       RAISE ERROR_PROCESO;
    END IF;**/

 FOR rREG IN c1 LOOP
    sCod_Moneda := rREG.COD_MONEDA;
 /***   DEPOSITO_VALORES **/
 /**Comprobamos que exista una entrada en la EFECCAJAS para la moneda.**/
/**    sDesc_Sql := 'SELECT EFEC_CAMBIO FROM CO_EFECTIVO_CAJAS. Oficina:'||sCod_oficina||' Cod_caja:'||iCod_caja;
    SELECT EFEC_CAMBIO
    INTO   dEfec_cambio
    FROM   CO_EFECTIVO_CAJAS
    WHERE  COD_OFICINA  = sCod_Oficina
    AND    COD_CAJA     = iCod_Caja
    AND    NUM_EJERCICIO= vp_num_ejercicio
    AND    COD_MONEDA   = rREG.COD_MONEDA ;***/
  FOR rREG2 IN c2 LOOP
   IF rREG2.EFEC_CAMBIO > 0 THEN
    sDesc_Sql := 'UPDATE  CO_EFECTIVO_CAJAS . Oficina:'||sCod_oficina||' Cod_caja:'||iCod_caja;
    UPDATE CO_EFECTIVO_CAJAS SET
           EFEC_CAMBIO  = 0
    WHERE  COD_OFICINA  = sCod_Oficina
    AND    COD_CAJA     = iCod_Caja
    AND    NUM_EJERCICIO= vp_num_ejercicio
    AND    COD_MONEDA   = rREG.COD_MONEDA
 AND    COD_OPERADORA_SCL = rREG2.COD_OPERADORA_SCL
 AND    COD_PLAZA = rREG2.COD_PLAZA;

    sDesc_Sql := 'SELECT COS_SEQ_MOVCAJA.NEXTVAL ';
    SELECT COS_SEQ_MOVCAJA.NEXTVAL
    INTO   iNum_Secu
    FROM   DUAL;

   /** --Obtiene Operadora y Plaza
    sDesc_Sql := 'SELECT COD_OPERADORA_SCL, COD_PLAZA FROM GE_OPERPLAZA_TD';
    SELECT COD_OPERADORA_SCL, COD_PLAZA
    INTO   sCod_Operadora, sCod_Plaza
    FROM   GE_OPERPLAZA_TD
    WHERE  COD_OPERADORA_SCL IN (SELECT COD_OPERADORA_SCL FROM   GE_OPERADORA_SCL_LOCAL);**/


    iTip_movcaja := 19;
    sDesc_Sql := 'INSERT INTO CO_MOVIMIENTOSCAJA(1). Num_secu:'||iNum_Secu||' sUsuario:'||sUsuario||' iTip_movcaja:'||iTip_movcaja||' dEfec_cambio:'||dEfec_cambio||' iTip_valor:'||iTip_valor;
    INSERT INTO CO_MOVIMIENTOSCAJA
                (COD_OFICINA  , COD_CAJA        , NUM_SECUMOV   ,
                NUM_EJERCICIO , FEC_EFECTIVIDAD , NOM_USUARORA  ,
             TIP_MOVCAJA   , IND_DEPOSITO    , IMPORTE       , IND_ERRONEO   ,
             TIP_VALOR     , IND_CIERRE      , COD_CLIENTE   , NUM_ABONADO   ,
             COD_PRODUCTO  , TIP_DOCUMENT    , COD_VENDEDOR_AGENTE           ,
             LETRA         , COD_CENTREMI    , NUM_SECUENCI  , LETRAC        , COD_CENTRC,
             NUM_SECUC     , COD_BANCO       , COD_SUCURSAL  , CTA_CORRIENTE ,
             NUM_CHEQUE    , TIP_CLEARING    , FEC_CHEQUE    , COD_TIPTARJETA,
             NUM_TARJETA   , COD_AUTORIZA    , NUM_CUPON     , NUM_CUOTAS    ,
             FEC_CUPON     , COD_MOVILI      , DES_MOVILI    , COD_RECOMPE   , NOM_CUSTODIA,
             NUM_IDENT     , NUM_ORDEN       , FEC_EMISION   , FEC_VENCIMIENTO,
             COD_COBRADOR  , NUM_INGMANUAL   , NUM_RESPINGR  , COD_MONEDA    ,
    COD_OPERADORA_SCL, COD_PLAZA    , NUM_COMPAGO   , PREF_PLAZA    )
 VALUES (    sCod_oficina  , iCod_caja       , iNum_Secu     ,
                vp_num_ejercicio ,SYSDATE       , sUsuario      , iTip_movcaja , 1 ,
                rREG2.EFEC_CAMBIO, 0 , rREG.TIP_VALOR  , 0    ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL , NULL , NULL ,
                NULL , NULL ,
                rREG.COD_MONEDA , rREG2.COD_OPERADORA_SCL ,
                rREG2.COD_PLAZA  , NULL , NULL );

    sDesc_Sql := 'INSERT INTO CO_MOVDEP(1)(Movto. de Depositos). Num_secu:'||iNum_Secu;
    INSERT INTO CO_MOVDEP
           (COD_OFICINA, COD_CAJA, NUM_EJERCICIO, NUM_SECUMOV, FEC_DEPOSITO,
            COD_BANCO, CTA_CORRIENTE, IMPORTE, IND_DEPOSITO, NUM_DEPOSITO,
   COD_MONEDA, COD_OPERADORA_SCL, COD_PLAZA)
    VALUES (sCod_Oficina, iCod_Caja, vp_num_ejercicio, iNum_Secu, SYSDATE, szCod_Banco,
            szNum_Cta_Cte, rREG2.EFEC_CAMBIO, 1,999999,
   rREG.COD_MONEDA, rREG2.COD_OPERADORA_SCL, rREG2.COD_PLAZA);
   END IF;
  END LOOP;
 END LOOP;

    i := 0;
    sDesc_Sql := 'For a Cursor C_Documentos';
    FOR rReg IN C_Documentos LOOP
        i := i + 1 ;
     Registro_Cheques(i).DES_TIPVALOR     := rReg.DES_TIPVALOR;
     Registro_Cheques(i).IMPORTE          := rReg.IMPORTE;
     Registro_Cheques(i).TIP_VALOR        := rReg.TIP_VALOR;
     Registro_Cheques(i).NUM_SECUMOV      := rReg.NUM_SECUMOV;
     Registro_Cheques(i).NUM_EJERCICIO    := rReg.NUM_EJERCICIO;
     Registro_Cheques(i).COD_BANCO        := rReg.COD_BANCO;
     Registro_Cheques(i).COD_SUCURSAL     := rReg.COD_SUCURSAL;
     Registro_Cheques(i).CTA_CORRIENTE    := rReg.CTA_CORRIENTE;
     Registro_Cheques(i).NUM_CHEQUE       := rReg.NUM_CHEQUE;
     Registro_Cheques(i).COD_TIPTARJETA   := rReg.COD_TIPTARJETA;
     Registro_Cheques(i).NUM_TARJETA      := rReg.NUM_TARJETA;
     Registro_Cheques(i).COD_AUTORIZA     := rReg.COD_AUTORIZA;
     Registro_Cheques(i).DES_BANCO        := rReg.DES_BANCO;
     Registro_Cheques(i).DES_TIPTARJETA   := rReg.DES_TIPTARJETA;
  Registro_Cheques(i).COD_MONEDA   := rReg.COD_MONEDA;
  Registro_Cheques(i).COD_OPERADORA_SCL:= rReg.COD_OPERADORA_SCL;
  Registro_Cheques(i).COD_PLAZA     := rReg.COD_PLAZA;
     /**    IF AUX_TOT_CUOTA < Registro_Cheques(i).NUM_CUOTA THEN
           AUX_TOT_CUOTA := Registro_Cheques(i).NUM_CUOTA;
        END IF; **/
    END LOOP;

    IF i > 0 THEN
        sDesc_Sql := 'For a Registro_Cheques.LAST';
        FOR i IN 1 .. Registro_Cheques.LAST LOOP
            sDesc_Sql := 'UPDATE CO_MOVIMIENTOSCAJA(Movto. de caja). Num_secu:'||iNum_Secu;
            UPDATE CO_MOVIMIENTOSCAJA SET
                   IND_DEPOSITO = 1
            WHERE  COD_OFICINA = sCod_Oficina
            AND    COD_CAJA= iCod_Caja
            AND    NUM_SECUMOV= Registro_Cheques(i).NUM_SECUMOV;

            sDesc_Sql := 'SELECT COS_SEQ_MOVCAJA.NEXTVAL ';
            SELECT COS_SEQ_MOVCAJA.NEXTVAL
            INTO   iNum_Secu
            FROM   DUAL;

            sDesc_Sql := 'INSERT INTO CO_MOVIMIENTOSCAJA(2). Num_secu:'||iNum_Secu;
            iTip_movcaja := 21;
            INSERT INTO CO_MOVIMIENTOSCAJA
                  (COD_OFICINA, COD_CAJA, NUM_SECUMOV,
                   NUM_EJERCICIO, FEC_EFECTIVIDAD, NOM_USUARORA,
                TIP_MOVCAJA, IND_DEPOSITO, IMPORTE, IND_ERRONEO,
                TIP_VALOR, IND_CIERRE, COD_CLIENTE, NUM_ABONADO,
                   COD_PRODUCTO, TIP_DOCUMENT, COD_VENDEDOR_AGENTE,
                LETRA, COD_CENTREMI, NUM_SECUENCI, LETRAC, COD_CENTRC,
                NUM_SECUC, COD_BANCO, COD_SUCURSAL, CTA_CORRIENTE,
                NUM_CHEQUE, TIP_CLEARING, FEC_CHEQUE, COD_TIPTARJETA,
                   NUM_TARJETA, COD_AUTORIZA, NUM_CUPON, NUM_CUOTAS,
                FEC_CUPON, COD_MOVILI, DES_MOVILI, COD_RECOMPE, NOM_CUSTODIA,
                NUM_IDENT, NUM_ORDEN, FEC_EMISION, FEC_VENCIMIENTO,
                COD_COBRADOR, NUM_INGMANUAL, NUM_RESPINGR, COD_MONEDA,
       COD_OPERADORA_SCL, COD_PLAZA, NUM_COMPAGO, PREF_PLAZA)
            SELECT COD_OFICINA, COD_CAJA, iNum_Secu, NUM_EJERCICIO,
                SYSDATE, sUsuario, 21, 1,
                IMPORTE, IND_ERRONEO, TIP_VALOR, IND_CIERRE, COD_CLIENTE,
                NUM_ABONADO, COD_PRODUCTO, TIP_DOCUMENT, COD_VENDEDOR_AGENTE,
                LETRA, COD_CENTREMI, NUM_SECUENCI, LETRAC, COD_CENTRC, NUM_SECUC,
                COD_BANCO, COD_SUCURSAL, CTA_CORRIENTE, NUM_CHEQUE, TIP_CLEARING,
                FEC_CHEQUE, COD_TIPTARJETA, NUM_TARJETA, COD_AUTORIZA,
                NUM_CUPON, NUM_CUOTAS, FEC_CUPON, COD_MOVILI, DES_MOVILI,
                COD_RECOMPE, NOM_CUSTODIA, NUM_IDENT, NUM_ORDEN, FEC_EMISION,
                FEC_VENCIMIENTO, COD_COBRADOR, NUM_INGMANUAL, NUM_RESPINGR, COD_MONEDA,
       COD_OPERADORA_SCL, COD_PLAZA, NUM_COMPAGO, PREF_PLAZA
            FROM   CO_MOVIMIENTOSCAJA
            WHERE  COD_OFICINA = sCod_Oficina
            AND    COD_CAJA = iCod_caja
            AND    NUM_SECUMOV = Registro_Cheques(i).NUM_SECUMOV ;

            sDesc_Sql := 'INSERT INTO CO_MOVDEP.(2) Num_secu:'||iNum_Secu;
            INSERT INTO CO_MOVDEP
                   (COD_OFICINA, COD_CAJA, NUM_EJERCICIO, NUM_SECUMOV,
                   FEC_DEPOSITO, COD_BANCO, CTA_CORRIENTE, IMPORTE,
                   IND_DEPOSITO, NUM_DEPOSITO,
       COD_MONEDA, COD_OPERADORA_SCL, COD_PLAZA)
            VALUES (sCod_Oficina,iCod_Caja,vp_num_ejercicio,
                   iNum_Secu,SYSDATE,szCod_Banco,
                   szNum_Cta_Cte, Registro_Cheques(i).IMPORTE,
                   1,'888888888',
       Registro_Cheques(i).COD_MONEDA, Registro_Cheques(i).COD_OPERADORA_SCL, Registro_Cheques(i).COD_PLAZA);

            /**  deposito de documentos**/
   IF Registro_Cheques(i).TIP_VALOR = 4 THEN
             sDesc_Sql := 'INSERT INTO CO_CANCELADOS . Num_secu:'||i;
             INSERT INTO CO_CANCELADOS
                    (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,
           LETRA, COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,
           IMPORTE_DEBE, IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,
           IND_PORTADOR,FEC_EFECTIVIDAD, FEC_VENCIMIE,FEC_CADUCIDA,
           FEC_ANTIGUEDAD,FEC_CANCELACION, NUM_ABONADO,NUM_FOLIO,PREF_PLAZA,FEC_PAGO,
           NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,
        COD_OPERADORA_SCL, COD_PLAZA)
             SELECT COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,
           LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO, IMPORTE_DEBE,
           IMPORTE_DEBE,IND_CONTADO,IND_FACTURADO,0,FEC_EFECTIVIDAD,FEC_VENCIMIE,
           FEC_CADUCIDA,FEC_ANTIGUEDAD,
           TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),NUM_ABONADO,NUM_FOLIO,PREF_PLAZA,
                    TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),NUM_CUOTA,SEC_CUOTA,0,
                    NUM_VENTA,NUM_FOLIOCTC,
        COD_OPERADORA_SCL, COD_PLAZA
             FROM   CO_CARTERA
             WHERE  NUM_FOLIO = Registro_Cheques(i).NUM_CHEQUE
             AND    NUM_SECUENCI= ( SELECT NUM_SECUENCI FROM CO_DOCUMENTOS
                                    WHERE NUM_DOCUMENTO=Registro_Cheques(i).NUM_CHEQUE
                                    AND NUM_SECUMOV=Registro_Cheques(i).NUM_SECUMOV);

             sDesc_Sql := 'DELETE CO_CARTERA . Num_secu:'||iNum_Secu;
             DELETE FROM CO_CARTERA
          WHERE  NUM_FOLIO = Registro_Cheques(i).NUM_CHEQUE
          AND    NUM_SECUENCI=( SELECT NUM_SECUENCI FROM CO_DOCUMENTOS
                                   WHERE NUM_DOCUMENTO= Registro_Cheques(i).NUM_CHEQUE
                 AND NUM_SECUMOV=Registro_Cheques(i).NUM_SECUMOV);

             sDesc_Sql := 'UPDATE CO_DOCUMENTOS . Num_secu:'||iNum_Secu;
             UPDATE CO_DOCUMENTOS SET
                    COD_ESTADO         = '2',
                    FECHA_DEPOSITO     = TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
                    COD_BANCO_DEPO     = sCod_banco,
                    CTA_CORRIENTE_DEPO = sCta_Corriente,
                    NUN_DEPOSITO       = vp_num_deposito
             WHERE  NUM_DOCUMENTO = Registro_Cheques(i).NUM_CHEQUE
             AND    NUM_SECUMOV   = Registro_Cheques(i).NUM_SECUMOV;
   END IF;
        END LOOP LOOP_Cheques;
    END IF;

 vp_outRetorno := 0;
 vp_outGlosa  := 'OK';
    COMMIT ;

    EXCEPTION
      WHEN ERROR_PROCESO THEN
           ROLLBACK;
     vp_outRetorno := 1;
     vp_outGlosa  := 'Error Sql : '||sqlerrm;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO ,DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE ,sDesc_Sql, vp_gls_error);
     COMMIT;
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
     vp_outRetorno := 100;
     vp_outGlosa  := 'Error Sql : '||sqlerrm;
     vp_gls_error := 'No Hay Datos - ' || SQLERRM;
     vp_error := SQLCODE;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO ,DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE ,sDesc_Sql, vp_gls_error);
     COMMIT;
      WHEN OTHERS THEN
           ROLLBACK;
     vp_outRetorno := 1;
     vp_outGlosa  := 'Error Sql : '||sqlerrm;
     vp_gls_error := 'Otros Errores - ' || SQLERRM;
     vp_error := SQLCODE;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE , sDesc_Sql, vp_gls_error);
     COMMIT;
END CO_DEPOSITO_VALORES;
/
SHOW ERRORS
