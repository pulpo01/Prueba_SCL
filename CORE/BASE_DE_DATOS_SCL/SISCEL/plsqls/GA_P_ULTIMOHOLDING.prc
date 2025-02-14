CREATE OR REPLACE PROCEDURE GA_P_ULTIMOHOLDING
(                            VP_ABONADO       IN            NUMBER,
                             VP_PRODUCTO      IN            NUMBER,
                             VP_TIPPLANTARIF  IN            VARCHAR2,
                             VP_HOLDING       IN            NUMBER,
                             VP_PROC          IN OUT        VARCHAR2,
                             VP_TABLA         IN OUT        VARCHAR2,
                             VP_ACT           IN OUT        VARCHAR2,
                             VP_ACTUA         IN            VARCHAR2,
                             VP_SQLCODE       IN OUT        VARCHAR2,
                             VP_SQLERRM       IN OUT        VARCHAR2,
                             VP_ERROR         IN OUT        VARCHAR2, -- ahott 15-02-2006 - RA-759
                             EV_ACTABO        IN            VARCHAR := NULL) -- ahott 15-02-2006 - RA-759
IS

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : GA_P_ULTIMOHOLDING
-- * Descripcisn        :
-- *
-- * Fecha de creacisn  : 14-01-2003 22:53
-- * Responsable        : AREA POSVENTA
-- *************************************************************

--GA_P_ULTIMOHOLDING  v1.0 //TM-200501111203: German Espinoza Z; 21/01/2005 se agrego condicion*/
--GA_P_ULTIMOHOLDING  v1.1 //ahott 15-02-2006 - RA-759
--GA_P_ULTIMOHOLDING  v1.2 //SAQL/Soporte 17/07/2006 - CO-200607050216
--GA_P_ULTIMOHOLDING  v1.3 //COL-61078|11-01-2008|GEZ
--GA_P_ULTIMOHOLDING  v1.4 //COL-72424|03-11-2008|GEZ
--GA_P_ULTIMOHOLDING  v1.5 //COL-72424|28-11-2008|GEZ

  VP_TIPPLANTARIF_AUX      		GA_ABOCEL.TIP_PLANTARIF%TYPE; -- ahott 15-02-2006 - RA-759
  V_ROWID                       VARCHAR2(19);
  V_CLIENTE                     GA_ABOCEL.COD_CLIENTE%TYPE;
  V_TERMINAL                    GA_ABOCEL.NUM_CELULAR%TYPE;
  IND_VALOR                     NUMBER;
  IND_VALOR2                    NUMBER;
  IND_ROWNUM                    NUMBER;

  /*TM-200501111203: German Espinoza Z; 21/01/2005*/
  nCod_Ciclo                    GA_ABOCEL.COD_CICLO%TYPE;
  nCod_CiclFact                 FA_CICLFACT.COD_CICLFACT%TYPE;
  /*FIN - TM-200501111203: German Espinoza Z; 21/01/2005*/

  ERROR_PROCESO                 EXCEPTION;

  /* Variables de salida para PV_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR */
  PvCodValor               	    VARCHAR2(50);
  pvErrorGlosa                  VARCHAR2(250);
  pvTrace                  		VARCHAR2(250);
  /* Fin Variables de salida para V_LIMITE_CONSUMO_PG.PV_OPERA_LIMITE_PR */

  --INI COL-72424|03-11-2008|GEZ
  LNCantAboAct					   NUMBER;
  LNEsOOSSProg 					 NUMBER; --0: no es programada, 1: es programada
  LVCodOSBajaAbo	  			ged_parametros.val_parametro%TYPE;
  LVCodOSBajaOpta	  			ged_parametros.val_parametro%TYPE;
  LVCodOSSolicBaja				 ged_parametros.val_parametro%TYPE;

  LVFecCorteBajaAbo	  			ged_parametros.val_parametro%TYPE;
  LVFecCorteBajaOpta	  		ged_parametros.val_parametro%TYPE;
  LVFecCorteSolicBaja			ged_parametros.val_parametro%TYPE;

  LVMaxIntentosOOSS  		  ged_parametros.val_parametro%TYPE;

  LVCodOsBaja					  pv_iorserv.cod_os%TYPE;
  LD_FecProg					   pv_iorserv.fh_ejecucion%TYPE;

  LVCodPlanEmp					ga_abocel.cod_plantarif%TYPE;

  LDFecBaja						DATE;
  --FIN COL-72424|03-11-2008|GEZ

