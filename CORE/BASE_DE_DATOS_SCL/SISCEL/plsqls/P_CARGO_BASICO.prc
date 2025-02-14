CREATE OR REPLACE PROCEDURE        P_Cargo_Basico
(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CARGOBAS IN VARCHAR2 ,
  VP_CICLO IN NUMBER ,
  VP_FECSYS IN DATE ,
  VP_OPERACION IN VARCHAR2,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_Cargo_Basico
-- * Descripcisn        : Procedimiento que refleja el cambio y efectividad del nuevo cargo basico
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  : 14-01-2003 16:23
-- * Responsable        : CRM
-- *           Los posibles retornos del procedimiento son :
-- *               - '0' Actualizaciones realizadas correctamente
-- *               - '4' Error en el proceso
-- *************************************************************
--
--
   V_FECHADCF GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHADLL GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHAD GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHA GA_INTARCEL.FEC_DESDE%TYPE;
   V_ROWID ROWID;
   V_COD_TIPMODI GA_MODABOCEL.COD_TIPMODI%TYPE;
   V_INDCAR NUMBER(1) := 0;
   V_INDLLA NUMBER(1) := 0;
   CURSOR C1 IS
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
   VAR1 GA_ABOCEL.NUM_ABONADO %TYPE;
   V_PLAN_REA GA_ABOCEL.COD_PLANTARIF%TYPE;
   V_CARGOBAS_REA  GA_ABOCEL.COD_CARGOBASICO%TYPE;
   VP_CARGOBASICO GA_ABOCEL.COD_CARGOBASICO%TYPE;
   V_PLANNUE  GA_SUSPREHABO.COD_PLANNUE%TYPE;
   V_USO GA_INTARCEL.COD_USO%TYPE;
   V_NUM_IMSI  GA_INTARCEL.NUM_IMSI%TYPE;
   V_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
   V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;

   V_FEC_HASTA_VIG GA_INTARCEL.FEC_HASTA%type;
   V_FECHASTA_MAX GA_INTARCEL.FEC_HASTA%type;

   ERROR_PROCESO EXCEPTION;

   vIndNumero  GA_INTARCEL.IND_NUMERO%TYPE;
   vErrorAplic VARCHAR2(100);
   vErrorGlosa VARCHAR2(100);
   vErrorOra VARCHAR2(100);
   vErrorOraGlosa VARCHAR2(100);
   vTrace VARCHAR2(100);

BEGIN

   VP_PROC := 'P_CARGO_BASICO';
   IF VP_OPERACION='S' THEN
   BEGIN
      VP_TABLA := 'FA_CICLFACT';
      VP_ACT := 'S';
          BEGIN
              SELECT COD_TIPMODI INTO V_COD_TIPMODI
                  FROM GA_MODABOCEL
                  WHERE COD_TIPMODI = 'SV' AND TRUNC(SYSDATE) = TRUNC(FEC_MODIFICA)
                  AND NUM_ABONADO = VP_ABONADO;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
                        V_COD_TIPMODI := 'X';
                WHEN OTHERS THEN
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
          END;
      SELECT MIN(FEC_DESDELLAM)
      INTO V_FECHADLL
      FROM FA_CICLFACT
      WHERE COD_CICLO = VP_CICLO
      AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
      AND IND_FACTURACION = 0;
      -- Modificación: Patricio Gallegos C.
          IF V_COD_TIPMODI = 'SV' THEN

	         SELECT SYSDATE,COD_CICLFACT
	         INTO V_FECHADCF,V_CICLFACT
	         FROM FA_CICLFACT
	         WHERE COD_CICLO = VP_CICLO
	         AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
	         AND IND_FACTURACION = 0
	         AND FEC_DESDELLAM=V_FECHADLL;

			 --Selección fecha_hasta del registro con vigente actual --
			 SELECT FEC_HASTA INTO V_FEC_HASTA_VIG
			 FROM GA_INTARCEL
			 WHERE COD_CLIENTE = VP_CLIENTE
         	 AND NUM_ABONADO = VP_ABONADO
			 AND V_FECHADCF BETWEEN FEC_DESDE AND FEC_HASTA;

			 --Selección de fecha máxima --
			 SELECT MAX(FEC_HASTA) into V_FECHASTA_MAX
			 FROM GA_INTARCEL
			 WHERE COD_CLIENTE = VP_CLIENTE
			 AND NUM_ABONADO  = VP_ABONADO;

			 -- Borro registros posteriores pertenecientes --
			 -- a un cambio de plan u otros  --
		 	 DELETE GA_INTARCEL
			 WHERE COD_CLIENTE = VP_CLIENTE
			 AND NUM_ABONADO = VP_ABONADO
			 AND FEC_DESDE>V_FEC_HASTA_VIG;

			 --Actualizar fecha máxima del registro vigente --
			 UPDATE GA_INTARCEL SET FEC_HASTA = V_FECHASTA_MAX
			 WHERE COD_CLIENTE = VP_CLIENTE
         	 AND NUM_ABONADO = VP_ABONADO
			 AND V_FECHADCF BETWEEN FEC_DESDE AND FEC_HASTA;

			 --Borrar GA_FINCICLO
			 DELETE GA_FINCICLO
			 Where COD_CLIENTE = VP_CLIENTE
			 AND NUM_ABONADO = VP_ABONADO;

          ELSE
	         SELECT FEC_DESDELLAM,COD_CICLFACT
	         INTO V_FECHADCF,V_CICLFACT
	         FROM FA_CICLFACT
	         WHERE COD_CICLO = VP_CICLO
	         AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
	         AND IND_FACTURACION = 0
	         AND FEC_DESDELLAM=V_FECHADLL;
          END IF;
	  -- Fin Modificación Patricio Gallegos
   EXCEPTION
      WHEN OTHERS THEN
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
   END;
   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'S';

		-- INI TMM_04026
        V_TECNOLOGIA_GSM :=  GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM'); --GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');
      -- FIN TMM_04026

        SELECT NUM_SERIE, COD_TECNOLOGIA
      INTO V_NUM_SERIE, V_TECNOLOGIA
      FROM GA_ABOCEL
      WHERE NUM_ABONADO = VP_ABONADO;

		  -- INI TMM_04026
        IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
        -- FIN TMM_04026
           SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
        END IF;

      BEGIN
         SELECT NUM_ABONADO
         INTO VAR1
         FROM GA_INTARCEL
         WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND TRUNC(FEC_DESDE)   = TRUNC(V_FECHADCF);
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
         AND TRUNC(FEC_DESDE)   = TRUNC(V_FECHADLL);
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
           SELECT FEC_DESDE
           INTO V_FECHAD
           FROM GA_INTARCEL
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
      ELSIF V_INDCAR <> 0 THEN
          VP_TABLA := 'GA_INTARCEL';
          VP_ACT := 'U';
          UPDATE GA_INTARCEL
          SET COD_CARGOBASICO = VP_CARGOBAS,NUM_IMSI=V_NUM_IMSI
          WHERE COD_CLIENTE = VP_CLIENTE
          AND NUM_ABONADO = VP_ABONADO
          AND FEC_DESDE >= V_FECHADCF;
          VP_ERROR := '0';
          RAISE ERROR_PROCESO;
      ELSIF V_INDLLA <> 0 THEN
          IF V_FECHADCF >= V_FECHADLL THEN
             V_FECHA := V_FECHADLL;
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
         FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
                       V_FRIENDS,V_DIASESP,V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                       V_CELULAR,V_CARGOBASICO,V_CICLO,V_PLANCOM,V_PLANSERV,V_GRPSERV,
                       V_GRUPO,V_PORTADOR,V_USO;
         EXIT WHEN C1%NOTFOUND;
         IF V_FECHA = V_FECHADLL THEN
            IF V_FECHADLL = V_FECHADCF THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               UPDATE GA_INTARCEL
                  SET COD_CARGOBASICO = VP_CARGOBAS,NUM_IMSI=V_NUM_IMSI
               WHERE ROWID = V_ROWID;
            ELSIF V_FECHADLL < V_FECHADCF THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               UPDATE GA_INTARCEL
               SET FEC_HASTA = V_FECHADCF - (1/(24*60*60)),NUM_IMSI=V_NUM_IMSI
               WHERE ROWID = V_ROWID;
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               INSERT INTO GA_INTARCEL
               (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,V_FECHADCF,V_FECHASTA,V_LIMCONSUMO,
                V_FRIENDS,V_DIASESP,V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,V_CELULAR,VP_CARGOBAS,V_CICLO,
                V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);

                                PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                                                        V_NUMERO,
                                                                                        'CB',
                                                                                        V_FECHADCF,
                                                                                        vErrorAplic,
                                                                                        vErrorGlosa,
                                                                                        vErrorOra,
                                                                                        vErrorOraGlosa,
                                                                                        vTrace);

            END IF;
         ELSE
            VP_TABLA := 'GA_INTARCEL';
            VP_ACT := 'U';
            UPDATE GA_INTARCEL
               SET FEC_HASTA = V_FECHADCF - (1/(24*60*60)),NUM_IMSI=V_NUM_IMSI
            WHERE ROWID = V_ROWID;
            IF V_INDLLA <> 0 THEN
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               INSERT INTO GA_INTARCEL
               (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,V_FECHADCF,V_FECHADLL - (1/(24*60*60)),
                V_LIMCONSUMO,V_FRIENDS,V_DIASESP,V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                V_CELULAR,VP_CARGOBAS,V_CICLO,V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);

                           PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                                                        V_NUMERO,
                                                                                        'CB',
                                                                                        V_FECHADCF,
                                                                                        vErrorAplic,
                                                                                        vErrorGlosa,
                                                                                        vErrorOra,
                                                                                        vErrorOraGlosa,
                                                                                        vTrace);

               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'U';
               UPDATE GA_INTARCEL
                  SET COD_CARGOBASICO = VP_CARGOBAS,NUM_IMSI=V_NUM_IMSI
               WHERE COD_CLIENTE = V_CLIENTE
               AND NUM_ABONADO = V_ABONADO
               AND FEC_DESDE = V_FECHADLL;
            ELSE
               VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
               INSERT INTO GA_INTARCEL(COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
               IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
               VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,V_FECHADCF,V_FECHASTA,V_LIMCONSUMO,
               V_FRIENDS,V_DIASESP,V_CELDA,V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,V_CELULAR,VP_CARGOBAS,V_CICLO,
               V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);



                           PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                                            V_ABONADO,
                                                                                        V_NUMERO,
                                                                                        'CB',
                                                                                        V_FECHADCF,
                                                                                        vErrorAplic,
                                                                                        vErrorGlosa,
                                                                                        vErrorOra,
                                                                                        vErrorOraGlosa,
                                                                                        vTrace);
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
               V_INDCAR := 0;
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
            AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS)
            AND ROWNUM = 1;
            V_FECHA := V_FECHAD;
         EXCEPTION
            WHEN OTHERS THEN
                 VP_ERROR := '4';
                 RAISE ERROR_PROCESO;
         END;
      ELSIF V_INDCAR <> 0 THEN
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         UPDATE GA_INTARBEEP
            SET COD_CARGOBASICO = VP_CARGOBAS
         WHERE COD_CLIENTE = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND FEC_DESDE >= V_FECHADCF;
         VP_ERROR := '0';
         RAISE ERROR_PROCESO;
      ELSIF V_INDLLA <> 0 THEN
            IF V_FECHADCF >= V_FECHADLL THEN
               V_FECHA := V_FECHADLL;
            ELSE
               V_FECHA := V_FECHAD;
            END IF;
      END IF;
      VP_TABLA := 'GA_INTARBEEP';
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
      IF V_FECHA = V_FECHADLL THEN
         IF V_FECHADLL = V_FECHADCF THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
            SET COD_CARGOBASICO = VP_CARGOBAS
            WHERE ROWID = V_ROWID;
         ELSIF V_FECHADLL < V_FECHADCF THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
            SET FEC_HASTA = V_FECHADCF - (1/(24*60*60))
            WHERE ROWID = V_ROWID;
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP
            (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
             TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
             COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
            VALUES (V_CLIENTE,V_ABONADO,V_FECHADCF,V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
            V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,V_BEEPER,VP_CARGOBAS,V_CICLO,
            V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO);
         END IF;
      ELSE
         VP_TABLA := 'GA_INTARBEEP';
         VP_ACT := 'U';
         UPDATE GA_INTARBEEP
         SET FEC_HASTA = V_FECHADCF - (1/(24*60*60))
         WHERE ROWID = V_ROWID;
         IF V_INDLLA <> 0 THEN
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP(COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
            FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
            NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
            COD_GRUPO)
            VALUES (V_CLIENTE,V_ABONADO,V_FECHADCF,V_FECHADLL - (1/(24*60*60)),V_LIMCONSUMO,V_DIASESP,
            V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,V_BEEPER,VP_CARGOBAS,V_CICLO,
            V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO);
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'U';
            UPDATE GA_INTARBEEP
               SET COD_CARGOBASICO = VP_CARGOBAS
            WHERE COD_CLIENTE = V_CLIENTE
            AND NUM_ABONADO = V_ABONADO
            AND FEC_DESDE = V_FECHADLL;
         ELSE
            VP_TABLA := 'GA_INTARBEEP';
            VP_ACT := 'I';
            INSERT INTO GA_INTARBEEP(COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
            FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
            NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
            VALUES (V_CLIENTE,V_ABONADO,V_FECHADCF,V_FECHASTA,V_LIMCONSUMO,V_DIASESP,
            V_TIPPLANTARIF,V_PLANTARIF,V_CAPCODE,V_BEEPER,VP_CARGOBAS,V_CICLO,V_PLANCOM,V_PLANSERV,V_GRPSERV,
            V_GRUPO);
         END IF;
      END IF;
    END IF;
    VP_ERROR := '0';
    RAISE ERROR_PROCESO;
  ELSIF VP_OPERACION='R' THEN
  BEGIN
      SELECT MIN(FEC_DESDELLAM)
      INTO V_FECHADLL
      FROM FA_CICLFACT
      WHERE COD_CICLO = VP_CICLO
      AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
      AND IND_FACTURACION = 0;
      SELECT FEC_DESDELLAM,COD_CICLFACT
      INTO V_FECHADCF,V_CICLFACT
      FROM FA_CICLFACT
      WHERE COD_CICLO = VP_CICLO
      AND TRUNC(VP_FECSYS) < TRUNC(FEC_DESDELLAM)
      AND IND_FACTURACION = 0
      AND FEC_DESDELLAM=V_FECHADLL;
   EXCEPTION
      WHEN OTHERS THEN
           VP_ERROR := '4';
           RAISE ERROR_PROCESO;
   END;
   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'S';
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
      -- Valida si poseia cambio de  plan tarifario  a ciclo
      BEGIN
          VP_TABLA := 'GA_SUSPREHABO';
          VP_ACT := 'S';

		  IF V_COD_TIPMODI='SV' THEN --RA-200602110755: German Espinoza Z; 17/02/2006
          SELECT COD_PLANNUE
          INTO V_PLANNUE
          FROM GA_SUSPREHABO
          WHERE NUM_ABONADO =VP_ABONADO
          AND COD_MODULO='GA'
	          AND COD_PLANNUE IS NOT NULL
			  AND cod_servicio=(SELECT val_parametro  		   			   --RA-200602110755: German Espinoza Z; 17/02/2006
			  	  				FROM ged_parametros 					   --RA-200602110755: German Espinoza Z; 17/02/2006
								where nom_parametro='COD_SERVSUSPT_GSM'    --RA-200602110755: German Espinoza Z; 17/02/2006
								and cod_producto=1 						   --RA-200602110755: German Espinoza Z; 17/02/2006
								and cod_modulo='GA');					   --RA-200602110755: German Espinoza Z; 17/02/2006

		  --RA-200602110755: German Espinoza Z; 17/02/2006
		  ELSE
			  SELECT COD_PLANNUE
	          INTO V_PLANNUE
	          FROM GA_SUSPREHABO
	          WHERE NUM_ABONADO =VP_ABONADO
	          AND COD_MODULO='GA'
	          AND COD_PLANNUE IS NOT NULL
			  AND cod_servicio=(SELECT val_parametro
			  	  				FROM ged_parametros
								where nom_parametro='COD_SERVAVSINIE_GSM'
								and cod_producto=1
								and cod_modulo='GA')
            AND ROWNUM = 1; -- COL|78629|14-02-2009|SAQL

		  END IF;
		  --FIN/RA-200602110755: German Espinoza Z; 17/02/2006

      EXCEPTION
            WHEN NO_DATA_FOUND THEN
               V_PLANNUE:='';
      END;
     IF V_INDCAR =0 AND V_INDLLA=0 THEN   --no existen filas proximo ciclo.
        IF V_PLANNUE <> '' THEN
            BEGIN
                   VP_TABLA := 'GA_INTARCEL';
                  VP_ACT := 'S';
                SELECT A.ROWID,A.FEC_DESDE
                INTO V_ROWID,V_FECHAD
FROM GA_INTARCEL A
WHERE COD_CLIENTE=VP_CLIENTE
AND NUM_ABONADO=VP_ABONADO
                   AND VP_FECSYS BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,VP_FECSYS);
                   VP_TABLA := 'TA_PLANTARIF';
                  VP_ACT := 'S';
                   SELECT COD_CARGOBASICO
                   INTO V_CARGOBAS_REA
                   FROM TA_PLANTARIF
                   WHERE COD_PRODUCTO=VP_PRODUCTO
                   AND COD_PLANTARIF=V_PLANNUE;
                   V_PLAN_REA:=V_PLANNUE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     VP_ERROR := '4';
                         RAISE ERROR_PROCESO;
            END;
        ELSE
            BEGIN
                   VP_TABLA := 'GA_INTARCEL';
                  VP_ACT := 'S';
                SELECT A.ROWID,A.FEC_DESDE,A.COD_PLANTARIF,B.COD_CARGOBASICO
                INTO V_ROWID,V_FECHAD,V_PLAN_REA,V_CARGOBAS_REA
                FROM GA_INTARCEL A, TA_PLANTARIF B
                WHERE COD_CLIENTE=VP_CLIENTE
                AND NUM_ABONADO=VP_ABONADO
                AND VP_FECSYS BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,VP_FECSYS)
                AND B.COD_PRODUCTO=VP_PRODUCTO
                AND A.COD_PLANTARIF=B.COD_PLANTARIF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   VP_ERROR:='4';
                   RAISE ERROR_PROCESO;
            END;
        END IF;

        VP_TABLA := 'GA_INTARCEL';
               VP_ACT := 'I';
        INSERT INTO GA_INTARCEL
               (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
        IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
               NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
        --Inicio Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
        --COD_GRUPO,COD_PORTADOR,COD_USO)
        COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
        --Fin Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
        SELECT COD_CLIENTE,NUM_ABONADO,IND_NUMERO,V_FECHADCF,TO_DATE('31-12-3000','DD_MM_YYYY'),
        IMP_LIMCONSUMO,IND_FRIENDS,IND_DIASESP,COD_CELDA,TIP_PLANTARIF,V_PLAN_REA,NUM_SERIE,
        NUM_CELULAR,V_CARGOBAS_REA,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
        --Inicio Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
        --COD_GRUPO,COD_PORTADOR,COD_USO
        COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI
        --Fin Modificación - GBM/Soporte - 27-02-2006 - RA-200602200813
        FROM GA_INTARCEL
        WHERE COD_CLIENTE=VP_CLIENTE
        AND NUM_ABONADO=VP_ABONADO
        AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
        VP_ERROR:='0';

	/*Inicio Homologacion  HD-200401060109 PCR  26/02/2004 */
		/* Inicio Homologacion HB-200312090250 - José Jara R. - 16/12/2003 */
		/*CH-041220031549, German Espinoza Z. 04/12/2003 20:00 Hr.
		Este update se encontraba antes del insert a la ga_intarcel
		ya que actualizaba el registro con un segundo menos
		el insert y el select no encontraba datos
		y el select se caia por no_data_found
		*/
		VP_TABLA := 'GA_INTARCEL 1';
	        VP_ACT := 'U';
	        UPDATE GA_INTARCEL
	               SET FEC_HASTA = V_FECHADCF - (1/(24*60*60))
	        WHERE ROWID = V_ROWID;
		/*CH-041220031549, German Espinoza Z. 04/12/2003 20:00 Hr.*/
      	/* Fin Homologacion HB-200312090250 - José Jara R. - 16/12/2003 */
        /*Fin  Homologacion  HD-200401060109 PCR  26/02/2004 */


                SELECT IND_NUMERO
                  INTO vIndNumero
                  FROM GA_INTARCEL
         WHERE COD_CLIENTE = VP_CLIENTE
           AND NUM_ABONADO = VP_ABONADO
           AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);


                PV_ACTUALIZA_CAMB_COMERC_PR(VP_CLIENTE,
                                            VP_ABONADO,
                                                                        vIndNumero,
                                                                        'CB',
                                                                        V_FECHADCF,
                                                                        vErrorAplic,
                                                                        vErrorGlosa,
                                                                        vErrorOra,
                                                                        vErrorOraGlosa,
                                                                        vTrace);

        RAISE ERROR_PROCESO;
     ELSE  -- Existen filas para el proximo ciclo.
        IF V_PLANNUE <> '' THEN
            BEGIN
                   VP_TABLA := 'GA_INTARCEL';
                  VP_ACT := 'S';
                SELECT A.ROWID,A.FEC_DESDE
                INTO V_ROWID,V_FECHAD
