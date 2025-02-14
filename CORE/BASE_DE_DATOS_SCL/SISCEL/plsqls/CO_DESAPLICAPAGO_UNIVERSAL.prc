CREATE OR REPLACE PROCEDURE CO_DESAPLICAPAGO_UNIVERSAL(
	vp_Num_ComPago   	IN NUMBER   ,
   	vp_Pref_Plaza    		IN VARCHAR2 ,
   	vp_Cod_Oficina   		IN VARCHAR2 ,
   	vp_Cod_Caja      		IN NUMBER   ,
   	vp_Motivo        		IN NUMBER   ,
   	VP_CONVENIO      		IN BOOLEAN  ,
   	VP_NUM_CONVENIO  	IN VARCHAR2,
   	sNom_User        		IN VARCHAR2,
   	vp_OutGlosa      		OUT  NOCOPY VARCHAR2,
   	vp_OutRetorno    		OUT  NOCOPY NUMBER
) IS

bOutRetorno     		BOOLEAN;
bPrimero        		BOOLEAN;
CONTADOR        		NUMBER(10);
CONTADOR_COB        	NUMBER(10);
CONTCARGOS      		NUMBER(10);
dAcumPagos      		CO_CARTERA.IMPORTE_DEBE%TYPE;

dImpDebeGlob    		CO_CARTERA.IMPORTE_DEBE%TYPE;
dImportePago    		CO_PAGOS.IMP_PAGO%TYPE;
dImpPago        		CO_PAGOS.IMP_PAGO%TYPE;
dPgImp_conce    		CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
dPgImp_conce1   		CO_PAGOSCONC.IMP_CONCEPTO%TYPE;
iCod_centremi   		CO_PAGOS.COD_CENTREMI%TYPE;

iCod_cliente    		CO_PAGOS.COD_CLIENTE%TYPE;
iCod_tipdocum   		CO_PAGOS.COD_TIPDOCUM%TYPE;
iCod_vendedor   		CO_PAGOS.COD_VENDEDOR_AGENTE%TYPE;
iContReg        		NUMBER(10);
iNum_secuenci   		CO_PAGOS.NUM_SECUENCI%TYPE;

iPgCod_agente   		CO_PAGOSCONC.COD_AGENTEREL%TYPE;
iPgCod_centr    		CO_PAGOSCONC.COD_CENTRREL%TYPE;
iPgCod_conce    		CO_PAGOSCONC.COD_CONCEPTO%TYPE;
iPgCod_tipdoc   		CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
iPgColumna      		CO_PAGOSCONC.COLUMNA%TYPE;

iPgNum_secu     		CO_PAGOSCONC.NUM_SECUREL%TYPE;
iPgNum_venta    		CO_PAGOSCONC.NUM_VENTA%TYPE;
iRetorno        		NUMBER(10);
lFolio          			CO_CARTERA.NUM_FOLIO%TYPE;
lFolioAnt       			CO_CARTERA.NUM_FOLIO%TYPE;
lColumna       			CO_CARTERA.COLUMNA%TYPE;
lColumnaAnt    		CO_CARTERA.COLUMNA%TYPE;

lMonto          			CO_CARTERA.IMPORTE_DEBE%TYPE;
lNumCargo       		CO_INTERESAPLI.NUM_CARGO%TYPE;
lNumCargoCob    		CO_INTERCOBAPLI.NUM_CARGO%TYPE;
lPref_Plaza     		CO_CARTERA.PREF_PLAZA%TYPE;
lPref_PlazaAnt  		CO_CARTERA.PREF_PLAZA%TYPE;
sDesPago				CO_PAGOS.DES_PAGO%TYPE;

lSecCuota       		CO_CARTERA.SEC_CUOTA%TYPE;
lSecCuotaAnt    		CO_CARTERA.SEC_CUOTA%TYPE;
NUMCARGO        		GE_CARGOS.NUM_CARGO%TYPE;
RR_CUENTA       		NUMBER(10);
sCentroEmisor   		GED_PARAMETROS.VAL_PARAMETRO%TYPE;

sCodAgenteVend  		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sDesc_Sql       		VARCHAR2(150);
sDocPagoCaja    		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sLetra          			CO_PAGOS.LETRA%TYPE;
sLetraPago      		GED_PARAMETROS.VAL_PARAMETRO%TYPE;

sNom_proceso    		VARCHAR2(50);
sPgLetra        		CO_PAGOSCONC.LETRA_REL%TYPE;
vp_caja         		CO_MOVIMIENTOSCAJA.COD_CAJA%TYPE;
vp_cod_moneda   		CO_MOVIMIENTOSCAJA.COD_MONEDA%TYPE;

vp_cod_operadora 		CO_MOVIMIENTOSCAJA.COD_OPERADORA_SCL%TYPE;
vp_cod_plaza    		CO_MOVIMIENTOSCAJA.COD_PLAZA%TYPE;
vp_contador     		NUMBER(10);
vp_efectivo     		CO_MOVIMIENTOSCAJA.IMPORTE%TYPE;
vp_err_orcl     		NUMBER(2);

vp_error        		NUMBER(5);
vp_gls_error    		VARCHAR2(255);
vp_monto        		CO_CARTERA.IMPORTE_DEBE%TYPE;
vp_oficina      		CO_MOVIMIENTOSCAJA.COD_OFICINA%TYPE;
vp_ruteo        		NUMBER(2);

iNumVenta       		CO_CARTERA.NUM_VENTA%TYPE;
iCodCliente     		CO_CARTERA.COD_CLIENTE%TYPE;
vp_saldo        		CO_CARTERA.IMPORTE_DEBE%TYPE;
vp_tipo_convenio 		CO_CONVENIOS.TIPO_CONVENIO%TYPE;

TN_numtransaccion	GA_TRANSACABO.NUM_TRANSACCION%TYPE;
GN_indcarrier			PLS_INTEGER := 0;
TN_retorno 			GA_TRANSACABO.COD_RETORNO%TYPE;
TV_glosa				GA_TRANSACABO.DES_CADENA%TYPE;

ERROR_PROCESO 		EXCEPTION;

CURSOR DOCS IS
	SELECT 	COD_CLIENTE ,	NUM_SECUENCI,			IMP_PAGO,
       		COD_TIPDOCUM,	COD_CENTREMI,			COD_VENDEDOR_AGENTE,
			LETRA,			DECODE(UPPER(DES_PAGO),	UPPER('Pago Efectuado Por Convenio'),'1','0')
  	FROM 	CO_PAGOS
 	WHERE 	NUM_COMPAGO 	=  vp_Num_ComPago
   	    AND 	PREF_PLAZA  		=  vp_Pref_Plaza;

