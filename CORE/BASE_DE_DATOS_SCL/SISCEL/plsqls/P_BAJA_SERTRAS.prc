CREATE OR REPLACE PROCEDURE        P_BAJA_SERTRAS
(VP_PRODUCTO IN NUMBER,
                         VP_CLIENTE IN NUMBER,
                         VP_ABONADO IN NUMBER,
                         VP_PROC IN OUT VARCHAR2,
                         VP_TABLA IN OUT VARCHAR2,
                         VP_ACT IN OUT VARCHAR2,
                         VP_SQLCODE IN OUT VARCHAR2,
                         VP_SQLERRM IN OUT VARCHAR2,
                         VP_ERROR IN OUT VARCHAR2)
IS
--
-- Procedimiento que refleja la baja POR TRASPASO  de abonados marcando fecha fin vigencia
-- en las tablas de interfase con tarificacion y facturacion
-- Ademas permite dar de baja servicios suplementarios en Base de Dato
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   CURSOR C1 IS
   SELECT ROWID
   FROM GA_SERVSUPLABO
   WHERE NUM_ABONADO = VP_ABONADO
         AND IND_ESTADO < 3;
   V_ROWID ROWID;
   V_CICLFACT GA_INFACCEL.COD_CICLFACT%TYPE;
   V_ESTADO_BAJACEN NUMBER;
BEGIN
   V_ESTADO_BAJACEN:=5;
   VP_PROC := 'P_BAJA_SERTRAS';
   VP_TABLA := 'C1';
   VP_ACT := 'O';
   OPEN C1;
   LOOP
      VP_TABLA := 'GA_SERVSUPLABO';
      VP_ACT := 'U';
      FETCH C1 INTO V_ROWID;
      EXIT WHEN C1%NOTFOUND;
      UPDATE GA_SERVSUPLABO
      SET FEC_BAJABD =SYSDATE,
          IND_ESTADO = V_ESTADO_BAJACEN
      WHERE ROWID = V_ROWID;
   END LOOP;
   CLOSE C1;
   VP_ERROR:='0';
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
