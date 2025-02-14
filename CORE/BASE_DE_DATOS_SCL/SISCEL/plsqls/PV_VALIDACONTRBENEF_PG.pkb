CREATE OR REPLACE PACKAGE BODY PV_VALIDACONTRBENEF_PG AS

	PROCEDURE PV_OBTENERNUMABOCLIE_PR
	(
		EN_num_celular		IN		    GA_ABOCEL.num_celular%TYPE,
		SN_num_abonado		OUT 	    GA_ABOCEL.num_abonado%TYPE,
		SN_cod_cliente		OUT	 	    GA_ABOCEL.cod_cliente%TYPE,
		SN_cod_plantarif	OUT 	    GA_ABOCEL.cod_plantarif%TYPE,
		SN_cod_ciclo		OUT 	    GA_ABOCEL.cod_ciclo%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SN_resultado := 0;
		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		begin

			LV_sSQL := 'select ';
			LV_sSQL := LV_sSQL || '   num_abonado, ';
			LV_sSQL := LV_sSQL || '   cod_cliente, ';
			LV_sSQL := LV_sSQL || '   cod_plantarif,';
			LV_sSQL := LV_sSQL || '   cod_ciclo';
			LV_sSQL := LV_sSQL || ' from ';
			LV_sSQL := LV_sSQL || '   ga_abocel';
			LV_sSQL := LV_sSQL || ' where  ';
			LV_sSQL := LV_sSQL || '   num_celular = ' || EN_num_celular;
			LV_sSQL := LV_sSQL || ' UNION';
			LV_sSQL := LV_sSQL || ' select ';
			LV_sSQL := LV_sSQL || '   num_abonado, ';
			LV_sSQL := LV_sSQL || '   cod_cliente, ';
			LV_sSQL := LV_sSQL || '   cod_plantarif,';
			LV_sSQL := LV_sSQL || '   cod_ciclo';
			LV_sSQL := LV_sSQL || ' from ';
			LV_sSQL := LV_sSQL || '   ga_aboamist';
			LV_sSQL := LV_sSQL || ' where  ';
			LV_sSQL := LV_sSQL || '   num_celular = ' || EN_num_celular;

			select
				   num_abonado,
				   cod_cliente,
				   cod_plantarif,
				   cod_ciclo
			into
				   SN_num_abonado,
				   SN_cod_cliente,
				   SN_cod_plantarif,
				   SN_cod_ciclo
			from
				   ga_abocel
			where
				   num_celular = EN_num_celular
			       and cod_situacion NOT IN ('BAA','BAP')
			UNION
			select
				   num_abonado,
				   cod_cliente,
				   cod_plantarif,
				   cod_ciclo
			from
				   ga_aboamist
			where
				   num_celular = EN_num_celular
				   and cod_situacion NOT IN ('BAA','BAP');
		exception
			when NO_DATA_FOUND then
				SN_resultado := 9;
				LV_des_error	 := 'PV_VALIDACONTRBENEF_PG.PV_OBTENERNUMABOCLIE_PR()' || SQLERRM;

  		        LN_cod_retorno := 144;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version,USER,
														  'PV_VALIDACONTRBENEF_PG.PV_OBTENERNUMABOCLIE_PR',
														  LV_sSQL,LN_cod_retorno,LV_des_error);
			when OTHERS then
				SN_resultado := 9;
				LV_des_error	 := 'PV_VALIDACONTRBENEF_PG.PV_OBTENERNUMABOCLIE_PR()' || SQLERRM;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PV_VALIDACONTRBENEF_PG.PV_OBTENERNUMABOCLIE_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );

		end;


	END PV_OBTENERNUMABOCLIE_PR;


	PROCEDURE PV_SITUACIONABON_PR
	(

	 	EN_num_abonado		IN	 		GA_ABOCEL.NUM_ABONADO%TYPE,
		EN_cod_os			IN			ci_tiporserv.cod_os%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError

	) IS

    ---Control de errores registro de OOSS---------------
    error_ooss   EXCEPTION;

	LV_cod_tipmodi VARCHAR(3):= '';
	LN_cantidad	   NUMBER;

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SN_resultado := 0;
		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		begin
			LV_sSQL :='select ';
			LV_sSQL := LV_sSQL || '   cod_tipmodi';
			LV_sSQL := LV_sSQL || ' from   ';
			LV_sSQL := LV_sSQL || '   ci_tiporserv';
			LV_sSQL := LV_sSQL || ' where  ';
			LV_sSQL := LV_sSQL || '   cod_os = ' || EN_cod_os;

			select
			   cod_tipmodi
			into
			   LV_cod_tipmodi
			from
			   ci_tiporserv
			where
			   cod_os = EN_cod_os;

		exception
			when NO_DATA_FOUND then
				SN_resultado := 9;
				LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR()' || SQLERRM;

  		        LN_cod_retorno := 204;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version,USER,
														  'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error);


		    when OTHERS then
		   	    SN_resultado :=  9;
				LV_des_error	 := 'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR()' || SQLERRM;
  			    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			       SV_mensaje := CV_error_no_clasif;
  			    END IF;
  			    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error);

		end;

		LV_sSQL :='select count(1)';
		LV_sSQL := LV_sSQL || ' from   ga_abocel a';
		LV_sSQL := LV_sSQL || ' where  a.num_abonado    = ' || EN_num_abonado;
		LV_sSQL := LV_sSQL || ' and    a.cod_situacion in (select cod_situacion';
		LV_sSQL := LV_sSQL || ' from   pvd_actuacion_situacion b';
		LV_sSQL := LV_sSQL || ' where  b.cod_producto  = a.cod_producto';
		LV_sSQL := LV_sSQL || ' and    b.cod_actabo    = ' || LV_cod_tipmodi;
		LV_sSQL := LV_sSQL || ' and    b.cod_situacion = a.cod_situacion);';
		select count(1)
		into   LN_cantidad
		from   ga_abocel a
		where  a.num_abonado    = EN_num_abonado -- número de abonado del celular contratante / beneficiario
		and    a.cod_situacion in (select cod_situacion
		                           from   pvd_actuacion_situacion b
		                           where  b.cod_producto  = a.cod_producto
		                           and    b.cod_actabo    = LV_cod_tipmodi -- cod_tipmodi
								   and    b.cod_situacion = a.cod_situacion);
		IF LN_cantidad = 0 THEN
			LV_sSQL :='    select count(1)';
			LV_sSQL := LV_sSQL || ' from   ga_aboamist a';
			LV_sSQL := LV_sSQL || ' where  a.num_abonado    = ' || EN_num_abonado;
			LV_sSQL := LV_sSQL || ' and    a.cod_situacion in (select cod_situacion';
			LV_sSQL := LV_sSQL || ' from   pvd_actuacion_situacion b';
			LV_sSQL := LV_sSQL || ' where  b.cod_producto  = a.cod_producto';
			LV_sSQL := LV_sSQL || ' and    b.cod_actabo    = ' || LV_cod_tipmodi;
			LV_sSQL := LV_sSQL || ' and    b.cod_situacion = a.cod_situacion);';

		   select count(1)
		   into   LN_cantidad
		   from   ga_aboamist a
		   where  a.num_abonado    = EN_num_abonado -- número de abonado del celular contratante / beneficiario
		   and    a.cod_situacion in (select cod_situacion
		                              from   pvd_actuacion_situacion b
		                              where  b.cod_producto  = a.cod_producto
		                              and    b.cod_actabo    = LV_cod_tipmodi -- cod_tipmodi
		                              and    b.cod_situacion = a.cod_situacion);
		   IF LN_cantidad = 0 THEN
		   	  SN_resultado :=  9;
		      LV_des_error   := 'situacion de abonado no es permitida para esta operacion';
			  RAISE error_ooss;
		   END IF;

		END IF;

	EXCEPTION
	    when error_ooss then

	    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
	       SV_mensaje := CV_error_no_clasif;
	    END IF;
		LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR()' || SQLERRM;
	    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
					   	  						  CV_cod_modulo,
												  SV_mensaje,
												  CV_version, USER,
												  'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR',
												  LV_sSQL, LN_cod_retorno, LV_des_error);


	    when OTHERS then
	   	    SN_resultado :=  9;
			LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR()' || SQLERRM;
  		    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  		       SV_mensaje := CV_error_no_clasif;
  		    END IF;
  		    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
						   	  						  CV_cod_modulo,
													  SV_mensaje,
													  CV_version, USER,
													  'PV_VALIDACONTRBENEF_PG.PV_SITUACIONABON_PR',
													  LV_sSQL, LN_cod_retorno, LV_des_error);


	END PV_SITUACIONABON_PR;

	PROCEDURE PV_TIPOPLANABO_PR
	(
		EN_cod_plantarif	IN	 		GA_ABOCEL.COD_PLANTARIF%TYPE,
		SN_cod_tiplan		OUT			TA_PLANTARIF.COD_TIPLAN%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	) IS


	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;


	BEGIN
		 SN_resultado := 0;
		 SV_mensaje	 := 'OK';

	     LN_cod_retorno := 0;
	     LN_num_evento  := 0;

 		 LV_sSQL :='  select cod_tiplan ';
	 	 LV_sSQL := LV_sSQL || '  into   SN_cod_tiplan';
		 LV_sSQL := LV_sSQL || '  from   ta_plantarif  ';
		 LV_sSQL := LV_sSQL || '  where  cod_plantarif = ' || EN_cod_plantarif;
		 LV_sSQL := LV_sSQL || '  and    cod_producto  = 1;';


			 select cod_tiplan
			 into   SN_cod_tiplan
			 from   ta_plantarif
			 where  cod_plantarif = EN_cod_plantarif -- plan tarifario del contratante / beneficiario
			 and    cod_producto  = 1;
		 EXCEPTION

		 when NO_DATA_FOUND then
			  SN_resultado := 9;
			  LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_TIPOPLANABO_PR()' || SQLERRM;

  		      LN_cod_retorno := 282;
  			  IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			     SV_mensaje := CV_error_no_clasif;
  			  END IF;
  			  LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
				       	   	  						    CV_cod_modulo,
														SV_mensaje,
														CV_version,USER,
														'PV_VALIDACONTRBENEF_PG.PV_TIPOPLANABO_PR',
														LV_sSQL, LN_cod_retorno, LV_des_error);

		 When OTHERS then
			  SN_resultado := 9;
			  LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_TIPOPLANABO_PR()' || SQLERRM;
			  IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
				 SV_mensaje := cv_error_no_clasif;
			  END IF;
			  LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						CV_cod_modulo,
														SV_mensaje,
														CV_version, USER,
														'PV_VALIDACONTRBENEF_PG.PV_TIPOPLANABO_PR',
														LV_sSQL, LN_cod_retorno, LV_des_error );

	END PV_TIPOPLANABO_PR;


	PROCEDURE PV_MOROSIDADABO_PR
	(
	 	EN_cod_cliente		IN			CO_CARTERA.COD_CLIENTE%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LV_monto NUMBER(16,4);

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

    ---Control de errores registro de OOSS---------------
    error_ooss   EXCEPTION;

	BEGIN

		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		LV_sSQL :=' SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)';
		LV_sSQL := LV_sSQL || ' FROM   CO_CARTERA';
		LV_sSQL := LV_sSQL || ' WHERE  cod_cliente       = ' || EN_cod_cliente ;
		LV_sSQL := LV_sSQL || ' AND    IND_FACTURADO     = ' || CV_IND_FACTURADO;
		LV_sSQL := LV_sSQL || ' AND    FEC_VENCIMIE      < TRUNC(SYSDATE)';
		LV_sSQL := LV_sSQL || ' AND    COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)';
		LV_sSQL := LV_sSQL || ' FROM    CO_CODIGOS';
		LV_sSQL := LV_sSQL || ' WHERE   NOM_TABLA   = ' || CV_CO_CARTERA;
		LV_sSQL := LV_sSQL || ' AND     NOM_COLUMNA = ' || CV_COD_TIPDOCUM;


		SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
		INTO   LV_monto
		FROM   CO_CARTERA
		WHERE  cod_cliente       = EN_cod_cliente	 -- código de cliente asociado al contratante / beneficiario
		AND    IND_FACTURADO     = CV_IND_FACTURADO
		AND    FEC_VENCIMIE      < TRUNC(SYSDATE)
		AND    COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)
		                            FROM    CO_CODIGOS
		                            WHERE   NOM_TABLA   = CV_CO_CARTERA
		                            AND     NOM_COLUMNA = CV_COD_TIPDOCUM);

		IF LV_monto > 0 THEN
		   LN_cod_retorno := 466;
		   SN_resultado   := 9;
		   LV_des_error   := 'Cliente presenta morosidad con valor: '||to_char(LV_monto);
  		   RAISE error_ooss;
		END IF;

	EXCEPTION
	    when error_ooss then
			LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_MOROSIDADABO_PR():Error OOSS';
  		    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  		       SV_mensaje := CV_error_no_clasif;
  		    END IF;
  		    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
						   	  						  CV_cod_modulo,
													  SV_mensaje,
													  CV_version, USER,
													  'PV_VALIDACONTRBENEF_PG.PV_MOROSIDADABO_PR',
													  LV_sSQL, LN_cod_retorno, LV_des_error);


	    when OTHERS then
	   	    SN_resultado :=  9;
			LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_MOROSIDADABO_PR()' || SQLERRM;
  		    IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  		       SV_mensaje := CV_error_no_clasif;
  		    END IF;
  		    LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
						   	  						  CV_cod_modulo,
													  SV_mensaje,
													  CV_version, USER,
													  'PV_VALIDACONTRBENEF_PG.PV_MOROSIDADABO_PR',
													  LV_sSQL, LN_cod_retorno, LV_des_error);

	END PV_MOROSIDADABO_PR;

	PROCEDURE PV_VALIDACICLOFACT_PR(
		EN_cod_cliente_con	IN	ga_infaccel.COD_CLIENTE%TYPE,
		EN_num_abonado_con  IN	ga_infaccel.NUM_ABONADO%TYPE,
		EN_cod_ciclo		IN	fa_ciclfact.COD_CICLO%TYPE,
		SN_cod_ciclfact		OUT NOCOPY	fa_ciclfact.cod_ciclfact%TYPE,
		SD_fec_desdeocargos	OUT NOCOPY	fa_ciclfact.fec_desdeocargos%TYPE,
		SD_fec_hastaocargos	OUT NOCOPY	fa_ciclfact.fec_hastaocargos%TYPE,
		SN_resultado		OUT NOCOPY	Number,
		SV_mensaje			OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LN_valciclo NUMBER(8);

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SN_resultado := 0;
		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		LV_sSQL :=' select cod_ciclfact, fec_desdeocargos, fec_hastaocargos';
		LV_sSQL := LV_sSQL || ' into   SN_cod_ciclfact, SD_fec_desdeocargos, SD_fec_hastaocargos';
		LV_sSQL := LV_sSQL || ' from   fa_ciclfact';
		LV_sSQL := LV_sSQL || ' where  cod_ciclo  = ' || EN_cod_ciclo;
		LV_sSQL := LV_sSQL || ' and sysdate between fec_desdeocargos and fec_hastaocargos;';

		BEGIN
			select cod_ciclfact, fec_desdeocargos, fec_hastaocargos
			into   SN_cod_ciclfact, SD_fec_desdeocargos, SD_fec_hastaocargos
			from   fa_ciclfact
			where  cod_ciclo  = EN_cod_ciclo -- ciclo de facturación del contratante (cod_ciclo)
			and sysdate between fec_desdeocargos and fec_hastaocargos;
		EXCEPTION
			when NO_DATA_FOUND then
				 SN_resultado := 9;
				 LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR()' || SQLERRM;

  		     	 LN_cod_retorno := 200;
  			  	 IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			     	SV_mensaje := CV_error_no_clasif;
  			  	 END IF;
  			  		LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
				       	   	  						    	  CV_cod_modulo,
															  SV_mensaje,
															  CV_version,USER,
															  'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR',
															  LV_sSQL, LN_cod_retorno, LV_des_error);
			when OTHERS then
			    LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR()' || SQLERRM;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
				   SV_mensaje := cv_error_no_clasif;
				END IF;
				LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );
		END;


		LV_sSQL :=' select count(1)';
		LV_sSQL := LV_sSQL || ' from   ga_infaccel';
		LV_sSQL := LV_sSQL || ' where  cod_cliente  = ' || EN_cod_cliente_con;
		LV_sSQL := LV_sSQL || ' and    num_abonado  = ' || EN_num_abonado_con;
		LV_sSQL := LV_sSQL || ' and    cod_ciclfact = ' || SN_cod_ciclfact;

		BEGIN
			select count(1)
			into   LN_valciclo
			from   ga_infaccel
			where  cod_cliente  = EN_cod_cliente_con -- código de cliente asociado al contratante
			and    num_abonado  = EN_num_abonado_con -- código de abonado asociado al contratante
			and    cod_ciclfact = SN_cod_ciclfact; -- código de ciclo de facturación del contratante (cod_ciclfact)

			if LN_valciclo=0 then
				SN_resultado := 9;
				SV_mensaje	 := 'No existe ciclo de facturacion vigente';
			end if;
		EXCEPTION

			when OTHERS then
				SN_resultado := 9;
			    LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR()' || SQLERRM;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
				   SV_mensaje := cv_error_no_clasif;
				END IF;
				LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error);
		END;

	END PV_VALIDACICLOFACT_PR;

	PROCEDURE  PV_VALIDACICLOPERMANENCIA_PR(
		EN_cod_cliente	IN	 fa_histdocu.COD_CLIENTE%TYPE,
		EN_min_ciclos	IN	 NUMBER,
		SN_resultado   OUT NOCOPY	Number,
		SV_mensaje	   OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LN_valmin NUMBER(10);

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SN_resultado := 0;
		SV_mensaje	 := 'OK';

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		BEGIN

			LV_sSQL :=' select count(1)';
			LV_sSQL := LV_sSQL || ' from fa_histdocu';
			LV_sSQL := LV_sSQL || ' where  cod_cliente   = ' || EN_cod_cliente ;
			LV_sSQL := LV_sSQL || ' and    cod_ciclfact != ' || CN_CICLOFACTNOPERMITIDO;

			select count(1)
			into LN_valmin
			from fa_histdocu
			where  cod_cliente   = EN_cod_cliente -- código de cliente asociado al contratante
			and    cod_ciclfact != CN_CICLOFACTNOPERMITIDO; -- este valor es fijo, siempre es 19010102

			if LN_valmin<EN_min_ciclos then
				SN_resultado := 9;
				SV_mensaje	 := 'El cliente no cumple el mínimo ciclos de facturación para poder contratar';
			end if;
		EXCEPTION
		 	when OTHERS then
			    SN_resultado := 9;
			    LV_des_error := 'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOFACT_PR()' || SQLERRM;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
				   SV_mensaje := cv_error_no_clasif;
				END IF;
				LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  						  CV_cod_modulo,
														  SV_mensaje,
														  CV_version, USER,
														  'PV_VALIDACONTRBENEF_PG.PV_VALIDACICLOPERMANENCIA_PR',
														  LV_sSQL, LN_cod_retorno, LV_des_error );
		END;

	END PV_VALIDACICLOPERMANENCIA_PR;

	PROCEDURE PV_VALCONTRANTEBENEFICIARIO_PR(
		EN_num_celular_con IN	ga_abocel.NUM_CELULAR%TYPE,
		EN_num_celular_ben IN	ga_abocel.NUM_CELULAR%TYPE,
		EN_cod_producto    IN	number,
		EN_can_producto    IN	number,
		EN_canal		   IN	Varchar2,
		SN_resultado   	   OUT NOCOPY	Number,
		SV_mensaje	   	   OUT NOCOPY	ge_errores_pg.MsgError
	) IS

	LN_num_abonado_con  NUMBER(8);
	LN_num_abonado_ben  NUMBER(8);

	LN_cod_cliente_con  NUMBER(8);
	LN_cod_cliente_ben  NUMBER(8);

	LN_cod_plantarif_con   	VARCHAR2(3);
	LN_cod_plantarif_ben    VARCHAR2(3);

	LN_num_celular_ben NUMBER(15);
	LN_num_celular_con NUMBER(15);
	NO_APLICA_CONDICIONES EXCEPTION;
	NO_HAY_RESTRICCIONES EXCEPTION;

	LN_cod_ciclo_con 		GA_ABOCEL.cod_ciclo%TYPE;
	LN_cod_ciclo_ben 		GA_ABOCEL.cod_ciclo%TYPE;
	LN_min_ciclos		NUMBER(10);
	LN_max_cantidad		NUMBER(10);
	LN_max_monto	    NUMBER(10);

	LN_cod_ciclfact		fa_ciclfact.cod_ciclfact%TYPE;
	LD_fec_desdeocargos	fa_ciclfact.fec_desdeocargos%TYPE;
	LD_fec_hastaocargos	fa_ciclfact.fec_hastaocargos%TYPE;
	LN_cod_tiplan_con	TA_PLANTARIF.COD_TIPLAN%TYPE;
	LN_cod_os 		    ci_tiporserv.cod_os%TYPE;

	BEGIN

		BEGIN
		/** OBTENER LOS NUMEROS DE ABONADOS POR EL NUMERO DEL CELULAR*/
			PV_OBTENERNUMABOCLIE_PR(EN_NUM_CELULAR_CON,LN_NUM_ABONADO_CON, LN_COD_CLIENTE_CON, LN_COD_PLANTARIF_CON,LN_cod_ciclo_con,SN_resultado,SV_MENSAJE);

			IF 	SN_resultado = 9 THEN
				SV_mensaje := 'El abonado contratante no existe';
				RAISE NO_APLICA_CONDICIONES;
			END IF;
			IF EN_NUM_CELULAR_BEN IS NULL THEN
			   LN_NUM_CELULAR_BEN := EN_NUM_CELULAR_CON;
			   LN_COD_CLIENTE_BEN := LN_COD_CLIENTE_CON;
			   LN_NUM_ABONADO_BEN := LN_NUM_ABONADO_CON;
			ELSE
				PV_OBTENERNUMABOCLIE_PR(EN_NUM_CELULAR_BEN,LN_NUM_ABONADO_BEN, LN_COD_CLIENTE_BEN, LN_COD_PLANTARIF_BEN,LN_cod_ciclo_ben ,SN_resultado,SV_MENSAJE);
				IF 	SN_resultado = 9 THEN
					SV_mensaje := 'El abonado beneficiario no existe';
					RAISE NO_APLICA_CONDICIONES;
				END IF;
			END IF;

			IF LN_cod_cliente_con =	LN_cod_cliente_ben then
			   LN_cod_os := 40100;
			ELSE
			   LN_cod_os := 40110;
			END IF;

			/** VALIDAR SI ESTAN CON SITUACION ALTA 'AAA' **/
			PV_SITUACIONABON_PR(LN_num_abonado_con,LN_cod_os,SN_resultado,SV_MENSAJE);
			IF 	SN_resultado = 9 THEN
				SV_mensaje := 'La situacion del abonado contratante no es valida para esta operacion o no es posible recuperar parámetros de orden de servicio';
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			PV_SITUACIONABON_PR(LN_num_abonado_ben,LN_cod_os,SN_resultado,SV_MENSAJE);
			IF 	SN_resultado = 9 THEN
				SV_mensaje := 'La situacion del abonado beneficiario no es valida para esta operacion';
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			/**VALIDA EL TIPO DE PLAN DEL ABONADO CONTRATANTE*/
			PV_TIPOPLANABO_PR(LN_cod_plantarif_CON,LN_cod_tiplan_con,SN_resultado,SV_MENSAJE);
			IF LN_cod_tiplan_con=1 THEN
				SN_resultado := 9;
				SV_mensaje	 := 'El abonado contratante no debe ser del tipo de plan Prepago';
			END IF;
			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			/** VALIDAR MOROSIDAD */
			PV_MOROSIDADABO_PR(LN_cod_cliente_con,SN_resultado,SV_MENSAJE);
			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			/** VALIDA QUE EL CLIENTE CONTRATADO NO ESTE VETADO  */
			cu_VALIDACONTRBENEF_PG.CU_VALVETADOSCONTRA_PR(LN_cod_cliente_con,LN_num_abonado_con,SN_resultado,SV_MENSAJE);
			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			IF EN_num_celular_con<>EN_num_celular_ben then
				cu_VALIDACONTRBENEF_PG.CU_VALIDABENEFICIARIO_PR(LN_cod_cliente_con,LN_num_abonado_con,LN_num_abonado_ben,SN_resultado,SV_MENSAJE);
				IF 	SN_resultado = 9 THEN
					RAISE NO_APLICA_CONDICIONES;
				END IF;
			end if;

			PR_VALIDACONTRBENEF_PG.PR_OBTENERRESTRICIONPRODUC_PR(LN_cod_tiplan_con,CV_NIVEL_APLICA,CV_TIPO_COMPORTAMIENTO,LN_min_ciclos,LN_max_cantidad,LN_max_monto,SN_resultado,SV_MENSAJE);
 			IF 	SN_resultado = 9 THEN
				RAISE NO_HAY_RESTRICCIONES;
			END IF;

			PV_VALIDACICLOPERMANENCIA_PR(LN_cod_cliente_con,LN_min_ciclos,SN_resultado,SV_MENSAJE);
 			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;


			PV_VALIDACICLOFACT_PR(LN_cod_cliente_con,LN_num_abonado_con,LN_cod_ciclo_con,LN_cod_ciclfact,LD_fec_desdeocargos,LD_fec_hastaocargos,SN_resultado,SV_mensaje);
 			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			PR_VALIDACONTRBENEF_PG.PR_VALIDACANTMODULOSCICLO_PR(
				LN_cod_cliente_con,
				LN_num_abonado_con,
				CV_TIPO_COMPORTAMIENTO,
				CV_ind_condicion,
				LD_fec_desdeocargos,
				LD_fec_hastaocargos,
				LN_max_cantidad,
				EN_can_producto,
				SN_resultado,SV_mensaje);
 			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

			PR_VALIDACONTRBENEF_PG.PR_VALIDAMONTOMODULOSCICLO_PR(
				LN_cod_cliente_con,
				LN_num_abonado_con,
				CV_TIPO_COMPORTAMIENTO,
				CV_ind_condicion,
				LD_fec_desdeocargos,
				LD_fec_hastaocargos,
				LN_max_monto,
				LN_max_cantidad,
				EN_cod_producto,
				en_canal,
				SN_resultado,SV_mensaje);
 			IF 	SN_resultado = 9 THEN
				RAISE NO_APLICA_CONDICIONES;
			END IF;

		EXCEPTION
			WHEN NO_APLICA_CONDICIONES THEN
				SN_resultado := 9;
			WHEN NO_HAY_RESTRICCIONES THEN
				SN_resultado := 0;
				SV_mensaje := 'No existen Restricciones Configuradas';
		END;


	END PV_VALCONTRANTEBENEFICIARIO_PR;
