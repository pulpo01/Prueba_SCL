CREATE OR REPLACE PACKAGE IC_PASOH
IS
-- Modificación : 29-11-2004
-- Modificación : Se aplica proceso motor de interfaz comercial, y se migra, como primera actuación, la actuación 'VA'
-- Modificación : a la nueva configuración, por lo que es extraida del proceso P_GA_RESPUESTA
-- Responsable  : Fabián Aedo R.

  -- Paso a historico de movimientos de Page --
  PROCEDURE P_IC_PASOHB(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_BMOV IN ICB_MOVIMIENTO%ROWTYPE,
                        V_NEW_BMOV IN ICB_MOVIMIENTO%ROWTYPE);
  -- Paso a historico de movimientos de Celular --
  PROCEDURE P_IC_PASOHC(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_CMOV IN ICC_MOVIMIENTO%ROWTYPE,
                        V_NEW_CMOV IN ICC_MOVIMIENTO%ROWTYPE);
  -- Paso a historico de movimientos de Trek --
  PROCEDURE P_IC_PASOHM(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_MMOV IN ICM_MOVIMIENTO%ROWTYPE,
                        V_NEW_MMOV IN ICM_MOVIMIENTO%ROWTYPE);
  -- Paso a historico de movimientos deTrunk --
  PROCEDURE P_IC_PASOHR(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_RMOV IN ICR_MOVIMIENTO%ROWTYPE,
                        V_NEW_RMOV IN ICR_MOVIMIENTO%ROWTYPE);
END IC_PASOH;
/
SHOW ERRORS
