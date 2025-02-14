CREATE OR REPLACE PROCEDURE        P_ALTA_INTARENT(
  VP_ALQUILER IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_PLEXSYS IN NUMBER ,
  VP_IMPLIMCONS IN NUMBER ,
  VP_CELDA IN VARCHAR2 ,
  VP_PLANTARIF IN VARCHAR2 ,
  VP_SERIE IN VARCHAR2 ,
  VP_CELULAR IN NUMBER ,
  VP_CELULAR_PLEX IN NUMBER ,
  VP_CARGOBASICO IN VARCHAR2 ,
  VP_PLANSERV IN VARCHAR2 ,
  VP_PROCALTA IN VARCHAR2 ,
  VP_AGENTE IN NUMBER ,
  VP_FECALTA IN DATE ,
  VP_FECBAJA IN DATE ,
  VP_FECSYS IN DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que inserta datos en la tabla de interfase
-- Abonados/Tarificacion para el procesamiento de estos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
  V_PLANCOM VE_PLANCOM.COD_PLANCOM%TYPE;
  V_FRIENDS GA_INTARCEL.IND_FRIENDS%TYPE;
  V_DIASESP GA_INTARCEL.IND_DIASESP%TYPE;
  V_FYFCEL GA_DATOSGENER.COD_FYFCEL%TYPE;
  V_DIASESPCEL GA_DATOSGENER.COD_DIASESPCEL%TYPE;
  V_PLANCOMNEW GA_INTARCEL.COD_PLANCOM%TYPE;
  VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
  ERROR_PROCESO EXCEPTION;
BEGIN
   VP_PROC := 'P_ALTA_INTARENT';
   dbms_output.put_line ('estamos entrando en alta intarent');
   dbms_output.put_line ('ALQUILER ='||TO_CHAR(VP_ALQUILER));
   dbms_output.put_line ('ABONADO ='||TO_CHAR(VP_ABONADO));
   dbms_output.put_line ('CLIENTE ='||TO_CHAR(VP_CLIENTE));
   dbms_output.put_line ('IND PLEX ='||TO_CHAR(VP_PLEXSYS));
   dbms_output.put_line ('LIMCONSU ='||TO_CHAR(VP_IMPLIMCONS));
   dbms_output.put_line ('CELDA ='||VP_CELDA);
   dbms_output.put_line ('PLANTARI ='||VP_PLANTARIF);
   dbms_output.put_line ('SERIE ='||VP_ALQUILER);
   dbms_output.put_line ('CELULAR ='||TO_CHAR(VP_CELULAR));
   dbms_output.put_line ('CELUPLEX ='||TO_CHAR(VP_CELULAR_PLEX));
   dbms_output.put_line ('CARGOBAS ='||VP_CARGOBASICO);
   dbms_output.put_line ('PLANSERV ='||VP_PLANSERV);
   dbms_output.put_line ('PROCALTA ='||VP_PROCALTA);
   dbms_output.put_line ('AGENTE ='||TO_CHAR(VP_AGENTE));
   dbms_output.put_line ('FECALTA='||TO_CHAR(VP_FECALTA));
   dbms_output.put_line ('FECSYS ='||TO_CHAR(VP_FECSYS));
   VP_TABLA := 'GA_DATOSGENER';
   VP_ACT := 'S';
   dbms_output.put_line ('select datos generales');
   SELECT COD_FYFCEL,COD_DIASESPCEL
     INTO V_FYFCEL,V_DIASESPCEL
     FROM GA_DATOSGENER;
   VP_TABLA := 'GA_SERVSUPLABO';
   dbms_output.put_line ('sale select datos generales');
   BEGIN
   dbms_output.put_line ('select de servsuplabo 1');
      SELECT NUM_ABONADO
        INTO VAR1
        FROM GA_SERVSUPLABO
       WHERE NUM_ABONADO = VP_ABONADO
         AND COD_SERVICIO = V_FYFCEL
         AND IND_ESTADO < 3;
   dbms_output.put_line ('sale select de servsuplabo');
      V_FRIENDS := 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
   dbms_output.put_line ('sale select de servsuplabo con no_data_found');
    V_FRIENDS := 0;
      WHEN OTHERS THEN
    VP_ERROR := '4';
    RAISE ERROR_PROCESO;
   END;
   BEGIN
   dbms_output.put_line ('select de servsuplabo 2');
      SELECT NUM_ABONADO
        INTO VAR1
        FROM GA_SERVSUPLABO
       WHERE NUM_ABONADO = VP_ABONADO
         AND COD_SERVICIO = V_DIASESPCEL
         AND IND_ESTADO < 3;
   dbms_output.put_line ('sale select de servsuplabo 2');
      V_DIASESP := 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
   dbms_output.put_line ('sale select de servsuplabo 2 con no_data_found');
    V_DIASESP := 0;
      WHEN OTHERS THEN
    VP_ERROR := '4';
    RAISE ERROR_PROCESO;
   END;
       dbms_output.put_line ('va a recuperar el plan comercial');
    VP_TABLA := 'GA_CLIENTE_PCOM';
    VP_ACT := 'S';
    SELECT COD_PLANCOM
      INTO V_PLANCOM
      FROM GA_CLIENTE_PCOM
     WHERE COD_CLIENTE = VP_CLIENTE
       AND VP_FECSYS BETWEEN FEC_DESDE
                         AND NVL(FEC_HASTA,VP_FECSYS);
       dbms_output.put_line ('sale de recuperar el plan comercial');
    dbms_output.put_line('insert en ga_intarent');
    VP_TABLA := 'GA_INTARENT';
    VP_ACT := 'I';
    dbms_output.put_line('VP_CLIENTE='||TO_CHAR(VP_CLIENTE)||'*');
    dbms_output.put_line('VP_ABONADO='||TO_CHAR(VP_ABONADO)||'*');
    dbms_output.put_line('VP_FECALTA='||TO_CHAR(VP_FECALTA)||'*');
    dbms_output.put_line('VP_FECBAJA='||TO_CHAR(VP_FECBAJA)||'*');
    dbms_output.put_line('VP_IMPLIMCONS='||TO_CHAR(VP_IMPLIMCONS)||'*');
    dbms_output.put_line('V_FRIENDS='||TO_CHAR(V_FRIENDS)||'*');
    dbms_output.put_line('V_DIASESP='||TO_CHAR(V_DIASESP)||'*');
    dbms_output.put_line('VP_CELDA='||VP_CELDA||'*');
    dbms_output.put_line('VP_PLANTARIF='||VP_PLANTARIF||'*');
    dbms_output.put_line('VP_SERIE='||VP_SERIE||'*');
    dbms_output.put_line('VP_CELULAR='||TO_CHAR(VP_CELULAR)||'*');
    dbms_output.put_line('VP_CARGOBASICO='||VP_CARGOBASICO||'*');
    dbms_output.put_line('VP_ALQUILER='||TO_CHAR(VP_ALQUILER)||'*');
    dbms_output.put_line('V_PLANCOM='||TO_CHAR(V_PLANCOM)||'*');
    dbms_output.put_line('VP_PLANSERV='||VP_PLANSERV||'*');
    INSERT INTO GA_INTARENT
           (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
            FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
            IND_FRIENDS,IND_DIASESP,COD_CELDA,
            TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
     NUM_CELULAR,COD_CARGOBASICO,NUM_ALQUILER,
     COD_PLANCOM,COD_PLANSERV)
    VALUES (VP_CLIENTE,VP_ABONADO,0,
            VP_FECALTA,VP_FECBAJA,VP_IMPLIMCONS,
            V_FRIENDS,V_DIASESP,VP_CELDA,
            'I',VP_PLANTARIF,VP_SERIE,
            VP_CELULAR,VP_CARGOBASICO,VP_ALQUILER,
            V_PLANCOM,VP_PLANSERV);
       dbms_output.put_line ('todo va bien en insert intarent');
    IF VP_PLEXSYS = 1 THEN
       dbms_output.put_line ('es plexsys');
       VP_TABLA := 'GA_INTARENT';
       VP_ACT := 'I';
       INSERT INTO GA_INTARENT
             (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
              FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
              IND_FRIENDS,IND_DIASESP,COD_CELDA,
              TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
       NUM_CELULAR,COD_CARGOBASICO,NUM_ALQUILER,
       COD_PLANCOM,COD_PLANSERV)
      VALUES (VP_CLIENTE,VP_ABONADO,1,
              VP_FECALTA,VP_FECBAJA,VP_IMPLIMCONS,
              V_FRIENDS,V_DIASESP,VP_CELDA,
              'I',VP_PLANTARIF,VP_SERIE,
              VP_CELULAR,VP_CARGOBASICO,VP_ALQUILER,
              V_PLANCOM,VP_PLANSERV);
       dbms_output.put_line ('el insert plexsys va ok');
    END IF;
    BEGIN
       VP_TABLA := 'TA_ACUMABONADO';
       VP_ACT := 'I';
       dbms_output.put_line ('insert de acumabonado');
       INSERT INTO TA_ACUMABONADO
                  (NUM_ABONADO,
                   FEC_ALTA,
                   SEG_CONSUMOS)
           VALUES (VP_ABONADO,
                   VP_FECALTA,
                   0);
       dbms_output.put_line ('sale de insert de acumabonado');
    EXCEPTION
 WHEN OTHERS THEN
      IF SQLCODE = -1 THEN
  UPDATE TA_ACUMABONADO
     SET SEG_CONSUMOS = 0
                 WHERE NUM_ABONADO = VP_ABONADO;
             ELSE
  VP_ERROR := '4';
  VP_SQLCODE := SQLCODE;
  VP_SQLERRM := SQLERRM;
             END IF;
    END;
EXCEPTION
   WHEN ERROR_PROCESO THEN
       dbms_output.put_line ('excepcion error_proceso');
 IF VP_SQLCODE IS NULL THEN
           VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
        END IF;
        VP_ERROR := '4';
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
