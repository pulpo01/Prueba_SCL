CREATE OR REPLACE PROCEDURE CO_DESPAGCONSUMO (vp_Cod_Oficina IN VARCHAR2,  vp_Cod_Caja    IN NUMBER, vp_Importe IN NUMBER,
                                                                                          vp_Cod_Moneda  IN VARCHAR2,  vp_Num_Compago IN NUMBER, vp_Pref_Plaza IN VARCHAR2,
                                                                                          vp_TipoPago IN NUMBER, vp_Num_ejercicio IN VARCHAR2, vpOutRetorna   OUT BOOLEAN) IS
vp_error        NUMBER(5);
vp_gls_error    VARCHAR2(255);
sNom_proceso    VARCHAR2(50);
sDesc_Sql       VARCHAR2(150);
iReg_Cajas      NUMBER(4);
iNum_SecuMov    CO_MOVIMIENTOSCAJA.NUM_SECUMOV%TYPE;
sOperadora		CO_MOVIMIENTOSCAJA.COD_OPERADORA_SCL%TYPE;
sPlaza			CO_MOVIMIENTOSCAJA.COD_PLAZA%TYPE;
ERROR_PROC EXCEPTION;
BEGIN
        vpOutRetorna:= TRUE;
        sNom_proceso:='CO_DESPAGCONSUMO';
        vp_error :=-1;

    /*Se obtiene la Operadora y Plaza del Movimiento que se va a desaplicar*/
	sDesc_Sql := 'SELECT NUM_SECUMOV, COD_OPERADORA_SCL, COD_PLAZA FROM CO_MOVIMIENTOSCAJA';
    SELECT NUM_SECUMOV, COD_OPERADORA_SCL, COD_PLAZA
	INTO   iNum_SecuMov, sOperadora, sPlaza
    FROM   CO_MOVIMIENTOSCAJA
	WHERE  COD_OFICINA = vp_Cod_Oficina
	AND    COD_CAJA = vp_Cod_Caja
	AND    COD_MONEDA = vp_Cod_Moneda
	AND	   NUM_COMPAGO = vp_Num_Compago
    AND    PREF_PLAZA = vp_Pref_Plaza;

    IF vp_TipoPago = 1 THEN
           sDesc_Sql := 'SELECT NVL(COUNT (*),0) FROM CO_EFECTIVO_CAJAS2';
           SELECT NVL(COUNT (*),0)
           INTO   iReg_Cajas
		   FROM   CO_EFECTIVO_CAJAS
       	   WHERE  COD_OFICINA =  vp_Cod_Oficina
           AND    COD_CAJA    =  vp_Cod_Caja
           AND    NUM_EJERCICIO = vp_Num_ejercicio
		   AND 	  COD_OPERADORA_SCL = sOperadora
		   AND	  COD_PLAZA = sPlaza
           AND    COD_MONEDA  =  vp_Cod_Moneda;

           IF iReg_Cajas > 0 THEN
              BEGIN
            sDesc_Sql := 'UPDATE CO_EFECTIVO_CAJAS SET';
            UPDATE CO_EFECTIVO_CAJAS SET
                  EFEC_CAMBIO = EFEC_CAMBIO - vp_Importe
            WHERE  COD_OFICINA = vp_Cod_Oficina
            AND    COD_CAJA    = vp_Cod_Caja
            AND    NUM_EJERCICIO = vp_Num_ejercicio
		    AND	   COD_OPERADORA_SCL = sOperadora
		    AND	   COD_PLAZA = sPlaza
            AND    COD_MONEDA  = vp_Cod_Moneda;
              END;
           ELSE
              BEGIN
            sDesc_Sql := 'INSERT INTO CO_EFECTIVO_CAJAS';
            INSERT INTO CO_EFECTIVO_CAJAS
                   (COD_OFICINA    , COD_CAJA   , NUM_EJERCICIO   , COD_MONEDA    , EFEC_EGRESO, EFEC_CAMBIO, COD_OPERADORA_SCL, COD_PLAZA)
            VALUES (vp_Cod_Oficina , vp_Cod_Caja, vp_Num_ejercicio, vp_Cod_Moneda , 0          , vp_Importe	, sOperadora	   , sPlaza);
              END;
       END IF;
    END IF;

    sDesc_Sql := 'UPDATE CO_MOVIMIENTOSCAJA SET';
    UPDATE CO_MOVIMIENTOSCAJA SET
           IND_ERRONEO = 1,
           TIP_MOVCAJA = 17
    WHERE  COD_OFICINA = vp_Cod_Oficina
    AND    COD_CAJA    = vp_Cod_Caja
    AND    NUM_SECUMOV = iNum_SecuMov
    AND    IND_ERRONEO = 0;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
                         ROLLBACK;
                         vp_gls_error := 'NO EXISTEN DATOS : ' || SQLERRM;
                         vp_error := SQLCODE;
                 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
                 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                 COMMIT;
        WHEN OTHERS THEN
             ROLLBACK;
             vpOutRetorna:= FALSE;
                         vp_gls_error := 'ERROR SQL : ' || SQLERRM;
                         vp_error := SQLCODE;
                 INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO , DESC_SQL , DESC_CADENA)
                 VALUES (sNom_proceso, vp_error, SYSDATE, sDesc_Sql, vp_gls_error);
                 COMMIT;
END CO_DESPAGCONSUMO;
/
SHOW ERRORS
