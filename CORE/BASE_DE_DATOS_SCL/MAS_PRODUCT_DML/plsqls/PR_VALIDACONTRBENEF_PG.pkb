CREATE OR REPLACE PACKAGE BODY PR_VALIDACONTRBENEF_PG
AS
	PROCEDURE  PR_OBTENERRESTRICIONPRODUC_PR(
		EN_tipo_plataforma		IN 	        pf_restricciones_prod_td.tipo_plataforma%TYPE,
		EV_ind_nivel_aplica		IN          pf_restricciones_prod_td.ind_nivel_aplica%TYPE,
		EV_tipo_comportamiento	IN          pf_restricciones_prod_td.tipo_comportamiento%TYPE,
		SN_min_ciclos			OUT NOCOPY  pf_restricciones_prod_td.min_ciclos%TYPE,
		SN_max_cantidad			OUT NOCOPY  pf_restricciones_prod_td.max_cantidad%TYPE,
		SN_max_monto			OUT NOCOPY  pf_restricciones_prod_td.max_monto%TYPE,
		SN_resultado    			OUT NOCOPY	Number,
		SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SN_resultado  := 0;
		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		LV_sSQL :=' select min_ciclos, max_cantidad, max_monto';
		LV_sSQL := LV_sSQL || ' into   SN_min_ciclos, SN_max_cantidad, SN_max_monto';
		LV_sSQL := LV_sSQL || ' from   pf_restricciones_prod_td';
		LV_sSQL := LV_sSQL || ' where  tipo_plataforma     = ' || EN_tipo_plataforma;
		LV_sSQL := LV_sSQL || ' and    ind_nivel_aplica    = ' || EV_ind_nivel_aplica;
		LV_sSQL := LV_sSQL || ' and    tipo_comportamiento = ' || EV_tipo_comportamiento;
		LV_sSQL := LV_sSQL || ' and    sysdate    between fec_inicio_vigencia and fec_termino_vigencia;';


-- 		DBMS_OUTPUT.put_line('select min_ciclos, max_cantidad, max_monto');
-- 		DBMS_OUTPUT.put_line(' into   SN_min_ciclos, SN_max_cantidad, SN_max_monto');
-- 		DBMS_OUTPUT.put_line(' from   pf_restricciones_prod_td');
-- 		DBMS_OUTPUT.put_line(' where  tipo_plataforma     = ' || EN_tipo_plataforma);
-- 		DBMS_OUTPUT.put_line(' and    ind_nivel_aplica    = ' || EV_ind_nivel_aplica);
-- 		DBMS_OUTPUT.put_line(' and    tipo_comportamiento = ' || EV_tipo_comportamiento);
-- 		DBMS_OUTPUT.put_line(' and    sysdate    between fec_inicio_vigencia and fec_termino_vigencia;');

		BEGIN
			select min_ciclos, max_cantidad, max_monto
			into   SN_min_ciclos, SN_max_cantidad, SN_max_monto
			from   pf_restricciones_prod_td
			where  tipo_plataforma     = EN_tipo_plataforma -- tipo de plataforma del contratante
			and    ind_nivel_aplica    = EV_ind_nivel_aplica -- este valor es fijo, siempre es 'A'
			and    tipo_comportamiento = EV_tipo_comportamiento -- este valor es fijo, siempre es 'PMOD'
			and    sysdate    between fec_inicio_vigencia and fec_termino_vigencia;

--			DBMS_OUTPUT.put_line('Monto max Salida : ' || SN_max_monto);

		 EXCEPTION
			when NO_DATA_FOUND then
				SN_resultado  := 9;
				LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_OBTENERRESTRICIONPRODUC_PR()' || SQLERRM;

  		        LN_cod_retorno :=  205;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version,USER,
														  'PR_VALIDACONTRBENEF_PG.PR_OBTENERRESTRICIONPRODUC_PR',
														  LV_sSQL,LN_cod_retorno,LV_des_error);


			when OTHERS then
				SN_resultado  := 9;
				LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_OBTENERRESTRICIONPRODUC_PR()' || SQLERRM;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PR_VALIDACONTRBENEF_PG.PR_OBTENERRESTRICIONPRODUC_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );
		 END;
	END PR_OBTENERRESTRICIONPRODUC_PR;


	PROCEDURE PR_VALIDACANTMODULOSCICLO_PR(
		EN_cod_cliente_con		IN	  pr_productos_contratados_to.COD_CLIENTE_CONTRATANTE%TYPE,
		EN_num_abonado_con		IN	  pr_productos_contratados_to.NUM_ABONADO_CONTRATANTE%TYPE,
		EV_tip_comport			IN	  pr_productos_contratados_to.TIPO_COMPORTAMIENTO%TYPE,
		EV_ind_condicion		IN	  pr_productos_contratados_to.IND_CONDICION_CONTRATACION%TYPE,
		ED_fecha_desde			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
		ED_fecha_hasta			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
		EN_max_cantidad			IN	  NUMBER,
		EN_cantidaAcon			IN	  NUMBER,
		SN_resultado    		OUT NOCOPY	Number,
		SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	LN_cantidad_to NUMBER(8);
	LN_cantidad_th NUMBER(8);

	BEGIN

		SN_resultado  := 0;
		SV_mensaje	 := 'OK';

		LN_cantidad_to := 0;
	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		LV_sSQL :=' select count(1)';
		LV_sSQL := LV_sSQL || ' from   pr_productos_contratados_to';
		LV_sSQL := LV_sSQL || ' where  cod_cliente_contratante = ' || EN_cod_cliente_con ;
		LV_sSQL := LV_sSQL || ' and    num_abonado_contratante = ' || EN_num_abonado_con ;
		LV_sSQL := LV_sSQL || ' and    tipo_comportamiento     = ' || EV_tip_comport ;
		LV_sSQL := LV_sSQL || ' and    fec_proceso       between ' || ED_fecha_desde || ' and ' || ED_fecha_hasta;


		select count(1)
		into LN_cantidad_to
		from   pr_productos_contratados_to
		where  cod_cliente_contratante = EN_cod_cliente_con -- código de cliente asociado al contratante
		and    num_abonado_contratante = EN_num_abonado_con -- código de abonado asociado al contratante
		and    tipo_comportamiento     = EV_tip_comport -- este valor es fijo, siempre es 'PMOD'
		and    ind_condicion_contratacion = EV_ind_condicion    -- este valor es fijo, siempre es 'O'
		and    fec_proceso       between ED_fecha_desde and ED_fecha_hasta; -- fechas desde y hasta del ciclo de facturación

		LV_sSQL := LV_sSQL || ' select count(1) ';
		LV_sSQL := LV_sSQL || ' from   pr_productos_contratados_th';
		LV_sSQL := LV_sSQL || ' where  cod_cliente_contratante = ' || EN_cod_cliente_con ;
		LV_sSQL := LV_sSQL || ' and    num_abonado_contratante = ' || EN_num_abonado_con ;
		LV_sSQL := LV_sSQL || ' and    tipo_comportamiento     = ' || EV_tip_comport ;
		LV_sSQL := LV_sSQL || ' and    fec_proceso       between ' || ED_fecha_desde || '  and ' || ED_fecha_hasta;

		LN_cantidad_th := 0;
		select count(1)
		into LN_cantidad_th
		from   pr_productos_contratados_th
		where  cod_cliente_contratante = EN_cod_cliente_con -- código de cliente asociado al contratante
		and    num_abonado_contratante = EN_num_abonado_con -- código de abonado asociado al contratanteatante
		and    tipo_comportamiento     = EV_tip_comport -- este valor es fijo, siempre es 'PMOD'
		and    ind_condicion_contratacion = EV_ind_condicion    -- este valor es fijo, siempre es 'O'
		and    fec_proceso       between ED_fecha_desde and ED_fecha_hasta; -- fechas desde y hasta del ciclo de facturación


		IF (LN_cantidad_to + LN_cantidad_th) + EN_cantidaAcon >= EN_max_cantidad then
			SN_resultado  := 9;
			if EN_cantidaAcon=0 then
			   SV_mensaje	 := 'Cliente ya tiene contratados el máximo de Planes Adicionales permitido por ciclo de facturación';
			else
			   SV_mensaje	 := 'Con ese Plan Adicional supera la cantidad máxima permitida por ciclo de facturación';
			end if;
		end if;

	EXCEPTION



			when OTHERS then
				SN_resultado  := 9;
				LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_VALIDACANTMODULOSCICLO_PR()' || SQLERRM;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PR_VALIDACONTRBENEF_PG.PR_VALIDACANTMODULOSCICLO_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );


	END PR_VALIDACANTMODULOSCICLO_PR;

	PROCEDURE PR_VALIDAMONTOMODULOSCICLO_PR(
		EN_cod_cliente_con		IN	  pr_productos_contratados_to.COD_CLIENTE_CONTRATANTE%TYPE,
		EN_num_abonado_con		IN	  pr_productos_contratados_to.NUM_ABONADO_CONTRATANTE%TYPE,
		EV_tip_comport			IN	  pr_productos_contratados_to.TIPO_COMPORTAMIENTO%TYPE,
		EV_ind_condicion		IN	  pr_productos_contratados_to.IND_CONDICION_CONTRATACION%TYPE,
		ED_fecha_desde			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
		ED_fecha_hasta			IN	  pr_productos_contratados_to.FEC_PROCESO%TYPE,
		EN_max_monto			IN	  NUMBER,
		EN_cantidaAcon			IN	  NUMBER,
		EN_cod_product			IN 	  pf_catalogo_ofertado_td.COD_PROD_OFERTADO%TYPE,
		EN_cod_canal			IN 	  pf_catalogo_ofertado_td.COD_CANAL%TYPE,
		SN_resultado    		OUT NOCOPY	Number,
		SV_mensaje	   			OUT NOCOPY	ge_errores_pg.MsgError
	) IS


	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	LN_monto_to number(10);
	LN_monto_pr number(10);
	LN_monto_th number(10);

	BEGIN

		LN_monto_pr := 0;
		if EN_cantidaAcon>0 and EN_cod_product>0 then
		   LV_sSQL :=' select nvl(sum(c.monto_importe), 0) *  ' || EN_cantidaAcon;
		   LV_sSQL := LV_sSQL || ' from   pf_catalogo_ofertado_td b, pf_cargos_productos_td c';
		   LV_sSQL := LV_sSQL || ' where  b.cod_prod_ofertado = ' || EN_cod_product;
		   LV_sSQL := LV_sSQL || ' and    b.cod_canal         = ' || EN_cod_canal;
		   LV_sSQL := LV_sSQL || ' and    sysdate       between b.fec_inicio_vigencia and b.fec_termino_vigencia';
		   LV_sSQL := LV_sSQL || ' and    c.cod_cargo         = b.cod_cargo';
		   begin
				select nvl(sum(c.monto_importe), 0) *  EN_cantidaAcon -- el 2 es la cantidad de producto a contratar, es parámetro
				into   LN_monto_pr
				from   pf_catalogo_ofertado_td b, pf_cargos_productos_td c
				where  b.cod_prod_ofertado = EN_cod_product    -- este valor es por parámetro
				and    b.cod_canal         = EN_cod_canal -- este valor es por parámetro
				and    sysdate       between b.fec_inicio_vigencia and b.fec_termino_vigencia
				and    c.cod_cargo         = b.cod_cargo;
			EXCEPTION
					when OTHERS then
						SN_resultado  := 9;
						LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR()' || SQLERRM;
		  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
		  			       SV_mensaje := CV_error_no_clasif;
		  			    END IF;
		  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
									   	  						  CV_cod_modulo,
																  SV_mensaje,
																  CV_version, USER,
																  'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR',
																  LV_sSQL, LN_cod_retorno, LV_des_error );
			end;
		end if;


		SN_resultado  := 0;
		SV_mensaje	 := 'OK';

		LN_monto_to:= 0;
		LN_monto_th:= 0;

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		begin
			LV_sSQL :=' select sum(c.monto_importe) ';
			LV_sSQL := LV_sSQL || ' from   pr_productos_contratados_to a, pf_catalogo_ofertado_td b, pf_cargos_productos_td c';
			LV_sSQL := LV_sSQL || ' where  a.cod_cliente_contratante    = ' || EN_cod_cliente_con;
			LV_sSQL := LV_sSQL || ' and    a.num_abonado_contratante    = ' || EN_num_abonado_con;
			LV_sSQL := LV_sSQL || ' and    a.tipo_comportamiento        = ' || EV_tip_comport ;
			LV_sSQL := LV_sSQL || ' and    a.ind_condicion_contratacion = ' || EV_ind_condicion ;
			LV_sSQL := LV_sSQL || ' and    a.fec_proceso between ' ||  ED_fecha_desde || ' and ' || ED_fecha_hasta;
			LV_sSQL := LV_sSQL || '	and    a.ind_condicion_contratacion =' || EV_ind_condicion;
			LV_sSQL := LV_sSQL || ' and    b.cod_prod_ofertado = a.cod_prod_ofertado';
			LV_sSQL := LV_sSQL || ' and    b.cod_canal  = a.cod_canal';
			LV_sSQL := LV_sSQL || ' and    a.fec_proceso between b.fec_inicio_vigencia and b.fec_termino_vigencia';
			LV_sSQL := LV_sSQL || ' and    c.cod_cargo = b.cod_cargo;';



			select nvl(sum(c.monto_importe),0)
			into   LN_monto_to
			from   pr_productos_contratados_to a, pf_catalogo_ofertado_td b, pf_cargos_productos_td c
			where  a.cod_cliente_contratante    = EN_cod_cliente_con
			and    a.num_abonado_contratante    = EN_num_abonado_con
			and    a.tipo_comportamiento        = EV_tip_comport -- este valor es fijo, siempre es 'PMOD'
			and    a.ind_condicion_contratacion = EV_ind_condicion    -- este valor es fijo, siempre es 'O'
			and    a.fec_proceso          between ED_fecha_desde and ED_fecha_hasta
			and    b.cod_prod_ofertado          = a.cod_prod_ofertado
			and    b.cod_canal                  = a.cod_canal
			and    a.fec_proceso          between b.fec_inicio_vigencia and b.fec_termino_vigencia
			and    c.cod_cargo                  = b.cod_cargo;

		EXCEPTION
				when OTHERS then
					SN_resultado  := 9;
					LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR()' || SQLERRM;
	  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
	  			       SV_mensaje := CV_error_no_clasif;
	  			    END IF;
	  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
								   	  						  CV_cod_modulo,
															  SV_mensaje,
															  CV_version, USER,
															  'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR',
															  LV_sSQL, LN_cod_retorno, LV_des_error );
		end;

		begin
			LV_sSQL :=' select sum(c.monto_importe)';
			LV_sSQL := LV_sSQL || ' from   pr_productos_contratados_th a, pf_catalogo_ofertado_td b, pf_cargos_productos_td c';
			LV_sSQL := LV_sSQL || ' where  a.cod_cliente_contratante    = ' || EN_cod_cliente_con;
			LV_sSQL := LV_sSQL || ' and    a.num_abonado_contratante    = ' || EN_num_abonado_con;
			LV_sSQL := LV_sSQL || ' and    a.tipo_comportamiento        = ' || EV_tip_comport ;
			LV_sSQL := LV_sSQL || ' and    a.ind_condicion_contratacion = ' || EV_ind_condicion;
			LV_sSQL := LV_sSQL || ' and    a.fec_proceso  between ' || ED_fecha_desde || ' and ' || ED_fecha_hasta;
			LV_sSQL := LV_sSQL || '	and    a.ind_condicion_contratacion =' || EV_ind_condicion;
			LV_sSQL := LV_sSQL || ' and    b.cod_prod_ofertado  = a.cod_prod_ofertado';
			LV_sSQL := LV_sSQL || ' and    b.cod_canal = a.cod_canal';
			LV_sSQL := LV_sSQL || ' and    a.fec_proceso between b.fec_inicio_vigencia and b.fec_termino_vigencia';
			LV_sSQL := LV_sSQL || ' and    c.cod_cargo = b.cod_cargo;';


			select nvl(sum(c.monto_importe),0)
			into  LN_monto_th
			from   pr_productos_contratados_th a, pf_catalogo_ofertado_td b, pf_cargos_productos_td c
			where  a.cod_cliente_contratante    = EN_cod_cliente_con
			and    a.num_abonado_contratante    = EN_num_abonado_con
			and    a.tipo_comportamiento        = EV_tip_comport -- este valor es fijo, siempre es 'PMOD'
			and    a.ind_condicion_contratacion = EV_ind_condicion    -- este valor es fijo, siempre es 'O'
			and    a.fec_proceso          between ED_fecha_desde and ED_fecha_hasta
			and    b.cod_prod_ofertado          = a.cod_prod_ofertado
			and    b.cod_canal                  = a.cod_canal
			and    a.fec_proceso          between b.fec_inicio_vigencia and b.fec_termino_vigencia
			and    c.cod_cargo                  = b.cod_cargo;
		EXCEPTION
				when OTHERS then
					SN_resultado  := 9;
					LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR()' || SQLERRM;
	  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
	  			       SV_mensaje := CV_error_no_clasif;
	  			    END IF;
	  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
								   	  						  CV_cod_modulo,
															  SV_mensaje,
															  CV_version, USER,
															  'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR',
															  LV_sSQL, LN_cod_retorno, LV_des_error );
		end;


		IF (LN_monto_to + LN_monto_th) + LN_monto_pr >= EN_max_monto then
			SN_resultado  := 9;
			if LN_monto_pr=0 then
			   SV_mensaje	 := 'Cliente ya tiene contratados el máximo de Planes Adicionales permitido por ciclo de facturación';
			else
			   SV_mensaje	 := 'Con ese Plan Adicional supera el monto máximo permitido por ciclo de facturación';
			end if;
		end if;

	EXCEPTION

			when OTHERS then
				SN_resultado  := 9;
				LV_des_error	 := 'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR()' || SQLERRM;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );

	END PR_VALIDAMONTOMODULOSCICLO_PR;

END PR_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
