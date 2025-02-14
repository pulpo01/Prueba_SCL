CREATE OR REPLACE PROCEDURE        P_ACTUALIZA_CARGOS_BAJA
(VP_CLIENTE IN NUMBER,
                                  VP_ABONADO IN NUMBER,
                                  VP_CICLO IN NUMBER,
                                  VP_PROC OUT VARCHAR2,
                                  VP_TABLA OUT VARCHAR2,
                                  VP_ACT OUT VARCHAR2,
                                  VP_SQLCODE OUT VARCHAR2,
                                  VP_SQLERRM OUT VARCHAR2,
                                  VP_ERROR OUT VARCHAR2)
IS
--
-- Procedimiento para actualizar los cargos de un abonado que ha sido dado
-- de baja, para que sean facturados en el proximo ciclo vigente
--
 V_COD_CICLFACT GE_CARGOS.COD_CICLFACT%TYPE;
 V_FECSYS DATE;
 IND_VALOR NUMBER;
BEGIN
   VP_PROC := 'P_ACTUALIZA_CARGOS_BAJA';
   VP_TABLA := 'FA_CICLFACT';
   VP_ACT := 'S';
   SELECT COD_CICLFACT INTO V_COD_CICLFACT
   FROM FA_CICLFACT
   WHERE COD_CICLO = VP_CICLO
         AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
   VP_PROC := 'P_ACTUALIZA_CARGOS_BAJA';
   VP_TABLA := 'GE_CARGOS';
   VP_ACT := 'U';
   IND_VALOR := 0;
   UPDATE GE_CARGOS
   SET COD_CICLFACT = V_COD_CICLFACT
   WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND NUM_TRANSACCION = IND_VALOR
         AND NUM_VENTA = IND_VALOR
         AND NUM_FACTURA = IND_VALOR;
   VP_ERROR := '0';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           VP_ERROR := '4';
           VP_SQLCODE := SQLCODE;
           VP_SQLERRM := SQLERRM;
      WHEN OTHERS THEN
           VP_ERROR := '4';
           VP_SQLCODE := SQLCODE;
           VP_SQLERRM := SQLERRM;
END;
/
SHOW ERRORS
