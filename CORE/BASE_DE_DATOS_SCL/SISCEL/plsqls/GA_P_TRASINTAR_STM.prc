CREATE OR REPLACE PROCEDURE           GA_P_TRASINTAR_STM (
                                                 VP_CLIENTE IN NUMBER,
                                                 VP_ABONADO IN NUMBER,
                                                 VP_ABONADONUE IN NUMBER,
                                                 VP_CICLO IN NUMBER,
                                                 VP_CICLONEW IN NUMBER,
                                                 VP_FECSYS IN DATE,
                                                 VP_CLIENEW IN OUT NUMBER,
                                                 VP_PROC IN OUT VARCHAR2,
                                                 VP_TABLA IN OUT VARCHAR2,
                                                 VP_ACT IN OUT VARCHAR2,
                                                 VP_SQLCODE IN OUT VARCHAR2,
                                                 VP_SQLERRM IN OUT VARCHAR2,
                                                 VP_ERROR IN OUT VARCHAR2) is
--
-- *************************************************************
-- * procedimiento      : GA_P_TRASINTAR_STM
-- * Descripcion        : Procedimiento que refleja el traspaso de abonados STM entre clientes
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacion  :
-- * Responsable        : CRM
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
-- *************************************************************
--
--
V_ROWID ROWID;
   CURSOR C1 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
          FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
          IND_FRIENDS,IND_DIASESP,COD_CELDA,
          TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
          NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
          COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
          COD_GRUPO,COD_PORTADOR,COD_USO
     FROM GA_INTARCEL
    WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND VP_FECSYS BETWEEN FEC_DESDE
                        AND FEC_HASTA;
   V_CLIENTE GA_INTARCEL.COD_CLIENTE%TYPE;
   V_ABONADO GA_INTARCEL.NUM_ABONADO%TYPE;
   V_NUMERO GA_INTARCEL.IND_NUMERO%TYPE;
   V_FECDESDE GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHASTA GA_INTARCEL.FEC_HASTA%TYPE;
   V_LIMCONSUMO GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   V_FRIENDS GA_INTARCEL.IND_FRIENDS%TYPE;
   V_DIASESP GA_INTARCEL.IND_DIASESP%TYPE;
   V_CELDA GA_INTARCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF GA_INTARCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF GA_INTARCEL.COD_PLANTARIF%TYPE;
   V_SERIE GA_INTARCEL.NUM_SERIE%TYPE;
   V_SERIETRUNK GA_INTARTRUNK.NUM_SERIE%TYPE;
   V_SERIETREK GA_INTARTREK.NUM_SERIE%TYPE;
   V_CELULAR GA_INTARCEL.NUM_CELULAR%TYPE;
   V_CARGOBASICO GA_INTARCEL.COD_CARGOBASICO%TYPE;
   V_CICLO GA_INTARCEL.COD_CICLO%TYPE;
   V_PLANCOM GA_INTARCEL.COD_PLANCOM%TYPE;
   V_PLANSERV GA_INTARCEL.COD_PLANSERV%TYPE;
   V_GRPSERV GA_INTARCEL.COD_GRPSERV%TYPE;
   V_GRUPO GA_INTARCEL.COD_GRUPO%TYPE;
   V_PORTADOR GA_INTARCEL.COD_PORTADOR%TYPE;
   V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
   V_USO GA_INTARCEL.COD_USO%TYPE;
   V_NUM_IMSI GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;

   ERROR_PROCESO EXCEPTION;
BEGIN
      VP_PROC := 'P_TRASPASO_INTARXXX';
      VP_TABLA := 'GA_ABOCEL';
      VP_ACT := 'S';

        V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');

      SELECT COD_CLIENTE
      INTO  VP_CLIENEW
      FROM  GA_ABOCEL
      WHERE NUM_ABONADO = VP_ABONADONUE;

      VP_TABLA := 'C1';
      VP_ACT := 'O';

      OPEN C1;
      LOOP
         VP_TABLA := 'C1';
         VP_ACT := 'F';
         FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,
                       V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
                       V_FRIENDS,V_DIASESP,V_CELDA,
                       V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                       V_CELULAR,V_CARGOBASICO,V_CICLO,
                       V_PLANCOM,V_PLANSERV,V_GRPSERV,
                       V_GRUPO,V_PORTADOR,V_USO;
         EXIT WHEN C1%NOTFOUND;

                 IF V_ABONADO <> 0 THEN
                 SELECT COD_TECNOLOGIA, NUM_SERIE
                         INTO  V_TECNOLOGIA, V_NUM_SERIE
                         FROM  GA_ABOCEL
                         WHERE NUM_ABONADO = V_ABONADO;

                         IF V_TECNOLOGIA = V_TECNOLOGIA_GSM THEN
                        SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
                         END IF;
                 END IF;

         VP_TABLA := 'GA_INTARCEL';
             VP_ACT := 'U';

         UPDATE GA_INTARCEL
            SET FEC_HASTA = VP_FECSYS - (1/(24*60*60)),
                        NUM_IMSI = V_NUM_IMSI
          WHERE ROWID = V_ROWID;

         VP_TABLA := 'GA_INTARCEL';
         VP_ACT := 'I';

         INSERT INTO GA_INTARCEL
                    (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                     FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,
                     TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                     COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                     COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
             VALUES (VP_CLIENEW,VP_ABONADONUE,V_NUMERO,
                     VP_FECSYS,V_FECHASTA,V_LIMCONSUMO,
                     V_FRIENDS,V_DIASESP,V_CELDA,
                     V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                     V_CELULAR,V_CARGOBASICO,VP_CICLONEW,
                     V_PLANCOM,V_PLANSERV,V_GRPSERV,
                     V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);
      END LOOP;
      VP_TABLA := 'C1';
      VP_ACT := 'C';
      CLOSE C1;
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
