CREATE OR REPLACE procedure P_INTERFASES_ABONADOS
 (VP_TRANSACCION IN VARCHAR2,
                                                   VP_ACTABO IN VARCHAR2,
                                                   VP_PRODUCTO IN VARCHAR2,
                                                   VP_ABONADO IN VARCHAR2,
                                                   VP_ORIGEN IN VARCHAR2,
                                                   VP_DESTINO IN VARCHAR2,
                                                   VP_VAR3 IN VARCHAR2,
                                                   VP_VAR4 IN VARCHAR2 := NULL,
                                                   VP_VAR5 IN VARCHAR2 := NULL,
                                                   VP_VAR6 IN VARCHAR2 := NULL) is
--
-- Procedimiento de actualizacion de interfases con los modulos de
-- Facturacion, Tarificacion y Ventas. Es llamado desde las pantallas del
-- modulo que realizan transaccion que afectan a estos modulos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  V_PRODUCTO GE_PRODUCTOS.COD_PRODUCTO%TYPE;
  V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
  V_ERROR VARCHAR2(1) := '0';
  V_PROC VARCHAR2(50);
  V_SQLCODE VARCHAR2(15);
  V_SQLERRM VARCHAR2(255);  /* Se cambia de 70 a 255. 22-04-2003 */
  V_TABLA VARCHAR2(50);
  V_ACT VARCHAR2(1);
  V_FECSYS DATE;
  ERROR_PROCESO EXCEPTION;
BEGIN
  V_PRODUCTO := TO_NUMBER(VP_PRODUCTO);
  V_TRANSAC := TO_NUMBER(VP_TRANSACCION);
  V_ABONADO := TO_NUMBER(VP_ABONADO);
  SELECT SYSDATE INTO V_FECSYS FROM DUAL;
  IF V_PRODUCTO = 1 THEN
     P_INTERFASES_CELULAR(V_PRODUCTO,VP_ACTABO,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                          VP_VAR3,V_FECSYS,V_PROC,V_TABLA,V_ACT,
                          V_SQLCODE,V_SQLERRM,V_ERROR);
  ELSIF V_PRODUCTO = 2 THEN
     P_INTERFASES_BEEPER(V_PRODUCTO,VP_ACTABO,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                         VP_VAR3,V_FECSYS,V_PROC,V_TABLA,V_ACT,
                         V_SQLCODE,V_SQLERRM,V_ERROR);
  ELSIF V_PRODUCTO = 3 THEN
        NULL;
  ELSIF V_PRODUCTO = 4 THEN
        NULL;
  ELSIF V_PRODUCTO = 5 THEN
     P_INTERFASES_GENERAL(VP_ACTABO,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                          VP_VAR3,VP_VAR4,VP_VAR5,VP_VAR6,V_FECSYS,V_PROC,V_TABLA,V_ACT,
                          V_SQLCODE,V_SQLERRM,V_ERROR);
  ELSE
        V_ERROR := '4';
        RAISE ERROR_PROCESO;
  END IF;
  RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        IF V_ERROR <> '0' THEN
--              Modificación MA-200403170359 Autonomous transaction
                P_INSERTA_ERRORES(V_PRODUCTO,VP_ACTABO,V_ABONADO,V_FECSYS,V_PROC,V_TABLA,V_ACT,V_SQLCODE,V_SQLERRM);
--              Fin Modificacion MA-200403170359 Autonomous transaction
           Rollback;
           V_ERROR := 4;
        END IF;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (V_TRANSAC,
                                   V_ERROR,
                                   NULL);
END;
/
SHOW ERRORS
