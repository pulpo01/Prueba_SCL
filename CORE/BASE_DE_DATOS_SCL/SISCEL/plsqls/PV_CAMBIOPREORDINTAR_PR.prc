CREATE OR REPLACE procedure PV_CAMBIOPREORDINTAR_PR
(VP_PRODUCTO   IN NUMBER,
VP_CLIENTE     IN NUMBER,
VP_ABONADO     IN NUMBER,
VP_CLIENTED    IN NUMBER,
VP_CICLO       IN NUMBER,
VP_FECSYS      IN DATE,
VP_CLIENEW     IN OUT NUMBER,
VP_PROC        IN OUT VARCHAR2,
VP_TABLA       IN OUT VARCHAR2,
VP_ACT         IN OUT VARCHAR2,
VP_SQLCODE     IN OUT VARCHAR2,
VP_SQLERRM     IN OUT VARCHAR2,
VP_ERROR       IN OUT VARCHAR2)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_CAMBIOPREORDINTAR_PR
-- * Descripcisn        : Procedimiento que refleja el traspaso de productos entre clientes
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************

--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_CLIENTE                    GA_INTARCEL.COD_CLIENTE%TYPE;
   V_ABONADO                    GA_INTARCEL.NUM_ABONADO%TYPE;
   V_NUMERO                     GA_INTARCEL.IND_NUMERO%TYPE;
   V_FECDESDE                   GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHASTA                   GA_INTARCEL.FEC_HASTA%TYPE;
   V_IMPLIMCONSUMO              GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   V_FRIENDS                    GA_INTARCEL.IND_FRIENDS%TYPE;
   V_DIASESP                    GA_INTARCEL.IND_DIASESP%TYPE;
   V_CELDA                              GA_INTARCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF               GA_INTARCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF                  GA_INTARCEL.COD_PLANTARIF%TYPE;
   V_SERIE                              GA_INTARCEL.NUM_SERIE%TYPE;
   V_CELULAR                    GA_INTARCEL.NUM_CELULAR%TYPE;
   V_CARGOBASICO                GA_INTARCEL.COD_CARGOBASICO%TYPE;
   V_CICLO                              GA_INTARCEL.COD_CICLO%TYPE;
   V_CICLOD                              GA_INTARCEL.COD_CICLO%TYPE;

   V_PLANCOM                    GA_INTARCEL.COD_PLANCOM%TYPE;
   V_PLANSERV                   GA_INTARCEL.COD_PLANSERV%TYPE;
   V_GRPSERV                    GA_INTARCEL.COD_GRPSERV%TYPE;
   V_GRUPO                              GA_INTARCEL.COD_GRUPO%TYPE;
   V_PORTADOR                   GA_INTARCEL.COD_PORTADOR%TYPE;
   V_USO                                GA_INTARCEL.COD_USO%TYPE;

   V_CAPCODE                    GA_INTARBEEP.CAP_CODE%TYPE;
   V_BEEPER                     GA_INTARBEEP.NUM_BEEPER%TYPE;

   V_RADIO                              GA_INTARTRUNK.NUM_RADIO%TYPE;
   V_SERIETRUNK                 GA_INTARTRUNK.NUM_SERIE%TYPE;

   V_MAN                                GA_INTARTREK.NUM_MAN%TYPE;
   V_SERIETREK                  GA_INTARTREK.NUM_SERIE%TYPE;

   V_CICLFACT                   FA_CICLFACT.COD_CICLFACT%TYPE;

   V_HOLDING                    GA_ABOCEL.COD_HOLDING%TYPE;

   V_EMPRESA                    GA_ABOCEL.COD_EMPRESA%TYPE;

   VAR1                                 GA_ABOCEL.NUM_ABONADO%TYPE;

   V_LIMCONSUMO                 GA_ABOCEL.COD_LIMCONSUMO%TYPE;

   V_FYFCEL                     GA_DATOSGENER.COD_FYFCEL%TYPE;

   -- INI.MAM 27/05/2003
   V_NUM_IMSI             GA_INTARCEL.NUM_IMSI%TYPE;
   V_NUM_SERIE            GA_ABOCEL.NUM_SERIE%TYPE;
   V_TECNOLOGIA 		  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM 	  GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   -- FIN.MAM 27/05/2003

   V_TABORIGEN VARCHAR2(10);
   IND_VALOR   NUMBER(1);
   FEC_AUX     DATE;
   V_ROWID     CHAR(18);

   vErrorAplic VARCHAR2(100);
   vErrorGlosa VARCHAR2(100);
   vErrorOra VARCHAR2(100);
   vErrorOraGlosa VARCHAR2(100);
   vTrace VARCHAR2(100);

   CURSOR C1 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
          FEC_DESDE,FEC_HASTA,IND_FRIENDS,
          IND_DIASESP,COD_CELDA,NUM_SERIE,
          NUM_CELULAR,TIP_PLANTARIF,COD_PLANTARIF,
                  COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_PLANSERV,
                  COD_GRPSERV,COD_GRUPO,COD_PORTADOR,COD_USO,IMP_LIMCONSUMO
   FROM GA_INTARCEL
   WHERE COD_CLIENTE     = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;

   CURSOR C2 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
          FEC_DESDE,FEC_HASTA,IND_DIASESP,CAP_CODE,
          NUM_BEEPER,COD_PLANSERV,COD_GRPSERV,
                  IMP_LIMCONSUMO,TIP_PLANTARIF,COD_PLANTARIF,
                  COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,COD_GRUPO
   FROM  GA_INTARBEEP
   WHERE COD_CLIENTE     = VP_CLIENTE
         AND NUM_ABONADO = VP_ABONADO
         AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
   ERROR_PROCESO EXCEPTION;

