CREATE OR REPLACE PROCEDURE        P_INDICADOR_FACTURABLE(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_ESTADO IN NUMBER ,
  VP_CICLO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja el estado del Indicativo de Facturacion
-- para cada uno de los abonados; 1-Activo 0-Desactivo las tablas de
-- interfase con facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_CICLFACT GA_INFACCEL.COD_CICLFACT%TYPE;
BEGIN
    VP_PROC := 'P_INDICADOR_FACTURABLE';
    VP_TABLA := 'FA_CICLFACT';
    VP_ACT := 'S';
    dbms_output.put_line ('select ciclfact');
    SELECT COD_CICLFACT
      INTO V_CICLFACT
      FROM FA_CICLFACT
     WHERE COD_CICLO = VP_CICLO
       AND VP_FECSYS BETWEEN FEC_DESDELLAM
                         AND FEC_HASTALLAM;
    dbms_output.put_line ('sale select ciclfact');
    IF VP_PRODUCTO = 1 THEN
       VP_TABLA := 'GA_INFACCEL';
       VP_ACT := 'U';
    dbms_output.put_line ('update infaccel');
       UPDATE GA_INFACCEL
          SET IND_FACTUR  = VP_ESTADO
        WHERE COD_CLIENTE  = VP_CLIENTE
          AND NUM_ABONADO  = VP_ABONADO
          AND COD_CICLFACT = V_CICLFACT
   AND IND_ACTUAC <> 6;
    dbms_output.put_line ('sale update infaccel');
    ELSIF VP_PRODUCTO = 2 THEN
       VP_TABLA := 'GA_INFACBEEP';
       VP_ACT := 'U';
       UPDATE GA_INFACBEEP
          SET IND_FACTUR  = VP_ESTADO
        WHERE COD_CLIENTE  = VP_CLIENTE
          AND NUM_ABONADO  = VP_ABONADO
          AND COD_CICLFACT = V_CICLFACT
   AND IND_ACTUAC <> 6;
    ELSIF VP_PRODUCTO = 3 THEN
       VP_TABLA := 'GA_INFACTRUNK';
       VP_ACT := 'U';
       UPDATE GA_INFACTRUNK
          SET IND_FACTUR  = VP_ESTADO
        WHERE COD_CLIENTE  = VP_CLIENTE
          AND NUM_ABONADO  = VP_ABONADO
          AND COD_CICLFACT = V_CICLFACT
   AND IND_ACTUAC <> 6;
    ELSIF VP_PRODUCTO = 4 THEN
       VP_TABLA := 'GA_INFACTREK';
       VP_ACT := 'U';
       UPDATE GA_INFACTREK
          SET IND_FACTUR  = VP_ESTADO
        WHERE COD_CLIENTE  = VP_CLIENTE
          AND NUM_ABONADO  = VP_ABONADO
          AND COD_CICLFACT = V_CICLFACT
   AND IND_ACTUAC <> 6;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
