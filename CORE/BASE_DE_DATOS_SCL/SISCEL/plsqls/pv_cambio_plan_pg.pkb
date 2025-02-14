CREATE OR REPLACE PACKAGE BODY PV_CAMBIO_PLAN_PG IS

CN_Version_Body VARCHAR2(10):='01.00.00';		   --COL-77303|18-02-2009|GEZ

--INI COL-77303|18-02-2009|GEZ
FUNCTION pv_version_body_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Body;
END;

FUNCTION pv_version_header_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Header;
END;

PROCEDURE pv_estado_reproceso_cpu_pr(  EN_NumId              IN                      ge_aud_regulariza_td.num_identificador%TYPE,
														   EN_EstadoFin         IN                      ge_aud_regulariza_td.cod_estado%TYPE,
														   SV_Estado	         OUT NOCOPY 	 VARCHAR2,
                                                           SV_Proc	              OUT NOCOPY 	  VARCHAR2,
	                                                       SN_CodMsg	       OUT NOCOPY 	   NUMBER,
	                                                       SN_Evento	         OUT NOCOPY 	 NUMBER,
	                                                       SV_Tabla              OUT NOCOPY 	 VARCHAR2,
	                                                       SV_Act		           OUT NOCOPY 	   VARCHAR2,
	                                                       SV_Code	             OUT NOCOPY 	 VARCHAR2,
	                                                         SV_Errm	             OUT NOCOPY 	 VARCHAR2
														) IS

PRAGMA AUTONOMOUS_TRANSACTION;

LV_DesError			       VARCHAR2(1000);
LV_Sql			              VARCHAR2(2000);
LV_MensajeError		    VARCHAR2(2000);

BEGIN

	  SV_Estado	     :='3';
      SV_Proc	      :='PV_ACT_REPROCEDO_CPU_PR';
	  SN_CodMsg	   :=0;
	  SN_Evento	     :=0;
	  SV_Code	     :='0';
	  SV_Errm        :='0';

	  SV_Tabla        :='GE_AUD_REGULARIZA_TD';
	  SV_Act		   :='U';

	  LV_Sql:=' UPDATE ge_aud_regulariza_td';
	  LV_Sql:=LV_Sql||' SET       cod_estado ='||EN_EstadoFin;
	  LV_Sql:=LV_Sql||' WHERE  num_identificador='||EN_NumId;

	  EXECUTE IMMEDIATE LV_SQL;

	  COMMIT;

EXCEPTION
		 	WHEN OTHERS THEN
					SV_Estado	:='4';
					SV_Code		:=SQLCODE;
					SV_Errm		:=SQLERRM;

					SN_CodMsg := 2729;

					IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
					   LV_MensajeError := 'Error No Clasificado';
					END IF;

					LV_DesError := 'pv_act_reprocedo_cpu_pr(' || EN_NumId || ','||EN_EstadoFin||')';
					LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
					LV_DesError :=LV_DesError ||'('||SV_Act||')';
					LV_DesError :=LV_DesError ||'-'|| SV_Errm;

					SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,	'pv_pasohist_aciclo_limcons_pr',LV_Sql,SN_CodMsg,LV_DesError);

END pv_estado_reproceso_cpu_pr;

PROCEDURE pv_actdatos_reproceso_cpu_pr(  EN_NumId       IN                      ge_aud_regulariza_td.num_identificador%TYPE,
														   EV_Tabla               IN                      ge_aud_regulariza_td.nom_tabla%TYPE,
														   EV_Act                  IN                      ge_aud_regulariza_td.cod_act%TYPE,
														   EN_Evento             IN                      ge_aud_regulariza_td.num_evento%TYPE,
														   ES_DesEstado        IN                      ge_aud_regulariza_td.des_estado%TYPE,
														   ES_Observacion     IN                      ge_aud_regulariza_td.observacion%TYPE,
														   ES_Code                IN                     ge_aud_regulariza_td.cod_sqlcode%TYPE,
														   ES_Errm                 IN                     ge_aud_regulariza_td.cod_sqlerrm%TYPE,
														   SV_Estado	         OUT NOCOPY 	 VARCHAR2,
                                                           SV_Proc	              OUT NOCOPY 	  VARCHAR2,
	                                                       SN_CodMsg	       OUT NOCOPY 	   NUMBER,
	                                                       SN_Evento	         OUT NOCOPY 	 NUMBER,
	                                                       SV_Tabla              OUT NOCOPY 	 VARCHAR2,
	                                                       SV_Act		           OUT NOCOPY 	   VARCHAR2,
	                                                       SV_Code	             OUT NOCOPY 	 VARCHAR2,
	                                                       SV_Errm	             OUT NOCOPY 	 VARCHAR2
														) IS

PRAGMA AUTONOMOUS_TRANSACTION;

LV_DesError			       VARCHAR2(1000);
LV_Sql			              VARCHAR2(2000);
LV_MensajeError		    VARCHAR2(2000);

