CREATE OR REPLACE procedure        P_PLAN_TARIFARIO
(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_TIPPLAN IN VARCHAR2 ,
  VP_PLANTARIF IN VARCHAR2 ,
  VP_CICLO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_EMPRESA IN NUMBER ,
  VP_HOLDING IN NUMBER ,
  VP_TIPPLANTANT IN VARCHAR2 ,
  VP_GRUPO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- *************************************************************
-- * procedimiento      : P_PLAN_TARIFARIO
-- * Descripcisn        : Procedimiento que refleja el cambio y efectividad del nuevo plan tarifario
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  :
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
   V_ROWID CHAR(18);
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
   V_SERIE_DEC GA_ABOCEL.NUM_SERIE%TYPE;
   V_SERIETRUNK GA_INTARTRUNK.NUM_SERIE%TYPE;
   V_SERIETREK GA_INTARTREK.NUM_SERIE%TYPE;
   V_CELULAR GA_INTARCEL.NUM_CELULAR%TYPE;
   V_CARGOBASICO GA_INTARCEL.COD_CARGOBASICO%TYPE;
   VP_CARGOBASICO GA_INTARCEL.COD_CARGOBASICO%TYPE;
   V_CICLO GA_INTARCEL.COD_CICLO%TYPE;
   V_PLANCOM GA_INTARCEL.COD_PLANCOM%TYPE;
   V_PLANSERV GA_INTARCEL.COD_PLANSERV%TYPE;
   V_GRPSERV GA_INTARCEL.COD_GRPSERV%TYPE;
   V_GRUPO GA_INTARCEL.COD_GRUPO%TYPE;
   VAR_GRUPO GA_INTARCEL.COD_GRUPO%TYPE;
   V_PORTADOR GA_INTARCEL.COD_PORTADOR%TYPE;
   V_CAPCODE GA_INTARBEEP.CAP_CODE%TYPE;
   V_BEEPER GA_INTARBEEP.NUM_BEEPER%TYPE;
   V_RADIO GA_INTARTRUNK.NUM_RADIO%TYPE;
   V_MAN GA_INTARTREK.NUM_MAN%TYPE;
   V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
   V_PLANTANT GA_FINCICLO.TIP_PLANTANT%TYPE := NULL;
   V_GRUPANT GA_FINCICLO.COD_GRUPANT%TYPE := NULL;
   VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
   V_DIAS TA_PLANTARIF.NUM_DIAS%TYPE;
   V_USO GA_INTARCEL.COD_USO%TYPE;
   AUX NUMBER;
   FEC_AUX DATE;
   V_NUM_IMSI GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;

   ERROR_PROCESO EXCEPTION;

   vErrorAplic VARCHAR2(100);
   vErrorGlosa VARCHAR2(100);
   vErrorOra VARCHAR2(100);
   vErrorOraGlosa VARCHAR2(100);
   vTrace VARCHAR2(100);

BEGIN
   VP_PROC := 'P_PLAN_TARIFARIO';
   BEGIN
      VP_TABLA := 'FA_CICLFACT';
      VP_ACT := 'S';
      AUX := 0;

      --INI.MAM PH-200403240059 05.05.2004
      --se modifica la consulta sacando el = de la condicion AND TRUNC(VP_FECSYS) <= TRUNC(FEC_DESDELLAM)
      SELECT MIN(FEC_DESDELLAM)
        INTO V_FECHADCF
        FROM FA_CICLFACT
       WHERE COD_CICLO = VP_CICLO
         AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
         AND IND_FACTURACION = AUX ;
       SELECT FEC_DESDELLAM,COD_CICLFACT
        INTO V_FECHADLL,V_CICLFACT
        FROM FA_CICLFACT
       WHERE COD_CICLO = VP_CICLO
         AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
         AND IND_FACTURACION = AUX
         AND ROWNUM = 1;
      --FIN.MAM PH-200403240059 05.05.2004

      VP_TABLA := 'TA_PLANTARIF';
      VP_ACT := 'S';
      SELECT NUM_DIAS,COD_CARGOBASICO
      INTO V_DIAS,VP_CARGOBASICO
      FROM TA_PLANTARIF
      WHERE COD_PRODUCTO = VP_PRODUCTO AND COD_PLANTARIF = VP_PLANTARIF;
   EXCEPTION
      WHEN OTHERS THEN
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
   END;
   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_INTARCEL';

		  -- INI TMM_04026
        V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM'); --GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');
        -- FIN TMM_04026

        IF VP_ABONADO <> 0 THEN
                SELECT NUM_SERIE, COD_TECNOLOGIA
                  INTO V_SERIE_DEC, V_TECNOLOGIA
                  FROM GA_ABOCEL
                 WHERE NUM_ABONADO = VP_ABONADO;

					 --INI TMM_04026
                IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
                --FIN TMM_04026
                        SELECT FRECUPERSIMCARD_FN(V_SERIE_DEC, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
                END IF;
        END IF;

      BEGIN
         SELECT NUM_ABONADO
           INTO VAR1
           FROM GA_INTARCEL
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
           FROM GA_INTARCEL
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
            AUX := 1;
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARCEL
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND FEC_HASTA
               AND ROWNUM = AUX;
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDLLA <> 0 THEN
         VP_ACT := 'U';
         IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
            VAR_GRUPO := VP_GRUPO;
         ELSIF VP_TIPPLAN = 'I' THEN
               VAR_GRUPO := NULL;
         END IF;
         UPDATE GA_INTARCEL
         SET TIP_PLANTARIF = VP_TIPPLAN,
             COD_PLANTARIF = VP_PLANTARIF,
             COD_CARGOBASICO = VP_CARGOBASICO,
             COD_GRUPO = VAR_GRUPO,
             NUM_IMSI = V_NUM_IMSI
         WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND FEC_DESDE >= V_FECHADCF;
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
         IF V_FECHA = V_FECHADCF THEN
            IF V_FECHADCF = V_FECHADLL THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
               ELSIF VP_TIPPLAN = 'I' THEN
                     VAR_GRUPO := NULL;
               END IF;
               UPDATE GA_INTARCEL
                  SET TIP_PLANTARIF = VP_TIPPLAN,
                      COD_PLANTARIF = VP_PLANTARIF,
                      COD_CARGOBASICO = VP_CARGOBASICO,
                      COD_GRUPO = VAR_GRUPO,NUM_IMSI=V_NUM_IMSI
                WHERE ROWID = V_ROWID;
            ELSIF V_FECHADCF < V_FECHADLL THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
               ELSIF VP_TIPPLAN = 'I' THEN
                     VAR_GRUPO := NULL;
               END IF;
               FEC_AUX := V_FECHADLL - (1/(24*60*60));
               UPDATE GA_INTARCEL
                  SET FEC_HASTA = FEC_AUX
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
                   VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHASTA,V_LIMCONSUMO,
                           V_FRIENDS,V_DIASESP,V_CELDA,
                           VP_TIPPLAN,VP_PLANTARIF,V_SERIE,
                           V_CELULAR,VP_CARGOBASICO,V_CICLO,
                           V_PLANCOM,V_PLANSERV,V_GRPSERV,VAR_GRUPO,
                           V_PORTADOR,V_USO,V_NUM_IMSI);

                                PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                        V_NUMERO,
                                                        'CT',
                                                        V_FECHADLL,
                                                        vErrorAplic,
                                                        vErrorGlosa,
                                                        vErrorOra,
                                                        vErrorOraGlosa,
                                                        vTrace);
                        IF vErrorAplic = 'FALSE'
                        THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                        END IF;

            END IF;
         ELSE
            VP_TABLA := 'GA_INTARCEL';
            VP_ACT := 'U';
            FEC_AUX := V_FECHADLL - (1/(24*60*60));
            UPDATE GA_INTARCEL
               SET FEC_HASTA = FEC_AUX
             WHERE ROWID = V_ROWID;
            IF V_INDCAR <> 0 THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
               ELSIF VP_TIPPLAN = 'I' THEN
                     VAR_GRUPO := NULL;
               END IF;
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
                           VP_TIPPLAN,VP_PLANTARIF,V_SERIE,
                           V_CELULAR,VP_CARGOBASICO,V_CICLO,
                           V_PLANCOM,V_PLANSERV,V_GRPSERV,
                           VAR_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);

                                PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                        V_NUMERO,
                                                        'CT',
                                                        V_FECHADLL,
                                                        vErrorAplic,
                                                        vErrorGlosa,
                                                        vErrorOra,
                                                        vErrorOraGlosa,
                                                        vTrace);
                        IF vErrorAplic = 'FALSE'
                        THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                        END IF;

               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               UPDATE GA_INTARCEL
                  SET TIP_PLANTARIF = VP_TIPPLAN,
                      COD_PLANTARIF = VP_PLANTARIF,
                      COD_CARGOBASICO = VP_CARGOBASICO,
                      COD_GRUPO = VAR_GRUPO,NUM_IMSI = V_NUM_IMSI
                  WHERE COD_CLIENTE = V_CLIENTE
                  AND NUM_ABONADO = V_ABONADO
                  AND FEC_DESDE = V_FECHADCF;
            ELSE
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
               ELSIF VP_TIPPLAN = 'I' THEN
                     VAR_GRUPO := NULL;
               END IF;
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
                           VP_TIPPLAN,VP_PLANTARIF,V_SERIE,
                           V_CELULAR,VP_CARGOBASICO,V_CICLO,
                           V_PLANCOM,V_PLANSERV,V_GRPSERV,VAR_GRUPO,
                           V_PORTADOR,V_USO,V_NUM_IMSI);

                                PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                        V_NUMERO,
                                                        'CT',
                                                        V_FECHADLL,
                                                        vErrorAplic,
                                                        vErrorGlosa,
                                                        vErrorOra,
                                                        vErrorOraGlosa,
                                                        vTrace);

                        IF vErrorAplic = 'FALSE'
                        THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                        END IF;
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
            SELECT FEC_DESDE
              INTO V_FECHAD
              FROM GA_INTARBEEP
             WHERE COD_CLIENTE = VP_CLIENTE
               AND NUM_ABONADO = VP_ABONADO
               AND VP_FECSYS BETWEEN FEC_DESDE
                                 AND FEC_HASTA
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
         IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
         ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
         END IF;
         UPDATE GA_INTARBEEP
            SET TIP_PLANTARIF = VP_TIPPLAN,
                COD_PLANTARIF = VP_PLANTARIF,
                COD_GRUPO = VAR_GRUPO
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
            IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
            ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
            END IF;
            UPDATE GA_INTARBEEP
               SET TIP_PLANTARIF = VP_TIPPLAN,
                   COD_PLANTARIF = VP_PLANTARIF,
                   COD_GRUPO = VAR_GRUPO
             WHERE ROWID = V_ROWID;
         ELSIF V_FECHADCF < V_FECHADLL THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            SELECT NUM_DIAS,COD_CARGOBASICO
            INTO V_DIAS,VP_CARGOBASICO
            FROM TA_PLANTARIF
            WHERE COD_PRODUCTO = VP_PRODUCTO AND COD_PLANTARIF = VP_PLANTARIF;
            FEC_AUX := V_FECHADLL - (1/(24*60*60));
            UPDATE GA_INTARBEEP
               SET FEC_HASTA = FEC_AUX
             WHERE ROWID = V_ROWID;
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
            ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        VP_TIPPLAN,VP_PLANTARIF,V_CAPCODE,
                        V_BEEPER,V_CARGOBASICO,V_CICLO,
                        V_PLANCOM,V_PLANSERV,V_GRPSERV,VAR_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         FEC_AUX :=  V_FECHADLL - (1/(24*60*60));
         UPDATE GA_INTARBEEP
            SET FEC_HASTA = FEC_AUX
          WHERE ROWID = V_ROWID;
         IF V_INDCAR <> 0 THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
            ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHADCF - (1/(24*60*60)),V_LIMCONSUMO,V_DIASESP,
                        VP_TIPPLAN,VP_PLANTARIF,V_CAPCODE,
                        V_BEEPER,V_CARGOBASICO,V_CICLO,
                        V_PLANCOM,V_PLANSERV,V_GRPSERV,VAR_GRUPO);
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
               SET TIP_PLANTARIF = VP_TIPPLAN,
                   COD_PLANTARIF = VP_PLANTARIF,
                   COD_CARGOBASICO = VP_CARGOBASICO,
                   COD_GRUPO = VAR_GRUPO
             WHERE COD_CLIENTE = V_CLIENTE
               AND NUM_ABONADO = V_ABONADO
               AND FEC_DESDE = V_FECHADCF;
         ELSE
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
            ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
            END IF;
            INSERT INTO GA_INTARBEEP
                       (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                        FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                        NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                        COD_GRUPO)
                VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                        V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                        VP_TIPPLAN,VP_PLANTARIF,V_CAPCODE,
                        V_BEEPER,VP_CARGOBASICO,V_CICLO,
                        V_PLANCOM,V_PLANSERV,V_GRPSERV,VAR_GRUPO);
         END IF;
      END IF;
  END IF;
    IF VP_TIPPLANTANT = 'H' THEN
       IF VP_TIPPLANTANT <> VP_TIPPLAN THEN
          IF VP_TIPPLANTANT <> 'I' THEN
             V_PLANTANT := VP_TIPPLANTANT;
             V_GRUPANT := VP_EMPRESA;
          END IF;
       ELSE
           IF VP_GRUPO <> VP_HOLDING THEN
              V_PLANTANT := VP_TIPPLANTANT;
              V_GRUPANT := VP_HOLDING;
           ELSE
              V_PLANTANT := NULL;
              V_GRUPANT := NULL;
           END IF;
       END IF;
   ELSIF VP_TIPPLANTANT = 'E' THEN
      IF VP_TIPPLANTANT <> VP_TIPPLAN THEN
         IF VP_TIPPLANTANT <> 'I' THEN
            V_PLANTANT := VP_TIPPLANTANT;
            V_GRUPANT := VP_HOLDING;
         END IF;
      ELSE
         IF VP_GRUPO <> VP_HOLDING THEN
            V_PLANTANT := VP_TIPPLANTANT;
            V_GRUPANT := VP_EMPRESA;
         ELSE
            V_PLANTANT := NULL;
            V_GRUPANT := NULL;
         END IF;
      END IF;
   END IF;
   VP_ERROR := '0';
   RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        IF VP_ERROR = '0' THEN
           BEGIN
              VP_TABLA := 'GA_FINCICLO';
              VP_ACT := 'S';
              SELECT ROWID
                INTO V_ROWID
                FROM GA_FINCICLO
               WHERE COD_CLIENTE = VP_CLIENTE
                 AND NUM_ABONADO = VP_ABONADO
                 AND COD_CICLFACT = V_CICLFACT;
              VP_TABLA := 'GA_FINCICLO';
              VP_ACT := 'U';
              IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                  VAR_GRUPO := VP_GRUPO;
              ELSIF VP_TIPPLAN = 'I' THEN
                  VAR_GRUPO := NULL;
              END IF;
              UPDATE GA_FINCICLO
                 SET TIP_PLANTARIF = VP_TIPPLAN,
                     COD_PLANTARIF = VP_PLANTARIF,
                     COD_CARGOBASICO = VP_CARGOBASICO,
                     COD_GRUPO = VAR_GRUPO,
                     FEC_DESDELLAM = DECODE(FEC_DESDELLAM,NULL,V_FECHADLL,
                                            FEC_DESDELLAM),
                     TIP_PLANTANT = V_PLANTANT,
                     COD_GRUPANT = V_GRUPANT,
                     NUM_DIAS = V_DIAS
                 WHERE ROWID = V_ROWID;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   VP_TABLA := 'GA_FINCICLO';
                   VP_ACT := 'I';
                   IF VP_TIPPLAN = 'E' OR VP_TIPPLAN = 'H' THEN
                      VAR_GRUPO := VP_GRUPO;
                   ELSIF VP_TIPPLAN = 'I' THEN
                      VAR_GRUPO := NULL;
                   END IF;
                   INSERT INTO GA_FINCICLO (COD_CLIENTE,
                                            COD_CICLFACT,
                                            NUM_ABONADO,
                                            COD_PRODUCTO,
                                            TIP_PLANTARIF,
                                            COD_PLANTARIF,
                                            COD_CARGOBASICO,
                                            COD_GRUPO,
                                            FEC_DESDELLAM,
                                            TIP_PLANTANT,
                                            COD_GRUPANT,
                                            NUM_DIAS)
                                    VALUES (VP_CLIENTE,
                                            V_CICLFACT,
                                            VP_ABONADO,
                                            VP_PRODUCTO,
                                            VP_TIPPLAN,
                                            VP_PLANTARIF,VP_CARGOBASICO,
                                            VAR_GRUPO,
                                            V_FECHADLL,
                                            V_PLANTANT,
                                            V_GRUPANT,
                                            V_DIAS);
              WHEN OTHERS THEN
     VP_SQLCODE := SQLCODE;
     VP_SQLERRM := SQLERRM;
                   VP_ERROR := '4';
           END;
     ELSE
        IF VP_ERROR = '4' THEN
       		VP_SQLCODE := SQLCODE;
       		VP_SQLERRM := SQLERRM;
       		VP_ERROR := '4';
    	ELSE
           IF VP_SQLCODE IS NULL THEN
              VP_SQLCODE := SQLCODE;
              VP_SQLERRM := SQLERRM;
           END IF;
        END IF;
     END IF;
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
