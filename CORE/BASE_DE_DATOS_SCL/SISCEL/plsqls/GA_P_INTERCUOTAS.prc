CREATE OR REPLACE PROCEDURE        GA_P_INTERCUOTAS(VP_TRANSAC IN  VARCHAR2, VP_CLIENTE  IN VARCHAR2, VP_ABONADO  IN  VARCHAR2,
				VP_CLIENTEN VARCHAR2, VP_ABONADON IN VARCHAR2) IS
    CURSOR C_CAB IS
        SELECT SEQ_CUOTAS, COD_CLIENTE, COD_CONCEPTO, IMP_TOTAL,
            COD_MONEDA, IND_PAGADA, COD_PRODUCTO, NUM_VENTA, NUM_TRANSACCION,
            NUM_CUOTAS, NUM_ABONADO, COD_MODVENTA, NUM_SERIELE, COD_CUOTA,
            NUM_PAGARE
        FROM FA_CABCUOTAS
        WHERE COD_CLIENTE =  TO_NUMBER(VP_CLIENTE)  AND
            NUM_ABONADO =  TO_NUMBER(VP_ABONADO)  AND
            IND_PAGADA = 0 ;
         R_CAB  C_CAB%ROWTYPE;
         R_CAB2 C_CAB%ROWTYPE;
	 V_ERROR NUMBER(1) := 0;
	 ERROR_PROCESO EXCEPTION;
 BEGIN
    OPEN C_CAB; --Abrimos Cursor
    Loop --Recorremos todas las cuotas del abonado y insertamos al nuevo
        FETCH C_CAB INTO R_CAB;
            EXIT WHEN C_CAB%NOTFOUND;
        R_CAB2 := R_CAB; --igualamos los cursores y asociamos el nuevo abonado y cliente
        R_CAB2.COD_CLIENTE :=  TO_NUMBER(VP_CLIENTEN) ;
        R_CAB2.NUM_ABONADO :=  TO_NUMBER(VP_ABONADON) ;
        SELECT FA_SEQ_CUOTAS.NEXTVAL INTO R_CAB2.SEQ_CUOTAS FROM DUAL; --pillamos secuencia de cuotas
            INSERT INTO FA_CABCUOTAS (SEQ_CUOTAS, COD_CLIENTE, COD_CONCEPTO,
        IMP_TOTAL, COD_MONEDA, IND_PAGADA, COD_PRODUCTO, NUM_VENTA,
        NUM_TRANSACCION, NUM_CUOTAS, NUM_ABONADO, COD_MODVENTA,
        NUM_SERIELE, COD_CUOTA, NUM_PAGARE)
        VALUES (R_CAB2.SEQ_CUOTAS,
            R_CAB2.COD_CLIENTE,
            R_CAB2.COD_CONCEPTO,
            R_CAB2.IMP_TOTAL,
            R_CAB2.COD_MONEDA,
            R_CAB2.IND_PAGADA,
            R_CAB2.COD_PRODUCTO,
            R_CAB2.NUM_VENTA,
            R_CAB2.NUM_TRANSACCION,
            R_CAB2.NUM_CUOTAS,
            R_CAB2.NUM_ABONADO,
            R_CAB2.COD_MODVENTA,
            R_CAB2.NUM_SERIELE,
            R_CAB2.COD_CUOTA,
            R_CAB2.NUM_PAGARE);
        INSERT INTO FA_CUOTAS (SEQ_CUOTAS, ORD_CUOTA, FEC_EMISION,
        IMP_CUOTA, IND_FACTURADO, IND_PAGADO)
            SELECT R_CAB2.SEQ_CUOTAS, ORD_CUOTA, FEC_EMISION, IMP_CUOTA,
        IND_FACTURADO, IND_PAGADO FROM FA_CUOTAS WHERE
        SEQ_CUOTAS = R_CAB.SEQ_CUOTAS;
    END LOOP;
	RAISE ERROR_PROCESO;
 EXCEPTION
	WHEN ERROR_PROCESO THEN
		INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		VALUES (VP_TRANSAC, V_ERROR, NULL);
	WHEN OTHERS THEN
		V_ERROR := 4;
 END;
/
SHOW ERRORS
