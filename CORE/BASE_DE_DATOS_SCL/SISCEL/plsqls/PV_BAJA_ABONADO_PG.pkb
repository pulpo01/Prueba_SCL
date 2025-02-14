CREATE OR REPLACE PACKAGE BODY pv_baja_abonado_pg IS

CN_Version_Body VARCHAR2(10):='01.00.00';		   --COL-79523|06-03-2009|GEZ

--INI COL-79523|06-03-2009|GEZ
FUNCTION pv_version_body_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Body;
END;

FUNCTION pv_version_header_fn RETURN VARCHAR2 IS

BEGIN
		 RETURN CN_Version_Header;
END;

PROCEDURE pv_valida_baja_batch_pr( EN_NumOs                IN                            pv_iorserv.num_os%TYPE,
		  											    SV_Mensaje              OUT NOCOPY 		      VARCHAR2,
														SV_MensajeCorto      OUT NOCOPY 		   VARCHAR2,
														SV_Estado	             OUT NOCOPY 		   VARCHAR2,
														SV_Proc	                  OUT NOCOPY 			VARCHAR2,
														SN_CodMsg	           OUT NOCOPY 			 NUMBER,
														SN_Evento	             OUT NOCOPY 		   NUMBER,
														SV_Tabla	             OUT NOCOPY 		   VARCHAR2,
														SV_Act		               OUT NOCOPY 			 VARCHAR2,
														SV_Code	                 OUT NOCOPY 		   VARCHAR2,
														SV_Errm	                 OUT NOCOPY 		   VARCHAR2
														) IS

LV_DesError			   VARCHAR2(1000);
LV_Sql			          VARCHAR2(2000);
LV_MensajeError		VARCHAR2(2000);

LN_Cont                    NUMBER;

LN_NumOsMax                pv_iorserv.num_os%TYPE;

LN_AbonadoCamCom      pv_camcom.num_abonado%TYPE;
LN_ClienteCamCom         pv_camcom.cod_cliente%TYPE;

LN_ClienteAbo                ga_abocel.cod_cliente%TYPE;

