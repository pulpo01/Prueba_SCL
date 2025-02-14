CREATE OR REPLACE PROCEDURE CO_DESAPLICA_CAJA(
		vp_Num_ComPago   IN NUMBER   ,
		vp_Pref_Plaza    IN VARCHAR2,
		vp_Cod_Oficina   IN VARCHAR2,
		vp_Cod_Caja      IN NUMBER   ,
		vp_Motivo        IN NUMBER   ,
		vp_OutGlosa      OUT VARCHAR2,
		vp_OutRetorno    OUT NUMBER
)  IS

bOutRetorno     BOOLEAN:=TRUE;
bPrimero        BOOLEAN;
dAcumPagos      CO_CARTERA.IMPORTE_DEBE%TYPE;
dImportePago    CO_PAGOS.IMP_PAGO%TYPE;

dImpPago        CO_PAGOS.IMP_PAGO%TYPE;
dPgImp_conce    CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
iCod_centremi   CO_PAGOS.COD_CENTREMI%TYPE;
iCod_cliente    CO_PAGOS.COD_CLIENTE%TYPE;
iCod_tipdocum   CO_PAGOS.COD_TIPDOCUM%TYPE;

iCod_vendedor   CO_PAGOS.COD_VENDEDOR_AGENTE%TYPE;
iContReg        NUMBER(10)   :=0;
iNum_secuenci   CO_PAGOS.NUM_SECUENCI%TYPE;
iPgCod_agente   CO_PAGOSCONC.COD_AGENTEREL%TYPE;
iPgCod_centr    CO_PAGOSCONC.COD_CENTRREL%TYPE;

iPgCod_conce    CO_PAGOSCONC.COD_CONCEPTO%TYPE;
iPgCod_tipdoc   CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
iPgColumna      CO_PAGOSCONC.COLUMNA%TYPE;
iPgNum_secu     CO_PAGOSCONC.NUM_SECUREL%TYPE;
iPgNum_venta    CO_PAGOSCONC.NUM_VENTA%TYPE;

iRetorno        NUMBER(10);
lFolio          CO_CARTERA.NUM_FOLIO%TYPE;
lFolioAnt       CO_CARTERA.NUM_FOLIO%TYPE;
lMonto          CO_CARTERA.IMPORTE_DEBE%TYPE;
lNumCargo       CO_INTERESAPLI.NUM_CARGO%TYPE;

lNumCargoCob    CO_INTERCOBAPLI.NUM_CARGO%TYPE;
lPref_Plaza     CO_CARTERA.PREF_PLAZA%TYPE;
lPref_PlazaAnt  CO_CARTERA.PREF_PLAZA%TYPE;
lSecCuota       CO_CARTERA.SEC_CUOTA%TYPE;
lSecCuotaAnt    CO_CARTERA.SEC_CUOTA%TYPE;

sCentroEmisor   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sCodAgenteVend  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sDesc_Sql       VARCHAR2(150);
sDocPagoCaja    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sLetra          CO_PAGOS.LETRA%TYPE;

sLetraPago      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sNom_proceso    VARCHAR2(50);
sNom_User       CO_CAJAS.NOM_USUARORA%TYPE;
sPgLetra        CO_PAGOSCONC.LETRA_REL%TYPE;
VP_CONVENIO     BOOLEAN := FALSE ;

vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
VP_NUM_CONVENIO VARCHAR2(50) := NULL;

dIndOrdenTotal 	FA_FACTDOCU_NOCICLO.IND_ORDENTOTAL%TYPE;
dNumProceso    	FA_FACTDOCU_NOCICLO.NUM_PROCESO%TYPE;
sCatribut      	GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
lSecTransacabo 	GA_TRANSACABO.NUM_TRANSACCION%TYPE;
lRetorno       	GA_TRANSACABO.COD_RETORNO%TYPE;
sCadena        	GA_TRANSACABO.DES_CADENA%TYPE;
sTipoTabla     	VARCHAR2(1);

ERROR_PROCESO 	EXCEPTION;

CURSOR DOCS IS
SELECT 	COD_CLIENTE ,	NUM_SECUENCI,	IMP_PAGO,
       	COD_TIPDOCUM,	COD_CENTREMI,	COD_VENDEDOR_AGENTE   ,
       	LETRA
FROM  	CO_PAGOS
WHERE  	NUM_COMPAGO =  vp_Num_ComPago
  	AND  PREF_PLAZA  =  vp_Pref_Plaza;

CURSOR DOCS_PGCONC IS
SELECT 	NVL(NUM_SECUREL,-1) ,	NVL(COD_TIPDOCREL,-1),	NVL(COD_AGENTEREL,-1),
       	NVL(LETRA_REL,' '),	NVL(COD_CENTRREL,-1),	NVL(IMP_CONCEPTO,-1) ,
	NVL(COD_CONCEPTO,-1) ,	NVL(COLUMNA,-1)  ,	NVL(NUM_VENTA,-1),
       	NUM_FOLIO,		PREF_PLAZA,		SEC_CUOTA
