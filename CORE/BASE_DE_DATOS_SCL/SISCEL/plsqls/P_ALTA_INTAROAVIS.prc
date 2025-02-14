CREATE OR REPLACE PROCEDURE        P_ALTA_INTAROAVIS(
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_FECALTA IN DATE ,
  VP_FECBAJA IN DATE ,
  VP_IMPLIMCONS IN NUMBER ,
  VP_CELDA IN VARCHAR2 ,
  VP_SERIE IN VARCHAR2 ,
  VP_CELULAR IN NUMBER ,
  VP_ESTADIA IN NUMBER ,
  VP_OPERADOR IN NUMBER ,
  VP_CELUORIG IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que inserta datos de abonados roaming en la tabla de interfase
-- Abonados/Tarificacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ALM GA_INTAROAVIS.COD_ALM%TYPE;
BEGIN
    dbms_output.put_line ('entra en intaroavis');
    VP_PROC := 'P_ALTA_INTAROAVIS';
    VP_TABLA := 'GA_INTAROAVIS';
    VP_ACT := 'I';
    dbms_output.put_line ('se va a recupera alm');
    P_RECUPERA_ALM(VP_CELDA,V_ALM,VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
     VP_SQLERRM,VP_ERROR);
    dbms_output.put_line ('vuelve de recupera alm');
    IF VP_ERROR = '0' THEN
       VP_PROC := 'P_ALTA_INTAROAVIS';
    dbms_output.put_line ('insert del intaroavis');
       INSERT INTO GA_INTAROAVIS
              (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
        FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
        IND_DIASESP,COD_CELDA,NUM_SERIE,
        NUM_CELULAR,NUM_ESTADIA,COD_OPERADOR,
        NUM_CELULARORIG,COD_ALM)
       VALUES (NVL(VP_CLIENTE,-1),VP_ABONADO,0,
        VP_FECALTA,VP_FECBAJA,VP_IMPLIMCONS,
        0,VP_CELDA,VP_SERIE,
               VP_CELULAR,VP_ESTADIA,VP_OPERADOR,
               VP_CELUORIG,V_ALM);
       dbms_output.put_line ('todo va bien en insert intaroavis');
    END IF;
EXCEPTION
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
