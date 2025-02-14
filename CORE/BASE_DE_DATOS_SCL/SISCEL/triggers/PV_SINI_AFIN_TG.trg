CREATE OR REPLACE TRIGGER PV_SINI_AFIN_TG
AFTER INSERT ON GA_SINIESTROS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE


  sCodCausa		   ged_parametros.VAL_PARAMETRO%type;
  nTraza		   NUMBER(2);

--	 Autor     : Christian Estay M. (Posventa)
--   Fecha     : 26/11/2003
--	 Comentario; Borra el registro en la tabla de errores la serie infromada por lista negra
--	 			 de Otras Operadoras(EXTERNAS) cuando la serie se encontraba en SCL con un abonado valido.

BEGIN

	 nTraza := 0;

	 BEGIN

		 IF :NEW.COD_ESTADO = 'AV' THEN

			    SELECT VAL_PARAMETRO
				  INTO sCodCausa
			  	  FROM GED_PARAMETROS
				 WHERE NOM_PARAMETRO = 'COD_CAUSAROBOEXT'
				   AND COD_MODULO = 'GA'
				   AND COD_PRODUCTO = 1;

			IF sCodCausa = :NEW.COD_CAUSA THEN

			   BEGIN

				   DELETE FROM PV_SERIELN_ERROR_TO
				         WHERE NUM_SERIE = :NEW.NUM_SERIE
						   AND NUM_ABONADO = :NEW.NUM_ABONADO;
			   EXCEPTION
				   WHEN OTHERS THEN
				        NULL;

			   END;

			END IF;

		 END IF;

     EXCEPTION
	     WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR  (-20002,'ERROR AL BORRAR EN PV_SERIELN_ERROR_TO : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

	 END;

EXCEPTION
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

END PV_SINI_AFIN_TG;
/
SHOW ERRORS
