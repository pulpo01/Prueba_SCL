CREATE OR REPLACE procedure        P_CAMBIO_CICLO
(VP_PRODUCTO IN NUMBER,
                         VP_CLIENTE IN NUMBER,
                         VP_ABONADO IN NUMBER,
                         VP_CICLONUE IN NUMBER,
                         VP_CICLOANT IN NUMBER,
                         VP_FECSYS IN DATE,
                         VP_PROC IN OUT VARCHAR2,
                         VP_TABLA IN OUT VARCHAR2,
                         VP_ACT IN OUT VARCHAR2,
                         VP_SQLCODE IN OUT VARCHAR2,
                         VP_SQLERRM IN OUT VARCHAR2,
                         VP_ERROR IN OUT VARCHAR2)
IS
--
-- *************************************************************
-- * procedimiento      : P_CAMBIO_CICLO
-- * Descripcisn        : Procedimiento que refleja el cambio y efectividad del ciclo de facturacion
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  :
-- * Responsable        : CRM
-- *************************************************************
--
--
   V_FECHADCF GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHADLL GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHAD GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHA GA_INTARCEL.FEC_DESDE%TYPE;
   V_FEC_SOL GA_INTARCEL.FEC_DESDE%TYPE; -- XO-200508180393 - 26/08/2005 - JJR.-
   V_ROWID ROWID;
   V_INDCAR NUMBER(1) := 0;
   V_INDLLA NUMBER(1) := 0;
   V_FEC_DESDE2 GA_INTARCEL.FEC_DESDE%TYPE;
   V_FILA2 ROWID;
   V_PLANTARIF2 GA_ABOCEL.TIP_PLANTARIF%TYPE;
   V_COD_PLANTARIF2 GA_ABOCEL.COD_PLANTARIF%TYPE;
   V_FEC_HASTA2 GA_INTARCEL.FEC_HASTA%TYPE;
   V_CELULAR2   GA_ABOCEL.NUM_CELULAR%TYPE;
   V_COD_CARGOBASICO2  GA_ABOCEL.COD_CARGOBASICO%TYPE;
   V_USO                           GA_INTARCEL.COD_USO%TYPE;
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
   V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
   V_FECHA_AUX DATE;
   VAR1 GA_ABOCEL.NUM_ABONADO%TYPE;
   IND_FACTUR NUMBER;
   IND_ROWNUM NUMBER;
   V_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
   V_NUM_IMSI  GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   ERROR_PROCESO EXCEPTION;

   vErrorAplic VARCHAR2(100);
   vErrorGlosa VARCHAR2(100);
   vErrorOra VARCHAR2(100);
   vErrorOraGlosa VARCHAR2(100);
   vTrace VARCHAR2(100);

