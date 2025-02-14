CREATE OR REPLACE PACKAGE BODY PV_DATOS_ABONADO2_PG AS

------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_DATOS_ABONADO_PR(SO_Abonado         	IN OUT NOCOPY	GA_Abonado2_QT,
								      SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								      SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								      SN_num_evento            OUT NOCOPY	ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_DATOS_ABONADO_PR
	      Lenguaje="PL/SQL"
	      Fecha="04-06-2007"
	      Versión="La del package"
	      Diseñador="Matías Guajardo"
	      Programador="Matías Guajardo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
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
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := ' ';
	    sn_num_evento 	:= 0;

LV_sSql:= LV_sSql||'SELECT a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion,';
LV_sSql:= LV_sSql||'   d.des_situacion,';
LV_sSql:= LV_sSql||'   b.tip_plantarif,';
LV_sSql:= LV_sSql||'   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
LV_sSql:= LV_sSql||'   b.cod_plantarif,';
LV_sSql:= LV_sSql||'   c.des_plantarif,';
LV_sSql:= LV_sSql||'   b.cod_ciclo,';
LV_sSql:= LV_sSql||'   c.cod_limconsumo,';
LV_sSql:= LV_sSql||'   e.des_limconsumo,';
LV_sSql:= LV_sSql||'   b.cod_planserv,';
LV_sSql:= LV_sSql||'   b.cod_uso,';
LV_sSql:= LV_sSql||'   c.cod_tiplan,';
LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
LV_sSql:= LV_sSql||'   b.cod_tipcontrato,b.fec_alta,b.fec_fincontra,b.ind_eqprestado,b.fec_prorroga,c.flg_rango,f.imp_cargobasico,';
LV_sSql:= LV_sSql||'   b.num_anexo,';
LV_sSql:= LV_sSql||'   b.cod_usuario,';
LV_sSql:= LV_sSql||'   b.tip_terminal,';
LV_sSql:= LV_sSql||'   g.des_terminal,';
LV_sSql:= LV_sSql||'   b.num_venta';
LV_sSql:= LV_sSql||' FROM ge_clientes a,';
LV_sSql:= LV_sSql||'   ga_abocel b,';
LV_sSql:= LV_sSql||'   ta_plantarif c,';
LV_sSql:= LV_sSql||'   ga_situabo d,';
LV_sSql:= LV_sSql||'   ta_limconsumo e,';
LV_sSql:= LV_sSql||'   ta_cargosbasico f';
LV_sSql:= LV_sSql||'   al_tipos_terminales g';
LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
LV_sSql:= LV_sSql||'   AND a.cod_cliente   = b.cod_cliente';
LV_sSql:= LV_sSql||'   AND b.cod_plantarif = c.cod_plantarif';
LV_sSql:= LV_sSql||'   AND b.cod_situacion = d.cod_situacion';
LV_sSql:= LV_sSql||'   AND e.cod_limconsumo = c.cod_limconsumo';
LV_sSql:= LV_sSql||'   AND c.cod_cargobasico = f.cod_cargobasico';
LV_sSql:= LV_sSql||'   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
LV_sSql:= LV_sSql||'   AND rownum=1';
LV_sSql:= LV_sSql||' UNION';
LV_sSql:= LV_sSql||' SELECT a.cod_cliente,';
LV_sSql:= LV_sSql||'   b.num_abonado,';
LV_sSql:= LV_sSql||'   b.num_celular,';
LV_sSql:= LV_sSql||'   b.num_serie,';
LV_sSql:= LV_sSql||'   b.num_imei,';
LV_sSql:= LV_sSql||'   b.cod_tecnologia,';
LV_sSql:= LV_sSql||'   b.cod_situacion,';
LV_sSql:= LV_sSql||'   d.des_situacion,';
LV_sSql:= LV_sSql||'   b.tip_plantarif,';
LV_sSql:= LV_sSql||'   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
LV_sSql:= LV_sSql||'   b.cod_plantarif,';
LV_sSql:= LV_sSql||'   c.des_plantarif,';
LV_sSql:= LV_sSql||'   b.cod_ciclo,';
LV_sSql:= LV_sSql||'   c.cod_limconsumo,';
LV_sSql:= LV_sSql||'   e.des_limconsumo,';
LV_sSql:= LV_sSql||'   b.cod_planserv,';
LV_sSql:= LV_sSql||'   b.cod_uso,';
LV_sSql:= LV_sSql||'   c.cod_tiplan,';
LV_sSql:= LV_sSql||'   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
LV_sSql:= LV_sSql||'   b.cod_tipcontrato,';
LV_sSql:= LV_sSql||'   b.fec_alta,';
LV_sSql:= LV_sSql||'   b.fec_fincontra,';
LV_sSql:= LV_sSql||'   null ind_eqprestado,';
LV_sSql:= LV_sSql||'   null fec_prorroga,';
LV_sSql:= LV_sSql||'   c.flg_rango,';
LV_sSql:= LV_sSql||'   f.imp_cargobasico,';
LV_sSql:= LV_sSql||'   b.num_anexo,';
LV_sSql:= LV_sSql||'   b.cod_usuario,';
LV_sSql:= LV_sSql||'   b.tip_terminal,';
LV_sSql:= LV_sSql||'   g.des_terminal,';
LV_sSql:= LV_sSql||'   b.num_venta';
LV_sSql:= LV_sSql||' FROM ge_clientes a,';
LV_sSql:= LV_sSql||'   ga_aboamist b,';
LV_sSql:= LV_sSql||'   ta_plantarif c,';
LV_sSql:= LV_sSql||'   ga_situabo d,';
LV_sSql:= LV_sSql||'   ta_limconsumo e,';
LV_sSql:= LV_sSql||'   ta_cargosbasico f,';
LV_sSql:= LV_sSql||'   al_tipos_terminales g';
LV_sSql:= LV_sSql||' WHERE b.num_abonado = '||SO_Abonado.num_abonado;
LV_sSql:= LV_sSql||'  AND a.cod_cliente   = b.cod_cliente';
LV_sSql:= LV_sSql||'  AND b.cod_plantarif = c.cod_plantarif';
LV_sSql:= LV_sSql||'  AND b.cod_situacion = d.cod_situacion';
LV_sSql:= LV_sSql||'  AND e.cod_limconsumo = c.cod_limconsumo';
LV_sSql:= LV_sSql||'  AND c.cod_cargobasico = f.cod_cargobasico';
LV_sSql:= LV_sSql||'  AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
LV_sSql:= LV_sSql||'  AND rownum=1';

		SELECT a.cod_cliente,
			   b.num_abonado,
			   b.num_celular,
			   b.num_serie,
			   b.num_imei,
			   b.cod_tecnologia,
			   b.cod_situacion,
			   d.des_situacion,
			   b.tip_plantarif,
			   DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
			   b.cod_plantarif,
			   c.des_plantarif,
			   b.cod_ciclo,
			   c.cod_limconsumo,
			   e.des_limconsumo,
			   b.cod_planserv,
			   b.cod_uso,
			   c.cod_tiplan,
			   DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
			   b.cod_tipcontrato,
			   b.fec_alta,
			   b.fec_fincontra,
			   b.ind_eqprestado,
			   b.fec_prorroga,
			   c.flg_rango,
			   f.imp_cargobasico,
			   b.num_anexo,
			   b.cod_usuario,
			   b.tip_terminal,
			   g.des_terminal,
			   b.num_venta,
			   b.cod_cuenta,
			   b.cod_subcuenta,
			   b.cod_vendedor,
			   b.cod_causa_venta,
			   b.fec_baja,
			   b.fec_bajacen,
			   b.fec_ultmod,
			   b.cod_empresa,
			   b.fec_acepventa,
			   b.num_contrato,
			   b.cod_modventa,
			   b.cod_cargobasico,
			   b.cod_central,
			   b.ind_disp
		INTO   SO_Abonado.cod_cliente,
			   SO_Abonado.num_abonado,
			   SO_Abonado.num_celular,
			   SO_Abonado.num_serie,
			   SO_Abonado.num_simcard,
			   SO_Abonado.cod_tecnologia,
			   SO_Abonado.cod_situacion,
			   SO_Abonado.des_situacion,
 			   SO_Abonado.tip_plantarif,
			   SO_Abonado.des_tipplantarif,
			   SO_Abonado.cod_plantarif,
			   SO_Abonado.des_plantarif,
			   SO_Abonado.cod_ciclo,
 			   SO_Abonado.cod_limconsumo,
			   SO_Abonado.des_limconsumo,
			   SO_Abonado.cod_planserv,
			   SO_Abonado.cod_uso,
			   SO_Abonado.cod_tiplan,
			   SO_Abonado.des_tiplan,
			   SO_Abonado.cod_tipcontrato,
			   SO_Abonado.fecha_alta,
			   SO_Abonado.fec_fincontra,
			   SO_Abonado.ind_eqprestado,
			   SO_Abonado.fecha_prorroga,
			   SO_Abonado.flg_rango,
			   SO_Abonado.imp_cargobasico,
			   SO_Abonado.num_anexo,
			   SO_Abonado.cod_usuario,
			   SO_Abonado.tip_terminal,
			   SO_Abonado.des_terminal,
			   SO_Abonado.num_venta,
			   SO_Abonado.cod_cuenta,
			   SO_Abonado.cod_subcuenta,
			   SO_Abonado.cod_vendedor,
			   SO_Abonado.cod_causa_venta,
			   SO_Abonado.fecha_baja,
			   SO_Abonado.fecha_bajacen,
			   SO_Abonado.fecha_ultmod,
			   SO_Abonado.cod_empresa,
			   SO_Abonado.fecha_acepventa,
			   SO_Abonado.num_contrato,
			   SO_Abonado.modalidad_de_pago,
			   SO_Abonado.cod_cargobasico,
			   SO_Abonado.cod_central,
			   SO_Abonado.ind_disp
		 FROM ge_clientes a,
			   ga_abocel b,
			   ta_plantarif c,
			   ga_situabo d,
			   ta_limconsumo e,
			   ta_cargosbasico f,
			   al_tipos_terminales g
		 WHERE b.num_abonado = SO_Abonado.num_abonado
		   AND a.cod_cliente   = b.cod_cliente
		   AND b.cod_plantarif = c.cod_plantarif
		   AND b.cod_situacion = d.cod_situacion
		   AND b.tip_terminal = g.tip_terminal
		   AND e.cod_limconsumo = c.cod_limconsumo
		   AND c.cod_cargobasico = f.cod_cargobasico
		   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
		   AND rownum=1
		 UNION
		 		SELECT a.cod_cliente,
			   b.num_abonado,
			   b.num_celular,
			   b.num_serie,
			   b.num_imei,
			   b.cod_tecnologia,
			   b.cod_situacion,
			   d.des_situacion,
			   b.tip_plantarif,
			   DECODE(b.tip_plantarif,'E','EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif,
			   b.cod_plantarif,
			   c.des_plantarif,
			   b.cod_ciclo,
			   c.cod_limconsumo,
			   e.des_limconsumo,
			   b.cod_planserv,
			   b.cod_uso,
			   c.cod_tiplan,
			   DECODE(c.cod_tiplan,'1','PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan,
			   b.cod_tipcontrato,
			   b.fec_alta,
			   b.fec_fincontra,
			   null ind_eqprestado,
			   null fec_prorroga,
			   c.flg_rango,
			   f.imp_cargobasico,
			   b.num_anexo,
			   b.cod_usuario,
			   b.tip_terminal,
			   g.des_terminal,
			   b.num_venta,
			   b.cod_cuenta,
			   b.cod_subcuenta,
			   b.cod_vendedor,
			   b.cod_causa_venta,
			   b.fec_baja,
			   b.fec_bajacen,
			   b.fec_ultmod,
			   b.cod_empresa,
			   b.fec_acepventa,
			   b.num_contrato,
			   b.cod_modventa,
			   b.cod_cargobasico,
			   b.cod_central,
			   b.ind_disp
		 FROM ge_clientes a,
			   ga_aboamist b,
			   ta_plantarif c,
			   ga_situabo d,
			   ta_limconsumo e,
			   ta_cargosbasico f,
   			   al_tipos_terminales g
		 WHERE b.num_abonado = SO_Abonado.num_abonado
		   AND a.cod_cliente   = b.cod_cliente
		   AND b.cod_plantarif = c.cod_plantarif
		   AND b.cod_situacion = d.cod_situacion
		   AND b.tip_terminal = g.tip_terminal
		   AND e.cod_limconsumo = c.cod_limconsumo
		   AND c.cod_cargobasico = f.cod_cargobasico
		   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta
		   AND rownum=1;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_ABONADO_PR('||SO_Abonado.num_abonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_DATOS_ABONADO_PR;
PROCEDURE PV_OBTIENE_CELDA_ABONADO_PR (EN_NumAbonado           IN           GA_ABOCEL.NUM_ABONADO%TYPE,
								       SV_CodCelda             OUT NOCOPY   GA_ABOCEL.COD_CELDA%TYPE, 
                                       SN_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento           OUT NOCOPY	ge_errores_pg.evento)
IS
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := ' ';
	    sn_num_evento 	:= 0;

LV_sSql:= LV_sSql||'SELECT a.cod_celda';
LV_sSql:= LV_sSql||' FROM ga_abocel a';
LV_sSql:= LV_sSql||' WHERE a.num_abonado = '|| EN_NumAbonado;

		SELECT a.cod_celda
        INTO SV_CodCelda
		FROM  ga_abocel a
		WHERE a.num_abonado = EN_NumAbonado;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 203;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_CELDA_ABONADO_PR('||EN_NumAbonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_CELDA_ABONADO_PR('||EN_NumAbonado||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_CELDA_ABONADO_PR;


--------------------------------------------------------------------------------------------------------
END PV_DATOS_ABONADO2_PG;
/
SHOW ERROR