FROM   	CO_PAGOSCONC
WHERE  	NUM_SECUENCI       = iNum_secuenci
	AND    COD_TIPDOCUM       = iCod_tipdocum
	AND    COD_CENTREMI       = iCod_centremi
	AND    COD_VENDEDOR_AGENTE= iCod_vendedor
	AND    LETRA              = sLetra  ;

BEGIN
    	sNom_proceso    :='CO_DESAPLICA_CAJA';
    	bOutRetorno     := TRUE;
    	vp_error        := -1;
    	sDesc_Sql:='CO_DATGEN CENTRO_EMISOR,COD_VENDEDOR, DOC_PAGOCAJA, LETRA_PAGO';
    	SELECT 	1,	AGENTE_INTERNO,		DOC_PAGO,	LETRA_COBROS
	INTO 	sCentroEmisor,	sCodAgenteVend,	sDocPagoCaja,	sLetraPago
      	FROM CO_DATGEN;

    	sDesc_Sql:='SELECT CO_CAJAS.NOM_USURORA';
    	SELECT 	NOM_USUARORA
      	INTO 	sNom_User
      	FROM 	CO_CAJAS
     	WHERE 	COD_OFICINA = vp_Cod_Oficina
       		AND COD_CAJA    = vp_Cod_Caja;

    	OPEN DOCS;
    	LOOP
      		BEGIN
        		sDesc_Sql:='FETCH DOCS';
        		FETCH DOCS INTO iCod_cliente ,iNum_secuenci,dImportePago,iCod_tipdocum,iCod_centremi,iCod_vendedor,sLetra;
        		EXIT WHEN DOCS%NOTFOUND;

 			--Verifica si se trata de un Cargo por Pago en Caja
       			sDesc_Sql:='SELECT NUM_PROCESO FROM CO_INTERFAZ_CAJA';
    			BEGIN
        			SELECT 	NUM_PROCESO INTO dNumProceso
				FROM 	CO_INTERFAZ_CAJA
       				WHERE 	NUM_SECUENCI_PAGO = iNum_secuenci
               				AND TIP_MOVIMIENTO = 'CPC';
       			EXCEPTION
      				WHEN NO_DATA_FOUND THEN
               				dNumProceso := 0;
      			END;

       			IF dNumProceso != 0 THEN
       				--Verifica si Factura está en el Histórico de Facturas No Ciclicas en Proceso
       				sDesc_Sql:='SELECT IND_ORDENTOTAL FROM FA_FACTDOCU_NOCICLO';
       				BEGIN
      					SELECT IND_ORDENTOTAL, 'N'
      					INTO dIndOrdenTotal, sTipoTabla
       					FROM FA_FACTDOCU_NOCICLO
       					WHERE NUM_PROCESO = dNumProceso;
       				EXCEPTION
       					WHEN NO_DATA_FOUND THEN
               					dIndOrdenTotal := 0;
       				END;

            			IF dIndOrdenTotal = 0 THEN
            				--Anula Factura Miscelanea
            				sDesc_Sql:='UPDATE FA_INTERFACT (COD_ESTADOC  = 900)';
               				UPDATE 	FA_INTERFACT
     	           			SET 	COD_ESTADOC  = 900,
        	           			COD_ESTPROC  = 3,
        	           			NOM_USUAELIM   = (SELECT USER FROM DUAL),
        	           			COD_CAUSAELIM = '00008'
                 			WHERE 	NUM_PROCESO = dNumProceso;
            			ELSE
            				--Obtiene Catergoría Tributaria del Cliente
	          			sDesc_Sql:='SELECT COD_CATRIBUT FROM GA_CATRIBUTCLIE';
	          			SELECT 	COD_CATRIBUT
	            			INTO 	sCatribut
	            			FROM 	GA_CATRIBUTCLIE
	           			WHERE 	COD_CLIENTE = iCod_cliente
	             				AND FEC_DESDE <= SYSDATE
	             				AND FEC_HASTA >= SYSDATE;

             				--Obtiene Secuencias para la Nota de Crédito
	          			sDesc_Sql:='SELECT FA_SEQ_NUMPRO.NEXTVAL, GA_SEQ_TRANSACABO.NEXTVAL';
	          			SELECT FA_SEQ_NUMPRO.NEXTVAL, GA_SEQ_TRANSACABO.NEXTVAL
	            			INTO dNumProceso, lSecTransacabo
                			FROM DUAL;

	          			--Genera Nota de Crédito
	          			sDesc_Sql:='PL FA_PRE_NOTACREDINTER';
	          			FA_PRE_NOTACREDINTER(lSecTransacabo, dIndOrdenTotal, sTipoTabla, iCod_cliente, dNumProceso, sCatribut, 1);
	         			--Verifica si la Pl se ejecutó con Error
	          			sDesc_Sql:='SELECT COD_RETORNO, DES_CADENA FROM GA_TRANSACABO';
	          			SELECT COD_RETORNO, DES_CADENA
	            			INTO lRetorno, sCadena
	            			FROM GA_TRANSACABO
	           			WHERE NUM_TRANSACCION = lSecTransacabo;

	             			IF lRetorno != 0 THEN
	               				sDesc_Sql:= sCadena ;
	               				RAISE ERROR_PROCESO;
	             			END IF;
	        		END IF;

            			sDesc_Sql:='DELETE CO_INTERFAZ_CAJA';
		  		DELETE 	CO_INTERFAZ_CAJA
		  		WHERE 	NUM_SECUENCI_PAGO=iNum_secuenci
		  			AND TIP_MOVIMIENTO = 'CPC';
        		END IF;

        		sDesc_Sql:='SELECT IMP_PAGO FROM CO_PAGOS';
        		SELECT 	IMP_PAGO  INTO   dImpPago
        		FROM   	CO_PAGOS
        		WHERE  	NUM_SECUENCI       = iNum_secuenci
        			AND    COD_TIPDOCUM       = iCod_tipdocum
        			AND    COD_CENTREMI       = iCod_centremi
        			AND    COD_VENDEDOR_AGENTE= iCod_vendedor
        			AND    LETRA              = sLetra  ;

