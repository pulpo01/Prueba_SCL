CREATE OR REPLACE PACKAGE BODY PV_CARGOS_PG AS

----------------------------------------------------------------------------------------------------------
--1.- Metodo  :  ActualizarCargoBolsaDinamica
	PROCEDURE PV_ACTUA_CARGO_BOLSA_DINA_PR (EO_BOLSAS_DINAMICAS  IN     	  	 PV_BOLSAS_DINAMICAS_QT,
										    SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
										    SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
										    SN_num_evento        OUT NOCOPY		 ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_ACTUA_CARGO_BOLSA_DINA_PR"
	      Lenguaje="PL/SQL"
	      Fecha="13-06-2007"
	      Versión="La del package"
	      Diseñador=""
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Metodo  :  actualizarCargoBolsaDinamica </Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_BOLSAS_DINAMICAS" 			   	Tipo="estructura">estructura Type de Datos </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.SECUENCIA" 	   	Tipo="estructura">Numero de Secuencia      </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_CLIENTE"   	Tipo="estructura">Codigo del Cliente       </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_CICLO" 	   	Tipo="estructura">Codigo del Ciclo         </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_PLANTARIF1" Tipo="estructura">Codigo Plantarifario uno </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_PLANTARIF2" Tipo="estructura">Codigo plantarifario dos </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_PRODUCTO" 	Tipo="estructura">Codigo del Producto      </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.COD_CARGO" 		Tipo="estructura">Codigo Cargo             </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.IMP_CARGO" 		Tipo="estructura">Imp. Cargo               </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.IMP_MAXIMO" 	Tipo="estructura">Imp. Maxima              </param>>
	            <param nom="EO_BOLSAS_DINAMICAS.FECHA" 			Tipo="estructura">Fecha                    </param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" 					Tipo="NUMERICO">Codigo de Retorno		   </param>>
	            <param nom="SV_mens_retorno" 					Tipo="CARACTER">Mensaje de Retorno		   </param>>
	            <param nom="SN_num_evento" 						Tipo="NUMERICO">Numero de Evento		   </param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   			ge_errores_pg.DesEvent;
		LV_sSql			   			ge_errores_pg.vQuery;
		ERROR_EJECUCION       		EXCEPTION;
		EN_num_transaccion	   		ga_transacabo.num_transaccion%TYPE;
		EN_cod_cliente    	   		ge_clientes.cod_cliente%TYPE;
		EN_cod_ciclo			   	fa_ciclfact.cod_ciclo%TYPE;
		EV_cod_plantarif1		   	ta_plantarif.cod_plantarif%TYPE;
		EV_cod_plantarif2		    ta_plantarif.cod_plantarif%TYPE;
		EV_cod_cargobasico2	   		ta_plantarif.cod_cargobasico%TYPE;
		EN_imp_cargo_basico	   		NUMBER(14,4);
		EN_imp_final	   		    NUMBER(14,4);

	BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

			EN_num_transaccion	   	:= EO_BOLSAS_DINAMICAS.SECUENCIA;
			EN_cod_cliente    	   	:= EO_BOLSAS_DINAMICAS.COD_CLIENTE;
			EN_cod_ciclo			:= EO_BOLSAS_DINAMICAS.COD_CICLO;
			EV_cod_plantarif1		:= EO_BOLSAS_DINAMICAS.COD_PLANTARIF1;
			EV_cod_plantarif2		:= EO_BOLSAS_DINAMICAS.COD_PLANTARIF2;
			EV_cod_cargobasico2	   	:= EO_BOLSAS_DINAMICAS.COD_CARGO;
			EN_imp_cargo_basico	   	:= EO_BOLSAS_DINAMICAS.IMP_CARGO;
			EN_imp_final	   		:= EO_BOLSAS_DINAMICAS.IMP_MAXIMO;

			LV_sSql:='';
			LV_sSql:= LV_sSql || ' PV_BOLSAS_DINAMICAS_PG.PV_ODBC_ACTLZBLSDNMCCAMPLAN_PR ('||to_char(EN_num_transaccion)||', ';
			LV_sSql:= LV_sSql || ' '||to_char(EN_cod_cliente)				||', ';
			LV_sSql:= LV_sSql || ' '||to_char(EN_cod_ciclo)			    	||', ';
			LV_sSql:= LV_sSql || ' '||EV_cod_plantarif1				    	||', ';
			LV_sSql:= LV_sSql || ' '||EV_cod_plantarif2				    	||', ';
			LV_sSql:= LV_sSql || ' '||EV_cod_cargobasico2			    	||', ';
			LV_sSql:= LV_sSql || ' '||to_char(nvl(EN_imp_cargo_basico,0))	||', ';
			LV_sSql:= LV_sSql || ' '||to_char(nvl(EN_imp_final,0))			||'); ';


			PV_BOLSAS_DINAMICAS_PG.PV_ODBC_ACTLZBLSDNMCCAMPLAN_PR (EN_num_transaccion,EN_cod_cliente,EN_cod_ciclo,EV_cod_plantarif1,
																  EV_cod_plantarif2,
																  EV_cod_cargobasico2,
																  EN_imp_cargo_basico,
																  EN_imp_final);
			LV_sSql:='';
			LV_sSql:=LV_sSql||'SELECT  COD_RETORNO,DES_CADENA INTO SN_cod_retorno,SV_mens_retorno ';
			LV_sSql:=LV_sSql||'FROM ga_transacabo WHERE num_transaccion =  '||to_char(EN_num_transaccion)|| '; ';

			-- Rescta Codigo y mensaje de Error que se produce en el package
			SELECT  COD_RETORNO,DES_CADENA	INTO  SN_cod_retorno,SV_mens_retorno
			FROM ga_transacabo WHERE  num_transaccion = EN_num_transaccion;
			IF 	SN_cod_retorno<>0 THEN
	   		   		RAISE ERROR_EJECUCION;
			END IF;

	EXCEPTION
    WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_ACTUA_CARGO_BOLSA_DINA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||'); '||SV_mens_retorno||'; PV_CARGOS_PG.PV_ACTUA_CARGO_BOLSA_DINA_PR';
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_ACTUA_CARGO_BOLSA_DINA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_ACTUA_CARGO_BOLSA_DINA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_ACTUA_CARGO_BOLSA_DINA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_ACTUA_CARGO_BOLSA_DINA_PR('||to_char(EN_num_transaccion)||', '||to_char(EN_cod_cliente)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_ACTUA_CARGO_BOLSA_DINA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PV_ACTUA_CARGO_BOLSA_DINA_PR;

----------------------------------------------------------------------------------------------------------

--3.- Metodo  :                                 PV_CARGOS_PG.PV_OBTENER_IMPUESTOS_PR
PROCEDURE PV_OBTENER_IMPUESTOS_PR(SO_PRESUPUESTO   		   IN OUT 			GA_PRESUPUESTO_QT,
							      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
							      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
							      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTENER_IMPUESTOS_PR "
	      Lenguaje="PL/SQL"
	      Fecha="28-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene impuestos</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_PRESUPUESTO" Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	LV_des_error	   			ge_errores_pg.DesEvent;
	LV_sSql			   			ge_errores_pg.vQuery;
	ERROR_EJECUCION       		EXCEPTION;

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql:='';
		LV_sSql:= LV_sSql || 'VE_INTERMEDIARIO_PG.VE_OBTIENEPRESUPUESTO_PR('||to_char(SO_PRESUPUESTO.NUM_PROCESO)||', ';
		LV_sSql:= LV_sSql || ' '||to_char(SO_PRESUPUESTO.IMP_BASE)     ||',  ';
		LV_sSql:= LV_sSql || ' '||to_char( SO_PRESUPUESTO.IMP_DTO)     ||',  ';
		LV_sSql:= LV_sSql || ' '||to_char(SO_PRESUPUESTO.IMP_IMPUESTO) ||',  ';
		LV_sSql:= LV_sSql || ' '||SN_cod_retorno  					   ||',  ';
		LV_sSql:= LV_sSql || ' '||SV_mens_retorno					   ||',  ';
		LV_sSql:= LV_sSql || ' '||to_char(SN_num_evento) 			   ||'); ';

		VE_INTERMEDIARIO_PG.VE_OBTIENEPRESUPUESTO_PR(SO_PRESUPUESTO.NUM_PROCESO,
													 SO_PRESUPUESTO.IMP_BASE,
													 SO_PRESUPUESTO.IMP_DTO,
													 SO_PRESUPUESTO.IMP_IMPUESTO,
													 SN_cod_retorno,
													 SV_mens_retorno,
													 SN_num_evento );
			IF 	SN_cod_retorno<>0 THEN
	   		   		RAISE ERROR_EJECUCION;
			END IF;
	EXCEPTION
      WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_OBTENER_IMPUESTOS_PR('||to_char(SO_PRESUPUESTO.NUM_PROCESO)||');  PV_CARGOS_PG.PV_OBTENER_IMPUESTOS_PR';
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTENER_IMPUESTOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTENER_IMPUESTOS_PR('||to_char(SO_PRESUPUESTO.NUM_PROCESO)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTENER_IMPUESTOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_IMPUESTOS_PR;

----------------------------------------------------------------------------------------------------------------

--4.- Metodo  :                                 PV_CARGOS_PG.PV_ACEPTAR_PRESUPUESTO_PR
PROCEDURE PV_ACEPTAR_PRESUPUESTO_PR(EO_PRESUPUESTO   		   IN    			GA_PRESUPUESTO_QT,
								      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
								      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
								      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_ACEPTAR_PRESUPUESTO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="10-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Ejecuta facturacion</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_PRESUPUESTO" Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   			ge_errores_pg.DesEvent;
		LV_sSql			   			ge_errores_pg.vQuery;
		ERROR_EJECUCION       		EXCEPTION;
	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

  		LV_sSql:= 		   	 ' UPDATE FA_INTERFACT';
		LV_sSql:= LV_sSql || ' SET     COD_ESTADOC     = '|| CN_vta_ingresada;
 		LV_sSql:= LV_sSql || ' 		  ,COD_ESTPROC     = '|| CN_cod_proc;
 		LV_sSql:= LV_sSql || '		  ,TIP_FOLIACION   = '|| EO_PRESUPUESTO.TIP_FOLIACION;
 		LV_sSql:= LV_sSql || '		  ,FEC_VENCIMIENTO = '|| EO_PRESUPUESTO.FECHA_VCTO;
		LV_sSql:= LV_sSql || ' WHERE  NUM_PROCESO =' || EO_PRESUPUESTO.NUM_PROCESO;
		LV_sSql:= LV_sSql || ' AND    NUM_VENTA   =' || EO_PRESUPUESTO.NUM_VENTA;

		UPDATE FA_INTERFACT
		SET    COD_ESTADOC     = CN_vta_ingresada
		      ,COD_ESTPROC     = CN_cod_proc
			  ,TIP_FOLIACION   = EO_PRESUPUESTO.TIP_FOLIACION
		      ,FEC_VENCIMIENTO = EO_PRESUPUESTO.FECHA_VCTO
		WHERE  NUM_PROCESO     = EO_PRESUPUESTO.NUM_PROCESO
		AND    NUM_VENTA       = EO_PRESUPUESTO.NUM_VENTA;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_ACEPTAR_PRESUPUESTO_PR('||to_char(EO_PRESUPUESTO.NUM_PROCESO)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_ACEPTAR_PRESUPUESTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACEPTAR_PRESUPUESTO_PR;

-----------------------------------------------------------------------------------------------------------------


--5.- Metodo  :									PV_OBTIENE_CUOTAS_PR
PROCEDURE PV_OBTIENE_CUOTAS_PR(CURSOR_CUOTA 	   OUT NOCOPY   REFCURSOR,
							   SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
						       SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
						       SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_CUOTAS_PR "
	      Lenguaje="PL/SQL"
	      Fecha="28-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene Cuotas </Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_CARGOS" Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	sCod_Cuota  GE_TIPCUOTAS.COD_CUOTA%TYPE;
	SN_valor_ordenacion   ged_parametros .val_parametro%TYPE;
    SN_permiso  VARCHAR2(500);

	BEGIN

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		  OPEN CURSOR_CUOTA FOR
		SELECT a.cod_cuota, a.des_cuota, a.num_cuotas, 1 AS defual
	      FROM ge_tipcuotas a, ged_parametros b
         WHERE b.cod_modulo = 'GA'
           AND b.cod_producto = 1
           AND b.nom_parametro = 'CUOTA_DEF'
           AND a.cod_cuota = b.val_parametro
         UNION
        SELECT a.cod_cuota, a.des_cuota, a.num_cuotas, NULL
          FROM ge_tipcuotas a;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENE_CUOTAS_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTIENE_CUOTAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END  PV_OBTIENE_CUOTAS_PR;


-----------------------------------------------------------------------------------------------------------------
--6.- Metodo  :									PV_OBTIENEMOD_PAGOS_PR
PROCEDURE PV_OBTIENEMOD_PAGOS_PR(EN_programa 		   IN  			 GA_MODVENT_APLIC.COD_APLIC%TYPE,
							     EN_canal_venta 	   IN  			 GA_MODVENT_APLIC.COD_CANAL%TYPE,
							     EN_tipo_contrato 	   IN  			 GAD_MODPAGO_CATPLAN.COD_TIPCONTRATO%TYPE,
							     EN_numero_meses 	   IN  			 GAD_MODPAGO_CATPLAN.NUM_MESES%TYPE,
							     EN_codigo_operacion   IN  			 GAD_MODPAGO_CATPLAN.COD_OPERACION%TYPE,
							     EN_indicador_de_causa IN  			 GAD_MODPAGO_CATPLAN.IND_CAUSA%TYPE,
							     EN_codigo_causa 	   IN 			 GAD_MODPAGO_CATPLAN.COD_CAUSA%TYPE,
							     EN_permiso 		   IN 			 VARCHAR2,
							     CURSOR_MODPAGOS 	      OUT NOCOPY REFCURSOR,
								 SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
							     SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
							     SN_num_evento            OUT NOCOPY ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENEMOD_PAGOS_PR "
	      Lenguaje="PL/SQL"
	      Fecha="28-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene  Pagos </Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EN_programa 		      " 		Tipo="Nombre Programa    ">			 </param>>
	            <param nom="EN_canal_venta 	   	   	  " 		Tipo="Canal de Venta     ">			 </param>>
	            <param nom="EN_tipo_contrato 	   	  " 		Tipo="Tipo de Contrato   ">			 </param>>
	            <param nom="EN_numero_meses 	   	  " 		Tipo="Numeros de Meses   ">			 </param>>
	            <param nom="EN_codigo_operacion       " 		Tipo="Codigo Operacion   ">			 </param>>
	            <param nom="EN_indicador_de_causa 	  " 		Tipo="Indicador de Causa ">			 </param>>
	            <param nom="EN_codigo_causa 	   	  " 		Tipo="Codigo de Causa    ">			 </param>>
	            <param nom="EN_permiso 		   		  " 		Tipo="Permiso            ">			 </param>>
	         </Entrada>
	         <Salida>
	            <param nom="CURSOR_MODPAGOS"  Tipo="NUMERICO">Cursor              </param>>
	            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno   </param>>
	            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno  </param>>
	            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento    </param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	      ge_errores_pg.DesEvent;
		LV_sSql			   	  ge_errores_pg.vQuery;
		sCod_Cuota  	   	  GE_TIPCUOTAS.COD_CUOTA%TYPE;
		SN_valor_ordenacion   ged_parametros .val_parametro%TYPE;
		SN_permiso  		  VARCHAR2(500);
	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		 If EN_indicador_de_causa <> '0' And EN_codigo_causa <> ''  and EN_permiso= 'TRUE' then

			 LV_sSql:='OPEN CURSOR_MODPAGOS FOR SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA ';
			 LV_sSql:=LV_sSql||'FROM  GE_MODVENTA A, GA_MODVENT_APLIC B ';
			 LV_sSql:=LV_sSql||'WHERE A.COD_MODVENTA = B.COD_MODVENTA ';
			 LV_sSql:=LV_sSql||'AND B.COD_PRODUCTO ='||CN_producto||' ';
			 LV_sSql:=LV_sSql||'AND B.COD_APLIC LIKE  ('||EN_programa||') ';
			 LV_sSql:=LV_sSql||'AND B.COD_CANAL ='||EN_canal_venta||' ';
			 LV_sSql:=LV_sSql||'AND A.COD_MODVENTA IN (SELECT COD_MODPAGO ';
			 LV_sSql:=LV_sSql||'FROM  GAD_MODPAGO_CATPLAN C ';
			 LV_sSql:=LV_sSql||'WHERE C.COD_TIPCONTRATO = '||EN_tipo_contrato||' ';
			 LV_sSql:=LV_sSql||'AND C.NUM_MESES ='||EN_numero_meses||' ';
			 LV_sSql:=LV_sSql||'AND C.COD_OPERACION ='||EN_codigo_operacion||' ';
			 LV_sSql:=LV_sSql||'AND C.IND_CAUSA ='||EN_indicador_de_causa||' ';
			 LV_sSql:=LV_sSql||'AND C.COD_CAUSA ='||EN_codigo_causa||' ';
			 LV_sSql:=LV_sSql||'AND C.COD_CANAL_VTA ='||EN_canal_venta||' ';
			 LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA ';
			 LV_sSql:=LV_sSql||'AND C.COD_MODPAGO  = A.COD_MODVENTA) ';
			 LV_sSql:=LV_sSql||'AND IND_CUOTAS <> -1; ';

			OPEN CURSOR_MODPAGOS FOR

				SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA
				FROM  GE_MODVENTA A, GA_MODVENT_APLIC B
				WHERE A.COD_MODVENTA = B.COD_MODVENTA
				AND B.COD_PRODUCTO  = 1
				AND B.COD_APLIC    LIKE  (EN_programa)
				AND B.COD_CANAL    =     EN_canal_venta
				AND A.COD_MODVENTA IN (SELECT COD_MODPAGO
				FROM  GAD_MODPAGO_CATPLAN C
				WHERE C.COD_TIPCONTRATO = EN_tipo_contrato
				AND C.NUM_MESES       = EN_numero_meses
				AND C.COD_OPERACION   = EN_codigo_operacion
				AND C.IND_CAUSA       = EN_indicador_de_causa
				AND C.COD_CAUSA =   EN_codigo_causa
				AND C.COD_CANAL_VTA = EN_canal_venta
				AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA
				AND C.COD_MODPAGO  = A.COD_MODVENTA)
				AND IND_CUOTAS <> -1;
    ELSIF  EN_permiso= 'FALSE' then

			LV_sSql:='OPEN CURSOR_MODPAGOS FOR SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA ';
		    LV_sSql:=LV_sSql||'FROM  GE_MODVENTA A, GA_MODVENT_APLIC B ';
		    LV_sSql:=LV_sSql||'WHERE A.COD_MODVENTA = B.COD_MODVENTA ';
		    LV_sSql:=LV_sSql||'AND B.COD_PRODUCTO= '||CN_producto||' ';
		    LV_sSql:=LV_sSql||'AND B.COD_APLIC LIKE ('||EN_programa||') ';
		    LV_sSql:=LV_sSql||'AND B.COD_CANAL ='||EN_canal_venta||' ';
		    LV_sSql:=LV_sSql||'AND A.COD_MODVENTA IN (SELECT COD_MODPAGO ';
		    LV_sSql:=LV_sSql||'FROM  GAD_MODPAGO_CATPLAN C ';
		    LV_sSql:=LV_sSql||'WHERE C.COD_TIPCONTRATO ='||EN_tipo_contrato||' ';
		    LV_sSql:=LV_sSql||'AND C.NUM_MESES ='||EN_numero_meses||' ';
			LV_sSql:=LV_sSql||'AND C.COD_OPERACION ='||EN_codigo_operacion||' ';
		    LV_sSql:=LV_sSql||'AND C.IND_CAUSA ='||EN_indicador_de_causa||' ';
		    LV_sSql:=LV_sSql||'AND C.COD_CAUSA ='||EN_codigo_causa||' ';
		    LV_sSql:=LV_sSql||'AND C.COD_CANAL_VTA ='||EN_canal_venta||' ';
		    LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA ';
		    LV_sSql:=LV_sSql||'AND C.COD_MODPAGO  = A.COD_MODVENTA); ';

			OPEN CURSOR_MODPAGOS FOR
			SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA
			FROM  GE_MODVENTA A, GA_MODVENT_APLIC B
			WHERE A.COD_MODVENTA = B.COD_MODVENTA
			AND B.COD_PRODUCTO  = 1
			AND B.COD_APLIC    LIKE  (EN_programa)
			AND B.COD_CANAL    =     EN_canal_venta
			AND A.COD_MODVENTA IN (SELECT COD_MODPAGO
			FROM  GAD_MODPAGO_CATPLAN C
			WHERE C.COD_TIPCONTRATO = EN_tipo_contrato
			AND C.NUM_MESES       = EN_numero_meses
			AND C.COD_OPERACION   = EN_codigo_operacion
			AND C.IND_CAUSA       = EN_indicador_de_causa
			AND C.COD_CAUSA =   EN_codigo_causa
			AND C.COD_CANAL_VTA = EN_canal_venta
			AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA
			AND C.COD_MODPAGO  = A.COD_MODVENTA);
	ELSE
			LV_sSql:='OPEN CURSOR_MODPAGOS FOR SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA ';
		    LV_sSql:=LV_sSql||'FROM  GE_MODVENTA A, GA_MODVENT_APLIC B ';
		    LV_sSql:=LV_sSql||'WHERE A.COD_MODVENTA = B.COD_MODVENTA ';
		    LV_sSql:=LV_sSql||'AND B.COD_PRODUCTO = '||CN_producto||' ';
		    LV_sSql:=LV_sSql||'AND B.COD_APLIC LIKE ('||EN_programa||') ';
		    LV_sSql:=LV_sSql||'AND B.COD_CANAL ='||EN_canal_venta||' ';
		    LV_sSql:=LV_sSql||'AND A.COD_MODVENTA IN (SELECT COD_MODPAGO ';
		    LV_sSql:=LV_sSql||'FROM  GAD_MODPAGO_CATPLAN C ';
		    LV_sSql:=LV_sSql||'WHERE C.COD_TIPCONTRATO ='||EN_tipo_contrato||' ';
		    LV_sSql:=LV_sSql||'AND C.NUM_MESES ='||EN_numero_meses||' ';
		    LV_sSql:=LV_sSql||'AND C.COD_OPERACION ='||EN_codigo_operacion||' ';
		    LV_sSql:=LV_sSql||'AND C.IND_CAUSA ='||EN_indicador_de_causa||' ';
		    LV_sSql:=LV_sSql||'AND C.COD_CANAL_VTA ='||EN_canal_venta||' ';
		    LV_sSql:=LV_sSql||'AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA ';
		    LV_sSql:=LV_sSql||'AND C.COD_MODPAGO  = A.COD_MODVENTA); ';


			OPEN CURSOR_MODPAGOS FOR
			SELECT UNIQUE A.IND_CUOTAS, A.COD_MODVENTA, A.DES_MODVENTA
			FROM  GE_MODVENTA A, GA_MODVENT_APLIC B
			WHERE A.COD_MODVENTA = B.COD_MODVENTA
			AND B.COD_PRODUCTO  = 1
			AND B.COD_APLIC    LIKE (EN_programa)
			AND B.COD_CANAL    =    EN_canal_venta
			AND A.COD_MODVENTA IN (SELECT COD_MODPAGO
			FROM  GAD_MODPAGO_CATPLAN C
			WHERE C.COD_TIPCONTRATO = EN_tipo_contrato
			AND C.NUM_MESES       = EN_numero_meses
			AND C.COD_OPERACION   = EN_codigo_operacion
			AND C.IND_CAUSA       = EN_indicador_de_causa
			AND C.COD_CANAL_VTA = EN_canal_venta
			AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA
			AND C.COD_MODPAGO  = A.COD_MODVENTA);
	END IF;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENE_CUOTAS_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTIENEMOD_PAGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END  PV_OBTIENEMOD_PAGOS_PR;


-----------------------------------------------------------------------------------------------------------------
--7.- Metodo  :									PV_OBTIENEMODALIDAD_PAGOS_PR
PROCEDURE PV_OBTIENEMODALIDAD_PAGOS_PR(SO_CARGOS 		IN OUT 			PV_CARGOS_QT,
									   CURSOR_MODPAGOS 	   OUT NOCOPY 	REFCURSOR,
									   SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENEMODALIDAD_PAGOS_PR "
	      Lenguaje="PL/SQL"
	      Fecha="28-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene Modalidad de Pagos </Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_CARGOS" Tipo=" Estructura Type "> 		</param>>
	         </Entrada>
	         <Salida>
	            <param nom="CURSOR "   		  Tipo="NUMERICO">Retorno Cursor     </param>>
	            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno  </param>>
	            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno </param>>
	            <param nom="SN_num_evento" 	  Tipo="NUMERICO">Numero de Evento   </param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;

		E_PROGRAMA  GA_MODVENT_APLIC.COD_APLIC%TYPE;
		E_CANAL_VE  GA_MODVENT_APLIC.COD_CANAL%TYPE;
		E_TIP_CONT  GAD_MODPAGO_CATPLAN.COD_TIPCONTRATO%TYPE;
		E_NUM_MESES  GAD_MODPAGO_CATPLAN.NUM_MESES%TYPE;
		E_COD_OPERACION  GAD_MODPAGO_CATPLAN.COD_OPERACION%TYPE;
		E_IND_CAUSA  GAD_MODPAGO_CATPLAN.IND_CAUSA%TYPE;
		E_COD_CAUSA  GAD_MODPAGO_CATPLAN.COD_CAUSA%TYPE;
		E_permiso  VARCHAR2(255);

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;
		E_PROGRAMA:= SO_CARGOS.COD_CUOTA;
		E_CANAL_VE:=SO_CARGOS.CANAL_VENTA;
		E_TIP_CONT:=SO_CARGOS.TIP_CONTRATO;
		E_NUM_MESES := SO_CARGOS.NUM_MESES;
		E_COD_OPERACION:=SO_CARGOS.COD_OPERACION;
		E_IND_CAUSA:=SO_CARGOS.IND_CAUSA;
		E_COD_CAUSA:=SO_CARGOS.COD_CAUSA;
		E_permiso:=SO_CARGOS.PERMISO;

		LV_sSql:='PV_OBTIENEMOD_PAGOS_PR('||E_PROGRAMA||','||E_CANAL_VE||','||E_TIP_CONT||','||E_NUM_MESES||','||E_COD_OPERACION||','||E_IND_CAUSA||','||E_COD_CAUSA||','||E_permiso||',CURSOR_MODPAGOS,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); ';
		PV_OBTIENEMOD_PAGOS_PR(E_PROGRAMA,E_CANAL_VE, E_TIP_CONT, E_NUM_MESES, E_COD_OPERACION, E_IND_CAUSA, E_COD_CAUSA,E_permiso, CURSOR_MODPAGOS,SN_cod_retorno,  SV_mens_retorno, SN_num_evento);


	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENEMODALIDAD_PAGOS_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTIENEMODALIDAD_PAGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENEMODALIDAD_PAGOS_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--8.- Metodo  :									PV_VALIDA_FREEDOM_VENTA_PR
PROCEDURE PV_VALIDA_FREEDOM_VENTA_PR(SO_VAL_FREEDOM  IN OUT 		PV_VAL_FREEDOM_QT,
								     SN_cod_retorno     OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
								     SV_mens_retorno    OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
								     SN_num_evento      OUT NOCOPY	ge_errores_pg.evento
    )
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_VALIDA_FREEDOM_VENTA_PR "
	      Lenguaje="PL/SQL"
	      Fecha="11-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>valida si existe plan freedom en venta</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_VAL_FREEDOM Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	SN_resultado	   NUMBER(1);

	BEGIN

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql:='VE_servicios_venta_PG.VE_hay_pfreedom_en_venta_PR('||SO_VAL_FREEDOM.PARAM_PROPOR_VTA||','||SO_VAL_FREEDOM.NUM_VENTA||','||SO_VAL_FREEDOM.PARAM_PROPOR1||','||SO_VAL_FREEDOM.PARAM_PROPOR2||','||SN_resultado||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
		VE_servicios_venta_PG.VE_hay_pfreedom_en_venta_PR ( SO_VAL_FREEDOM.PARAM_PROPOR_VTA --in
				  							  			  ,SO_VAL_FREEDOM.NUM_VENTA			--in
			  							 	  			  ,SO_VAL_FREEDOM.PARAM_PROPOR1     --in
										 				  ,SO_VAL_FREEDOM.PARAM_PROPOR2     --in
										 				  ,SN_resultado     --out
			 				 	  	 	 				  ,SN_cod_retorno
                       		      	 	 				  ,SV_mens_retorno
                          		      	 				  ,SN_num_evento);


	    IF (SN_resultado = 1) THEN
			SO_VAL_FREEDOM.RESULTADO := 'TRUE';
		ELSE
			SO_VAL_FREEDOM.RESULTADO := 'FALSE';
		END IF;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_VALIDA_FREEDOM_VENTA_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_VALIDA_FREEDOM_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_VALIDA_FREEDOM_VENTA_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--9.- Metodo  : 								PV_OBTENER_FORMAS_PAGO_PR
PROCEDURE PV_OBTENER_FORMAS_PAGO_PR(EO_BUSQ_FORMA_PAGO	 IN 				PV_BUSQ_FORMA_PAGO_QT,
									CURSOR_FORMAS_PAGO	     OUT NOCOPY 	REFCURSOR,
								    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
								    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
								    SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    )
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTENER_FORMAS_PAGO_PR "
	      Lenguaje="PL/SQL"
	      Fecha="12-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>obtiene un cursor con las formas de pago</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_BUSQ_FORMA_PAGO" Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
 	            <param nom="CURSOR_FORMAS_PAGO" Tipo="cursor">Cursor de formas de pago</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	ERROR_EJECUCION    EXCEPTION;
	SN_resultado	   NUMBER(1);

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql:='VE_servicios_venta_PG.VE_obtiene_formas_pago_PR('||EO_BUSQ_FORMA_PAGO.PARAM_ORDEN_COMPRA_VAL||','||EO_BUSQ_FORMA_PAGO.EXISTE_PLAN_FREEDOM||','||EO_BUSQ_FORMA_PAGO.CATEG_TRIBUTARIA||',CURSOR_FORMAS_PAGO,'||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
		VE_servicios_venta_PG.VE_obtiene_formas_pago_PR (EO_BUSQ_FORMA_PAGO.PARAM_ORDEN_COMPRA_VAL
				  							  			,EO_BUSQ_FORMA_PAGO.EXISTE_PLAN_FREEDOM
											  			,EO_BUSQ_FORMA_PAGO.CATEG_TRIBUTARIA
				  							  			,CURSOR_FORMAS_PAGO
			  						 	  	 			,SN_cod_retorno
                        		      	  	  			,SV_mens_retorno
                           		      	  	  			,SN_num_evento);
		IF SN_cod_retorno>0 THEN
		   RAISE ERROR_EJECUCION;
		END IF;

	EXCEPTION
      WHEN ERROR_EJECUCION THEN
          LV_des_error   := 'PV_OBTENER_FORMAS_PAGO_PR(''); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTENER_FORMAS_PAGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTENER_FORMAS_PAGO_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTENER_FORMAS_PAGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_FORMAS_PAGO_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--10.-Metodo  :									PV_OBTENER_TIPOS_DOC_PR
PROCEDURE PV_OBTENER_TIPOS_DOC_PR(EO_BUSQ_TIPO_DOC		   IN 				PV_BUSQ_TIPO_DOC_QT,
								  CURSOR_TIPOS_DOC		   OUT NOCOPY 		REFCURSOR,
							      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
							      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
							      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
    )
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTENER_TIPOS_DOC_PR"
	      Lenguaje="PL/SQL"
	      Fecha="12-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>obtiene un cursor con los tipos de documentos/Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_BUSQ_TIPO_DOC" Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
 	            <param nom="CURSOR_TIPOS_DOC Tipo="cursor">Cursor de tipos de documentos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	SN_resultado	   NUMBER(1);

	BEGIN

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;


	 	VE_parametros_comerciales_PG.VE_tipodocumento_PR(EO_BUSQ_TIPO_DOC.COD_CLIENTE   --in
                                  				  ,EO_BUSQ_TIPO_DOC.IND_AGENTE    --in
                                  				  ,EO_BUSQ_TIPO_DOC.IND_SITUACION --in
                                  				  ,EO_BUSQ_TIPO_DOC.COD_PRODUCTO  --in
                                  				  ,EO_BUSQ_TIPO_DOC.COD_AMICICLO	 --in
                                  				  ,EO_BUSQ_TIPO_DOC.COD_MODULO	 --in
												  ,CURSOR_TIPOS_DOC				--out
							      				  ,SN_cod_retorno
                    		      				  ,SV_mens_retorno
                           	      				  ,SN_num_evento);

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTENER_TIPOS_DOC_PR(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_OBTENER_TIPOS_DOC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_TIPOS_DOC_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--11.-Metodo  :									PV_LISTA_SEGM_CARGOS_PR
PROCEDURE PV_LISTA_SEGM_CARGOS_PR(SO_CargosSegmentacion	  IN OUT NOCOPY    PV_TIPOS_PG.TIP_GA_SEGMENTACION_CARGOS,
								  SC_Cursor	   			     OUT NOCOPY	   refCursor,
								  SN_cod_retorno             OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
							      SV_mens_retorno            OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
							      SN_num_evento              OUT NOCOPY	   ge_errores_pg.evento
	)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_LISTA_SEGM_CARGOS_PR"
	      Lenguaje="PL/SQL"
	      Fecha="18-07-2007"
	      Versión="1.0"
	      Diseñador="Raúl Lozano"
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>SC_cargosSegmentacion</Retorno>>
	      <Descripción>Retorna los valores de cargos por segmentacion</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_CargosSegmentacion" Tipo="estructura">estructura de GA_SEGMENTACION_CARGOS</param>>
	         </Entrada>
	         <Salida>
				<param nom="SC_Cursor" Tipo="cursor">listado con los cargos de segmentacion</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;
		--lista  de Cargos por segmentacion
		LV_sSql := 'OPEN SO_Cursor FOR';
		LV_sSql := LV_sSql || 'A.des_concepto,B.imp_cargo,C.des_moneda, A.cod_concepto, B.cod_moneda,B.tipo_cargo';
		LV_sSql := LV_sSql || 'FROM PV_SEGMENTACION_CARGOS_TD B, GE_MONEDAS C, FA_CONCEPTOS A';
		LV_sSql := LV_sSql || 'WHERE B.COD_SEG_ORIG = '||SO_CargosSegmentacion(1).cod_seg_orig;
		LV_sSql := LV_sSql || 'AND B.COD_SEG_DES ='||SO_CargosSegmentacion(1).cod_seg_des;
		LV_sSql := LV_sSql || 'AND B.TIPO_CARGO='||SO_CargosSegmentacion(1).Tipo_Cargo;
		LV_sSql := LV_sSql || 'AND B.COD_CONCEPTO= A.COD_CONCEPTO ';
		LV_sSql := LV_sSql || 'AND C.COD_MONEDA = B.COD_MONEDA';
		LV_sSql := LV_sSql || 'ORDER BY COD_SEG_ORIG,COD_SEG_DES,TIPO_CARGO';

		OPEN SC_Cursor FOR
		   SELECT A.DES_CONCEPTO,B.IMP_CARGO,C.DES_MONEDA, A.COD_CONCEPTO, B.COD_MONEDA,B.TIPO_CARGO,B.TIPO_SEG_ORIG,B.TIPO_SEG_DES
		   FROM PV_SEGMENTACION_CARGOS_TD B, GE_MONEDAS C, FA_CONCEPTOS A
		   WHERE  B.COD_SEG_ORIG = SO_CargosSegmentacion(1).cod_seg_orig
		  		 AND B.COD_SEG_DES  = SO_CargosSegmentacion(1).cod_seg_des
				 AND B.tipo_seg_orig = SO_CargosSegmentacion(1).tipo_seg_orig
				 AND B.tipo_seg_des= SO_CargosSegmentacion(1).tipo_seg_des
				 AND B.TIPO_CARGO=SO_CargosSegmentacion(1).Tipo_Cargo
				 AND B.COD_CONCEPTO = A.COD_CONCEPTO
				 AND C.COD_MONEDA = B.COD_MONEDA
		         AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,TO_DATE('31-12-3000','DD-MM-YYYY'))
		   ORDER BY COD_SEG_ORIG,COD_SEG_DES,TIPO_CARGO;

	EXCEPTION
		  WHEN OTHERS THEN
		      SN_cod_retorno := -1;
		      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		         SV_mens_retorno := CV_error_no_clasif;
		      END IF;
			  LV_des_error   := ' PV_OBTIENE_CARGOS_SEGM_PR(''); '||SQLERRM;
		      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OBTIENE_CARGOS_SEGM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_LISTA_SEGM_CARGOS_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--12.-Funcion  :									PV_Obtener_CodValor_FN
FUNCTION PV_Obtener_CodValor_FN    (EN_Cod_Cliente    IN          ga_valor_cli.COD_CLIENTE%TYPE,
                                    SN_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento     OUT NOCOPY  ge_errores_pg.evento)
 RETURN ga_valor_cli.cod_valor%TYPE
	AS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_Obtener_CodValorxCodCliente_FN
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador= Raúl Lozano
	      Programador="Raúl Lozano
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene codigo valor del Cliente</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EN_Cod_Cliente" Tipo="NUMBER"></param>>
	         </Entrada>
	         <Salida>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	LN_cod_cliente	   ge_clientes.cod_cliente%TYPE;
	SV_cod_valor       ga_valor_cli.cod_valor%TYPE;

	BEGIN
		SN_cod_retorno 	  := 0;
	    SV_mens_retorno   := NULL;
	    SN_num_evento 	  := 0;

		SELECT  cod_valor
		INTO    SV_cod_valor
		FROM    ga_valor_cli
		WHERE   cod_cliente=EN_cod_cliente
		AND ROWNUM <=1;
		RETURN SV_cod_valor;


EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := -1;
		  SV_cod_valor:=0;	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_Obtener_CodValor_FN('||EN_COD_CLIENTE||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_Obtener_CodValor_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN SV_cod_valor;

END PV_Obtener_CodValor_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--13.-Metodo  :									PV_Obtener_CodValor_PR
PROCEDURE PV_Obtener_CodValor_PR( SN_cod_cliente	IN          ga_valor_cli.cod_cliente%TYPE,
		  						  SN_cod_valor      OUT NOCOPY  ga_valor_cli.cod_valor%TYPE,
								  SN_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
								  SV_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
								  SN_num_evento     OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = " PV_Obtener_CodValor_PR'
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador= Raúl Lozano
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene codigo valor de cliente </Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SN_cod_cliente" Tipo="NUMERICO"></param>>
	         </Entrada>
	         <Salida>
			    <param nom="SN_cod_valor" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	En_Cod_Cliente     ge_clientes.cod_cliente%TYPE;


	BEGIN


	    SV_mens_retorno :=NULL;
	    SN_num_evento 	:= 0;
		EN_Cod_Cliente  := SN_cod_cliente;
		SN_cod_valor    :=0;


    	SN_cod_valor:=PV_Obtener_CodValor_FN (EN_Cod_Cliente,SN_cod_retorno, SV_mens_retorno, SN_num_evento);

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := -1;-- Queda pendiente analalizar codigo de error
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := '  PV_Obtener_CodValor_PR((''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG. PV_Obtener_CodValor_PR(', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_Obtener_CodValor_PR;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--14.-Metodo  :									VE_List_cargos_Ocasionales_PR
 PROCEDURE VE_List_cargos_Ocasionales_PR (EV_cod_producto    IN ga_actuaserv.cod_producto%TYPE,
 		   								  EV_cod_actabo      IN ga_actuaserv.cod_actabo%TYPE,
										  EV_cod_tipserv     IN ga_actuaserv.cod_tipserv%TYPE,
										  EV_cod_concepto    IN ga_actuaserv.cod_concepto%TYPE,
										  EV_cod_planserv    IN ga_tarifas.cod_planserv%TYPE,
					                      SC_cursordatos	 OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "VE_busca_precio_cargo_servocac_PR"
				Lenguaje="PL/SQL"
				Fecha="27-07-2007"
				Version="1.0.0"
				Dise?ador="Raúl Lozano"
				Programador="Raúl Lozano"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los cargos por Servicios Ocasionales
			</Descripcion>
			<Parametros>
			<Entrada>
			    <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por servicios o </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
			LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
		    LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
			LN_NumEvento   NUMBER;
			LV_Sql      ge_errores_pg.vQuery;
			LV_des_error ge_errores_pg.DesEvent;
			LV_codMoneda   VARCHAR2(20);
			LV_codServHab  VARCHAR2(20);
			no_data_found_cursor               EXCEPTION;
		    LN_contador NUMBER;
			CV_modulo_PV   VARCHAR2(25);

			LV_tipdescuento gad_descuentos.tip_descuento%TYPE;
			LV_codmoneda    gad_descuentos.cod_moneda%TYPE;
			LN_valdescuento gad_descuentos.val_descuento%TYPE;
			LN_codconcepto  gad_descuentos.cod_concepto_dscto%TYPE;
			LV_ind_autman   ga_servicios.ind_autman%TYPE;
			LV_des_servicio ga_servicios.des_servicio%TYPE;
			LN_imp_tarifa   ga_tarifas.imp_tarifa%TYPE;
			LV_desmoneda    ge_monedas.des_moneda%TYPE;
			LV_cod_concepto ga_actuaserv.cod_concepto%TYPE;
			LV_cod_moneda   ga_tarifas.cod_moneda%TYPE;


		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
			CV_modulo_PV:='PV';


			LV_Sql:=' SELECT  c.ind_autman, c.des_servicio,b.imp_tarifa, d.des_moneda, a.cod_concepto, b.cod_moneda '||
				    ' FROM  ga_actuaserv a, ga_tarifas b, ga_servicios c,ge_monedas d '||
				    ' WHERE b.cod_producto = a.cod_producto '||
					 ' AND b.cod_actabo = a.cod_actabo '||
					 ' AND b.cod_tipserv = a.cod_tipserv '||
					 ' AND b.cod_servicio = a.cod_servicio '||
					 ' AND sysdate BETWEEN b.fec_desde AND nvl(b.fec_hasta, sysdate) '||
					 ' AND c.cod_producto = a.cod_producto '||
					 ' AND c.cod_servicio = a.cod_servicio '||
					 ' AND d.cod_moneda = b.cod_moneda '||
					 ' AND a.cod_producto= ' ||EV_cod_producto ||
					 ' AND a.cod_actabo= '''||EV_cod_actabo ||''''||
					 ' AND a.cod_tipserv = '''||EV_cod_tipserv ||''''||
	 				 ' AND b.cod_planserv= '''||EV_cod_planserv ||'''';
					 IF  (EV_cod_concepto IS NOT NULL) THEN
					    LV_Sql:= LV_Sql || ' AND  a.cod_concepto = '||EV_cod_concepto;
					 END IF;


			OPEN SC_cursordatos FOR	LV_Sql;



		 EXCEPTION
			 WHEN OTHERS THEN
			 	  SN_cod_retorno:=156;
				  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	                   SV_mens_retorno:=CV_error_no_clasif;
	              END IF;
	              LV_des_error:='OTHERS:PV_CARGOS_PG.VE_List_cargos_Ocasionales_PR('||EV_cod_tipserv||');- ' || SQLERRM;
	              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_PV,SV_mens_retorno, '1.0', USER,
				  'PV_CARGOS_PG.VE_List_cargos_Ocasionales_PR('||EV_cod_tipserv||')', LV_Sql, SQLCODE, LV_des_error );
		END VE_List_cargos_Ocasionales_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--15.-Metodo  :									PV_Obtiene_CodConceptoArt_PR
PROCEDURE PV_Obtiene_CodConceptoArt_PR( SO_ARTICULO 	  IN OUT      PV_TIPOS_PG.TIP_AL_ARTICULOS,
		  						  		SN_cod_retorno    OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
								  		SV_mens_retorno   OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
								  		SN_num_evento     OUT NOCOPY	ge_errores_pg.evento) IS
/*--
<Documentacion TipoDoc = "Procedimiento">
  <Elemento Nombre = "PV_OBTIENE_ARTICULO_PR"
	 Lenguaje="PL/SQL"
		Fecha="31-07-2007"
		Version="1.0.0"
		Dise?ador="Raúl Lozano"
		Programador="Raúl Lozano"
		Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
				Obtiene Articulo en Base a codigo concepto Articulo.
			</Descripcion>
			<Parametros>
			<Entrada>
			    <param nom="SO_ARTICULO" Tipo="TIP_AL_ARTICULOS"> Estructura de la Tabla AL_ARTICULOS</param>
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="SO_ARTICULO> Estructura de la Tabla AL_ARTICULOS</param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
		</Parametros>
	</Elemento>
</Documentacion>
--*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql := 'SELECT cod_articulo, cod_barras, cod_conceptoart, cod_conceptoartalq,'||
			              'cod_conceptodto, cod_conceptodtoalq, cod_fabricante, cod_grpconcepto,'||
   			              'cod_modelo, cod_producto, cod_proveedor, cod_unidad, des_articulo,'||
			              'ind_agru, ind_equiacc, ind_obs, ind_oracle, ind_proc, ind_seriado,'||
			              'mes_afijo, mes_caducidad, mes_fabricante, mes_garantia, ref_fabricante,'||
 			              'tip_articulo, tip_terminal '||
				   'INTO SO_ARTICULO(1).cod_articulo,SO_ARTICULO(1).cod_barras,SO_ARTICULO(1).cod_conceptoart, SO_ARTICULO(1).cod_conceptoartalq,'||
					    'SO_ARTICULO(1).cod_conceptodto, SO_ARTICULO(1).cod_conceptodtoalq, SO_ARTICULO(1).cod_fabricante, SO_ARTICULO(1).cod_grpconcepto,'||
						'SO_ARTICULO(1).cod_modelo, SO_ARTICULO(1).cod_producto, SO_ARTICULO(1).cod_proveedor, SO_ARTICULO(1).cod_unidad, '||
						'SO_ARTICULO(1).des_articulo, SO_ARTICULO(1).ind_agru, SO_ARTICULO(1).ind_equiacc, SO_ARTICULO(1).ind_obs, SO_ARTICULO(1).ind_oracle,'||
						'SO_ARTICULO(1).ind_proc, SO_ARTICULO(1).ind_seriado, SO_ARTICULO(1).mes_afijo, SO_ARTICULO(1).mes_caducidad, SO_ARTICULO(1).mes_fabricante,'||
						'SO_ARTICULO(1).mes_garantia, SO_ARTICULO(1).ref_fabricante, SO_ARTICULO(1).tip_articulo, SO_ARTICULO(1).tip_terminal '||
					'WHERE AL.cod_conceptoart='||SO_ARTICULO(1).cod_conceptoart;

		SELECT cod_articulo, cod_barras, cod_conceptoart, cod_conceptoartalq,
			   cod_conceptodto, cod_conceptodtoalq, cod_fabricante, cod_grpconcepto,
			   cod_modelo, cod_producto, cod_proveedor, cod_unidad, des_articulo,
			   ind_agru, ind_equiacc, ind_obs, ind_oracle, ind_proc, ind_seriado,
			   mes_afijo, mes_caducidad, mes_fabricante, mes_garantia, ref_fabricante,
			   tip_articulo, tip_terminal
		INTO SO_ARTICULO(1).cod_articulo,SO_ARTICULO(1).cod_barras,SO_ARTICULO(1).cod_conceptoart, SO_ARTICULO(1).cod_conceptoartalq,
		     SO_ARTICULO(1).cod_conceptodto, SO_ARTICULO(1).cod_conceptodtoalq, SO_ARTICULO(1).cod_fabricante, SO_ARTICULO(1).cod_grpconcepto,
			 SO_ARTICULO(1).cod_modelo, SO_ARTICULO(1).cod_producto, SO_ARTICULO(1).cod_proveedor, SO_ARTICULO(1).cod_unidad,
			 SO_ARTICULO(1).des_articulo, SO_ARTICULO(1).ind_agru, SO_ARTICULO(1).ind_equiacc, SO_ARTICULO(1).ind_obs, SO_ARTICULO(1).ind_oracle,
			 SO_ARTICULO(1).ind_proc, SO_ARTICULO(1).ind_seriado, SO_ARTICULO(1).mes_afijo, SO_ARTICULO(1).mes_caducidad, SO_ARTICULO(1).mes_fabricante,
			 SO_ARTICULO(1).mes_garantia, SO_ARTICULO(1).ref_fabricante, SO_ARTICULO(1).tip_articulo, SO_ARTICULO(1).tip_terminal

		FROM AL_ARTICULOS AL
		WHERE AL.cod_conceptoart=SO_ARTICULO(1).cod_conceptoart;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 			   SO_ARTICULO(1).cod_conceptoart:=NULL;
		  WHEN OTHERS THEN
		      SN_cod_retorno := -1;
		      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		         SV_mens_retorno := CV_error_no_clasif;
		      END IF;
			  LV_des_error   := ' PV_Obtiene_CodConceptoArt_PR('||to_char(SO_ARTICULO(1).cod_conceptoart)||'); '||SQLERRM;
		      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_Obtiene_CodConceptoArt_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


  END PV_Obtiene_CodConceptoArt_PR;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CargosEstDevlEqup_PR(    EO_GAT_DEVLEQUIP IN OUT NOCOPY PV_GAT_DEVLEQUIP_QT,
		  							  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
									  SN_cod_retorno  OUT NOCOPY    ge_errores_pg.CodError,
              						  SV_mens_retorno OUT NOCOPY    ge_errores_pg.MsgError,
									  SN_num_evento   OUT NOCOPY    ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PV_CargosEstDevlEqup_PR"
	Lenguaje="PL/SQL"
		Fecha="06-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene el concepto estado de devoluacion de: equipo, ya sea este terminal y/o cargador
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="EO_GAT_DEVLEQUIP" Tipo="GAT_DEVLEQUIP_QT" > TYPE definido en esquema</param>
		</Entrada>
		<Salida>
			<param nom="EO_GAT_DEVLEQUIP" Tipo="GAT_DEVLEQUIP_QT" > TYPE definido en esquema</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;


	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';


		LV_sSql:=   ' SELECT  ''A'',a.des_concepto, ''1'', b.imp_dev_equipo, c.des_moneda, a.cod_concepto, b.cod_moneda,b.imp_dev_acces'||
					' FROM gat_est_devlequipos b, ge_monedas c, fa_conceptos a '||
					' WHERE c.cod_moneda = b.cod_moneda '||
					'   and SYSDATE BETWEEN b.fec_desde and NVL(b.fec_hasta, SYSDATE) '||
					'   and a.cod_producto		= '|| EO_GAT_DEVLEQUIP.cod_producto  ||
					'   and a.cod_concepto 		= '|| EO_GAT_DEVLEQUIP.cod_concepto  ||
					'   and b.cod_categoria 	= '''|| EO_GAT_DEVLEQUIP.cod_categoria ||''''||
					'   and b.cod_modpago 	  	= '|| EO_GAT_DEVLEQUIP.cod_modpago   ||
					'   and b.cod_estado_dev	= '''|| EO_GAT_DEVLEQUIP.cod_estado_dev ||''''||
					'   and b.cod_tipcontrato 	= '''|| EO_GAT_DEVLEQUIP.cod_tipcontrato||''''||
					'   and b.num_meses 		= '|| EO_GAT_DEVLEQUIP.num_meses	   ||
					'   and b.cod_antiguedad 	= '''|| EO_GAT_DEVLEQUIP.cod_antiguedad||''''||
					'   and b.cod_operacion 	= '''|| EO_GAT_DEVLEQUIP.cod_operacion ||''''||
					'   and b.ind_causa 		= '|| EO_GAT_DEVLEQUIP.ind_Causa;

		 IF (EO_GAT_DEVLEQUIP.ind_Causa is not null) THEN
			    LV_sSql:= LV_sSql|| ' and b.cod_causa = '''||EO_GAT_DEVLEQUIP.cod_causa||'''';
		 END IF;

		/*EXECUTE IMMEDIATE LV_sSql INTO  EO_GAT_DEVLEQUIP.des_concepto,  EO_GAT_DEVLEQUIP.imp_dev_equipo,
						  		  		EO_GAT_DEVLEQUIP.des_moneda, 	EO_GAT_DEVLEQUIP.cod_concepto,
										EO_GAT_DEVLEQUIP.cod_moneda,    EO_GAT_DEVLEQUIP.imp_dev_acc;*/
		OPEN SC_cursordatos FOR LV_sSql;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;

		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:PV_CARGOS_PG.PV_CargosEstDevlEqup_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,
			 'PV_CARGOS_PG.PV_CargosEstDevlEqup_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CargosEstDevlEqup_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_CargosBajaPenaliz_PR  (  EO_GA_IMPPLZ    IN OUT NOCOPY  PV_GA_IMPPENALIZA_QT,
		  						      SC_cursordatos  OUT NOCOPY 	 REFCURSOR,
									  SN_cod_retorno  OUT NOCOPY     ge_errores_pg.CodError,
              						  SV_mens_retorno OUT NOCOPY     ge_errores_pg.MsgError,
									  SN_num_evento   OUT NOCOPY     ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PROCEDURE PV_CargosBajaPenaliz_PR
	Lenguaje="PL/SQL"
		Fecha="06-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene los cargos por penalización escenario : baja abonado.
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="EO_GA_IMPPLZ"      Tipo="GA_IMPPENALIZA_QT> Type</param>
		</Entrada>
		<Salida>
			<param nom="EO_GA_IMPPLZ"      Tipo="GA_IMPPENALIZA_QT> Type</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;


	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';


		LV_sSql:=   ' SELECT b.cod_concepto,b.des_penaliza,a.imp_penaliza, a.cod_moneda,c.des_moneda,a.sw_penaliza  '||
					' FROM ge_monedas c, ga_penaliza b, ga_imppenaliza a '||
					' WHERE a.cod_producto = b.cod_producto '||
  					' AND a.cod_penaliza = b.cod_penaliza '||
  					' AND a.cod_moneda = c.cod_moneda'||
  					' AND sysdate between a.fec_desde and nvl(a.fec_hasta, sysdate)'||
  					' AND a.cod_producto = '||EO_GA_IMPPLZ.cod_producto||
  					' AND a.cod_penaliza = '||EO_GA_IMPPLZ.cod_penaliza;

		--EXECUTE IMMEDIATE LV_sSql INTO EO_GA_IMPPLZ.des_penaliza,EO_GA_IMPPLZ.imp_penaliza,EO_GA_IMPPLZ.des_moneda,EO_GA_IMPPLZ.cod_concepto,EO_GA_IMPPLZ.cod_moneda,EO_GA_IMPPLZ.sw_penaliza;
		OPEN SC_cursordatos FOR LV_sSql;

	EXCEPTION
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:PV_CARGOS_PG.PV_CargosBajaPenaliz_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,
			 'PV_CARGOS_PG.PV_CargosBajaPenaliz_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CargosBajaPenaliz_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CargosBajaIndemniz_PR (  EO_GA_CARGINDEMZ IN OUT NOCOPY  PV_GA_CARGOSBINDEMNIZ_QT,
		  						   	  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
									  SN_cod_retorno   OUT NOCOPY     ge_errores_pg.CodError,
              						  SV_mens_retorno  OUT NOCOPY     ge_errores_pg.MsgError,
									  SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PROCEDURE PV_CargosBajaPenaliz_PR
	Lenguaje="PL/SQL"
		Fecha="06-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene los cargos por penalización escenario : baja abonado.
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="EO_GA_CARGINDEMZ      Tipo="GA_CARGOSBINDEMNIZ_QT> Type</param>
		</Entrada>
		<Salida>
			<param nom="EO_GA_CARGINDEMZ      Tipo="GA_CARGOSBINDEMNIZ_QT> Type</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;


	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';


		LV_sSql:=   ' SELECT a.cod_concepto,c.des_servicio, e.valor,d.cod_moneda,d.des_moneda, ''A'',''1'' '||
					' FROM   ga_actuaserv a, ga_servicios c, ge_monedas d,ga_cargos_indemnizacion e '||
					' WHERE  c.cod_producto = a.cod_producto '||
					'   AND  c.cod_servicio = a.cod_servicio '||
					'   AND  d.cod_moneda = e.cod_moneda '||
					'   AND  sysdate BETWEEN e.fec_desde AND nvl(e.fec_hasta,sysdate) '||
					'   AND  a.cod_producto = ' ||EO_GA_CARGINDEMZ.cod_producto ||
					'   AND  a.cod_actabo = ''' ||EO_GA_CARGINDEMZ.cod_actabo ||''''||
					'   AND  a.cod_tipserv= ''' ||EO_GA_CARGINDEMZ.cod_tipserv ||''''||
					'   AND  a.cod_servicio =''' ||EO_GA_CARGINDEMZ.cod_servicio ||''''||
					'   AND  e.meses_contrato = '||EO_GA_CARGINDEMZ.meses_contrato ||
					'   AND  e.num_meses = '||EO_GA_CARGINDEMZ.num_meses;

		OPEN SC_cursordatos FOR LV_sSql;/* LV_sSql INTO EO_GA_CARGINDEMZ.des_servicio,   EO_GA_CARGINDEMZ.valor,
						  		  	   EO_GA_CARGINDEMZ.des_moneda,		EO_GA_CARGINDEMZ.cod_concepto,
									   EO_GA_CARGINDEMZ.cod_moneda;*/

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:PV_CARGOS_PG.PV_CargosBajaIndemniz_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_CargosBajaIndemniz_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CargosBajaIndemniz_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneDescPorConcepto_PR( SO_Descuentos IN OUT NOCOPY PV_TIPOS_PG.TIP_GAD_DESCUENTOS,
			  							 SC_cursordatos	 OUT NOCOPY REFCURSOR,
	     			 				 	 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
              							 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)IS
	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PV_ObtieneDescPorConcepto_PR"
	Lenguaje="PL/SQL"
		Fecha="04-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Actualiza Retorna cursor
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="SO_Descuentos   Tipo="SO_Descuentos> Estructura tabla gad_descuentos</param>
		</Entrada>
		<Salida>
			<param nom="SO_cursor"      Tipo="cursor" lista de registros filtrados</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   no_data_found_cursor      EXCEPTION;
	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;
	   LN_contador      NUMBER;

	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		LV_sSql := '  SELECT a.tip_descuento, a.cod_moneda,  NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)'||
				   '  FROM   SISCEL.gad_descuentos a  '||
				   '  WHERE  a.cod_operacion         ='||  SO_Descuentos(1).cod_operacion ||
		    	   '  AND    a.tip_contrato_actual   ='||  SO_Descuentos(1).tip_contrato_actual||
				   '  AND    a.num_meses_actual      ='||  SO_Descuentos(1).num_meses_actual||
				   '  AND    a.cod_antiguedad        ='||  SO_Descuentos(1).cod_antiguedad||
				   '  AND    a.cod_promfact          ='||  SO_Descuentos(1).cod_promfact||
				   '  AND    a.cod_estado_dev        ='||  SO_Descuentos(1).cod_estado_dev||
				   '  AND    a.cod_tipcontrato_nuevo ='||  SO_Descuentos(1).cod_tipcontrato_nuevo||
				   '  AND    a.num_meses_nuevo       ='|| SO_Descuentos(1).num_meses_nuevo||
				   '  AND    a.cod_articulo          ='||  SO_Descuentos(1).cod_articulo||
				   '  AND    '||sysdate|| 'BETWEEN'|| 'a.fec_desde' ||'AND'|| 'nvl(a.fec_hasta, '||sysdate||')'||
				   '  AND    a.clase_descuento       ='|| SO_Descuentos(1).clase_descuento;



	OPEN SC_cursordatos FOR
		SELECT a.tip_descuento, a.cod_moneda,  NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)
		FROM   SISCEL.gad_descuentos a
		WHERE  a.cod_operacion         	   =  SO_Descuentos(1).cod_operacion
		    AND    a.tip_contrato_actual   =  SO_Descuentos(1).tip_contrato_actual
			AND    a.num_meses_actual      =  SO_Descuentos(1).num_meses_actual
			AND    a.cod_antiguedad        =  SO_Descuentos(1).cod_antiguedad
			AND    a.cod_promfact          =  SO_Descuentos(1).cod_promfact
			AND    a.cod_estado_dev        =  SO_Descuentos(1).cod_estado_dev
			AND    a.cod_tipcontrato_nuevo =  SO_Descuentos(1).cod_tipcontrato_nuevo
			AND    a.num_meses_nuevo       =  SO_Descuentos(1).num_meses_nuevo
			AND    a.cod_articulo          =  SO_Descuentos(1).cod_articulo
			AND    sysdate       BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)
			AND    a.clase_descuento       =  SO_Descuentos(1).clase_descuento;

	EXCEPTION
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('PV_CARGOS_PG.PV_ObtieneDescPorConcepto_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'PV_CARGOS_PG.PV_ObtieneDescPorConcepto_PR', LV_sSql, SN_cod_retorno, LV_des_error );

	END PV_ObtieneDescPorConcepto_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneDescPorArticulo_PR( SO_Descuentos IN OUT NOCOPY PV_TIPOS_PG.TIP_GAD_DESCUENTOS,
			  							 SC_cursordatos	 OUT NOCOPY REFCURSOR,
	     			 				 	 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
              							 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
										 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)IS
	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PV_ObtieneDescPorArticulo_PR"
	Lenguaje="PL/SQL"
		Fecha="04-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Actualiza Retorna cursor
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="SO_Descuentos   Tipo="SO_Descuentos> Estructura tabla gad_descuentos</param>
		</Entrada>
		<Salida>
			<param nom="SO_cursor"      Tipo="cursor" lista de registros filtrados</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   no_data_found_cursor      EXCEPTION;
	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;
	   LN_contador      NUMBER;

	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		LV_sSql := '  SELECT a.tip_descuento, a.cod_moneda,  NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)'||
				   '  FROM   SISCEL.gad_descuentos a  '||
				   '  WHERE  a.cod_operacion         ='||  SO_Descuentos(1).cod_operacion ||
		    	   '  AND    a.tip_contrato_actual   ='||  SO_Descuentos(1).tip_contrato_actual||
				   '  AND    a.num_meses_actual      ='||  SO_Descuentos(1).num_meses_actual||
				   '  AND    a.cod_antiguedad        ='||  SO_Descuentos(1).cod_antiguedad||
				   '  AND    a.cod_promfact          ='||  SO_Descuentos(1).cod_promfact||
				   '  AND    a.cod_estado_dev        ='||  SO_Descuentos(1).cod_estado_dev||
				   '  AND    a.cod_tipcontrato_nuevo ='||  SO_Descuentos(1).cod_tipcontrato_nuevo||
				   '  AND    a.num_meses_nuevo       ='|| SO_Descuentos(1).num_meses_nuevo||
				   '  AND    a.cod_articulo          ='||  SO_Descuentos(1).cod_articulo||
				   '  AND    '||sysdate|| 'BETWEEN'|| 'a.fec_desde' ||'AND'|| 'nvl(a.fec_hasta, '||sysdate||')'||
				   '  AND    a.clase_descuento       ='|| SO_Descuentos(1).clase_descuento;



	OPEN SC_cursordatos FOR
		SELECT a.tip_descuento, a.cod_moneda,  NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)
		FROM   SISCEL.gad_descuentos a
		WHERE  a.cod_operacion         	   =  SO_Descuentos(1).cod_operacion
		    AND    a.tip_contrato_actual   =  SO_Descuentos(1).tip_contrato_actual
			AND    a.num_meses_actual      =  SO_Descuentos(1).num_meses_actual
			AND    a.cod_antiguedad        =  SO_Descuentos(1).cod_antiguedad
			AND    a.cod_promfact          =  SO_Descuentos(1).cod_promfact
			AND    a.cod_estado_dev        =  SO_Descuentos(1).cod_estado_dev
			AND    a.cod_tipcontrato_nuevo =  SO_Descuentos(1).cod_tipcontrato_nuevo
			AND    a.num_meses_nuevo       =  SO_Descuentos(1).num_meses_nuevo
			AND    a.cod_articulo          =  SO_Descuentos(1).cod_articulo
			AND    sysdate       BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)
			AND    a.clase_descuento       =  SO_Descuentos(1).clase_descuento;

	EXCEPTION
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('PV_CARGOS_PG.PV_ObtieneDescPorArticulo_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_ObtieneDescPorArticulo_PR', LV_sSql, SN_cod_retorno, LV_des_error );

	END PV_ObtieneDescPorArticulo_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CargosEstDevlEqup_PR(  EO_GAT_DEVLEQUIP IN OUT NOCOPY  PV_GAT_DEVLEQUIP_QT,
									  SN_cod_retorno  OUT NOCOPY    ge_errores_pg.CodError,
              						  SV_mens_retorno OUT NOCOPY    ge_errores_pg.MsgError,
									  SN_num_evento   OUT NOCOPY    ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PV_CargosEstDevlEqup_PR"
	Lenguaje="PL/SQL"
		Fecha="06-08-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene el concepto estado de devoluacion de: equipo, ya sea este terminal y/o cargador
		</Descripcion>
		<Parametros>
		<Entrada>
			<param nom="SO_FaConcept"      Tipo="PV_TIPOS_PG.TIP_FA_CONCEPTOS" > Estructura de la tabla Fa_Conceptos</param>
			<param nom="SO_GeDevlEq"      Tipo="PV_TIPOS_PG.TIP_GAT_EST_DEVLEQUIPOS > Estructura de la tabla GAT_EST_DEVLEQUIPOS</param>
		</Entrada>
		<Salida>
			<param nom="SO_FaConcept"      Tipo="PV_TIPOS_PG.TIP_FA_CONCEPTOS" > Estructura de la tabla Fa_Conceptos</param>
			<param nom="SO_GeDevlEq"      Tipo="PV_TIPOS_PG.TIP_GAT_EST_DEVLEQUIPOS > Estructura de la tabla GAT_EST_DEVLEQUIPOS</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;


	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';


		LV_sSql:=   ' SELECT  a.des_concepto,  b.imp_dev_equipo, c.des_moneda, a.cod_concepto, b.cod_moneda '||
					' FROM gat_est_devlequipos b, ge_monedas c, fa_conceptos a '||
					' WHERE c.cod_moneda = b.cod_moneda'||
					'   and sysdate BETWEEN b.fec_desde and NVL(b.fec_hasta, sysdate)'||
					'   and a.cod_producto		= '|| EO_GAT_DEVLEQUIP.cod_producto  ||
					'   and a.cod_concepto 		= '|| EO_GAT_DEVLEQUIP.cod_concepto  ||
					'   and b.cod_categoria 	= '|| EO_GAT_DEVLEQUIP.cod_categoria ||
					'   and b.cod_modpago 	  	= '|| EO_GAT_DEVLEQUIP.cod_modpago   ||
					'   and b.cod_estado_dev	= '|| EO_GAT_DEVLEQUIP.cod_estado_dev||
					'   and b.cod_tipcontrato 	= '|| EO_GAT_DEVLEQUIP.cod_tipcontrato||
					'   and b.num_meses 		= '|| EO_GAT_DEVLEQUIP.num_meses	   ||
					'   and b.cod_antiguedad 	= '|| EO_GAT_DEVLEQUIP.cod_antiguedad||
					'   and b.cod_operacion 	= '|| EO_GAT_DEVLEQUIP.cod_operacion ||
					'   and b.ind_causa 		= '|| EO_GAT_DEVLEQUIP.ind_Causa;
		 IF (EO_GAT_DEVLEQUIP.ind_Causa is not null) THEN
			    LV_sSql:= LV_sSql|| 'and b.cod_causa = '||EO_GAT_DEVLEQUIP.cod_causa;
		 END IF;

		EXECUTE IMMEDIATE LV_sSql INTO  EO_GAT_DEVLEQUIP.des_concepto,  EO_GAT_DEVLEQUIP.imp_dev_equipo, EO_GAT_DEVLEQUIP.des_moneda, EO_GAT_DEVLEQUIP.cod_concepto, EO_GAT_DEVLEQUIP.cod_moneda;

	EXCEPTION
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.PV_CargosEstDevlEqup_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,
			 'Ve_Servicios_Venta_Pg.PV_CargosEstDevlEqup_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CargosEstDevlEqup_PR;

----------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneParamBajIndemz_PR(EO_GA_PINDEMNIZ_QT IN OUT NOCOPY PV_GA_PARAMBAJAINDEMNIZ_QT,
			  							  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
								          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
	) IS

	/*--
	<Documentación TipoDoc = "Procedimiento">
		Elemento Nombre = "VE_ObtieneParamBajIndemz_PR
		Lenguaje="PL/SQL"
		Fecha="01-03-2007"
		Versión="1.0.0"
		Diseñador="Raúl Lozano"
		Programador="Raúl Lozano"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripción>
				  Obtiene datos de referencia ; fecha_alta, codigo de tipo contrato, mediante el codigo del producto y numero de abonado
	</Descripción>
	<Parámetros>
	<Entrada>
		<param nom="EO_GA_PINDEMNIZ_QT" Tipo="PV_GA_PARAMBAJAINDEMNIZ_QT"> EO_GA_PINDEMNIZ_QT</param>
	</Entrada>
	<Salida>
		<param nom="EO_GA_PINDEMNIZ_QT"  Tipo="PV_GA_PARAMBAJAINDEMNIZ_QT">  EO_GA_PINDEMNIZ_QT</param>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	--*/
		LV_des_error ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
	BEGIN
		SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

		LV_sql:=   ' SELECT a.fec_alta, a.fec_prorroga, a.cod_tipcontrato, b.num_meses,a.num_abonado '||
					' FROM   ga_percontrato b, ga_abocel a '||
					' WHERE  a.cod_tipcontrato = b.cod_tipcontrato '||
					'   AND  b.cod_producto = '|| EO_GA_PINDEMNIZ_QT.cod_producto ||
					'   AND  a.num_abonado  = '|| EO_GA_PINDEMNIZ_QT.num_abonado;


		OPEN SC_cursordatos FOR LV_sql ;


	EXCEPTION
		WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='PV_cargos_PG.PV_ObtieneParamBajIndemz_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,'PV_cargos_PG.PV_ObtieneParamBajIndemz_PR', LV_Sql, SQLCODE, LV_des_error );
	END PV_ObtieneParamBajIndemz_PR;

	----------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_ObtieneCodConcepto_PR(SN_COD_CONCEPTO 		IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
			  							  SV_CONCEPTO_DESC  OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE,
								          SN_cod_retorno  	OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno 	OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   	OUT NOCOPY ge_errores_pg.Evento
	) IS

	/*--
	<Documentación TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ObtieneCodConcepto_PR
		Lenguaje="PL/SQL"
		Fecha="21-09-2007"
		Versión="1.0.0"
		Diseñador="Daniel Sagredo"
		Programador="Daniel Sagredo"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripción>
				  Obtiene datos codigo de concepto de cargo ;
	</Descripción>
	<Parámetros>
	<Entrada>
		<param nom="COD_CONCEPTO Tipo="GA_TRANSACABO.NUM_TRANSACCION"> SN_COD_CONCEPTO/param>
	</Entrada>
	<Salida>
		<param nom="SN_COD_CONCEPTO  Tipo="PV_GA_PARAMBAJAINDEMNIZ_QT">  EO_GA_PINDEMNIZ_QT</param>
		<param nom="SV_CONCEPTO_DESC  Tipo="NUMBER"> Codigo Concepto</param>
		<param nom="SN_cod_retorno Tipo="STRING">  Codigo de error</param>
		<param nom="SV_mens_retorno   Tipo="NUMBER"> glosa mensaje error </param>
		<param nom="SN_num_evento   Tipo="NUMBER"> numero de evento</param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	--*/
		ERROR_INSERT EXCEPTION;
		LV_des_error ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
	BEGIN
		SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

		LV_sql:=    ' SELECT DES_CADENA, COD_RETORNO'||
					' FROM GA_TRANSACABO'||
				   	' WHERE NUM_TRANSACCION = '|| SN_COD_CONCEPTO;

		SELECT DES_CADENA, COD_RETORNO
		INTO SV_CONCEPTO_DESC, SN_cod_retorno
		FROM GA_TRANSACABO
		WHERE NUM_TRANSACCION = SN_COD_CONCEPTO;

		IF SN_cod_retorno <> 0 THEN
		   RAISE ERROR_INSERT;
		END IF;


	EXCEPTION
		WHEN ERROR_INSERT THEN
			 SN_cod_retorno := 4;
		WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='PV_cargos_PG.PV_ObtieneCodConcepto_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,'PV_cargos_PG.PV_ObtieneCodConcepto_PR', LV_Sql, SQLCODE, LV_des_error );
	END PV_ObtieneCodConcepto_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_EliminaCodConcepto_PR(SN_COD_CONCEPTO 		IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
								          SN_cod_retorno  	OUT NOCOPY ge_errores_pg.CodError,
								          SV_mens_retorno 	OUT NOCOPY ge_errores_pg.MsgError,
								          SN_num_evento   	OUT NOCOPY ge_errores_pg.Evento
	) IS

	/*--
	<Documentación TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ObtieneCodConcepto_PR
		Lenguaje="PL/SQL"
		Fecha="21-09-2007"
		Versión="1.0.0"
		Diseñador="Daniel Sagredo"
		Programador="Daniel Sagredo"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripción>
				  Obtiene datos codigo de concepto de cargo ;
	</Descripción>
	<Parámetros>
	<Entrada>
		<param nom="COD_CONCEPTO Tipo="GA_TRANSACABO.NUM_TRANSACCION"> SN_COD_CONCEPTO/param>
	</Entrada>
	<Salida>
		<param nom="SN_COD_CONCEPTO  Tipo="PV_GA_PARAMBAJAINDEMNIZ_QT">  EO_GA_PINDEMNIZ_QT</param>
		<param nom="SV_CONCEPTO_DESC  Tipo="NUMBER"> Codigo Concepto</param>
		<param nom="SN_cod_retorno Tipo="STRING">  Codigo de error</param>
		<param nom="SV_mens_retorno   Tipo="NUMBER"> glosa mensaje error </param>
		<param nom="SN_num_evento   Tipo="NUMBER"> numero de evento</param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	--*/
		LV_des_error ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
	BEGIN
		SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

		LV_sql:=    ' DELETE '||
					' FROM GA_TRANSACABO'||
				   	' WHERE NUM_TRANSACCION = '|| SN_COD_CONCEPTO;

		DELETE
		FROM GA_TRANSACABO
		WHERE NUM_TRANSACCION = SN_COD_CONCEPTO;

	EXCEPTION
		WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='PV_cargos_PG.PV_EliminaCodConcepto_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,'PV_cargos_PG.PV_EliminaCodConcepto_PR', LV_Sql, SQLCODE, LV_des_error );
	END PV_EliminaCodConcepto_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION PV_ConsultarEstadoFact_FN (EN_num_proceso	IN 		   FA_INTERFACT.num_proceso%TYPE,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
									  SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
	RETURN  VARCHAR2
	 IS

	/*--
	<Documentación TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ConsultarEstadoFact_FN"
		Lenguaje="PL/SQL"
		Fecha="01-03-2007"
		Versión="1.0.0"
		Diseñador="
		Programador="Elizabeth Vera"
		Ambiente="BD"
	<Retorno>true/false</Retorno>
	<Descripción>
			Verifica si esta lista la factura
	</Descripción>
	<Parámetros>
	<Entrada>
		<param nom="EN_num_proceso" Tipo="NUMBER"> numero de proceso/param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	--*/
		LV_des_error ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
		LN_contador      NUMBER;
		LV_resultado     VARCHAR2(5);
	BEGIN
		SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;
		LV_resultado := 'FALSE';

		LV_sql:= ' 	 		 SELECT COUNT(1) ';
		LV_sql:= LV_sql || ' 		INTO ' || LN_contador;
		LV_sql:= LV_sql || ' FROM   FA_INTERFACT ';
		LV_sql:= LV_sql || ' WHERE  NUM_PROCESO = ' || EN_num_proceso;
		LV_sql:= LV_sql || ' AND    COD_ESTADOC = ' || CN_cod_estado_doc;
		LV_sql:= LV_sql || ' AND    COD_ESTPROC = ' || CN_cod_proc;


		SELECT COUNT(1)
		INTO LN_contador
		FROM   FA_INTERFACT
		WHERE  NUM_PROCESO = EN_num_proceso
		AND    COD_ESTADOC = CN_cod_estado_doc
		AND    COD_ESTPROC = CN_cod_proc;


		IF (LN_contador >0) THEN
		   LV_resultado := 'TRUE';
		END IF;

		RETURN LV_resultado;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		  RETURN LV_resultado;
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_ConsultarEstadoFact_FN('||EN_num_proceso||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS.PV_ConsultarEstadoFact_FN', LV_sql, SN_cod_retorno, LV_des_error );

		  RETURN LV_resultado;

	END PV_ConsultarEstadoFact_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE PV_ObtenerDetallePresup_PR(EN_num_proceso	IN 		   FA_INTERFACT.num_proceso%TYPE,
			  						  SC_cursordatos   OUT NOCOPY REFCURSOR,
									  SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
									  SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
									  SN_num_evento    OUT NOCOPY  ge_errores_pg.evento)
  IS

	/*--
	<Documentación TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ObtenerDetallePresup_PR
		Lenguaje="PL/SQL"
		Fecha="25-09-2007"
		Versión="1.0.0"
		Diseñador=""
		Programador="Elizabeth Vera"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripción>
				  Obtiene detalle de presupuesto
	</Descripción>
	<Parámetros>
	<Entrada>
		<param nom="EN_num_proceso" Tipo="NUMBER"> numero de proceso/param>
	</Entrada>
	<Salida>
		<param nom="SO_cursor"       Tipo="cursor" detalle de presupuesto </param>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	--*/
		LV_des_error ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
	BEGIN
		SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

		OPEN SC_cursordatos FOR
				SELECT des_concepto_rep, num_unidades, imp_base, imp_impuesto, imp_dto, imp_total
				 FROM ga_presupuesto where num_proceso = EN_num_proceso;


	EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_ObtenerDetallePresup_PR('||EN_num_proceso||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CARGOS.PV_ObtenerDetallePresup_PR', LV_sql, SN_cod_retorno, LV_des_error );


    END PV_ObtenerDetallePresup_PR ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CargosAbonadoCero_PR (   EV_cod_concepto   IN            fa_conceptos.COD_CONCEPTO%type,
		  						  	  EN_cod_producto   IN            fa_conceptos.COD_PRODUCTO%type,
		  						   	  SC_cursordatos   OUT NOCOPY 	  REFCURSOR,
									  SN_cod_retorno   OUT NOCOPY     ge_errores_pg.CodError,
              						  SV_mens_retorno  OUT NOCOPY     ge_errores_pg.MsgError,
									  SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PROCEDURE PV_CargosAbonadoCero_PR
	Lenguaje="PL/SQL"
		Fecha="27-11-2007"
			Version="1.0.0"
			Diseñador="Raúl Lozano"
			Programador="Raúl Lozano"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene los cargos configurados para el caso "Abonado CERO"
		</Descripcion>
		<Parametros>
		<Entrada>
				 EV_cod_concepto   obtenido de la gedparametros
		  		 EN_cod_producto
		</Entrada>
		<Salida>
			<param nom="SC_cursordatos      Tipo="Cursor> Type</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;


	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';


		LV_sSql:=   ' SELECT a.cod_concepto,a.des_concepto,b.cod_moneda,b.des_moneda, ''A'',''1'''||
					' FROM   fa_conceptos a, ge_monedas b'||
					' WHERE  a.cod_concepto = ' ||EV_cod_concepto ||
					'   AND  a.cod_producto = ' ||EN_cod_producto ||
					'   AND  a.cod_moneda = b.cod_moneda';

		OPEN SC_cursordatos FOR LV_sSql;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:PV_CARGOS_PG.PV_CargosAbonadoCero_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_CargosAbonadoCero_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CargosAbonadoCero_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_REC_PREC_EQUIPO_NUEVO_PR (   EN_NUM_ABONADO   IN            GA_ABOCEL.NUM_ABONADO%TYPE,
		  						  	      EV_COD_PLANTARIF IN            GA_ABOCEL.COD_PLANTARIF%TYPE,
		  						   	      EN_COD_ARTICULO  IN            AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_IND_COMODATO  IN            GA_ABOCEL.IND_EQPRESTADO%TYPE,
                                          EN_COD_PRODUCTO  IN            GA_CARGOS_HABILITACION.COD_PRODUCTO%TYPE,
                                          EN_COD_MODVENTA  IN            AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_COD_USO       IN            AL_PRECIOS_VENTA.COD_USO%TYPE,
                                          EN_TIP_STOCK     IN            AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ESTADO    IN            AL_PRECIOS_VENTA.COD_ESTADO%TYPE, 
                                          EN_NUM_MESES     IN            AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EN_IND_RECAMBIO  IN            GA_CARGOS_HABILITACION.IND_VENTA%TYPE,
                                          SN_PRECIO        OUT NOCOPY 	 AL_PRECIOS_VENTA.PRC_VENTA%TYPE,
									      SN_cod_retorno   OUT NOCOPY    ge_errores_pg.CodError,
              						      SV_mens_retorno  OUT NOCOPY    ge_errores_pg.MsgError,
									      SN_num_evento    OUT NOCOPY    ge_errores_pg.Evento)
IS

	/*--
  <Documentacion TipoDoc = "Procedimiento">
	Elemento Nombre = "PROCEDURE PV_REC_PREC_EQUIPO_NUEVO_PR
	Lenguaje="PL/SQL"
		Fecha="13-04-2011"
			Version="1.0.0"
			Diseñador="EVERIS"
			Programador="EVERIS"
			Ambiente="BD"
		<Retorno>NA</Retorno>
		<Descripcion>
			Obtiene el cargo o precio nuevo asociado a un articulo para restitucion de equipo
		</Descripcion>
		<Parametros>
		<Entrada>
                 EN_NUM_ABONADO   
                 EV_COD_PLANTARIF 
                 EN_COD_ARTICULO  
                 EV_IND_COMODATO  
                 EN_COD_PRODUCTO  
                 EN_COD_MODVENTA  
                 EN_COD_USO       
                 EN_TIP_STOCK     
                 EN_COD_STOCK     
                 EN_COD_ESTADO     
                 EN_NUM_MESES     
                 EN_IND_RECAMBIO  
		</Entrada>
		<Salida>
			<param nom="SN_PRECIO"     Tipo="NUMBER"> Type</param>
			<param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
			<param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
			<param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
		</Salida>
		</Parametros>
		</Elemento>
		</Documentacion>
		--*/

	   LV_des_error         ge_errores_pg.DesEvent;
	   LV_sSql              ge_errores_pg.vQuery;
       LV_IND_VTA           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
       LV_COD_CONCEPTO      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
       LV_COD_MONEDA        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
       LV_FLAG_PRECIO_LISTA GED_PARAMETROS.VAL_PARAMETRO%TYPE;
       LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
       ERROR_SIN_PRECIO     EXCEPTION;

	BEGIN

		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';
        
        LV_sSql:=   ' SELECT VAL_PARAMETRO '||
                    ' INTO LV_IND_VTA '|| 
                    ' FROM GED_PARAMETROS '|| 
                    ' WHERE NOM_PARAMETRO = ''IND_VTA_HABIL_CE''';
        
        SELECT VAL_PARAMETRO
        INTO LV_IND_VTA 
        FROM GED_PARAMETROS 
        WHERE NOM_PARAMETRO = 'IND_VTA_HABIL_CE';
        
        LV_sSql := ' SELECT COD_CATEGORIA FROM VE_CATPLANTARIF ' ||
                  ' WHERE COD_PRODUCTO = ' || EN_COD_PRODUCTO ||
                  ' AND COD_PLANTARIF = ' || EV_COD_PLANTARIF;
        
        SELECT COD_CATEGORIA
        INTO  LV_COD_CATEGORIA
        FROM VE_CATPLANTARIF
        WHERE COD_PRODUCTO = EN_COD_PRODUCTO
        AND COD_PLANTARIF = EV_COD_PLANTARIF;
        
        LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                   ' WHERE NOM_PARAMETRO = ''CONCEPTO_CAR_HABIL''';
                  
        SELECT VAL_PARAMETRO
        INTO LV_COD_CONCEPTO   
        FROM GED_PARAMETROS 
        WHERE NOM_PARAMETRO = 'CONCEPTO_CAR_HABIL';
                       
        LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                   ' WHERE NOM_PARAMETRO = ''COD_MONEDA_PESO''';
                  
        SELECT VAL_PARAMETRO
        INTO LV_COD_MONEDA   
        FROM GED_PARAMETROS 
        WHERE NOM_PARAMETRO = 'COD_MONEDA_PESO';
              
    
        IF EV_IND_COMODATO = '1' THEN
        
        
            IF EN_IND_RECAMBIO = 0 THEN
            
                LV_IND_VTA := '1';
                
            END IF;
            
            
            LV_sSql := ' SELECT B.PRC_CARGO ' ||
                       ' FROM FA_CONCEPTOS A, GA_CARGOS_HABILITACION B, GE_MONEDAS D ' || 
                       ' WHERE ' ||
                       ' A.Cod_Concepto = ' || LV_COD_CONCEPTO ||
                       ' AND B.COD_PRODUCTO = ' || EN_COD_PRODUCTO ||
                       ' AND B.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                       ' AND B.COD_USO = ' || EN_COD_USO ||
                       ' AND B.TIP_STOCK = ' || EN_TIP_STOCK ||
                       ' AND B.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                       ' AND B.IND_VENTA = ' || LV_IND_VTA ||
                       ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE) ' ||
                       ' AND B.COD_CATEGORIA in (SELECT cod_categoria FROM VE_CATPLANTARIF ' ||
                       ' WHERE cod_producto = ' || LV_COD_CONCEPTO ||
                       ' AND cod_plantarif = ' || EV_COD_PLANTARIF || ') ' ||
                       ' AND D.COD_MONEDA = ' || LV_COD_MONEDA ||
                       ' AND ROWNUM <=1 ';
            
            BEGIN
            
                SELECT B.PRC_CARGO 
                INTO SN_PRECIO
                FROM FA_CONCEPTOS A, GA_CARGOS_HABILITACION B, GE_MONEDAS D  
                WHERE 
                     A.Cod_Concepto = LV_COD_CONCEPTO
                     AND B.COD_PRODUCTO = EN_COD_PRODUCTO
                     AND B.COD_MODVENTA = EN_COD_MODVENTA
                     AND B.COD_USO = EN_COD_USO
                     AND B.TIP_STOCK = EN_TIP_STOCK
                     AND B.COD_ARTICULO = EN_COD_ARTICULO
                     AND B.IND_VENTA = LV_IND_VTA
                     AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
                     AND B.COD_CATEGORIA in (SELECT cod_categoria FROM VE_CATPLANTARIF 
                                             WHERE cod_producto = LV_COD_CONCEPTO
                                             AND cod_plantarif = EV_COD_PLANTARIF)
                     AND D.COD_MONEDA = LV_COD_MONEDA
                     AND ROWNUM <=1;
                    
        
            EXCEPTION
            
                WHEN NO_DATA_FOUND THEN
                
                SV_mens_retorno := SV_mens_retorno || 'No existe Tarifa Equipo Nuevo Cargo de Habilitacion...';
                SV_mens_retorno := SV_mens_retorno || '|Cod Concepto......... : ' || LV_COD_CONCEPTO;
                SV_mens_retorno := SV_mens_retorno || '|Producto............. : ' || EN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || '|Mod. Venta........... : ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || '|Cod. Uso............. : ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || '|Tipo Stock........... : ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || '|Articulo............. : ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || '|Plan Tarifario....... : ' || EV_COD_PLANTARIF;
                SV_mens_retorno := SV_mens_retorno || '|Cod. Categoria....... : ' || LV_COD_CATEGORIA; 
                SV_mens_retorno := SV_mens_retorno || '|Indicador de Venta... : ' || LV_IND_VTA;
                SV_mens_retorno := SV_mens_retorno || '|Meses................ : ' || EN_NUM_MESES;
                SV_mens_retorno := SV_mens_retorno || '|FAVOR CONFIRMAR OPERACIÓN A REALIZAR';
                SV_mens_retorno := SV_mens_retorno || '|CON POLÍTICA DE RECAMBIO ACTUAL.';                        
                
                RAISE ERROR_SIN_PRECIO;
                    
            END;
        ELSE
            
            LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                       ' WHERE NOM_PARAMETRO = ''PRECIO_LISTA_EQUIPO''';
                  
            SELECT VAL_PARAMETRO
            INTO LV_FLAG_PRECIO_LISTA 
            FROM GED_PARAMETROS 
            WHERE NOM_PARAMETRO = 'PRECIO_LISTA_EQUIPO';    
            
            
            IF LV_FLAG_PRECIO_LISTA = 'TRUE' THEN
            
                LV_sSql := ' SELECT A.PRC_VENTA ' ||
                           ' FROM   AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                           ' WHERE  A.TIP_STOCK      = ' || EN_TIP_STOCK ||
                           ' AND    A.COD_ARTICULO   = ' || EN_COD_ARTICULO ||
                           ' AND    A.COD_USO        = ' || EN_COD_USO ||
                           ' AND    A.COD_ESTADO     = ' || EN_COD_ESTADO ||
                           ' AND    SYSDATE    BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                           ' AND    B.COD_ARTICULO   = A.COD_ARTICULO ' ||
                           ' AND    C.COD_MONEDA     = A.COD_MONEDA ' ||
                           ' AND    A.IND_RECAMBIO   = 9 ' ||
                           ' AND ROWNUM <=1 ';
            
                BEGIN
                
                    SELECT A.PRC_VENTA
                    INTO SN_PRECIO 
                    FROM   AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C 
                    WHERE  A.TIP_STOCK = EN_TIP_STOCK
                           AND    A.COD_ARTICULO   = EN_COD_ARTICULO
                           AND    A.COD_USO        = EN_COD_USO
                           AND    A.COD_ESTADO     = EN_COD_ESTADO
                           AND    SYSDATE    BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) 
                           AND    B.COD_ARTICULO   = A.COD_ARTICULO
                           AND    C.COD_MONEDA     = A.COD_MONEDA
                           AND    A.IND_RECAMBIO   = 9 
                           AND ROWNUM <=1;
                           
                EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                
                    SV_mens_retorno := SV_mens_retorno || ' No existe Tarifa Equipo Nuevo a Precio Lista... ';
                    SV_mens_retorno := SV_mens_retorno || '|Num Abonado.......... : ' || EN_NUM_ABONADO;
                    SV_mens_retorno := SV_mens_retorno || '|Tipo Stock........... : ' || EN_TIP_STOCK;
                    SV_mens_retorno := SV_mens_retorno || '|Articulo............. : ' || EN_COD_ARTICULO;
                    SV_mens_retorno := SV_mens_retorno || '|Cod. Uso............. : ' || EN_COD_USO;
                    SV_mens_retorno := SV_mens_retorno || '|Estado............... : ' || EN_COD_ESTADO;                        
                    
                    RAISE ERROR_SIN_PRECIO;
                
                END;
            ELSE
            
                LV_sSql := ' SELECT A.PRC_VENTA ' ||
                           ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                           ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                           ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                           ' AND A.COD_USO = ' || EN_COD_USO ||
                           ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                           ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                           ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                           ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                           ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                           ' AND A.IND_RECAMBIO = 1 ' ||  
                           ' AND A.NUM_MESES = ' || EN_NUM_MESES ||
                           ' AND A.COD_CATEGORIA = ' || LV_COD_CATEGORIA ||
                           ' AND A.COD_USO <> 3 ' || 
                           ' AND B.IND_EQUIACC = ''E''' ||
                           ' AND ROWNUM <=1 ';
            
                BEGIN
                
                    SELECT A.PRC_VENTA
                    INTO SN_PRECIO
                    FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C 
                    WHERE A.TIP_STOCK = EN_TIP_STOCK
                          AND A.COD_ARTICULO = EN_COD_ARTICULO
                          AND A.COD_USO = EN_COD_USO
                          AND A.COD_ESTADO = EN_COD_ESTADO
                          AND A.COD_MODVENTA = EN_COD_MODVENTA
                          AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
                          AND B.COD_ARTICULO = A.COD_ARTICULO
                          AND C.COD_MONEDA = A.COD_MONEDA
                          AND A.IND_RECAMBIO = 1
                          AND A.NUM_MESES = EN_NUM_MESES
                          AND A.COD_CATEGORIA = LV_COD_CATEGORIA
                          AND A.COD_USO <> 3 
                          AND B.IND_EQUIACC = 'E'
                          AND ROWNUM <=1;
                          
                EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                
                    SV_mens_retorno := SV_mens_retorno || ' No existe Tarifa Equipo Nuevo a Precio Lista... ';
                    SV_mens_retorno := SV_mens_retorno || '|Num Abonado.......... : ' || EN_NUM_ABONADO;
                    SV_mens_retorno := SV_mens_retorno || '|Tipo Stock........... : ' || EN_TIP_STOCK;
                    SV_mens_retorno := SV_mens_retorno || '|Articulo............. : ' || EN_COD_ARTICULO;
                    SV_mens_retorno := SV_mens_retorno || '|Cod. Uso............. : ' || EN_COD_USO;
                    SV_mens_retorno := SV_mens_retorno || '|Estado............... : ' || EN_COD_ESTADO;
                    SV_mens_retorno := SV_mens_retorno || '|Mod. Venta........... : ' || EN_COD_MODVENTA;
                    SV_mens_retorno := SV_mens_retorno || '|Meses................ : ' || EN_NUM_MESES;
                    SV_mens_retorno := SV_mens_retorno || '|Cod. Categoria....... : ' || LV_COD_CATEGORIA;
                    SV_mens_retorno := SV_mens_retorno || '|FAVOR CONFIRMAR OPERACIÓN A REALIZAR';
                    SV_mens_retorno := SV_mens_retorno || '|CON POLÍTICA DE RECAMBIO ACTUAL.';
                                                                                    
                    RAISE ERROR_SIN_PRECIO;
                
                END;        
                          
            END IF;
            
        
        END IF;


	EXCEPTION
        WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_REC_PREC_EQUIPO_NUEVO_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_REC_PREC_EQUIPO_NUEVO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                    
		WHEN OTHERS THEN
			 SN_cod_retorno:=-1;
			 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := SUBSTR('OTHERS:PV_CARGOS_PG.PV_REC_PREC_EQUIPO_NUEVO_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_REC_PREC_EQUIPO_NUEVO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
             
	END PV_REC_PREC_EQUIPO_NUEVO_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Habilitacion_PR (EV_IND_COMODATO    IN GA_ABOCEL.IND_EQPRESTADO%TYPE,
                                          EN_COD_PRODUCTO    IN GA_ACTUASERV.COD_PRODUCTO%TYPE,
 		   								  EN_COD_MODVENTA    IN GA_CARGOS_HABILITACION.COD_MODVENTA%TYPE,
										  EN_TIP_STOCK       IN GA_CARGOS_HABILITACION.TIP_STOCK%TYPE,
										  EN_COD_ARTICULO    IN GA_CARGOS_HABILITACION.COD_ARTICULO%TYPE,
										  EN_COD_USO         IN GA_CARGOS_HABILITACION.COD_USO%TYPE,
                                          EN_NUM_MESES       IN GA_CARGOS_HABILITACION.NUM_MESES%TYPE,
                                          EV_COD_PLANTARIF   IN VE_CATPLANTARIF.COD_PLANTARIF%TYPE,
                                          EV_COD_ANTIGUEDAD  IN GA_CARGOS_HABILITACION.COD_ANTIGUEDAD%TYPE,
					                      SC_cursordatos	 OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_List_cargos_Habilitacion_PR"
				Lenguaje="PL/SQL"
				Fecha="13-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los cargos por Habilitacion
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EV_IND_COMODATO" Tipo="VARCHAR2">Indicador de si es comodato o no</param>
                  <param nom="EV_cod_producto" Tipo="VARCHAR2"> codigo producto</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"></param>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_USO" Tipo="NUMERIC"></param>
                  <param nom="EN_NUM_MESES" Tipo="NUMERIC"></param>
                  <param nom="EV_COD_PLANTARIF" Tipo="VARCHAR2"></param>
                  <param nom="EV_COD_ANTIGUEDAD" Tipo="VARCHAR2"></param>
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por Habilitacion </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LV_IND_VTA           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LV_COD_CONCEPTO      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_COD_MONEDA        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_CANT_CARGOS       NUMBER;
        ERROR_SIN_PRECIO     EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
			 

            LV_sSql:=   ' SELECT VAL_PARAMETRO '||
                        ' INTO LV_IND_VTA '||
                        ' FROM GED_PARAMETROS '||
                        ' WHERE NOM_PARAMETRO = ''IND_VTA_HABIL_CE''';

            SELECT VAL_PARAMETRO
            INTO LV_IND_VTA
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'IND_VTA_HABIL_CE';

            LV_sSql := ' SELECT COD_CATEGORIA FROM VE_CATPLANTARIF ' ||
                       ' WHERE COD_PRODUCTO = ' || EN_COD_PRODUCTO ||
                       ' AND COD_PLANTARIF = ' || EV_COD_PLANTARIF;
        
            SELECT COD_CATEGORIA
            INTO  LV_COD_CATEGORIA
            FROM VE_CATPLANTARIF
            WHERE COD_PRODUCTO = EN_COD_PRODUCTO
            AND COD_PLANTARIF = EV_COD_PLANTARIF;

            LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                   ' WHERE NOM_PARAMETRO = ''CONCEPTO_CAR_HABIL''';

            SELECT VAL_PARAMETRO
            INTO LV_COD_CONCEPTO
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'CONCEPTO_CAR_HABIL';

            LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                       ' WHERE NOM_PARAMETRO = ''COD_MONEDA_PESO''';

            SELECT VAL_PARAMETRO
            INTO LV_COD_MONEDA
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'COD_MONEDA_PESO';

            LV_sSql := ' SELECT COUNT(B.PRC_CARGO) ' ||
                      ' FROM FA_CONCEPTOS A, GA_CARGOS_HABILITACION B, GE_MONEDAS D ' ||
                      ' WHERE ' ||
                      ' A.Cod_Concepto = ' || LV_COD_CONCEPTO ||
                      ' AND B.COD_PRODUCTO = ' || EN_COD_PRODUCTO ||
                      ' AND B.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                      ' AND B.TIP_STOCK = ' || EN_TIP_STOCK ||
                      ' AND B.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                      ' AND B.COD_USO = ' || EN_COD_USO ||
                      ' AND B.NUM_MESES = ' || EN_NUM_MESES ||
                      ' AND B.COD_CATEGORIA in (SELECT cod_categoria FROM VE_CATPLANTARIF ' ||
                      ' WHERE cod_producto = ' || EN_COD_PRODUCTO ||
                      ' AND cod_plantarif = ' || EV_COD_PLANTARIF || ' ) ';
                       
                       IF LV_IND_VTA <> '1' THEN
                           LV_sSql :=  LV_sSql || ' AND B.COD_ANTIGUEDAD = ' || EV_COD_ANTIGUEDAD;
                       END IF;
                       
                       IF EV_IND_COMODATO = '1' Then
                           LV_sSql :=  LV_sSql || ' AND B.IND_VENTA = ' || LV_IND_VTA;
                       END IF;
                       
            LV_sSql :=  LV_sSql || ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE) ' ||
                                 ' AND D.COD_MONEDA = ' || LV_COD_MONEDA;
                                 
            EXECUTE IMMEDIATE LV_sSql INTO LN_CANT_CARGOS;
            
            IF LN_CANT_CARGOS = 0 THEN
            
                SV_mens_retorno := SV_mens_retorno || 'No Existen Tarifas para Cargos de Habilitacion.';
                SV_mens_retorno := SV_mens_retorno || '|Producto............. : ' || EN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || '|Mod. Venta........... : ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || '|Tipo Stock........... : ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || '|Articulo............. : ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || '|Cod. Uso............. : ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || '|Meses................ : ' || EN_NUM_MESES;
                SV_mens_retorno := SV_mens_retorno || '|Categoria............ : ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || '|Plan Tarifario....... : ' || EV_COD_PLANTARIF;
                SV_mens_retorno := SV_mens_retorno || '|Cod. Antiguedad...... : ' || EV_COD_ANTIGUEDAD;
                SV_mens_retorno := SV_mens_retorno || '|Indicador de Venta... : ' || LV_IND_VTA;
                SV_mens_retorno := SV_mens_retorno || '|FAVOR CONFIRMAR OPERACIÓN A REALIZAR';
                SV_mens_retorno := SV_mens_retorno || '|CON POLÍTICA DE RECAMBIO ACTUAL.';
                                                                                    
                RAISE ERROR_SIN_PRECIO;
                    
            END IF;                                 

            LV_sSql := ' SELECT ''A'', A.DES_CONCEPTO, ''1'', B.PRC_CARGO, D.DES_MONEDA, A.COD_CONCEPTO, ' ||
                      ' D.COD_MONEDA, B.VAL_MINIMO, B.VAL_MAXIMO ' ||       
                      ' FROM FA_CONCEPTOS A, GA_CARGOS_HABILITACION B, GE_MONEDAS D ' ||
                      ' WHERE ' ||
                      ' A.Cod_Concepto = ' || LV_COD_CONCEPTO ||
                      ' AND B.COD_PRODUCTO = ' || EN_COD_PRODUCTO ||
                      ' AND B.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                      ' AND B.TIP_STOCK = ' || EN_TIP_STOCK ||
                      ' AND B.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                      ' AND B.COD_USO = ' || EN_COD_USO ||
                      ' AND B.NUM_MESES = ' || EN_NUM_MESES ||
                      ' AND B.COD_CATEGORIA in (SELECT cod_categoria FROM VE_CATPLANTARIF ' ||
                      ' WHERE cod_producto = ' || EN_COD_PRODUCTO ||
                      ' AND cod_plantarif = ' || EV_COD_PLANTARIF || ' ) ';
                       
                       IF LV_IND_VTA <> '1' THEN
                           LV_sSql :=  LV_sSql || ' AND B.COD_ANTIGUEDAD = ' || EV_COD_ANTIGUEDAD;
                       END IF;
                       
                       IF EV_IND_COMODATO = '1' Then
                           LV_sSql :=  LV_sSql || ' AND B.IND_VENTA = ' || LV_IND_VTA;
                       END IF;
                       
            LV_sSql :=  LV_sSql || ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE) ' ||
                                 ' AND D.COD_MONEDA = ' || LV_COD_MONEDA;
   
			OPEN SC_cursordatos FOR	LV_sSql;


EXCEPTION
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_List_cargos_Habilitacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_List_cargos_Habilitacion_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_List_cargos_Habilitacion_PR('||EV_IND_COMODATO||','||EN_COD_PRODUCTO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||','||EN_NUM_MESES||','||EV_COD_PLANTARIF||','||EV_COD_ANTIGUEDAD||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_List_cargos_Habilitacion_PR('||EV_IND_COMODATO||','||EN_COD_PRODUCTO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||','||EN_NUM_MESES||','||EV_COD_PLANTARIF||','||EV_COD_ANTIGUEDAD||')', LV_sSql, SQLCODE, LV_des_error );
END PV_List_cargos_Habilitacion_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_List_cargos_Deducible_PR (EN_COD_ARTICULO    IN AL_PRECIOS_DEDUCIBLE_TO.COD_ARTICULO%TYPE,
                                       EN_NUM_ABONADO     IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_NUM_SERIE_NUEVA IN AL_SERIES.NUM_SERIE%TYPE, 
                                       EV_NOMBRE_USUARIO  IN VARCHAR2,
					                   SC_cursordatos	  OUT NOCOPY REFCURSOR,
 					                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
                                       
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_List_cargos_Deducible_PR"
				Lenguaje="PL/SQL"
				Fecha="14-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los precios deducibles
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_NUM_ABONADO" Tipo="NUMERIC"> Numero de Abonado</param>
                  <param nom="EV_NUM_SERIE_NUEVA" Tipo="VARCHAR2">numero de serie nueva</param>
                  <param nom="EV_NOMBRE_USUARIO" Tipo="VARCHAR2">nombre de usuario</param>
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios deducibles </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LN_CANT_CARGOS       NUMBER;
        LV_IND_AUTO_MAN      VARCHAR(2);
        LV_DES_ARTICULO      VARCHAR2(40);
        LV_NUM_UNIDADES      VARCHAR(2);
        LN_PRC_DEDUCIBLE     NUMBER(14,4);
        LV_DES_MONEDA        VARCHAR2(20);
        LN_COD_CONCEPTOART   NUMBER;
        LV_COD_MONEDA        VARCHAR2(3);
        LV_VAL_MINIMO        VARCHAR2(2);
        LV_VAL_MAXIMO        VARCHAR2(2);
        LN_CARGO    	     NUMBER;
        LN_CANTIDAD          NUMBER;
    
        OT_CARGOEQUIPO       PV_LISTACARGOEQUIPO_OT:=PV_LISTACARGOEQUIPO_OT();
        
        LC_CURSORDATOS	     REFCURSOR;
        
        ERROR_SIN_PRECIO     EXCEPTION;
        ERROR_PRC_EXT        EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
			 
            
            LV_sSql := ' SELECT ''A'', B.DES_ARTICULO, ''1'', A.PRC_DEDUCIBLE, C.DES_MONEDA, B.COD_CONCEPTOART, ' ||
                       ' A.COD_MONEDA, 0, 0' ||
                       ' FROM AL_PRECIOS_DEDUCIBLE_TO A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                       ' WHERE A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                       ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                       ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                       ' AND C.COD_MONEDA = A.COD_MONEDA ';
            
            SELECT COUNT(A.PRC_DEDUCIBLE)
            INTO LN_CANT_CARGOS
            FROM AL_PRECIOS_DEDUCIBLE_TO A, AL_ARTICULOS B, GE_MONEDAS C 
            WHERE A.COD_ARTICULO = EN_COD_ARTICULO
            AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
            AND B.COD_ARTICULO = A.COD_ARTICULO
            AND C.COD_MONEDA = A.COD_MONEDA;
            
            IF LN_CANT_CARGOS = 0 THEN
            
                SV_mens_retorno := 'PROBLEMAS EN CARGOS NO HAY CONFIGURACIÓN DE PRECIOS EN LA TABLA DE DEDUCIBLES PARA EL EQUIPO NUEVO';
                
                RAISE ERROR_SIN_PRECIO;
                
            END IF;
                
            OPEN LC_CURSORDATOS FOR
            
                SELECT 'A', B.DES_ARTICULO, '1', A.PRC_DEDUCIBLE, C.DES_MONEDA, B.COD_CONCEPTOART,
                A.COD_MONEDA, 0, 0
                FROM AL_PRECIOS_DEDUCIBLE_TO A, AL_ARTICULOS B, GE_MONEDAS C 
                WHERE A.COD_ARTICULO = EN_COD_ARTICULO
                AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
                AND B.COD_ARTICULO = A.COD_ARTICULO
                AND C.COD_MONEDA = A.COD_MONEDA;

            LOOP
    
                FETCH LC_CURSORDATOS
                INTO LV_IND_AUTO_MAN, LV_DES_ARTICULO, LV_NUM_UNIDADES, LN_PRC_DEDUCIBLE, 
                     LV_DES_MONEDA, LN_COD_CONCEPTOART, LV_COD_MONEDA, LV_VAL_MINIMO, LV_VAL_MAXIMO;
                
                EXIT WHEN LC_CURSORDATOS%NOTFOUND;
            
                LV_sSql := ' SELECT  COUNT(1) FROM GA_SEGUROABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO ';
            
                SELECT  COUNT(1)
                INTO LN_CANTIDAD 
                FROM GA_SEGUROABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO; 
                
                IF LN_CANTIDAD > 0 THEN
                
                    LV_sSql := ' PV_List_cargos_Seguros_PR ( ' || EN_NUM_ABONADO || ', ' ||
                                                                  EV_NUM_SERIE_NUEVA || ', ' ||
                                                                  LV_COD_MONEDA || ', ' ||
                                                                  EV_NOMBRE_USUARIO || ', ' ||
                                                                  LN_PRC_DEDUCIBLE || ')';
                                                           
                           
                    PV_List_cargos_Seguros_PR (EN_NUM_ABONADO,
                                               EV_NUM_SERIE_NUEVA,
                                               LV_COD_MONEDA,
                                               EV_NOMBRE_USUARIO,
                                               LN_PRC_DEDUCIBLE,
                                               LN_CARGO,
                                               SN_cod_retorno,
                                               SV_mens_retorno,
                                               SN_num_evento);
                                           
                    IF SN_cod_retorno <> 0 THEN
                    
                        RAISE ERROR_PRC_EXT;
                        
                    END IF;                                           
                                           
                    LN_PRC_DEDUCIBLE := LN_CARGO;
                
                END IF;
            
                
                OT_CARGOEQUIPO.extend;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last) := PV_CARGO_EQUIPO_QT(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
                     
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_AUTO_MAN:=LV_IND_AUTO_MAN;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_ARTICULO:=LV_DES_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).NUM_UNIDADES:=LV_NUM_UNIDADES;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).PRC_DEDUCIBLE:=LN_PRC_DEDUCIBLE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_MONEDA:=LV_DES_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_CONCEPTOART:=LN_COD_CONCEPTOART;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_MONEDA:=LV_COD_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MINIMO:=LV_VAL_MINIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MAXIMO:=LV_VAL_MAXIMO;                                           
            
            END LOOP;
            
            
            OPEN SC_cursordatos FOR
             SELECT IND_AUTO_MAN,
                    DES_ARTICULO,
                    NUM_UNIDADES,
                    PRC_DEDUCIBLE,
                    DES_MONEDA,
                    COD_CONCEPTOART,
                    COD_MONEDA,
                    VAL_MINIMO,
                    VAL_MAXIMO
             FROM   TABLE (CAST (OT_CARGOEQUIPO AS PV_LISTACARGOEQUIPO_OT)) a;

EXCEPTION
    WHEN ERROR_PRC_EXT THEN
    
        NULL;
        
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_List_cargos_Deducible_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_List_cargos_Deducible_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_List_cargos_Deducible_PR('||EN_COD_ARTICULO||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_List_cargos_Deducible_PR('||EN_COD_ARTICULO||')', LV_sSql, SQLCODE, LV_des_error );
END PV_List_cargos_Deducible_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Seguros_PR (EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EV_NUM_SERIE_NUEVA      IN AL_SERIES.NUM_SERIE%TYPE,
 		   							 EV_COD_MONEDA           IN AL_PRECIOS_DEDUCIBLE_TO.COD_MONEDA%TYPE,
                                     EV_NOMBRE_USUARIO       IN VARCHAR2,
                                     EN_IMPORTE              IN NUMBER,
					                 SN_CARGO    	         OUT NOCOPY NUMBER,
 					                 SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                 		             SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                        	         SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_List_cargos_Seguros_PR"
				Lenguaje="PL/SQL"
				Fecha="14-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los precios deducibles
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_NUM_ABONADO" Tipo="NUMERIC">Numero del Abonado</param>
                  <param nom="EV_NUM_SERIE_NUEVA" Tipo="VARCHAR2"> numero de serie</param>
                  <param nom="EV_COD_MONEDA" Tipo="VARCHAR2">codigo moneda</param>
                  <param nom="EV_NOMBRE_USUARIO" Tipo="VARCHAR2"> nombre de usuario</param>
                  <param nom="EN_IMPORTE" Tipo="NUMERIC">importe</param>
			</Entrada>
			<Salida>
   			    <param nom="SN_CARGO"  Tipo="NUMBER"> cargo por seguro </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LV_NUM_SERIE_ANT_RES GA_ABOCEL.NUM_IMEI%TYPE;
        LD_FEC_ALTA          GA_EQUIPABOSER.FEC_ALTA%TYPE;
        LV_NUM_SERIE_ANT     GA_EQUIPABOSER.NUM_SERIE%TYPE;
        LV_IND_PROCEQUI      GA_EQUIPABOSER.IND_PROCEQUI%TYPE;
        LV_COD_SEGURO        GA_SEGUROABONADO_TO.COD_SEGURO%TYPE; 
        LN_NUM_EVENTOS       GA_SEGUROABONADO_TO.NUM_EVENTOS%TYPE;
        LN_COD_ARTICULO      GA_EQUIPABOSER.COD_ARTICULO%TYPE;
        LN_IMPORTE_SEGURO    AL_PRECIOS_DEDUCIBLE_TO.PRC_DEDUCIBLE%TYPE;
        LN_POR_COBRO         GA_PORCENTAJE_COBROS_TD.POR_COBRO%TYPE;
        LN_DEDUCIBLE         GA_TIPOSEGURO_TD.DEDUCIBLE%TYPE;
        LN_EVENTO            GA_SEGUROABONADO_TO.NUM_EVENTOS%TYPE;
        LB_FLAG_TARIFA       BOOLEAN;
        LN_CANTIDAD          NUMBER;
        LN_TMP_IMPORTE       NUMBER;
      
        ERROR_FIN            EXCEPTION;
        ERROR_SIN_PRECIO     EXCEPTION; 
    
		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';

            SN_CARGO := EN_IMPORTE; 
            
            BEGIN
            
                LV_sSql := ' SELECT  NUM_IMEI ' ||
                           ' FROM GA_ABOCEL ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
                SELECT  NUM_IMEI
                INTO LV_NUM_SERIE_ANT_RES
                FROM GA_ABOCEL 
                WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;			
            
            BEGIN
            
                LV_SSQL := ' SELECT  MAX(FEC_ALTA) FROM GA_EQUIPABOSER ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND NUM_IMEI IS NULL ';
            
                SELECT  MAX(FEC_ALTA)
                INTO LD_FEC_ALTA   
                FROM GA_EQUIPABOSER
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND NUM_IMEI IS NULL;
            
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;
              
            
            BEGIN
            
                LV_SSQL := ' SELECT NUM_SERIE , IND_PROCEQUI ' ||
                           ' FROM GA_EQUIPABOSER ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND NUM_IMEI IS NULL ' ||
                           ' AND FEC_ALTA = ' || LD_FEC_ALTA;
             

                SELECT NUM_SERIE , IND_PROCEQUI
                INTO LV_NUM_SERIE_ANT, LV_IND_PROCEQUI 
                FROM GA_EQUIPABOSER 
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND NUM_IMEI IS NULL
                AND FEC_ALTA = LD_FEC_ALTA;
            
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;

            IF LV_IND_PROCEQUI = 'E' THEN
            
                RAISE ERROR_FIN;
                   
            END IF;
            
            BEGIN
            
                LV_SSQL := ' SELECT  COUNT(1) FROM GA_EQUIPABOSER ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND IND_PROCEQUI = ''I''' ||
                           ' AND NUM_SERIE = ' || LV_NUM_SERIE_ANT_RES ||
                           ' AND NUM_IMEI IS NULL ';
             
                SELECT  COUNT(1)
                INTO LN_CANTIDAD 
                FROM GA_EQUIPABOSER 
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND IND_PROCEQUI = 'I'
                AND NUM_SERIE = LV_NUM_SERIE_ANT_RES
                AND NUM_IMEI IS NULL;
            
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;
            
            IF EV_NUM_SERIE_NUEVA IS NOT NULL THEN
            
                IF LV_NUM_SERIE_ANT <> TRIM(EV_NUM_SERIE_NUEVA) THEN
                  
                    LB_FLAG_TARIFA := TRUE;
                  
                END IF;
            
            ELSE
                 
                LB_FLAG_TARIFA := FALSE;
             
            END IF;

            BEGIN
            
                LV_SSQL := ' SELECT A.COD_SEGURO, A.NUM_EVENTOS ' ||
                           ' FROM GA_SEGUROABONADO_TO A , GA_TIPOSEGURO_TD B ' ||
                           ' WHERE A.COD_SEGURO = B.COD_SEGURO ' ||
                           ' AND NUM_ABONADO = ' || EN_NUM_ABONADO;
   
                SELECT A.COD_SEGURO, A.NUM_EVENTOS
                INTO LV_COD_SEGURO, LN_NUM_EVENTOS 
                FROM GA_SEGUROABONADO_TO A , GA_TIPOSEGURO_TD B 
                WHERE A.COD_SEGURO = B.COD_SEGURO 
                AND NUM_ABONADO = EN_NUM_ABONADO;
                
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;            
            

            BEGIN
            
                LV_SSQL := ' SELECT  MAX(FEC_ALTA) FROM GA_EQUIPABOSER ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND IND_PROCEQUI = ''I''' ||
                           ' AND TIP_TERMINAL = ''T''' ||
                           ' AND NUM_SERIE <> ' || EV_NUM_SERIE_NUEVA;
   
                
                SELECT  MAX(FEC_ALTA) 
                INTO LD_FEC_ALTA
                FROM GA_EQUIPABOSER
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND IND_PROCEQUI = 'I'
                AND TIP_TERMINAL = 'T'
                AND NUM_SERIE <> EV_NUM_SERIE_NUEVA;
                
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;
            
            
            BEGIN
            
                LV_SSQL := ' SELECT  COD_ARTICULO FROM GA_EQUIPABOSER ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND IND_PROCEQUI = ''I''' || 
                           ' AND TIP_TERMINAL = ''T''' ||
                           ' AND num_serie <> ' || EV_NUM_SERIE_NUEVA ||
                           ' AND FEC_ALTA = ' || LD_FEC_ALTA;
   
                SELECT  COD_ARTICULO
                INTO LN_COD_ARTICULO
                FROM GA_EQUIPABOSER  
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND IND_PROCEQUI = 'I' 
                AND TIP_TERMINAL = 'T'
                AND num_serie <> EV_NUM_SERIE_NUEVA
                AND FEC_ALTA = LD_FEC_ALTA;
                
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                                                                                    
                    RAISE ERROR_FIN;
                
            END;
            
            
            BEGIN
            
                LV_SSQL := ' SELECT  PRC_DEDUCIBLE FROM AL_PRECIOS_DEDUCIBLE_TO ' ||
                           ' WHERE COD_ARTICULO = ' || LN_COD_ARTICULO ||
                           ' AND COD_MONEDA = ' || EV_COD_MONEDA ||
                           ' AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ';
            
   
                SELECT  PRC_DEDUCIBLE
                INTO LN_IMPORTE_SEGURO    
                FROM AL_PRECIOS_DEDUCIBLE_TO
                WHERE COD_ARTICULO = LN_COD_ARTICULO
                AND COD_MONEDA = EV_COD_MONEDA
                AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                
            EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                    SV_mens_retorno := 'PROBLEMAS EN CARGOS NO HAY CONFIGURACIÓN DE PRECIOS EN LA TABLA DE DEDUCIBLES PARA EL EQUIPO ANTIGUO';                                                                                   
                    RAISE ERROR_SIN_PRECIO;
                
            END;            
            
            LV_SSQL := ' SELECT NVL(C.NUM_EVENTOS,0) ' ||
                       ' FROM  GA_SEGUROABONADO_TO C ' ||
                       ' WHERE ' ||
                       ' C.NUM_ABONADO = ' || EN_NUM_ABONADO ||
                       ' AND C.COD_SEGURO = ' || LV_COD_SEGURO;
   
            SELECT NVL(C.NUM_EVENTOS,0)
            INTO LN_EVENTO   
            FROM  GA_SEGUROABONADO_TO C
            WHERE C.NUM_ABONADO = EN_NUM_ABONADO
            AND C.COD_SEGURO = LV_COD_SEGURO;
            
            
            IF LN_EVENTO = 0 THEN
            
                LN_NUM_EVENTOS := LN_NUM_EVENTOS + 1;
                
                LV_SSQL := ' UPDATE GA_SEGUROABONADO_TO ' ||
                           ' SET NUM_EVENTOS = ' || LN_NUM_EVENTOS ||
                           ' ,FEC_MODIFICACION =  SYSDATE ' ||
                           ' ,NOM_USUARORA =  ' || EV_NOMBRE_USUARIO ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND COD_SEGURO  = ' || LV_COD_SEGURO;
            
                UPDATE GA_SEGUROABONADO_TO 
                SET NUM_EVENTOS = LN_NUM_EVENTOS
                   ,FEC_MODIFICACION =  SYSDATE 
                   ,NOM_USUARORA = EV_NOMBRE_USUARIO
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND COD_SEGURO  = LV_COD_SEGURO;
                
                LV_SSQL := ' SELECT B.POR_COBRO, A.DEDUCIBLE ' ||
                           ' FROM GA_TIPOSEGURO_TD A , GA_PORCENTAJE_COBROS_TD B, GA_SEGUROABONADO_TO C ' ||
                           ' WHERE A.COD_SEGURO = B.COD_SEGURO ' ||
                           ' AND A.COD_SEGURO=C.COD_SEGURO ' ||
                           ' AND B.COD_SEGURO=C.COD_SEGURO ' ||
                           ' AND SYSDATE BETWEEN A.FEC_INICIO AND A.FEC_TERMINO ' ||
                           ' AND SYSDATE BETWEEN B.FEC_INICIO AND B.FEC_TERMINO ' ||
                           ' AND B.NUM_EVENTO=C.NUM_EVENTOS ' ||
                           ' AND C.NUM_ABONADO = ' || EV_NOMBRE_USUARIO ||
                           ' AND A.COD_SEGURO = ' || LV_COD_SEGURO;
                
                BEGIN
                
                    SELECT B.POR_COBRO, A.DEDUCIBLE
                    INTO  LN_POR_COBRO, LN_DEDUCIBLE
                    FROM GA_TIPOSEGURO_TD A , GA_PORCENTAJE_COBROS_TD B, GA_SEGUROABONADO_TO C
                    WHERE A.COD_SEGURO = B.COD_SEGURO
                         AND A.COD_SEGURO=C.COD_SEGURO
                         AND B.COD_SEGURO=C.COD_SEGURO
                         AND SYSDATE BETWEEN A.FEC_INICIO AND A.FEC_TERMINO
                         AND SYSDATE BETWEEN B.FEC_INICIO AND B.FEC_TERMINO
                         AND B.NUM_EVENTO=C.NUM_EVENTOS 
                         AND C.NUM_ABONADO = EV_NOMBRE_USUARIO
                         AND A.COD_SEGURO = LV_COD_SEGURO;
                     
                EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                    
                    LN_POR_COBRO := 0; 
                    LN_DEDUCIBLE := 0;
                    
                    LV_SSQL := ' UPDATE GA_SEGUROABONADO_TO ' ||
                               ' SET NUM_EVENTOS = ' || LN_NUM_EVENTOS - 1 ||
                               '     ,FEC_MODIFICACION =  SYSDATE ' ||
                               '     ,NOM_USUARORA=  ' || EV_NOMBRE_USUARIO ||
                               ' WHERE  NUM_ABONADO = ' || EN_NUM_ABONADO ||
                               ' AND    COD_SEGURO  = ' || LV_COD_SEGURO;
                
                    UPDATE GA_SEGUROABONADO_TO 
                    SET NUM_EVENTOS = LN_NUM_EVENTOS - 1
                       ,FEC_MODIFICACION =  SYSDATE
                       ,NOM_USUARORA= EV_NOMBRE_USUARIO
                    WHERE  NUM_ABONADO = EN_NUM_ABONADO
                    AND    COD_SEGURO  = LV_COD_SEGURO;
                    
                    
                    
                END; 
            
            ELSE
            
                LN_NUM_EVENTOS := LN_NUM_EVENTOS + 1;
            
                LV_SSQL := ' UPDATE GA_SEGUROABONADO_TO ' ||
                           ' SET NUM_EVENTOS = ' || LN_NUM_EVENTOS ||
                           '     ,FEC_MODIFICACION =  SYSDATE ' ||
                           '     ,NOM_USUARORA=  ' || EV_NOMBRE_USUARIO ||
                           ' WHERE  NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND    COD_SEGURO  = ' || LV_COD_SEGURO;
            
                UPDATE GA_SEGUROABONADO_TO 
                SET NUM_EVENTOS = LN_NUM_EVENTOS
                   ,FEC_MODIFICACION =  SYSDATE
                   ,NOM_USUARORA = EV_NOMBRE_USUARIO
                WHERE  NUM_ABONADO = EN_NUM_ABONADO
                AND    COD_SEGURO  = LV_COD_SEGURO;
                           

                
                BEGIN           
                           
                    LV_SSQL := ' SELECT B.POR_COBRO, A.DEDUCIBLE ' ||
                               ' FROM GA_TIPOSEGURO_TD A , GA_PORCENTAJE_COBROS_TD B, GA_SEGUROABONADO_TO C ' ||
                               ' WHERE A.COD_SEGURO = B.COD_SEGURO ' ||
                               ' AND A.COD_SEGURO=C.COD_SEGURO ' ||
                               ' AND B.COD_SEGURO=C.COD_SEGURO ' ||
                               ' AND SYSDATE BETWEEN A.FEC_INICIO AND A.FEC_TERMINO ' ||
                               ' AND SYSDATE BETWEEN B.FEC_INICIO AND B.FEC_TERMINO ' ||
                               ' AND B.NUM_EVENTO=C.NUM_EVENTOS ' ||
                               ' AND C.NUM_ABONADO = ' || EN_NUM_ABONADO ||
                               ' AND A.COD_SEGURO = ' || LV_COD_SEGURO;
                           
                    SELECT B.POR_COBRO, A.DEDUCIBLE
                    INTO  LN_POR_COBRO, LN_DEDUCIBLE
                    FROM GA_TIPOSEGURO_TD A , GA_PORCENTAJE_COBROS_TD B, GA_SEGUROABONADO_TO C
                    WHERE A.COD_SEGURO = B.COD_SEGURO 
                    AND A.COD_SEGURO=C.COD_SEGURO
                    AND B.COD_SEGURO=C.COD_SEGURO
                    AND SYSDATE BETWEEN A.FEC_INICIO AND A.FEC_TERMINO
                    AND SYSDATE BETWEEN B.FEC_INICIO AND B.FEC_TERMINO
                    AND B.NUM_EVENTO=C.NUM_EVENTOS 
                    AND C.NUM_ABONADO = EN_NUM_ABONADO
                    AND A.COD_SEGURO = LV_COD_SEGURO;                           
            
                EXCEPTION
                    
                    WHEN NO_DATA_FOUND THEN
                    
                    LN_POR_COBRO := 0; 
                    LN_DEDUCIBLE := 0;
                    
                    LV_SSQL := ' UPDATE GA_SEGUROABONADO_TO ' ||
                               ' SET NUM_EVENTOS = ' || LN_NUM_EVENTOS - 1 ||
                               '     ,FEC_MODIFICACION =  SYSDATE ' ||
                               '     ,NOM_USUARORA=  ' || EV_NOMBRE_USUARIO ||
                               ' WHERE  NUM_ABONADO = ' || EN_NUM_ABONADO ||
                               ' AND    COD_SEGURO  = ' || LV_COD_SEGURO;
                
                    UPDATE GA_SEGUROABONADO_TO 
                    SET NUM_EVENTOS = LN_NUM_EVENTOS - 1
                       ,FEC_MODIFICACION =  SYSDATE
                       ,NOM_USUARORA= EV_NOMBRE_USUARIO
                    WHERE  NUM_ABONADO = EN_NUM_ABONADO
                    AND    COD_SEGURO  = LV_COD_SEGURO;
                    
                END; 
                
            END IF;
                 
            
            IF LB_FLAG_TARIFA = TRUE THEN
            
                IF LN_POR_COBRO = 0 THEN
                
                    RAISE ERROR_FIN;                        
                
                END IF;
                
                IF LN_IMPORTE_SEGURO < EN_IMPORTE THEN
                
                    IF LN_POR_COBRO <> 0 THEN
                    
                        LN_TMP_IMPORTE := (EN_IMPORTE - LN_IMPORTE_SEGURO) + (LN_IMPORTE_SEGURO * (LN_POR_COBRO / 100));
                    
                    ELSE
                        LN_TMP_IMPORTE := EN_IMPORTE;
                    
                    END IF;
                
                END IF;
            
                IF LN_IMPORTE_SEGURO > EN_IMPORTE THEN
                
                    IF LN_POR_COBRO <> 0 THEN
                        
                        LN_TMP_IMPORTE := (EN_IMPORTE * (LN_POR_COBRO / 100));
                    
                    ELSE
                    
                        LN_TMP_IMPORTE := EN_IMPORTE;
                            
                    END IF;
                    
                END IF;
                
                IF LN_IMPORTE_SEGURO = EN_IMPORTE THEN
                
                    IF LN_POR_COBRO <> 0 THEN
                        
                        LN_TMP_IMPORTE := (LN_IMPORTE_SEGURO * (LN_POR_COBRO / 100));
                    
                    ELSE
                    
                        LN_TMP_IMPORTE := EN_IMPORTE;
                            
                    END IF;
                    
                END IF;
            
                SN_CARGO := LN_TMP_IMPORTE;
                
            END IF;
                  
EXCEPTION
    WHEN ERROR_FIN THEN
             
        NULL;
    
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_List_cargos_Seguros_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_List_cargos_Seguros_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                                     
    WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_List_cargos_Seguros_PR('||EN_NUM_ABONADO||','||EV_NUM_SERIE_NUEVA||','||EV_COD_MONEDA||','||EV_NOMBRE_USUARIO||','||EN_IMPORTE||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_List_cargos_Seguros_PR('||EN_NUM_ABONADO||','||EV_NUM_SERIE_NUEVA||','||EV_COD_MONEDA||','||EV_NOMBRE_USUARIO||','||EN_IMPORTE||')', LV_sSql, SQLCODE, LV_des_error );
          
END PV_List_cargos_Seguros_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_Prec_List_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                     EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                     EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                     EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                     EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                     EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                     EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                     EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                     EV_NOMBRE_USUARIO    IN VARCHAR2,
					                 SC_cursordatos	      OUT NOCOPY REFCURSOR,
 					                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                                       
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_List_Prec_List_Rest_PR"
				Lenguaje="PL/SQL"
				Fecha="14-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los precios lista para restitucion
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC">Tipo de Stock</param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"> Codigo de Articulo</param>
                  <param nom="EV_NUM_SERIE" Tipo="VARCHAR2">numero de serie nueva</param>
                  <param nom="EN_COD_USO" Tipo="NUMBER">Codigo de Uso</param>
                  <param nom="EN_COD_ESTADO" Tipo="NUMERIC">Codigo de estado</param>
                  <param nom="EN_NUM_ABONADO" Tipo="NUMBER">numero de abonado</param>
                  <param nom="EN_COD_ANTIGUEDAD" Tipo="NUMERIC">Codigo de Antiguedad</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"> Modalidad de la Venta</param>
                  <param nom="EN_NUM_MESES" Tipo="NUMBER">numero de meses</param>
                  <param nom="EV_NOMBRE_USUARIO" Tipo="VARCHAR2">nombre de usuario</param>   
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios lista con seguro si es que aplica </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LN_CANTIDAD_CARGOS   NUMBER;    
        LV_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_COD_PRODUCTO      AL_ARTICULOS.COD_PRODUCTO%TYPE;   
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LN_COD_PROMEDIO      AL_PROMFACT.COD_PROMEDIO%TYPE;
        LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_CALIFICACION  GA_DATABONADO_TO.COD_CALIFICACION%TYPE;
        LV_APLICA_CAL_ABO    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_CAL_DEFAULT_PRC   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_COD_CONCEPTOART   NUMBER;
        LV_DES_ARTICULO      VARCHAR2(40);
        LN_PRC_DEDUCIBLE     NUMBER(14,4);
        LV_COD_MONEDA        VARCHAR2(3);
        LV_DES_MONEDA        VARCHAR2(20);
        LV_VAL_MINIMO        VARCHAR2(2);
        LV_VAL_MAXIMO        VARCHAR2(2);
        LV_IND_AUTO_MAN      VARCHAR(2);
        LV_NUM_UNIDADES      VARCHAR(2);
        LN_IND_EQUIPO        NUMBER;
        LN_IND_PAQUETE       NUMBER;
        LN_MES_GARANTIA      NUMBER;
        LN_IND_ACCESORIO     NUMBER;
        LN_COD_ARTICULO      NUMBER;
        LN_COD_STOCK         NUMBER;
        LN_COD_ESTADO        NUMBER;
        LN_CANTIDAD          NUMBER;
        LN_CARGO    	     NUMBER;
        
        OT_CARGOEQUIPO       PV_LISTACARGOEQUIPO_OT:=PV_LISTACARGOEQUIPO_OT();
        LC_CURSORDATOS	     REFCURSOR;
        
        ERROR_SIN_PRECIO     EXCEPTION;
        ERROR_PRC_EXT        EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
			
            LV_sSql := ' SELECT COD_PRODUCTO ' ||
                       ' FROM AL_ARTICULOS ' ||
                       ' WHERE COD_ARTICULO = ' || EN_COD_ARTICULO;
   
            SELECT COD_PRODUCTO
            INTO LN_COD_PRODUCTO
            FROM AL_ARTICULOS
            WHERE COD_ARTICULO = EN_COD_ARTICULO;
    
            LV_sSql := ' SELECT COD_PLANTARIF ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT COD_PLANTARIF
            INTO LV_COD_PLANTARIF
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            LV_sSql := ' SELECT cod_cliente ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT cod_cliente
            INTO LN_COD_CLIENTE
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            BEGIN
            
                LV_sSql := ' SELECT trim(VAL_PARAMETRO) ' || 
                           ' FROM GED_PARAMETROS  ' || 
                           ' WHERE  NOM_PARAMETRO = ''APLICA_CAL_ABO'' AND COD_MODULO = ''GA''';           
            
                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_APLICA_CAL_ABO  
                FROM GED_PARAMETROS 
                WHERE  NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                LV_APLICA_CAL_ABO := '';
                    
            END;
                 
            IF (TRIM(LV_APLICA_CAL_ABO) = 'TRUE') THEN
            
                LV_sSql := ' SELECT TRIM(VAL_PARAMETRO) ' || 
                           ' FROM GED_PARAMETROS ' ||
                           ' WHERE  NOM_PARAMETRO = ''CAL_DEFAULT_PRC'' AND COD_MODULO = ''GA''';

                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_CAL_DEFAULT_PRC 
                FROM GED_PARAMETROS 
                WHERE  NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';
                
                LV_sSql := ' SELECT NVL(COD_CALIFICACION, ' || LV_CAL_DEFAULT_PRC || ' ) ' ||
                           ' FROM GA_DATABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
                           
                SELECT NVL(COD_CALIFICACION, LV_CAL_DEFAULT_PRC)
                INTO LV_COD_CALIFICACION
                FROM GA_DATABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO;
                                     
                IF ((LV_COD_CALIFICACION IS NOT NULL) AND (LENGTH(TRIM(LV_COD_CALIFICACION))>0)) THEN
                
                    LV_COD_CALIFICACION := LV_COD_CALIFICACION;
                
                ELSE
                
                    LV_COD_CALIFICACION := LV_CAL_DEFAULT_PRC;
                
                END IF;
                
            ELSE
                    
                LV_sSql := ' SELECT COD_CALIFICACION ' ||
                           ' FROM GE_CLIENTES ' ||
                           ' WHERE COD_CLIENTE = ' || LN_COD_CLIENTE;
                           
                SELECT COD_CALIFICACION 
                INTO LV_COD_CALIFICACION
                FROM GE_CLIENTES
                WHERE COD_CLIENTE = LN_COD_CLIENTE;
                
            END IF;                  
            
            
            LV_sSql := ' SELECT COD_CATEGORIA ' ||
                       ' FROM VE_CATPLANTARIF ' ||
                       ' WHERE COD_PRODUCTO = ' || LN_COD_PRODUCTO || 
                       ' AND COD_PLANTARIF = ' || LV_COD_PLANTARIF;
            
            SELECT COD_CATEGORIA
            INTO LV_COD_CATEGORIA
            FROM VE_CATPLANTARIF
            WHERE COD_PRODUCTO = LN_COD_PRODUCTO 
            AND COD_PLANTARIF = LV_COD_PLANTARIF;
   
            LV_sSql := ' SELECT A.COD_PROMEDIO FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL ' ||
                       '                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,''MM'')) CUENTA ' ||
                       '                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                                                     AND COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                                                   ) V ' ||
                       '                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                            AND     U.COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                         )B ' ||
                       ' WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA ';

            BEGIN
            
                SELECT A.COD_PROMEDIO 
                INTO LN_COD_PROMEDIO
                FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL 
                                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,'MM')) CUENTA
                                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                                                     AND COD_CLIENTE = LN_COD_CLIENTE
                                                                   ) V 
                                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                            AND     U.COD_CLIENTE = LN_COD_CLIENTE
                                         )B
                WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA;
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                    LV_sSql := ' SELECT MAX(A.COD_PROMEDIO) FROM AL_PROMFACT A ';
                    
                    SELECT MAX(A.COD_PROMEDIO)
                    INTO LN_COD_PROMEDIO 
                    FROM AL_PROMFACT A;    
                    
            END; 


            LV_sSql := ' SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA,C.DES_MONEDA, ' ||
           ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0),''A'', ''1'',''1'',''0'',B.MES_GARANTIA, ' ||   
           ' ''0'', ''0'',''0'',''0''' ||
           ' FROM AL_PRECIOS_VENTA  A, AL_ARTICULOS B, GE_MONEDAS C ' ||
           ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
           ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
           ' AND A.COD_USO = ' || EN_COD_USO ||
           ' AND A.COD_ESTADO = ' || EN_COD_ESTADO || 
           ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
           ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
           ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
           ' AND A.IND_RECAMBIO = 9 ' ||
           ' AND A.IND_RENOVA = 0 ' ||
           ' AND A.COD_CALIFICACION = ' || LV_COD_CALIFICACION;
                       
           SELECT COUNT(A.PRC_VENTA)
           INTO LN_CANTIDAD_CARGOS
           FROM AL_PRECIOS_VENTA  A, AL_ARTICULOS B, GE_MONEDAS C
           WHERE A.TIP_STOCK = EN_TIP_STOCK
           AND A.COD_ARTICULO = EN_COD_ARTICULO
           AND A.COD_USO = EN_COD_USO
           AND A.COD_ESTADO = EN_COD_ESTADO
           AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
           AND B.COD_ARTICULO = A.COD_ARTICULO
           AND C.COD_MONEDA = A.COD_MONEDA
           AND A.IND_RECAMBIO = 9
           AND A.IND_RENOVA = 0
           AND A.COD_CALIFICACION = LV_COD_CALIFICACION;
           
           IF LN_CANTIDAD_CARGOS = 0 THEN
           
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado: ';
                SV_mens_retorno := SV_mens_retorno || '|Producto....................: ' || LN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Articulo................: ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || '|Num.Serie...................: ' || EV_NUM_SERIE;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Uso.....................: ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || '|Tip.Stock...................: ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Categoria...............: ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Antigüedad..............: ' || EN_COD_ANTIGUEDAD;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Estado..................: ' || EN_COD_ESTADO;
                SV_mens_retorno := SV_mens_retorno || '|Modalidad venta.............: ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || '|Meses Prorroga..............: ' || EN_NUM_MESES;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Promedio Facturado......: ' || LN_COD_PROMEDIO;
                SV_mens_retorno := SV_mens_retorno || '|FAVOR INFORMAR A LA MESA DE AYUDA .....';
                
                RAISE ERROR_SIN_PRECIO;
                
           END IF;
           
           
           OPEN LC_CURSORDATOS FOR 
                SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA,C.DES_MONEDA,
                       NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0),'A', '1','1','0',B.MES_GARANTIA,   
                       '0', '0','0','0'
                FROM AL_PRECIOS_VENTA  A, AL_ARTICULOS B, GE_MONEDAS C
                WHERE A.TIP_STOCK = EN_TIP_STOCK
                AND A.COD_ARTICULO = EN_COD_ARTICULO
                AND A.COD_USO = EN_COD_USO
                AND A.COD_ESTADO = EN_COD_ESTADO
                AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
                AND B.COD_ARTICULO = A.COD_ARTICULO
                AND C.COD_MONEDA = A.COD_MONEDA
                AND A.IND_RECAMBIO = 9
                AND A.IND_RENOVA = 0
                AND A.COD_CALIFICACION = LV_COD_CALIFICACION;
            
            LOOP
    
                FETCH LC_CURSORDATOS
                INTO LN_COD_CONCEPTOART, LV_DES_ARTICULO, LN_PRC_DEDUCIBLE, LV_COD_MONEDA, LV_DES_MONEDA, 
                     LV_VAL_MINIMO, LV_VAL_MAXIMO, LV_IND_AUTO_MAN, LV_NUM_UNIDADES, LN_IND_EQUIPO,
                     LN_IND_PAQUETE, LN_MES_GARANTIA, LN_IND_ACCESORIO, LN_COD_ARTICULO, LN_COD_STOCK,
                     LN_COD_ESTADO;
                
                EXIT WHEN LC_CURSORDATOS%NOTFOUND;
                
                LV_sSql := ' SELECT  COUNT(1) FROM GA_SEGUROABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO ';
            
                SELECT  COUNT(1)
                INTO LN_CANTIDAD 
                FROM GA_SEGUROABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO; 
                
                
                IF LN_CANTIDAD > 0 THEN
                
                    LV_sSql := ' PV_List_cargos_Seguros_PR ( ' || EN_NUM_ABONADO || ', ' ||
                                                                  EV_NUM_SERIE || ', ' ||
                                                                  LV_COD_MONEDA || ', ' ||
                                                                  EV_NOMBRE_USUARIO || ', ' ||
                                                                  LN_PRC_DEDUCIBLE || ')';
                                                           
                           
                    PV_List_cargos_Seguros_PR (EN_NUM_ABONADO,
                                               EV_NUM_SERIE,
                                               LV_COD_MONEDA,
                                               EV_NOMBRE_USUARIO,
                                               LN_PRC_DEDUCIBLE,
                                               LN_CARGO,
                                               SN_cod_retorno,
                                               SV_mens_retorno,
                                               SN_num_evento);
                                           
                    IF SN_cod_retorno <> 0 THEN
                    
                        RAISE ERROR_PRC_EXT;
                        
                    END IF;                                           
                                           
                    LN_PRC_DEDUCIBLE := LN_CARGO;
                
                END IF;
                
                OT_CARGOEQUIPO.extend;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last) := PV_CARGO_EQUIPO_QT(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
                    
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_CONCEPTOART:=LN_COD_CONCEPTOART;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_ARTICULO:=LV_DES_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).PRC_DEDUCIBLE:=LN_PRC_DEDUCIBLE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_MONEDA:=LV_COD_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_MONEDA:=LV_DES_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MINIMO:=LV_VAL_MINIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MAXIMO:=LV_VAL_MAXIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_AUTO_MAN:=LV_IND_AUTO_MAN;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).NUM_UNIDADES:=LV_NUM_UNIDADES;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_EQUIPO:=LN_IND_EQUIPO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_PAQUETE:=LN_IND_PAQUETE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).MES_GARANTIA:=LN_MES_GARANTIA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_ACCESORIO:=LN_IND_ACCESORIO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ARTICULO:=LN_COD_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_STOCK:=LN_COD_STOCK;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ESTADO:=LN_COD_ESTADO;
                    
            END LOOP;
            
            OPEN SC_cursordatos FOR
             SELECT COD_CONCEPTOART,
                    DES_ARTICULO,
                    PRC_DEDUCIBLE,
                    COD_MONEDA,
                    DES_MONEDA,
                    VAL_MINIMO,
                    VAL_MAXIMO,
                    IND_AUTO_MAN,
                    NUM_UNIDADES,
                    IND_EQUIPO,
                    IND_PAQUETE,
                    MES_GARANTIA,
                    IND_ACCESORIO,
                    COD_ARTICULO,
                    COD_STOCK,
                    COD_ESTADO
             FROM   TABLE (CAST (OT_CARGOEQUIPO AS PV_LISTACARGOEQUIPO_OT)) a;

EXCEPTION
    WHEN ERROR_PRC_EXT THEN
    
        NULL;
            
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_List_cargos_Deducible_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_List_cargos_Deducible_PR', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_List_cargos_Deducible_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_List_cargos_Deducible_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||')', LV_sSql, SQLCODE, LV_des_error );
          
