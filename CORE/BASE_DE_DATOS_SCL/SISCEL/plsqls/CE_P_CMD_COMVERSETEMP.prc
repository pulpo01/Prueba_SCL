CREATE OR REPLACE PROCEDURE        CE_P_CMD_COMVERSETEMP(
pcomando    IN VARCHAR2,
pcelular    IN NUMBER,
pempresa    IN VARCHAR2,
pserie      IN VARCHAR2,
ppin        IN VARCHAR2,
pmonto      IN NUMBER,
presul      IN OUT VARCHAR2,
pusuario    IN VARCHAR2,
pservicio   IN VARCHAR2,
plote       IN NUMBER
)IS
/******************************************************************************
   NOMBRE:     CMD_COMVERSE
   OBJETIVO:   INSERTAR EN ICC_MOVPIN PARA EJECUTAR COMANDO PARA ACTIVAR ESTADO DE SERIES EN COMVERSE
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        27/09/2000  CRISTIAN RETAMAL M.
******************************************************************************/
pCodEstado VARCHAR2(2);
BEGIN
	presul:='OK';
	IF UPPER(pcomando)='BAJAS' OR UPPER(pcomando)='ACTSE' THEN
	   IF pserie IS NULL OR pusuario IS NULL OR plote IS NULL then
	   	  presul:='<Error' || pcomando ||'> Debe ingresar serie y usuario';
	   END IF;
	END IF;
    IF UPPER(pcomando)='CARGA' THEN
	   IF pcelular=0 OR pserie IS NULL OR ppin IS NULL OR pempresa IS NULL OR pusuario IS NULL then
	   	  presul:='<Error Carga> Debe ingresar celular, pin, serie, empresa y usuario';
	   END IF;
	END IF;
    IF UPPER(pcomando)='AUBAL' THEN
	   IF pcelular=0 OR pmonto IS NULL OR pusuario IS NULL then
	   	  presul:='<Error AUBAL> Debe ingresar celular, monto y usuario';
	   END IF;
	END IF;
	IF UPPER(pcomando)='RDIST' THEN
	   IF pserie IS NULL OR pempresa IS NULL OR pusuario IS NULL then
	   	  presul:='<Error Baja> Debe ingresar serie, empresa y usuario';
	   END IF;
	END IF;
IF presul='OK' THEN
   SELECT VAL_CARACTER
   INTO   pCodEstado
   FROM   CED_PARAMETROS
   WHERE  COD_PARAMETRO=35;
    INSERT INTO CET_ICCMOVPIN(
	DES_COMANDO,
	NUM_CELULAR,
	COD_EMPRESA,
	NUM_SERIE,
	NUM_PIN,
	MONTO,
	COD_USUARIO,
	COD_SERVICIO,
	NUM_LOTE,
	COD_ESTADO,
	FEC_INGRESO)
	VALUES(
	pcomando,
	pcelular,
	pempresa,
	pserie,
	ppin,
	pmonto,
	pusuario,
	pservicio,
	plote,
	pCodEstado,
	SYSDATE);
COMMIT;
END IF;
	EXCEPTION
	WHEN OTHERS THEN
   	    presul := SQLERRM;
	 	ROLLBACK;
END CE_P_CMD_COMVERSETEMP;
/
SHOW ERRORS
