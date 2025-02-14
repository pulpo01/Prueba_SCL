CREATE OR REPLACE PROCEDURE        GA_P_ALTA_SUBCUENTAS  (VP_SUBCUENTAS  IN GA_SUBCUENTAS%ROWTYPE,
						   VP_PROC     IN OUT VARCHAR2,
						   VP_TABLA    IN OUT VARCHAR2,
						   VP_SQLCODE  IN OUT VARCHAR2,
						   VP_SQLERRM  IN OUT VARCHAR2,
						   VP_ERROR    IN OUT VARCHAR2 ) IS
--Procedimiento  de insercion de la tabla ga_subcuentas
--
--Los valores del codigo de retorno seran los siguientes:
--		-"0" ; la insercion se ha realizado correctamente
--		-"4" ; Error en proceso
BEGIN
	VP_PROC := 'GA_P_ALTA_SUBCUENTAS';
	VP_TABLA := 'GA_SUBCUENTAS';
     INSERT INTO GA_SUBCUENTAS
       (COD_SUBCUENTA,
        COD_CUENTA,
        DES_SUBCUENTA,
	COD_DIRECCION,
        FEC_ALTA)
 VALUES(VP_SUBCUENTAS.COD_SUBCUENTA,
        VP_SUBCUENTAS.COD_CUENTA,
        VP_SUBCUENTAS.DES_SUBCUENTA,
	VP_SUBCUENTAS.COD_DIRECCION,
        VP_SUBCUENTAS.FEC_ALTA);
  EXCEPTION
       WHEN OTHERS THEN
        VP_SQLCODE :=SQLCODE;
        VP_SQLERRM :=SQLERRM;
        VP_ERROR := '4';
 END;
/
SHOW ERRORS