BEGIN

	  SV_Estado	     :='3';
      SV_Proc	      :='PV_ACT_REPROCEDO_CPU_PR';
	  SN_CodMsg	   :=0;
	  SN_Evento	     :=0;
	  SV_Code	     :='0';
	  SV_Errm        :='0';

	  SV_Tabla        :='GE_AUD_REGULARIZA_TD';
	  SV_Act		   :='U';

	  LV_Sql:=' UPDATE ge_aud_regulariza_td';
	  LV_Sql:=LV_Sql||' SET nom_tabla  ='''||EV_Tabla||'''';
	  LV_Sql:=LV_Sql||    '  ,cod_act      ='''||EV_Act||'''';
	  LV_Sql:=LV_Sql||    '  ,num_evento='||EN_Evento;

          IF ES_DesEstado NOT IN ('0','-1') THEN
	           LV_Sql:=LV_Sql||    '  ,des_estado=SUBSTR('''|| ES_DesEstado ||''',1,2000)';
	  END IF;

	  IF ES_Observacion NOT IN ('0','-1') THEN
	           LV_Sql:=LV_Sql||    '  ,observacion=SUBSTR('''|| ES_Observacion ||''',1,2000)';
	  END IF;

	  LV_Sql:=LV_Sql||    '  ,cod_sqlcode='''||ES_Code||'''';
	  LV_Sql:=LV_Sql||    '  ,cod_sqlerrm='''||ES_Errm||'''';
	  LV_Sql:=LV_Sql||' WHERE  num_identificador='||EN_NumId;

	  EXECUTE IMMEDIATE LV_Sql;

	  COMMIT;

EXCEPTION
		 	WHEN OTHERS THEN
					SV_Estado	:='4';
					SV_Code		:=SQLCODE;
					SV_Errm		:=SQLERRM;

					SN_CodMsg := 2729;

					IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
					   LV_MensajeError := 'Error No Clasificado';
					END IF;

					LV_DesError := 'pv_actdatos_reproceso_cpu_pr(' || EN_NumId || ','||EV_Tabla||','||EV_Act||','||EN_Evento||')';
					LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
					LV_DesError :=LV_DesError ||'('||SV_Act||')';
					LV_DesError :=LV_DesError ||'-'|| SV_Errm;

					SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,	'pv_pasohist_aciclo_limcons_pr',LV_Sql,SN_CodMsg,LV_DesError);

END pv_actdatos_reproceso_cpu_pr;

PROCEDURE pv_parseo_cpu_pr(  EV_CadenaDatos           IN                      VARCHAR2,
                                                SN_ClienteOri               OUT NOCOPY 	    NUMBER,
												SN_ClienteDes              OUT NOCOPY 	   NUMBER,
												SN_NumAboOri             OUT NOCOPY 	 NUMBER,
												SN_CuentaDes              OUT NOCOPY 	  NUMBER,
												SV_CodPlantarifDes       OUT NOCOPY 	 VARCHAR2,
												SV_AplicaTras              OUT NOCOPY 	   VARCHAR2,
												SD_FechaProg              OUT NOCOPY 	  DATE,
												SV_Usuario                  OUT NOCOPY 	     VARCHAR2,
		  				   		  				SV_Estado	                OUT NOCOPY 	    VARCHAR2,
                                                SV_Proc	                     OUT NOCOPY 	  VARCHAR2,
	                                            SN_CodMsg	              OUT NOCOPY 	   NUMBER,
	                                            SN_Evento	                OUT NOCOPY 	    NUMBER,
	                                            SV_Tabla                    OUT NOCOPY 	    VARCHAR2,
	                                            SV_Act		                 OUT NOCOPY 	  VARCHAR2,
	                                            SV_Code	                    OUT NOCOPY 	    VARCHAR2,
	                                            SV_Errm	                    OUT NOCOPY 	    VARCHAR2 ) IS

LV_MensajeError                 VARCHAR2(2000);
LV_DatosParseo                  VARCHAR2(2000);
LV_FechaProg                     VARCHAR2(2000);
LV_DesError			              VARCHAR2(1000);

LN_Pos                               NUMBER;

BEGIN
               SN_ClienteOri           :=0;
			   SN_ClienteDes          :=0;
			   SN_NumAboOri         :=0;
			   SN_CuentaDes          :=0;
			   SV_CodPlantarifDes   :='0';
			   SV_AplicaTras           :='0';
			   SD_FechaProg           :=SYSDATE ;
			   SV_Usuario			    :='0';
		 	   SV_Estado	            :='3';
			   SV_Proc	                  :='PV_PARSEO_CPU_PR';
			   SN_CodMsg	           :=0;
			   SN_Evento	             :=0;
			   SV_Code	                 :='0';
			   SV_Errm                   :='0';
			   SV_Tabla		             :='0';
			   SV_Act	                   :='0';

		       IF EV_CadenaDatos IS NULL THEN
		                   SV_Estado	            :='5';
			               SN_CodMsg	           :=2733;

						   IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
						         LV_MensajeError := 'Error No Clasificado';
						   END IF;

						   SN_Evento :=ge_errores_pg.grabarpl( SN_Evento, 'PV',LV_MensajeError,'1.0',USER,'pv_reproceso_cpu_alciclo_pr',NULL ,SN_CodMsg,'NO HAY DATOS');

		       ELSE
		                   LV_DatosParseo:=EV_CadenaDatos;

						   --::::CLIENTE ORIGEN::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SN_ClienteOri:=TO_NUMBER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --::::CLIENTE DESTINO::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SN_ClienteDes:=TO_NUMBER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --::::ABONADO ORIGEN::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SN_NumAboOri:=TO_NUMBER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --::::CUENTA DESTINO::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SN_CuentaDes:=TO_NUMBER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --::::PLAN DESTINO::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SV_CodPlantarifDes:=SUBSTR(LV_DatosParseo,1,LN_Pos-1);

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						    --::::APLICA TRASPASO::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SV_AplicaTras:=SUBSTR(LV_DatosParseo,1,LN_Pos-1);

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --::::FECHA DE EJECUCION::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   LV_FechaProg:=UPPER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

						   LV_DatosParseo:=SUBSTR(LV_DatosParseo,LN_Pos+1);

						   --formateo de fecha de programacion
						   LN_Pos:=INSTR(LV_FechaProg,' ');

						   LV_FechaProg:=SUBSTR(LV_FechaProg,LN_Pos+1);

						   LN_Pos:=INSTR(LV_FechaProg,' ',1,3);

						   LV_FechaProg:=SUBSTR(LV_FechaProg,1,LN_Pos-1)||SUBSTR(LV_FechaProg,LN_Pos+4);

						   SD_FechaProg:=TO_DATE(LV_FechaProg,'MON DD hh24:mi:ss YYYY');

						   --::::FECHA DE EJECUCION::::::::
						   LN_Pos:=INSTR(LV_DatosParseo,'|');

						   SV_Usuario:=UPPER(SUBSTR(LV_DatosParseo,1,LN_Pos-1));

		       END IF;

EXCEPTION
      WHEN OTHERS THEN
                SV_Estado	:='4';
				SV_Code		:=SQLCODE;
				SV_Errm		:=SQLERRM;

				SN_CodMsg := 2734;

				IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
				   LV_MensajeError := 'Error No Clasificado';
				END IF;

				LV_DesError := 'pv_parseo_cpu_pr(' || EV_CadenaDatos||')';
				LV_DesError :=LV_DesError ||'-'|| SV_Errm;

				SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'pv_parseo_cpu_pr',NULL,SN_CodMsg,LV_DesError);

END;

PROCEDURE pv_reproceso_cpu_alciclo_pr( EN_NumOs	   		    IN                       pv_iorserv.num_os%TYPE,
		  							   					   EN_NumAbonado       IN                       ga_abocel.num_abonado%TYPE,
														   EN_CodCliente           IN                       ga_abocel.cod_cliente%TYPE,
														   EV_CodOs                 IN                       pv_iorserv.cod_os%TYPE,
														   EV_CodPlantarifDes    IN                       ga_abocel.cod_plantarif%TYPE,
														   EV_Usuario                IN                      pv_iorserv.usuario%TYPE,
                                                           SV_Estado	            OUT NOCOPY 	     VARCHAR2,
                                                           SV_Proc	                 OUT NOCOPY 	  VARCHAR2,
	                                                       SN_CodMsg	          OUT NOCOPY 	   NUMBER,
	                                                       SN_Evento	            OUT NOCOPY 	    NUMBER,
	                                                       SV_Tabla                 OUT NOCOPY 	    VARCHAR2,
	                                                       SV_Act		              OUT NOCOPY 	  VARCHAR2,
	                                                       SV_Code	                OUT NOCOPY 	    VARCHAR2,
	                                                       SV_Errm	                OUT NOCOPY 	    VARCHAR2
) IS

LN_Cont                  NUMBER;

LV_DesError			  VARCHAR2(1000);
LV_Sql			         VARCHAR2(2000);
LV_MensajeError	   VARCHAR2(2000);

LD_FecHasta            DATE;
LD_FecDesde           DATE;

LV_CadenaAct		   pv_camcom.clase_servicio_act%TYPE;
LV_CadenaDes          pv_camcom.clase_servicio_des%TYPE;

LV_UsoParam           pv_param_abocel.cod_uso%TYPE;

LV_Descripcion         pv_iorserv.descripcion%TYPE;
LN_TipProcesa		  pv_iorserv.tip_procesa%TYPE;
LV_CodModgener     pv_iorserv.cod_modgener%TYPE;

LV_CodLimConsNue  ga_limite_cliabo_to.cod_limcons%TYPE;

LN_ImpLimNuevo      ga_intarcel.imp_limconsumo%TYPE;

LV_UsoDestino          ga_abocel.cod_uso%TYPE;
LV_Tecnologia          ga_abocel.cod_tecnologia%TYPE;
LN_CodCuentaOri      ga_abocel.cod_cuenta%TYPE;
LN_NumCelular         ga_abocel.num_celular%TYPE;
LV_CodPlantarifOri    ga_abocel.cod_plantarif%TYPE;
LV_TipPlantarifOri     ga_abocel.tip_plantarif%TYPE;
LV_TipPlantarifDes    ga_abocel.tip_plantarif%TYPE;
LV_TipTerminal        ga_abocel.tip_terminal%TYPE;
LN_CodCiclo			    ga_abocel.cod_ciclo%TYPE;
LV_NumSerie			  ga_abocel.num_serie%TYPE;

LV_CodTiplanDes      ta_plantarif.cod_tiplan%TYPE;
LV_CodBasicoDes      ta_plantarif.cod_cargobasico%TYPE;

LN_CodCiclfact	   	   ga_finciclo.cod_ciclfact%TYPE;

LN_CodVendedor     ge_seg_usuario.cod_vendedor%TYPE;

LV_CodPlanserv       ga_plantecplserv.cod_planserv%TYPE;

ERROR_EXISTE        EXCEPTION;
ERROR_PROCESO    EXCEPTION;

CURSOR ssdefectoplanorigen IS
SELECT lpad(b.cod_servsupl,2,'0')||lpad(b.cod_nivel,4,'0') ssdesactivar
FROM gad_servsup_plan a, ga_servsupl b
WHERE a.cod_plantarif= LV_CodPlantarifOri
AND     a.tip_relacion='3'
AND     SYSDATE BETWEEN fec_desde AND fec_hasta
AND     b.cod_servicio=a.cod_servicio
AND     b.cod_producto=a.cod_producto
AND     EXISTS (SELECT 1 FROM ga_servsuplabo WHERE num_abonado=EN_NumAbonado AND cod_servicio=a.cod_servicio AND ind_estado<3);

CURSOR ssdefectoplandestino IS
SELECT lpad(b.cod_servsupl,2,'0')||lpad(b.cod_nivel,4,'0') ssactivar
FROM gad_servsup_plan a, ga_servsupl b
WHERE a.cod_plantarif=EV_CodPlantarifDes
AND     a.tip_relacion='3'
AND     SYSDATE BETWEEN fec_desde AND fec_hasta
AND     b.cod_servicio=a.cod_servicio
AND     b.cod_producto=a.cod_producto;

BEGIN

			   LV_DesError := 'pv_reproceso_cpu_alciclo_pr(' || EN_NumOs || ','||EN_NumAbonado||','||EN_CodCliente||','||EV_CodOs||','||EV_CodPlantarifDes||','||EV_Usuario||')';

			   SV_Estado	     :='3';
			   SV_Proc	          :='PV_REPROCESO_CPU_ALCICLO_PR';
			   SN_CodMsg	   :=0;
			   SN_Evento	     :=0;
			   SV_Code	         :='0';
			   SV_Errm           :='0';

			   SV_Tabla		:='GA_ABOCEL';
			   SV_Act	      :='S';

			   LV_Sql	:=' SELECT cod_plantarif,tip_plantarif,cod_ciclo,num_celular,cod_cuenta,tip_terminal,num_serie,cod_tecnologia';
			   LV_Sql	:=LV_Sql	||' FROM    ga_abocel';
			   LV_Sql	:=LV_Sql	||' WHERE  num_abonado='||EN_NumAbonado;

			   EXECUTE IMMEDIATE LV_Sql INTO LV_CodPlantarifOri,LV_TipPlantarifOri,LN_CodCiclo,LN_NumCelular,LN_CodCuentaOri,LV_TipTerminal,LV_NumSerie,LV_Tecnologia;

			   IF LV_CodPlantarifOri=EV_CodPlantarifDes THEN

						SV_Estado	:='5';
						SN_CodMsg := 285;

						IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
						   LV_MensajeError := 'Error No Clasificado';
						END IF;

						LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
						LV_DesError :=LV_DesError ||'('||SV_Act||')';

						SN_Evento :=ge_errores_pg.grabarpl( SN_Evento, 'PV',LV_MensajeError,'1.0',USER,'pv_reproceso_cpu_alciclo_pr',LV_Sql,SN_CodMsg,LV_DesError);

			   ELSE
			   	   		SV_Tabla	 :='PV_IORSERV';
						SV_Act	      :='S';

					    LV_Sql	:=' SELECT COUNT(1) FROM pv_iorserv WHERE num_os='||EN_NumOs;

					    EXECUTE IMMEDIATE LV_Sql INTO LN_Cont;

						IF LN_Cont>0 THEN
					   	  	   RAISE ERROR_EXISTE;
					    END IF;

						SV_Tabla	 :='PVH_IORSERV';
						SV_Act	      :='S';

					    LV_Sql	:=' SELECT COUNT(1) FROM pvh_iorserv WHERE num_os='||EN_NumOs;

					    EXECUTE IMMEDIATE LV_Sql INTO LN_Cont;

						IF LN_Cont>0 THEN
					   	  	   RAISE ERROR_EXISTE;
					    END IF;

						SV_Tabla	:='AFA_CICLFACT';
					    SV_Act	      :='S';

					    LV_Sql	:=' SELECT  fec_hastallam,fec_hastallam+1/86400';
					    LV_Sql	:=LV_Sql	||' FROM   fa_ciclfact';
					    LV_Sql	:=LV_Sql	||' WHERE cod_ciclo='||LN_CodCiclo;
					    LV_Sql	:=LV_Sql	||' AND SYSDATE BETWEEN fec_desdellam AND fec_hastallam';

					    EXECUTE IMMEDIATE LV_Sql INTO  LD_FecHasta,LD_FecDesde;

					    SV_Tabla	:='BFA_CICLFACT';
					    SV_Act	      :='S';

					    LV_Sql	:=' SELECT  cod_ciclfact';
					    LV_Sql	:=LV_Sql	||' FROM   fa_ciclfact';
					    LV_Sql	:=LV_Sql	||' WHERE cod_ciclo='||LN_CodCiclo;
					    LV_Sql	:=LV_Sql	||' AND fec_desdellam='||TO_CHAR(LD_FecDesde,'DD-MM-YYYY hh24:mi:ss');

					    SELECT  cod_ciclfact
						INTO     LN_CodCiclfact
					    FROM   fa_ciclfact
					    WHERE cod_ciclo=LN_CodCiclo
					    AND      fec_desdellam=LD_FecDesde;

					    SV_Tabla	 :='CI_TIPORSERV';
			   			SV_Act	      :='S';

						LV_Sql	:=' SELECT descripcion,tip_procesa,cod_modgener FROM ci_tiporserv WHERE cod_os='''||EV_CodOs||'''';

			   			EXECUTE IMMEDIATE LV_Sql INTO LV_Descripcion,LN_TipProcesa,LV_CodModgener;

					    SV_Tabla	:='TA_PLANTARIF';
					    SV_Act	      :='S';

					    LV_Sql	:=               ' SELECT tip_plantarif,cod_tiplan,cod_cargobasico FROM ta_plantarif';
					    LV_Sql	:=LV_Sql || ' WHERE cod_plantarif='''||EV_CodPlantarifDes||'''';

			            EXECUTE IMMEDIATE LV_Sql INTO LV_TipPlantarifDes,LV_CodTiplanDes,LV_CodBasicoDes;

						SV_Tabla   :='GA_PLANTECPLSERV';
		                SV_Act      :='S';

		                LV_Sql	:=              ' SELECT cod_planserv FROM ga_plantecplserv';
		                LV_Sql	:=LV_Sql ||' WHERE cod_tecnologia='''||LV_Tecnologia||'''';
		                LV_Sql	:=LV_Sql ||' AND cod_plantarif='''||EV_CodPlantarifDes||'''';
		                LV_Sql	:=LV_Sql ||' AND SYSDATE BETWEEN fec_desde AND fec_hasta';

						EXECUTE IMMEDIATE LV_Sql  INTO LV_CodPlanserv;

					    SV_Tabla     :='GE_SEG_USUARIO';
					    SV_Act	      :='S';

					    LV_Sql	:='  SELECT cod_vendedor FROM ge_seg_usuario WHERE nom_usuario='''||EV_Usuario||'''';

						BEGIN
					  		EXECUTE IMMEDIATE LV_Sql INTO  LN_CodVendedor;
					    EXCEPTION
					  		 WHEN NO_DATA_FOUND THEN
							        LN_CodVendedor:=0;
					    END;

						SV_Tabla	 :='PV_IORSERV';
					    SV_Act	      :='I';

					    LV_Sql	:=' INSERT INTO pv_iorserv(num_os, cod_os, num_ospadre, descripcion, fecha_ing, producto, usuario, status, tip_procesa, fh_ejecucion, cod_estado';
					    LV_Sql	:=LV_Sql	||' , cod_modgener, num_osf,  tip_sujeto, ind_lock, num_osf_err, comentario)';
					    LV_Sql	:=LV_Sql	||' VALUES ('||EN_NumOs||','''||EV_CodOs||''',NULL,'''||LV_Descripcion||''',SYSDATE,1,'''||EV_Usuario||''',''Proceso exitoso orden_Servicio'','||LN_TipProcesa||',TO_DATE('''||TO_CHAR(LD_FecDesde,'DD-MM-YYYY hh24:mi:ss')||''',''DD-MM-YYYY hh24:mi:ss''),10';
					    LV_Sql	:=LV_Sql	||' ,'''||LV_CodModgener||''',0,''A'',0,0,''CAMBIO DE PLAN BATCH, REPROCESO'')';

					    EXECUTE IMMEDIATE LV_Sql;

						SV_Tabla		:='pv_erecorrido';
			   			SV_Act	      :='I';

			   			LV_Sql	:='  INSERT INTO pv_erecorrido ( num_os, cod_estado, descripcion, tip_estado, fec_ingestado,msg_error )';
			   		    LV_Sql	:=LV_Sql	||'	VALUES ('||EN_NumOS||', 10, ''PROC. INSCRIPCION EN INTERFAZ'', 3, SYSDATE, NULL)';

						EXECUTE IMMEDIATE LV_Sql;

                        --:::::::::::::::::::::::LIMITE DE CONSUMO Y ASIGNACION DE DATOS
						IF EV_CodOs='10530' THEN
			  	    	   				LV_UsoParam:='10';

										LV_CadenaAct:='*';
										LV_CadenaDes:='*';

										LV_UsoDestino  :=10;

										IF LV_TipPlantarifOri='I' THEN

													SV_Tabla   :='PV_CERRARLIM_ACICLO_IND_PR';
			                    					SV_Act      :='P';

													pv_limite_consumo_pg.pv_cerrarlim_aciclo_ind_pr(EN_NumAbonado,EN_CodCliente,LV_CodPlantarifOri,
																		 													SV_Estado,SV_Proc,SN_CodMsg,SN_Evento,SV_Tabla,SV_Act,SV_Code,SV_Errm);

												    IF  SV_Estado<>'3' THEN
															RAISE ERROR_PROCESO;
													END IF;

									    END IF;

			  		    ELSIF EV_CodOs='10539' THEN
								       LV_UsoParam:='2';

									   LV_CadenaAct:='*';
									   LV_CadenaDes:='*';

									   LV_UsoDestino:=2;

									   IF LV_TipPlantarifOri='I' THEN

							                   SV_Tabla            :='tol_plan_td-limite_td';
							                   SV_Act                :='S';

							                   LV_Sql	:='  SELECT a.cod_limcons,b.imp_limite ';
							                   LV_Sql	:=LV_Sql	||'	FROM tol_limite_plan_td a,tol_limite_td b ';
							                   LV_Sql	:=LV_Sql	||'	WHERE a.cod_plantarif='''||EV_CodPlantarifDes||'''';
							                   LV_Sql	:=LV_Sql	||'	AND     SYSDATE BETWEEN a.fec_Desde AND NVL(a.fec_hasta,SYSDATE ) ';
											   LV_Sql	:=LV_Sql	||'	AND     a.ind_default=''S''';
							                   LV_Sql	:=LV_Sql	||'	AND     b.cod_limcons=a.cod_limcons';
							                   LV_Sql	:=LV_Sql	||'	AND     SYSDATE BETWEEN a.fec_Desde AND NVL(a.fec_hasta,SYSDATE )';

											   EXECUTE IMMEDIATE LV_Sql INTO LV_CodLimConsNue,LN_ImpLimNuevo;

							                   SV_Tabla     :='Cga_limite_cliabo_to';
							                   SV_Act        :='S';

											   LV_Sql	:=' SELECT COUNT(1) FROM ga_limite_cliabo_to';
											   LV_Sql	:=LV_Sql	||'	WHERE num_abonado='||EN_NumAbonado;
											   LV_Sql	:=LV_Sql	||'	AND     cod_cliente='||EN_CodCliente;
											   LV_Sql	:=LV_Sql	||'	AND     cod_plantarif='||EV_CodPlantarifDes;
											   LV_Sql	:=LV_Sql	||'	AND     fec_desde='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400';
											   LV_Sql	:=LV_Sql	||'	AND     cod_limcons='||LV_CodLimConsNue;

											   SELECT COUNT(1)
											   INTO LN_Cont
											   FROM ga_limite_cliabo_to
											   WHERE num_abonado=EN_NumAbonado
											   AND     cod_cliente=EN_CodCliente
											   AND     cod_plantarif=EV_CodPlantarifDes
											   AND     fec_desde=LD_FecHasta+1/86400
											   AND     cod_limcons=LV_CodLimConsNue;

											   IF LN_Cont=0 THEN

													    SV_Tabla     :='PV_CREALIM_ACICLO_IND_PR';
							                   			SV_Act        :='P';

													   pv_limite_consumo_pg.pv_crealim_aciclo_ind_pr(EN_NumAbonado,EN_CodCliente,EV_CodPlantarifDes,
																                                                              SV_Estado,SV_Proc,SN_CodMsg,SN_Evento,SV_Tabla,SV_Act,SV_Code,SV_Errm);

													   IF  SV_Estado<>'3' THEN
															RAISE ERROR_PROCESO;
													   END IF;

											  END IF;

				                       END IF;--endIF LV_TipPlantarifOri='I' THEN

			            ELSIF EV_CodOs='10020' THEN

									  IF LV_TipPlantarifOri='I' THEN

												  LV_CadenaAct:=NULL;

												  FOR ssact IN ssdefectoplandestino  LOOP
																LV_CadenaAct:=LV_CadenaAct||ssact.ssactivar;
												  END LOOP;

												  LV_CadenaDes:=NULL;

												  FOR ssact IN ssdefectoplanorigen  LOOP
																LV_CadenaDes:=LV_CadenaDes||ssact.ssdesactivar;
												  END LOOP;

						      					  LV_UsoParam:=NULL;

												  IF LV_CodTiplanDes=2 THEN
								                              LV_UsoDestino:=2;

								                              SV_Tabla     :='1TOL_LIMITE_LIMITE_TD';
								                              SV_Act        :='S';

								                              LV_Sql	:=' SELECT a.cod_limcons,b.imp_limite FROM tol_limite_plan_td a,tol_limite_td b';
								                              LV_Sql	:=LV_Sql	||'	WHERE a.cod_plantarif='''||EV_CodPlantarifDes||'''';
								                              LV_Sql	:=LV_Sql	||'	AND     SYSDATE BETWEEN a.fec_Desde AND NVL(a.fec_hasta,SYSDATE ) AND a.ind_default=''S''';
								                              LV_Sql	:=LV_Sql	||'	AND     b.cod_limcons=a.cod_limcons AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE )';

															  EXECUTE IMMEDIATE LV_Sql INTO LV_CodLimConsNue,LN_ImpLimNuevo;

															   SV_Tabla     :='Cga_limite_cliabo_to';
											                   SV_Act        :='S';

															    LV_Sql	:=' SELECT COUNT(1) FROM ga_limite_cliabo_to';
											                    LV_Sql	:=LV_Sql	||'	WHERE num_abonado='||EN_NumAbonado;
											                    LV_Sql	:=LV_Sql	||'	AND     cod_cliente='||EN_CodCliente;
											                    LV_Sql	:=LV_Sql	||'	AND     cod_plantarif='||EV_CodPlantarifDes;
											                    LV_Sql	:=LV_Sql	||'	AND     fec_desde='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400';
											                    LV_Sql	:=LV_Sql	||'	AND     cod_limcons='||LV_CodLimConsNue;

															   SELECT COUNT(1)
															   INTO LN_Cont
															   FROM ga_limite_cliabo_to
															   WHERE num_abonado=EN_NumAbonado
															   AND cod_cliente=EN_CodCliente
															   AND cod_plantarif=EV_CodPlantarifDes
															   AND fec_desde=LD_FecHasta+1/86400
															   AND cod_limcons=LV_CodLimConsNue;

															   IF LN_Cont=0 THEN
										                              SV_Tabla     :='PV_CREALIM_ACICLO_IND_PR';
										                   			  SV_Act        :='P';

																      pv_limite_consumo_pg.pv_crealim_aciclo_ind_pr(EN_NumAbonado,EN_CodCliente,EV_CodPlantarifDes,
																			                                                              SV_Estado,SV_Proc,SN_CodMsg,SN_Evento,SV_Tabla,SV_Act,SV_Code,SV_Errm);

																	  IF  SV_Estado<>'3' THEN
															                 RAISE ERROR_PROCESO;
													                  END IF;

															  END IF;

								                              SV_Tabla   :='PV_CERRARLIM_ACICLO_IND_PR';
						                    				  SV_Act      :='P';

															  pv_limite_consumo_pg.pv_cerrarlim_aciclo_ind_pr(EN_NumAbonado,EN_CodCliente,LV_CodPlantarifOri,
																					 													SV_Estado,SV_Proc,SN_CodMsg,SN_Evento,SV_Tabla,SV_Act,SV_Code,SV_Errm);

															  IF  SV_Estado<>'3' THEN
															         RAISE ERROR_PROCESO;
													          END IF;

								                  ELSIF LV_CodTiplanDes=3 THEN
								                              LV_UsoDestino:=10;
								                              LN_ImpLimNuevo:=0;
								                  END IF;

								      END IF;--ENDIF LV_TipPlantarifOri='I' THEN

                        END IF; --ENDIF EV_CodOs='10530' THEN

			            SV_Tabla	 :='PV_CAMCOM';
			            SV_Act	      :='I';

			            LV_Sql	:='  INSERT INTO pv_camcom ( num_os, num_abonado, num_celular, cod_cliente, cod_cuenta, cod_producto,';
			            LV_Sql	:=LV_Sql	||'	bdatos,  cod_actabo, fec_vencimiento, ';
			            LV_Sql	:=LV_Sql	||'	clase_servicio_act, clase_servicio_des, ind_central_ss,ind_portable, tip_terminal)';
			            LV_Sql	:=LV_Sql	||'	VALUES ( ';
			            LV_Sql	:=LV_Sql	||	EN_NumOs||','|| EN_NumAbonado||','|| LN_NumCelular||','|| EN_CodCliente||','|| LN_CodCuentaOri||', 1, ''SCEL''';
			            LV_Sql	:=LV_Sql	||'	,''SS'',TO_DATE('''|| TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||''',''DD-MM-YYYY hh24:mi:ss''), '''||LV_CadenaAct||''','''||LV_CadenaDes||''', 1, 1,'''|| LV_TipTerminal||''')';

			            EXECUTE IMMEDIATE LV_Sql;

						IF EV_CodOs<>'10233' THEN
								  SV_Tabla   :='AGA_INTARCEL';
					              SV_Act       :='S';

								  LV_Sql	:=' SELECT COUNT(1) FROM ga_intarcel ';
								  LV_Sql	:=LV_Sql	||'	WHERE num_abonado='||EN_NumAbonado;
								  LV_Sql	:=LV_Sql	||'	AND cod_cliente='||EN_CodCLiente;
								  LV_Sql	:=LV_Sql	||'	AND cod_plantarif='||EV_CodPlantarifDes;
								  LV_Sql	:=LV_Sql	||'	AND fec_desde='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400';

								  SELECT COUNT(1)
								  INTO LN_Cont
								  FROM ga_intarcel
								  WHERE num_abonado=EN_NumAbonado
								  AND cod_cliente=EN_CodCLiente
								  AND cod_plantarif=EV_CodPlantarifDes
								  AND fec_desde=LD_FecHasta+1/86400;

								  IF LN_Cont=0 THEN

										  SV_Tabla	 :='BGA_INTARCEL';
						   				  SV_Act	   :='I';

										  LV_Sql	:=' INSERT INTO ga_intarcel';
							              LV_Sql	:=LV_Sql	||'	(cod_cliente, num_abonado, ind_numero, fec_desde, fec_hasta, imp_limconsumo, ind_friends, ind_diasesp, cod_celda, tip_plantarif,';
							              LV_Sql	:=LV_Sql	||'	cod_plantarif, num_serie, num_celular, cod_cargobasico, cod_ciclo, cod_plancom, cod_planserv, cod_grpserv, cod_grupo, cod_portador, cod_uso, num_imsi, num_min_mdn)';
							              LV_Sql	:=LV_Sql	||'	SELECT cod_cliente, num_abonado, ind_numero,'||TO_CHAR( LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400, to_DATE(''31-12-3000'',''dd-mm-yyyy''),';
										  LV_Sql	:=LV_Sql	||	LN_ImpLimNuevo||', ind_friends, ind_diasesp, cod_celda,'|| LV_TipPlantarifDes||',';
							              LV_Sql	:=LV_Sql	||	EV_CodPlantarifDes||',num_serie, num_celular, '||LV_CodBasicoDes||' , cod_ciclo, cod_plancom,';
										  LV_Sql	:=LV_Sql	||	LV_CodPlanserv||', cod_grpserv, cod_grupo, cod_portador,'|| LV_UsoDestino||', num_imsi, num_min_mdn';
							              LV_Sql	:=LV_Sql	||'	FROM ga_intarcel WHERE  num_abonado='||EN_NumAbonado;
							              LV_Sql	:=LV_Sql	||'	AND      cod_cliente='||EN_CodCLiente ||' AND SYSDATE BETWEEN fec_Desde AND fec_hasta';

							              INSERT INTO ga_intarcel
							              (cod_cliente, num_abonado, ind_numero, fec_desde, fec_hasta, imp_limconsumo, ind_friends, ind_diasesp, cod_celda, tip_plantarif,
							              cod_plantarif, num_serie, num_celular, cod_cargobasico, cod_ciclo, cod_plancom, cod_planserv, cod_grpserv, cod_grupo, cod_portador, cod_uso, num_imsi, num_min_mdn)
							              SELECT cod_cliente, num_abonado, ind_numero, LD_FecHasta+1/86400, to_DATE('31-12-3000','dd-mm-yyyy'), LN_ImpLimNuevo, ind_friends, ind_diasesp, cod_celda, LV_TipPlantarifDes,
							              EV_CodPlantarifDes, num_serie, num_celular, LV_CodBasicoDes , cod_ciclo, cod_plancom, LV_CodPlanserv, cod_grpserv, cod_grupo, cod_portador, LV_UsoDestino, num_imsi, num_min_mdn
							              FROM ga_intarcel
							              WHERE  num_abonado=EN_NumAbonado
							              AND      cod_cliente=EN_CodCLiente
							              AND     SYSDATE BETWEEN fec_Desde AND fec_hasta;

								  END IF;

					              SV_Tabla    :='CGA_INTARCEL';
					              SV_Act        :='U';

								  LV_Sql	:=' UPDATE ga_intarcel SET fec_hasta='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss');
					              LV_Sql	:=LV_Sql	||'	WHERE  num_abonado='||EN_NumAbonado;
					              LV_Sql	:=LV_Sql	||'	AND      cod_cliente='||EN_CodCLiente||' AND SYSDATE BETWEEN fec_Desde AND fec_hasta';

					              UPDATE ga_intarcel
					              SET       fec_hasta=LD_FecHasta
					              WHERE  num_abonado=EN_NumAbonado
					              AND      cod_cliente=EN_CodCLiente
					              AND     SYSDATE BETWEEN fec_Desde AND fec_hasta;

					              SV_Tabla   :='GA_FINCICLO';
					              SV_Act       :='S';

								  LV_Sql	:=' SELECT COUNT(1) FROM ga_finciclo WHERE num_abonado='||EN_NumAbonado;
								  LV_Sql	:=LV_Sql	||'	AND cod_cliente='||EN_CodCLiente||' AND  cod_ciclfact='||LN_CodCiclfact;
								  LV_Sql	:=LV_Sql	||'	AND cod_plantarif='||EV_CodPlantarifDes||' AND fec_desdellam='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400';

								  SELECT COUNT(1)
								  INTO   LN_Cont
								  FROM ga_finciclo
								  WHERE num_abonado=EN_NumAbonado
								  AND cod_cliente=EN_CodCLiente
								  AND  cod_ciclfact=LN_CodCiclfact
								  AND cod_plantarif=EV_CodPlantarifDes
								  AND fec_desdellam=LD_FecHasta+1/86400;

								  IF LN_Cont=0 THEN

										  SV_Tabla   :='GA_FINCICLO';
										  SV_Act       :='I';

										  LV_Sql	:=' INSERT INTO ga_finciclo (cod_cliente, num_abonado, cod_ciclfact, cod_producto, tip_plantarif, cod_plantarif, cod_cargobasico,fec_desdellam)';
							              LV_Sql	:=LV_Sql ||' VALUES('||EN_CodCLiente||','||EN_NumAbonado||','||LN_CodCiclfact||',1,'||LV_TipPlantarifDes||','||EV_CodPlantarifDes||','||LV_CodBasicoDes||','||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400)';

							              INSERT INTO ga_finciclo
							              (cod_cliente, num_abonado, cod_ciclfact, cod_producto, tip_plantarif, cod_plantarif, cod_cargobasico,fec_desdellam)
							              VALUES(EN_CodCLiente,EN_NumAbonado,LN_CodCiclfact,1,LV_TipPlantarifDes,EV_CodPlantarifDes,LV_CodBasicoDes,LD_FecHasta+1/86400);
								  ELSE
								  	  	  SV_Tabla   :='GA_FINCICLO';
					               		  SV_Act       :='U';

										  LV_Sql	:=' UPDATE ga_finciclo SET cod_plantarif='||EV_CodPlantarifDes ||' WHERE num_abonado='||EN_NumAbonado;
								          LV_Sql	:=LV_Sql	||'	AND cod_cliente='||EN_CodCLiente||' AND  cod_ciclfact='||LN_CodCiclfact;
								          LV_Sql	:=LV_Sql	||'	AND cod_plantarif='||EV_CodPlantarifDes||' AND fec_desdellam='||TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||'+1/86400';

										  UPDATE ga_finciclo
										  SET cod_plantarif=EV_CodPlantarifDes
										  WHERE num_abonado=EN_NumAbonado
								  		  AND cod_cliente=EN_CodCLiente
								  		  AND  cod_ciclfact=LN_CodCiclfact
								  		  AND fec_desdellam=LD_FecHasta+1/86400;
								  END IF;

						END IF;--ENDIF reg.cod_os<>'10233' THEN

						LV_Sql	:='  INSERT INTO pv_param_abocel ( num_os, num_abonado, cod_tipmodi, fec_modifica, nuom_usuarora,';
					    LV_Sql	:=LV_Sql	||'	num_celular, cod_uso, tip_plantarif, tip_terminal, cod_plantarif, num_serie, obs_detalle, cod_tipsegu, cod_plantarif_nue, tip_plantarif_nue, cod_producto, num_dia, cod_vendedor,';
					    LV_Sql	:=LV_Sql	||'	param1_mens ) VALUES (';
					    LV_Sql	:=LV_Sql	|| 	EN_NumOs||','|| EN_NumAbonado||', ''SS'',  SYSDATE';
					    LV_Sql	:=LV_Sql	||' , ''OPS$XPFACTUR'', '||LN_NumCelular||','''|| LV_UsoParam||''','''|| LV_TipPlantarifOri ||''','''|| LV_TipTerminal||''','''|| LV_CodPlantarifOri ||''','''||LV_NumSerie||'''';
					    LV_Sql	:=LV_Sql	|| ' ,''10309'', 0,'''|| EV_CodPlantarifDes||''','''|| LV_TipPlantarifDes||''', 1, 1,'||LN_CodVendedor||', ''S'')';

					    EXECUTE IMMEDIATE LV_Sql;

					    IF EV_Usuario IS NOT NULL THEN
					   	  	 	SV_Tabla   :='CPV_PARAM_ABOCEL';
				                SV_Act       :='U';

								LV_Sql	:=' UPDATE pv_param_abocel SET nuom_usuarora='''||EV_Usuario||'''';
								LV_Sql	:=LV_Sql ||' WHERE num_os='||EN_NumOs;

								EXECUTE IMMEDIATE LV_Sql;

					    END IF;

					    IF EV_CodOs='10233' THEN

								SV_Tabla   :='APV_PARAM_ABOCEL';
				                SV_Act       :='U';

								LV_Sql	:=' UPDATE pv_param_abocel SET cod_causa=''34'' WHERE num_os='||EN_NumOs;

								EXECUTE IMMEDIATE LV_Sql;

					    END IF;

					    SV_Tabla   :='bpv_param_abocel';
				        SV_Act       :='U';

					    LV_Sql	:=' UPDATE pv_param_abocel SET cod_planserv= '''||LV_CodPlanserv||''' WHERE num_os='||EN_NumOs;

					    EXECUTE IMMEDIATE LV_Sql;

					    IF  EV_CodOs<>'10233' THEN
							   SV_Tabla		:='PV_MOVIMIENTOS';
							   SV_Act	      :='I';

							   LV_Sql	:='  INSERT INTO pv_movimientos ( num_os, f_ejecucion, ord_comando, cod_actabo, ind_estado,cod_estado )';
							   LV_Sql	:=LV_Sql	||'  VALUES ('||EN_NumOs||',SYSDATE , 1, ''SS'', 1, 1)';

							   EXECUTE IMMEDIATE LV_Sql;

					    ELSE
					  	       SV_Tabla		:='B1PV_MOVIMIENTOS';
							   SV_Act	      :='I';

							   LV_Sql	:='  INSERT INTO pv_movimientos ( num_os, f_ejecucion, ord_comando, cod_actabo, ind_estado,cod_estado )';
							   LV_Sql	:=LV_Sql	||'  VALUES ('||EN_NumOs||',SYSDATE , 1, ''BA'', 1, 1)';

							   EXECUTE IMMEDIATE LV_Sql;

							   SV_Tabla		:='B2PV_MOVIMIENTOS';
							   SV_Act	      :='I';

							   LV_Sql	:='  INSERT INTO pv_movimientos ( num_os, f_ejecucion, ord_comando, cod_actabo, ind_estado,cod_estado )';
							   LV_Sql	:=LV_Sql	||'  VALUES ('||EN_NumOs||',SYSDATE , 2, ''AM'', 1, 1)';

							   EXECUTE IMMEDIATE LV_Sql;

							   SV_Tabla		:='B2PV_MOVIMIENTOS';
							   SV_Act	      :='I';

							   LV_Sql	:='  INSERT INTO pv_movimientos ( num_os, f_ejecucion, ord_comando, cod_actabo, ind_estado,cod_estado )';
							   LV_Sql	:=LV_Sql	||'  VALUES ('||EN_NumOs||',SYSDATE , 3, ''SS'', 1, 1)';

							   EXECUTE IMMEDIATE LV_Sql;

					    END IF;

					    SV_Tabla     :='PV_PROG';
					    SV_Act	      :='I';

					    LV_Sql	:='  INSERT INTO pv_prog ( num_os, f_prorroga, usuario, fec_prog ) ';
					    LV_Sql	:=LV_Sql	|| 'VALUES ('||EN_NumOs||',  TO_DATE('''|| TO_CHAR(LD_FecHasta,'DD-MM-YYYY hh24:mi:ss')||''',''DD-MM-YYYY hh24:mi:ss''), USER ,SYSDATE )';

		                EXECUTE IMMEDIATE LV_Sql;

			   END IF;
EXCEPTION
         WHEN ERROR_PROCESO THEN
         	  			NULL;
		 WHEN ERROR_EXISTE THEN
		 	  	        SV_Estado	:='5';
						SN_CodMsg := 2732;

						IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
						       LV_MensajeError := 'Error No Clasificado';
						END IF;

						LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
						LV_DesError :=LV_DesError ||'('||SV_Act||')';

						SN_Evento :=ge_errores_pg.grabarpl( SN_Evento, 'PV',LV_MensajeError,'1.0',USER,'pv_reproceso_cpu_alciclo_pr',LV_Sql,SN_CodMsg,LV_DesError);

         WHEN OTHERS THEN
		 	  	        ROLLBACK;

						SV_Estado	:='4';
						SN_CodMsg := 0;

						SV_Code	   := SQLCODE;
	                    SV_Errm    := SQLERRM;

						IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
						       LV_MensajeError := 'Error No Clasificado';
						END IF;

						LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
						LV_DesError :=LV_DesError ||'('||SV_Act||')'||'-'||SV_Errm;

						SN_Evento :=ge_errores_pg.grabarpl( SN_Evento, 'PV',LV_MensajeError,'1.0',USER,'pv_reproceso_cpu_alciclo_pr',LV_Sql,SN_CodMsg,LV_DesError);

END pv_reproceso_cpu_alciclo_pr;

PROCEDURE pv_reprocesa_ooss_cpu_pr IS

LN_Cont	  						   	    NUMBER;
LN_DiasEncolado					   NUMBER;
LN_CodMsg                            NUMBER;
LN_Evento                              NUMBER;
LN_EventoAux                         NUMBER;

LV_DesError			                  VARCHAR2(1000);
LV_MensajeError	                   VARCHAR2(2000);
LV_Estado                              VARCHAR2(1);
LV_EstadoAux                         VARCHAR2(1);
LV_Proc	                                VARCHAR2(100);
LV_Tabla                               VARCHAR2(100);
LV_Act                                   VARCHAR2(1);
LV_TablaAux                          VARCHAR2(100);
LV_ActAux                             VARCHAR2(1);
LV_Code	                               VARCHAR2(100);
LV_Errm	                               VARCHAR2(2000);
LV_Sql	                                VARCHAR2(2000);

LN_ClienteOri                          NUMBER;
LN_ClienteDes                         NUMBER;
LN_NumAboOri             		    NUMBER;
LN_CuentaDes                         NUMBER;
LV_AplicaTras                         VARCHAR2(3);
LD_FechaProg                         DATE;

LV_CodOsCPU							ci_tiporserv.cod_os%TYPE;
LV_CodTipModi						ci_tiporserv.cod_tipmodi%TYPE;

LV_Usuario                            pv_iorserv.usuario%TYPE;

LN_CodClienteAbo				  ga_abocel.cod_cliente%TYPE;
LN_CodCiclo						 	 ga_abocel.cod_ciclo%TYPE;
LV_CodSituacion					   ga_abocel.cod_situacion%TYPE;
LV_CodPlantarifDes                ga_abocel.cod_plantarif%TYPE;

LN_NumId							 ge_aud_regulariza_td.num_identificador%TYPE;
LN_NumIdRePro					  ge_aud_regulariza_td.num_identificador%TYPE;
LV_DatosRepro 					   ge_aud_regulariza_td.des_estado%TYPE;
LV_DesEstadoRepro 		 	    ge_aud_regulariza_td.des_estado%TYPE;

LV_DetalleEstado                    pv_detalle_os_to.estado%TYPE;
LV_DetalleError                      pv_detalle_os_to.des_error%TYPE;

ERROR_REPROCESO               EXCEPTION;
ERROR_PROCESO                 EXCEPTION;

CURSOR oosscpu IS
SELECT num_os,fec_estado,num_abonado,cod_cliente,num_proceso,estado
FROM pv_detalle_os_to
WHERE estado ='ERROR'
AND num_os=25831150;

/*UNION ALL
SELECT num_os,fec_estado,num_abonado,cod_cliente,num_proceso,estado
FROM pv_detalle_os_to
WHERE estado ='ENCOLADO'
AND fec_estado>SYSDATE -LN_DiasEncolado;*/

BEGIN

	 		LN_DiasEncolado:=TO_NUMBER(GE_FN_DEVVALPARAM('GA',1,'CPU_REPROC_DIASMAXEN'));

	 		FOR reg IN oosscpu LOOP
					BEGIN
						 	   LV_DesError	:='0';
							   LV_MensajeError:='0';
							   LV_Estado         :='0';
							   LV_EstadoAux   :='0';
							   LV_Proc	       :='0';
							   LV_Tabla          :='0';
							   LV_Act             :='0';
							   LV_TablaAux    :='0';
							   LV_ActAux       :='0';
							   LV_Code	      :='0';
							   LV_Errm	      :='0';
							   LV_Sql:='0';
							   LV_DetalleEstado   :='0';
                                                           LV_DetalleError :='0';

							   --:::::::::BUSCO DATOS INICIALES DEL REPROCESO:::::::::

							   LV_Tabla   :='GE_AUD_REGULARIZA_TD';
							   LV_Act      :='S';

							   LV_Sql:=               ' SELECT  num_identificador,des_estado,cod_os,cod_tipmodi';
							   LV_Sql:=LV_Sql || ' FROM    ge_aud_regulariza_td ';
							   LV_Sql:=LV_Sql || ' WHERE  num_inter='||reg.num_os;
							   LV_Sql:=LV_Sql || ' AND      tip_inter=2';
							   LV_Sql:=LV_Sql || ' AND      cod_modulo=''PV''';
							   LV_Sql:=LV_Sql || ' AND      cod_tipmodi<>''CR''';
							   LV_Sql:=LV_Sql || ' AND      cod_estado=0';

							   EXECUTE IMMEDIATE  LV_Sql INTO LN_NumId,LV_DatosRepro,LV_CodOsCPU,LV_CodTipModi;

							   --:::::::::MODIFICO A UNO EL ESTADO DEL REGISTRO DEL REPROCESO:::::::::

							   LV_Tabla   :='PV_ESTADO_REPROCESO_CPU_PR';
							   LV_Act      :='P';

							   pv_estado_reproceso_cpu_pr(  LN_NumId ,1,LV_Estado,LV_Proc,LN_CodMsg,LN_Evento,LV_Tabla,LV_Act,LV_Code,LV_Errm);

                               IF LV_Estado<>'3' THEN
							   	  		RAISE ERROR_PROCESO;
							   ELSE

									   --:::::::::SE GENERA REGISTRO PARA LA IDENTIFICACION DEL ACTUAL REPROCESO:::::::::

									   LV_Tabla   :='PV_AUDREG_PR';
							   		   LV_Act      :='P';

									   pv_general_ooss_pg.pv_audreg_pr ( 'PV', reg.num_os, 2, '1', NULL , 'CR', NULL , NULL, 'pv_cambio_plan_pg body v'|| pv_version_body_fn||'-header v'||pv_version_header_fn , NULL , NULL , NULL , 0, NULL , NULL , 0, LV_Estado, LV_Code	, LV_Errm );

                                      IF LV_Estado<>'3' THEN
									   	  		RAISE ERROR_PROCESO;
									   ELSE

											   --:::::::::SE IDENTIFICA NUEVO REGISTRO DEL REPROCESO:::::::::

											   LV_Tabla  :='AGE_AUD_REGULARIZA_TD';
											   LV_Act     :='S';

											   LV_Sql:=             ' SELECT max(num_identificador)';
											   LV_Sql:=LV_Sql||' FROM    ge_aud_regulariza_td';
											   LV_Sql:=LV_Sql||' WHERE  num_inter='||reg.num_os;
											   LV_Sql:=LV_Sql||' AND       tip_inter=2';
											   LV_Sql:=LV_Sql||' AND       cod_modulo=''PV''';
											   LV_Sql:=LV_Sql||' AND       cod_tipmodi=''CR''';

											   EXECUTE IMMEDIATE LV_Sql INTO LN_NumIdRePro;

											   --:::::::::SE BUSCAN DATOS DEL ABONADO:::::::::

											   LV_Tabla  :='AGA_ABOCEL';
											   LV_Act     :='S';

											   LV_Sql:=             ' SELECT  cod_cliente,cod_ciclo,cod_situacion';
											   LV_Sql:=LV_Sql||' FROM    ga_abocel';
											   LV_Sql:=LV_Sql||' WHERE  num_abonado='||reg.num_abonado;

											   EXECUTE IMMEDIATE LV_Sql INTO LN_CodClienteAbo,LN_CodCiclo,LV_CodSituacion;

											   --:::::::::SE VALIDA QUE EL CLIENTE EN LA OOSS SEA EL QUE TIENE EL ABONADO EN GA_ABOCEL:::::::::
											    IF LN_CodClienteAbo<>reg.cod_cliente THEN
												            LN_CodMsg    := 2731;
                                                            LV_DetalleEstado    :='ERROR_REPROCESO';
                                                            LV_DetalleError:='Abonado ya no pertenece al cliente de la OOSS ClienteOS['||reg.cod_cliente||']-ClienteAbo['||LN_CodClienteAbo||']';

															RAISE ERROR_REPROCESO;
											   END IF;

											   --:::::::::SE VALIDA SI LA SITUACION DEL ABONADO ES LA VALIDA:::::::::
											   IF LV_CodSituacion IN ('BAA','BAP') THEN
											                LN_CodMsg    := 323;
                                                            LV_DetalleEstado    :='ERROR_REPROCESO';
                                                            LV_DetalleError:='Situacion del Abonado no permitida para el reproceso';

															RAISE ERROR_REPROCESO;

											   END IF;

											   --:::::::::SE BUSCAN DATOS DEL CICLO EN EL CUAL SE GENERO LA OOSS EN CPU:::::::::

											   LV_Tabla  :='AFA_CICLFACT';
											   LV_Act     :='S';

											   LV_Sql:=' SELECT COUNT(1)';
											   LV_Sql:=LV_Sql||' FROM fa_ciclfact';
											   LV_Sql:=LV_Sql||' WHERE cod_ciclo='||LN_CodCiclo;
											   LV_Sql:=LV_Sql||' AND '|| TO_CHAR(reg.fec_estado,'DD-MM-YYYY hh24:mi:ss') ||' BETWEEN fec_desdellam AND fec_hastallam';

											   SELECT COUNT(1)
											   INTO    LN_Cont
											   FROM fa_ciclfact
											   WHERE cod_ciclo=LN_CodCiclo
											   AND reg.fec_estado BETWEEN fec_desdellam AND fec_hastallam;

											   --:::::::::VALIDO SI LA OOSS POR CPU, ES DE EL CICLO DE FACTURACION ACTUAL:::::::::
											   IF LN_Cont=0 THEN
											                LN_CodMsg    := 2730;
                                                            LV_DetalleEstado    :='ERROR_REPROCESO';
                                                            LV_DetalleError:='La OS es de ciclos Anteriores por lo que no se Reprocesara';

															RAISE ERROR_REPROCESO;

											   END IF;

											   --:::::::::INICIO PARSEO DE DATOS::::::::::::::::
											   pv_parseo_cpu_pr(  LV_DatosRepro,LN_ClienteOri,LN_ClienteDes,LN_NumAboOri ,LN_CuentaDes,LV_CodPlantarifDes,LV_AplicaTras ,
											   LD_FechaProg ,LV_Usuario ,LV_Estado,LV_Proc	,LN_CodMsg,LN_Evento,LV_Tabla,LV_Act,LV_Code,LV_Errm);

											   IF LV_Estado<>'3' THEN
											             RAISE ERROR_REPROCESO;
											   END IF;
											   --:::::::::FIN       PARSEO DE DATOS::::::::::::::::

											   --::::::::::::::::OOSS AL CORTE DE CICLO:::::::::::::::::::::::::::::
											   IF LV_CodOsCPU IN ('10020','10530','10539','10233') THEN
											   	  			pv_reproceso_cpu_alciclo_pr(reg.num_os,reg.num_abonado,reg.cod_cliente,LV_CodOsCPU,
														   								LV_CodPlantarifDes,LV_Usuario,LV_Estado,LV_Proc,LN_CodMsg,LN_Evento,LV_Tabla,LV_Act,LV_Code,LV_Errm);

															IF LV_Estado<>'3' THEN
														RAISE ERROR_REPROCESO;
											                END IF;


											   END IF;	--ENDIF reg.cod_os IN ('10020','10530','10539','10233')

											    LV_Tabla	:='PV_DETALLE_OS_TO';
							    				LV_Act	      :='U';

							    				UPDATE pv_detalle_os_to
							    				SET estado='REPROCESADA'
							    				WHERE num_os=reg.num_os;

												pv_estado_reproceso_cpu_pr(  LN_NumId ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

												IF LV_EstadoAux<>'3' THEN
													   		ROLLBACK;

															p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
												ELSE
															pv_estado_reproceso_cpu_pr(  LN_NumIdRePro ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

															IF LV_EstadoAux<>'3' THEN
															   			ROLLBACK;
																		p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
															ELSE
																 		COMMIT;
															END IF;

												END IF;

							   		  END IF; -- IF LV_Estado<>'3' THEN

							   END IF; --IF LV_Estado<>'3' THEN

					EXCEPTION

							 WHEN ERROR_PROCESO THEN
							 	  		p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_Tabla,LV_Act,'E:'||LN_Evento,LV_Errm);

							 WHEN ERROR_REPROCESO THEN
							 			 ROLLBACK;
										IF LN_Evento IS NULL OR LN_Evento=0 THEN
											LV_Estado	   :='5';
											LV_Proc         :='pv_reprocesa_ooss_cpu_pr';

											IF NOT ge_errores_pg.mensajeerror(LN_CodMsg, LV_MensajeError) THEN
											   LV_MensajeError := 'Error No Clasificado';
											END IF;

											LN_Evento := ge_errores_pg.grabarpl( LN_Evento,'PV',LV_MensajeError,'1.0',USER,	'pv_reprocesa_ooss_cpu_pr',LV_Sql,LN_CodMsg,LV_DesError);

										END IF;

										pv_actdatos_reproceso_cpu_pr(  LN_NumId,LV_Tabla,LV_Act ,LN_Evento,'-1','-1',LV_Code, LV_Errm,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

										IF LV_Estado<>'3' THEN
										   		    p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_Tabla,LV_Act ,'E:'||LN_EventoAux,LV_Errm);
										ELSE
													LV_Proc      :='pv_reprocesa_ooss_cpu_pr';

													pv_actdatos_reproceso_cpu_pr(  LN_NumIdRePro,LV_Tabla,LV_Act ,LN_Evento,LV_DetalleError,LV_Sql,LV_Code, LV_Errm,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

													IF LV_EstadoAux<>'3' THEN
										   		       				  p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
													ELSE

																	UPDATE pv_detalle_os_to
																	SET       estado=LV_DetalleEstado
																	            ,des_error= LV_DetalleError
																	WHERE  num_os=reg.num_os
																	AND      estado=reg.estado
																	AND      num_abonado=reg.num_abonado
																	AND      cod_cliente=reg.cod_cliente
																	AND 	 fec_estado=reg.fec_estado
																	AND      num_proceso=reg.num_proceso;

																	pv_estado_reproceso_cpu_pr(  LN_NumId ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

																	IF LV_EstadoAux<>'3' THEN
																	   		ROLLBACK;

																			p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
																	ELSE
																			pv_estado_reproceso_cpu_pr(  LN_NumIdRePro ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

																			IF LV_EstadoAux<>'3' THEN
																			   			ROLLBACK;
																						p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
																			ELSE
																				 		COMMIT;
																			END IF; --IF LV_EstadoAux<>'3' THEN

																	END IF;	--ENDIF LV_EstadoAux<>'3' THEN

													END IF;  --ENDIF LV_EstadoAux<>'3' THEN

										END IF; --ENDIF LV_Estado<>'3' THEN

							 WHEN OTHERS THEN
							 	 ROLLBACK;

								  LV_Errm:=SQLERRM;
								  LN_CodMsg := 0;

								  IF NOT ge_errores_pg.mensajeerror(LN_CodMsg, LV_MensajeError) THEN
									       LV_MensajeError := 'Error No Clasificado';
								  END IF;

								  LV_DesError :='-T:'||LV_Tabla;
								  LV_DesError :=LV_DesError ||'('||LV_Act||')-'||LV_Errm;

								  LN_Evento :=ge_errores_pg.grabarpl( LN_Evento, 'PV',LV_MensajeError,'1.0',USER,'pv_reproceso_cpu_alciclo_pr',LV_Sql,LN_CodMsg,LV_DesError);

								  pv_actdatos_reproceso_cpu_pr(  LN_NumId,LV_Tabla,LV_Act,LN_Evento,'-1','-1',LV_Code, LV_Errm,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

								  IF LV_EstadoAux<>'3' THEN
										   		    p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);

								  ELSE
													LV_Proc      :='PV_REPROCESA_OOSS_CPU_PR';

													pv_actdatos_reproceso_cpu_pr(  LN_NumIdRePro,LV_Tabla,LV_Act,LN_Evento,LV_DetalleError,LV_Sql,LV_Code, LV_Errm,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

													IF LV_EstadoAux<>'3' THEN
										   		       				  p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
													ELSE
				 			  										UPDATE pv_detalle_os_to
																	SET       estado='ERROR_REPROCESO'
																	WHERE  num_os=reg.num_os
																	AND      estado=reg.estado
																	AND      num_abonado=reg.num_abonado
																	AND      cod_cliente=reg.cod_cliente
																	AND 	 fec_estado=reg.fec_estado
																	AND      num_proceso=reg.num_proceso;

																	pv_estado_reproceso_cpu_pr(  LN_NumId ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

																	IF LV_EstadoAux<>'3' THEN
																	   		ROLLBACK;

																			p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
																	ELSE
																			pv_estado_reproceso_cpu_pr(  LN_NumIdRePro ,LV_Estado,LV_EstadoAux,LV_Proc,LN_CodMsg,LN_EventoAux,LV_TablaAux,LV_ActAux,LV_Code,LV_Errm);

																			IF LV_EstadoAux<>'3' THEN
																			   			ROLLBACK;
																						p_inserta_errores (1,'CR',reg.num_os,SYSDATE, LV_Proc,LV_TablaAux,LV_ActAux,'E:'||LN_EventoAux,LV_Errm);
																			ELSE
																				 		COMMIT;
																			END IF;

																	END IF;
													END IF;

						          END IF;

					END;
			END LOOP;

END pv_reprocesa_ooss_cpu_pr;

--FIN COL-77303|18-02-2009|GEZ

END PV_CAMBIO_PLAN_PG;
/
SHOW ERRORS
