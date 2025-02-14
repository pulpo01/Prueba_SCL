CREATE OR REPLACE PACKAGE BODY PV_CICLOS_FACTURACION_PG AS

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_ELIM_GA_FINCICLO_PR(EO_CICLOS_FAC     IN           PV_CICLOS_FACTURACION_QT,
                                 SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento     OUT NOCOPY	ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_ELIM_GA_FINCICLO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="14-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Elimina de la tabla GA_FINCICLO>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_CICLOS_FAC" Tipo="estructura"></param>>
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
	ERROR_EJECUCION    EXCEPTION;
    LV_OBS_DETALLE	   pv_param_abocel.OBS_DETALLE%TYPE;
	LN_CICLFACT_AUX    ga_finciclo.COD_CICLFACT%TYPE;
	LV_movimiento	   varchar2(09);
	LN_num_os		   number(10);
	LN_num_abonado	   number(8);
	LV_cod_os		   varchar2(5);
	LD_fechasys		   varchar2(30);
	LN_cliente		   number(8);
	LV_sqlcode		   varchar2(50);
	LV_sqlerrm		   varchar2(50);
	LV_error		   varchar2(50);
	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LN_num_os		  := EO_CICLOS_FAC.idOOSS;
		LV_cod_os		  := EO_CICLOS_FAC.codOOSS;
		LD_fechasys		  := EO_CICLOS_FAC.fechaEjecucion;
		LN_cliente		  := EO_CICLOS_FAC.codCliente;
		LN_num_abonado	  := EO_CICLOS_FAC.numAbonado;

		IF TRIM(LD_fechasys) IS NOT NULL OR trim(LD_fechasys)<>'' THEN

			LV_sSql:='DELETE GA_FINCICLO';
			LV_sSql:=LV_sSql||'WHERE NUM_ABONADO  = '|| LN_num_abonado;
			LV_sSql:=LV_sSql||'	AND   COD_CLIENTE  = ' ||LN_cliente;
			LV_sSql:=LV_sSql||' AND   COD_PLANTARIF IS NOT NULL';
			LV_sSql:=LV_sSql||'AND 	TO_CHAR(FEC_DESDELLAM,"DD-MM-YYYY")=TO_CHAR('||LD_fechasys||',''DD-MM-YYYY'')';

			DELETE GA_FINCICLO
			WHERE NUM_ABONADO  =  LN_num_abonado
			AND   COD_CLIENTE  = LN_cliente
			AND   COD_PLANTARIF IS NOT NULL
			AND TRUNC(FEC_DESDELLAM)=TO_date(LD_fechasys,'DD-MM-YYYY');

		END IF;

 	EXCEPTION

	  WHEN OTHERS THEN
 	      SN_cod_retorno := 156;
 	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 	         SV_mens_retorno := CV_error_no_clasif;
 	      END IF;
 		  LV_des_error   := 'PV_ELIM_GA_FINCICLO_PR('||EO_CICLOS_FAC.idOOSS||','||EO_CICLOS_FAC.codOOSS||','||EO_CICLOS_FAC.fechaEjecucion||','||EO_CICLOS_FAC.codCliente||','||EO_CICLOS_FAC.numAbonado||'); '||SQLERRM;
 	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_ELIM_GA_FINCICLO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ELIM_GA_FINCICLO_PR;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENER_FECHA_CICLO_PR (EO_FA_CICLFACT   IN OUT NOCOPY  PV_FA_CICLFACT_QT,
                                     SN_cod_retorno   OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno  OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento    OUT NOCOPY     ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTENER_FECHA_CICLO_PR "
	      Lenguaje="PL/SQL"
	      Fecha="14-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción> obtener Fecha Ciclo  GA_FINCICLO>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_FA_CICLFACT" Tipo="estructura"></param>>
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
		EO_FORMATO_FEC				PV_FORMATO_FEC_QT;
		LV_FORMATO					VARCHAR2(20);

	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
		SN_num_evento   := 0;
		EO_FORMATO_FEC := PV_INICIA_ESTRUCTURAS_PG.PV_FORMATO_FEC_QT_FN;

		LV_sSql:='SELECT GE_FN_DEVVALPARAM(''GE'', 1, ''FORMATO_SEL2'')';
		LV_sSql:=LV_sSql||'from dual';

		select ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2')
		  INTO EO_FORMATO_FEC.FORMATO
		from dual;

		LV_FORMATO:= EO_FORMATO_FEC.FORMATO;

		LV_sSql:='SELECT To_char(FEC_DESDEOCARGOS,'||LV_FORMATO||'), COD_CICLFACT';
		LV_sSql:=LV_sSql||' FROM  FA_CICLFACT';
		LV_sSql:=LV_sSql||' WHERE COD_CICLO = '||EO_FA_CICLFACT.COD_CICLO;
		LV_sSql:=LV_sSql||' AND   SYSDATE   <= FEC_DESDEOCARGOS';
		LV_sSql:=LV_sSql||' AND   IND_FACTURACION = '||CN_IND_FACTURACION;
		LV_sSql:=LV_sSql||' AND   ROWNUM   = 1';

		SELECT To_char(FEC_DESDEOCARGOS,LV_FORMATO)
		INTO   EO_FA_CICLFACT.FECHA_CICLO_FEC_DESDELLAM
		FROM  FA_CICLFACT
		WHERE	  COD_CICLO       = EO_FA_CICLFACT.COD_CICLO
			AND   SYSDATE        <= FEC_DESDEOCARGOS
			AND   IND_FACTURACION = CN_IND_FACTURACION
			AND   ROWNUM          = 1;

		LV_sSql:='SELECT COD_CICLFACT';
		LV_sSql:=LV_sSql||' FROM   FA_CICLFACT';
		LV_sSql:=LV_sSql||' WHERE  COD_CICLO = '||EO_FA_CICLFACT.COD_CICLO;
		LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDEOCARGOS AND NVL(FEC_HASTAOCARGOS, SYSDATE)';

		SELECT COD_CICLFACT
		INTO   EO_FA_CICLFACT.PERIODO_CICLO_COD_CICLFACT
		FROM   FA_CICLFACT
		WHERE  COD_CICLO = EO_FA_CICLFACT.COD_CICLO
			   AND SYSDATE BETWEEN FEC_DESDEOCARGOS AND NVL(FEC_HASTAOCARGOS, SYSDATE);

 	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTENER_FECHA_CICLO_PR('||EO_FA_CICLFACT.COD_CICLO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_OBTENER_FECHA_CICLO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 	  WHEN OTHERS THEN
 	      SN_cod_retorno := 156;
 	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 	         SV_mens_retorno := CV_error_no_clasif;
 	      END IF;
 		  LV_des_error   := 'PV_OBTENER_FECHA_CICLO_PR('||EO_FA_CICLFACT.COD_CICLO||'); '||SQLERRM;
 	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_OBTENER_FECHA_CICLO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTENER_FECHA_CICLO_PR;

-----------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDAR_PERIODOFACT_FN (EO_GA_ABONADO    IN          GA_ABONADO_QT,
                                    SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento    OUT NOCOPY  ge_errores_pg.evento) RETURN VARCHAR2
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_VALIDAR_PERIODOFACT_FN "
	      Lenguaje="PL/SQL"
	      Fecha="14-06-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Alejandro Díaz"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción> obtener Fecha Ciclo  GA_FINCICLO>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_GA_ABONADO" Tipo="estructura"></param>>
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
		ERROR_GA_INFACCEL      		EXCEPTION;
		VAR_CODCICLOFACT            FA_CICLFACT.COD_CICLFACT%TYPE;
		VAR_INFACC                  GA_INFACCEL.num_abonado%TYPE;
		Reg_fa_ciclfact				PV_TIPOS_PG.R_FA_CICLFACT;
	BEGIN
		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
		SN_num_evento   := 0;

		LV_sSql:='SELECT COD_CICLFACT ';
		LV_sSql:=LV_sSql||' FROM FA_CICLFACT ';
		LV_sSql:=LV_sSql||' WHERE COD_CICLO = '||EO_GA_ABONADO.COD_CICLO||' ';
		LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDEOCARGOS AND FEC_HASTAOCARGOS';

		SELECT COD_CICLFACT
        INTO VAR_CODCICLOFACT
        FROM FA_CICLFACT
        WHERE COD_CICLO = EO_GA_ABONADO.COD_CICLO
        AND SYSDATE BETWEEN FEC_DESDEOCARGOS AND FEC_HASTAOCARGOS;

       IF (VAR_CODCICLOFACT IS NOT NULL ) THEN
			BEGIN
				LV_sSql:='SELECT NUM_ABONADO ';
				LV_sSql:=LV_sSql||' FROM  GA_INFACCEL ';
				LV_sSql:=LV_sSql||' WHERE COD_CLIENTE   = '||EO_GA_ABONADO.COD_CLIENTE||' ';
				LV_sSql:=LV_sSql||' AND   NUM_ABONADO   = '||EO_GA_ABONADO.NUM_ABONADO||' ';
				LV_sSql:=LV_sSql||' AND   COD_CICLFACT  = '||VAR_CODCICLOFACT||' ';
				LV_sSql:=LV_sSql||' AND   SYSDATE BETWEEN FEC_ALTA AND FEC_BAJA;';

				SELECT NUM_ABONADO
				INTO   VAR_INFACC
				FROM   GA_INFACCEL
				WHERE  COD_CLIENTE   = EO_GA_ABONADO.COD_CLIENTE
				AND    NUM_ABONADO   = EO_GA_ABONADO.NUM_ABONADO
				AND    COD_CICLFACT  = VAR_CODCICLOFACT
				AND    SYSDATE BETWEEN FEC_ALTA AND FEC_BAJA;

			EXCEPTION
			WHEN NO_DATA_FOUND THEN
				  SN_cod_retorno := 1410;
			      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			         SV_mens_retorno := CV_error_no_clasif;
			      END IF;
				  LV_des_error   := 'PV_VALIDAR_PERIODOFACT_FN('||to_char(Reg_fa_ciclfact(1).COD_CICLO)||','||to_char(Reg_fa_ciclfact(1).IND_FACTURACION)||'); '||SQLERRM;
			      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_VALIDAR_PERIODOFACT_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
				  RETURN 'FALSE';
			END;
	    END IF;

	   RETURN  'TRUE';

 	EXCEPTION
		WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1411;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_VALIDAR_PERIODOFACT_FN('||EO_GA_ABONADO.COD_CICLO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_VALIDAR_PERIODOFACT_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN 'FALSE';
 	  WHEN OTHERS THEN
 	      SN_cod_retorno := 156;
 	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 	         SV_mens_retorno := CV_error_no_clasif;
 	      END IF;
 		  LV_des_error   := ' PV_VALIDAR_PERIODOFACT_FN('||EO_GA_ABONADO.COD_CICLO||'); '||SQLERRM;
 	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CICLOS_FACTURACION_PG.PV_VALIDAR_PERIODOFACT_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN 'FALSE';
END PV_VALIDAR_PERIODOFACT_FN;

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_getDiasProrrateo_PR(EV_codCiclo      IN         VARCHAR2,
                                 EV_formatoFecha  IN         VARCHAR2,
                                 SV_diasProrrateo OUT NOCOPY VARCHAR2,
                                 SV_cantDias      OUT NOCOPY VARCHAR2,
                                 SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "PV_getDiasProrrateo_PR"
			Lenguaje="PL/SQL"
			Fecha="11-09-2007"
			Versión="1.0.0"
			Diseñador="wjrc"
			Programador="wjrc"
			Ambiente="BD"
		<Retorno>
				  Retorna numero de dias prorrateo para el abonado
		</Retorno>
		<Descripción>
				  Retorna numero de dias prorrateo para el abonado
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom="EV_codCiclo"     Tipo="STRING"> codigo ciclo </param>
			   <param nom="EV_formatoFecha" Tipo="STRING"> formato fecha </param>
			 </Entrada>
	         <Salida>
	           <param nom="SV_diasProrrateo" Tipo="STRING"> numero dias prorrateo </param>
			   <param nom="SV_cantDias"      Tipo="STRING"> cantidad de dias</param>
			   <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
	           <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
	           <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;
		SV_diasProrrateo := NULL;
		SV_cantDias := NULL;

		LV_Sql:= 'SELECT a.dia_periodo,'
		      || ' (TO_DATE(TO_CHAR(a.fec_hastallam,''' || EV_formatoFecha || '''),'''|| EV_formatoFecha||''') - TO_DATE(TO_CHAR(SYSDATE,''' || EV_formatoFecha || '''),'''|| EV_formatoFecha||''')) + 1'
		      || ' FROM fa_ciclfact a'
		      || ' WHERE a.cod_ciclo =' || EV_codCiclo
		      || ' AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam';


		SELECT a.dia_periodo,
	    (TO_DATE(TO_CHAR(a.fec_hastallam,EV_formatoFecha),EV_formatoFecha) - TO_DATE(TO_CHAR(SYSDATE,EV_formatoFecha),EV_formatoFecha)) + 1
	    INTO SV_diasProrrateo, SV_cantDias
	    FROM fa_ciclfact a
	    WHERE a.cod_ciclo = EV_codCiclo
	    AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam;

	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_error_no_clasif;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:PV_CICLOS_FACTURACION_PG.PV_getDiasProrrateo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_cod_modulo, SV_menRetorno, CV_version, USER,
				'PV_CICLOS_FACTURACION_PG.FA_getDiasProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_error_no_clasif;
				END IF;
				LV_desError  := 'OTHERS:PV_CICLOS_FACTURACION_PG.PV_getDiasProrrateo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_cod_modulo,SV_menRetorno, CV_version, USER,
				'PV_CICLOS_FACTURACION_PG.PV_getDiasProrrateo_PR', LV_Sql, SQLCODE, LV_desError );
	END PV_getDiasProrrateo_PR;
-----------------------------------------------------------------------------------------------------------
END PV_CICLOS_FACTURACION_PG;
/
SHOW ERRORS