BEGIN
   VP_PROC := 'PV_CAMBIOPREORDINTAR_PR';
   VP_ERROR := '0';

   -- INI.MAM 27/05/2003
   --TMM-04026 Ini
   V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
   --TMM-04026 Fin
   -- FIN.MAM 27/05/2003

   IF VP_PRODUCTO = 1 THEN
      VP_TABLA := 'GA_ABOCEL';
      VP_ACT   := 'S';

	  -- INI.MAM 27/05/2003
	  IF VP_ABONADO <> 0 THEN

	 	 SELECT NUM_SERIE, COD_TECNOLOGIA
		 INTO   V_NUM_SERIE, V_TECNOLOGIA
	 	 FROM   GA_ABOCEL
		 WHERE  NUM_ABONADO = VP_ABONADO;

		 --TMM-04026 Ini
		 --IF V_TECNOLOGIA = V_TECNOLOGIA_GSM THEN
		 IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
		      SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
		 END IF;
		 --TMM-04026 Fin
  	  ELSE

		 V_NUM_IMSI := '';

	  END IF;
	  -- FIN.MAM 27/05/2003

          BEGIN
                 SELECT  COD_CLIENTE,TIP_PLANTARIF, COD_PLANTARIF, COD_CARGOBASICO,
             COD_LIMCONSUMO, COD_CICLO, COD_HOLDING, COD_EMPRESA,COD_USO
                 INTO   VP_CLIENEW,V_TIPPLANTARIF, V_PLANTARIF, V_CARGOBASICO,
                 V_LIMCONSUMO, V_CICLOD, V_HOLDING, V_EMPRESA,V_USO
                 FROM GA_ABOCEL
                 WHERE COD_CLIENTE = VP_CLIENTED
                         AND ROWNUM = 1;

                         V_TABORIGEN:='ABOCEL';

          EXCEPTION WHEN NO_DATA_FOUND THEN

                    BEGIN
                       VP_TABLA := 'GA_ABOAMIST';
                           VP_ACT := 'S';
                   SELECT COD_CLIENTE, TIP_PLANTARIF, COD_PLANTARIF,COD_USO
               INTO  VP_CLIENEW, V_TIPPLANTARIF, V_PLANTARIF,V_USO
                   FROM GA_ABOAMIST
                   WHERE COD_CLIENTE = VP_CLIENTED
                           AND ROWNUM = 1;

                           V_TABORIGEN:='ABOAMIST';

                    EXCEPTION WHEN OTHERS THEN
                                VP_SQLCODE := SQLCODE;
                                VP_SQLERRM := SQLERRM;
                                VP_ERROR := '4';
                    END;
          END;

      SELECT COD_FYFCEL
      INTO V_FYFCEL
      FROM GA_DATOSGENER;
      IF V_TIPPLANTARIF = 'H' THEN V_GRUPO := V_HOLDING;
      ELSIF V_TIPPLANTARIF = 'E' THEN
            V_GRUPO := V_EMPRESA;
      END IF;

          VP_TABLA := 'C1';
      VP_ACT := 'O';

          OPEN C1;
      LOOP
         VP_TABLA := 'C1';
         VP_ACT := 'F';

                 FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,
                       V_FECDESDE,V_FECHASTA,V_FRIENDS,V_DIASESP,V_CELDA,
                       V_SERIE,V_CELULAR,V_TIPPLANTARIF,V_PLANTARIF,V_CARGOBASICO,
                                           V_CICLO,V_PLANCOM,V_PLANSERV,V_GRPSERV,V_GRUPO,V_PORTADOR,V_USO,
                                           V_IMPLIMCONSUMO;

         EXIT WHEN C1%NOTFOUND;
         VP_TABLA := 'GA_INTARCEL';
         VP_ACT := 'U';
         FEC_AUX := VP_FECSYS - (1/(24*60*60));

         UPDATE GA_INTARCEL
         SET FEC_HASTA = FEC_AUX
         WHERE ROWID = V_ROWID;

                 IF V_TABORIGEN = 'ABOCEL' THEN
                VP_TABLA := 'GA_ABOCEL';
                VP_ACT := 'I';

                INSERT INTO GA_INTARCEL
                        (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                          FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                          IND_FRIENDS,IND_DIASESP,COD_CELDA,
                          TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                          NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                          COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                          COD_GRUPO,COD_PORTADOR,COD_USO,
						  NUM_IMSI) -- MAM 27/05/2003
            VALUES     (VP_CLIENTED,VP_ABONADO,V_NUMERO,
                        VP_FECSYS,V_FECHASTA,V_IMPLIMCONSUMO,
                        V_FRIENDS,V_DIASESP,V_CELDA,
                        V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                        V_CELULAR,V_CARGOBASICO,V_CICLOD,
                        V_PLANCOM,V_PLANSERV,V_GRPSERV,
                        V_GRUPO,V_PORTADOR,V_USO,
						V_NUM_IMSI); -- MAM 27/05/2003

		PV_ACTUALIZA_CAMB_COMERC_PR(VP_CLIENTED,
		                            VP_ABONADO,
		  			    V_NUMERO,
					   'AE',
					    VP_FECSYS,
					    vErrorAplic,
					    vErrorGlosa,
				  	    vErrorOra,
				  	    vErrorOraGlosa,
					    vTrace);

		PV_ACTUALIZA_CAMB_COMERC_PR(VP_CLIENTE,
		                            VP_ABONADO,
		  			    V_NUMERO,
					   'BA',
					    V_FECDESDE,
					    vErrorAplic,
					    vErrorGlosa,
				  	    vErrorOra,
				  	    vErrorOraGlosa,
					    vTrace);

                END IF;
      END LOOP;

      UPDATE GA_ABOCEL
      SET COD_CICLO = V_CICLOD
      WHERE NUM_ABONADO  =  VP_ABONADO;

          VP_TABLA := 'C1';
      VP_ACT := 'C';

          CLOSE C1;

          VP_TABLA := 'GA_INTARCEL';
      VP_ACT := 'D';


    ELSIF VP_PRODUCTO = 2 THEN
          VP_TABLA := 'C2';
          VP_ACT := 'O';
          OPEN C2;
          LOOP
              VP_TABLA := 'C2';
              VP_ACT := 'F';
              FETCH C2 INTO V_ROWID,V_CLIENTE,V_ABONADO,
                       V_FECDESDE,V_FECHASTA,V_DIASESP,
                       V_CAPCODE,V_BEEPER,V_PLANSERV,V_GRPSERV,
                                           V_IMPLIMCONSUMO,V_TIPPLANTARIF,V_PLANTARIF,
                                           V_CARGOBASICO,V_CICLO,V_PLANCOM,V_GRUPO;
              EXIT WHEN C2%NOTFOUND;

                  VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'U';
              FEC_AUX := VP_FECSYS - (1/(24*60*60));

                  UPDATE GA_INTARBEEP
              SET FEC_HASTA = FEC_AUX
              WHERE ROWID = V_ROWID;

                  VP_TABLA := 'GA_INTARBEEP';

              VP_ACT := 'I';
              V_FECHASTA := TO_DATE('31-12-3000', 'DD-MM-YYYY');
              INSERT INTO GA_INTARBEEP
                     (COD_CLIENTE,NUM_ABONADO,
                      FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                      IND_DIASESP,TIP_PLANTARIF,COD_PLANTARIF,
                      CAP_CODE,NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                      COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                      COD_GRUPO)
              VALUES (VP_CLIENTED,VP_ABONADO,
                      VP_FECSYS,V_FECHASTA,V_IMPLIMCONSUMO,
                      V_DIASESP,V_TIPPLANTARIF,V_PLANTARIF,
                      V_CAPCODE,V_BEEPER,V_CARGOBASICO,V_CICLO,
                      V_PLANCOM,V_PLANSERV,V_GRPSERV,
                      V_GRUPO);
          END LOOP;
          VP_TABLA := 'C2';
          VP_ACT   := 'C';

          CLOSE C2;
          VP_TABLA := 'GA_INTARBEEP';
          VP_ACT   := 'D';

        END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR   := '4';
END;
/
SHOW ERRORS
