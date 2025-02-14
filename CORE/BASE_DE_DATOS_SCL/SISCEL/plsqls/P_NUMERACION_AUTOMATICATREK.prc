CREATE OR REPLACE PROCEDURE        P_NUMERACION_AUTOMATICATREK
						   (VP_TRANSAC IN VARCHAR2,
                                                    VP_CENTRAL IN VARCHAR2,
                                                    VP_CLIENTE IN VARCHAR2,
						    VP_TIPSUSC IN VARCHAR2) is
--
-- Procedimiento de recuperacion de numeracion trek seleccionada de forma
-- automatica en funcion de la central,cliente y tipo de suscripcion
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Seleccionado y Reservado
--         - "1" ; Rango Bloqueado Temporalmente
--         - "2" ; No Existe Numeracion para Asignar
--         - "3" ; No Existe Numeracion en la central para asignar al cliente
--         - "4" ; Error en el proceso
--         - "5" ; Ya existe una suscripcion fija para el cliente
--
   V_ERROR CHAR(1) := '2';
   V_MAN GA_ABOTREK.NUM_MAN%TYPE;
   V_CLIENTE GA_ABOTREK.COD_CLIENTE%TYPE;
   V_CENTRAL GA_ABOTREK.COD_CENTRAL%TYPE;
   V_TABLA CHAR(1);
   V_FECBAJA DATE := NULL;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   V_RANGO NUMBER(1);
   ERROR_PROCESO EXCEPTION;
BEGIN
   V_CLIENTE := TO_NUMBER(VP_CLIENTE);
   V_CENTRAL := TO_NUMBER(VP_CENTRAL);
   V_TABLA := 'R';
   P_SELECT_REUTILIZABLESTREK (V_CENTRAL,V_CLIENTE,V_MAN,
			       VP_TIPSUSC,V_FECBAJA,V_ERROR);
   IF V_ERROR = '2' THEN
      V_TABLA := 'L';
      P_SELECT_RANGOSTREK (V_CENTRAL,V_CLIENTE,V_MAN,
                           VP_TIPSUSC,V_RANGO,V_ERROR);
   END IF;
   IF V_ERROR = '0' THEN
      V_CADENA := '/'||TO_CHAR(V_MAN)||
                  '/'||V_TABLA||
                  '/'||TO_CHAR(V_FECBAJA,'DD-MM-YYYY')||
		  '/'||TO_CHAR(V_RANGO);
      INSERT INTO GA_TRANSACABO
                 (NUM_TRANSACCION,
                  COD_RETORNO,
                  DES_CADENA)
          VALUES (VP_TRANSAC,
                  V_ERROR,
                  V_CADENA);
      COMMIT;
   ELSE
      RAISE ERROR_PROCESO;
   END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        ROLLBACK;
        INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
        COMMIT;
   WHEN OTHERS THEN
        RAISE ERROR_PROCESO;
END;
/
SHOW ERRORS
