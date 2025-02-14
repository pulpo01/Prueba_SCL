CREATE OR REPLACE PROCEDURE        Co_DeleteCo_Cancelados(iCodTipDocum IN NUMBER, iCodCenEmi IN NUMBER, lNumSecu IN NUMBER, lCodAgente IN NUMBER,
		 					sLetra    IN VARCHAR2, iCod_Concepto IN NUMBER, iColumna IN NUMBER, vpOutRetorna OUT BOOLEAN) IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
BEGIN
    vpOutRetorna:=TRUE;
	sNom_proceso:='Co_DeleteCo_Cancelados';
	sDesc_Sql   :='DELETE FROM CO_CANCELADOS';
    DELETE FROM CO_CANCELADOS
    WHERE  COD_TIPDOCUM    = iCodTipDocum
    AND    COD_CENTREMI    = iCodCenEmi
    AND    NUM_SECUENCI    = lNumSecu
    AND    COD_VENDEDOR_AGENTE = lCodAgente
    AND    LETRA           = sLetra
    AND    COD_CONCEPTO    = iCod_Concepto
    AND    COLUMNA         = iColumna;
    EXCEPTION
        WHEN OTHERS THEN
             vpOutRetorna:= FALSE;
		   	 vp_gls_error := 'ERROR SQL EN DELETE : ' || SQLERRM;
		   	 vp_error := SQLCODE;
           	 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           	 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
END Co_DeleteCo_Cancelados;
/
SHOW ERRORS
