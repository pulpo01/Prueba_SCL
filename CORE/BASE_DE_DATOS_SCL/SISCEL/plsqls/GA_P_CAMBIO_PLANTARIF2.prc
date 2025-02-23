CREATE OR REPLACE PROCEDURE GA_P_CAMBIO_PLANTARIF2
(
  VP_PRODUCTO 	  IN 		NUMBER   ,
  VP_CLIENTE 	  IN 		NUMBER   ,
  VP_ABONADO 	  IN 		NUMBER   ,
  VP_PLANTARIF 	  IN 		VARCHAR2 ,
  VP_CICLO 		  IN 		NUMBER   ,
  VP_GRUPO 		  IN 		NUMBER   ,
  VP_FECSYS 	  IN 		DATE     ,
  VP_PROC 		  IN OUT 	VARCHAR2 ,
  VP_TABLA 		  IN OUT 	VARCHAR2 ,
  VP_ACT 		  IN OUT 	VARCHAR2 ,
  VP_SQLCODE 	  IN OUT 	VARCHAR2 ,
  VP_SQLERRM 	  IN OUT 	VARCHAR2 ,
  VP_ERROR 		  IN OUT 	VARCHAR2 ,
  V_USODESTINO 	  IN 		VARCHAR2 := NULL )
IS

-- GA_P_CAMBIO_PLANTARIF2 v1.1 RA-200512160334: JJR.- 22/12/2005
-- GA_P_CAMBIO_PLANTARIF2 v1.2 CO-200608160325: German Espinoza Z; 14/08/2006
-- GA_P_CAMBIO_PLANTARIF2 v1.3 Modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326
-- GA_P_CAMBIO_PLANTARIF2 v1.4 COL|43725|10/09/2007|SAQL
-- GA_P_CAMBIO_PLANTARIF2 v1.5 COL|43725|08/10/2007|SAQL
-- GA_P_CAMBIO_PLANTARIF2 v1.6 COL|75765|10/01/2009|EFR

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : GA_P_CAMBIO_PLANTARIF2
-- * Descripcisn        : Procedimiento que refleja el cambio y efectividad deL NUEVO PLANTARIFARIO
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creacisn  : 14-01-2003 16:23
-- * Responsable        : CRM
-- *           Los posibles retornos del procedimiento son :
-- *               - '0' Actualizaciones realizadas correctamente
-- *               - '4' Error en el proceso
-- *************************************************************
--
--
   V_FECHASUP GA_INTARCEL.FEC_DESDE%TYPE;
   V_ROWID ROWID;
   CURSOR C1 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
          FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
          IND_FRIENDS,IND_DIASESP,COD_CELDA,
          TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
          NUM_CELULAR,COD_CICLO,
          COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
          COD_GRUPO,COD_PORTADOR,COD_USO
   FROM GA_INTARCEL
   WHERE COD_CLIENTE = VP_CLIENTE
   AND   NUM_ABONADO = VP_ABONADO
   AND   VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;

   V_CLIENTE 	   		   GA_INTARCEL.COD_CLIENTE%TYPE;
   V_ABONADO 			   GA_INTARCEL.NUM_ABONADO%TYPE;
   V_NUMERO 			   GA_INTARCEL.IND_NUMERO%TYPE;
   V_FECDESDE 			   GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHASTA 			   GA_INTARCEL.FEC_HASTA%TYPE;
   V_LIMCONSUMO 		   GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   V_FRIENDS 			   GA_INTARCEL.IND_FRIENDS%TYPE;
   V_DIASESP 			   GA_INTARCEL.IND_DIASESP%TYPE;
   V_CELDA 				   GA_INTARCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF 		   GA_INTARCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF 			   GA_INTARCEL.COD_PLANTARIF%TYPE;
   V_SERIE 				   GA_INTARCEL.NUM_SERIE%TYPE;
   V_SERIETRUNK 		   GA_INTARTRUNK.NUM_SERIE%TYPE;
   V_SERIETREK 			   GA_INTARTREK.NUM_SERIE%TYPE;
   V_CELULAR 			   GA_INTARCEL.NUM_CELULAR%TYPE;
   V_CARGOBASICO 		   GA_INTARCEL.COD_CARGOBASICO%TYPE;
   V_CICLO 				   GA_INTARCEL.COD_CICLO%TYPE;
   V_PLANCOM 			   GA_INTARCEL.COD_PLANCOM%TYPE;
   V_PLANSERV 			   GA_INTARCEL.COD_PLANSERV%TYPE;
   V_GRPSERV 			   GA_INTARCEL.COD_GRPSERV%TYPE;
   V_GRUPO 				   GA_INTARCEL.COD_GRUPO%TYPE;
   V_PORTADOR 			   GA_INTARCEL.COD_PORTADOR%TYPE;
   V_CAPCODE 			   GA_INTARBEEP.CAP_CODE%TYPE;
   V_BEEPER 			   GA_INTARBEEP.NUM_BEEPER%TYPE;
   V_RADIO 				   GA_INTARTRUNK.NUM_RADIO%TYPE;
   V_MAN 				   GA_INTARTREK.NUM_MAN%TYPE;
   V_INDCUOTA 			   GE_MODVENTA.IND_CUOTAS%TYPE;
   V_CUOTA 				   GA_INFACCEL.IND_CUOTAS%TYPE;
   V_ARRIENDO 			   GA_INFACCEL.IND_ARRIENDO%TYPE;
   V_CICLFACT 			   GA_INFACCEL.COD_CICLFACT%TYPE;
   V_DESDE_LIMITE_CLIABO   DATE;
   V_DESDE  			   DATE;
   V_HASTA  			   DATE;
   V_USO 				   GA_ABOCEL.COD_USO%TYPE:=NULL;
   VP_USO 				   GA_ABOCEL.COD_USO%TYPE:=NULL;
   VNUM_IMSI 			   GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA 		   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM 	   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_NUM_SERIE 			   GA_ABOCEL.NUM_SERIE%TYPE;
   V_FYF 				   NUMBER:=0;
   vFecDesdeProximo        GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE; -- PBR
   vErrorAplic 			   VARCHAR2(100);
   vErrorGlosa 			   VARCHAR2(100);
   vErrorOra 			   VARCHAR2(100);
   vErrorOraGlosa 		   VARCHAR2(100);
   vTrace 				   VARCHAR2(100);

   --SPZ 24-05-2003
   ERROR_PROCESO   		   EXCEPTION;
   V_CANT_REG 			   NUMBER:=0;
   V_COD_TIPLAN            VARCHAR2(10); -- Modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326

   --INI COL-37559|12-02-2007|GEZ
   sCodUsoActual		   ga_intarcel.cod_uso%TYPE;
   sCodUsoPostPago		   ged_parametros.val_parametro%TYPE;
   sCodUsoHibrido 		   ged_parametros.val_parametro%TYPE;
   --FIN COL-37559|12-02-2007|GEZ
   nCANTIDAD         NUMBER;
