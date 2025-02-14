CREATE OR REPLACE PROCEDURE CO_CASTIGOS_EXTERNOS (vp_Cod_cliente   		IN NUMBER	,	vp_Num_Folio     IN NUMBER   ,
												  vp_Num_Prefijo_Plaza 	IN VARCHAR2 ,	vp_Fec_Pago		 IN VARCHAR2 ,
												  vp_Imp_Pago     		IN NUMBER   ,	vp_Ind_Pago		 IN NUMBER   ,
												  vp_Sec_Cuota          IN NUMBER   ,
												  vp_OutRetorno    		OUT NUMBER  ) IS

iCount              NUMBER(2);
iDecimal            NUMBER(2);
v_sqlcode           VARCHAR2(10);
v_sqlerrm           VARCHAR2(255);
vp_Gls_Error        VARCHAR2(255);

sNom_proceso		CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
iColumna            CO_CARTERA.COLUMNA%TYPE;
dImporte_haber      CO_CARTERA.IMPORTE_HABER%TYPE;
dImporte_debe       CO_CARTERA.IMPORTE_DEBE%TYPE;
dTotImp_Pago		CO_CARTERA.IMPORTE_DEBE%TYPE;
dPago               CO_CARTERA.IMPORTE_DEBE%TYPE;
TN_conceptocastigo  CO_CARTERA.COD_CONCEPTO%TYPE := 6; --Concepto de Castigos Contables
TN_indfacturado		CO_CARTERA.IND_FACTURADO%TYPE := 1;

/*Soporte 30/09/2003 Se cambia COD_TIPDOCUM */
CURSOR CUR_CASTCONT IS
SELECT COLUMNA,IMPORTE_DEBE,IMPORTE_HABER
FROM   CO_CARTERA
WHERE  COD_CLIENTE   = vp_Cod_cliente
AND    COD_CONCEPTO  = TN_conceptocastigo
AND    NUM_FOLIO     = vp_Num_Folio
AND    PREF_PLAZA 	 = vp_Num_Prefijo_Plaza
AND    IND_FACTURADO = TN_indfacturado
AND    (SEC_CUOTA    = vp_Sec_Cuota OR SEC_CUOTA IS NULL)
ORDER BY SEC_CUOTA,FEC_VENCIMIE,COLUMNA;