BEGIN
   VP_PROC := 'P_CAMBIO_CICLO';
   BEGIN

      VP_TABLA := 'FA_CICLFACT';
      VP_ACT := 'S';
      IND_FACTUR := 0;

	  --Grupo GSM
	  -- INI TMM_04026
 	  V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
	  -- FIN TMM_04026
      IF VP_ABONADO <> 0 THEN
	     SELECT NUM_SERIE, COD_TECNOLOGIA
	     INTO  V_NUM_SERIE, V_TECNOLOGIA
	     FROM  GA_ABOCEL
	     WHERE NUM_ABONADO = VP_ABONADO;

	     -- INI TMM_04026
	     IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
	     -- FIN TMM_04026
	          SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
	     END IF;
      ELSE
      	 V_NUM_IMSI := '';
      END IF;


       --INI.MAM PH-200403240059 05.05.2004
       --se modifica la consulta sacando el = de la condicion AND TRUNC(VP_FECSYS) <= TRUNC(FEC_DESDELLAM)

	    SELECT MIN(FEC_DESDELLAM) INTO V_FECHADCF
        FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLOANT
           AND TRUNC(sysdate) < TRUNC(FEC_DESDELLAM)
           AND IND_FACTURACION = IND_FACTUR;

        SELECT FEC_DESDELLAM,COD_CICLFACT INTO V_FECHADLL,V_CICLFACT
        FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLOANT
           AND TRUNC(sysdate) < TRUNC(FEC_DESDELLAM)
           AND IND_FACTURACION = IND_FACTUR
           AND FEC_DESDELLAM= V_FECHADCF;

		/*
        SELECT MIN(FEC_DESDELLAM) INTO V_FECHADCF
        FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLOANT
           AND TRUNC(sysdate) <= TRUNC(FEC_DESDELLAM)
           AND IND_FACTURACION = IND_FACTUR;

        SELECT FEC_DESDELLAM,COD_CICLFACT INTO V_FECHADLL,V_CICLFACT
        FROM FA_CICLFACT
        WHERE COD_CICLO = VP_CICLOANT
           AND TRUNC(sysdate) <= TRUNC(FEC_DESDELLAM)
           AND IND_FACTURACION = IND_FACTUR
           AND FEC_DESDELLAM= V_FECHADCF;		*/

	--FIN.MAM PH-200403240059 05.05.2004

   EXCEPTION
     WHEN OTHERS THEN
              VP_ERROR := '4';
              RAISE ERROR_PROCESO;
   END;
   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'S';
      BEGIN
         SELECT NUM_ABONADO INTO VAR1
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
         SELECT NUM_ABONADO INTO VAR1
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
        VP_TABLA := 'GA_INTARCEL';
        VP_ACT := 'S';
        IND_ROWNUM := 1;
        SELECT FEC_DESDE INTO V_FECHAD
        FROM GA_INTARCEL
        WHERE COD_CLIENTE = VP_CLIENTE
              AND NUM_ABONADO = VP_ABONADO
              AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA
              AND ROWNUM = IND_ROWNUM;
        V_FECHA := V_FECHAD;
     EXCEPTION
        WHEN OTHERS THEN
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
     END;
     ELSIF V_INDLLA <> 0 THEN
        VP_TABLA := 'GA_INTARCEL';
        VP_ACT := 'U';
        UPDATE GA_INTARCEL
        SET COD_CICLO = VP_CICLONUE, NUM_IMSI = V_NUM_IMSI
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
                  UPDATE GA_INTARCEL
                  SET COD_CICLO = VP_CICLONUE
                  WHERE ROWID = V_ROWID;
               ELSIF V_FECHADCF < V_FECHADLL THEN
                     VP_TABLA := 'GA_INTARCEL';
                     VP_ACT := 'U';
                     V_FECHA_AUX := V_FECHADLL - (1/(24*60*60));
                     UPDATE GA_INTARCEL
                     SET FEC_HASTA = V_FECHA_AUX
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
                      COD_GRUPO,COD_PORTADOR,COD_USO, NUM_IMSI)
                      VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                      V_FECHADLL,V_FECHASTA,V_LIMCONSUMO,
                      V_FRIENDS,V_DIASESP,V_CELDA,
                      V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                      V_CELULAR,V_CARGOBASICO,VP_CICLONUE,
                      V_PLANCOM,V_PLANSERV,V_GRPSERV,
                      V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);

                                          PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                                      V_ABONADO,
                                                                                                  V_NUMERO,
                                                                                                  'CL',
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
            BEGIN

                V_FEC_SOL :=  TRUNC(V_FECHA+1); -- XO-200508180393 - 26/08/2005 - JJR.-

                SELECT ROWID, FEC_DESDE,FEC_HASTA,TIP_PLANTARIF,COD_PLANTARIF,NUM_CELULAR,COD_CARGOBASICO,COD_USO
                INTO V_FILA2, V_FEC_DESDE2,V_FEC_HASTA2,V_PLANTARIF2,V_COD_PLANTARIF2,V_CELULAR2,
                     V_COD_CARGOBASICO2,V_USO
                FROM GA_INTARCEL
                WHERE COD_CLIENTE=V_CLIENTE
                AND NUM_ABONADO=V_ABONADO
                AND TRUNC(FEC_DESDE) BETWEEN V_FEC_SOL  AND V_FECHADCF; -- XO-200508180393 - 26/08/2005 - JJR.-
