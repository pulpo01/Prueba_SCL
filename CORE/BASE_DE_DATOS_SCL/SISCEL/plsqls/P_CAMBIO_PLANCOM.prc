CREATE OR REPLACE PROCEDURE P_CAMBIO_PLANCOM(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_PLANCOM IN NUMBER ,
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
-- *************************************************************
-- * procedimiento      : P_CAMBIO_PLANCOM
-- * Descripcion        : Procedimiento que refleja el cambio y efectividad del nuevo plan tarifario
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacion  :
-- * Responsable        : CRM
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
-- *************************************************************
--
--
   V_FECHADCF GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHADLL GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHAD GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHA GA_INTARCEL.FEC_DESDE%TYPE;
   V_ROWID ROWID;
   V_INDCAR NUMBER(1) := 0;
   V_INDLLA NUMBER(1) := 0;
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
      AND FEC_DESDE = V_FECHA;
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
   V_CAPCODE GA_INTARBEEP.CAP_CODE%TYPE;
   V_BEEPER GA_INTARBEEP.NUM_BEEPER%TYPE;
   V_RADIO GA_INTARTRUNK.NUM_RADIO%TYPE;
   V_MAN GA_INTARTREK.NUM_MAN%TYPE;
   V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
   V_NEXTPC GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
   V_NEXTFEC GA_CLIENTE_PCOM.FEC_DESDE%TYPE;
   V_USO GA_INTARCEL.COD_USO%TYPE;
   VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
   V_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
   V_NUM_IMSI  GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;

   ERROR_PROCESO EXCEPTION;
BEGIN
   dbms_output.put_line ('entra');
   VP_PROC := 'P_CAMBIO_PLANCOM';
   dbms_output.put_line ('01');
   BEGIN
      VP_TABLA := 'FA_CICLFACT';
   dbms_output.put_line ('02');
      VP_ACT := 'S';
   dbms_output.put_line ('03');
       SELECT MIN(FEC_DESDELLAM)
          INTO V_FECHADCF
          FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLO
           AND VP_FECSYS <= FEC_DESDELLAM
           AND IND_FACTURACION = 0;
        SELECT FEC_DESDELLAM,COD_CICLFACT
          INTO V_FECHADLL,V_CICLFACT
          FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLO
           AND VP_FECSYS <= FEC_DESDELLAM
           AND IND_FACTURACION = 0
           AND FEC_DESDELLAM=V_FECHADCF;
   dbms_output.put_line ('3');
   EXCEPTION
      WHEN OTHERS THEN
   dbms_output.put_line ('4');
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
   END;
   IF VP_PRODUCTO = 1 THEN
        V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');

        SELECT NUM_SERIE, COD_TECNOLOGIA
        INTO V_NUM_SERIE, V_TECNOLOGIA
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = VP_ABONADO;

        IF V_TECNOLOGIA = V_TECNOLOGIA_GSM THEN
        SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
        END IF;

      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'S';
      BEGIN
   dbms_output.put_line ('5');
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARCEL
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADCF;
   dbms_output.put_line ('6');
         V_INDCAR := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDCAR := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDCAR := 1;
         WHEN OTHERS THEN
   dbms_output.put_line ('7');
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
      END;
      BEGIN
   dbms_output.put_line ('8');
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARCEL
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADLL;
   dbms_output.put_line ('9');
         V_INDLLA := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDLLA := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDLLA := 1;
         WHEN OTHERS THEN
   dbms_output.put_line ('10');
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
      END;
      IF V_INDCAR = 0 AND V_INDLLA = 0 THEN
         BEGIN
            VP_TABLA := 'GA_INTARCEL';
            VP_ACT := 'S';
   dbms_output.put_line ('11');
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARCEL
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND NVL(FEC_HASTA,VP_FECSYS)
               AND ROWNUM = 1;
   dbms_output.put_line ('12');
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
   dbms_output.put_line ('13');
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDLLA <> 0 THEN
         VP_TABLA := 'GA_INTARCEL';
         VP_ACT := 'U';
   dbms_output.put_line ('14');
         UPDATE GA_INTARCEL
            SET COD_PLANCOM = VP_PLANCOM,NUM_IMSI=V_NUM_IMSI
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE >= V_FECHADCF;
   dbms_output.put_line ('15');
         VP_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF V_INDCAR <> 0 THEN
            IF V_FECHADLL >= V_FECHADCF THEN
               V_FECHA := V_FECHADCF;
            ELSE
               V_FECHA := V_FECHAD;
            END IF;
      END IF;
      VP_TABLA := 'C1';
      VP_ACT := 'O';
      OPEN C1;
      LOOP
         VP_ACT := 'F';
   dbms_output.put_line ('16');
         FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,
                       V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
                       V_FRIENDS,V_DIASESP,V_CELDA,
                       V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                       V_CELULAR,V_CARGOBASICO,V_CICLO,
                       V_PLANCOM,V_PLANSERV,V_GRPSERV,
                       V_GRUPO,V_PORTADOR,V_USO;
   dbms_output.put_line ('17');
         EXIT WHEN C1%NOTFOUND;
         IF V_FECHA = V_FECHADCF THEN
            IF V_FECHADCF = V_FECHADLL THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
   dbms_output.put_line ('18');
               UPDATE GA_INTARCEL
                  SET COD_PLANCOM = VP_PLANCOM,NUM_IMSI=V_NUM_IMSI
                WHERE ROWID = V_ROWID;
   dbms_output.put_line ('19');
            ELSIF V_FECHADCF < V_FECHADLL THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
   dbms_output.put_line ('20');
               UPDATE GA_INTARCEL
                  SET FEC_HASTA = V_FECHADLL - (1/(24*60*60)),NUM_IMSI=V_NUM_IMSI
                WHERE ROWID = V_ROWID;
   dbms_output.put_line ('21');
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
   dbms_output.put_line ('22');
               INSERT INTO GA_INTARCEL
                          (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                           FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                           IND_FRIENDS,IND_DIASESP,COD_CELDA,
                           TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                           NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                           COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                           COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                   VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHASTA,V_LIMCONSUMO,
                           V_FRIENDS,V_DIASESP,V_CELDA,
                           V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CARGOBASICO,V_CICLO,
                           VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                           V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);
   dbms_output.put_line ('23');
            END IF;
         ELSE
            VP_TABLA := 'GA_INTARCEL';
            VP_ACT := 'U';
   dbms_output.put_line ('24');
            UPDATE GA_INTARCEL
               SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
             WHERE ROWID = V_ROWID;
   dbms_output.put_line ('25');
            IF V_INDCAR <> 0 THEN
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
                   VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHADCF - (1/(24*60*60)),
                           V_LIMCONSUMO,V_FRIENDS,V_DIASESP,V_CELDA,
                           V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CARGOBASICO,V_CICLO,
                           VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                           V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               UPDATE GA_INTARCEL
                  SET COD_PLANCOM = VP_PLANCOM,NUM_IMSI=V_NUM_IMSI
                WHERE COD_CLIENTE = V_CLIENTE
                  AND NUM_ABONADO = V_ABONADO
                  AND FEC_DESDE = V_FECHADCF;
            ELSE
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
                   VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHASTA,V_LIMCONSUMO,
                           V_FRIENDS,V_DIASESP,V_CELDA,
                           V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CARGOBASICO,V_CICLO,
                           VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                           V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);
            END IF;
         END IF;
      END LOOP;
      VP_TABLA := 'C1';
      VP_ACT := 'C';
      CLOSE C1;
    ELSIF VP_PRODUCTO = 2 THEN
      VP_TABLA := 'GA_INTARBEEP';
      VP_ACT := 'S';
      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARBEEP
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADCF;
         V_INDCAR := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDCAR := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDCAR := 1;
         WHEN OTHERS THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
      END;
      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARBEEP
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADLL;
         V_INDLLA := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDLLA := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDLLA := 1;
         WHEN OTHERS THEN
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
      END;
      IF V_INDCAR = 0 AND V_INDLLA = 0 THEN
         BEGIN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'S';
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARBEEP
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND NVL(FEC_HASTA,VP_FECSYS)
               AND ROWNUM = 1;
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDLLA <> 0 THEN
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         UPDATE GA_INTARBEEP
            SET COD_PLANCOM = VP_PLANCOM
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE >= V_FECHADLL;
         VP_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF V_INDCAR <> 0 THEN
            IF V_FECHADLL >= V_FECHADCF THEN
               V_FECHA := V_FECHADCF;
            ELSE
               V_FECHA := V_FECHAD;
            END IF;
      END IF;
      VP_TABLA := 'GA_INTARBEEP';
      VP_ACT := 'S';
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
             FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
             IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,
             CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,
             COD_CICLO,COD_PLANCOM,COD_PLANSERV,
             COD_GRPSERV,COD_GRUPO
        INTO V_ROWID,V_CLIENTE,V_ABONADO,
             V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
             V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,
             V_CAPCODE,V_BEEPER,V_CARGOBASICO,
             V_CICLO,V_PLANCOM,V_PLANSERV,
             V_GRPSERV,V_GRUPO
        FROM GA_INTARBEEP
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND FEC_DESDE = V_FECHA;
      IF V_FECHA = V_FECHADCF THEN
         IF V_FECHADCF = V_FECHADLL THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
               SET COD_PLANCOM = VP_PLANCOM
             WHERE ROWID = V_ROWID;
         ELSIF V_FECHADCF < V_FECHADLL THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
               SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
             WHERE ROWID = V_ROWID;
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                        V_BEEPER,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         UPDATE GA_INTARBEEP
            SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
          WHERE ROWID = V_ROWID;
         IF V_INDCAR <> 0 THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHADCF - (1/(24*60*60)),V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                        V_BEEPER,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
               SET COD_PLANCOM = VP_PLANCOM
             WHERE COD_CLIENTE = V_CLIENTE
               AND NUM_ABONADO = V_ABONADO
               AND FEC_DESDE = V_FECHADCF;
         ELSE
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                        V_BEEPER,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
         END IF;
      END IF;
    ELSIF VP_PRODUCTO = 3 THEN
      VP_TABLA := 'GA_INTARTRUNK';
      VP_ACT := 'S';
      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARTRUNK
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADCF;
         V_INDCAR := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDCAR := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDCAR := 1;
         WHEN OTHERS THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
      END;
      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARTRUNK
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADLL;
         V_INDLLA := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDLLA := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDLLA := 1;
         WHEN OTHERS THEN
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
      END;
      IF V_INDCAR = 0 AND V_INDLLA = 0 THEN
         BEGIN
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'S';
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARTRUNK
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND NVL(FEC_HASTA,VP_FECSYS)
               AND ROWNUM = 1;
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDLLA <> 0 THEN
         VP_TABLA := 'GA_INTARTRUNK';
         VP_ACT := 'U';
         UPDATE GA_INTARTRUNK
            SET COD_PLANCOM = VP_PLANCOM
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE >= V_FECHADLL;
         VP_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF V_INDCAR <> 0 THEN
            IF V_FECHADLL >= V_FECHADCF THEN
               V_FECHA := V_FECHADCF;
            ELSE
               V_FECHA := V_FECHAD;
            END IF;
      END IF;
      VP_TABLA := 'GA_INTARTRUNK';
      VP_ACT := 'S';
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
             FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
             IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,
             NUM_SERIE,NUM_RADIO,COD_CARGOBASICO,
             COD_CICLO,COD_PLANCOM,COD_PLANSERV,
             COD_GRPSERV,COD_GRUPO
        INTO V_ROWID,V_CLIENTE,V_ABONADO,
             V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
             V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,
             V_SERIETRUNK,V_RADIO,V_CARGOBASICO,
             V_CICLO,V_PLANCOM,V_PLANSERV,
             V_GRPSERV,V_GRUPO
        FROM GA_INTARTRUNK
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND FEC_DESDE = V_FECHA;
      IF V_FECHA = V_FECHADCF THEN
         IF V_FECHADCF = V_FECHADLL THEN
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'U';
            UPDATE GA_INTARTRUNK
               SET COD_PLANCOM = VP_PLANCOM
             WHERE ROWID = V_ROWID;
         ELSIF V_FECHADCF < V_FECHADLL THEN
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'U';
            UPDATE GA_INTARTRUNK
               SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
             WHERE ROWID = V_ROWID;
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTRUNK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                        NUM_RADIO,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_SERIETRUNK,
                        V_RADIO,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARTRUNK';
         VP_ACT := 'U';
         UPDATE GA_INTARTRUNK
            SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
          WHERE ROWID = V_ROWID;
         IF V_INDCAR <> 0 THEN
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTRUNK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                        NUM_RADIO,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHADCF - (1/(24*60*60)),V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_SERIETRUNK,
                        V_RADIO,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'U';
            UPDATE GA_INTARTRUNK
               SET COD_PLANCOM = VP_PLANCOM
             WHERE COD_CLIENTE = V_CLIENTE
               AND NUM_ABONADO = V_ABONADO
               AND FEC_DESDE = V_FECHADCF;
        ELSE
            VP_TABLA := 'GA_INTARTRUNK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTRUNK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                        NUM_RADIO,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_SERIETRUNK,
                        V_RADIO,V_CARGOBASICO,V_CICLO,
                        VP_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO);
         END IF;
      END IF;
    ELSIF VP_PRODUCTO = 4 THEN
      VP_TABLA := 'GA_INTARTREK';
      VP_ACT := 'S';
      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARTREK
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADCF;
         V_INDCAR := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDCAR := 0;
         WHEN TOO_MANY_ROWS THEN
       V_INDCAR := 1;
         WHEN OTHERS THEN
       VP_ERROR := '4';
       RAISE ERROR_PROCESO;
      END;
      BEGIN
         VP_TABLA := 'GA_INTARTREK';
         VP_ACT := 'S';
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARTREK
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE   = V_FECHADLL;
         V_INDLLA := 1;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
       V_INDLLA := 0;
         WHEN TOO_MANY_ROWS THEN
              V_INDCAR := 1;
         WHEN OTHERS THEN
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
      END;
      IF V_INDCAR = 0 AND V_INDLLA = 0 THEN
         BEGIN
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'S';
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARTREK
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND NVL(FEC_HASTA,VP_FECSYS)
               AND ROWNUM = 1;
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDLLA <> 0 THEN
         VP_TABLA := 'GA_INTARTREK';
         VP_ACT := 'U';
         UPDATE GA_INTARTREK
            SET COD_PLANCOM = VP_PLANCOM
          WHERE COD_CLIENTE = VP_CLIENTE
            AND NUM_ABONADO = VP_ABONADO
            AND FEC_DESDE >= V_FECHADLL;
         VP_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF V_INDCAR <> 0 THEN
            IF V_FECHADLL >= V_FECHADCF THEN
               V_FECHA := V_FECHADCF;
            ELSE
               V_FECHA := V_FECHAD;
            END IF;
      END IF;
      VP_TABLA := 'GA_INTARTREK';
      VP_ACT := 'S';
      SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
             FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
             IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,
             NUM_MAN,COD_CARGOBASICO,COD_CICLO,
             COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
             NUM_SERIE,COD_GRUPO
        INTO V_ROWID,V_CLIENTE,V_ABONADO,
             V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
             V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,
             V_MAN,V_CARGOBASICO,V_CICLO,
             V_PLANCOM,V_PLANSERV,V_GRPSERV,
             V_SERIETREK,V_GRUPO
        FROM GA_INTARTREK
       WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND FEC_DESDE = V_FECHA;
      IF V_FECHA = V_FECHADCF THEN
         IF V_FECHADCF = V_FECHADLL THEN
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'U';
            UPDATE GA_INTARTREK
               SET COD_PLANCOM = VP_PLANCOM
             WHERE ROWID = V_ROWID;
         ELSIF V_FECHADCF < V_FECHADLL THEN
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'U';
            UPDATE GA_INTARTREK
               SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
             WHERE ROWID = V_ROWID;
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTREK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_MAN,
                        COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,
                        COD_PLANSERV,COD_GRPSERV,NUM_SERIE,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_MAN,
                        V_CARGOBASICO,V_CICLO,VP_PLANCOM,
                        V_PLANSERV,V_GRPSERV,V_SERIETREK,
                        V_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARTREK';
         VP_ACT := 'U';
         UPDATE GA_INTARTREK
            SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
          WHERE ROWID = V_ROWID;
         IF V_INDCAR <> 0 THEN
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTREK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_MAN,
                        COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,
                        COD_PLANSERV,COD_GRPSERV,NUM_SERIE,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHADCF - (1/(24*60*60)),V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_MAN,
                        V_CARGOBASICO,V_CICLO,VP_PLANCOM,
                        V_PLANSERV,V_GRPSERV,V_SERIETREK,
                        V_GRUPO);
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'U';
            UPDATE GA_INTARTREK
               SET COD_PLANCOM = VP_PLANCOM
             WHERE COD_CLIENTE = V_CLIENTE
               AND NUM_ABONADO = V_ABONADO
               AND FEC_DESDE = V_FECHADCF;
         ELSE
            VP_TABLA := 'GA_INTARTREK';
            VP_ACT := 'I';
            INSERT INTO GA_INTARTREK
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,NUM_MAN,
                        COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,
                        COD_PLANSERV,COD_GRPSERV,NUM_SERIE,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        V_TIPPLANTARIF,V_PLANTARIF,V_MAN,
                        V_CARGOBASICO,V_CICLO,V_PLANCOM,
                        V_PLANSERV,V_GRPSERV,V_SERIETREK,
                        V_GRUPO);
         END IF;
      END IF;
    END IF;
    VP_ERROR := '0';
    RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
 IF VP_ERROR = '0' THEN
           BEGIN
              VP_TABLA := 'GA_CLIENTE_PCOM';
              VP_ACT := 'S';
              SELECT COD_PLANCOM,FEC_DESDE
         INTO V_NEXTPC,V_NEXTFEC
         FROM GA_CLIENTE_PCOM
               WHERE COD_CLIENTE = VP_CLIENTE
          AND FEC_DESDE > VP_FECSYS;
              IF VP_PLANCOM <> V_NEXTPC OR (V_FECHADLL < V_NEXTFEC) THEN
                 VP_TABLA := 'GA_CLIENTE_PCOM';
                 VP_ACT := 'U';
                 UPDATE GA_CLIENTE_PCOM
             SET COD_PLANCOM = VP_PLANCOM,
                 FEC_DESDE = V_FECHADLL
                  WHERE COD_CLIENTE = VP_CLIENTE
             AND FEC_DESDE > VP_FECSYS;
                 UPDATE GA_CLIENTE_PCOM
                    SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
                  WHERE COD_CLIENTE = VP_CLIENTE
             AND VP_FECSYS BETWEEN FEC_DESDE
                 AND NVL(FEC_HASTA,VP_FECSYS);
              END IF;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   VP_TABLA := 'GA_CLIENTE_PCOM';
                   VP_ACT := 'I';
            INSERT INTO GA_CLIENTE_PCOM
                (COD_CLIENTE,COD_PLANCOM,FEC_DESDE,
          NOM_USUARORA,FEC_HASTA)
                       VALUES (VP_CLIENTE,VP_PLANCOM,V_FECHADLL,
          USER,TO_DATE('31-12-3000','DD-MM-YYYY'));
                   VP_TABLA := 'GA_CLIENTE_PCOM';
                   VP_ACT := 'U';
                   UPDATE GA_CLIENTE_PCOM
                      SET FEC_HASTA = V_FECHADLL - (1/(24*60*60))
                    WHERE COD_CLIENTE = VP_CLIENTE
               AND VP_FECSYS BETWEEN FEC_DESDE
            AND NVL(FEC_HASTA,VP_FECSYS);
              WHEN OTHERS THEN
            VP_ERROR := '4';
     VP_SQLCODE := SQLCODE;
     VP_SQLERRM := SQLERRM;
           END;
        ELSE
    IF VP_SQLCODE IS NULL THEN
       VP_SQLCODE := SQLCODE;
       VP_SQLERRM := SQLERRM;
           END IF;
        END IF;
   WHEN OTHERS THEN
 IF VP_SQLCODE IS NULL THEN
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
           VP_ERROR := '4';
        END IF;
END;
/
SHOW ERRORS
