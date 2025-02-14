CREATE OR REPLACE PROCEDURE PV_ABONO_LC_PR(pSEQ      IN NUMBER,
	   	  		  						   pABONADO  IN NUMBER,
	   	  		  				  		   pCLIENTE	 IN NUMBER,
	   	  		  				  		   pABONO    IN NUMBER

										   )

IS

  sCod_Ciclo	   FA_CICLFACT.COD_CICLFACT%TYPE;
  sSeq			   TOL_PAGO_LIMITE_TO.NUM_SECUENCI%TYPE;
  dFecha		   TOL_PAGO_LIMITE_TO.FEC_EFECTIVIDAD%TYPE;
  sOPER_LOCAL	   VARCHAR2(4);

  ERROR_PROCESO EXCEPTION;

  nNumError		   NUMBER(2);
  pMsgError		   VARCHAR2(200);
  sMsgError		   VARCHAR2(200);
  sCOD_SQLCODE     VARCHAR2(30);
  sCOD_SQLERRM	   VARCHAR2(200);
  sERROR           VARCHAR2(2);


BEGIN

	sCOD_SQLERRM := '';

	nNumError:=4;
	sMsgError:='Error, Obtener Fecha Actual';
	SELECT SYSDATE
	INTO dFECHA
	FROM DUAL;

	nNumError:=4;
	sMsgError:='Error, Obtener Codigo Ciclo';
    SELECT COD_CICLO
	INTO sCod_Ciclo
	FROM GE_CLIENTES
	WHERE COD_CLIENTE = pCLIENTE;

	nNumError:=4;
	sMsgError:='Error, Obtener Operadora';
	SELECT FN_OBTIENE_OPERCLIENTE(pCLIENTE)
	INTO sOPER_LOCAL
	FROM DUAL;

	nNumError:=4;
	sMsgError:='Error, Obtener Secuencia';
	BEGIN
		SELECT MAX(NUM_SECUENCI)+1
		INTO sSeq
		FROM TOL_PAGO_LIMITE_TO;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     sSeq := 1;
	END;

	IF sSeq IS NULL THEN
	   sSeq := 1;
	END IF;

	nNumError:=4;
	sMsgError:='Error, Insert TOL_PAGO_LIMITE_TO';
	INSERT INTO TOL_PAGO_LIMITE_TO(COD_TIPDOCUM,
		   						   NUM_SECUENCI,
								   COD_CLIENTE,
								   IMP_PAGO,
								   FEC_EFECTIVIDAD,
								   FEC_VALOR,
								   NOM_USUARORA,
								   DES_PAGO,
								   NUM_COMPAGO,
								   PREF_PLAZA,
								   COD_CICLO,
								   COD_OPERADORA,
								   COD_ABONADO,
								   COD_MOVIMIENTO)
							VALUES(00,
								   sSeq,
								   pCLIENTE,
								   pABONO,
								   dFecha,
								   dFecha,
								   USER,
								   'ABONO LIMITE DE CONSUMO',
								   0,
								   '',
								   sCod_Ciclo,
								   sOPER_LOCAL,
								   pABONADO,
								   1);

	nNumError:=0;
	sMsgError:='Proceso Exitoso';

  	RAISE ERROR_PROCESO;

EXCEPTION

    WHEN ERROR_PROCESO THEN
			sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);
			pMsgError := sMsgError || ', ' || sCOD_SQLERRM;

			INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
							   VALUES (pSEQ,nNumError,pMsgError);
	WHEN OTHERS THEN
			sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);
			pMsgError := sMsgError || ', ' || sCOD_SQLERRM;

			INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
							   VALUES (pSEQ,nNumError,pMsgError);


END;
/
SHOW ERRORS