CURSOR DOCS_PGCONC IS
	SELECT 	NVL(NUM_SECUREL,-1),	NVL(COD_TIPDOCREL,-1),	NVL(COD_AGENTEREL,-1),
       		NVL(LETRA_REL,' '),		NVL(COD_CENTRREL,-1),	NVL(IMP_CONCEPTO,-1) ,
			NVL(COD_CONCEPTO,-1) ,	NVL(COLUMNA,-1)  ,		NVL(NUM_VENTA,-1),
			NUM_FOLIO, 				PREF_PLAZA, 				SEC_CUOTA
  	FROM 	CO_PAGOSCONC
 	WHERE 	NUM_SECUENCI       		= iNum_secuenci
   	    AND 	COD_TIPDOCUM       		= iCod_tipdocum
   	    AND 	COD_CENTREMI       		= iCod_centremi
	    AND 	COD_VENDEDOR_AGENTE	= iCod_vendedor
   	    AND 	LETRA              			= sLetra;

CURSOR DOCS_CARGOSMORA IS
	SELECT 	NUM_CARGO
  	FROM 	CO_INTERESAPLI
 	WHERE 	COD_TIPDOCUM   			= sDocPagoCaja
   	    AND 	COD_CENTREMI    			= sCentroEmisor
   	    AND 	NUM_SECUENCI    			= iNum_secuenci
   	    AND 	COD_VENDEDOR_AGENTE 	= sCodAgenteVend
   	    AND 	LETRA           			= sLetraPago
   	    AND 	NUM_CARGO       			> 0;

CURSOR DOCS_INTERCOBAPLI IS
	SELECT 	DISTINCT(NUM_CARGO)
  	FROM 	CO_INTERCOBAPLI
 	WHERE 	COD_TIPDOCUM    			= sDocPagoCaja
   	    AND 	COD_CENTREMI    			= sCentroEmisor
           AND 	NUM_SECUENCI    			= iNum_secuenci
   	    AND 	COD_VENDEDOR_AGENTE 	= sCodAgenteVend
          AND 	LETRA           			= sLetraPago
   	    AND 	NUM_CARGO       			> 0;

CURSOR CODETCONVENIO (NUMEROCONVENIO NUMBER) IS
	SELECT 	COD_CLIENTE,			NUM_SECUENCI_CA,	COD_TIPDOCUM_CA,
			COD_VEND_AGENTE_CA,	LETRA_CA,			IMPORTE_CA,
			SEC_CUOTA_CA,			COD_CONCEPTO_CA,	COLUMNA_CA,
			NUM_ABONADO_CA,		COD_CENTREMI_CA
  	FROM 	CO_DET_CONVENIO
 	WHERE 	NUM_CONVENIO = NUMEROCONVENIO;

CURSOR DOCUMENTOS (NUMSECUMOV NUMBER,NUMCHEQUE NUMBER,CTACORRIENTE VARCHAR2) IS
	SELECT 	NUM_DOCUMENTO,	NUM_SECUENCI
  	FROM 	CO_DOCUMENTOS
 	WHERE 	NUM_SECUMOV   		= NUMSECUMOV
   	    AND 	NUM_DOCUMENTO 	= NUMCHEQUE
   	    AND 	CTA_CORRIENTE 		= CTACORRIENTE;

CURSOR DOCUMENTOS1 (NUMSECUMOV NUMBER,NUMCHEQUE NUMBER) IS
	SELECT 	NUM_DOCUMENTO,	NUM_SECUENCI
  	FROM 	CO_DOCUMENTOS
 	WHERE 	NUM_SECUMOV   		= NUMSECUMOV
   	    AND 	NUM_DOCUMENTO 	= NUMCHEQUE
   	    AND 	COD_TIPDOCUM    		= 5;

CURSOR CUENTA (NUMSECUENCI NUMBER,TIPDOCUM NUMBER,AGENTE VARCHAR2,LETRA VARCHAR2,CENTREMI VARCHAR2,CLIENTE NUMBER) IS
  	SELECT 	COUNT(COUNT(*))
    	FROM 	CO_INTERESAPLI
   	WHERE 	NUM_SECUENCI       		= NUMSECUENCI
     	    AND 	COD_TIPDOCUM       		= TIPDOCUM
     	    AND 	COD_VENDEDOR_AGENTE	= AGENTE
     	    AND 	LETRA              			= LETRA
     	    AND 	COD_CENTREMI       		= CENTREMI
     	    AND 	COD_CLIENTE        		= CLIENTE
	GROUP BY NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, COD_CLIENTE;

CURSOR CUENTA_COB (NUMSECUENCI NUMBER,TIPDOCUM NUMBER,AGENTE VARCHAR2,LETRA VARCHAR2,CENTREMI VARCHAR2,CLIENTE NUMBER) IS
  	SELECT 	COUNT(COUNT(*))
    	FROM 	CO_INTERCOBAPLI
   	WHERE 	NUM_SECUENCI       		= NUMSECUENCI
     	    AND 	COD_TIPDOCUM       		= TIPDOCUM
     	    AND 	COD_VENDEDOR_AGENTE	= AGENTE
     	    AND 	LETRA              			= LETRA
     	    AND 	COD_CENTREMI       		= CENTREMI
     	    AND 	COD_CLIENTE        		= CLIENTE
	GROUP BY NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, COD_CLIENTE;

CURSOR COMOVIMIENTOSCAJA IS
	SELECT 	NUM_SECUMOV,	NUM_CHEQUE,	CTA_CORRIENTE
  	FROM 	CO_MOVIMIENTOSCAJA
 	WHERE 	NUM_COMPAGO	=TO_NUMBER(VP_NUM_COMPAGO)
   	    AND 	PREF_PLAZA 		= VP_PREF_PLAZA;

CURSOR COCANCELADOS (CLIENTE NUMBER,SECUENCI_CA NUMBER,TIPDOCUM_CA NUMBER,VEND_AGENTE_CA VARCHAR2,LETRA_CA VARCHAR2,CONCEPTO NUMBER,COLUMNA1 NUMBER,ABONADO NUMBER,CENTREMI NUMBER) IS
	SELECT 	COD_CLIENTE,	COD_TIPDOCUM,			COD_CENTREMI,
			NUM_SECUENCI,	COD_VENDEDOR_AGENTE,	LETRA,
			COD_CONCEPTO,	COLUMNA,				IMPORTE_HABER
  	FROM 	CO_CANCELADOS
 	WHERE 	COD_CLIENTE         		= CLIENTE
   	    AND 	COD_TIPDOCUM        		= TIPDOCUM_CA
   	    AND 	NUM_SECUENCI        		= SECUENCI_CA
          AND 	COD_VENDEDOR_AGENTE	= VEND_AGENTE_CA
   	   AND 	LETRA               			= LETRA_CA
   	   AND 	COD_CONCEPTO        		= CONCEPTO
   	   AND 	COLUMNA             		= COLUMNA1
   	   AND 	NUM_ABONADO         		= ABONADO
   	   AND 	COD_CENTREMI        		= CENTREMI;

