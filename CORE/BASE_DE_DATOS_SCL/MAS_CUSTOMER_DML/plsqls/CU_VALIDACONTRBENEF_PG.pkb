CREATE OR REPLACE PACKAGE BODY CU_VALIDACONTRBENEF_PG

AS

	PROCEDURE CU_VALVETADOSCONTRA_PR(
	 	EN_cod_cliente  in cu_vetados_prod_to.COD_CLIENTE%TYPE,
		EN_num_abonado  in cu_vetados_prod_to.NUM_ABONADO%TYPE,
		SN_resultado   OUT NOCOPY	Number,
		SV_mensaje	   OUT NOCOPY	ge_errores_pg.MsgError
	 )
	IS

	LN_vetado NUMBER(10);

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN

		SV_mensaje:='El abonado se encuentra vetado para contratar planes adicionales';
		LN_vetado := 0;
		SN_resultado := 9;

	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;

		LV_sSQL :=' select count(1)';
		LV_sSQL := LV_sSQL || ' from   cu_vetados_prod_to';
		LV_sSQL := LV_sSQL || ' where  cod_cliente   = ' || EN_cod_cliente ;
		LV_sSQL := LV_sSQL || ' and    num_abonado   = ' || EN_num_abonado ;
		LV_sSQL := LV_sSQL || ' and    sysdate between fec_inicio_vigencia and fec_termino_vigencia;';

	BEGIN
		select count(1)
		into LN_vetado
		from   cu_vetados_prod_to
		where  cod_cliente   = EN_cod_cliente -- código de cliente asociado al contratante
		and    num_abonado   = EN_num_abonado -- código de abonado asociado al contratante
		and    sysdate between fec_inicio_vigencia and fec_termino_vigencia;

		IF LN_vetado=0 THEN
		 	SV_mensaje:='OK';
			SN_resultado := 0;
		END IF;
	EXCEPTION

	WHEN OTHERS then
			 SN_resultado := 9;
			 LN_cod_retorno := 467;
			 LV_des_error := 'CU_VALIDACONTRBENEF_PG.CU_VALVETADOSCONTRA_PR()' || SQLERRM;
  			 IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			     SV_mensaje := CV_error_no_clasif;
  			 END IF;
  			 LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  					   CV_cod_modulo,
													   SV_mensaje,
													   CV_version, USER,
													   'CU_VALIDACONTRBENEF_PG.CU_VALVETADOSCONTRA_PR',
													   LV_sSQL, LN_cod_retorno, LV_des_error );
	END;


	END CU_VALVETADOSCONTRA_PR;

	PROCEDURE CU_VALIDABENEFICIARIO_PR(
	  		EN_cod_cliente 		 in cu_vetados_prod_to.COD_CLIENTE%TYPE,
			EN_num_abonado_con   in cu_vetados_prod_to.NUM_ABONADO%TYPE,
			EN_num_abonado_ben   in cu_vetados_prod_to.NUM_ABONADO%TYPE,
			SN_resultado   		 OUT NOCOPY	Number,
			SV_mensaje	   		 OUT NOCOPY	ge_errores_pg.MsgError
	)
	IS

	LN_beneficioAbonado NUMBER(10);

	LV_sSQL            ge_errores_pg.vQuery;
	LN_num_evento      ge_errores_pg.Evento;
	LN_cod_retorno     ge_errores_pg.CodError;
	LV_des_error       ge_errores_pg.DesEvent;

	BEGIN
		SV_mensaje:='OK';
	    LN_cod_retorno := 0;
	    LN_num_evento  := 0;
		LN_beneficioAbonado	:= 0;

		LV_sSQL :=' select count(1) ';
		LV_sSQL := LV_sSQL || ' from   cu_benef_prod_to';
		LV_sSQL := LV_sSQL || ' where  cod_cliente_contratante  = ' || EN_cod_cliente;
		LV_sSQL := LV_sSQL || ' and    num_abonado_contratante  = ' || EN_num_abonado_con;
		LV_sSQL := LV_sSQL || ' and    num_abonado_beneficiario = ' || EN_num_abonado_ben;
		LV_sSQL := LV_sSQL || ' and    sysdate  between fec_inicio_vigencia and fec_termino_vigencia;';

		BEGIN
			select count(1)
			into LN_beneficioAbonado
			from   cu_benef_prod_to
			where  cod_cliente_contratante  = EN_cod_cliente -- código de cliente asociado al contratante
			and    num_abonado_contratante  = EN_num_abonado_con -- código de abonado asociado al contratante
			and    num_abonado_beneficiario = EN_num_abonado_ben  -- código de abonado asociado al beneficiario
			and    sysdate  between fec_inicio_vigencia and fec_termino_vigencia;

		    IF 	LN_beneficioAbonado	=0 then
				LN_beneficioAbonado:=0;
				SN_resultado := 9;
				SV_mensaje:='El abonado beneficiario no esta registrado como beneficiario';
		    END IF;

		exception
		WHEN OTHERS then
			 SN_resultado := 9;
			 LN_cod_retorno := 1;
			 LV_des_error := 'CU_VALIDACONTRBENEF_PG.CU_VALIDABENEFICIARIO_PR()' || SQLERRM;
  			 IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mensaje) THEN
  			     SV_mensaje := CV_error_no_clasif;
  			 END IF;
  			 LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento,
							   	  					   CV_cod_modulo,
													   SV_mensaje,
													   CV_version, USER,
													   'CU_VALIDACONTRBENEF_PG.CU_VALIDABENEFICIARIO_PR',
													   LV_sSQL, LN_cod_retorno, LV_des_error );
		END;
	END CU_VALIDABENEFICIARIO_PR;


END CU_VALIDACONTRBENEF_PG;
/
SHOW ERRORS