BEGIN
	 SV_Estado      :='0';
	 SV_Proc         := 'pv_valida_baja_batch_pr';
	 SN_CodMsg    :=0;
	 SN_Evento      :=0;
	 SV_Code        :='0';
	 SV_Errm         :='0';

	 LV_DesError := 'PV_VALIDA_BAJA_BATCH_PR(' || EN_NumOs ||')';

	 SV_Tabla	 :='PV_CAMCOM';
	 SV_Act        :='S';

	 LV_Sql:= ' SELECT num_abonado,cod_cliente FROM pv_camcom WHERE num_os='||EN_NumOs;

	 EXECUTE IMMEDIATE LV_Sql INTO LN_AbonadoCamCom,LN_ClienteCamCom;

	 --::::INI VALIDO SITUACION DEL ABONADO:::::::--
	 SV_Tabla	 :='PV_SITUABO_ACTABO_PR';
     SV_Act        :='P';

	 pv_general_ooss_pg.pv_situabo_actabo_pr(LN_AbonadoCamCom,'BA',SV_Estado,SV_Proc,SN_CodMsg,SN_Evento,SV_Tabla,SV_Act,SV_Code,SV_Errm);

	 IF SV_Estado<>'3' THEN

				SV_Tabla	 :='ABOCEL/ABOAMIST';
     			SV_Act        :='S';

				SELECT SUBSTR('ABO['||num_abonado||'],'||DECODE(cod_uso,2,'POST',10,'HIB','NN')||' en Sit['||cod_situacion||']',1,30)
				INTO     SV_MensajeCorto
				FROM    ga_abocel
				WHERE  num_abonado = LN_AbonadoCamCom
				UNION ALL
				SELECT SUBSTR('ABO['||num_abonado||'],PRE en Sit['||cod_situacion||']',1,30)
				FROM    ga_aboamist
				WHERE  num_abonado = LN_AbonadoCamCom;

				IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, SV_Mensaje) THEN
		                SV_Mensaje := 'Error No Clasificado';
		        END IF;

				SV_Estado:='6';

	 END IF;
	 --:::FIN VALIDO SITUACION DEL ABONADO:::::::--

	 --:::INI VALIDO CLIENTE:::::::--

	 IF SV_Estado='3' THEN
	 			SV_Tabla	 :='ABOCEL/ABOAMIST';
     			SV_Act        :='S';

				LV_Sql:=' SELECT cod_cliente FROM ga_abocel WHERE num_abonado='||LN_AbonadoCamCom;
				LV_Sql	:=LV_Sql || ' UNION ALL SELECT cod_cliente FROM ga_aboamist WHERE num_abonado='||LN_AbonadoCamCom;

				EXECUTE IMMEDIATE LV_Sql INTO LN_ClienteAbo;

				IF LN_ClienteAbo<> LN_ClienteCamCom THEN
				   			SV_Estado:='6';
							SV_MensajeCorto:='Abo pertenece a otro cliente';
							SV_Mensaje:='El cliente con el cual se inscribio esta OOSS no es el mismo que tiene actualmente el Abonado se AutoCancelara OOSS ClienteAbo['||LN_ClienteAbo||']-ClienteCamCom['||LN_ClienteCamCom||']';

				END IF;

	 END IF;
	 --:::FIN VALIDO CLIENTE:::::::--

	 --:::INI VALIDO OTRAS OOSS:::::::--
	 IF SV_Estado='3' THEN

			SV_Tabla	 :='IORSERV/CAMCOM';
     	    SV_Act        :='S';

			LV_Sql  :=' SELECT COUNT(1) FROM pv_iorserv a,pv_camcom b,pv_erecorrido c';
			LV_Sql	:=LV_Sql || ' WHERE b.num_abonado='||LN_AbonadoCamCom;
			LV_Sql	:=LV_Sql || ' AND     a.num_os=b.num_os AND a.cod_os IN (''10222'',''10232'',''10233'') AND a.cod_estado<210';
			LV_Sql	:=LV_Sql || ' AND     c.num_os=a.num_os AND c.cod_estado=a.cod_estado AND c.tip_estado NOT IN (4,5,6)';

			EXECUTE IMMEDIATE LV_Sql INTO LN_Cont;

			IF LN_Cont>0 THEN

						 LV_Sql := ' SELECT z.num_os FROM pv_iorserv z,pv_camcom x,pv_erecorrido y';
						 LV_Sql := LV_Sql || ' WHERE x.num_abonado='||LN_AbonadoCamCom;
						 LV_Sql := LV_Sql || ' AND     z.num_os=x.num_os AND z.cod_os IN (''10222'',''10232'',''10233'') AND z.cod_estado<210';
						 LV_Sql := LV_Sql || ' AND     y.num_os=z.num_os AND y.cod_estado=z.cod_estado AND y.tip_estado NOT IN (4,5,6)';
						 LV_Sql := LV_Sql || ' AND     NVL(z.fh_ejecucion,z.fecha_ing) =(';
						 LV_Sql := LV_Sql || ' SELECT MAX (NVL(fh_ejecucion,fecha_ing)) FROM pv_iorserv a,pv_camcom b,pv_erecorrido c';
						 LV_Sql := LV_Sql || ' WHERE b.num_abonado=x.num_abonado';
						 LV_Sql := LV_Sql || ' AND     a.num_os=b.num_os AND a.cod_os IN (''10222'',''10232'',''10233'') AND a.cod_estado<210';
						 LV_Sql := LV_Sql || ' AND     c.num_os=a.num_os AND c.cod_estado=a.cod_estado AND c.tip_estado NOT IN (4,5,6))';

						 EXECUTE IMMEDIATE LV_Sql INTO LN_NumOsMax;

						 IF EN_NumOs<>LN_NumOsMax THEN
                                SV_Estado:='6';
							    SV_MensajeCorto:='Existe Otra OS mas nueva';
							    SV_Mensaje:='Se cancela OS ya que existe otra baja aun sin ejecutar mas reciente a esta NUM_OS['||LN_NumOsMax||']';
						 END IF;

			END IF;

	 END IF;
	 --:::FIN VALIDO OTRAS OOSS:::::::--

EXCEPTION

	WHEN OTHERS THEN
		SV_Estado	:='4';
		SV_Code		:=SQLCODE;
		SV_Errm		:=SQLERRM;

		SN_CodMsg := 0;

		IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
		   LV_MensajeError := 'Error No Clasificado';
		END IF;

		LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
		LV_DesError :=LV_DesError ||'('||SV_Act||')';
		LV_DesError :=LV_DesError ||'-'|| SV_Errm;

		SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'pv_situabo_actabo_pr',LV_Sql,SN_CodMsg,LV_DesError);

END pv_valida_baja_batch_pr;
--FIN COL-79523|06-03-2009|GEZ

END pv_baja_abonado_pg;
/
SHOW ERRORS