--              AND TRUNC(FEC_DESDE) BETWEEN to_date(V_FECHA,'dd-mon-yy')+1  AND V_FECHADCF; -- XO-200508180393 - 26/08/2005 - JJR.-
                V_FECHA:=V_FEC_DESDE2;
                V_ROWID:=V_FILA2;
                V_TIPPLANTARIF:=V_PLANTARIF2;
                V_PLANTARIF:=V_COD_PLANTARIF2;
                V_FECHASTA:=V_FEC_HASTA2;
                V_CELULAR:=V_CELULAR2;
                V_CARGOBASICO:=V_COD_CARGOBASICO2;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NULL;
            END;
            VP_TABLA := 'GA_INTARCEL';
            VP_ACT := 'U';
            V_FECHA_AUX := V_FECHADLL - (1/(24*60*60));
            UPDATE GA_INTARCEL
               SET FEC_HASTA = V_FECHA_AUX
             WHERE ROWID = V_ROWID;
            IF V_INDCAR <> 0 THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               V_FECHA_AUX := V_FECHADCF - (1/(24*60*60));
               INSERT INTO GA_INTARCEL
                          (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                           FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                           IND_FRIENDS,IND_DIASESP,COD_CELDA,
                           TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                           NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                           COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                           COD_GRUPO,COD_PORTADOR,COD_USO, NUM_IMSI)
                VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHA_AUX,
                           V_LIMCONSUMO,V_FRIENDS,V_DIASESP,V_CELDA,
                           V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CARGOBASICO,VP_CICLONUE,
                           V_PLANCOM,V_PLANSERV,V_GRPSERV,
                           V_GRUPO,V_PORTADOR,V_USO, V_NUM_IMSI);

                                PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                      V_ABONADO,
                                                                                  V_NUMERO,
                                                                                  'CL',
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
                  SET COD_CICLO = VP_CICLONUE,NUM_IMSI =   V_NUM_IMSI
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
                           COD_GRUPO,COD_PORTADOR,COD_USO, NUM_IMSI)
                   VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                           V_FECHADLL,V_FECHASTA,V_LIMCONSUMO,
                           V_FRIENDS,V_DIASESP,V_CELDA,
                           V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                           V_CELULAR,V_CARGOBASICO,VP_CICLONUE,
                           V_PLANCOM,V_PLANSERV,V_GRPSERV,
                           V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);

                        PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                    V_ABONADO,
                                                  V_NUMERO,
                                                  'CL',
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
          VP_TABLA := 'GA_INTARBEP';
          VP_ACT := 'S';
          BEGIN
             SELECT NUM_ABONADO INTO VAR1
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
             SELECT NUM_ABONADO INTO VAR1
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
            VP_TABLA := 'GA_INTARBEP';
            VP_ACT := 'S';
            SELECT FEC_DESDE INTO V_FECHAD
            FROM GA_INTARBEEP
            WHERE COD_CLIENTE = VP_CLIENTE
                  AND NUM_ABONADO = VP_ABONADO
                  AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA
                  AND ROWNUM = 1;
            V_FECHA := V_FECHAD;
            EXCEPTION
                WHEN OTHERS THEN
                     VP_ERROR := '4';
                     RAISE ERROR_PROCESO;
         END;
         ELSIF V_INDLLA <> 0 THEN
               VP_TABLA := 'GA_INTARBEP';
               VP_ACT := 'U';
               UPDATE GA_INTARBEEP
               SET COD_CICLO = VP_CICLONUE
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
        VP_TABLA := 'GA_INTARBEP';
        VP_ACT := 'S';
        SELECT ROWID,COD_CLIENTE,NUM_ABONADO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,
               COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO
        INTO V_ROWID,V_CLIENTE,V_ABONADO,V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
             V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,V_BEEPER,V_CARGOBASICO,
             V_CICLO,V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO
        FROM GA_INTARBEEP
        WHERE COD_CLIENTE = VP_CLIENTE
              AND NUM_ABONADO = VP_ABONADO
              AND FEC_DESDE = V_FECHA;
        IF V_FECHA = V_FECHADCF THEN
           IF V_FECHADCF = V_FECHADLL THEN
              VP_TABLA := 'GA_INTARBEP';
              VP_ACT := 'U';
              UPDATE GA_INTARBEEP
              SET COD_CICLO = VP_CICLONUE
              WHERE ROWID = V_ROWID;
           ELSIF V_FECHADCF < V_FECHADLL THEN
                 VP_TABLA := 'GA_INTARBEP';
                 VP_ACT := 'U';
                 V_FECHA_AUX :=V_FECHADLL - (1/(24*60*60));
                 UPDATE GA_INTARBEEP
                 SET FEC_HASTA = V_FECHA_AUX
                 WHERE ROWID = V_ROWID;
                 VP_TABLA := 'GA_INTARBEP';
                 VP_ACT := 'I';
                 INSERT INTO GA_INTARBEEP
                 (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                  FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                  TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                  NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                  COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
                 VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                         V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                         V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                         V_BEEPER,V_CARGOBASICO,VP_CICLONUE,
                         V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARBEP';
         VP_ACT := 'U';
         V_FECHA_AUX := V_FECHADLL - (1/(24*60*60));
         UPDATE GA_INTARBEEP
         SET FEC_HASTA = V_FECHA_AUX
         WHERE ROWID = V_ROWID;
         IF V_INDCAR <> 0 THEN
            VP_TABLA := 'GA_INTARBEP';
            VP_ACT := 'I';
            V_FECHA_AUX := V_FECHADCF - (1/(24*60*60));
            INSERT INTO GA_INTARBEEP
            (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
             FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
             TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
             NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
             COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
            VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,V_FECHA_AUX,
                    V_LIMCONSUMO,V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,
                    V_CAPCODE,V_BEEPER,V_CARGOBASICO,VP_CICLONUE,
                    V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO);
            VP_TABLA := 'GA_INTARBEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
            SET COD_CICLO = VP_CICLONUE
            WHERE COD_CLIENTE = V_CLIENTE
                  AND NUM_ABONADO = V_ABONADO
                  AND FEC_DESDE = V_FECHADCF;
         ELSE
            VP_TABLA := 'GA_INTARBEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP
            (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
             FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
             TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
             NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
             COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
             VALUES (V_CLIENTE,V_ABONADO,V_FECHADLL,
                     V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
                     V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,
                     V_BEEPER,V_CARGOBASICO,VP_CICLONUE,
                     V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO);
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
              SELECT ROWID INTO V_ROWID
              FROM GA_FINCICLO
              WHERE COD_CLIENTE = VP_CLIENTE
                    AND NUM_ABONADO = VP_ABONADO
                    AND COD_CICLFACT = V_CICLFACT;
              VP_TABLA := 'GA_FINCICLO';
              VP_ACT := 'U';
              UPDATE GA_FINCICLO
              SET COD_CICLO = VP_CICLONUE,
              FEC_DESDELLAM = DECODE(FEC_DESDELLAM,NULL,V_FECHADLL,
                                            FEC_DESDELLAM)
              WHERE ROWID = V_ROWID;
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                       VP_TABLA := 'GA_FINCICLO';
                       VP_ACT := 'I';
                       INSERT INTO GA_FINCICLO (COD_CLIENTE,
                                                COD_CICLFACT,
                                                NUM_ABONADO,
                                                COD_PRODUCTO,
                                                COD_CICLO,
                                                FEC_DESDELLAM)
                                        VALUES (VP_CLIENTE,
                                                V_CICLFACT,
                                                VP_ABONADO,
                                                VP_PRODUCTO,
                                                VP_CICLONUE,
                                                V_FECHADLL);
                   WHEN OTHERS THEN
                        VP_SQLCODE := SQLCODE;
                        VP_SQLERRM := SQLERRM;
                        VP_ERROR := '4';
            END;
        ELSE
       IF VP_SQLCODE IS NULL THEN
          VP_SQLCODE := SQLCODE;
          VP_SQLERRM := SQLERRM;
       END IF;
    END IF;
WHEN OTHERS THEN
     VP_SQLCODE := SQLCODE;
     VP_SQLERRM := SQLERRM;
     VP_ERROR := '4';
END;
/
SHOW ERRORS
