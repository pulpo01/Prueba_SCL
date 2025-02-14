CREATE OR REPLACE PROCEDURE        Co_SelectCo_Cancelados(iCodTipDocum IN NUMBER, iCodCenEmi IN NUMBER, lNumSecu IN NUMBER, lCodAgente IN NUMBER,
		 					sLetra    IN VARCHAR2, iCod_Concepto IN NUMBER, iColumna IN NUMBER, vpOutRetorna OUT NUMBER)  IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
dImporteDebe	CO_CANCELADOS.IMPORTE_DEBE%TYPE;
BEGIN
	sNom_proceso:='Co_SelectCo_Cancelados';
	sDesc_Sql   :='SELECT IMPORTE_DEBE FROM CO_CANCELADOS';
    SELECT IMPORTE_DEBE
    INTO   dImporteDebe
    FROM   CO_CANCELADOS
    WHERE  COD_TIPDOCUM    = iCodTipDocum
    AND    COD_CENTREMI    = iCodCenEmi
    AND    NUM_SECUENCI    = lNumSecu
    AND    COD_VENDEDOR_AGENTE = lCodAgente
    AND    LETRA           = sLetra
    AND    COD_CONCEPTO    = iCod_Concepto
    AND    COLUMNA         = iColumna;
    vpOutRetorna:=dImporteDebe;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
		     vpOutRetorna:= -99999000;
        WHEN OTHERS THEN
			 vp_gls_error := 'ERROR FATAL : ' || SQLERRM;
		   	 vp_error := SQLCODE;
           	 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           	 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
			 vpOutRetorna:= -99999999;
END Co_SelectCo_Cancelados;
/
SHOW ERRORS
