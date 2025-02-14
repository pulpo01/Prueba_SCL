CREATE OR REPLACE PROCEDURE P_INSERTA_ERRORES
 (	   	  	 V_PRODUCTO		in  NUMBER,
             V_ACTABO		in  VARCHAR2,
             V_ABONADO		in  NUMBER,
             V_FECSYS		in  DATE,
             V_PROC			in  VARCHAR2,
             V_TABLA		in  VARCHAR2,
             V_ACT			in  VARCHAR2,
             V_SQLCODE		in  VARCHAR2,
             V_SQLERRM		in  VARCHAR2 )
 IS

PRAGMA AUTONOMOUS_TRANSACTION;

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_INSERTA_ERRORES
-- * Descripcion        : inserta en la tabla GA_ERRORES
-- * Fecha de creacion  : <11/03/2004
-- * Responsable        : Soporte PV
-- *************************************************************
BEGIN

	 INSERT INTO GA_ERRORES
            (COD_PRODUCTO,
             COD_ACTABO,
             CODIGO,
             FEC_ERROR,
             NOM_PROC,
             NOM_TABLA,
             COD_ACT,
             COD_SQLCODE,
             COD_SQLERRM)
     VALUES (V_PRODUCTO,
             V_ACTABO,
             V_ABONADO,
             V_FECSYS,
             V_PROC,
             V_TABLA,
             V_ACT,
             V_SQLCODE,
             SUBSTR(V_SQLERRM,1,60)
			);

	 COMMIT;

EXCEPTION
	 WHEN OTHERS THEN
	 	  RAISE_APPLICATION_ERROR (-20177,'Error INSERT en GA_ERRORES' || TO_CHAR(SQLCODE));


END;
/
SHOW ERRORS
