CREATE OR REPLACE procedure PV_INS_RECARPREPAGO_QUIOSCO_PR (SPARAMETRO      IN NUMBER,
	   	  		  		   							  SCOD_RECARGA    IN VARCHAR2,
													  NNUM_MOVIMIENTO IN NUMBER,
													  STIP_MONEDERO	  IN VARCHAR2
														   )
IS
	NNUM_ABONADO           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    NNUM_CELULAR           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
    SNOM_USUARIO		   ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
	NVAL_RECARGA		   ICC_MOVIMIENTO.CARGA%TYPE;
	NCOD_CLIENTE		   GA_ABOCEL.COD_CLIENTE%TYPE;
	SCOD_ACTABO            ICC_MOVIMIENTO.COD_ACTABO%TYPE;
	SCOD_MODULO            ICC_MOVIMIENTO.COD_MODULO%TYPE;

	SACTABOMOL             VARCHAR2(4);
	VTABLA				   VARCHAR2(30);
	V_ACT				   VARCHAR2(1);
	sCOD_SQLERRM	 	   VARCHAR2(60);

	ERROR_PROCESO EXCEPTION;

BEGIN

	VTABLA:='ICC_MOVIMIENTO';
	V_ACT:='S' ;

	SELECT NUM_ABONADO,NUM_CELULAR,
	       CARGA,NOM_USUARORA,
		   COD_ACTABO,COD_MODULO
	INTO
		   NNUM_ABONADO,NNUM_CELULAR,
		   NVAL_RECARGA,SNOM_USUARIO,
		   SCOD_ACTABO,SCOD_MODULO
	FROM ICC_MOVIMIENTO
	WHERE
	NUM_MOVIMIENTO = NNUM_MOVIMIENTO;

	SACTABOMOL  := SCOD_MODULO;

	VTABLA:='GA_ABOCEL';
	V_ACT:='S' ;

	BEGIN
		SELECT COD_CLIENTE INTO	NCOD_CLIENTE
		FROM GA_ABOCEL
		WHERE
		NUM_ABONADO = NNUM_ABONADO;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN

			 VTABLA:='GA_ABOAMIST';
			 V_ACT:='S' ;

			 SELECT COD_CLIENTE INTO	NCOD_CLIENTE
			 FROM GA_ABOAMIST
			 WHERE
			 NUM_ABONADO = NNUM_ABONADO;
		WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;
	END;

    VTABLA:='PV_RECARGAPREPAGO_TO';
	V_ACT:='I';


	INSERT INTO PV_RECARGAPREPAGO_TO
	(
	NUM_MOVIMIENTO,NUM_ABONADO,NUM_CELULAR,COD_CLIENTE,
    COD_RECARGA,VAL_RECARGA,NUM_TARJETA,COD_APLIORIGEN,
    IND_ESTADO,FEC_EJECENTRAL,FEC_RECARGA,NOM_USUARIO
    /*,COD_TIPMONEDERO*/
    )
    VALUES
	(
	NNUM_MOVIMIENTO,NNUM_ABONADO,NNUM_CELULAR,NCOD_CLIENTE,
    NVL(SCOD_RECARGA,SCOD_ACTABO),NVL(NVAL_RECARGA,0),'',SACTABOMOL,
    '1','',SYSDATE,SNOM_USUARIO
    /*,STIP_MONEDERO*/);


 INSERT INTO GA_TRANSACABO
		 (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		 VALUES
		 (SPARAMETRO,0,NULL);


EXCEPTION
    WHEN ERROR_PROCESO THEN
		sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);

        INSERT INTO GA_TRANSACABO
       		 (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
       		 VALUES
       		 (SPARAMETRO,4,sCOD_SQLERRM);


 	WHEN OTHERS THEN
		sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);

		INSERT INTO GA_TRANSACABO
		 (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		 VALUES
		 (SPARAMETRO,4,sCOD_SQLERRM);



END  PV_INS_RECARPREPAGO_QUIOSCO_PR;
/
SHOW ERROR
--******************************************************************************************
--** Informaci�n de Versionado *************************************************************
--******************************************************************************************
--** Pieza                                               :
--**  %ARCHIVE%
--** Identificador en PVCS                               :
--**  %PID%
--** Producto                                            :
--**  %PP%
--** Revisi�n                                            :
--**  %PR%
--** Autor de la Revisi�n                                :
--**  %AUTHOR%
--** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) :
--**  %PS%
--** Fecha de Creaci�n de la Revisi�n                    :
--**  %DATE%
--** Worksets ******************************************************************************
--** %PIRW%
--** Historia ******************************************************************************
--** %PL%
--******************************************************************************************