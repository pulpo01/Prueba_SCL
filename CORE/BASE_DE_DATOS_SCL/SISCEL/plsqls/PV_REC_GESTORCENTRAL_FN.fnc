CREATE OR REPLACE FUNCTION PV_REC_GESTORCENTRAL_FN (NNUM_MOVIMIENTO IN NUMBER) RETURN VARCHAR2
IS

	NNUM_ABONADO           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    NNUM_CELULAR           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
	NCOD_CLIENTE		   GA_ABOCEL.COD_CLIENTE%TYPE;
	SCOD_ACTABO            ICC_MOVIMIENTO.COD_ACTABO%TYPE;


	V_RESPUESTA			   VARCHAR2(30);
	V_TABLA				   VARCHAR2(30);
	V_ACT				   VARCHAR2(1);
	sCOD_SQLERRM	 	   VARCHAR2(60);

	ERROR_PROCESO EXCEPTION;

BEGIN

	V_RESPUESTA := 'FALSE';

	V_TABLA:='ICC_MOVIMIENTO';
	V_ACT:='S' ;

	SELECT NUM_ABONADO,NUM_CELULAR,
		   COD_ACTABO
	INTO
		   NNUM_ABONADO,NNUM_CELULAR,
		   SCOD_ACTABO
	FROM ICC_MOVIMIENTO
	WHERE
	NUM_MOVIMIENTO = NNUM_MOVIMIENTO;

	V_TABLA:='GA_ABOCEL';
	V_ACT:='S' ;

	BEGIN
		SELECT COD_CLIENTE INTO	NCOD_CLIENTE
		  FROM GA_ABOCEL
		 WHERE NUM_ABONADO = NNUM_ABONADO;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN

			 V_TABLA:='GA_ABOAMIST';
			 V_ACT:='S' ;

			 SELECT COD_CLIENTE INTO	NCOD_CLIENTE
			 FROM GA_ABOAMIST
			 WHERE
			 NUM_ABONADO = NNUM_ABONADO;
		WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;
	END;


    IF LTRIM(RTRIM(SCOD_ACTABO)) = 'GC' THEN  --CAMBIO DE CICLO
	   BEGIN
		   SELECT DECODE(COD_CICLO,1,'28',5,'05',10,'09',13,'12',20,'19')--Pareo de Ciclos, Gestor --
		   INTO V_RESPUESTA
 		   FROM GA_FINCICLO
		   WHERE NUM_ABONADO = NNUM_ABONADO;

	   EXCEPTION
	   	WHEN NO_DATA_FOUND THEN
	   		SELECT DECODE(COD_CICLO,1,'28',5,'05',10,'09',13,'12',20,'19')-- MARCELO MIRANDA Pareo de Ciclos, Gestor --
		   	INTO V_RESPUESTA
 		   	FROM GA_ABOCEL
		   	WHERE NUM_ABONADO = NNUM_ABONADO;
 	        WHEN OTHERS THEN
	   	   	RAISE ERROR_PROCESO;
	   END;
    ELSIF LTRIM(RTRIM(SCOD_ACTABO)) = 'GO' THEN  --CICLO ACTUAL CAMBIO DE CLIENTE
	   BEGIN
		     SELECT COD_CLIENANT
		     INTO V_RESPUESTA
 			 FROM GA_TRASPABO
			 WHERE NUM_ABONADO = NNUM_ABONADO
			 AND NUM_ABONADO <> NUM_ABONADOANT
			 AND COD_CLIENNUE <> COD_CLIENANT
			 AND FEC_MODIFICA IN (SELECT MAX(FEC_MODIFICA) FROM GA_TRASPABO WHERE NUM_ABONADO = NNUM_ABONADO
			  						                AND NUM_ABONADO <> NUM_ABONADOANT -- Marcelo Miranda W. --
			  								AND COD_CLIENNUE <> COD_CLIENANT);

	   EXCEPTION
   	   	  WHEN OTHERS THEN
	   		   RAISE ERROR_PROCESO;
	   END;
	END IF;

RETURN V_RESPUESTA;


EXCEPTION
    WHEN ERROR_PROCESO THEN
		sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);
		RETURN 'FALSE';
 	WHEN OTHERS THEN
		sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);
		RETURN 'FALSE';


END;
/
SHOW ERRORS
