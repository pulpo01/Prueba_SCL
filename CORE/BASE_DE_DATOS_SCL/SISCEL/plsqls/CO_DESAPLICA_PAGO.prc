CREATE OR REPLACE PROCEDURE CO_DESAPLICA_PAGO( vpIn_Comprobante IN NUMBER   ,
	   	  		  			 vpIn_Pref_Plaza  IN VARCHAR2 ,
							 vpIn_TipDocPag   IN NUMBER,
                             vpIn_CodAgenPag  IN NUMBER   ,
                             vpIn_LetraPag    IN VARCHAR2,
                             vpIn_CentrEmiPag IN NUMBER   ,
                             vpIn_Motivo      IN NUMBER,
                             vpIn_TipoPago    IN NUMBER   ,
                             vp_Emp_Recauda   IN VARCHAR2,
                             vp_Cod_Caja_Rec  IN NUMBER   ,
                             vp_Cod_Moneda    IN VARCHAR2,
                             vp_Num_ejercicio IN VARCHAR2 ,
                             vp_Num_Transac   IN NUMBER,
                             vp_fecha_efec    IN VARCHAR2 ,
                             vp_outGlosa      OUT VARCHAR2,
                             vp_outRetorno    OUT NUMBER,
                             vp_tipOperacion IN NUMBER DEFAULT 1) IS

bOutRetorno     BOOLEAN:=TRUE;
dAcumPagos      NUMBER(14,4) :=0;
dImpDebeGlob    NUMBER(18,4) :=0;
dImportePago    CO_PAGOS.IMP_PAGO%TYPE;
dImpPago        CO_PAGOS.IMP_PAGO%TYPE;

dPgImp_conce    CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
iCod_centremi   CO_PAGOS.COD_CENTREMI%TYPE;
iCod_cliente    CO_PAGOS.COD_CLIENTE%TYPE;
iCod_tipdocum   CO_PAGOS.COD_TIPDOCUM%TYPE;
iCod_vendedor   CO_PAGOS.COD_VENDEDOR_AGENTE%TYPE;

iContReg        NUMBER(10)   :=0;
iDocPago        CO_DATGEN.DOC_PAGO%TYPE;
iInd_PagoCons   NUMBER(1):=0;
iNum_secuenci   CO_PAGOS.NUM_SECUENCI%TYPE;
iPgCod_agente   CO_PAGOSCONC.COD_AGENTEREL%TYPE;

iPgCod_centr    CO_PAGOSCONC.COD_CENTRREL%TYPE;
iPgCod_conce    CO_PAGOSCONC.COD_CONCEPTO%TYPE;
iPgCod_tipdoc   CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
iPgColumna      CO_PAGOSCONC.COLUMNA%TYPE;
iPgNum_secu     CO_PAGOSCONC.NUM_SECUREL%TYPE;

iPgNum_venta    CO_PAGOSCONC.NUM_VENTA%TYPE;
lNumCargo       CO_INTERESAPLI.NUM_CARGO%TYPE;
lNumCargoCob    CO_INTERCOBAPLI.NUM_CARGO%TYPE;
sDesc_Sql       VARCHAR2(150);
sLetra          CO_PAGOS.LETRA%TYPE;

sNom_proceso    VARCHAR2(50);
sNom_User       CO_CAJEROS.NOM_USUARORA%TYPE;
sPgLetra        CO_PAGOSCONC.LETRA_REL%TYPE;
vp_Cod_Caja     CO_EMPRESAS_REX.COD_CAJA%TYPE;
vp_Cod_Oficina  CO_EMPRESAS_REX.COD_OFICINA%TYPE;

vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
VP_CONVENIO     BOOLEAN := FALSE ;
VP_NUM_CONVENIO VARCHAR2(50) := NULL;



ERROR_PROCESO EXCEPTION;
BEGIN
    sNom_proceso	:='CO_DESAPLICA_PAGO';
    bOutRetorno 	:= TRUE;
    vp_error		:= -1;
    sDesc_Sql		:='SELECT OFICINA,CAJA,USUARIO';

    SELECT A.COD_OFICINA,
           A.COD_CAJA,
           B.NOM_USUARORA
      INTO vp_Cod_Oficina,
           vp_Cod_Caja ,
           sNom_User
      FROM CO_EMPRESAS_REX A,
           CO_CAJEROS B
     WHERE A.EMP_RECAUDADORA = vp_Emp_Recauda
       AND A.COD_OFICINA     = B.COD_OFICINA
       AND A.COD_CAJA        = B.COD_CAJA;

    sDesc_Sql		:='SELECT DOC_PAGO FROM CO_DATGEN';
    SELECT DOC_PAGO
      INTO iDocPago
      FROM CO_DATGEN;

    SELECT IMP_PAGO
      INTO dImportePago
      FROM CO_PAGOS
     WHERE NUM_COMPAGO =  vpIn_Comprobante
       AND PREF_PLAZA  =  vpIn_Pref_Plaza;


        IF iInd_PagoCons = 0 THEN
           CO_DESPAGCONSUMO(vp_Cod_Oficina,
           		    		vp_Cod_Caja,
							dImportePago,
							vp_Cod_Moneda,
							vpIn_Comprobante,
							vpIn_Pref_Plaza,
							vpIn_TipoPago,
							vp_Num_ejercicio,
							bOutRetorno);
           IF bOutRetorno = FALSE THEN
              sDesc_Sql:='Error en PL CO_DESPAGCONSUMO';
              RAISE ERROR_PROCESO;
           END IF;
           iInd_PagoCons:=1;
        END IF;
        
