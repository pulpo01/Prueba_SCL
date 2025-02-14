CREATE OR REPLACE FUNCTION Al_FN_EstadoICC (pNUM_SIMCARD in GSM_SIMCARD_ESTADOS_TO.NUM_SIMCARD%TYPE) Return varchar2
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : Al_EstadoIcc
-- * Salida             : Valor del Campo entregado por parametro
-- * Descripcion        : Funcion que retorna el estado de la
-- *                      Simcard o false
-- * Fecha de creacion  : Abril 2003
-- * Responsable        : Claudio Astudillo Z.
-- *************************************************************
v_Return GSM_SIMCARD_ESTADOS_TO.COD_ESTADO%type;
BEGIN
     SELECT distinct(COD_ESTADO)
	 INTO   v_Return
	 FROM   GSM_SIMCARD_ESTADOS_TO
	 WHERE  COD_MODULO = 'AL'
	 AND    COD_ESTADO = 'EI'
	 AND    NUM_SIMCARD = pNUM_SIMCARD;

	 RETURN v_Return;

EXCEPTION
	 WHEN NO_DATA_FOUND   THEN
	 BEGIN
          		 SELECT COD_ESTADO
				 INTO   v_Return
				 FROM   GSM_SIMCARD_TO
				 WHERE  NUM_SIMCARD = pNUM_SIMCARD;

				 RETURN v_Return;
		 EXCEPTION
	     WHEN NO_DATA_FOUND   THEN
		 	  RETURN 'FALSE';
	 END;
     WHEN OTHERS THEN
       raise_application_error (SQLCODE,'ERROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END Al_FN_EstadoICC;
/
SHOW ERRORS