FROM GA_INTARCEL A
WHERE COD_CLIENTE=VP_CLIENTE
AND NUM_ABONADO=VP_ABONADO
AND TRUNC(VP_FECSYS) <= TRUNC(A.FEC_DESDE) -- PCR- Inicio Homologacion HD-200312170043
                AND ROWNUM =1;
                   VP_TABLA := 'TA_PLANTARIF';
                  VP_ACT := 'S';
                   SELECT COD_CARGOBASICO
                   INTO V_CARGOBAS_REA
                   FROM TA_PLANTARIF
                   WHERE COD_PRODUCTO=VP_PRODUCTO
                   AND COD_PLANTARIF=V_PLANNUE;
                   V_PLAN_REA:=V_PLANNUE;
                VP_TABLA := 'GA_INTARCEL';
                VP_ACT := 'U';
                UPDATE GA_INTARCEL
                  SET COD_CARGOBASICO=V_CARGOBAS_REA,
                      COD_PLANTARIF=V_PLAN_REA
                WHERE ROWID = V_ROWID;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     VP_ERROR := '4';
                         RAISE ERROR_PROCESO;
            END;
        ELSE
            BEGIN
                VP_TABLA := 'GA_INTARCEL';
                VP_ACT := 'S';
                SELECT A.ROWID,A.FEC_DESDE,A.COD_PLANTARIF,B.COD_CARGOBASICO
                INTO V_ROWID,V_FECHAD,V_PLAN_REA,V_CARGOBAS_REA
                FROM GA_INTARCEL A, TA_PLANTARIF B
                WHERE COD_CLIENTE=VP_CLIENTE
                AND NUM_ABONADO=VP_ABONADO
                AND TRUNC(VP_FECSYS) <= TRUNC(A.FEC_DESDE) -- PCR- Inicio Homologacion HD-200312170043
                AND A.COD_PLANTARIF=B.COD_PLANTARIF
                AND B.COD_PRODUCTO=VP_PRODUCTO
                AND ROWNUM =1;
                VP_TABLA := 'GA_INTARCEL';
                VP_ACT := 'U';
                UPDATE GA_INTARCEL
                  SET COD_CARGOBASICO=V_CARGOBAS_REA
                WHERE ROWID = V_ROWID;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   VP_ERROR:='4';
                   RAISE ERROR_PROCESO;
                WHEN OTHERS THEN
                   VP_ERROR:='4';
                   RAISE ERROR_PROCESO;
            END;
        END IF;
        VP_ERROR:='0';
        RAISE ERROR_PROCESO;
     END IF;
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
     IF V_INDCAR =0 AND V_INDLLA=0 THEN   --no existen filas proximo ciclo.
        VP_TABLA := 'GA_INTARCEL';
        VP_ACT := 'U';
        SELECT A.ROWID,A.FEC_DESDE,A.COD_PLANTARIF,B.COD_CARGOBASICO
        INTO V_ROWID,V_FECHAD,V_PLAN_REA,V_CARGOBAS_REA
        FROM GA_INTARBEEP A, TA_PLANTARIF B
        WHERE COD_CLIENTE=VP_CLIENTE
        AND NUM_ABONADO=VP_ABONADO
        AND VP_FECSYS BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,VP_FECSYS)
        AND B.COD_PRODUCTO=VP_PRODUCTO
        AND A.COD_PLANTARIF=B.COD_PLANTARIF;
        VP_TABLA := 'GA_INTARBEEP';
        VP_ACT := 'U';
        UPDATE GA_INTARBEEP
        SET FEC_HASTA = V_FECHADCF - (1/(24*60*60))
        WHERE ROWID = V_ROWID;
        INSERT INTO GA_INTARBEEP
        (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
        TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
        COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO)
        SELECT COD_CLIENTE,NUM_ABONADO,V_FECHADCF,TO_DATE('31-12-3000','DD_MM_YYYY'),
        IMP_LIMCONSUMO,IND_DIASESP,TIP_PLANTARIF,V_PLAN_REA,CAP_CODE,NUM_BEEPER,
        V_CARGOBAS_REA,COD_CICLO,COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,COD_GRUPO
        FROM GA_INTARBEEP
        WHERE COD_CLIENTE=VP_CLIENTE
        AND NUM_ABONADO=VP_ABONADO
        AND VP_FECSYS BETWEEN FEC_DESDE AND NVL(FEC_HASTA,VP_FECSYS);
        VP_ERROR:='0';
        RAISE ERROR_PROCESO;
     ELSE
        VP_TABLA := 'GA_INTARBEEP';
        VP_ACT := 'S';
        SELECT A.ROWID,A.FEC_DESDE,A.COD_PLANTARIF,B.COD_CARGOBASICO
        INTO V_ROWID,V_FECHAD,V_PLAN_REA,V_CARGOBAS_REA
        FROM GA_INTARBEEP A, TA_PLANTARIF B
        WHERE COD_CLIENTE=VP_CLIENTE
        AND NUM_ABONADO=VP_ABONADO
        AND TRUNC(VP_FECSYS) <= TRUNC(A.FEC_DESDE) -- PCR- Inicio Homologacion HD-200312170043
        AND A.COD_PLANTARIF=B.COD_PLANTARIF
        AND B.COD_PRODUCTO=VP_PRODUCTO
        AND ROWNUM =1;
        VP_TABLA := 'GA_INTARBEEP';
        VP_ACT := 'U';
        UPDATE GA_INTARBEEP
          SET COD_CARGOBASICO=V_CARGOBAS_REA
        WHERE ROWID = V_ROWID;
        VP_ERROR:='0';
        RAISE ERROR_PROCESO;
      END IF;
    END IF;
  END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
        IF VP_ERROR = '0' THEN
        BEGIN
           IF V_CARGOBAS_REA IS NOT NULL THEN
              VP_CARGOBASICO:=V_CARGOBAS_REA;
           ELSE
              VP_CARGOBASICO:=VP_CARGOBAS;
           END IF;
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
           UPDATE GA_FINCICLO
              SET COD_CARGOBASICO = VP_CARGOBASICO,
                  FEC_DESDECARGOS = DECODE(FEC_DESDECARGOS,NULL,V_FECHADCF,FEC_DESDECARGOS)
              WHERE ROWID = V_ROWID;
        EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  VP_TABLA := 'GA_FINCICLO';
                  VP_ACT := 'I';
                  INSERT INTO GA_FINCICLO (COD_CLIENTE,COD_CICLFACT,NUM_ABONADO,COD_PRODUCTO,
                  COD_CARGOBASICO,FEC_DESDECARGOS)
                  VALUES (VP_CLIENTE,V_CICLFACT,VP_ABONADO,VP_PRODUCTO,VP_CARGOBASICO,V_FECHADCF);
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
