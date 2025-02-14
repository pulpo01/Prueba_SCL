CREATE OR REPLACE PROCEDURE CO_CIERRECAJAS( vp_Cod_servicio IN VARCHAR2,
						   	  		  	    vp_Cod_periodo   IN VARCHAR2, vp_Cod_empresa  IN VARCHAR2,
										    vp_Cod_tipoper   IN VARCHAR2, vp_Cod_tipuso   IN VARCHAR2,
										    vp_num_ejercicio IN VARCHAR2, vp_Num_Transac  IN NUMBER  ,
										    vp_outGlosa      OUT VARCHAR2, vp_outRetorno OUT NUMBER) IS
sUsuario		VARCHAR2(30);
iFechayyyymmdd  NUMBER(8);
iInd_dias       NUMBER(3);
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
bOutRetorno     BOOLEAN:=TRUE;
iTip_movcaja    NUMBER(3);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(250);
sFec_Desde      VARCHAR2(25);
sFec_Hasta      VARCHAR2(25);
sPeriodo        VARCHAR2(6);
sDia			VARCHAR2(11);
iNum_secu       NUMBER(14);
iCan_Reg        NUMBER(8);
sCod_oficina    CO_EMPRESAS_REX.COD_OFICINA%TYPE;
iCod_caja       CO_EMPRESAS_REX.COD_CAJA%TYPE;
iTip_valor      CO_TIPVALOR.TIP_VALOR%TYPE;
sCod_Moneda		CO_TIPVALOR.COD_MONEDA%TYPE;
sNum_ejercicio  CO_INTERFAZ_PAGOS.NUM_EJERCICIO%TYPE;
sCod_Operadora  CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
sCod_Plaza	    CO_EMPRESAS_REX.COD_PLAZA%TYPE;

/********/
CURSOR c1 IS
SELECT TIP_VALOR, COD_MONEDA
FROM CO_TIPVALOR
WHERE IND_EFECTIVO=1;
/*******/

ERROR_PROCESO EXCEPTION;
BEGIN
	sNom_proceso := 'CO_CIERRECAJAS';

	sDesc_Sql := 'SELECT COD_OFICINA FROM CO_EMPRESAS_REX (Validando Parametro Cod_Caja)  vp_Cod_empresa:'||vp_Cod_empresa;
    SELECT A.COD_OFICINA  , A.COD_CAJA, NOM_USUARORA, TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD'))
    INTO   sCod_oficina , iCod_caja , sUsuario , iFechayyyymmdd
    FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
    WHERE  A.EMP_RECAUDADORA = vp_Cod_empresa
    AND    A.COD_CAJA        = B.COD_CAJA
    AND    A.COD_OFICINA     = B.COD_OFICINA;