--TOL
-- Se agrega PLAN y LIMITE para soportar planes adicionales y SS
	 		IF iCod_tipdocum=88 THEN
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
					AND    NUM_COMPAGO		  = vp_Num_ComPago
					AND    PREF_PLAZA		  = vp_Pref_Plaza;
			END IF;
     			OPEN DOCS_PGCONC;
        		LOOP
				sDesc_Sql:='FETCH DOCS_PGCONC';
				FETCH DOCS_PGCONC INTO iPgNum_secu,iPgCod_tipdoc,iPgCod_agente,sPgLetra,iPgCod_centr,dPgImp_conce,iPgCod_conce,iPgColumna,iPgNum_venta,lFolio,lPref_Plaza,lSecCuota;
             			EXIT WHEN DOCS_PGCONC%NOTFOUND;

            			IF  (iPgCod_tipdoc = -1) AND (iPgNum_venta != -1) THEN
                			BEGIN
                    				sDesc_Sql:='DELETE FROM CO_CARTEVENTA';
                    				DELETE	FROM CO_CARTEVENTA
                     				WHERE NUM_VENTA = iPgNum_venta;

                    				sDesc_Sql:='UPDATE GA_VENTAS SET';
                    				UPDATE GA_VENTAS
                       				SET IND_PASOCOB = 0
                     				WHERE NUM_VENTA = iPgNum_venta;
                			END;
            			END IF;
        		END LOOP;
        		CLOSE DOCS_PGCONC;
      		END;
	END LOOP;

/*************************************************************************
	INI MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/
     	BEGIN
		CO_DESAPLICAPAGO_UNIVERSAL(
			vp_Num_ComPago,		vp_Pref_Plaza ,		vp_Cod_oficina,
			vp_Cod_Caja   ,		vp_Motivo     ,		VP_CONVENIO   ,
			VP_NUM_CONVENIO,	sNom_User     ,		vp_OutGlosa    ,
			vp_OutRetorno  );
    	EXCEPTION
		WHEN ERROR_PROCESO THEN
			RAISE ERROR_PROCESO;
	END;
/*************************************************************************
	FIN MODIFICACION THALES-IS UC AGOSTO 2004
*************************************************************************/

EXCEPTION
	WHEN ERROR_PROCESO THEN
		vp_OutRetorno := -1;
		vp_OutGlosa  := 'Error PROCESO : '||SQLERRM;
		vp_gls_error:='Error de Proceso';
		vp_error := SQLCODE;
		INSERT	INTO CO_TRANSAC_ERROR
			(NOM_PROCESO,COD_RETORNO,FEC_PROCESO,DESC_SQL,DESC_CADENA)
		VALUES (sNom_proceso,vp_error,SYSDATE,sDesc_Sql,vp_gls_error);
	WHEN NO_DATA_FOUND THEN
		vp_OutRetorno := 1;
		vp_OutGlosa  := 'Error NO DATA FOUND : '||SQLERRM;
		vp_gls_error := 'No Hay Datos - ' || SQLERRM;
		vp_error := SQLCODE;
		INSERT	INTO CO_TRANSAC_ERROR
			(NOM_PROCESO,COD_RETORNO,FEC_PROCESO,DESC_SQL,DESC_CADENA)
		VALUES (sNom_proceso,vp_error,SYSDATE,sDesc_Sql,vp_gls_error);
	WHEN OTHERS THEN
		vp_OutRetorno := 1;
		vp_OutGlosa  := 'Error Sql OTHERS: '||SQLERRM;
		vp_gls_error := 'Otros Errores - ' || SQLERRM;
		vp_error := SQLCODE;
		INSERT	INTO CO_TRANSAC_ERROR
			(NOM_PROCESO,COD_RETORNO,FEC_PROCESO,DESC_SQL,DESC_CADENA)
		VALUES (sNom_proceso,vp_error,SYSDATE,sDesc_Sql,vp_gls_error);
END Co_Desaplica_Caja;
/
SHOW ERRORS