CURSOR COCANCELADOS1 (CLIENTE NUMBER,SECUENCI_CA NUMBER,TIPDOCUM_CA NUMBER,VEND_AGENTE_CA VARCHAR2,LETRA_CA VARCHAR2,CUOTA NUMBER,CONCEPTO NUMBER,COLUMNA1 NUMBER,ABONADO NUMBER,CENTREMI NUMBER) IS
	SELECT 	COD_CLIENTE,	COD_TIPDOCUM,			COD_CENTREMI,
			NUM_SECUENCI,	COD_VENDEDOR_AGENTE,	LETRA,
			COD_CONCEPTO,	COLUMNA,				IMPORTE_HABER
  	FROM 	CO_CANCELADOS
 	WHERE 	COD_CLIENTE         		= CLIENTE
   	    AND 	COD_TIPDOCUM        		= TIPDOCUM_CA
   	    AND 	NUM_SECUENCI        		= SECUENCI_CA
   	    AND 	COD_VENDEDOR_AGENTE	= VEND_AGENTE_CA
   	    AND 	LETRA               			= LETRA_CA
   	    AND 	SEC_CUOTA           		= CUOTA
   	    AND 	COD_CONCEPTO        		= CONCEPTO
   	    AND 	COLUMNA             		= COLUMNA1
   	    AND 	NUM_ABONADO         		= ABONADO
   	    AND 	COD_CENTREMI        		= CENTREMI;

/*VAR_DURA ***********************************/
vcod_tipdocum_1		NUMBER(2);
vcod_tipdocum_2		NUMBER(2);
/*VAR_DURA ***********************************/

