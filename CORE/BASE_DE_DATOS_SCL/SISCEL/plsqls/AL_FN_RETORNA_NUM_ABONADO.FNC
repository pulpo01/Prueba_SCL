CREATE OR REPLACE FUNCTION AL_FN_RETORNA_NUM_ABONADO(IMSI IN GSM_SIMCARD_TO.num_simcard%TYPE) RETURN VARCHAR
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : AL_FN_RETORNA_NUM_ABONADO
-- *  Entrada 			: IMSI
-- * Salida             : Numero de Abonado
-- * Descripcion        : Funcion que retorna el valor del Numero de Abonado
-- *                      y si encuentra datos retorna un cero
-- * Fecha de creacion  : Febrero 2003
-- * Responsable        : Claudio Astudillo Z.
-- *************************************************************
IS
  vNum_Abonado ga_abocel.num_abonado%TYPE;
  vCod_Cliente ga_abocel.cod_cliente%TYPE;
BEGIN
	SELECT  NUM_ABONADO, COD_CLIENTE
	INTO vNum_Abonado, vCod_Cliente
	FROM GA_ABOCEL
	WHERE NUM_SERIE IN (SELECT NUM_SIMCARD
	FROM GSM_DET_SIMCARD_TO
	WHERE COD_CAMPO = 'IMSI' AND VAL_CAMPO = IMSI);

	RETURN TO_CHAR(vCod_Cliente,'00000000') || ' ' || to_char(vNum_Abonado,'00000000');

	EXCEPTION
        WHEN NO_DATA_FOUND THEN
		BEGIN
			SELECT  NUM_ABONADO, COD_CLIENTE
			INTO vNum_Abonado, vCod_Cliente
			FROM GA_HABOCEL
			WHERE NUM_SERIE IN (SELECT NUM_SIMCARD
			FROM GSM_DET_SIMCARD_TO
			WHERE COD_CAMPO = 'IMSI' AND VAL_CAMPO = IMSI);

			RETURN TO_CHAR(vCod_Cliente,'00000000') || ' ' || to_char(vNum_Abonado,'00000000');

		EXCEPTION
        	WHEN NO_DATA_FOUND   THEN
		    RETURN 0;
		END;
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'Error ' || to_char(SQLCODE) || ': ' || SQLERRM);

END AL_FN_RETORNA_NUM_ABONADO;
/
SHOW ERRORS