/**    sDesc_Sql := 'SELECT TIP_VALOR, COD_MONEDA FROM CO_TIPVALOR ';
    SELECT TIP_VALOR, COD_MONEDA
    INTO   iTip_valor, sCod_Moneda
    FROM   CO_TIPVALOR
    WHERE  IND_EFECTIVO = 1;
    IF iTip_valor != 1 THEN
       vp_error := iTip_valor;
       vp_gls_error := 'Error. El Tipo de Valor es distinto de 1.';
       RAISE ERROR_PROCESO;
    END IF;

    --Obtiene Operadora y Plaza
    sDesc_Sql := 'SELECT COD_OPERADORA_SCL, COD_PLAZA FROM GE_OPERPLAZA_TD';
	SELECT COD_OPERADORA_SCL, COD_PLAZA
	INTO   sCod_Operadora, sCod_Plaza
	FROM   GE_OPERPLAZA_TD
	WHERE  COD_OPERADORA_SCL IN (SELECT COD_OPERADORA_SCL FROM   GE_OPERADORA_SCL_LOCAL);**/

	   --Obtiene Operadora y Plaza
   sDesc_Sql := 'SELECT COD_OPERADORA_SCL, COD_PLAZA FROM CO_EMPRESAS_REX';
   SELECT COD_OPERADORA_SCL, COD_PLAZA
   INTO   sCod_Operadora, sCod_Plaza
   FROM   CO_EMPRESAS_REX
   WHERE  EMP_RECAUDADORA= vp_cod_empresa;


 FOR rREG IN c1 LOOP
    iTip_movcaja := 23;
    LOOP
       EXIT WHEN iTip_movcaja > 24;

       sDesc_Sql := 'Rescatando Secuencia Cos_Seq_MovCaja.';
       SELECT COS_SEQ_MOVCAJA.NEXTVAL
       INTO   iNum_secu
       FROM   DUAL;

       sDesc_Sql := 'INSERT INTO CO_MOVIMIENTOSCAJA(Movto. de caja 23-24). Num_secu : '||iNum_secu;
       INSERT INTO CO_MOVIMIENTOSCAJA
                (COD_OFICINA, COD_CAJA, NUM_SECUMOV,
				NUM_EJERCICIO,FEC_EFECTIVIDAD, NOM_USUARORA,
                TIP_MOVCAJA, IND_DEPOSITO,IMPORTE,
				IND_ERRONEO, TIP_VALOR, IND_CIERRE,
                COD_CLIENTE, NUM_ABONADO,COD_PRODUCTO,
				TIP_DOCUMENT, COD_VENDEDOR_AGENTE, LETRA,
                COD_CENTREMI, NUM_SECUENCI, LETRAC,
				COD_CENTRC, NUM_SECUC, COD_BANCO,
				COD_SUCURSAL, CTA_CORRIENTE, NUM_CHEQUE,
                TIP_CLEARING, FEC_CHEQUE, COD_TIPTARJETA,
				NUM_TARJETA, COD_AUTORIZA, NUM_CUPON,
                NUM_CUOTAS, FEC_CUPON, COD_MOVILI,
				DES_MOVILI, COD_RECOMPE, NOM_CUSTODIA,
				NUM_IDENT, NUM_ORDEN, FEC_EMISION,
				FEC_VENCIMIENTO, COD_COBRADOR, NUM_INGMANUAL,
				NUM_RESPINGR, NUM_COMPAGO, PREF_PLAZA,
				COD_MONEDA, COD_OPERADORA_SCL, COD_PLAZA)
	   VALUES (
              sCod_oficina, iCod_caja, iNum_secu , vp_num_ejercicio ,
              SYSDATE , sUsuario , iTip_movcaja , 0 ,
              0, 0 , rREG.TIP_VALOR  , 1    ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
              NULL , NULL , NULL , NULL ,
			  rREG.COD_MONEDA , sCod_Operadora , sCod_Plaza);
        iTip_movcaja := iTip_movcaja + 1;
    END LOOP;
 END LOOP;

    sDesc_Sql := 'INSERT INTO CO_HISTMOVCAJA (Insertando desde Co_MovimientosCaja).  Oficina:'||sCod_oficina||' Cod_caja:'||iCod_caja;
    INSERT INTO CO_HISTMOVCAJA (
           COD_OFICINA   , COD_CAJA     , NUM_SECUMOV        , NUM_EJERCICIO, FEC_EFECTIVIDAD ,
           FEC_HISTORICO , NOM_USUARORA , TIP_MOVCAJA        , IND_DEPOSITO , IMPORTE         ,
           IND_ERRONEO   , TIP_VALOR    , IND_CIERRE         , COD_CLIENTE  , NUM_ABONADO     ,
           COD_PRODUCTO  , TIP_DOCUMENT , COD_VENDEDOR_AGENTE, LETRA        , COD_CENTREMI    ,
           NUM_SECUENCI  , LETRAC       , COD_CENTRC         , NUM_SECUC    , COD_BANCO       ,
           COD_SUCURSAL  , CTA_CORRIENTE, NUM_CHEQUE         , TIP_CLEARING , FEC_CHEQUE      ,
           COD_TIPTARJETA, NUM_TARJETA  , COD_AUTORIZA       , NUM_CUPON    , NUM_CUOTAS      ,
           FEC_CUPON     , COD_MOVILI   , DES_MOVILI         , COD_RECOMPE  , NOM_CUSTODIA    ,
           NUM_ORDEN     , FEC_EMISION  , FEC_VENCIMIENTO    , COD_COBRADOR , NUM_INGMANUAL   ,
           NUM_RESPINGR  , NUM_COMPAGO  , COD_MONEDA         , COD_OPERADORA_SCL,COD_PLAZA    ,
           PREF_PLAZA    , NUM_IDENT    )
    SELECT COD_OFICINA   , COD_CAJA     , NUM_SECUMOV        , NUM_EJERCICIO, FEC_EFECTIVIDAD ,
           SYSDATE       , NOM_USUARORA , TIP_MOVCAJA        , IND_DEPOSITO , IMPORTE         ,
           IND_ERRONEO   , TIP_VALOR    , IND_CIERRE         , COD_CLIENTE  , NUM_ABONADO     ,
           COD_PRODUCTO  , TIP_DOCUMENT , COD_VENDEDOR_AGENTE, LETRA        , COD_CENTREMI    ,
           NUM_SECUENCI  , LETRAC       , COD_CENTRC         , NUM_SECUC    , COD_BANCO       ,
           COD_SUCURSAL  , CTA_CORRIENTE, NUM_CHEQUE         , TIP_CLEARING , FEC_CHEQUE      ,
           COD_TIPTARJETA, NUM_TARJETA  , COD_AUTORIZA       , NUM_CUPON    , NUM_CUOTAS      ,
           FEC_CUPON     , COD_MOVILI   , DES_MOVILI         , COD_RECOMPE  , NOM_CUSTODIA    ,
           NUM_ORDEN 	 , FEC_EMISION  , FEC_VENCIMIENTO    , COD_COBRADOR , NUM_INGMANUAL   ,
           NUM_RESPINGR  , NUM_COMPAGO  , COD_MONEDA	     , COD_OPERADORA_SCL, COD_PLAZA   ,
           PREF_PLAZA	 , NUM_IDENT
    FROM   CO_MOVIMIENTOSCAJA
    WHERE  COD_CAJA    = iCod_caja
    AND    COD_OFICINA = sCod_oficina
    AND    NUM_EJERCICIO = vp_num_ejercicio;

    sDesc_Sql := 'DELETE FROM CO_MOVIMIENTOSCAJA (Eliminando Movimientos Cajas).  Oficina:'||sCod_oficina||' Cod_caja:'||iCod_caja;
    DELETE FROM CO_MOVIMIENTOSCAJA
    WHERE  COD_CAJA    = iCod_caja
    AND    COD_OFICINA = sCod_oficina
    AND    NUM_EJERCICIO = vp_num_ejercicio ;

    sDesc_Sql := 'UPDATE COT_CAJAS_NT SET (Cerrando Caja).  Oficina :'||sCod_oficina||' Cod_caja :'||iCod_caja;
    UPDATE COT_CAJAS_NT SET
      	  IND_ABIERTA = 0
    WHERE COD_OFICINA = sCod_oficina
    AND   COD_CAJA 	  = iCod_caja
    AND   NUM_EJERCICIO = vp_num_ejercicio;

    sDesc_Sql := 'UPDATE CET_PERIODOSERV SET COD_ESTADO = CT';
    UPDATE CET_PERIODOSERV SET
    	   COD_ESTADO    = 'CT',
    	   IND_GRUPOSERV = 0 ,
    	   FEC_ULTMOD = SYSDATE
    WHERE  COD_SERVICIO = 'REX02'
    AND    COD_PERIODO  = vp_Cod_periodo
    AND    COD_EMPRESA  = vp_Cod_empresa;


    /*IF sCod_oficina = 'NT' THEN
       sNum_ejercicio:=SUBSTR(vp_num_ejercicio,1,8);
    ELSE*/
       sNum_ejercicio:=vp_num_ejercicio;
    /*END IF;*/

    sDesc_Sql := 'UPDATE CO_INTERFAZ_PAGOS SET COD_ESTADO = PRO';
    UPDATE CO_INTERFAZ_PAGOS SET
    	   COD_ESTADO    = 'PRO'
    WHERE  SER_SOLICITADO  = 'INT'
    AND    TIP_TRANSACCION = 'A'
    AND    COD_ESTADO      IS NULL
    AND    COD_SERVICIO    = 8
    AND    EMP_RECAUDADORA = vp_Cod_empresa
    AND    NUM_EJERCICIO   = sNum_ejercicio;

    sDesc_Sql := 'INSERT INTO CO_HINTERFAZ_PAGOS';
    INSERT INTO CO_HINTERFAZ_PAGOS (
           EMP_RECAUDADORA ,COD_CAJA_RECAUDA,SER_SOLICITADO  ,FEC_EFECTIVIDAD ,NUM_TRANSACCION ,
           FEC_HISTORICO   ,NOM_USUARORA    ,TIP_TRANSACCION ,SUB_TIP_TRANSAC ,COD_SERVICIO    ,
           NUM_EJERCICIO   ,COD_CLIENTE     ,NUM_CELULAR     ,IMP_PAGO        ,NUM_FOLIOCTC    ,
           NUM_IDENT       ,TIP_VALOR       ,NUM_DOCUMENTO   ,COD_BANCO       ,CTA_CORRIENTE   ,
           COD_AUTORIZA    ,CAN_DEBE        ,MTO_DEBE        ,CAN_HABER       ,MTO_HABER       ,
           COD_ESTADO      ,COD_ERROR       ,NUM_COMPAGO     ,NUM_TARJETA     ,COD_TIPIDENT    ,
           PREF_PLAZA      ,COD_OPERACION   , DES_AGENCIA    ,NUM_TRANSACCION_EMP, COD_TIPTARJETA)
    SELECT EMP_RECAUDADORA ,COD_CAJA_RECAUDA,SER_SOLICITADO  ,FEC_EFECTIVIDAD ,NUM_TRANSACCION ,
           SYSDATE         ,NOM_USUARORA    ,TIP_TRANSACCION ,SUB_TIP_TRANSAC ,COD_SERVICIO    ,
           NUM_EJERCICIO   ,COD_CLIENTE     ,NUM_CELULAR     ,IMP_PAGO        ,NUM_FOLIOCTC    ,
           NUM_IDENT       ,TIP_VALOR       ,NUM_DOCUMENTO   ,COD_BANCO       ,CTA_CORRIENTE   ,
           COD_AUTORIZA    ,CAN_DEBE        ,MTO_DEBE        ,CAN_HABER       ,MTO_HABER       ,
           COD_ESTADO      ,COD_ERROR       ,NUM_COMPAGO     ,NUM_TARJETA     ,COD_TIPIDENT    ,
           PREF_PLAZA      ,COD_OPERACION   , DES_AGENCIA    ,NUM_TRANSACCION_EMP, COD_TIPTARJETA
    FROM   CO_INTERFAZ_PAGOS
    WHERE  EMP_RECAUDADORA = vp_Cod_empresa
    AND    NUM_EJERCICIO   = sNum_ejercicio;

    sDesc_Sql := 'Select Count por Transac. Pendientes';
    SELECT NVL(COUNT(*),0)
    INTO   iCan_Reg
    FROM   CET_PERIODOSERV B, CO_INTERFAZ_PAGOS A
    WHERE  A.SER_SOLICITADO  = 'REX'
    AND    A.TIP_TRANSACCION IN ('R','K')
    AND    A.EMP_RECAUDADORA = vp_Cod_empresa
    AND    (A.COD_ESTADO  != 'PRO' OR A.COD_ESTADO IS NULL)
    AND    A.NUM_EJERCICIO   = sNum_ejercicio
    AND    A.EMP_RECAUDADORA = B.COD_EMPRESA
    AND    SUBSTR(A.NUM_EJERCICIO,7,2)||SUBSTR(A.NUM_EJERCICIO,5,2)||SUBSTR(A.NUM_EJERCICIO,3,2) = B.COD_PERIODO
    AND    B.COD_SERVICIO    = 'REX02';

    sDesc_Sql := 'DELETE FROM  CO_INTERFAZ_PAGOS';
    DELETE FROM  CO_INTERFAZ_PAGOS
    WHERE  EMP_RECAUDADORA = vp_Cod_empresa
    AND    NUM_EJERCICIO   = sNum_ejercicio;

	/**    ANALIZAR  **/
	sDesc_Sql := 'DELETE FROM  CO_EFECTIVO_CAJAS';
    DELETE FROM  CO_EFECTIVO_CAJAS
    WHERE  COD_OFICINA = sCod_oficina
    AND    COD_CAJA    = iCod_caja
    AND    NUM_EJERCICIO   = sNum_ejercicio;

    IF (iCan_Reg > 0) THEN
       ROLLBACK;
       vp_outRetorno := 5;
       vp_outGlosa  := 'Transacciones Pendientes. Revisar';
    ELSE
       vp_outRetorno := 0;
       vp_outGlosa  := 'OK';
       COMMIT;
    END IF;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
    ROLLBACK;
        vp_outRetorno := 1;
        vp_outGlosa  := 'Error Sql : '||SQLERRM;
        INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO ,DESC_SQL , DESC_CADENA)
        VALUES (sNom_proceso, vp_error, SYSDATE ,sDesc_Sql, vp_gls_error);
        COMMIT;
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        vp_outRetorno := 100;
        vp_outGlosa  := 'Error Sql : '||SQLERRM;
        vp_gls_error := 'No Hay Datos - ' || SQLERRM;
        vp_error := SQLCODE;
        INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO, DESC_SQL , DESC_CADENA)
        VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql , vp_gls_error);
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
END CO_CIERRECAJAS;
/
SHOW ERRORS