BEGIN
  --PL que comprueba si el abonado que se esta dando de baja y tarifario
  --Holding o Empresa es el ultimo . si es asm Elimina el abonado 0 de
  --Interface con Facturacion y Tarificacion
  --Retorna 0 si todo funciono, 4 si se produjo algzn error
  --
  	 BEGIN
     	  VP_PROC := 'GA_P_ULTIMOHOLDING';
		  VP_TIPPLANTARIF_AUX :=VP_TIPPLANTARIF; -- ahott 15-02-2006 - RA-759

		  IF VP_PRODUCTO = 1 THEN
          	 BEGIN
	             /* Inicio modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
	             -- Inicio - Ahott 14-02-2006 - Soporte Inc. RA-759
	             /* IF EV_ACTABO = 'AE' OR EV_ACTABO = 'A2' OR EV_ACTABO = 'TP' THEN  */
	             IF EV_ACTABO = 'AE' OR EV_ACTABO = 'A2' OR EV_ACTABO = 'TP' OR EV_ACTABO = 'T2' THEN
	             /* Fin modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */

	             	VP_TIPPLANTARIF_AUX := 'E';

	                VP_TABLA        := 'GA_ABOCEL-ID'; --COL-61078|11-01-2008|GEZ
	                VP_ACT          := 'S';            --COL-61078|11-01-2008|GEZ

	                SELECT ROWID INTO V_ROWID
	                FROM GA_ABOCEL
	                WHERE TIP_PLANTARIF =   VP_TIPPLANTARIF_AUX
	                AND COD_EMPRESA = VP_HOLDING
	                AND NUM_ABONADO <> VP_ABONADO
	                AND COD_SITUACION NOT IN ('BAA','BAP', 'TVP','AOA','AOP','ATA', 'ATP','RDA','CVA','AOS','ATS','REA','REP')
	                AND NUM_ABONADO <> 0
	                AND ROWNUM = 1;

	                VP_TABLA        := 'GA_ABOCEL'; --COL-61078|11-01-2008|GEZ
	                VP_ACT          := 'U';         --COL-61078|11-01-2008|GEZ

	                UPDATE GA_ABOCEL
	                SET COD_EMPRESA = NULL
	                WHERE NUM_ABONADO = VP_ABONADO
	                AND tip_plantarif<>'E';                --COL-61078|11-01-2008|GEZ

				 --INI COL-72424|03-11-2008|GEZ
				 ELSIF EV_ACTABO = 'BA' THEN
				 	   BEGIN

						   VP_TABLA        := 'GA_ABOCELA';
		                   VP_ACT          := 'S';

						   SELECT cod_cliente,cod_ciclo,cod_plantarif
	                       INTO   V_CLIENTE,NCOD_CICLO,LVCodPlanEmp
	                 	   FROM   ga_abocel
	                 	   WHERE  num_abonado=VP_ABONADO;

						   VP_TABLA        := 'GA_ABOCELB';
		                   VP_ACT          := 'S';

						   SELECT COUNT(1)
						   INTO   LNCantAboAct
		                   FROM   ga_abocel
		                   WHERE  tip_plantarif =  VP_TIPPLANTARIF_AUX
						   AND	  cod_cliente   =  V_CLIENTE
		                   AND 	  num_abonado   <> VP_ABONADO
		                   AND 	  cod_situacion NOT IN ('BAA','BAP', 'TVP','AOA','AOP','ATA', 'ATP','RDA','CVA','AOS','ATS','REA','REP')
		                   AND 	  num_abonado   <> 0;

						   IF LNCantAboAct=0 THEN

							   LVCodOSBajaAbo	 := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_ABONADO');
	   					   	   LVCodOSBajaOpta	 := GE_FN_DEVVALPARAM('GA',1,'CODOS_BAJA_OPTAPREPA');
						   	   LVCodOSSolicBaja  := GE_FN_DEVVALPARAM('GA',1,'CODOS_SOLICITUD_BAJA');

	   					   	   LVMaxIntentosOOSS := GE_FN_DEVVALPARAM('GA',1,'MAX_INTENTOS');

							   BEGIN
								   VP_TABLA := 'IORSERV-CAMCOM';
							   	   VP_ACT := 'S';

								   SELECT cod_os,DECODE(a.fh_ejecucion,NULL,0,1),a.fh_ejecucion
								   INTO	  LVCodOsBaja,LNEsOOSSProg,LD_FecProg
								   FROM   pv_iorserv a,pv_camcom b
								   WHERE  b.num_abonado  =  VP_ABONADO
								   AND 	  a.num_os  	 =  b.num_os
								   AND	  a.cod_os 		 IN (LVCodOSBajaAbo,LVCodOSBajaOpta,LVCodOSSolicBaja)
								   AND	  a.cod_estado	 =  210
								   AND	  NVL(a.num_intentos,0) <  TO_NUMBER(LVMaxIntentosOOSS);
							   EXCEPTION
							   		WHEN OTHERS THEN
										 LNEsOOSSProg:=0;
							   END;

							   VP_TABLA := 'FA_CICLFACT';
							   VP_ACT   := 'S';

							   SELECT fec_hastallam,cod_ciclfact
							   INTO     LDFecBaja,nCod_CiclFact
							   FROM    fa_ciclfact
							   WHERE  cod_ciclo=NCOD_CICLO
							   AND 	    NVL(LD_FecProg,SYSDATE)  BETWEEN fec_desdellam AND fec_hastallam;

							   --IF LNEsOOSSProg = 0 THEN  RRG 19-12-2008 COL 72424
							   IF LNEsOOSSProg = 0 OR TRUNC(LD_FecProg) = TRUNC(SYSDATE) THEN -- RRG 19-12-2008 COL 72424
							   	  LDFecBaja:=SYSDATE;
							   ELSE

								   IF LVCodOsBaja = LVCodOSBajaAbo THEN
									   LVFecCorteBajaAbo	 := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_ABO');

									   IF LVFecCorteBajaAbo='FALSE' THEN
									   	  LDFecBaja:=SYSDATE;
									   END IF;
								   ELSIF  LVCodOsBaja = LVCodOSBajaOpta THEN
									   LVFecCorteBajaOpta	 := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_BAJA_OPTA');

									   IF LVFecCorteBajaOpta='FALSE' THEN
									   	  LDFecBaja:=SYSDATE;
									   END IF;
								   ELSIF  LVCodOsBaja = LVCodOSSolicBaja THEN
									   LVFecCorteSolicBaja	 := GE_FN_DEVVALPARAM('GA',1,'FEC_CORTE_SOLIC_BAJA');

									   IF LVFecCorteSolicBaja='FALSE' THEN
									   	  LDFecBaja:=SYSDATE;
									   END IF;
								   END IF;

							   END IF;

							   VP_TABLA        := 'GA_INTARCEL';
                 	 		   VP_ACT          := 'U';

                 	 		   UPDATE GA_INTARCEL
                 	 		   SET 	  fec_hasta =LDFecBaja
                 	 		   WHERE  cod_cliente = V_CLIENTE
                 	 		   AND 	  num_abonado = 0
                 	 		   AND 	  SYSDATE BETWEEN fec_desde AND fec_hasta;

							   VP_TABLA := 'GAH_INTARCEL';
						   	   VP_ACT := 'I';

							   INSERT INTO gah_intarcel(
							   COD_CLIENTE, NUM_ABONADO, IND_NUMERO, FEC_DESDE, FEC_HASTA, IMP_LIMCONSUMO, IND_FRIENDS, IND_DIASESP
							   , COD_CELDA, TIP_PLANTARIF, COD_PLANTARIF, NUM_SERIE, NUM_CELULAR, COD_CARGOBASICO, COD_CICLO
							   , COD_PLANCOM, COD_PLANSERV, COD_GRPSERV, COD_GRUPO, COD_PORTADOR, COD_USO, FEC_HISTORICO, NUM_IMSI, NUM_MIN_MDN)
							   SELECT COD_CLIENTE, NUM_ABONADO, IND_NUMERO, FEC_DESDE, FEC_HASTA, IMP_LIMCONSUMO, IND_FRIENDS, IND_DIASESP
							   , COD_CELDA, TIP_PLANTARIF, COD_PLANTARIF, NUM_SERIE, NUM_CELULAR, COD_CARGOBASICO, COD_CICLO
							   , COD_PLANCOM, COD_PLANSERV, COD_GRPSERV, COD_GRUPO, COD_PORTADOR, COD_USO, SYSDATE, NUM_IMSI, NUM_MIN_MDN
							   FROM  ga_intarcel
							   WHERE cod_cliente = V_CLIENTE
						       AND 	 num_abonado = 0
						       AND 	 fec_desde 	 > SYSDATE;

							   VP_TABLA := 'GA_INTARCEL';
                 	 		   VP_ACT := 'D';

                 	 		   DELETE ga_intarcel
                 	 		   WHERE cod_cliente = V_CLIENTE
                 	 		   AND num_abonado   = 0
                 	 		   AND fec_desde 	 > SYSDATE;

							   VP_TABLA := 'TOL_CLIENTE_TD';
                 	 		   VP_ACT := 'D';

                 	 		   DELETE tol_cliente_td
                 	 		   WHERE  cod_cliente = V_CLIENTE
                 	 		   AND 	  cod_abonado = 0
                 	 		   AND 	  fec_ini_vig > SYSDATE;

							   VP_TABLA := 'GA_INFACCEL';
                 	 		   VP_ACT := 'D';

							   UPDATE ga_infaccel
                 	 		   SET 	  fec_baja=LDFecBaja,
                 	 		   		  ind_actuac = 2
                 	 		   WHERE  cod_cliente=V_CLIENTE
                 	 		   AND 	  num_abonado = 0
                 	 		   AND 	  ind_actuac = 1
                     		   AND 	  cod_ciclfact=nCod_CiclFact;

							   VP_TABLA := 'GA_LIMITE_CLIABO_TO';
                 	 		   VP_ACT   := 'U';

							   UPDATE ga_limite_cliabo_to
                 	 		   SET    fec_hasta   = LDFecBaja
                 	 		   WHERE  num_abonado = 0
                 	 		   AND 	  cod_cliente = v_cliente
							   AND	  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE)
							   AND 	  cod_plantarif=LVCodPlanEmp;

							   VP_TABLA := 'GA_LIMITE_CLIABO_TH';
                 	 		   VP_ACT := 'I';

							   INSERT INTO ga_limite_cliabo_th
							   (cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, fec_historico
							   , fec_hasta, nom_usuarora, fec_asignacion, cod_causa_hist, est_aplica_tol, fec_aplica_tol)
							   SELECT cod_cliente, num_abonado, cod_limcons, cod_plantarif, fec_desde, SYSDATE
							   , fec_hasta, nom_usuarora, fec_asignacion,'BA', est_aplica_tol, fec_aplica_tol
							   FROM ga_limite_cliabo_to
							   WHERE  cod_cliente   = V_CLIENTE
                 	 		   AND 	  num_abonado   = 0
                 	 		   AND 	  fec_desde     > SYSDATE
							   AND 	  cod_plantarif = LVCodPlanEmp;

							   VP_TABLA := 'GA_LIMITE_CLIABO_TO';
                 	 		   VP_ACT := 'D';

                 	 		   DELETE ga_limite_cliabo_to
                 	 		   WHERE  cod_cliente   = V_CLIENTE
                 	 		   AND 	  num_abonado   = 0
                 	 		   AND 	  fec_desde     > SYSDATE
							   AND 	  cod_plantarif = LVCodPlanEmp;

						   END IF;

						   VP_ERROR    := '0';
						   VP_PROC	   := '0';
						   VP_SQLCODE  := '0';
         				   VP_SQLERRM  := '0';

					   EXCEPTION
					   		WHEN OTHERS THEN
								 VP_ERROR 	 	 := '4';
         						 VP_SQLCODE      := SQLCODE;
         						 VP_SQLERRM      := SQLERRM;
					   END;

				 --FIN COL-72424|03-11-2008|GEZ

	             ELSE
	                -- Fin - Ahott 14-02-2006 - Soporte Inc. RA-759
	                IF VP_TIPPLANTARIF = 'H' THEN

	                     VP_TABLA        := 'GA_ABOCEL';
	                     VP_ACT          := 'S';

	                     SELECT ROWID INTO V_ROWID FROM GA_ABOCEL
	                     WHERE TIP_PLANTARIF = VP_TIPPLANTARIF
	                  	 AND COD_HOLDING = VP_HOLDING
	                  	 AND NUM_ABONADO <> VP_ABONADO
	                  	 AND COD_SITUACION NOT IN ('BAA','BAP', 'TVP','AOA','AOP','ATA', 'ATP','RDA','CVA','AOS','ATS','REA','REP')
	                  	 AND NUM_ABONADO <> 0 AND ROWNUM = 1;

	                ELSIF VP_TIPPLANTARIF = 'E' THEN

	                      VP_TABLA        := 'GA_ABOCEL';
	                  	  VP_ACT          := 'S';

	                  	  SELECT ROWID INTO V_ROWID FROM GA_ABOCEL
	                  	  WHERE TIP_PLANTARIF = VP_TIPPLANTARIF
	                  	  AND COD_EMPRESA = VP_HOLDING
	                  	  AND NUM_ABONADO <> VP_ABONADO
	                  	  AND COD_SITUACION NOT IN ('BAA','BAP', 'TVP','AOA','AOP','ATA', 'ATP','RDA','CVA','AOS','ATS','REA','REP')
	                  	  AND NUM_ABONADO <> 0 AND ROWNUM = 1;
	                END IF;
	             END IF; --AHOTT RA-759 14-02-2005

        	 EXCEPTION
             	WHEN NO_DATA_FOUND THEN
					 /*TM-200501111203: German Espinoza Z; 21/01/2005*/
                     --VP_TABLA        := 'GA_INTARCEL';
                     VP_TABLA        := 'GA_EMPRESA';
                     /*FIN - TM-200501111203: German Espinoza Z; 21/01/2005*/

                 	 VP_ACT          := 'S';
                 	 IND_VALOR := 0;
                 	 IND_ROWNUM := 1;

                 	 /*TM-200501111203: German Espinoza Z; 21/01/2005*/
                     --solo se agrega campo cod_ciclo
                     SELECT COD_CLIENTE,cod_ciclo
                     INTO V_CLIENTE,nCod_Ciclo
                 	 FROM GA_EMPRESA
                 	 WHERE COD_EMPRESA=VP_HOLDING;

                     VP_TABLA := 'FA_CICLFACT';
                 	 VP_ACT   := 'S';

                     SELECT cod_ciclfact
                     INTO nCod_CiclFact
                     FROM fa_ciclfact
                     WHERE cod_ciclo=nCod_Ciclo
                     AND SYSDATE BETWEEN fec_desdellam AND  fec_hastallam;

                     /*FIN - TM-200501111203: German Espinoza Z; 21/01/2005*/

                 	 VP_TABLA        := 'GA_INTARCEL';
                 	 VP_ACT          := 'U';

                 	 UPDATE GA_INTARCEL
                 	 SET FEC_HASTA =SYSDATE
                 	 WHERE COD_CLIENTE = V_CLIENTE
                 	 AND NUM_ABONADO = IND_VALOR
                 	 AND TIP_PLANTARIF = VP_TIPPLANTARIF_AUX -- ahott 16-02-2006 - RA-759
                 	 AND COD_GRUPO = VP_HOLDING
                 	 AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                 	 VP_TABLA := 'GA_INTARCEL';
                 	 VP_ACT := 'D';

                 	 DELETE GA_INTARCEL
                 	 WHERE COD_CLIENTE = V_CLIENTE
                 	 AND NUM_ABONADO = IND_VALOR
                 	 AND TIP_PLANTARIF = VP_TIPPLANTARIF_AUX -- ahott 16-02-2006 - RA-759
                 	 AND COD_GRUPO = VP_HOLDING
                 	 AND FEC_DESDE > SYSDATE;

                 	 VP_TABLA        := 'GA_INFACCEL';
                 	 VP_ACT          := 'D';

                 	 IF VP_ACTUA = 'T' THEN
                     	IND_VALOR2 := 3;
                 	 ELSE
                        IND_VALOR2 := 2;
                     END IF;

                 	 UPDATE GA_INFACCEL
                 	 SET FEC_BAJA=SYSDATE,
                 	 IND_ACTUAC = IND_VALOR2
                 	 WHERE COD_CLIENTE=V_CLIENTE
                 	 AND NUM_ABONADO = IND_VALOR
                 	 AND IND_ACTUAC = 1
                     AND cod_ciclfact=nCod_CiclFact; /*TM-200501111203: German Espinoza Z; 21/01/2005 se agrego condicion*/

                     -- Inicio - Ahott 14-02-2006 - Soporte Inc. RA-759
                 	 --PV_LIMITE_CONSUMO_PG.PV_LC_HISTORICO_PR (V_CLIENTE,'C','*','*','0',PvCodValor,VP_ERROR,pvErrorGlosa,VP_SQLCODE,VP_SQLERRM,pvTrace);

                 	 UPDATE GA_LIMITE_CLIABO_TO
                 	 SET    FEC_HASTA   = SYSDATE - (1/(24*60*60))
                 	 WHERE  NUM_ABONADO = IND_VALOR
                 	 AND 	COD_CLIENTE = V_CLIENTE;
                 	 -- Fin - Ahott 14-02-2006 - Soporte Inc. RA-759

                 	 IF PvCodValor='FALSE' THEN
                         VP_ERROR := '4';
                         RAISE ERROR_PROCESO;
                     ELSE
                     	 VP_ERROR:='0';
                     END IF;

                WHEN OTHERS THEN
                 	 VP_ERROR := '4';
                 	 RAISE ERROR_PROCESO;
             END;
     END IF;
  EXCEPTION
     WHEN ERROR_PROCESO THEN
         VP_SQLCODE      := SQLCODE;
         VP_SQLERRM      := SQLERRM;
     WHEN OTHERS THEN
         VP_ERROR 	 	 := '4';
         VP_SQLCODE      := SQLCODE;
         VP_SQLERRM      := SQLERRM;
    END;
END GA_P_ULTIMOHOLDING;
/
SHOW ERRORS