/****************************************************************************************************************************/
PROCEDURE PV_VALIDAPOSPAGO_PR ( EV_PARAM_ENTRADA IN         VARCHAR2,
								SV_RESULTADO     OUT NOCOPY VARCHAR2,
								SV_MENSAJE       OUT NOCOPY ga_transacabo.des_cadena%TYPE
							)  IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_TIPOPLANABO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Valida que el abonado no sea ni hibrido ni prepago</Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EN_NUM_ABONADO" tipo="NUMERICO">Cliente origen</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

LV_sSQL            ge_errores_pg.vQuery;
LN_num_evento      ge_errores_pg.Evento;
LN_cod_retorno     ge_errores_pg.CodError;
LV_des_error       ge_errores_pg.DesEvent;
LN_NUM_ABONADO	   ga_abocel.num_abonado%TYPE;

string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

LV_CODTIPLAN ta_plantarif.cod_tiplan%TYPE;

BEGIN
	SV_RESULTADO := 'TRUE';
	SV_MENSAJE := 'Abonado es Pospago';


	GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_param_entrada, string);
	LN_num_abonado := TO_NUMBER(string(5));

	SELECT plan.cod_tiplan
	INTO   LV_CODTIPLAN
	FROM   ga_abocel abo, ta_plantarif plan
	WHERE  abo.num_abonado = LN_NUM_ABONADO
	AND	   abo.cod_plantarif = plan.cod_plantarif;

	IF (LV_CODTIPLAN = '1') THEN
		SV_RESULTADO := 'FALSE';
		SV_MENSAJE := 'No es posible ejecutar OOSS para abonados prepagos';
	END IF;

	IF (LV_CODTIPLAN = '3') THEN
		SV_RESULTADO := 'FALSE';
		SV_MENSAJE := 'No es posible ejecutar OOSS para abonados hibridos';
	END IF;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		SV_RESULTADO := 'FALSE';
		SV_MENSAJE := 'No es posible ejecutar OOSS para abonados prepagos';
	WHEN OTHERS THEN
		SV_RESULTADO := 'FALSE';
		SV_MENSAJE := 'Ocurrio un error al validar al abonado PV_TIPOPLANABO_PR('||LN_NUM_ABONADO||'); - ' || SQLERRM;

END PV_VALIDAPOSPAGO_PR;
/****************************************************************************************************************************/

END PV_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
