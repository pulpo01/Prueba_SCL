CREATE OR REPLACE PROCEDURE        Co_DeleteCo_PagosConc(iCodTipDocum IN NUMBER, iCodCenEmi IN NUMBER, lNumSecu IN NUMBER,
		 					   lCodAgente IN NUMBER, sLetra IN VARCHAR2, vpOutRetorna OUT BOOLEAN) IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
BEGIN
    vpOutRetorna:=TRUE;
	sNom_proceso:='Co_DeleteCo_PagosConc';
	sDesc_Sql   :='DELETE FROM CO_PAGOSCONC';
    DELETE FROM CO_PAGOSCONC
    WHERE  COD_TIPDOCUM    = iCodTipDocum
    AND    COD_CENTREMI    = iCodCenEmi
    AND    NUM_SECUENCI    = lNumSecu
    AND    COD_VENDEDOR_AGENTE = lCodAgente
    AND    LETRA           = sLetra;
    EXCEPTION
        WHEN OTHERS THEN
             vpOutRetorna:= FALSE;
		   	 vp_gls_error := 'ERROR SQL EN DELETE : ' || SQLERRM;
		   	 vp_error := SQLCODE;
           	 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
           	 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
END Co_DeleteCo_PagosConc;
/
SHOW ERRORS