ERROR_PROCESO EXCEPTION ;
/****** Inicio  ******/
BEGIN
    vp_Gls_Error := '';
    sNom_proceso :='CO_CASTIGOS_EXTERNOS';

    vp_Gls_Error := 'SELECT COUNT(1) CO_CARTERA.';
    SELECT COUNT(1)
    INTO   iCount
    FROM (
    SELECT 1
    FROM   CO_CARTERA
    WHERE  COD_CLIENTE  = vp_Cod_cliente
    AND    COD_CONCEPTO = TN_conceptocastigo
    AND    NUM_FOLIO    = vp_Num_Folio
    AND    PREF_PLAZA 	= vp_Num_Prefijo_Plaza
    AND    (SEC_CUOTA   = vp_Sec_Cuota OR SEC_CUOTA IS NULL)
    AND ROWNUM 			= 1);

    IF iCount != 0 THEN

        SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
        INTO   iDecimal
        FROM   DUAL;

        IF vp_Ind_Pago = 0 THEN

                vp_Gls_Error := 'INSERT INTO CO_CANCELADOS.  CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                INSERT INTO CO_CANCELADOS (
                        COD_CLIENTE      ,  COD_TIPDOCUM          ,  COD_CENTREMI      ,
                        NUM_SECUENCI     ,  COD_VENDEDOR_AGENTE   ,  LETRA             ,
                        COD_CONCEPTO     ,  COLUMNA               ,  COD_PRODUCTO      ,
                        IMPORTE_HABER    ,  NUM_TRANSACCION       ,  IMPORTE_DEBE      ,
                        IND_CONTADO      ,  IND_FACTURADO         ,  FEC_EFECTIVIDAD   ,
                        FEC_CANCELACION  ,  IND_PORTADOR          ,  FEC_PAGO          ,
                        FEC_CADUCIDA     ,  FEC_ANTIGUEDAD        ,  FEC_VENCIMIE      ,
                        NUM_CUOTA        ,  SEC_CUOTA             ,  NUM_VENTA         ,
                        NUM_ABONADO      ,  NUM_FOLIO             ,  PREF_PLAZA 	   ,
						NUM_FOLIOCTC	 ,	COD_OPERADORA_SCL	  ,	 COD_PLAZA		   )
                SELECT  COD_CLIENTE      ,  COD_TIPDOCUM          ,  COD_CENTREMI      ,
                        NUM_SECUENCI     ,  COD_VENDEDOR_AGENTE   ,  LETRA             ,
                        COD_CONCEPTO     ,  COLUMNA               ,  COD_PRODUCTO      ,
                        IMPORTE_HABER    ,  0                     ,  IMPORTE_HABER     ,
                        IND_CONTADO      ,  IND_FACTURADO         ,  FEC_EFECTIVIDAD   ,
                        TO_DATE(vp_Fec_Pago,'DD-MM-YYYY HH24:MI:SS') , 0 , SYSDATE     ,
                        FEC_CADUCIDA     ,  FEC_ANTIGUEDAD        ,  FEC_VENCIMIE      ,
                        NUM_CUOTA        ,  SEC_CUOTA             ,  NUM_VENTA         ,
                        NUM_ABONADO      ,  NUM_FOLIO             ,  PREF_PLAZA 	   ,
						NUM_FOLIOCTC	 ,	COD_OPERADORA_SCL	  ,	 COD_PLAZA
                FROM    CO_CARTERA
                WHERE   COD_CLIENTE   = vp_Cod_cliente
                AND     COD_CONCEPTO  = TN_conceptocastigo
                AND     NUM_FOLIO     = vp_Num_Folio
                AND     PREF_PLAZA 	  = vp_Num_Prefijo_Plaza
		AND    (SEC_CUOTA     = vp_Sec_Cuota OR SEC_CUOTA IS NULL);

                vp_Gls_Error := 'DELETE FROM CO_CARTERA. CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                DELETE FROM CO_CARTERA
                WHERE  COD_CLIENTE    = vp_Cod_cliente
                AND    COD_CONCEPTO   = TN_conceptocastigo
                AND    NUM_FOLIO      = vp_Num_Folio
                AND    PREF_PLAZA 	  = vp_Num_Prefijo_Plaza
                AND    (SEC_CUOTA     = vp_Sec_Cuota OR SEC_CUOTA IS NULL);

        ELSE

            dTotImp_Pago:=vp_Imp_Pago;
            OPEN CUR_CASTCONT;
            LOOP
                BEGIN
                    vp_Gls_Error := 'FETCH CUR_CASTCONT. CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                    FETCH CUR_CASTCONT INTO iColumna, dImporte_debe , dImporte_haber ;
                    EXIT WHEN CUR_CASTCONT%NOTFOUND;

                    IF (dTotImp_Pago > 0) AND (dTotImp_Pago < dImporte_haber) THEN

					    --Soporte
					   	IF dTotImp_Pago > (dImporte_haber - dImporte_debe) THEN
						      dPago := dImporte_haber - dImporte_debe;
						ELSE
						      dPago := dTotImp_Pago;
						END IF;
						--Fin Soporte

                        vp_Gls_Error := 'UPDATE CO_CARTERA SET. CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                        UPDATE CO_CARTERA SET
                               IMPORTE_DEBE = IMPORTE_DEBE + GE_PAC_GENERAL.REDONDEA(dPago, iDecimal, 0)  --dTotImp_Pago
                        WHERE  COD_CLIENTE   = vp_Cod_cliente
                        AND    COD_CONCEPTO  = TN_conceptocastigo
                        AND    COLUMNA       = iColumna
                        AND    NUM_FOLIO     = vp_Num_Folio
                        AND    PREF_PLAZA	 = vp_Num_Prefijo_Plaza
                        AND    (SEC_CUOTA = vp_Sec_Cuota OR SEC_CUOTA IS NULL);

                        dImporte_debe:=dImporte_debe + dPago;
                        dTotImp_Pago:= dTotImp_Pago - dPago;

                    ELSIF (dTotImp_Pago >= dImporte_haber) THEN

                        dTotImp_Pago := dTotImp_Pago - (dImporte_haber - dImporte_debe);
                        dImporte_debe := dImporte_haber;

                    END IF;


                    IF dImporte_debe = dImporte_haber THEN
                        vp_Gls_Error := 'INSERT INTO CO_CANCELADOS (Parc).  CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                        INSERT INTO CO_CANCELADOS (
                                COD_CLIENTE      ,  COD_TIPDOCUM          ,  COD_CENTREMI      ,
                                NUM_SECUENCI     ,  COD_VENDEDOR_AGENTE   ,  LETRA             ,
                                COD_CONCEPTO     ,  COLUMNA               ,  COD_PRODUCTO      ,
                                IMPORTE_HABER    ,  NUM_TRANSACCION       ,  IMPORTE_DEBE      ,
                                IND_CONTADO      ,  IND_FACTURADO         ,  FEC_EFECTIVIDAD   ,
                                FEC_CANCELACION  ,  IND_PORTADOR          ,  FEC_PAGO          ,
                                FEC_CADUCIDA     ,  FEC_ANTIGUEDAD        ,  FEC_VENCIMIE      ,
                                NUM_CUOTA        ,  SEC_CUOTA             ,  NUM_VENTA         ,
                                NUM_ABONADO      ,  NUM_FOLIO             ,  PREF_PLAZA 	   ,
								NUM_FOLIOCTC	 ,	COD_OPERADORA_SCL	  ,	 COD_PLAZA		   )
                        SELECT  COD_CLIENTE      ,  COD_TIPDOCUM          ,  COD_CENTREMI      ,
                                NUM_SECUENCI     ,  COD_VENDEDOR_AGENTE   ,  LETRA             ,
                                COD_CONCEPTO     ,  COLUMNA               ,  COD_PRODUCTO      ,
                                IMPORTE_HABER    ,  0                     ,  IMPORTE_HABER     ,
                                IND_CONTADO      ,  IND_FACTURADO         ,  FEC_EFECTIVIDAD   ,
                                TO_DATE(vp_Fec_Pago,'DD-MM-YYYY HH24:MI:SS') , 0 , SYSDATE     ,
                                FEC_CADUCIDA     ,  FEC_ANTIGUEDAD        ,  FEC_VENCIMIE      ,
                                NUM_CUOTA        ,  SEC_CUOTA             ,  NUM_VENTA         ,
                                NUM_ABONADO      ,  NUM_FOLIO             ,  PREF_PLAZA 	   ,
								NUM_FOLIOCTC	 ,	COD_OPERADORA_SCL	  ,	 COD_PLAZA
                        FROM    CO_CARTERA
                        WHERE   COD_CLIENTE   = vp_Cod_cliente
                        AND     COD_CONCEPTO  = TN_conceptocastigo
                        AND     COLUMNA       = iColumna
                        AND     NUM_FOLIO     = vp_Num_Folio
                        AND     PREF_PLAZA 	  = vp_Num_Prefijo_Plaza
                        AND    (SEC_CUOTA = vp_Sec_Cuota OR SEC_CUOTA IS NULL);

                        vp_Gls_Error := 'DELETE FROM CO_CARTERA (Parc). CLIENTE : '||vp_Cod_cliente||' FOLIO : '||vp_Num_Folio||' PREFIJO PLAZA : '||vp_Num_Prefijo_Plaza;
                        DELETE FROM CO_CARTERA
                        WHERE  COD_CLIENTE    = vp_Cod_cliente
                        AND    COD_CONCEPTO   = TN_conceptocastigo
                        AND    COLUMNA        = iColumna
                        AND    NUM_FOLIO      = vp_Num_Folio
                        AND    PREF_PLAZA 	  = vp_Num_Prefijo_Plaza
                        AND    (SEC_CUOTA = vp_Sec_Cuota OR SEC_CUOTA IS NULL);

                    END IF;

                END;
            END LOOP;
            CLOSE CUR_CASTCONT;

        END IF;
    END IF;

    vp_OutRetorno:=0;

EXCEPTION
    WHEN ERROR_PROCESO THEN
         ROLLBACK;
    	 vp_OutRetorno := 1;
         v_sqlerrm := 'Error Sql : '||sqlerrm;
         v_sqlcode := SQLCODE;
         INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
         VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
    	 COMMIT;
    WHEN OTHERS THEN
         ROLLBACK;
    	 vp_OutRetorno := 1;
         v_sqlerrm := 'Error Sql : '||sqlerrm;
         v_sqlcode := SQLCODE;
         INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
         VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm);
    	 COMMIT;
END CO_CASTIGOS_EXTERNOS;
/
SHOW ERRORS