--TOL
-- Se agrega PLAN y LIMITE para soportar planes adicionales y SS
	 		--IF vpIn_TipDocPag=88 THEN
            IF vp_tipOperacion != 1 THEN
		    		sDesc_Sql:='INSERT INTO TOL_PAGO_LIMITE_TO';
		    		INSERT INTO TOL_PAGO_LIMITE_TO (
	               			COD_TIPDOCUM  , NUM_SECUENCI   , COD_CLIENTE  , COD_ABONADO , COD_MOVIMIENTO,
	               			IMP_PAGO      , FEC_EFECTIVIDAD, FEC_VALOR    , NOM_USUARORA,
	               			DES_PAGO      ,NUM_COMPAGO     , PREF_PLAZA   , COD_CICLO   , COD_OPERADORA,
	               			COD_PLAN, COD_LIMITE   )
	        		SELECT 	COD_TIPDOCUM  , NUM_SECUENCI   , COD_CLIENTE  , COD_ABONADO , 2,
	               			IMP_PAGO*(-1) , SYSDATE        , FEC_VALOR    , NOM_USUARORA,
	               			'REVERSA PAGO LIMITE DE CONSUMO', NUM_COMPAGO , PREF_PLAZA  , COD_CICLO , COD_OPERADORA,
	               			COD_PLAN, COD_LIMITE
	        		FROM   	TOL_PAGO_LIMITE_TO
	        		WHERE  	COD_MOVIMIENTO	  = 1
					AND    NUM_COMPAGO		  = vpIn_Comprobante
					AND    PREF_PLAZA		  = vpIn_Pref_Plaza;
			END IF;        
            
	/*************************************************************************
			INI MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
	BEGIN
  		Co_Desaplicapago_Universal
			(  vpIn_Comprobante,
   				vpIn_Pref_Plaza ,
   				vpIn_CodAgenPag,
   				vp_Cod_Caja_Rec   ,
   				vpIn_Motivo     ,
   				VP_CONVENIO   ,
   				VP_NUM_CONVENIO,
   				sNom_User     ,
   				vp_OutGlosa    ,
   				vp_OutRetorno  );
   		IF (vp_OutRetorno!=0 OR vp_OutRetorno IS NULL) THEN
			RAISE ERROR_PROCESO;
		END IF;
	END;
	/*************************************************************************
			FIN MODIFICACION THALES-IS UC AGOSTO 2004
		*************************************************************************/
    sDesc_Sql:='UPDATE CO_INTERFAZ_PAGOS SET COD_ESTADO = PRO';
    UPDATE CO_INTERFAZ_PAGOS
       SET COD_ESTADO 		= 'PRO'
     WHERE EMP_RECAUDADORA 	= vp_Emp_Recauda
       AND COD_CAJA_RECAUDA = vp_Cod_Caja_Rec
       AND FEC_EFECTIVIDAD  = TO_DATE(vp_fecha_efec,'DD-MM-YYYY HH24:MI:SS')
       AND NUM_TRANSACCION 	= vp_Num_Transac
       AND TIP_TRANSACCION 	= 'R';

    vp_outRetorno 		:= 0;
    vp_outGlosa  		:= 'OK';
    COMMIT;

    EXCEPTION
        WHEN ERROR_PROCESO THEN
             ROLLBACK;
                     vp_outRetorno 	:= 1;
                     vp_outGlosa  	:= 'Error Sql : '||SQLERRM;
                     vp_gls_error	:='Error de Proceso';
                     vp_error := SQLCODE;
             INSERT
               INTO CO_TRANSAC_ERROR (NOM_PROCESO,
               			      COD_RETORNO,
               			      FEC_PROCESO,
               			      DESC_SQL ,
               			      DESC_CADENA)
             VALUES (sNom_proceso,
                     vp_error,
                     SYSDATE,
                     sDesc_Sql,
                     vp_gls_error);
             COMMIT;
        WHEN NO_DATA_FOUND THEN
             ROLLBACK;
                     vp_outRetorno 	:= 1;
                     vp_outGlosa  	:= 'Error Sql : '||SQLERRM;
                     vp_gls_error 	:= 'No Hay Datos - ' || SQLERRM;
                     vp_error 		:= SQLCODE;
             INSERT
               INTO CO_TRANSAC_ERROR (NOM_PROCESO,
                                      COD_RETORNO,
                                      FEC_PROCESO,
                                      DESC_SQL ,
                                      DESC_CADENA)
             VALUES (sNom_proceso,
                     vp_error,
                     SYSDATE,
                     sDesc_Sql ,
                     vp_gls_error);
	     COMMIT;
        WHEN OTHERS THEN
             ROLLBACK;
                     vp_outRetorno 	:= 1;
                     vp_outGlosa  	:= 'Error Sql : '||SQLERRM;
                     vp_gls_error 	:= 'Otros Errores - ' || SQLERRM;
                     vp_error 		:= SQLCODE;
             INSERT
               INTO CO_TRANSAC_ERROR (NOM_PROCESO,
                                      COD_RETORNO,
                                      FEC_PROCESO,
                                      DESC_SQL ,
                                      DESC_CADENA)
             VALUES (sNom_proceso,
                     vp_error,
                     SYSDATE,
                     sDesc_Sql,
                     vp_gls_error);
             COMMIT;
END Co_Desaplica_Pago;
/
SHOW ERRORS