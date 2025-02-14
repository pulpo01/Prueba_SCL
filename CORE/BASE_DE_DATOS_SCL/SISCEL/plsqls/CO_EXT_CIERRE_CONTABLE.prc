CREATE OR REPLACE PROCEDURE CO_EXT_CIERRE_CONTABLE(vp_Cod_Emp     IN VARCHAR2 , vp_Num_Ejercicio  IN VARCHAR2 ,
                                                   vp_outGlosa    OUT VARCHAR2, vp_outRetorno     OUT NUMBER) IS

vp_gls_error        VARCHAR2(255);
sNom_proceso        VARCHAR2(50);
sDesc_Sql           VARCHAR2(250);
szhGlosaError       VARCHAR2(70);
ihRetorno           NUMBER(5);
vp_error            NUMBER(5):=0;
iCount              NUMBER(2);
szCod_Oficina       CO_EMPRESAS_REX.COD_OFICINA%TYPE;
iCod_Caja           CO_EMPRESAS_REX.COD_CAJA%TYPE;
ERROR_PROCESO EXCEPTION;

BEGIN
	sNom_proceso := 'CO_EXT_CIERRE_CONTABLE';

    sDesc_Sql := 'SELECT COD_OFICINA, COD_CAJA FROM CO_EMPRESAS_REX ';
    SELECT COD_OFICINA, COD_CAJA
    INTO   szCod_Oficina , iCod_Caja
    FROM   CO_EMPRESAS_REX
    WHERE  EMP_RECAUDADORA = vp_Cod_Emp;

    sDesc_Sql := 'Llamada a PL CO_DEPOSITO_VALORES';
    Co_Deposito_Valores(vp_Cod_Emp, vp_Num_Ejercicio, szhGlosaError, ihRetorno);

    IF ihRetorno != 0 THEN
       vp_outGlosa  := szhGlosaError;
       vp_outRetorno:= ihRetorno;
       RAISE ERROR_PROCESO;
    END IF;

    sDesc_Sql := 'INSERT INTO CO_HISTMOVCAJA. Oficina:'||szCod_Oficina||' Cod_caja:'||iCod_Caja;
    INSERT INTO CO_HISTMOVCAJA (
           COD_OFICINA    ,COD_CAJA       ,NUM_SECUMOV    ,NUM_EJERCICIO  ,FEC_EFECTIVIDAD  ,
           FEC_HISTORICO  ,NOM_USUARORA   ,TIP_MOVCAJA    ,IND_DEPOSITO   ,IMPORTE          ,
           IND_ERRONEO    ,TIP_VALOR      ,IND_CIERRE     ,COD_CLIENTE    ,NUM_ABONADO      ,
           COD_PRODUCTO   ,TIP_DOCUMENT   ,COD_VENDEDOR_AGENTE            ,LETRA            ,
           COD_CENTREMI   ,NUM_SECUENCI   ,LETRAC         ,COD_CENTRC     ,NUM_SECUC        ,
           COD_BANCO      ,COD_SUCURSAL   ,CTA_CORRIENTE  ,NUM_CHEQUE     ,TIP_CLEARING     ,
           FEC_CHEQUE     ,COD_TIPTARJETA ,NUM_TARJETA    ,COD_AUTORIZA   ,NUM_CUPON        ,
           NUM_CUOTAS     ,FEC_CUPON      ,COD_MOVILI     ,DES_MOVILI     ,COD_RECOMPE      ,
           NOM_CUSTODIA   ,NUM_ORDEN      ,FEC_EMISION    ,FEC_VENCIMIENTO,COD_COBRADOR     ,
           NUM_INGMANUAL  ,NUM_RESPINGR   ,NUM_COMPAGO    ,COD_MONEDA     ,COD_OPERADORA_SCL,
           COD_PLAZA      ,PREF_PLAZA     ,NUM_IDENT      )
    SELECT COD_OFICINA    ,COD_CAJA       ,NUM_SECUMOV    ,NUM_EJERCICIO  ,FEC_EFECTIVIDAD  ,
           SYSDATE        ,NOM_USUARORA   ,TIP_MOVCAJA    ,IND_DEPOSITO   ,IMPORTE          ,
           IND_ERRONEO    ,TIP_VALOR      ,IND_CIERRE     ,COD_CLIENTE    ,NUM_ABONADO      ,
           COD_PRODUCTO   ,TIP_DOCUMENT   ,COD_VENDEDOR_AGENTE            ,LETRA            ,
           COD_CENTREMI   ,NUM_SECUENCI   ,LETRAC         ,COD_CENTRC     ,NUM_SECUC        ,
           COD_BANCO      ,COD_SUCURSAL   ,CTA_CORRIENTE  ,NUM_CHEQUE     ,TIP_CLEARING     ,
           FEC_CHEQUE     ,COD_TIPTARJETA ,NUM_TARJETA    ,COD_AUTORIZA   ,NUM_CUPON        ,
           NUM_CUOTAS     ,FEC_CUPON      ,COD_MOVILI     ,DES_MOVILI     ,COD_RECOMPE      ,
           NOM_CUSTODIA   ,NUM_ORDEN      ,FEC_EMISION    ,FEC_VENCIMIENTO,COD_COBRADOR     ,
           NUM_INGMANUAL  ,NUM_RESPINGR   ,NUM_COMPAGO    ,COD_MONEDA     ,COD_OPERADORA_SCL,
           COD_PLAZA      ,PREF_PLAZA     ,NUM_IDENT
    FROM   CO_MOVIMIENTOSCAJA
    WHERE  COD_CAJA      = iCod_Caja
    AND    COD_OFICINA   = szCod_Oficina
    AND    NUM_EJERCICIO = vp_Num_Ejercicio;

    sDesc_Sql := 'DELETE FROM CO_MOVIMIENTOSCAJA (Eliminando Movimientos Cajas).  Oficina:'||szCod_Oficina||' Cod_caja:'||iCod_Caja;
    DELETE FROM CO_MOVIMIENTOSCAJA
    WHERE  COD_CAJA      = iCod_Caja
    AND    COD_OFICINA   = szCod_Oficina
    AND    NUM_EJERCICIO = vp_Num_Ejercicio ;

    COMMIT;

    Co_Gen_Informe_Contable_Cajas(szCod_Oficina, iCod_Caja, vp_Num_Ejercicio);

    Co_Imputacion_Contable_Cajas(szCod_Oficina, iCod_Caja, vp_Num_Ejercicio);

    Co_Imputacion_Contable_Dep(szCod_Oficina, iCod_Caja, vp_Num_Ejercicio);


	vp_outRetorno := 0;
	vp_outGlosa  := 'OK';
    COMMIT ;

    EXCEPTION
      WHEN ERROR_PROCESO THEN
           ROLLBACK;
		   vp_gls_error := szhGlosaError;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO ,DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE ,sDesc_Sql, vp_gls_error);
		   COMMIT;
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
		   vp_outRetorno := 100;
		   vp_outGlosa  := 'Error Sql : '||SQLERRM;
		   vp_gls_error := 'No Hay Datos - ' || SQLERRM;
		   vp_error := SQLCODE;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO ,DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE ,sDesc_Sql, vp_gls_error);
		   COMMIT;
      WHEN OTHERS THEN
           ROLLBACK;
		   vp_outRetorno := 1;
		   vp_outGlosa  := 'Error Sql : '||SQLERRM;
		   vp_gls_error := 'Otros Errores - ' || SQLERRM;
		   vp_error := SQLCODE;
           INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
           VALUES (sNom_proceso, vp_error, SYSDATE , sDesc_Sql, vp_gls_error);
		   COMMIT;
END CO_EXT_CIERRE_CONTABLE;
/
SHOW ERRORS