BEGIN
   VP_PROC := 'GA_P_CAMBIO_PLANTARIF2'; -- MAM PH-200403240064 05.05.2004
   VP_ACT := 'S';

   --QUITAMOS LOS SEGUNDOS Y MINUTOS

   -- Inicio Modificacion: Patricio Gallegos C. 16-05-2003 Inc. CH-090520030675

   --ini 75765/10-01-2009/EFR
   --V_DESDE := VP_FECSYS;
   V_DESDE := VP_FECSYS + (1/(24*60*60));
   --FIN 75765/10-01-2009/EFR

   -- V_DESDE := TO_DATE(TO_CHAR(VP_FECSYS + 1, 'DDMMYYYY' ), 'DDMMYYYY');
   -- Fin Modificacion

   --OCB-INI[31-03-2003]

   -- Inicio RA-200512160334 - 21/12/2005 - jr.-
   --   V_DESDE_LIMITE_CLIABO:=TO_DATE(TO_CHAR(VP_FECSYS + 1, 'DDMMYYYY HH24:MI:SS' ), 'DDMMYYYY HH24:MI:SS');
   V_DESDE_LIMITE_CLIABO:=TO_DATE(TO_CHAR(VP_FECSYS, 'DDMMYYYY HH24:MI:SS' ), 'DDMMYYYY HH24:MI:SS');
   -- Fin RA-200512160334 - 21/12/2005 - jr.-

   --OCB-FIN[31-03-2003]

   V_HASTA := V_DESDE - (1/(24*60*60));

   -- INI.MAM PH-200403240064 05.05.2004
   --VP_TABLA := 'FA_CICLFACT 1'; --COL-37559|12-02-2007|GEZ
   VP_TABLA := 'GA_INTARCEL';--COL-37559|12-02-2007|GEZ

   VP_ACT := 'S';
   -- FIN.MAM PH-200403240064 05.05.2004

   --INI COL-37559|12-02-2007|GEZ
   SELECT cod_uso
   INTO   sCodUsoActual
   FROM   ga_intarcel
   WHERE  cod_cliente = VP_CLIENTE
   AND    num_abonado = VP_ABONADO
   AND 	  SYSDATE BETWEEN fec_desde AND fec_hasta;
   --FIN COL-37559|12-02-2007|GEZ

   -- INI COL-35791|14-12-2006|PBR

   VP_TABLA := 'GA_INTARCEL ';
   VP_ACT := 'D';

   -- INI COL-36728|12-01-2007|AHA
   BEGIN

	 SELECT fec_desde
     INTO vFecDesdeProximo
     FROM GA_INTARCEL
     WHERE fec_desde > sysdate
     AND COD_CLIENTE =   VP_CLIENTE
     AND NUM_ABONADO =  VP_ABONADO;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     	  vFecDesdeProximo := NULL;
   END;
   -- FIN COL-36728|12-01-2007|AHA

    IF vFecDesdeProximo IS NOT NULL then

		   DELETE FROM GA_INTARCEL
           WHERE COD_CLIENTE = VP_CLIENTE
           AND NUM_ABONADO = VP_ABONADO
           AND FEC_DESDE=vFecDesdeProximo;

		   UPDATE GA_INTARCEL
		   SET FEC_HASTA= TO_DATE('31-12-3000','DD-MM-YYYY')
           WHERE COD_CLIENTE = VP_CLIENTE
           AND NUM_ABONADO = VP_ABONADO
		   AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

           DELETE FROM GA_INTARCEL_ACCIONES_TO
           WHERE COD_CLIENTE = VP_CLIENTE
           AND NUM_ABONADO = VP_ABONADO
           AND FEC_DESDE=vFecDesdeProximo;

    END IF;

	VP_TABLA := 'FA_CICLFACT 1';
   	VP_ACT := 'S';

    SELECT COD_CICLFACT
    INTO V_CICLFACT
    FROM FA_CICLFACT
    WHERE COD_CICLO = VP_CICLO
    AND VP_FECSYS BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

    IF VP_PRODUCTO = 1 THEN

      IF VP_ABONADO <> 0 THEN

	  	  -- INI.MAM PH-200403240064 05.05.2004
	  	  VP_TABLA := 'GA_ABOCEL 1';
      	  VP_ACT := 'S';
		  -- FIN.MAM PH-200403240064 05.05.2004

		  SELECT COD_USO INTO V_USO
          FROM GA_ABOCEL WHERE NUM_ABONADO=VP_ABONADO;

      END IF;

      IF V_USODESTINO IS NULL THEN
         VP_USO:=V_USO;
      ELSE
         VP_USO:=V_USODESTINO;
      END IF;

	  VP_TABLA := 'GE_FN_DEVVALPARAM'; --COL-37559|12-02-2007|GEZ

      V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM'); --GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');

	  -- INI.MAM PH-200403240064 05.05.2004
	  VP_TABLA := 'C1 1';
      VP_ACT := 'O';
	  -- FIN.MAM PH-200403240064 05.05.2004

	  OPEN C1;

	  LOOP

         --VP_TABLA := 'C1 2'; -- MAM PH-200403240064 05.05.2004-- COL-37559|12-02-2007|GEZ
         --VP_ACT := 'F';--COL-37559|12-02-2007|GEZ

         FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,
                       V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
                       V_FRIENDS,V_DIASESP,V_CELDA,
                       V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                       V_CELULAR,V_CICLO,
                       V_PLANCOM,V_PLANSERV,V_GRPSERV,
                       V_GRUPO,V_PORTADOR,V_USO;
         EXIT WHEN C1%NOTFOUND;

   	     --SPZ 24-05-2003
		 V_CANT_REG:=V_CANT_REG+1;

		 -- INI.MAM PH-200403240064 05.05.2004
         VP_TABLA := 'GA_ABOCEL 2';
         VP_ACT := 'S';
		 -- FIN.MAM PH-200403240064 05.05.2004


		 SELECT COD_TECNOLOGIA, NUM_SERIE
         INTO V_TECNOLOGIA, V_NUM_SERIE
         FROM GA_ABOCEL
         WHERE NUM_ABONADO = V_ABONADO;

      	 -- INI TMM_04026
         IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM Then
      	 -- FIN TMM_04026

		 	 -- INI.MAM PH-200403240064 05.05.2004
		 	 VP_TABLA := 'DUAL FRECUPERSIMCARD_FN 1';
         	 VP_ACT := 'S';
			 -- FIN.MAM PH-200403240064 05.05.2004

			 SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO  VNUM_IMSI FROM DUAL;

         END IF;

         VP_TABLA := 'GA_INTARCEL 1'; -- MAM PH-200403240064 05.05.2004
         VP_ACT := 'U';

         UPDATE GA_INTARCEL
         SET FEC_HASTA = V_HASTA
		   , NUM_IMSI = VNUM_IMSI
         WHERE ROWID = V_ROWID;

         VP_TABLA := 'GA_INTARCEL 2'; -- MAM PH-200403240064 05.05.2004
         VP_ACT := 'S';

         SELECT MIN(FEC_DESDE)
         INTO V_FECHASUP
         FROM GA_INTARCEL
         WHERE COD_CLIENTE = V_CLIENTE
         AND   NUM_ABONADO = V_ABONADO
         AND   IND_NUMERO = V_NUMERO
         AND   FEC_DESDE > VP_FECSYS;

         IF V_FECHASUP IS NULL THEN
            V_FECHASUP := V_FECHASTA;
         ELSE
            V_FECHASUP := V_FECHASUP - (1/(24*60*60));
         END IF;

		 BEGIN

         	  VP_TABLA := 'TA_PLANTARIF 1'; -- MAM PH-200403240064 05.05.2004
         	  VP_ACT := 'S';

         	  SELECT COD_CARGOBASICO INTO V_CARGOBASICO
         	  FROM TA_PLANTARIF
         	  WHERE COD_PLANTARIF = VP_PLANTARIF --ahott 26-02-2004 CH-200402241692 - HOM. HD-200403020326 RACB 11-03-04
         	  AND COD_PRODUCTO =  VP_PRODUCTO; -- ahott 26-02-2004 CH-200402241692 - HOM. HD-200403020326 RACB 11-03-04

		 	  --INI. HOM. HD-200403020326 RACB 11-03-04 - codigo no estaba en version Cuzco
		 	  V_FRIENDS:=0;

			  -- INI.MAM PH-200403240064 05.05.2004
		 	  VP_TABLA := 'GA_SERVSUPLABO-GA_GRUPOS_SERVSUP 1';
         	  VP_ACT := 'S';
			  -- FIN.MAM PH-200403240064 05.05.2004

		 	  SELECT COUNT(*)
         	  INTO V_FYF
         	  FROM GA_SERVSUPLABO A, GA_GRUPOS_SERVSUP B
         	  WHERE A.NUM_ABONADO = V_ABONADO
         	  AND A.COD_SERVICIO = B.COD_SERVICIO
         	  AND B.COD_GRUPO='FYFCEL'
         	  AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
         	  AND A.IND_ESTADO < 3;

         	  IF V_FYF > 0 THEN
              	 V_FRIENDS:=1;
         	  END IF;
		 	  --FIN HOM. HD-200403020326 RACB 11-03-04 - codigo no estaba en version Cuzco

            -- INI COL|43301|22/08/2007|SAQL
            BEGIN
               VP_TABLA := 'TA_PLANES_FRECUENTES';
         	   VP_ACT := 'S';
               SELECT COUNT(1) INTO NCANTIDAD
               FROM TA_PLANES_FRECUENTES
               WHERE COD_PLANTARIF = VP_PLANTARIF
               AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
               IF NCANTIDAD > 0 THEN
                  V_FRIENDS := 1;
               ELSE
                  V_FRIENDS := 0;
               END IF;
            EXCEPTION
               WHEN OTHERS THEN
                  V_FRIENDS := 0;
            END;
            -- FIN COL|43301|22/08/2007|SAQL

			  --CO-200608160325: German Espinoza Z; 14/08/2006
			  VP_TABLA := 'GA_PLANTECPLSERV';
         	  VP_ACT := 'S';
			  --FIN/CO-200608160325: German Espinoza Z; 14/08/2006

         	  --Inicio modificacion by SAQL/Soporte 12/02/2006 - RA-200602070717
         	  SELECT COD_PLANSERV INTO V_PLANSERV
         	  FROM GA_PLANTECPLSERV
         	  WHERE COD_PLANTARIF = VP_PLANTARIF
         	  AND COD_TECNOLOGIA = V_TECNOLOGIA; --CO-200607110231, 12/07/2006 PBR

			  BEGIN

			  	   --CO-200608160325: German Espinoza Z; 14/08/2006
				   VP_TABLA := 'TOL_LIMITE_PLAN_TD';
         	  	   VP_ACT := 'S';
				   --FIN/CO-200608160325: German Espinoza Z; 14/08/2006

              	   -- Inicio modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326
              	   /*
              	   SELECT COD_LIMCONS INTO V_LIMCONSUMO
            	   FROM TOL_LIMITE_PLAN_TD
            	   WHERE COD_PLANTARIF = VP_PLANTARIF
            	   --CO-200608160325: German Espinoza Z; 14/08/2006
				   --AND IND_DEFAULT = 'S';
				   AND IND_DEFAULT = 'S'
				   AND SYSDATE BETWEEN fec_desde AND fec_hasta;
				   --FIN/CO-200608160325: German Espinoza Z; 14/08/2006
		   		   */

		   		   SELECT B.IMP_LIMITE INTO V_LIMCONSUMO
		   		   FROM TOL_LIMITE_PLAN_TD A, TOL_LIMITE_TD B
		   		   WHERE A.COD_PLANTARIF = VP_PLANTARIF
		   		   AND A.COD_LIMCONS = B.COD_LIMCONS
		   		   AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
		   		   AND A.IND_DEFAULT = 'S';
		   		   -- Fin modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326

         	  EXCEPTION
              	WHEN NO_DATA_FOUND THEN
               		 V_LIMCONSUMO := 0;

         	  END;
         	  -- Fin modificacion by SAQL/Soporte 12/02/2006 - RA-200602070717

			  -- Inicio modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326
         	  VP_TABLA := 'TA_PLANTARIF';
         	  VP_ACT := 'S';

			  SELECT DECODE(COD_TIPLAN,GE_FN_DEVVALPARAM('GA','1','TIPOHIBRIDO'),'TRUE','FALSE')
         	  INTO V_COD_TIPLAN
         	  FROM TA_PLANTARIF
         	  WHERE COD_PLANTARIF = VP_PLANTARIF;

			  IF V_COD_TIPLAN = 'TRUE' THEN
         	     V_LIMCONSUMO := 0;
         	  END IF;
         	  -- Fin modificacion by SAQL/Soporte 24/08/2006 - CO-200608160326

              --INI COL-37559|12-02-2007|GEZ
         	  -- VP_TABLA := 'GA_INTARCEL 3'; -- MAM PH-200403240064 05.05.2004
              --VP_ACT := 'I';
              VP_TABLA := 'TA_PLANTARIF-TOL_LIMITE_TD';
         	  VP_ACT := 'S';
              --FIN COL-37559|12-02-2007|GEZ

           IF V_LIMCONSUMO IS NULL THEN -- COL|43725|10/09/2007|SAQL
			  -- INI COL-35791|14-12-2006|PBR
		 	  SELECT B.IMP_LIMITE
		 	  INTO V_LIMCONSUMO
		 	  FROM TA_PLANTARIF A, TOL_LIMITE_TD B
		 	  WHERE A.COD_PLANTARIF=VP_PLANTARIF
		 	  AND A.COD_PRODUCTO =  1
		 	  AND B.COD_LIMCONS=A.COD_LIMCONSUMO
		 	  AND sysdate BETWEEN b.fec_desde and b.fec_hasta;
		 	  -- FIN COL-35791|14-12-2006|PBR
           END IF; -- COL|43725|10/09/2007|SAQL

			  VP_TABLA := 'GA_INTARCEL 3'; --COL-37559|12-02-2007|GEZ
         	  VP_ACT := 'I'; --COL-37559|12-02-2007|GEZ

         	  INSERT INTO GA_INTARCEL
                    (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                     FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                     IND_FRIENDS,IND_DIASESP,COD_CELDA,
                     TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                     NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                     COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                     COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
              VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                     V_DESDE,V_FECHASUP,V_LIMCONSUMO,
                     V_FRIENDS,V_DIASESP,V_CELDA,
                     V_TIPPLANTARIF,VP_PLANTARIF,V_SERIE,
                     V_CELULAR,V_CARGOBASICO,V_CICLO,
                     V_PLANCOM,V_PLANSERV,V_GRPSERV,
                     VP_GRUPO,V_PORTADOR,VP_USO,VNUM_IMSI);

			  VP_TABLA := 'PV_ACTUALIZA_CAMB_COMERC_PR';--COL-37559|12-02-2007|GEZ
         	  VP_ACT := 'P';--COL-37559|12-02-2007|GEZ

        	  PV_ACTUALIZA_CAMB_COMERC_PR(V_CLIENTE,
                                    V_ABONADO,
                                    V_NUMERO,
                                    --'CT', -- COL-44902|12-10-2007|EFR
                                    'PI', -- COL-44902|12-10-2007|EFR
                                    V_DESDE_LIMITE_CLIABO,
                                    vErrorAplic,
                                    vErrorGlosa,
                                    vErrorOra,
                                    vErrorOraGlosa,
                                    vTrace);

			  --INI COL-37559|12-02-2007|GEZ
			  VP_TABLA := 'GE_FN_DEVVALPARAM1';
         	  VP_ACT := 'F';

			  sCodUsoPostPago := GE_FN_DEVVALPARAM('GA', 1, 'USO_LINEA');

			  VP_TABLA := 'GE_FN_DEVVALPARAM2';
         	  VP_ACT := 'F';

   			  sCodUsoHibrido  := GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA');

			  IF TO_CHAR(sCodUsoActual)=sCodUsoPostPago AND TO_CHAR(VP_USO)=sCodUsoHibrido THEN

				   VP_TABLA := 'GA_INTARCEL_ACCIONES_TO';
         	  	   VP_ACT := 'I';

				  INSERT INTO GA_INTARCEL_ACCIONES_TO
			            (
			             COD_CLIENTE,
			             NUM_ABONADO,
			             IND_NUMERO,
			             FEC_DESDE,
			             COD_ACTABO,
			             NOM_USUARORA,
			             FEC_INGRESO
			            )
			      VALUES
			            (
			             V_CLIENTE,
			             V_ABONADO,
			             V_NUMERO,
			             V_DESDE_LIMITE_CLIABO,
			             'BA',
			             USER,
			             SYSDATE
			      );

			  END IF;
			  --FIN COL-37559|12-02-2007|GEZ

         EXCEPTION
         	WHEN OTHERS THEN
            	IF SQLCODE = -1 THEN

					-- INI.MAM PH-200403240064 05.05.2004
			   		VP_TABLA := 'GA_INTARCEL 4';
         			VP_ACT := 'U';
					-- FIN.MAM PH-200403240064 05.05.2004

					UPDATE GA_INTARCEL
                    SET COD_PLANTARIF=VP_PLANTARIF, COD_USO=VP_USO, NUM_IMSI =VNUM_IMSI
                    WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND IND_NUMERO = V_NUMERO
                    AND FEC_DESDE =   V_DESDE;
           		ELSE
                	VP_ERROR := '4';

					--CO-200608160325: German Espinoza Z; 14/08/2006
					VP_SQLCODE := SQLCODE;
        			VP_SQLERRM := SUBSTR(SQLERRM,1,100);
					--CO-200608160325: German Espinoza Z; 14/08/2006

           		END IF;
         END;

		 --CO-200608160325: German Espinoza Z; 14/08/2006
		 IF VP_ERROR=0 THEN
		 --FIN/CO-200608160325: German Espinoza Z; 14/08/2006

	         VP_TABLA := 'TA_PLANTARIF 2'; -- MAM PH-200403240064 05.05.2004
	         VP_ACT := 'S';

	         SELECT COD_CARGOBASICO INTO V_CARGOBASICO
	         FROM TA_PLANTARIF
	         WHERE COD_PLANTARIF = VP_PLANTARIF --ahott 25-02-2004 CH-200402241692 - HOM. HD-200403020326 RACB 11-03-04
	         AND COD_PRODUCTO =  VP_PRODUCTO; -- ahott 25-02-2004 CH-200402241692 - HOM. HD-200403020326 RACB 11-03-04

			 VP_TABLA := 'GA_INTARCEL 5'; -- MAM PH-200403240064 05.05.2004
	         VP_ACT := 'U';

			 UPDATE GA_INTARCEL
	         SET COD_PLANTARIF = VP_PLANTARIF,
	             COD_CARGOBASICO = V_CARGOBASICO,
	             COD_USO=VP_USO, NUM_IMSI =VNUM_IMSI  --CEM
	         WHERE COD_CLIENTE = V_CLIENTE
	         AND NUM_ABONADO = V_ABONADO
	         AND IND_NUMERO = V_NUMERO
	         AND FEC_DESDE > VP_FECSYS;

		 --CO-200608160325: German Espinoza Z; 14/08/2006
		 END IF;
		 --FIN/CO-200608160325: German Espinoza Z; 14/08/2006

      END LOOP;

	  --CO-200608160325: German Espinoza Z; 14/08/2006
      --VP_TABLA := 'C1 3';  -- MAM PH-200403240064 05.05.2004
      --VP_ACT := 'C';
	  --FIN/CO-200608160325: German Espinoza Z; 14/08/2006

	  CLOSE C1;

	  --SPZ 24-05-2003
      IF V_CANT_REG <=0 THEN
            RAISE ERROR_PROCESO;
      END IF;

   ELSIF VP_PRODUCTO = 2 THEN

      VP_TABLA := 'GA_INTARBEEP 1'; -- MAM PH-200403240064 05.05.2004
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
         AND VP_FECSYS BETWEEN FEC_DESDE
                           AND FEC_HASTA;

      VP_TABLA := 'GA_INTARBEEP 2'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'U';

      UPDATE GA_INTARBEEP
         SET FEC_HASTA = V_HASTA
       WHERE ROWID = V_ROWID;

      VP_TABLA := 'GA_INTARBEEP 3'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'S';

      SELECT MIN(FEC_DESDE)
        INTO V_FECHASUP
        FROM GA_INTARBEEP
       WHERE COD_CLIENTE = V_CLIENTE
         AND NUM_ABONADO = V_ABONADO
         AND FEC_DESDE > VP_FECSYS;
      IF V_FECHASUP IS NULL THEN
         V_FECHASUP := V_FECHASTA;
      ELSE
         V_FECHASUP := V_FECHASUP - (1/(24*60*60));
      END IF;

      VP_TABLA := 'TA_PLANTARIF 3'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'S';

      SELECT COD_CARGOBASICO INTO V_CARGOBASICO
      FROM TA_PLANTARIF
      WHERE COD_PLANTARIF = VP_PLANTARIF
      AND COD_PRODUCTO=VP_PRODUCTO;

      VP_TABLA := 'GA_INTARBEEP 4'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'I';

      BEGIN
      INSERT INTO GA_INTARBEEP
                 (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                  FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                  TIP_PLANTARIF,COD_PLANTARIF,CAP_CODE,
                  NUM_BEEPER,COD_CARGOBASICO,COD_CICLO,
                  COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                  COD_GRUPO)
          VALUES (V_CLIENTE,V_ABONADO,V_DESDE,
                  V_FECHASUP,V_LIMCONSUMO,V_DIASESP,
                  V_TIPPLANTARIF,VP_PLANTARIF,V_CAPCODE,
                  V_BEEPER,V_CARGOBASICO,V_CICLO,
                  V_PLANCOM,V_PLANSERV,V_GRPSERV,
                  VP_GRUPO);
          EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1 THEN
			-- INI.MAM PH-200403240064 05.05.2004
			   		VP_TABLA := 'GA_INTARBEEP 5';
      				VP_ACT := 'U';
			-- FIN.MAM PH-200403240064 05.05.2004
                    UPDATE GA_INTARBEEP
                             SET COD_PLANTARIF=VP_PLANTARIF
                              WHERE COD_CLIENTE = V_CLIENTE
                              AND NUM_ABONADO = V_ABONADO
                              AND FEC_DESDE =   V_DESDE;
           ELSE
                 VP_ERROR := '4';
           END IF;
         END;
		 -- INI.MAM PH-200403240064 05.05.2004
		 VP_TABLA := 'TA_PLANTARIF 4';
		 VP_ACT := 'I';
		 -- FIN.MAM PH-200403240064 05.05.2004
         SELECT COD_CARGOBASICO INTO V_CARGOBASICO
         FROM TA_PLANTARIF
         WHERE COD_PLANTARIF = VP_PLANTARIF
         AND COD_PRODUCTO=VP_PRODUCTO;

         VP_TABLA := 'GA_INTARBEEP 6'; -- MAM PH-200403240064 05.05.2004
         VP_ACT := 'U';

         UPDATE GA_INTARBEEP
            SET COD_PLANTARIF = VP_PLANTARIF,
                COD_CARGOBASICO=V_CARGOBASICO
          WHERE COD_CLIENTE = V_CLIENTE
            AND NUM_ABONADO = V_ABONADO
            AND FEC_DESDE > VP_FECSYS;

    ELSIF VP_PRODUCTO = 4 THEN

      VP_TABLA := 'GA_INTARTREK 1'; -- MAM PH-200403240064 05.05.2004
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
         AND VP_FECSYS BETWEEN FEC_DESDE
                           AND FEC_HASTA;

      VP_TABLA := 'GA_INTARTREK 2'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'U';

      UPDATE GA_INTARTREK
         SET FEC_HASTA = V_HASTA
       WHERE ROWID = V_ROWID;

      VP_TABLA := 'GA_INTARTREK 3'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'S';

      SELECT MIN(FEC_DESDE)
        INTO V_FECHASUP
        FROM GA_INTARTREK
       WHERE COD_CLIENTE = V_CLIENTE
         AND NUM_ABONADO = V_ABONADO
         AND FEC_DESDE > VP_FECSYS;

      IF V_FECHASUP IS NULL THEN
         V_FECHASUP := V_FECHASTA;
      ELSE
         V_FECHASUP := V_FECHASUP - (1/(24*60*60));
      END IF;

	  VP_TABLA := 'GA_INTARTREK 4'; -- MAM PH-200403240064 05.05.2004
      VP_ACT := 'I';

      BEGIN
      INSERT INTO GA_INTARTREK
                 (COD_CLIENTE,NUM_ABONADO,FEC_DESDE,
                  FEC_HASTA,IMP_LIMCONSUMO,IND_DIASESP,
                  TIP_PLANTARIF,COD_PLANTARIF,NUM_MAN,
                  COD_CARGOBASICO,COD_CICLO,COD_PLANCOM,
                  COD_PLANSERV,COD_GRPSERV,NUM_SERIE,
                  COD_GRUPO)
          VALUES (V_CLIENTE,V_ABONADO,V_DESDE,
                  V_FECHASUP,V_LIMCONSUMO,V_DIASESP,
                  V_TIPPLANTARIF,V_PLANTARIF,V_MAN,
                  V_CARGOBASICO,V_CICLO,V_PLANCOM,
                  V_PLANSERV,V_GRPSERV,VP_PLANTARIF,
                  VP_GRUPO);



       EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1 THEN
			-- INI.MAM PH-200403240064 05.05.2004
					VP_TABLA := 'GA_INTARTREK 5';
					VP_ACT := 'U';
               		-- FIN.MAM PH-200403240064 05.05.2004
                    UPDATE GA_INTARTREK
                             SET COD_PLANTARIF=VP_PLANTARIF
                              WHERE COD_CLIENTE = V_CLIENTE
                              AND NUM_ABONADO = V_ABONADO
                              AND FEC_DESDE =   V_DESDE;
           ELSE
                 VP_ERROR := '4';
           END IF;
         END;
	  -- INI.MAM PH-200403240064 05.05.2004
	  VP_TABLA := 'GA_INTARTREK 6';
	  VP_ACT := 'U';
	  -- FIN.MAM PH-200403240064 05.05.2004
      UPDATE GA_INTARTREK
         SET COD_PLANTARIF = VP_PLANTARIF
       WHERE COD_CLIENTE = V_CLIENTE
         AND NUM_ABONADO = V_ABONADO
         AND FEC_DESDE > VP_FECSYS;


    END IF;

EXCEPTION

   WHEN ERROR_PROCESO THEN

        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := 'NO EXISTE PERIODO VIGENTE DE TARIFICACION';
        VP_ERROR := '4';

   WHEN OTHERS THEN
   		VP_SQLCODE := SQLCODE;
 		VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
