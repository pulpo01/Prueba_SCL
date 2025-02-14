CREATE OR REPLACE PROCEDURE        Co_UpdateCo_Cartera(iCodTipDocum IN NUMBER, iCodCenEmi IN NUMBER, lNumSecu IN NUMBER, lCodAgente IN NUMBER,
		 					sLetra IN VARCHAR2, iCod_Concepto IN NUMBER, iColumna IN NUMBER, dImp_conce IN NUMBER, vpOutRetorna OUT BOOLEAN) IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
dImporteHaber	CO_CARTERA.IMPORTE_HABER%TYPE;
BEGIN
	vpOutRetorna:=TRUE;
	sNom_proceso:='Co_UpdateCo_Cartera';
	sDesc_Sql   :='SELECT IMPORTE_HABER FROM CO_CARTERA';
    SELECT IMPORTE_HABER
    INTO   dImporteHaber
    FROM   CO_CARTERA
    WHERE  COD_TIPDOCUM    = iCodTipDocum
    AND    COD_CENTREMI    = iCodCenEmi
    AND    NUM_SECUENCI    = lNumSecu
    AND    COD_VENDEDOR_AGENTE = lCodAgente
    AND    LETRA           = sLetra
    AND    COD_CONCEPTO    = iCod_Concepto
    AND    COLUMNA         = iColumna;
	dImporteHaber := dImporteHaber - dImp_conce;
	sDesc_Sql   :='UPDATE CO_CARTERA SET';
    UPDATE CO_CARTERA SET
           IMPORTE_HABER = dImporteHaber
    WHERE  COD_TIPDOCUM    = iCodTipDocum
    AND    COD_CENTREMI    = iCodCenEmi
    AND    NUM_SECUENCI    = lNumSecu
    AND    COD_VENDEDOR_AGENTE = lCodAgente
    AND    LETRA           = sLetra
    AND    COD_CONCEPTO    = iCod_Concepto
    AND    COLUMNA         = iColumna;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
			 vpOutRetorna:= FALSE;
		   	 vp_gls_error := 'NO EXISTEN DATOS : ' || SQLERRM;
		   	 vp_error := SQLCODE;
           	 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           	 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
        WHEN OTHERS THEN
             vpOutRetorna:= FALSE;
		   	 vp_gls_error := 'ERROR FATAL SQL : ' || SQLERRM;
		   	 vp_error := SQLCODE;
           	 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           	 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
END Co_UpdateCo_Cartera;
/
SHOW ERRORS
