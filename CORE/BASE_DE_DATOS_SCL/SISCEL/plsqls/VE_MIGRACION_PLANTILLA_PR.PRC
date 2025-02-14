CREATE OR REPLACE PROCEDURE VE_MIGRACION_PLANTILLA_PR
IS
--
-- Procedimiento de insercion de datos en la tabla ve_plantilla_tipcomis_td
-- para cada registro de la tabla VE_TIPCOMIS
-- Pamela Gonzalez (16-10-2003)

   v_categoria      ve_tipcomis.cod_tipcomis%TYPE;
   v_error         VARCHAR2 (1) := '0';
   v_cant          INTEGER;
   ERROR_PROCESO   EXCEPTION;

   	CURSOR categoria IS
    SELECT cod_tipcomis
    FROM ve_tipcomis;


BEGIN

   OPEN categoria;

   LOOP
      BEGIN

         FETCH categoria INTO v_categoria;
         EXIT WHEN categoria%NOTFOUND;

		 SELECT COUNT(1)
		 INTO v_cant
		 FROM ve_plantilla_tipcomis_td
		 WHERE cod_tipcomis = v_categoria;

		 IF v_cant = 0 THEN
 		 	INSERT INTO ve_plantilla_tipcomis_td
       	 	(SELECT cod_campo, v_categoria,1,1,sysdate, user from ve_campos_td );

		 END IF;

		 EXCEPTION
         WHEN OTHERS THEN
         RAISE ERROR_PROCESO;

         END;
		 COMMIT;
   END LOOP;


   CLOSE categoria;

EXCEPTION
   WHEN ERROR_PROCESO
   THEN
      ROLLBACK;
   WHEN OTHERS
   THEN
      NULL;
END;
/
SHOW ERRORS
