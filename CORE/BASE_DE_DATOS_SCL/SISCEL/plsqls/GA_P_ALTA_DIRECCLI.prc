CREATE OR REPLACE PROCEDURE        GA_P_ALTA_DIRECCLI(VP_DIRECCLI IN GA_DIRECCLI%ROWTYPE,
						   VP_PROC     IN OUT VARCHAR2,
						   VP_TABLA    IN OUT VARCHAR2,
						   VP_SQLCODE  IN OUT VARCHAR2,
						   VP_SQLERRM  IN OUT VARCHAR2,
						   VP_ERROR    IN OUT VARCHAR2 ) IS
--Procedimiento  de insercion de la tabla ge_direcCLI
--
--Los valores del codigo de retorno seran los siguientes:
--		-"0" ; la insercion se ha realizado correctamente
--		-"4" ; Error en proceso
BEGIN
	VP_PROC := 'GA_P_ALTA_DIRECCLI';
	VP_TABLA := 'GA_DIRECCLI';
     INSERT INTO GA_DIRECCLI
       (COD_CLIENTE,
        COD_TIPDIRECCION,
	COD_DIRECCION)
     VALUES(VP_DIRECCLI.COD_CLIENTE,
        VP_DIRECCLI.COD_TIPDIRECCION,
	VP_DIRECCLI.COD_DIRECCION);
  EXCEPTION
       WHEN OTHERS THEN
        VP_SQLCODE :=SQLCODE;
        VP_SQLERRM :=SQLERRM;
        VP_ERROR := '4';
 END;
/
SHOW ERRORS