BEGIN
    	sNom_proceso:='CO_DESAPLICA_UNIVERSAL';
	bOutRetorno:=TRUE;
	vp_error:=-1;
	dAcumPagos:=0;
	dImpDebeGlob:=0;
	bOutRetorno:=TRUE;
	iContReg:=0;
	/*VAR_DURA ***********************************/
	vcod_tipdocum_1:=5;
	vcod_tipdocum_2:=59;
	/*VAR_DURA ***********************************/

	IF (VP_CONVENIO) THEN
		SELECT 	TIPO_CONVENIO
		INTO 	vp_tipo_convenio
      		FROM 	CO_CONVENIOS
     		WHERE 	NUM_CONVENIO = TO_NUMBER(VP_NUM_CONVENIO);
	END IF;

	OPEN DOCS;
	LOOP
      		BEGIN
        		sDesc_Sql:='FETCH DOCS';
        		FETCH DOCS INTO iCod_cliente,iNum_secuenci,dImportePago,iCod_tipdocum,iCod_centremi,iCod_vendedor,sLetra,sDesPago;
        		EXIT WHEN DOCS%NOTFOUND;
			sDesc_Sql:='INSERT INTO CO_DESAPAGOS';
        		INSERT INTO CO_DESAPAGOS(
         			COD_TIPDOCUM,			COD_CENTREMI,	NUM_SECUENCI,
				COD_VENDEDOR_AGENTE,	LETRA,			COD_CLIENTE,
				IMP_PAGO,				FEC_EFECTIVIDAD,	FEC_VALOR,
				NOM_USUARORA,			COD_FORPAGO,	COD_SISPAGO,
				COD_ORIPAGO,			COD_CAUPAGO,	FEC_DESAPLICA,
				NOM_USUARIOSDESAP,		TIP_DESAPLICA,	COD_BANCO,
				COD_TIPTARJETA,			COD_CAJA,		COD_SUCURSAL,
				CTA_CORRIENTE,			NUM_TARJETA,	DES_PAGO,
				PREF_PLAZA)
        		SELECT 	COD_TIPDOCUM,		COD_CENTREMI,	NUM_SECUENCI,
				COD_VENDEDOR_AGENTE,	LETRA,			COD_CLIENTE,
				IMP_PAGO,				FEC_EFECTIVIDAD,	FEC_VALOR,
				NOM_USUARORA,			COD_FORPAGO,	COD_SISPAGO,
				COD_ORIPAGO,			COD_CAUPAGO,	SYSDATE,
				sNom_User,				vp_Motivo,		COD_BANCO,
				COD_TIPTARJETA,			COD_CAJA,		COD_SUCURSAL,
				CTA_CORRIENTE,			NUM_TARJETA,	DES_PAGO,
				PREF_PLAZA
			FROM
				CO_PAGOS
         		WHERE
				NUM_SECUENCI       			= iNum_secuenci
           			AND COD_TIPDOCUM       		= iCod_tipdocum
           			AND COD_CENTREMI       		= iCod_centremi
           			AND COD_VENDEDOR_AGENTE	= iCod_vendedor
           			AND LETRA              			= sLetra  ;

        		sDesc_Sql:='INSERT INTO CO_DESAPAGOSCONC';
			INSERT INTO CO_DESAPAGOSCONC(
				COD_TIPDOCUM,			COD_CENTREMI,		NUM_SECUENCI,
				COD_VENDEDOR_AGENTE,	LETRA,				IMP_CONCEPTO,
				COD_PRODUCTO,			NUM_SECUREL,		COD_TIPDOCREL,
				COD_AGENTEREL,			NUM_TRANSACCION,	LETRA_REL,
				COD_CENTRREL,			COD_CONCEPTO,		COLUMNA,
				NUM_ABONADO,			NUM_FOLIO,			NUM_CUOTA,
				SEC_CUOTA,				NUM_VENTA,			COD_OPERADORA_SCL,
				COD_PLAZA,				PREF_PLAZA)
        		SELECT 	COD_TIPDOCUM,		COD_CENTREMI,		NUM_SECUENCI,
				COD_VENDEDOR_AGENTE,	LETRA,				IMP_CONCEPTO,
				COD_PRODUCTO,			NUM_SECUREL,		COD_TIPDOCREL,
				COD_AGENTEREL,			NUM_TRANSACCION,	LETRA_REL,
				COD_CENTRREL,			COD_CONCEPTO,		COLUMNA,
				NUM_ABONADO,			NUM_FOLIO,			NUM_CUOTA,
				SEC_CUOTA,				NUM_VENTA,			COD_OPERADORA_SCL,
				COD_PLAZA,				PREF_PLAZA
          		FROM
				CO_PAGOSCONC
         		WHERE
				NUM_SECUENCI       			= iNum_secuenci
           			AND COD_TIPDOCUM       		= iCod_tipdocum
           			AND COD_CENTREMI       		= iCod_centremi
           			AND COD_VENDEDOR_AGENTE	= iCod_vendedor
           			AND LETRA              			= sLetra  ;

      			lFolioAnt:=0;
      			lPref_PlazaAnt:='';
      			lSecCuotaAnt:=0;
      			lMonto:=0;
      			bPrimero:=TRUE;

      			IF (NOT vp_convenio) THEN
         			BEGIN
					OPEN DOCS_PGCONC;
	        			dAcumPagos:=0;
	        			LOOP
	            				sDesc_Sql:='FETCH DOCS_PGCONC';
	            				FETCH DOCS_PGCONC INTO iPgNum_secu,iPgCod_tipdoc,iPgCod_agente,sPgLetra,iPgCod_centr,dPgImp_conce,iPgCod_conce,iPgColumna,iPgNum_venta, lFolio, lPref_Plaza, lSecCuota;
	             				EXIT WHEN DOCS_PGCONC%NOTFOUND;

	            				dAcumPagos := dAcumPagos + dPgImp_conce;
	            				iContReg   := iContReg + 1;

						IF  (iPgCod_tipdoc = -1) AND (iPgNum_venta != -1) THEN
                					BEGIN
                    					sDesc_Sql:='DELETE FROM CO_CARTEVENTA';
                    					DELETE 	FROM CO_CARTEVENTA
                    					WHERE  	NUM_VENTA = iPgNum_venta;

                    					sDesc_Sql:='UPDATE GA_VENTAS SET';
                    					UPDATE 	GA_VENTAS
                    					SET 		IND_PASOCOB 	= 0
                    					WHERE 	NUM_VENTA 		= iPgNum_venta;
                					END;
            					ELSE
	            					BEGIN
		               				Co_SelectCo_Cancelados(iPgCod_tipdoc,iPgCod_centr,iPgNum_secu,iPgCod_agente,sPgLetra,iPgCod_conce,iPgColumna,dImpDebeGlob);
		               				IF (dImpDebeGlob=-99999999) THEN
		                     				sDesc_Sql:='Error en PL Co_SelectCo_Cancelados 1';
		                      				RAISE ERROR_PROCESO;
		                   				ELSIF dImpDebeGlob = -99999000 THEN
		                      				BEGIN
		                        					--Inicio Soporte RyC CGLagos 05-12-2005 RA-200511180145
		                        					--IF (iPgCod_tipdoc=8) THEN
		                        					IF (iPgCod_tipdoc=8) OR (iPgCod_tipdoc=88) THEN
		                        					--Fin Soporte RyC CGLagos 05-12-2005 RA-200511180145
		                            					sDesc_Sql:='Error DELETE FROM   CO_CARTERA';
		                            					DELETE 	FROM CO_CARTERA
		                             					WHERE	COD_TIPDOCUM    			= iPgCod_tipdoc
		                               					    AND 	COD_CENTREMI    			= iPgCod_centr
		                               					    AND 	NUM_SECUENCI    			= iPgNum_secu
		                               					    AND 	COD_VENDEDOR_AGENTE 	= iPgCod_agente
		                               					    AND 	LETRA           			= sPgLetra
		                               					    AND 	COD_CONCEPTO    		= iPgCod_conce
		                               					    AND 	COLUMNA         			= iPgColumna;

										ELSIF (iPgCod_tipdoc = 32) THEN
											BEGIN
												sDesc_Sql:='SELECT NUM_VENTA CO_CARTERA';
												SELECT 	UNIQUE 	NUM_VENTA , COD_CLIENTE
												INTO   	iNumVenta , iCodCliente
												FROM   	CO_CARTERA
												WHERE	COD_TIPDOCUM        		= iPgCod_tipdoc
												    AND   COD_CENTREMI            	= iPgCod_centr
												    AND   NUM_SECUENCI        		= iPgNum_secu
												    AND   COD_VENDEDOR_AGENTE 	= iPgCod_agente
												    AND   LETRA                   		= sPgLetra
												    AND	COD_CONCEPTO            	= iPgCod_conce
												    AND   COLUMNA                 		= iPgColumna;

												sDesc_Sql:='UPDATE GA_ABONADO_GARANTIA' ;
												UPDATE 	GA_ABONADO_GARANTIA
												SET		IND_PAGO       	= 0,
														FECHA_PAGO     	= NULL,
														IND_GPAPLICADA 	=      NULL
												WHERE  	NUM_VENTA      	= iNumVenta
												    AND 	COD_CLIENTE    	= iCodCliente;

												sDesc_Sql:='UPDATE GA_VENTAS' ;
												UPDATE 	GA_VENTAS
												SET    	IND_PASOCOB	= 0
												WHERE  	NUM_VENTA 	= iNumVenta ;

												sDesc_Sql:='Error DELETE FROM   CO_CARTERA';
												DELETE	FROM   CO_CARTERA
												WHERE 	COD_TIPDOCUM            	= iPgCod_tipdoc
												    AND	COD_CENTREMI       		= iPgCod_centr
												    AND   NUM_SECUENCI       		= iPgNum_secu
												    AND   COD_VENDEDOR_AGENTE	= iPgCod_agente
												    AND   LETRA              			= sPgLetra
												    AND   COD_CONCEPTO       		= iPgCod_conce
												    AND   COLUMNA            			= iPgColumna;
											END;
										ELSE
		                            					Co_UpdateCo_Cartera(iPgCod_tipdoc,iPgCod_centr,iPgNum_secu,iPgCod_agente,sPgLetra,iPgCod_conce,iPgColumna,dPgImp_conce,bOutRetorno);
											IF (bOutRetorno=FALSE) THEN
		                               						sDesc_Sql:='Error en PL Co_UpdateCo_Cartera';
		                               						RAISE ERROR_PROCESO;
		                            					END IF;
		                        					END IF;
		                      				END;
		                   				ELSE
		                      				BEGIN
		                        					Co_InsertCo_Cartera(iPgCod_tipdoc,iPgCod_centr,iPgNum_secu,iPgCod_agente,sPgLetra,iPgCod_conce,iPgColumna,dPgImp_conce,bOutRetorno);
		                        					IF (bOutRetorno=FALSE) THEN
		                           					sDesc_Sql:='Error en PL Co_InsertCo_Cartera 1';
		                           					RAISE ERROR_PROCESO;
		                        					END IF;

		                        					IF (dImpDebeGlob>dPgImp_conce) THEN
		                           					BEGIN
		                                					sDesc_Sql:='Error UPDATE CO_CARTERA SET';
												dPgImp_conce1:=dPgImp_conce-dImpDebeGlob;
	                                    						Co_UpdateCo_Cartera(iPgCod_tipdoc,iPgCod_centr,iPgNum_secu,iPgCod_agente,sPgLetra,iPgCod_conce,iPgColumna,dPgImp_conce1,bOutRetorno);
		                           					END;
		                        					END IF;

		                        					Co_DeleteCo_Cancelados(iPgCod_tipdoc,iPgCod_centr,iPgNum_secu,iPgCod_agente,sPgLetra,iPgCod_conce,iPgColumna,bOutRetorno);
		                      				END;
		                   				END IF;

		                    			IF (lFolioAnt!=lFolio OR lPref_PlazaAnt!=lPref_Plaza OR lSecCuotaAnt!=lSecCuota ) AND NOT bPrimero THEN

	                           				CO_DESAPLICA_CASTIGOS_PR(iCod_cliente,lFolioAnt,lPref_PlazaAnt,lMonto,lSecCuotaAnt,iRetorno);

									lFolioAnt := 0;
									lPref_PlazaAnt := '';
									lSecCuotaAnt := 0;
									lMonto := 0;
	                         				END IF;

	                        				lFolioAnt		:=lFolio;
	                        				lPref_PlazaAnt:=lPref_Plaza;
	                        				lSecCuotaAnt	:=lSecCuota;
	                        				lMonto		:=lMonto+dPgImp_conce;
	                        				bPrimero		:=FALSE;
	            					END;
	           				END IF;
	        			END LOOP;
	        			CLOSE DOCS_PGCONC;

                			CO_DESAPLICA_CASTIGOS_PR(iCod_cliente,lFolioAnt,lPref_PlazaAnt,lMonto,lSecCuotaAnt,iRetorno);

					IF iContReg != 0 THEN
						IF dAcumPagos != dImportePago THEN
               					sDesc_Sql:='Error en Cuadratura de Importe entre Pagos y Pagosconc';
               					RAISE ERROR_PROCESO;
            					END IF;
					END IF;
				END;
			ELSE
				IF (sDesPago='1') THEN
		 			FOR rReg IN CODETCONVENIO(TO_NUMBER(VP_NUM_CONVENIO)) LOOP
		  				BEGIN
		         				IF (rReg.SEC_CUOTA_CA IS NULL OR rReg.SEC_CUOTA_CA=0) THEN
		                 				vp_gls_error := 'select a CO_CANCELADOS de facturas canceladas';
		                 				SELECT 	COUNT(*)
		                 				INTO 	RR_CUENTA
		                   				FROM 	CO_CANCELADOS
		                  				WHERE 	COD_CLIENTE         		= rReg.COD_CLIENTE
		                    			    AND 	NUM_SECUENCI        		= rReg.NUM_SECUENCI_CA
		                    			    AND 	COD_TIPDOCUM        		= rReg.COD_TIPDOCUM_CA
		                    			    AND 	COD_VENDEDOR_AGENTE	= rReg.COD_VEND_AGENTE_CA
		                    			    AND 	LETRA               			= rReg.LETRA_CA
		                    			    AND 	COD_CONCEPTO        		= rReg.COD_CONCEPTO_CA
				    				    AND 	COLUMNA             		= rReg.COLUMNA_CA
				    				    AND 	NUM_ABONADO         		= rReg.NUM_ABONADO_CA
				    				    AND 	COD_CENTREMI        		= rReg.COD_CENTREMI_CA;

		                    			IF (RR_CUENTA > 0) THEN
									vp_saldo 		:= rReg.IMPORTE_CA;
				            				vp_monto 	:= 0;
									vp_gls_error 	:= 'inicio de ciclo COCANCELADOS';

									FOR rReg1 IN COCANCELADOS(rReg.COD_CLIENTE,rReg.NUM_SECUENCI_CA,rReg.COD_TIPDOCUM_CA,rReg.COD_VEND_AGENTE_CA,rReg.LETRA_CA,rReg.COD_CONCEPTO_CA,rReg.COLUMNA_CA,rReg.NUM_ABONADO_CA,rReg.COD_CENTREMI_CA) LOOP
			               					vp_gls_error:='insercion a CO_CARTERA de facturas canceladas';

	    									IF (vp_saldo=0) THEN
				        						Vp_monto := rReg1.IMPORTE_HABER;
										ELSE
											vp_monto := rReg1.IMPORTE_HABER - vp_saldo;
										END IF;

		                       					Co_InsertCo_Cartera(rReg1.COD_TIPDOCUM,rReg1.COD_CENTREMI,rReg1.NUM_SECUENCI,rReg1.COD_VENDEDOR_AGENTE,rReg1.LETRA,rReg1.COD_CONCEPTO,rReg1.COLUMNA,vp_monto,bOutRetorno);
		                       					IF (bOutRetorno = FALSE) THEN
		                          					sDesc_Sql:='Error en PL Co_InsertCo_Cartera 1';
		                           					RAISE ERROR_PROCESO;
		                        					END IF;

			                       				vp_gls_error := 'borrado de CO_CANCELADOS facturas canceladas';

			                       				Co_DeleteCo_Cancelados(rReg1.COD_TIPDOCUM,rReg1.COD_CENTREMI,rReg1.NUM_SECUENCI,rReg1.COD_VENDEDOR_AGENTE,rReg1.LETRA,rReg1.COD_CONCEPTO,rReg1.COLUMNA,bOutRetorno);
		                        					IF (bOutRetorno = FALSE) THEN
		                           					sDesc_Sql	:='Error en PL Co_DeleteCo_Cancelados 1';
		                           					RAISE ERROR_PROCESO;
		                        					END IF;
			                    				vp_saldo := vp_saldo - (rReg1.IMPORTE_HABER - vp_monto) ;
			                    			END LOOP;
			            				ELSE
			                   				UPDATE 	CO_CARTERA
			                   				SET		IMPORTE_HABER 			= IMPORTE_HABER - rReg.IMPORTE_CA
			                    			WHERE 	COD_CLIENTE         		= rReg.COD_CLIENTE
			                      			    AND 	NUM_SECUENCI        		= rReg.NUM_SECUENCI_CA
			                      			    AND 	COD_TIPDOCUM        		= rReg.COD_TIPDOCUM_CA
			                      			    AND   COD_VENDEDOR_AGENTE 	= rReg.COD_VEND_AGENTE_CA
			                      			    AND 	LETRA               			= rReg.LETRA_CA
			                      			    AND   COD_CONCEPTO        		= rReg.COD_CONCEPTO_CA
			                      			    AND 	COLUMNA             		= rReg.COLUMNA_CA
			                      			    AND 	NUM_ABONADO         		= rReg.NUM_ABONADO_CA
			                      			    AND 	COD_CENTREMI        		= rReg.COD_CENTREMI_CA;
			            				END IF;
		         				ELSE
								vp_gls_error := 'select a CO_CANCELADOS de facturas canceladas';
								SELECT 	COUNT(*)
								INTO 	RR_CUENTA
								FROM 	CO_CANCELADOS
		                  				WHERE 	COD_CLIENTE         		= rReg.COD_CLIENTE
		                    			    AND 	NUM_SECUENCI        		= rReg.NUM_SECUENCI_CA
		                    			    AND 	COD_TIPDOCUM        		= rReg.COD_TIPDOCUM_CA
		                    			    AND 	COD_VENDEDOR_AGENTE 	= rReg.COD_VEND_AGENTE_CA
		                    			    AND 	LETRA               			= rReg.LETRA_CA
		                    			    AND 	SEC_CUOTA           		= rReg.SEC_CUOTA_CA
		                    			    AND 	COD_CONCEPTO        		= rReg.COD_CONCEPTO_CA
		                    			    AND 	COLUMNA             		= rReg.COLUMNA_CA
		                    			    AND 	NUM_ABONADO         		= rReg.NUM_ABONADO_CA
		                    			    AND 	COD_CENTREMI        		= rReg.COD_CENTREMI_CA;

		            						IF (RR_CUENTA > 0) THEN
		                    					vp_saldo 		:= rReg.IMPORTE_CA;
				    						vp_monto 	:= 0;
		                    					vp_gls_error 	:= 'inicio de ciclo COCANCELADOS';

		                     					FOR rReg1 IN COCANCELADOS1(rReg.COD_CLIENTE,rReg.NUM_SECUENCI_CA,rReg.COD_TIPDOCUM_CA,rReg.COD_VEND_AGENTE_CA,rReg.LETRA_CA,rReg.SEC_CUOTA_CA,rReg.COD_CONCEPTO_CA,rReg.COLUMNA_CA,rReg.NUM_ABONADO_CA,rReg.COD_CENTREMI_CA) LOOP
		                     						vp_gls_error := 'insercion a CO_CARTERA de facturas canceladas';

			             						IF ((vp_saldo - rReg1.IMPORTE_HABER)>=0)  THEN
			             							vp_monto := 0;
			             						ELSE
			                							vp_monto := rReg1.IMPORTE_HABER - vp_saldo;
			             						END IF;

		                        						Co_InsertCo_Cartera(rReg1.COD_TIPDOCUM,rReg1.COD_CENTREMI,rReg1.NUM_SECUENCI,rReg1.COD_VENDEDOR_AGENTE,rReg1.LETRA,rReg1.COD_CONCEPTO,rReg1.COLUMNA,vp_monto,bOutRetorno);
		                        						IF (bOutRetorno = FALSE) THEN
		                           						sDesc_Sql:='Error en PL Co_InsertCo_Cartera 1';
		                           						RAISE ERROR_PROCESO;
		                        						END IF;

			                       					vp_gls_error := 'borrado de CO_CANCELADOS facturas canceladas';
			                       					Co_DeleteCo_Cancelados(rReg1.COD_TIPDOCUM,rReg1.COD_CENTREMI,rReg1.NUM_SECUENCI,rReg1.COD_VENDEDOR_AGENTE,rReg1.LETRA,rReg1.COD_CONCEPTO,rReg1.COLUMNA,bOutRetorno);
		                        						IF (bOutRetorno = FALSE) THEN
		                           						sDesc_Sql:='Error en PL Co_DeleteCo_Cancelados 1';
		                           						RAISE ERROR_PROCESO;
		                        						END IF;

			             						vp_saldo := vp_saldo - (rReg1.IMPORTE_HABER-vp_monto);
		                     					END LOOP;
		            						ELSE
		                   						UPDATE 	CO_CARTERA
		                   						SET		IMPORTE_HABER       		= IMPORTE_HABER - rReg.IMPORTE_CA
										WHERE 	COD_CLIENTE         		= rReg.COD_CLIENTE
		                      					    AND 	NUM_SECUENCI        		= rReg.NUM_SECUENCI_CA
		                      					    AND 	COD_TIPDOCUM        		= rReg.COD_TIPDOCUM_CA
		                      					    AND 	COD_VENDEDOR_AGENTE 	= rReg.COD_VEND_AGENTE_CA
		                      					    AND 	LETRA               			= rReg.LETRA_CA
		                      					    AND 	SEC_CUOTA           		= rReg.SEC_CUOTA_CA
										    AND 	COD_CONCEPTO        		= rReg.COD_CONCEPTO_CA
										    AND 	COLUMNA             		= rReg.COLUMNA_CA
										    AND 	NUM_ABONADO         		= rReg.NUM_ABONADO_CA
										    AND 	COD_CENTREMI        		= rReg.COD_CENTREMI_CA;
		            						END IF;
		         					END IF;
		      					END;
		     				END LOOP;
					END IF;

	     				vp_gls_error := 'actualizacion de CO_CONVENIOS';
	     				UPDATE CO_CONVENIOS
	     				SET		ESTADO_CONVENIO =3
					WHERE 	NUM_CONVENIO=TO_NUMBER(VP_NUM_CONVENIO);
				END IF;

         			vp_gls_error := 'CONTADOR CO_INTERESAPLI';
         			CONTADOR := -1;
         			OPEN CUENTA(iNum_secuenci,iCod_tipdocum,iCod_vendedor,sLetra,iCod_centremi,iCod_cliente);
         			LOOP
            				vp_gls_error := 'VA AL FETCH';
					FETCH CUENTA INTO CONTADOR;
             				EXIT WHEN CUENTA%NOTFOUND;
         			END LOOP;
         			CLOSE CUENTA;

         			vp_gls_error := 'SALE DE LOOP';
         			IF (CONTADOR>0) THEN
                 			vp_gls_error := 'borrado de GE_CARGOS';
                 			DELETE 	FROM GE_CARGOS
                  			WHERE 	NUM_CARGO IN	(SELECT	NUM_CARGO
											FROM 	CO_INTERESAPLI
											WHERE 	NUM_SECUENCI		= iNum_secuenci
											AND COD_TIPDOCUM       		= iCod_tipdocum
                            							AND COD_VENDEDOR_AGENTE	= iCod_vendedor
                            							AND LETRA              			= sLetra
                            							AND COD_CENTREMI       		= iCod_centremi
                            							AND COD_CLIENTE        		= iCod_cliente);

                			vp_gls_error := 'DEL. CO_INTERESAPLI ';
                 			DELETE 	CO_INTERESAPLI
                  			WHERE 	NUM_SECUENCI       		= iNum_secuenci
                    		    AND 	COD_TIPDOCUM       		= iCod_tipdocum
                    		    AND 	COD_VENDEDOR_AGENTE	= iCod_vendedor
                    		   AND 	LETRA              			= sLetra
                    		   AND 	COD_CENTREMI       		= iCod_centremi
                    		   AND 	COD_CLIENTE        		= iCod_cliente;
         			END IF;

         			vp_gls_error := 'CONTADOR CO_INTERCOBAPLI';
         			CONTADOR_COB := -1;
         			OPEN CUENTA_COB(iNum_secuenci,iCod_tipdocum,iCod_vendedor,sLetra,iCod_centremi,iCod_cliente);
         			LOOP
            				vp_gls_error := 'VA AL FETCH';
					FETCH CUENTA_COB INTO CONTADOR_COB;
             			EXIT WHEN CUENTA_COB%NOTFOUND;
         			END LOOP;
         			CLOSE CUENTA_COB;

         			vp_gls_error := 'SALE DE LOOP';
         			IF (CONTADOR_COB>0) THEN
                 			vp_gls_error := 'borrado de GE_CARGOS';
                 			DELETE 	FROM GE_CARGOS
                  			WHERE 	NUM_CARGO IN	( SELECT NUM_CARGO
											FROM 	CO_INTERCOBAPLI
											WHERE 	NUM_SECUENCI			= iNum_secuenci
											    AND 	COD_TIPDOCUM       		= iCod_tipdocum
                            							    AND 	COD_VENDEDOR_AGENTE	= iCod_vendedor
                            							    AND 	LETRA              			= sLetra
                            							    AND 	COD_CENTREMI       		= iCod_centremi
                            							    AND 	COD_CLIENTE        		= iCod_cliente);

                			vp_gls_error := 'DEL. CO_INTERCOBAPLI ';
                 			DELETE 	CO_INTERCOBAPLI
                  			WHERE 	NUM_SECUENCI       		= iNum_secuenci
                    		    AND 	COD_TIPDOCUM       		= iCod_tipdocum
                    		    AND 	COD_VENDEDOR_AGENTE	= iCod_vendedor
                    		    AND 	LETRA              			= sLetra
                    		    AND 	COD_CENTREMI       		= iCod_centremi
                    		    AND 	COD_CLIENTE        		= iCod_cliente;
         			END IF;

         			IF (CONTADOR>0 OR CONTADOR_COB>0) THEN
         				vp_gls_error := 'Contando Cargos a Cliente de GE_CARGOS';
					SELECT 	COUNT(COUNT(*))
					INTO 	CONTCARGOS
                   			FROM 	GE_CARGOS
                  			WHERE 	COD_CLIENTE = iCod_cliente
               			GROUP BY COD_CLIENTE;

					IF (CONTCARGOS=0) THEN
                    			vp_gls_error := 'UPD. GA_INFACCEL';
                    			UPDATE 	GA_INFACCEL
                    			SET		IND_CARGOS=0
                     			WHERE 	COD_CLIENTE = iCod_cliente;

                    			vp_gls_error := 'Actualizando GA_INFACBEEP.IND_CARGOS=0';
                    			UPDATE 	GA_INFACBEEP
                    			SET		IND_CARGOS=0
                     			WHERE 	COD_CLIENTE = iCod_cliente;
                 			END IF;
         			END IF;

         			DELETE 	FROM CO_PAGOSCONC
         			WHERE 	NUM_SECUENCI=iNum_secuenci;
      			END;
    		END LOOP;

		DELETE 	FROM CO_PAGOS
		WHERE 	NUM_COMPAGO 	=TO_NUMBER(VP_NUM_COMPAGO)
		AND 	PREF_PLAZA 		= VP_PREF_PLAZA;

		vp_OutRetorno := 0;
		vp_OutGlosa  := 'OK';
    		--COMMIT;
    		vp_gls_error := 'Select count(*) a la CO_MOVIMIENTOSCAJA';

		FOR REG IN COMOVIMIENTOSCAJA LOOP
			IF (vp_tipo_convenio = '1') THEN
				FOR rReg1 IN DOCUMENTOS1(REG.NUM_SECUMOV,TO_NUMBER(REG.NUM_CHEQUE)) LOOP
					vp_ruteo := 9;
	                      	vp_gls_error := 'borrado de CO_DET_DOCUMENTOS';
	                      	DELETE 	FROM CO_DET_DOCUMENTOS
	                      	WHERE 	NUM_DOCUMENTO 	= rReg1.NUM_DOCUMENTO
	                      	AND 	NUM_SECUENCI_DOC 	= rReg1.NUM_SECUENCI;

	                       	vp_ruteo 	:= 16;
	                       	vp_gls_error 	:= 'borrado de cheques de la CO_CARTERA';

	                       	DELETE 	FROM CO_CARTERA
	                       	WHERE 	NUM_FOLIO 		= rReg1.NUM_DOCUMENTO
	                       	AND 	COD_TIPDOCUM 	= 5
	                       	AND 	NUM_SECUENCI 	= rReg1.NUM_SECUENCI;
	               	END LOOP;

	            		vp_ruteo := 10;
				vp_gls_error := 'borrado de CO_DOCUMENTOS';

				DELETE 	FROM CO_DOCUMENTOS
				WHERE 	NUM_SECUMOV   		= REG.NUM_SECUMOV
		                 AND 	NUM_DOCUMENTO   	= TO_NUMBER(REG.NUM_CHEQUE)
		                 AND 	COD_TIPDOCUM    		= vcod_tipdocum_1;
                	ELSE
				FOR rReg1 IN DOCUMENTOS(REG.NUM_SECUMOV,TO_NUMBER(REG.NUM_CHEQUE),REG.CTA_CORRIENTE) LOOP
					vp_ruteo := 9;

					vp_gls_error := 'borrado de CO_DET_DOCUMENTOS';
					DELETE FROM CO_DET_DOCUMENTOS
					WHERE 	NUM_DOCUMENTO 	= rReg1.NUM_DOCUMENTO
					AND 	NUM_SECUENCI_DOC 	= rReg1.NUM_SECUENCI;

	                      	vp_ruteo 	:= 16;
	                      	vp_gls_error 	:= 'borrado de cheques de la CO_CARTERA';

	                      	DELETE FROM CO_CARTERA
	                       	WHERE 	NUM_FOLIO     		= rReg1.NUM_DOCUMENTO
	                       	    AND 	COD_TIPDOCUM  		= vcod_tipdocum_2
	                       	    AND 	NUM_SECUENCI 		= rReg1.NUM_SECUENCI;
	             	END LOOP;

				vp_ruteo := 10;
				vp_gls_error := 'borrado de CO_DOCUMENTOS';
	             	DELETE 	FROM CO_DOCUMENTOS
	              	WHERE 	NUM_SECUMOV   		= REG.NUM_SECUMOV
	                	    AND 	NUM_DOCUMENTO 	= TO_NUMBER(REG.NUM_CHEQUE)
	                	    AND 	CTA_CORRIENTE 		= REG.CTA_CORRIENTE;
               	END IF;

                	IF (vp_convenio=TRUE AND vp_tipo_convenio='1') THEN
                		FOR rReg1 IN DOCUMENTOS(REG.NUM_SECUMOV,TO_NUMBER(REG.NUM_CHEQUE),REG.CTA_CORRIENTE) LOOP
					vp_ruteo := 9;

					vp_gls_error := 'borrado de CO_DET_DOCUMENTOS';
					DELETE 	FROM CO_DET_DOCUMENTOS
					WHERE 	NUM_DOCUMENTO 	= rReg1.NUM_DOCUMENTO
					AND 	NUM_SECUENCI_DOC 	= rReg1.NUM_SECUENCI;

	                      	vp_ruteo 	:= 16;
	                      	vp_gls_error 	:= 'borrado de cheques de la CO_CARTERA';
	                      	DELETE 	FROM CO_CARTERA
	                       	WHERE 	NUM_FOLIO     	= rReg1.NUM_DOCUMENTO
	                       	    AND 	COD_TIPDOCUM  	= vcod_tipdocum_2
	                       	    AND 	NUM_SECUENCI	= rReg1.NUM_SECUENCI;
	               	END LOOP;

				vp_ruteo := 10;
				vp_gls_error := 'borrado de CO_DOCUMENTOS';
	             	DELETE 	FROM CO_DOCUMENTOS
	              	WHERE 	NUM_SECUMOV   	= REG.NUM_SECUMOV
	                	    AND 	NUM_DOCUMENTO	= TO_NUMBER(REG.NUM_CHEQUE)
	                	    AND 	CTA_CORRIENTE	= REG.CTA_CORRIENTE;
                	END IF;
		END LOOP;

		/*Modificacion para Cancelacion de Creditos */
	    	--Obtiene Número de Secuencia
		sDesc_Sql := 'Error en Obtencion de Secuencia de Cancelacion de Creditos. ';
		SELECT	ga_seq_transacabo.NEXTVAL
		INTO	TN_numtransaccion
		FROM	dual;

		--Ejecuta Pl de Cancelacion de Creditos
		sDesc_Sql := 'Error en llamada a Pl CO_CANCELACREDITOS_PR. ';
	    	CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(iCod_cliente, SYSDATE, TN_numtransaccion, GN_indcarrier, NULL, NULL, NULL, TN_retorno, TV_glosa);

		--Verifica si se produjo error en Cancelacion de Credito
		IF TN_retorno <> 0 THEN
			sDesc_Sql 	:= TV_glosa;
		   	vp_gls_error 	:= 'ERROR SQL EN Pl CO_CANCELACION_PG.CO_CANCELACREDITOS_PR ';
		   	vp_error 		:= sqlcode;

           	 	INSERT INTO	co_transac_error (
				nom_proceso, 	cod_retorno, 	fec_proceso, 	desc_sql, 	desc_cadena)
           	 	VALUES(
				sNom_proceso, 	vp_error, 	SYSDATE, 	sDesc_Sql, 	vp_gls_error);

		   	RAISE ERROR_PROCESO;
		END IF;
		/*Fin Modificacion para Cancelacion de Creditos */

		CLOSE DOCS;
	EXCEPTION
	WHEN ERROR_PROCESO THEN
		ROLLBACK;
		vp_OutRetorno := 1;
		vp_OutGlosa  := 'Error Sql : '||SQLERRM;
		vp_gls_error:='Error de Proceso';
		vp_error := SQLCODE;
             INSERT INTO CO_TRANSAC_ERROR (
             	NOM_PROCESO, 	COD_RETORNO, 	FEC_PROCESO, 	DESC_SQL, 	DESC_CADENA)
             VALUES (
             	sNom_proceso, 	vp_error, 		SYSDATE, 		sDesc_Sql, 	vp_OutGlosa);
             COMMIT;
	WHEN NO_DATA_FOUND THEN
             ROLLBACK;
		vp_OutRetorno 	:= 1;
		vp_OutGlosa  		:= 'Error Sql : '||SQLERRM;
		vp_gls_error 		:= 'No Hay Datos - ' || SQLERRM;
		vp_error 			:= SQLCODE;

             INSERT INTO CO_TRANSAC_ERROR (
             	NOM_PROCESO, 	COD_RETORNO, 	FEC_PROCESO, 	DESC_SQL, 	DESC_CADENA)
             VALUES (
             	sNom_proceso, 	vp_error, 		SYSDATE, 		sDesc_Sql, 	vp_gls_error);
             COMMIT;
        WHEN OTHERS THEN
        	--Inicio Soporte RyC CGLagos 05-12-2005 RA-200511180145
            	--DBMS_OUTPUT.PUT_LINE(SUBSTR('Error '||TO_CHAR(SQLCODE)||': '||SQLERRM, 1, 255));
            	--Fin Soporte RyC CGLagos 05-12-2005 RA-200511180145
             ROLLBACK;
		vp_OutRetorno := 1;
		vp_OutGlosa  := 'Error Sql : '||SQLERRM;
		vp_gls_error := 'Otros Errores - ' || SQLERRM;
		vp_error := SQLCODE;
             INSERT INTO CO_TRANSAC_ERROR (
             	NOM_PROCESO, 	COD_RETORNO, 	FEC_PROCESO, 	DESC_SQL, 	DESC_CADENA)
             VALUES (
             	sNom_proceso, 	vp_error, 		SYSDATE, 		sDesc_Sql, 	vp_gls_error);
		COMMIT;
END Co_Desaplicapago_Universal;
/
SHOW ERRORS