END PV_List_Prec_List_Rest_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PrecTerRen_NoPreLis_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                          EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                          EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,    
                                          EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                          EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EN_PROMO_CELULAR     IN NUMBER, --0 CON PROMO, 1 SIN PROMO
                                          EV_NOMBRE_USUARIO    IN VARCHAR2,
					                      SC_cursordatos	      OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                                       
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_PrecTerRen_NoPreLis_Rest_PR"
				Lenguaje="PL/SQL"
				Fecha="14-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los precios lista para restitucion
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"> Numero de Abonado</param>
                  <param nom="EV_NUM_SERIE" Tipo="VARCHAR2">numero de serie nueva</param>
                  <param nom="EN_COD_USO" Tipo="NUMBER">nombre de usuario</param>
                  <param nom="EN_COD_ESTADO" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_NUM_ABONADO" Tipo="NUMBER">numero de serie nueva</param>
                  <param nom="EN_COD_ANTIGUEDAD" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"> Numero de Abonado</param>
                  <param nom="EN_NUM_MESES" Tipo="NUMBER">numero de serie nueva</param>
                  <param nom="EV_NOMBRE_USUARIO" Tipo="VARCHAR2">nombre de usuario</param>   
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios lista con seguro si es que aplica </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LN_CANTIDAD_CARGOS   NUMBER;    
        LV_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_COD_PRODUCTO      AL_ARTICULOS.COD_PRODUCTO%TYPE;   
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LN_COD_PROMEDIO      AL_PROMFACT.COD_PROMEDIO%TYPE;
        LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_CALIFICACION  GA_DATABONADO_TO.COD_CALIFICACION%TYPE;
        LV_APLICA_CAL_ABO    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_CAL_DEFAULT_PRC   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_COD_CONCEPTOART   NUMBER;
        LV_DES_ARTICULO      VARCHAR2(40);
        LN_PRC_DEDUCIBLE     NUMBER(14,4);
        LV_COD_MONEDA        VARCHAR2(3);
        LV_DES_MONEDA        VARCHAR2(20);
        LV_VAL_MINIMO        VARCHAR2(2);
        LV_VAL_MAXIMO        VARCHAR2(2);
        LV_IND_AUTO_MAN      VARCHAR(2);
        LV_NUM_UNIDADES      VARCHAR(2);
        LN_IND_EQUIPO        NUMBER;
        LN_IND_PAQUETE       NUMBER;
        LN_MES_GARANTIA      NUMBER;
        LN_IND_ACCESORIO     NUMBER;
        LN_COD_ARTICULO      NUMBER;
        LN_COD_STOCK         NUMBER;
        LN_COD_ESTADO        NUMBER;
        LN_CANTIDAD          NUMBER;
        LN_CARGO    	     NUMBER;
        
        LN_CANT_CARG_1       NUMBER;
        LN_CANT_CARG_2       NUMBER;
        LV_CANT_sSql         ge_errores_pg.vQuery;
        
        OT_CARGOEQUIPO       PV_LISTACARGOEQUIPO_OT:=PV_LISTACARGOEQUIPO_OT();
        LC_CURSORDATOS	     REFCURSOR;
        
        ERROR_SIN_PRECIO     EXCEPTION;
        ERROR_PRC_EXT        EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
            
            LN_CANT_CARG_1 := 0;
            LN_CANT_CARG_2 := 0;
			
            LV_sSql := ' SELECT COD_PRODUCTO ' ||
                       ' FROM AL_ARTICULOS ' ||
                       ' WHERE COD_ARTICULO = ' || EN_COD_ARTICULO;
   
            SELECT COD_PRODUCTO
            INTO LN_COD_PRODUCTO
            FROM AL_ARTICULOS
            WHERE COD_ARTICULO = EN_COD_ARTICULO;
    
            LV_sSql := ' SELECT COD_PLANTARIF ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT COD_PLANTARIF
            INTO LV_COD_PLANTARIF
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            LV_sSql := ' SELECT COD_CATEGORIA ' ||
                       ' FROM VE_CATPLANTARIF ' ||
                       ' WHERE COD_PRODUCTO = ' || LN_COD_PRODUCTO || 
                       ' AND COD_PLANTARIF = ' || LV_COD_PLANTARIF;
            
            LV_sSql := ' SELECT cod_cliente ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT cod_cliente
            INTO LN_COD_CLIENTE
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            BEGIN
            
                LV_sSql := ' SELECT trim(VAL_PARAMETRO) ' ||
                           ' FROM GED_PARAMETROS  ' ||
                           ' WHERE  NOM_PARAMETRO = ''APLICA_CAL_ABO'' AND COD_MODULO = ''GA''';

                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_APLICA_CAL_ABO
                FROM GED_PARAMETROS
                WHERE  NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                LV_APLICA_CAL_ABO := '';
                    
            END;
            
            IF (TRIM(LV_APLICA_CAL_ABO) = 'TRUE') THEN
            
                LV_sSql := ' SELECT TRIM(VAL_PARAMETRO) ' || 
                           ' FROM GED_PARAMETROS ' ||
                           ' WHERE  NOM_PARAMETRO = ''CAL_DEFAULT_PRC'' AND COD_MODULO = ''GA''';

                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_CAL_DEFAULT_PRC 
                FROM GED_PARAMETROS 
                WHERE  NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';
                
                LV_sSql := ' SELECT NVL(COD_CALIFICACION, ' || LV_CAL_DEFAULT_PRC || ' ) ' ||
                           ' FROM GA_DATABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
                           
                SELECT NVL(COD_CALIFICACION, LV_CAL_DEFAULT_PRC)
                INTO LV_COD_CALIFICACION
                FROM GA_DATABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO;
                                     
                IF ((LV_COD_CALIFICACION IS NOT NULL) AND (LENGTH(TRIM(LV_COD_CALIFICACION))>0)) THEN
                
                    LV_COD_CALIFICACION := LV_COD_CALIFICACION;
                
                ELSE
                
                    LV_COD_CALIFICACION := LV_CAL_DEFAULT_PRC;
                
                END IF;
                
            ELSE
                    
                LV_sSql := ' SELECT COD_CALIFICACION ' ||
                           ' FROM GE_CLIENTES ' ||
                           ' WHERE COD_CLIENTE = ' || LN_COD_CLIENTE;
                           
                SELECT COD_CALIFICACION 
                INTO LV_COD_CALIFICACION
                FROM GE_CLIENTES
                WHERE COD_CLIENTE = LN_COD_CLIENTE;
                
            END IF;                  
            
            
            SELECT COD_CATEGORIA
            INTO LV_COD_CATEGORIA
            FROM VE_CATPLANTARIF
            WHERE COD_PRODUCTO = LN_COD_PRODUCTO 
            AND COD_PLANTARIF = LV_COD_PLANTARIF;
   
            LV_sSql := ' SELECT A.COD_PROMEDIO FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL ' ||
                       '                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,''MM'')) CUENTA ' ||
                       '                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                                                     AND COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                                                   ) V ' ||
                       '                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                            AND     U.COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                         )B ' ||
                       ' WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA ';

            BEGIN
            
                SELECT A.COD_PROMEDIO 
                INTO LN_COD_PROMEDIO
                FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL 
                                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,'MM')) CUENTA
                                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                                                     AND COD_CLIENTE = LN_COD_CLIENTE
                                                                   ) V 
                                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                            AND     U.COD_CLIENTE = LN_COD_CLIENTE
                                         )B
                WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA;
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                    LV_sSql := ' SELECT MAX(A.COD_PROMEDIO) FROM AL_PROMFACT A ';
                    
                    SELECT MAX(A.COD_PROMEDIO)
                    INTO LN_COD_PROMEDIO 
                    FROM AL_PROMFACT A;    
                    
            END; 

            IF EN_PROMO_CELULAR = 0 THEN
            
                LV_sSql := ' SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA, C.DES_MONEDA, ' || 
                           ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0), ''A'', ''1'', ''1'', ''0'', B.MES_GARANTIA, ' ||
                           ' ''0'', ''0'',''0'',''0''' ||
                           ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                           ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                           ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                           ' AND A.COD_USO = ' || EN_COD_USO ||
                           ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                           ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                           ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                           ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                           ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                           ' AND A.IND_RECAMBIO = 2 ' ||
                           ' AND A.IND_RENOVA = 0 ' ||
                           ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''';
                           
                LV_CANT_sSql := ' SELECT COUNT(A.PRC_VENTA) ' || 
                                ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                                ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                                ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                                ' AND A.COD_USO = ' || EN_COD_USO ||
                                ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                                ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                                ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                                ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                                ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                                ' AND A.IND_RECAMBIO = 2 ' ||
                                ' AND A.IND_RENOVA = 0 ' ||
                                ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''';                           
            
                EXECUTE IMMEDIATE LV_CANT_sSql INTO LN_CANT_CARG_1; 
            
            ELSE
            
                LV_sSql := ' (SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA, C.DES_MONEDA, ' ||
                           ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0), ''A'', ''1'',''1'',''0'',B.MES_GARANTIA, ' || 
                           ' ''0'', ''0'',''0'',''0''' ||
                           ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                           ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                           ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO || 
                           ' AND A.COD_USO = ' || EN_COD_USO ||
                           ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                           ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                           ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                           ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                           ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                           ' AND A.IND_RECAMBIO = 1 ' ||
                           ' AND A.IND_RENOVA = 0 ' ||
                           ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                           ' AND ' || LN_COD_PROMEDIO || ' = A.COD_PROMEDIO ' ||
                           ' AND ' || EN_COD_ANTIGUEDAD || ' = A.COD_ANTIGUEDAD ' ||
                           ' AND A.NUM_MESES = ' || EN_NUM_MESES ||
                           ' AND A.COD_USO <> 3 ' ||
                           ' AND A.COD_CATEGORIA = ''' || LV_COD_CATEGORIA || '''' ||
                           ' AND B.IND_EQUIACC = ''E'') ' ||
                           ' UNION ' ||
                           ' (SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA, C.DES_MONEDA, ' ||
                           ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0), ''A'', ''1'',''1'',''0'',B.MES_GARANTIA, ' ||
                           ' ''0'', ''0'',''0'',''0''' ||
                           ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                           ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                           ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                           ' AND A.COD_USO = ' || EN_COD_USO ||
                           ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                           ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                           ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                           ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                           ' AND A.IND_RECAMBIO = 9 ' ||
                           ' AND A.IND_RENOVA = 0 ' ||
                           ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                           ' AND (B.IND_EQUIACC = ''A'' OR A.COD_USO = 3)) ';
                           
                LV_CANT_sSql := ' (SELECT COUNT(A.PRC_VENTA) ' || 
                                ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                                ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                                ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO || 
                                ' AND A.COD_USO = ' || EN_COD_USO ||
                                ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                                ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                                ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                                ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                                ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                                ' AND A.IND_RECAMBIO = 1 ' ||
                                ' AND A.IND_RENOVA = 0 ' ||
                                ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                                ' AND ' || LN_COD_PROMEDIO || ' = A.COD_PROMEDIO ' ||
                                ' AND ' || EN_COD_ANTIGUEDAD || ' = A.COD_ANTIGUEDAD ' ||
                                ' AND A.NUM_MESES = ' || EN_NUM_MESES ||
                                ' AND A.COD_USO <> 3 ' ||
                                ' AND A.COD_CATEGORIA = ''' || LV_COD_CATEGORIA || '''' ||
                                ' AND B.IND_EQUIACC = ''E'') ';
                                
                EXECUTE IMMEDIATE LV_CANT_sSql INTO LN_CANT_CARG_1;                                
                                
                LV_CANT_sSql := ' (SELECT COUNT(A.PRC_VENTA) ' ||
                                ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                                ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                                ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                                ' AND A.COD_USO = ' || EN_COD_USO ||
                                ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                                ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                                ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                                ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                                ' AND A.IND_RECAMBIO = 9 ' ||
                                ' AND A.IND_RENOVA = 0 ' ||
                                ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                                ' AND (B.IND_EQUIACC = ''A'' OR A.COD_USO = 3)) ';                           
            
                EXECUTE IMMEDIATE LV_CANT_sSql INTO LN_CANT_CARG_2;
                
            END IF;
            
                       
           
           
           IF (LN_CANT_CARG_1 + LN_CANT_CARG_2) = 0 THEN
           
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado: ';
                SV_mens_retorno := SV_mens_retorno || '|Producto....................: ' || LN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Articulo................: ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || '|Num.Serie...................: ' || EV_NUM_SERIE;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Uso.....................: ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || '|Tip.Stock...................: ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Categoria...............: ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Antigüedad..............: ' || EN_COD_ANTIGUEDAD;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Estado..................: ' || EN_COD_ESTADO;
                SV_mens_retorno := SV_mens_retorno || '|Modalidad venta.............: ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || '|Meses Prorroga..............: ' || EN_NUM_MESES;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Promedio Facturado......: ' || LN_COD_PROMEDIO;
                SV_mens_retorno := SV_mens_retorno || '|FAVOR INFORMAR A LA MESA DE AYUDA .....';
                
                RAISE ERROR_SIN_PRECIO;
                
           END IF;
           
           
           OPEN LC_CURSORDATOS FOR LV_sSql; 
                
            LOOP
    
                FETCH LC_CURSORDATOS
                INTO LN_COD_CONCEPTOART, LV_DES_ARTICULO, LN_PRC_DEDUCIBLE, LV_COD_MONEDA, LV_DES_MONEDA, 
                     LV_VAL_MINIMO, LV_VAL_MAXIMO, LV_IND_AUTO_MAN, LV_NUM_UNIDADES, LN_IND_EQUIPO,
                     LN_IND_PAQUETE, LN_MES_GARANTIA, LN_IND_ACCESORIO, LN_COD_ARTICULO, LN_COD_STOCK,
                     LN_COD_ESTADO;
                
                EXIT WHEN LC_CURSORDATOS%NOTFOUND;
                
                LV_sSql := ' SELECT  COUNT(1) FROM GA_SEGUROABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO ';
            
                SELECT  COUNT(1)
                INTO LN_CANTIDAD 
                FROM GA_SEGUROABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO; 
                
                
                IF LN_CANTIDAD > 0 THEN
                
                    LV_sSql := ' PV_List_cargos_Seguros_PR ( ' || EN_NUM_ABONADO || ', ' ||
                                                                  EV_NUM_SERIE || ', ' ||
                                                                  LV_COD_MONEDA || ', ' ||
                                                                  EV_NOMBRE_USUARIO || ', ' ||
                                                                  LN_PRC_DEDUCIBLE || ')';
                                                           
                           
                    PV_List_cargos_Seguros_PR (EN_NUM_ABONADO,
                                               EV_NUM_SERIE,
                                               LV_COD_MONEDA,
                                               EV_NOMBRE_USUARIO,
                                               LN_PRC_DEDUCIBLE,
                                               LN_CARGO,
                                               SN_cod_retorno,
                                               SV_mens_retorno,
                                               SN_num_evento);
                                           
                    IF SN_cod_retorno <> 0 THEN
                    
                        RAISE ERROR_PRC_EXT;
                        
                    END IF;                                           
                                           
                    LN_PRC_DEDUCIBLE := LN_CARGO;
                
                END IF;
                
                OT_CARGOEQUIPO.extend;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last) := PV_CARGO_EQUIPO_QT(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
                    
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_CONCEPTOART:=LN_COD_CONCEPTOART;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_ARTICULO:=LV_DES_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).PRC_DEDUCIBLE:=LN_PRC_DEDUCIBLE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_MONEDA:=LV_COD_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_MONEDA:=LV_DES_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MINIMO:=LV_VAL_MINIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MAXIMO:=LV_VAL_MAXIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_AUTO_MAN:=LV_IND_AUTO_MAN;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).NUM_UNIDADES:=LV_NUM_UNIDADES;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_EQUIPO:=LN_IND_EQUIPO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_PAQUETE:=LN_IND_PAQUETE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).MES_GARANTIA:=LN_MES_GARANTIA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_ACCESORIO:=LN_IND_ACCESORIO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ARTICULO:=LN_COD_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_STOCK:=LN_COD_STOCK;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ESTADO:=LN_COD_ESTADO;
                    
            END LOOP;
            
            OPEN SC_cursordatos FOR
             SELECT COD_CONCEPTOART,
                    DES_ARTICULO,
                    PRC_DEDUCIBLE,
                    COD_MONEDA,
                    DES_MONEDA,
                    VAL_MINIMO,
                    VAL_MAXIMO,
                    IND_AUTO_MAN,
                    NUM_UNIDADES,
                    IND_EQUIPO,
                    IND_PAQUETE,
                    MES_GARANTIA,
                    IND_ACCESORIO,
                    COD_ARTICULO,
                    COD_STOCK,
                    COD_ESTADO
             FROM   TABLE (CAST (OT_CARGOEQUIPO AS PV_LISTACARGOEQUIPO_OT)) a;

EXCEPTION
    WHEN ERROR_PRC_EXT THEN
    
        NULL;
            
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_PrecTerRen_NoPreLis_Rest_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_PrecTerRen_NoPreLis_Rest_PR', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_PrecTerRen_NoPreLis_Rest_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_PrecTerRen_NoPreLis_Rest_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||')', LV_sSql, SQLCODE, LV_des_error );
          
END PV_PrecTerRen_NoPreLis_Rest_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE pv_precarterm_noprelis_Rest_PR (EN_TIP_STOCK         IN AL_PRECIOS_VENTA.TIP_STOCK%TYPE,
                                          EN_COD_ARTICULO      IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EV_NUM_SERIE         IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_COD_USO           IN AL_PRECIOS_VENTA.COD_USO%TYPE, 
                                          EN_COD_ESTADO        IN AL_PRECIOS_VENTA.COD_ESTADO%TYPE,
                                          EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,    
                                          EN_COD_ANTIGUEDAD    IN AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE,   
                                          EN_COD_MODVENTA      IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          EN_NUM_MESES         IN AL_PRECIOS_VENTA.NUM_MESES%TYPE,
                                          EV_NOMBRE_USUARIO    IN VARCHAR2,
					                      SC_cursordatos	   OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
                                       
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "pv_precarterm_noprelis_Rest_pr"
				Lenguaje="PL/SQL"
				Fecha="14-04-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Obtiene los precios lista para restitucion
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"> Numero de Abonado</param>
                  <param nom="EV_NUM_SERIE" Tipo="VARCHAR2">numero de serie nueva</param>
                  <param nom="EN_COD_USO" Tipo="NUMBER">nombre de usuario</param>
                  <param nom="EN_COD_ESTADO" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EV_COD_CALIFICACION" Tipo="VARCHAR2"> Numero de Abonado</param>
                  <param nom="EN_NUM_ABONADO" Tipo="NUMBER">numero de serie nueva</param>
                  <param nom="EN_COD_CLIENTE" Tipo="NUMBER">nombre de usuario</param>
                  <param nom="EN_COD_ANTIGUEDAD" Tipo="NUMERIC">Codigo de articulo</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"> Numero de Abonado</param>
                  <param nom="EN_NUM_MESES" Tipo="NUMBER">numero de serie nueva</param>
                  <param nom="EV_NOMBRE_USUARIO" Tipo="VARCHAR2">nombre de usuario</param>   
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios lista con seguro si es que aplica </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LN_CANTIDAD_CARGOS   NUMBER;    
        LV_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_COD_PRODUCTO      AL_ARTICULOS.COD_PRODUCTO%TYPE;   
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LN_COD_PROMEDIO      AL_PROMFACT.COD_PROMEDIO%TYPE;
        LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_CALIFICACION  GA_DATABONADO_TO.COD_CALIFICACION%TYPE;
        LV_APLICA_CAL_ABO    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_CAL_DEFAULT_PRC   GED_PARAMETROS.VAL_PARAMETRO%TYPE;        
        LN_COD_CONCEPTOART   NUMBER;
        LV_DES_ARTICULO      VARCHAR2(40);
        LN_PRC_DEDUCIBLE     NUMBER(14,4);
        LV_COD_MONEDA        VARCHAR2(3);
        LV_DES_MONEDA        VARCHAR2(20);
        LV_VAL_MINIMO        VARCHAR2(2);
        LV_VAL_MAXIMO        VARCHAR2(2);
        LV_IND_AUTO_MAN      VARCHAR(2);
        LV_NUM_UNIDADES      VARCHAR(2);
        LN_IND_EQUIPO        NUMBER;
        LN_IND_PAQUETE       NUMBER;
        LN_MES_GARANTIA      NUMBER;
        LN_IND_ACCESORIO     NUMBER;
        LN_COD_ARTICULO      NUMBER;
        LN_COD_STOCK         NUMBER;
        LN_COD_ESTADO        NUMBER;
        LN_CANTIDAD          NUMBER;
        LN_CARGO    	     NUMBER;
        
        LN_CANT_CARG_1       NUMBER;
        LN_CANT_CARG_2       NUMBER;
        LV_CANT_sSql         ge_errores_pg.vQuery;
        
        OT_CARGOEQUIPO       PV_LISTACARGOEQUIPO_OT:=PV_LISTACARGOEQUIPO_OT();
        LC_CURSORDATOS	     REFCURSOR;
        
        ERROR_SIN_PRECIO     EXCEPTION;
        ERROR_PRC_EXT        EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
            
            LN_CANT_CARG_1 := 0;
            LN_CANT_CARG_2 := 0;
			
            LV_sSql := ' SELECT COD_PRODUCTO ' ||
                       ' FROM AL_ARTICULOS ' ||
                       ' WHERE COD_ARTICULO = ' || EN_COD_ARTICULO;
   
            SELECT COD_PRODUCTO
            INTO LN_COD_PRODUCTO
            FROM AL_ARTICULOS
            WHERE COD_ARTICULO = EN_COD_ARTICULO;
    
            LV_sSql := ' SELECT COD_PLANTARIF ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT COD_PLANTARIF
            INTO LV_COD_PLANTARIF
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            LV_sSql := ' SELECT cod_cliente ' ||
                       ' FROM GA_ABOCEL ' ||
                       ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
            
            SELECT cod_cliente
            INTO LN_COD_CLIENTE
            FROM GA_ABOCEL
            WHERE NUM_ABONADO = EN_NUM_ABONADO;

            BEGIN            
            
                LV_sSql := ' SELECT trim(VAL_PARAMETRO) ' ||
                           ' FROM GED_PARAMETROS  ' ||
                           ' WHERE  NOM_PARAMETRO = ''APLICA_CAL_ABO'' AND COD_MODULO = ''GA''';

                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_APLICA_CAL_ABO
                FROM GED_PARAMETROS
                WHERE  NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                LV_APLICA_CAL_ABO := '';
                    
            END; 
            
            IF (TRIM(LV_APLICA_CAL_ABO) = 'TRUE') THEN
            
                LV_sSql := ' SELECT TRIM(VAL_PARAMETRO) ' || 
                           ' FROM GED_PARAMETROS ' ||
                           ' WHERE  NOM_PARAMETRO = ''CAL_DEFAULT_PRC'' AND COD_MODULO = ''GA''';

                SELECT TRIM(VAL_PARAMETRO)
                INTO LV_CAL_DEFAULT_PRC 
                FROM GED_PARAMETROS 
                WHERE  NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';
                
                LV_sSql := ' SELECT NVL(COD_CALIFICACION, ' || LV_CAL_DEFAULT_PRC || ' ) ' ||
                           ' FROM GA_DATABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
                           
                SELECT NVL(COD_CALIFICACION, LV_CAL_DEFAULT_PRC)
                INTO LV_COD_CALIFICACION
                FROM GA_DATABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO;
                                     
                IF ((LV_COD_CALIFICACION IS NOT NULL) AND (LENGTH(TRIM(LV_COD_CALIFICACION))>0)) THEN
                
                    LV_COD_CALIFICACION := LV_COD_CALIFICACION;
                
                ELSE

                    LV_COD_CALIFICACION := LV_CAL_DEFAULT_PRC;
                
                END IF;
                
            ELSE
                    
                LV_sSql := ' SELECT COD_CALIFICACION ' ||
                           ' FROM GE_CLIENTES ' ||
                           ' WHERE COD_CLIENTE = ' || LN_COD_CLIENTE;
                           
                SELECT COD_CALIFICACION 
                INTO LV_COD_CALIFICACION
                FROM GE_CLIENTES
                WHERE COD_CLIENTE = LN_COD_CLIENTE;
                
            END IF;                  
            
            LV_sSql := ' SELECT COD_CATEGORIA ' ||
                       ' FROM VE_CATPLANTARIF ' ||
                       ' WHERE COD_PRODUCTO = ' || LN_COD_PRODUCTO || 
                       ' AND COD_PLANTARIF = ' || LV_COD_PLANTARIF;
            
            SELECT COD_CATEGORIA
            INTO LV_COD_CATEGORIA
            FROM VE_CATPLANTARIF
            WHERE COD_PRODUCTO = LN_COD_PRODUCTO 
            AND COD_PLANTARIF = LV_COD_PLANTARIF;
   
            LV_sSql := ' SELECT A.COD_PROMEDIO FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL ' ||
                       '                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,''MM'')) CUENTA ' ||
                       '                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                                                     AND COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                                                   ) V ' ||
                       '                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) ' ||
                       '                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) ' ||
                       '                            AND     U.COD_CLIENTE = ' || LN_COD_CLIENTE ||
                       '                         )B ' ||
                       ' WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA ';

            BEGIN
            
                SELECT A.COD_PROMEDIO 
                INTO LN_COD_PROMEDIO
                FROM AL_PROMFACT A,( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL 
                                             FROM FA_HISTDOCU U,  ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,'MM')) CUENTA
                                                                    FROM    FA_HISTDOCU WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                                                    AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                                                     AND COD_CLIENTE = LN_COD_CLIENTE
                                                                   ) V 
                                            WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                            AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                            AND     U.COD_CLIENTE = LN_COD_CLIENTE
                                         )B
                WHERE B.TOTAL BETWEEN  FACT_DESDE  AND FACT_HASTA;
            
            EXCEPTION
                    
                WHEN NO_DATA_FOUND THEN
                    
                    LV_sSql := ' SELECT MAX(A.COD_PROMEDIO) FROM AL_PROMFACT A ';
                    
                    SELECT MAX(A.COD_PROMEDIO)
                    INTO LN_COD_PROMEDIO 
                    FROM AL_PROMFACT A;    
                    
            END; 

            LV_sSql := ' (SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA, C.DES_MONEDA, ' ||
                       ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0), ''A'', ''1'',''1'',''0'',B.MES_GARANTIA ' ||
                       ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C, ' ||
                       ' (SELECT W.COD_CATEGORIA CATEGORIA FROM GA_ABOCEL U, VE_CATPLANTARIF V, VE_CATEGORIAS W ' ||
                       ' WHERE U.COD_PLANTARIF = V.COD_PLANTARIF ' ||
                       ' AND V.COD_CATEGORIA = W.COD_CATEGORIA ' ||
                       ' AND U.NUM_ABONADO= ' || EN_NUM_ABONADO || ' ) Z, ' ||
                       ' (SELECT V.NUM_MESES MESES FROM GA_ABOCEL U,GA_PERCONTRATO V ' ||
                       ' WHERE V.COD_PRODUCTO > 0 ' ||
                       ' AND U.COD_TIPCONTRATO = V.COD_TIPCONTRATO ' ||
                       ' AND U.NUM_ABONADO = ' || EN_NUM_ABONADO || ' ) XY ' ||
                       ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                       ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                       ' AND A.COD_USO = ' || EN_COD_USO ||
                       ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                       ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                       ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                       ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                       ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                       ' AND A.IND_RECAMBIO = 0 ' ||
                       ' AND A.NUM_MESES = XY.MESES ' ||
                       ' AND A.COD_CATEGORIA = Z.CATEGORIA ' ||
                       ' AND A.COD_USO <> 3 ' ||
                       ' AND A.IND_RENOVA = 0 ' ||
                       ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                       ' AND B.IND_EQUIACC = ''E'' ) ' || 
                       ' UNION ' ||
                       ' (SELECT B.COD_CONCEPTOART, B.DES_ARTICULO, A.PRC_VENTA, A.COD_MONEDA, C.DES_MONEDA, ' ||
                       ' NVL(A.VAL_MINIMO,0), NVL(A.VAL_MAXIMO,0), ''A'', ''1'',''1'',''0'',B.MES_GARANTIA ' ||
                       ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                       ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                       ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                       ' AND A.COD_USO = ' || EN_COD_USO ||
                       ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                       ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                       ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                       ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                       ' AND A.IND_RECAMBIO = 9 ' ||
                       ' AND A.IND_RENOVA = 0 ' ||
                       ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                       ' AND (B.IND_EQUIACC = ''A'' OR A.COD_USO = 3)) ';                        

                           
            LV_CANT_sSql := ' (SELECT COUNT(A.PRC_VENTA)' ||
                            ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C, ' ||
                            ' (SELECT W.COD_CATEGORIA CATEGORIA FROM GA_ABOCEL U, VE_CATPLANTARIF V, VE_CATEGORIAS W ' ||
                            ' WHERE U.COD_PLANTARIF = V.COD_PLANTARIF ' ||
                            ' AND V.COD_CATEGORIA = W.COD_CATEGORIA ' ||
                            ' AND U.NUM_ABONADO= ' || EN_NUM_ABONADO || ' ) Z, ' ||
                            ' (SELECT V.NUM_MESES MESES FROM GA_ABOCEL U,GA_PERCONTRATO V ' ||
                            ' WHERE V.COD_PRODUCTO > 0 ' ||
                            ' AND U.COD_TIPCONTRATO = V.COD_TIPCONTRATO ' ||
                            ' AND U.NUM_ABONADO = ' || EN_NUM_ABONADO || ' ) XY ' ||
                            ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                            ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                            ' AND A.COD_USO = ' || EN_COD_USO ||
                            ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                            ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA ||
                            ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                            ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                            ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                            ' AND A.IND_RECAMBIO = 0 ' ||
                            ' AND A.NUM_MESES = XY.MESES ' ||
                            ' AND A.COD_CATEGORIA = Z.CATEGORIA ' ||
                            ' AND A.COD_USO <> 3 ' ||
                            ' AND A.IND_RENOVA = 0 ' ||
                            ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                            ' AND B.IND_EQUIACC = ''E'' ) ';
                                
            EXECUTE IMMEDIATE LV_CANT_sSql INTO LN_CANT_CARG_1;                                
                                
            LV_CANT_sSql := ' (SELECT COUNT(A.PRC_VENTA) ' ||
                            ' FROM AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ' ||
                            ' WHERE A.TIP_STOCK = ' || EN_TIP_STOCK ||
                            ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO ||
                            ' AND A.COD_USO = ' || EN_COD_USO ||
                            ' AND A.COD_ESTADO = ' || EN_COD_ESTADO ||
                            ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE) ' ||
                            ' AND B.COD_ARTICULO = A.COD_ARTICULO ' ||
                            ' AND C.COD_MONEDA = A.COD_MONEDA ' ||
                            ' AND A.IND_RECAMBIO = 9 ' ||
                            ' AND A.IND_RENOVA = 0 ' ||
                            ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''' ||
                            ' AND (B.IND_EQUIACC = ''A'' OR A.COD_USO = 3)) ';                           
            
           EXECUTE IMMEDIATE LV_CANT_sSql INTO LN_CANT_CARG_2;
                
           IF (LN_CANT_CARG_1 + LN_CANT_CARG_2) = 0 THEN
           
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado: ';
                SV_mens_retorno := SV_mens_retorno || '|Producto....................: ' || LN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Articulo................: ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || '|Num.Serie...................: ' || EV_NUM_SERIE;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Uso.....................: ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || '|Tip.Stock...................: ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Categoria...............: ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Antigüedad..............: ' || EN_COD_ANTIGUEDAD;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Estado..................: ' || EN_COD_ESTADO;
                SV_mens_retorno := SV_mens_retorno || '|Modalidad venta.............: ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || '|Meses Prorroga..............: ' || EN_NUM_MESES;
                SV_mens_retorno := SV_mens_retorno || '|Cod.Promedio Facturado......: ' || LN_COD_PROMEDIO;
                SV_mens_retorno := SV_mens_retorno || '|FAVOR INFORMAR A LA MESA DE AYUDA .....';
                
                RAISE ERROR_SIN_PRECIO;
                
           END IF;
           
           
           OPEN LC_CURSORDATOS FOR LV_sSql; 
                
            LOOP
    
                FETCH LC_CURSORDATOS
                INTO LN_COD_CONCEPTOART, LV_DES_ARTICULO, LN_PRC_DEDUCIBLE, LV_COD_MONEDA, LV_DES_MONEDA, 
                     LV_VAL_MINIMO, LV_VAL_MAXIMO, LV_IND_AUTO_MAN, LV_NUM_UNIDADES, LN_IND_EQUIPO,
                     LN_IND_PAQUETE, LN_MES_GARANTIA, LN_IND_ACCESORIO, LN_COD_ARTICULO, LN_COD_STOCK,
                     LN_COD_ESTADO;
                
                EXIT WHEN LC_CURSORDATOS%NOTFOUND;
                
                LV_sSql := ' SELECT  COUNT(1) FROM GA_SEGUROABONADO_TO ' ||
                           ' WHERE NUM_ABONADO = ' || EN_NUM_ABONADO ||
                           ' AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO ';
            
                SELECT  COUNT(1)
                INTO LN_CANTIDAD 
                FROM GA_SEGUROABONADO_TO
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND SYSDATE BETWEEN FEC_ALTA AND FEC_FINCONTRATO; 
                
                
                IF LN_CANTIDAD > 0 THEN
                
                    LV_sSql := ' PV_List_cargos_Seguros_PR ( ' || EN_NUM_ABONADO || ', ' ||
                                                                  EV_NUM_SERIE || ', ' ||
                                                                  LV_COD_MONEDA || ', ' ||
                                                                  EV_NOMBRE_USUARIO || ', ' ||
                                                                  LN_PRC_DEDUCIBLE || ')';
                                                           
                           
                    PV_List_cargos_Seguros_PR (EN_NUM_ABONADO,
                                               EV_NUM_SERIE,
                                               LV_COD_MONEDA,
                                               EV_NOMBRE_USUARIO,
                                               LN_PRC_DEDUCIBLE,
                                               LN_CARGO,
                                               SN_cod_retorno,
                                               SV_mens_retorno,
                                               SN_num_evento);
                                           
                    IF SN_cod_retorno <> 0 THEN
                    
                        RAISE ERROR_PRC_EXT;
                        
                    END IF;                                           
                                           
                    LN_PRC_DEDUCIBLE := LN_CARGO;
                
                END IF;
                
                OT_CARGOEQUIPO.extend;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last) := PV_CARGO_EQUIPO_QT(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
                    
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_CONCEPTOART:=LN_COD_CONCEPTOART;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_ARTICULO:=LV_DES_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).PRC_DEDUCIBLE:=LN_PRC_DEDUCIBLE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_MONEDA:=LV_COD_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).DES_MONEDA:=LV_DES_MONEDA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MINIMO:=LV_VAL_MINIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).VAL_MAXIMO:=LV_VAL_MAXIMO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_AUTO_MAN:=LV_IND_AUTO_MAN;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).NUM_UNIDADES:=LV_NUM_UNIDADES;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_EQUIPO:=LN_IND_EQUIPO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_PAQUETE:=LN_IND_PAQUETE;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).MES_GARANTIA:=LN_MES_GARANTIA;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).IND_ACCESORIO:=LN_IND_ACCESORIO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ARTICULO:=LN_COD_ARTICULO;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_STOCK:=LN_COD_STOCK;
                OT_CARGOEQUIPO(OT_CARGOEQUIPO.last).COD_ESTADO:=LN_COD_ESTADO;
                    
            END LOOP;
            
            OPEN SC_cursordatos FOR
             SELECT COD_CONCEPTOART,
                    DES_ARTICULO,
                    PRC_DEDUCIBLE,
                    COD_MONEDA,
                    DES_MONEDA,
                    VAL_MINIMO,
                    VAL_MAXIMO,
                    IND_AUTO_MAN,
                    NUM_UNIDADES,
                    IND_EQUIPO,
                    IND_PAQUETE,
                    MES_GARANTIA,
                    IND_ACCESORIO,
                    COD_ARTICULO,
                    COD_STOCK,
                    COD_ESTADO
             FROM   TABLE (CAST (OT_CARGOEQUIPO AS PV_LISTACARGOEQUIPO_OT)) a;

EXCEPTION
    WHEN ERROR_PRC_EXT THEN
    
        NULL;
            
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.pv_precarterm_noprelis_Rest_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.pv_precarterm_noprelis_Rest_PR', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.pv_precarterm_noprelis_Rest_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.pv_precarterm_noprelis_Rest_PR('||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EV_NUM_SERIE||','||EN_COD_USO||','||EN_COD_ESTADO||','||EN_NUM_ABONADO||','||EN_COD_ANTIGUEDAD||','||EN_COD_MODVENTA||','||EN_NUM_MESES||','||EV_NOMBRE_USUARIO||')', LV_sSql, SQLCODE, LV_des_error );
          
END pv_precarterm_noprelis_Rest_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_PrecCargoSim_PreLis_Rest_PR ( EN_NUM_ABONADO     IN GE_CARGOS.NUM_ABONADO%TYPE,
                                           EN_TIP_STOCK       IN AL_SERIES.TIP_STOCK%TYPE,  
                                           EN_COD_USO         IN AL_SERIES.COD_USO%TYPE,
                                           EN_COD_ESTADO      IN AL_SERIES.COD_ESTADO%TYPE, 
                                           EN_COD_ARTICULO    IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                           EN_COD_MODVENTA    IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                           SC_cursordatos     OUT NOCOPY REFCURSOR,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) 
IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_PrecCargoSim_PreLis_Rest_PR"
                Lenguaje="PL/SQL"
                Fecha="15-04-2011"
                Version="1.0.0"
                Disenador="Paul Barria"
                Programador="Paul Barria"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Obtiene los cargos para articulo Simcard 
            </Descripcion>
            <Parametros>
            <Entrada>
                  <param nom="EV_IND_COMODATO" Tipo="VARCHAR2">Indicador de si es comodato o no</param>
                  <param nom="EV_cod_producto" Tipo="VARCHAR2"> codigo producto</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"></param>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_USO" Tipo="NUMERIC"></param>
                  <param nom="EN_NUM_MESES" Tipo="NUMERIC"></param>
                  <param nom="EV_COD_PLANTARIF" Tipo="VARCHAR2"></param>
                  <param nom="EV_COD_ANTIGUEDAD" Tipo="VARCHAR2"></param>
            </Entrada>
            <Salida>
                <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por Habilitacion </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
                   
        LV_des_error         ge_errores_pg.DesEvent;
        LV_sSql              ge_errores_pg.vQuery;
        LV_sSql_cab          ge_errores_pg.vQuery;
        LV_sSql_det          ge_errores_pg.vQuery;
        LV_sSql_cont         ge_errores_pg.vQuery;
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LV_COD_CALIFICACION  AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LV_CALIF_PRC         AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LV_CAL_DEF_PRC       AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LN_PROMEDIOFACT      AL_PRECIOS_VENTA.COD_PROMEDIO%TYPE;
        LN_COD_PRODUCTO      AL_ARTICULOS.COD_PRODUCTO%TYPE;
        LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
        LV_CAL_ABO           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        
        LN_AUX_CAL_ABO       NUMBER;
        LN_CANT_CARGOS       NUMBER;
        LV_AUX_PRCANTI       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_AUX_PRC_LISTA     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        ERROR_SIN_PRECIO     EXCEPTION;

        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
             
            LV_sSql := ' SELECT COD_PRODUCTO ' || 
                       ' FROM AL_ARTICULOS ' || 
                       ' WHERE COD_ARTICULO = ' || EN_COD_ARTICULO;
                   
            SELECT COD_PRODUCTO 
            INTO LN_COD_PRODUCTO
            FROM AL_ARTICULOS 
            WHERE COD_ARTICULO = EN_COD_ARTICULO;                   
        
            LV_sSql := 'SELECT cod_plantarif,cod_cliente
                        FROM GA_ABOCEL
                       WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
          
            SELECT cod_plantarif,cod_cliente
              INTO LV_COD_PLANTARIF, LN_COD_CLIENTE
              FROM GA_ABOCEL
             WHERE NUM_ABONADO = EN_NUM_ABONADO;
          
          -- Obtiene Promedio mensual de facturación
          
            SELECT   A.COD_PROMEDIO INTO LN_PROMEDIOFACT
              FROM   AL_PROMFACT A,
                     (SELECT   ROUND (NVL (SUM (U.TOT_FACTURA) / MAX (V.CUENTA), 0))
                                  TOTAL
                        FROM   FA_HISTDOCU U,
                               (SELECT   COUNT (DISTINCT TO_CHAR (FEC_EMISION, 'MM'))
                                            CUENTA
                                  FROM   FA_HISTDOCU
                                 WHERE       COD_TIPDOCUM IN (SELECT   COD_TIPDOCUMMOV
                                                                FROM   FA_TIPDOCUMEN
                                                               WHERE   IND_CICLO = '1')
                                         AND FEC_EMISION > ADD_MONTHS (SYSDATE, -6)
                                         AND COD_CLIENTE = LN_COD_CLIENTE) V
                       WHERE       U.COD_TIPDOCUM IN (SELECT   COD_TIPDOCUMMOV
                                                        FROM   FA_TIPDOCUMEN
                                                       WHERE   IND_CICLO = 1)
                               AND U.FEC_EMISION > ADD_MONTHS (SYSDATE, -6)
                               AND U.COD_CLIENTE = LN_COD_CLIENTE) B
             WHERE   B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA;
          
          -- Se valida si es necesario realizar calculo de abonado 
            SELECT   count (*) INTO LN_AUX_CAL_ABO
              FROM   GED_PARAMETROS
             WHERE   NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
            
          IF LN_AUX_CAL_ABO <> 0 THEN
            SELECT   UPPER(TRIM (VAL_PARAMETRO)) INTO  LV_CAL_ABO
              FROM   GED_PARAMETROS
             WHERE   NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
          END IF;
          
          IF LV_CAL_ABO = 'TRUE' THEN
          
                SELECT   TRIM (VAL_PARAMETRO) INTO LV_CAL_DEF_PRC
                  FROM   GED_PARAMETROS
                 WHERE   NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';

                SELECT   NVL (COD_CALIFICACION, LV_CAL_DEF_PRC) INTO LV_CALIF_PRC
                  FROM   GA_DATABONADO_TO
                 WHERE   NUM_ABONADO = EN_NUM_ABONADO
                   AND   ROWNUM < 2;
                   
                       IF LV_CALIF_PRC <> NULL THEN
                         
                             LV_COD_CALIFICACION := LV_CALIF_PRC;
                       ELSE
                             LV_COD_CALIFICACION := LV_CAL_DEF_PRC;
                       END IF;
          ELSE
                SELECT   COD_CALIFICACION INTO LV_COD_CALIFICACION
                  FROM   GE_CLIENTES
                 WHERE   COD_CLIENTE = LN_COD_CLIENTE;
          END IF;
          
          LV_sSql :=  'SELECT   COD_CATEGORIA INTO LV_COD_CATEGORIA
                         FROM   VE_CATPLANTARIF
                        WHERE   COD_PRODUCTO = ' || LN_COD_PRODUCTO  || ' AND COD_PLANTARIF = '|| LV_COD_PLANTARIF;
          
          SELECT   COD_CATEGORIA INTO LV_COD_CATEGORIA
              FROM   VE_CATPLANTARIF
             WHERE   COD_PRODUCTO = LN_COD_PRODUCTO AND COD_PLANTARIF = LV_COD_PLANTARIF;
          
          
          LV_sSql_cab :=  'SELECT ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.COD_CONCEPTOART, ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.DES_ARTICULO, ';
          LV_sSql_cab :=  LV_sSql_cab || 'A.PRC_VENTA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'A.COD_MONEDA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'C.DES_MONEDA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'NVL(A.val_minimo,0), ';
          LV_sSql_cab :=  LV_sSql_cab || 'NVL(A.val_maximo,0), ';
          LV_sSql_cab :=  LV_sSql_cab || '''A'', '; 
          LV_sSql_cab :=  LV_sSql_cab || '''1'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''1'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.MES_GARANTIA, ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'' ';
                 
          LV_sSql_det:=   ' FROM   AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C';
          LV_sSql_det:=   LV_sSql_det || ' WHERE    A.TIP_STOCK = ' || EN_TIP_STOCK; 
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_USO = ' || EN_COD_USO;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_ESTADO = ' || EN_COD_ESTADO;
          LV_sSql_det:=   LV_sSql_det || ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL (A.FEC_HASTA, SYSDATE)';
          LV_sSql_det:=   LV_sSql_det || ' AND B.COD_ARTICULO = A.COD_ARTICULO';
          LV_sSql_det:=   LV_sSql_det || ' AND C.COD_MONEDA = A.COD_MONEDA';
          LV_sSql_det:=   LV_sSql_det || ' AND A.IND_RECAMBIO = 9';
          LV_sSql_det:=   LV_sSql_det || ' AND A.IND_RENOVA = 0';
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_CALIFICACION = ' || LV_COD_CALIFICACION || ';';
           
           
           LV_sSql_cont := 'SELECT COUNT(A.PRC_VENTA)' ;
           
           LV_sSql := LV_sSql_cont || LV_sSql_det; 
           
           EXECUTE IMMEDIATE LV_sSql INTO LN_CANT_CARGOS;
                      
            IF LN_CANT_CARGOS = 0 THEN
            
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado: ';
                SV_mens_retorno := SV_mens_retorno || 'Producto....................: ' || LN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Articulo................: ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Uso.....................: ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || 'Tip.Stock...................: ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Categoria...............: ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Estado..................: ' || EN_COD_ESTADO;
                SV_mens_retorno := SV_mens_retorno || 'Modalidad venta.............: ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Promedio Facturado......: ' || LN_PROMEDIOFACT;
                SV_mens_retorno := SV_mens_retorno || 'FAVOR INFORMAR A LA MESA DE AYUDA .....';
                                                                                    
                RAISE ERROR_SIN_PRECIO;
                    
            END IF;                                 

            LV_sSql := LV_sSql_cab || LV_sSql_det; 
            
            OPEN SC_cursordatos FOR    LV_sSql;

EXCEPTION
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
             LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.VE_PrecCargoSim_PreLis_Rest_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.VE_PrecCargoSim_PreLis_Rest_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.VE_PrecCargoSim_PreLis_Rest_PR('||EN_NUM_ABONADO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.VE_PrecCargoSim_PreLis_Rest_PR('||EN_NUM_ABONADO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||')', LV_sSql, SQLCODE, LV_des_error );
END VE_PrecCargoSim_PreLis_Rest_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PreCarSim_NoPreLis_Rest_PR ( EN_NUM_ABONADO     IN GE_CARGOS.NUM_ABONADO%TYPE,
                                          --EN_COD_PRODUCTO    IN GA_ACTUASERV.COD_PRODUCTO%TYPE,
                                          --EN_COD_ACTABO      IN GA_ACTABO.COD_ACTABO%TYPE, 
                                          --EN_COD_PLANSERV    IN GA_TARIFAS.COD_PLANSERV%TYPE,
                                          --EN_COD_PLANCOM     IN GE_CARGOS.COD_PLANCOM%TYPE,
                                          --EV_NUM_SERIE       IN AL_SERIES.NUM_SERIE%TYPE,
                                          EN_TIP_STOCK       IN AL_SERIES.TIP_STOCK%TYPE,  
                                          EN_COD_USO         IN AL_SERIES.COD_USO%TYPE,
                                          EN_COD_ESTADO      IN AL_SERIES.COD_ESTADO%TYPE, 
                                          EN_COD_ARTICULO    IN AL_PRECIOS_VENTA.COD_ARTICULO%TYPE,
                                          EN_COD_MODVENTA    IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                          SC_cursordatos     OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) 
IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "PV_PreCarSim_NoPreLis_Rest_PR"
                Lenguaje="PL/SQL"
                Fecha="15-04-2011"
                Version="1.0.0"
                Disenador="Paul Barria"
                Programador="Paul Barria"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Obtiene los cargos para articulo Simcard 
            </Descripcion>
            <Parametros>
            <Entrada>
                  <param nom="EV_IND_COMODATO" Tipo="VARCHAR2">Indicador de si es comodato o no</param>
                  <param nom="EV_cod_producto" Tipo="VARCHAR2"> codigo producto</param>
                  <param nom="EN_COD_MODVENTA" Tipo="NUMERIC"></param>
                  <param nom="EN_TIP_STOCK" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_ARTICULO" Tipo="NUMERIC"></param>
                  <param nom="EN_COD_USO" Tipo="NUMERIC"></param>
                  <param nom="EN_NUM_MESES" Tipo="NUMERIC"></param>
                  <param nom="EV_COD_PLANTARIF" Tipo="VARCHAR2"></param>
                  <param nom="EV_COD_ANTIGUEDAD" Tipo="VARCHAR2"></param>
            </Entrada>
            <Salida>
                <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por Habilitacion </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
                   
        LV_des_error         ge_errores_pg.DesEvent;
        LV_sSql              ge_errores_pg.vQuery;
        LV_sSql_cab          ge_errores_pg.vQuery;
        LV_sSql_det          ge_errores_pg.vQuery;
        LV_sSql_cont         ge_errores_pg.vQuery;
        LV_COD_CATEGORIA     VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
        LV_COD_CALIFICACION  AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LV_CALIF_PRC         AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LV_CAL_DEF_PRC       AL_PRECIOS_VENTA.COD_CALIFICACION%TYPE;
        LN_PROMEDIOFACT      AL_PRECIOS_VENTA.COD_PROMEDIO%TYPE;
        LN_COD_PRODUCTO      AL_ARTICULOS.COD_PRODUCTO%TYPE;
        LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_PLANTARIF     GA_ABOCEL.COD_PLANTARIF%TYPE;
        LV_CAL_ABO           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        
        LN_AUX_CAL_ABO       NUMBER;
        LN_CANT_CARGOS       NUMBER;
        LV_AUX_PRCANTI       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_AUX_PRC_LISTA     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        ERROR_SIN_PRECIO     EXCEPTION;

        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
             
           
          LV_sSql := 'SELECT cod_plantarif,cod_cliente
                        FROM GA_ABOCEL
                       WHERE NUM_ABONADO = ' || EN_NUM_ABONADO;
          
            SELECT cod_plantarif,cod_cliente
              INTO LV_COD_PLANTARIF, LN_COD_CLIENTE
              FROM GA_ABOCEL
             WHERE NUM_ABONADO = EN_NUM_ABONADO;
          
          -- Obtiene Promedio mensual de facturación
          
            SELECT   A.COD_PROMEDIO INTO LN_PROMEDIOFACT
              FROM   AL_PROMFACT A,
                     (SELECT   ROUND (NVL (SUM (U.TOT_FACTURA) / MAX (V.CUENTA), 0))
                                  TOTAL
                        FROM   FA_HISTDOCU U,
                               (SELECT   COUNT (DISTINCT TO_CHAR (FEC_EMISION, 'MM'))
                                            CUENTA
                                  FROM   FA_HISTDOCU
                                 WHERE       COD_TIPDOCUM IN (SELECT   COD_TIPDOCUMMOV
                                                                FROM   FA_TIPDOCUMEN
                                                               WHERE   IND_CICLO = '1')
                                         AND FEC_EMISION > ADD_MONTHS (SYSDATE, -6)
                                         AND COD_CLIENTE = LN_COD_CLIENTE) V
                       WHERE       U.COD_TIPDOCUM IN (SELECT   COD_TIPDOCUMMOV
                                                        FROM   FA_TIPDOCUMEN
                                                       WHERE   IND_CICLO = 1)
                               AND U.FEC_EMISION > ADD_MONTHS (SYSDATE, -6)
                               AND U.COD_CLIENTE = LN_COD_CLIENTE) B
             WHERE   B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA;
          
            LV_sSql := 'SELECT   COD_PRODUCTO
                          INTO   LN_COD_PRODUCTO
                          FROM   AL_ARTICULOS
                         WHERE   COD_ARTICULO = ' || EN_COD_ARTICULO;
            
            SELECT   COD_PRODUCTO
              INTO   LN_COD_PRODUCTO
              FROM   AL_ARTICULOS
             WHERE   COD_ARTICULO = EN_COD_ARTICULO;  
          
          -- Se valida si es necesario realizar calculo de abonado 
            SELECT   count (*) INTO LN_AUX_CAL_ABO
              FROM   GED_PARAMETROS
             WHERE   NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
            
          IF LN_AUX_CAL_ABO <> 0 THEN
            SELECT   UPPER(TRIM (VAL_PARAMETRO)) INTO  LV_CAL_ABO
              FROM   GED_PARAMETROS
             WHERE   NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
          END IF;
          
          IF LV_CAL_ABO = 'TRUE' THEN
          
                SELECT   TRIM (VAL_PARAMETRO) INTO LV_CAL_DEF_PRC
                  FROM   GED_PARAMETROS
                 WHERE   NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';

                SELECT   NVL (COD_CALIFICACION, LV_CAL_DEF_PRC) INTO LV_CALIF_PRC
                  FROM   GA_DATABONADO_TO
                 WHERE   NUM_ABONADO = EN_NUM_ABONADO
                   AND   ROWNUM < 2;
                   
                       IF LV_CALIF_PRC <> NULL THEN
                         
                             LV_COD_CALIFICACION := LV_CALIF_PRC;
                       ELSE
                             LV_COD_CALIFICACION := LV_CAL_DEF_PRC;
                       END IF;
          ELSE
                SELECT   COD_CALIFICACION INTO LV_COD_CALIFICACION
                  FROM   GE_CLIENTES
                 WHERE   COD_CLIENTE = LN_COD_CLIENTE;
          END IF;
          
          LV_sSql :=  'SELECT   COD_CATEGORIA INTO LV_COD_CATEGORIA
                         FROM   VE_CATPLANTARIF
                        WHERE   COD_PRODUCTO = ' || LN_COD_PRODUCTO  || ' AND COD_PLANTARIF = '|| LV_COD_PLANTARIF;
          
          SELECT   COD_CATEGORIA INTO LV_COD_CATEGORIA
          FROM   VE_CATPLANTARIF
          WHERE   COD_PRODUCTO = LN_COD_PRODUCTO AND COD_PLANTARIF = LV_COD_PLANTARIF;
          
           
          LV_sSql_cab :=  'SELECT ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.COD_CONCEPTOART, ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.DES_ARTICULO, ';
          LV_sSql_cab :=  LV_sSql_cab || 'A.PRC_VENTA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'A.COD_MONEDA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'C.DES_MONEDA, ';
          LV_sSql_cab :=  LV_sSql_cab || 'NVL(A.val_minimo,0), ';
          LV_sSql_cab :=  LV_sSql_cab || 'NVL(A.val_maximo,0), ';
          LV_sSql_cab :=  LV_sSql_cab || '''A'', '; 
          LV_sSql_cab :=  LV_sSql_cab || '''1'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''1'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || 'B.MES_GARANTIA, ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'', ';
          LV_sSql_cab :=  LV_sSql_cab || '''0'' ';
                 
          LV_sSql_det:= ' FROM   AL_PRECIOS_VENTA A, AL_ARTICULOS B, GE_MONEDAS C ';
          LV_sSql_det:=   LV_sSql_det || ' WHERE       A.TIP_STOCK = ' || EN_TIP_STOCK;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_ARTICULO = ' || EN_COD_ARTICULO;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_USO = ' || EN_COD_USO;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_ESTADO = ' || EN_COD_ESTADO;
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_MODVENTA = ' || EN_COD_MODVENTA;
          LV_sSql_det:=   LV_sSql_det || ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL (A.FEC_HASTA, SYSDATE)';
          LV_sSql_det:=   LV_sSql_det || ' AND B.COD_ARTICULO = A.COD_ARTICULO';
          LV_sSql_det:=   LV_sSql_det || ' AND C.COD_MONEDA = A.COD_MONEDA';
          LV_sSql_det:=   LV_sSql_det || ' AND A.IND_RECAMBIO = 1';
          LV_sSql_det:=   LV_sSql_det || ' AND ''' || LN_PROMEDIOFACT || ''' = A.COD_PROMEDIO';
          LV_sSql_det:=   LV_sSql_det || ' AND A.NUM_MESES = 0';
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_CATEGORIA = ''' || LV_COD_CATEGORIA || '''';
          LV_sSql_det:=   LV_sSql_det || ' AND A.IND_RENOVA = 0';
          LV_sSql_det:=   LV_sSql_det || ' AND A.COD_CALIFICACION = ''' || LV_COD_CALIFICACION || '''';
          LV_sSql_det:=   LV_sSql_det || ' AND ROWNUM <= 1';
           
           
           LV_sSql_cont := 'SELECT COUNT(*)' ;
           
           LV_sSql := LV_sSql_cont || LV_sSql_det; 
           
           EXECUTE IMMEDIATE LV_sSql INTO LN_CANT_CARGOS;
                      
            IF LN_CANT_CARGOS = 0 THEN
                                                   
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado: ';
                SV_mens_retorno := SV_mens_retorno || 'Producto....................: ' || LN_COD_PRODUCTO;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Articulo................: ' || EN_COD_ARTICULO;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Uso.....................: ' || EN_COD_USO;
                SV_mens_retorno := SV_mens_retorno || 'Tip.Stock...................: ' || EN_TIP_STOCK;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Categoria...............: ' || LV_COD_CATEGORIA;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Estado..................: ' || EN_COD_ESTADO;
                SV_mens_retorno := SV_mens_retorno || 'Modalidad venta.............: ' || EN_COD_MODVENTA;
                SV_mens_retorno := SV_mens_retorno || 'Cod.Promedio Facturado......: ' || LN_PROMEDIOFACT;
                SV_mens_retorno := SV_mens_retorno || 'FAVOR INFORMAR A LA MESA DE AYUDA .....';
                                                     
                RAISE ERROR_SIN_PRECIO;
                    
            END IF;                                 

            LV_sSql := LV_sSql_cab || LV_sSql_det; 
             
            OPEN SC_cursordatos FOR    LV_sSql;

EXCEPTION
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
             LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_PreCarSim_NoPreLis_Rest_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_PreCarSim_NoPreLis_Rest_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_PreCarSim_NoPreLis_Rest_PR('||EN_NUM_ABONADO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||','||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_PreCarSim_NoPreLis_Rest_PR('||EN_NUM_ABONADO||','||EN_COD_MODVENTA||','||EN_TIP_STOCK||','||EN_COD_ARTICULO||','||EN_COD_USO||')', LV_sSql, SQLCODE, LV_des_error );
END PV_PreCarSim_NoPreLis_Rest_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_List_cargos_Dif_Garantia_PR (EN_VAL_DIFERENCIA  IN NUMBER,
					                      SC_cursordatos	 OUT NOCOPY REFCURSOR,
 					                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                 		                  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                        	              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
		    /*--
			<Documentacion TipoDoc = "Procedimiento">
				Elemento Nombre = "PV_List_cargos_Dif_Garantia_PR"
				Lenguaje="PL/SQL"
				Fecha="01-05-2011"
				Version="1.0.0"
				Dise?ador="EVERIS"
				Programador="EVERIS"
				Ambiente="BD"
			<Retorno>NA</Retorno>
			<Descripcion>
				Genera estructura de cargos para el monto final de la diferencia por garantia
			</Descripcion>
			<Parametros>
			<Entrada>
                  <param nom="EN_VAL_DIFERENCIA" Tipo="NUMBER>Monto Final por concepto Garantia</param>
			</Entrada>
			<Salida>
   			    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos por Garantia </param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
			</Salida>
			</Parametros>
			</Elemento>
			</Documentacion>
			--*/
				   
        LV_des_error         ge_errores_pg.DesEvent;
	    LV_sSql              ge_errores_pg.vQuery;
        LV_COD_CONCEPTO      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_COD_MONEDA        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LN_CANT_CARGOS       NUMBER;
        ERROR_SIN_PRECIO     EXCEPTION;

		BEGIN

			SN_num_evento:= 0;
			SN_cod_retorno:=0;
			SV_mens_retorno:='';
			 

            LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                   ' WHERE NOM_PARAMETRO = ''CONCEPTO_DIF_GARANTI''';

            SELECT VAL_PARAMETRO
            INTO LV_COD_CONCEPTO
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'CONCEPTO_DIF_GARANTI';

            LV_sSql := ' SELECT VAL_PARAMETRO FROM GED_PARAMETROS ' ||
                       ' WHERE NOM_PARAMETRO = ''COD_MONEDA_PESO''';

            SELECT VAL_PARAMETRO
            INTO LV_COD_MONEDA
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'COD_MONEDA_PESO';

            LV_sSql := ' SELECT COUNT(A.COD_CONCEPTO) ' ||
                      ' FROM FA_CONCEPTOS A, GE_MONEDAS D ' ||
                      ' WHERE ' ||
                      ' A.Cod_Concepto = ' || LV_COD_CONCEPTO ||
                      ' AND D.COD_MONEDA = ''' || LV_COD_MONEDA || '''';
                      
            SELECT COUNT(A.COD_CONCEPTO)
            INTO LN_CANT_CARGOS
            FROM FA_CONCEPTOS A, GE_MONEDAS D
            WHERE
                 A.Cod_Concepto = LV_COD_CONCEPTO
                 AND D.COD_MONEDA = LV_COD_MONEDA;
            
            IF LN_CANT_CARGOS = 0 THEN
            
                SV_mens_retorno := SV_mens_retorno || 'No existen tarifas para el equipo seleccionado..';
                                                                                    
                RAISE ERROR_SIN_PRECIO;
                    
            END IF;                                 

            LV_sSql := ' SELECT ''A'', A.DES_CONCEPTO, ''1'', '||EN_VAL_DIFERENCIA||', D.DES_MONEDA, A.COD_CONCEPTO, ' ||
                      ' D.COD_MONEDA ' ||       
                      ' FROM FA_CONCEPTOS A, GE_MONEDAS D ' ||
                      ' WHERE ' ||
                      ' A.Cod_Concepto = ' || LV_COD_CONCEPTO ||
                      ' AND D.COD_MONEDA = ''' || LV_COD_MONEDA || '''';
                      
			OPEN SC_cursordatos FOR	
                SELECT 'A', A.DES_CONCEPTO, '1', EN_VAL_DIFERENCIA, D.DES_MONEDA, A.COD_CONCEPTO,D.COD_MONEDA
                FROM FA_CONCEPTOS A, GE_MONEDAS D
                WHERE
                     A.Cod_Concepto = LV_COD_CONCEPTO
                     AND D.COD_MONEDA = LV_COD_MONEDA;


EXCEPTION
    WHEN ERROR_SIN_PRECIO THEN
             SN_cod_retorno:=-1;
	         LV_des_error := SUBSTR('ERROR_SIN_PRECIO:PV_CARGOS_PG.PV_List_cargos_Dif_Garantia_PR; - '|| SQLERRM,1,CN_largoerrtec);
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, CV_version, USER,'PV_CARGOS_PG.PV_List_cargos_Dif_Garantia_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                        
     WHEN OTHERS THEN
          SN_cod_retorno:=156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
          END IF;
          LV_des_error:='OTHERS:PV_CARGOS_PG.PV_List_cargos_Dif_Garantia_PR('||EN_VAL_DIFERENCIA||');- ' || SQLERRM;
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CARGOS_PG.PV_List_cargos_Dif_Garantia_PR('||EN_VAL_DIFERENCIA||')', LV_sSql, SQLCODE, LV_des_error );
END PV_List_cargos_Dif_Garantia_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END PV_CARGOS_PG;
/
SHOW ERRORS