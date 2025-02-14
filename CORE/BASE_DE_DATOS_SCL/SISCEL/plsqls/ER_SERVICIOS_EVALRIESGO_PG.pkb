CREATE OR REPLACE PACKAGE BODY ER_servicios_evalriesgo_PG IS

	--------------------------------------------------------------------------------------------
	-- PROCEDIMIENTOS --
	--------------------------------------------------------------------------------------------

	PROCEDURE ER_getRegEvaluacionRiesgo_PR(EV_numIdent     IN  ert_solicitud_campos.num_ident%TYPE,
									       SV_nomCliente   OUT NOCOPY ert_solicitud_campos.nombre_cliente%TYPE,
									       SV_desNombre    OUT NOCOPY ert_solicitud_campos.des_nombre%TYPE,
									       SV_priApellido  OUT NOCOPY ert_solicitud_campos.primer_apellido%TYPE,
									       SV_segApellido  OUT NOCOPY ert_solicitud_campos.segundo_apellido%TYPE,
									       SV_codTipIdent  OUT NOCOPY ert_solicitud_campos.cod_tipident%TYPE,
										   SN_numSolicitud OUT NOCOPY ert_solicitud_campos.num_solicitud%TYPE,
								 	       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getRegEvaluacionRiesgo_PR'
			Lenguaje='PL/SQL'
			Fecha='22-05-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
		</Retorno>
		<Descripción>
				  Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom='EV_numIdent' Tipo='STRING'> numero de identificacion </param>
			 </Entrada>
	         <Salida>
			   <param nom='SV_nomCliente'   Tipo='STRING'> nombre del cliente </param>
			   <param nom='SV_desNombre'    Tipo='STRING'> descripcion del nombre </param>
			   <param nom='SV_priApellido'  Tipo='STRING'> primer apellido </param>
			   <param nom='SV_segApellido'  Tipo='STRING'> segundo apellido </param>
			   <param nom='SV_codTipIdent'  Tipo='STRING'> codigo  tipo identificacion </param>
	           <param nom='SN_numSolicitud' Tipo='NUMBER'> numero solicitud </param>
			   <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
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

		LV_Sql:='SELECT a.nombre_cliente,a.des_nombre,a.primer_apellido,a.segundo_apellido,a.cod_tipident,SN_numSolicitud '
			|| 'FROM ert_solicitud_campos a '
			|| 'WHERE a.num_ident = ' || EV_numIdent;

		SELECT a.nombre_cliente,
		       a.des_nombre,
			   a.primer_apellido,
			   a.segundo_apellido,
			   a.cod_tipident,
			   a.num_solicitud
	    INTO SV_nomCliente,
		     SV_desNombre,
			 SV_priApellido,
			 SV_segApellido,
			 SV_codTipIdent,
			 SN_numSolicitud
		FROM ert_solicitud_campos a
		WHERE a.num_ident = EV_numIdent;

	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:ER_servicios_evalriesgo_PG.ER_getRegEvaluacionRiesgo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getRegEvaluacionRiesgo_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getRegEvaluacionRiesgo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getRegEvaluacionRiesgo_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getRegEvaluacionRiesgo_PR;

	PROCEDURE ER_getListPlanTarifAutoriz_PR(EN_numSolicitud IN  ert_solicitud_planes.num_solicitud%TYPE,
									        SC_cursorDatos  OUT NOCOPY REFCURSOR,
								 	        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getListPlanTarifAutoriz_PR'
			Lenguaje='PL/SQL'
			Fecha='17-05-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Retorna lista planes tarifario autorizados
		</Retorno>
		<Descripción>
				  Retorna lista planes tarifario autorizados
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom='EN_numSolicitud' Tipo='NUMBER'> numero de solicitud </param>
			 </Entrada>
	         <Salida>
			   <param nom='SC_cursorDatos' Tipo='STRING'> cursor planes tarifario </param>
			   <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		NO_DATA_FOUND_CURSOR EXCEPTION;
		LV_desError  ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
		LN_contador  NUMBER;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='SELECT a.cod_plantarif '
			|| 'FROM ert_solicitud_planes a '
			|| 'WHERE a.num_solicitud = ' || EN_numSolicitud
			|| '  AND a.val_cant_terminales > a.val_cant_vendidos ';

		LN_contador := 0;
		SELECT COUNT(1)
		INTO LN_contador
		FROM ert_solicitud_planes a
		WHERE a.num_solicitud = EN_numSolicitud
	  	  AND a.val_cant_terminales > a.val_cant_vendidos;

		OPEN SC_cursorDatos FOR
		SELECT a.cod_plantarif
		FROM ert_solicitud_planes a
		WHERE a.num_solicitud = EN_numSolicitud
	  	  AND a.val_cant_terminales > a.val_cant_vendidos;

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:ER_servicios_evalriesgo_PG.ER_getListPlanTarifAutoriz_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_PG.ER_getListPlanTarifAutoriz_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:ER_servicios_evalriesgo_PG.ER_getListPlanTarifAutoriz_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getPlanTarifAutorizado_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getListPlanTarifAutoriz_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getListPlanTarifAutoriz_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getListPlanTarifAutoriz_PR;

	PROCEDURE ER_getExcepcion_PR(EV_numIdent     IN  erd_excepcion.num_ident%TYPE,
							     EV_codTipIdent  IN  erd_excepcion.cod_tipident%TYPE,
								 SN_codRestricc  OUT NOCOPY erd_excepcion.cod_restric%TYPE,
								 SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
	                       		 SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
	                       		 SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getExcepcion_PR'
			Lenguaje='PL/SQL'
			Fecha='22-05-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Retorna si existe excepcion para numero identificacion.
		</Retorno>
		<Descripción>
				  Retorna si existe excepcion para numero identificacion.
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom='EV_numIdent'    Tipo='STRING'> numero de identificacion </param>
			   <param nom='EV_codTipIdent' Tipo='STRING'> codigo tipo identificador </param>
			 </Entrada>
	         <Salida>
			   <param nom='SN_codRestricc' Tipo='NUMBER'> codigo de restriccion </param>
			   <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
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

		LV_Sql:='SELECT a.cod_restric '
			|| 'FROM erd_excepcion a '
			|| 'WHERE a.cod_tipident = ' || EV_codTipIdent
			|| 'AND a.num_ident = ' || EV_numIdent;

		SELECT a.cod_restric
		INTO SN_codRestricc
		FROM erd_excepcion a
		WHERE a.cod_tipident = EV_codTipIdent
		AND a.num_ident = EV_numIdent;

	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:ER_servicios_evalriesgo_PG.ER_getExcepcion_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getExcepcion_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getExcepcion_PR;

	PROCEDURE ER_getListPlanTarif_PR(EV_codTipIdentif IN VARCHAR2,
	                                 EV_numIdentif    IN VARCHAR2,
												EV_indTipoSolicitud IN ert_solicitud.ind_tipo_solicitud%TYPE, -- DEBE SER 1
									         SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		      SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		      SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getListPlanTarif_PR'
			Lenguaje='PL/SQL'
			Fecha='06-06-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Cursor
		</Retorno>
		<Descripción>
				  Retorna lista planes tarifario segun numero identificador y evaluacion de riesgo
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom='EV_codTipIdentif' Tipo='STRING'>  Dcodigo tipo identificador </param>
	           <param nom='EV_numIdentif'    Tipo='STRING'> numero identificador </param>
				  <param nom='EV_indTipoSolicitud' Tipo='STRING'> Indentifica el tipo de solicitud 0 o 1</param>
			 </Entrada>
	         <Salida>
			   <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
			   <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		NO_DATA_FOUND_CURSOR EXCEPTION;
		LV_desError  ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;
		LN_contador  NUMBER;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		LV_Sql:='SELECT planes.cod_plantarif, planes.des_plantarif, solicitudes.num_solicitud '
            || 'FROM ert_solicitud_planes solplanes,ta_plantarif planes, ert_solicitud solicitudes '
				|| 'WHERE solplanes.cod_plantarif = planes.cod_plantarif '
				|| 'AND solplanes.num_solicitud = solicitudes.num_solicitud '
				|| 'AND solicitudes.cod_tipident =' || EV_codTipIdentif
				|| 'AND solicitudes.num_ident_cliente =' || EV_numIdentif
				|| 'AND solicitudes.ind_tipo_solicitud =' || EV_indTipoSolicitud
				|| 'AND solicitudes.COD_ESTADO IN (1,2,3)';

		LN_contador := 0;
		SELECT COUNT(1)
		INTO LN_contador
		FROM ert_solicitud_planes solplanes,ta_plantarif planes, ert_solicitud solicitudes
	   WHERE solplanes.cod_plantarif = planes.cod_plantarif
      AND solplanes.num_solicitud = solicitudes.num_solicitud
  		AND solicitudes.cod_tipident = EV_codTipIdentif
		AND solicitudes.num_ident_cliente = EV_numIdentif
		AND solicitudes.ind_tipo_solicitud = EV_indTipoSolicitud
      AND solicitudes.COD_ESTADO IN (1,2,3);

		OPEN SC_cursorDatos FOR
		SELECT planes.cod_plantarif, planes.des_plantarif, solicitudes.num_solicitud
		FROM ert_solicitud_planes solplanes,ta_plantarif planes, ert_solicitud solicitudes
	   WHERE solplanes.cod_plantarif = planes.cod_plantarif
      AND solplanes.num_solicitud = solicitudes.num_solicitud
  		AND solicitudes.cod_tipident = EV_codTipIdentif
		AND solicitudes.num_ident_cliente = EV_numIdentif
		AND solicitudes.ind_tipo_solicitud = EV_indTipoSolicitud
      AND solicitudes.COD_ESTADO IN (1,2,3);

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getListPlanTarif_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getListPlanTarif_PR;


	PROCEDURE ER_getEvRiesgoVigente_PR(
	                                   EV_codTipIdentif IN VARCHAR2,
	                                   EV_numIdentif    IN VARCHAR2,
												  EV_indTipoSolicitud IN ert_solicitud.ind_tipo_solicitud%TYPE, -- DEBE SER 1
	                                   SN_numSolicitud  OUT NOCOPY ert_solicitud.num_solicitud%TYPE,
												  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		        SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento
												 ) IS

		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getEvRiesgoVigente_PR'
			Lenguaje='PL/SQL'
			Fecha='06-06-2007'
			Versión='1.0.0'
			Diseñador='Fernando García'
			Programador='ernando García''
			Ambiente='BD'
		<Retorno>
				  Retornas la evaluación de riesgo vigente para un número y tipo de identificación
		</Retorno>
		<Descripción>
				  Retornas la evaluación de riesgo vigente para un número y tipo de identificación
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom='EV_codTipIdentif' Tipo='STRING'>  Dcodigo tipo identificador </param>
	           <param nom='EV_numIdentif'    Tipo='STRING'> numero identificador </param>
				  <param nom='EV_indTipoSolicitud' Tipo='STRING'> Indentifica el tipo de solicitud 0 o 1</param>
			 </Entrada>
	         <Salida>
			   <param nom='SSN_numSolicitud' Tipo='NUMBER'> número de solicitud vigente </param>
			   <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/


		LV_desError  ge_errores_pg.desevent;
		LV_sql		 ge_errores_pg.vquery;

	BEGIN

	   SN_codRetorno:= 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

      LV_sql := 'SELECT solicitudes.num_solcitud '
          || 'FROM ert_solicitud solicitudes '
          || 'WHERE solicitudes.cod_tipident =' || EV_codTipIdentif
          || 'AND solicitudes.num_ident_cliente =' || EV_numIdentif
          || 'AND solicitudes.ind_tipo_solicitud = ' || EV_indTipoSolicitud
          || 'AND solicitudes.COD_ESTADO IN (1,2,3) ';


      SELECT solicitudes.num_solicitud
		INTO SN_numSolicitud
		FROM ert_solicitud solicitudes
		WHERE solicitudes.cod_tipident = EV_codTipIdentif
		AND solicitudes.num_ident_cliente = EV_numIdentif
		AND solicitudes.ind_tipo_solicitud = EV_indTipoSolicitud
      AND solicitudes.COD_ESTADO IN (1,2,3);

	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
				SN_codRetorno := 1;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'NO_DATA_FOUND:ER_servicios_evalriesgo_PG.ER_getEvRiesgoVigente_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getEvRiesgoVigente_PR', LV_Sql, SQLCODE, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getEvRiesgoVigente_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getEvRiesgoVigente_PR', LV_Sql, SQLCODE, LV_desError );
    END ER_getEvRiesgoVigente_PR;

	PROCEDURE ER_getListPlanTarifTipo_PR(EV_codTipIdentif IN VARCHAR2,
	                                     EV_numIdentif    IN VARCHAR2,
									     EV_tipoPlan      IN VARCHAR2,
									     SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		         SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		         SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getListPlanTarifTipo_PR'
			Lenguaje='PL/SQL'
			Fecha='06-06-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Cursor
		</Retorno>
		<Descripción>
				  Retorna lista planes tarifario segun numero identificador y tipo de plan
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom='EV_codTipIdentif' Tipo='STRING'>  Dcodigo tipo identificador </param>
	           <param nom='EV_numIdentif'    Tipo='STRING'> numero identificador </param>
			   <param nom='EV_tipoPlan'      Tipo='STRING'> Indentifica el tipo de solicitud 0 o 1</param>
			 </Entrada>
	         <Salida>
			   <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
			   <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		NO_DATA_FOUND_CURSOR EXCEPTION;
		LV_desError       ge_errores_pg.desevent;
		LV_sql		      ge_errores_pg.vquery;
		LN_contador  	  NUMBER;
		LN_codRestriccion NUMBER;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;
 		LN_contador   := 0;
		LN_codRestriccion := CN_SINEXCEPCION;

		-- buscamos excepcion para el numero de identificador
		BEGIN
			SELECT a.cod_restric
			INTO LN_codRestriccion
			FROM erd_excepcion a
			WHERE a.cod_tipident = EV_codTipIdentif
			AND a.num_ident = EV_numIdentif;
		EXCEPTION
			 WHEN OTHERS THEN
				LN_codRestriccion := CN_SINEXCEPCION;
		END;

		CASE LN_codRestriccion
			 WHEN CN_SINEXCEPCION THEN
			 -- no tiene excepcion
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa

						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar <> CN_INDFAMILIA
							AND a.cod_plantarif = b.cod_plantarif
							AND c.num_solicitud = b.num_solicitud
							AND c.cod_estado IN (CV_ESTSOLAPROBPORSIST,
							                     CV_ESTSOLAPROBPORUSUA,
												 CV_ESTSOLENVENTA)
							AND c.cod_tipident = EV_codTipIdentif
							AND c.num_ident_cliente = EV_numIdentif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
							|| ' AND a.cod_plantarif = b.cod_plantarif '
							|| ' AND c.num_solicitud = b.num_solicitud '
							|| ' AND c.cod_estado IN (' || CV_ESTSOLAPROBPORSIST || ','
							                     || CV_ESTSOLAPROBPORUSUA || ','
												 || CV_ESTSOLENVENTA || ')'
							|| ' AND c.cod_tipident = ''' || EV_codTipIdentif || ''''
							|| ' AND c.num_ident_cliente = ''' || EV_numIdentif || '''';

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar

						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND a.cod_plantarif = b.cod_plantarif
							AND c.num_solicitud = b.num_solicitud
							AND c.cod_estado IN (CV_ESTSOLAPROBPORSIST,
							                     CV_ESTSOLAPROBPORUSUA,
												 CV_ESTSOLENVENTA)
							AND c.cod_tipident = EV_codTipIdentif
							AND c.num_ident_cliente = EV_numIdentif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND a.cod_plantarif = b.cod_plantarif '
							|| ' AND c.num_solicitud = b.num_solicitud '
							|| ' AND c.cod_estado IN (' || CV_ESTSOLAPROBPORSIST || ','
							                     || CV_ESTSOLAPROBPORUSUA || ','
												 || CV_ESTSOLENVENTA || ')'
							|| ' AND c.cod_tipident = ''' || EV_codTipIdentif || ''''
							|| ' AND c.num_ident_cliente = ''' || EV_numIdentif || '''';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_TODOSPLANES THEN -- tiene excepcion : todos los planes

				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa

						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar <> CN_INDFAMILIA
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
							|| ' AND a.cod_plantarif = b.cod_plantarif';

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar

						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_PLANESCOMER THEN -- tiene excepcion : planes comercializables
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar <> CN_INDFAMILIA
							AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
							|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_TODOSNOCOMER THEN -- tiene excepcion : planes no comercializables
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar <> CN_INDFAMILIA
							AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
							|| ' AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
 			 ELSE
			 	  RAISE NO_DATA_FOUND_CURSOR;
		END CASE;

		OPEN SC_cursordatos FOR LV_Sql;

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getListPlanTarifTipo_PR;

	PROCEDURE ER_getListPlanTarifTipo_PR(EV_codTipIdentif IN VARCHAR2,
	                                     EV_numIdentif    IN VARCHAR2,
									     EV_tipoPlan      IN VARCHAR2,
										 EV_SelTipo		  IN VARCHAR2,
									     SC_cursorDatos   OUT NOCOPY REFCURSOR,
								 	     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       		         SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                       		         SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'ER_getListPlanTarifTipo_PR'
			Lenguaje='PL/SQL'
			Fecha='06-06-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno>
				  Cursor
		</Retorno>
		<Descripción>
				  Retorna lista planes tarifario segun numero identificador y tipo de plan
		</Descripción>
		<Parámetros>
	         <Entrada>
	           <param nom='EV_codTipIdentif' Tipo='STRING'>  Dcodigo tipo identificador </param>
	           <param nom='EV_numIdentif'    Tipo='STRING'> numero identificador </param>
			   <param nom='EV_tipoPlan'      Tipo='STRING'> Indentifica el tipo de solicitud 0 o 1</param>
			 </Entrada>
	         <Salida>
			   <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
			   <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
			 </Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/
		NO_DATA_FOUND_CURSOR EXCEPTION;
		LV_desError       ge_errores_pg.desevent;
		LV_sql		      ge_errores_pg.vquery;
		LN_contador  	  NUMBER;
		LN_codRestriccion NUMBER;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;
 		LN_contador   := 0;
		LN_codRestriccion := CN_SINEXCEPCION;

		-- buscamos excepcion para el numero de identificador
		BEGIN
			SELECT a.cod_restric
			INTO LN_codRestriccion
			FROM erd_excepcion a
			WHERE a.cod_tipident = EV_codTipIdentif
			AND a.num_ident = EV_numIdentif;
		EXCEPTION
			 WHEN OTHERS THEN
				LN_codRestriccion := CN_SINEXCEPCION;
		END;

		CASE LN_codRestriccion
			 WHEN CN_SINEXCEPCION THEN
			 -- no tiene excepcion
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa

-- 						    SELECT COUNT(1)
-- 						    INTO LN_contador
-- 							FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c
-- 							WHERE a.tip_plantarif = CV_PLANEMPRESA
-- 							AND a.ind_familiar <> CN_INDFAMILIA
-- 							AND a.cod_plantarif = b.cod_plantarif
-- 							AND c.num_solicitud = b.num_solicitud
-- 							AND c.cod_estado IN (CV_ESTSOLAPROBPORSIST,
-- 							                     CV_ESTSOLAPROBPORUSUA,
-- 												 CV_ESTSOLENVENTA)
-- 							AND c.cod_tipident = EV_codTipIdentif
-- 							AND c.num_ident_cliente = EV_numIdentif;

--  							LV_Sql := 'SELECT distinct'
--  							|| ' a.cod_plantarif, a.des_plantarif '
--  							|| ' FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c '
--  							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
--  							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
--  							|| ' AND a.cod_plantarif = b.cod_plantarif '
--  							|| ' AND c.num_solicitud = b.num_solicitud '
--  							|| ' AND c.cod_estado IN (' || CV_ESTSOLAPROBPORSIST || ','
--  							                     || CV_ESTSOLAPROBPORUSUA || ','
--  												 || CV_ESTSOLENVENTA || ')'
--  							|| ' AND c.cod_tipident = ''' || EV_codTipIdentif || ''''
--  							|| ' AND c.num_ident_cliente = ''' || EV_numIdentif || '''';

							IF EV_SelTipo = 'P' THEN
								SELECT  COUNT(1)
								INTO LN_contador
								FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f
								WHERE a.cod_producto = CN_PRODUCTO
									AND a.tip_plantarif = EV_tipoPlan
									AND a.cod_plantarif = f.cod_plantarif(+)
									AND a.cod_producto = f.cod_producto(+)
									AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
									--AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia
									AND d.cod_limconsumo = a.cod_limconsumo
									AND a.cod_cargobasico = e.cod_cargobasico
								    AND e.cod_producto=CN_PRODUCTO
								 	AND d.cod_producto=CN_PRODUCTO
								 	AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) -- Inc. 75083 RAB 03-02-2009
									AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE);

								LV_Sql := 'SELECT  distinct a.cod_plantarif,'
							 	|| ' a.des_plantarif,'
								|| ' a.cod_limconsumo,'
								|| ' d.des_limconsumo,'
								|| ' a.cod_cargobasico,'
								|| ' e.des_cargobasico,'
								|| ' e.imp_cargobasico,'
								|| ' null imp_final,'
								|| ' a.num_dias,a.tip_plantarif,d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f'
								|| ' WHERE a.cod_producto = '||CN_PRODUCTO
								|| ' AND a.tip_plantarif = '''||EV_tipoPlan||''''
								|| ' AND a.cod_plantarif = f.cod_plantarif(+)'
								|| ' AND a.cod_producto = f.cod_producto(+)'
								|| ' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)'
								|| ' AND d.cod_limconsumo = a.cod_limconsumo'
								|| ' AND a.cod_cargobasico = e.cod_cargobasico'
								|| ' AND e.cod_producto = '||CN_PRODUCTO
								|| ' AND d.cod_producto = '||CN_PRODUCTO
								|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)' -- Inc. 75083 RAB 03-02-2009
								|| ' AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE)';

							END IF;

							IF EV_SelTipo = 'R' THEN

							   SELECT COUNT(1)
							   INTO LN_contador
								FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e
								 WHERE a.cod_producto = b.cod_producto
								  	   AND a.cod_plantarif  = b.cod_plantarif
									   AND a.cod_plantarif = e.cod_plantarif(+)
									   AND a.cod_producto = e.cod_producto(+)
									   AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)
									   AND c.cod_cargobasico = a.cod_cargobasico
									   AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE)
									   AND a.tip_plantarif  = EV_tipoPlan
									   AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
									   AND d.cod_limconsumo = a.cod_limconsumo
									   AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
								  ORDER BY b.imp_inicial;


								  LV_Sql := 'SELECT distinct lpad(a.cod_plantarif,3) ,'
					   				 || ' a.des_plantarif || ''{ '' ||b.imp_inicial || '' - '' || b.imp_final || '' }'','
									 || ' d.cod_limconsumo,'
									 || ' d.des_limconsumo,'
									 || ' c.cod_cargobasico,'
		 							 || ' c.des_cargobasico,'
									 || ' b.imp_inicial,'
									 || ' b.imp_final,'
									 || ' a.num_dias,'
									 || ' a.tip_plantarif,'
									 || ' d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e'
								 || ' WHERE a.cod_producto = b.cod_producto'
								  	   || ' AND a.cod_plantarif  = b.cod_plantarif'
									   || ' AND a.cod_plantarif = e.cod_plantarif(+)'
									   || ' AND a.cod_producto = e.cod_producto(+)'
									   || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)'
									   || ' AND c.cod_cargobasico = a.cod_cargobasico'
									   || ' AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE) '
									   || ' AND a.tip_plantarif  = '''||EV_tipoPlan||''''
									   || ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)'
									   || ' AND d.cod_limconsumo = a.cod_limconsumo'
									   || ' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta'
								  || ' ORDER BY b.imp_inicial';
							END IF;

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar

 						    SELECT COUNT(1)
 						    INTO LN_contador
 							FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c
 							WHERE a.tip_plantarif = CV_PLANEMPRESA
 							AND a.ind_familiar = CN_INDFAMILIA
 							AND a.cod_plantarif = b.cod_plantarif
 							AND c.num_solicitud = b.num_solicitud
 							AND c.cod_estado IN (CV_ESTSOLAPROBPORSIST,
 							                     CV_ESTSOLAPROBPORUSUA,
 												 CV_ESTSOLENVENTA)
 							AND c.cod_tipident = EV_codTipIdentif
 							AND c.num_ident_cliente = EV_numIdentif;

 							LV_Sql := 'SELECT distinct'
 							|| ' a.cod_plantarif, a.des_plantarif '
 							|| ' FROM ta_plantarif a,ert_solicitud_planes b, ert_solicitud c '
 							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
 							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
 							|| ' AND a.cod_plantarif = b.cod_plantarif '
 							|| ' AND c.num_solicitud = b.num_solicitud '
 							|| ' AND c.cod_estado IN (' || CV_ESTSOLAPROBPORSIST || ','
 							                     || CV_ESTSOLAPROBPORUSUA || ','
 												 || CV_ESTSOLENVENTA || ')'
 							|| ' AND c.cod_tipident = ''' || EV_codTipIdentif || ''''
 							|| ' AND c.num_ident_cliente = ''' || EV_numIdentif || '''';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_TODOSPLANES THEN -- tiene excepcion : todos los planes

				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa

-- 						    SELECT COUNT(1)
-- 						    INTO LN_contador
-- 							FROM ta_plantarif a,ert_solicitud_planes b
-- 							WHERE a.tip_plantarif = CV_PLANEMPRESA
-- 							AND a.ind_familiar <> CN_INDFAMILIA
-- 							AND a.cod_plantarif = b.cod_plantarif;
--
-- 							LV_Sql := 'SELECT distinct'
-- 							|| ' a.cod_plantarif, a.des_plantarif '
-- 							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
-- 							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
-- 							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
-- 							|| ' AND a.cod_plantarif = b.cod_plantarif';

							IF EV_SelTipo = 'P' THEN
								SELECT  COUNT(1)
								INTO LN_contador
								FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f
								WHERE a.cod_producto = CN_PRODUCTO
									AND a.tip_plantarif = EV_tipoPlan
									AND a.cod_plantarif = f.cod_plantarif(+)
									AND a.cod_producto = f.cod_producto(+)
									AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
									--AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia
									AND d.cod_limconsumo = a.cod_limconsumo
									AND a.cod_cargobasico = e.cod_cargobasico
								    AND e.cod_producto=CN_PRODUCTO
								 	AND d.cod_producto=CN_PRODUCTO
									AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE);

								LV_Sql := 'SELECT  distinct a.cod_plantarif,'
							 	|| ' a.des_plantarif,'
								|| ' a.cod_limconsumo,'
								|| ' d.des_limconsumo,'
								|| ' a.cod_cargobasico,'
								|| ' e.des_cargobasico,'
								|| ' e.imp_cargobasico,'
								|| ' null imp_final,'
								|| ' a.num_dias,a.tip_plantarif,d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f'
								|| ' WHERE a.cod_producto = '||CN_PRODUCTO
								|| ' AND a.tip_plantarif = '''||EV_tipoPlan||''''
								|| ' AND a.cod_plantarif = f.cod_plantarif(+)'
								|| ' AND a.cod_producto = f.cod_producto(+)'
								|| ' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)'
								|| ' AND d.cod_limconsumo = a.cod_limconsumo'
								|| ' AND a.cod_cargobasico = e.cod_cargobasico'
								|| ' AND e.cod_producto = '||CN_PRODUCTO
								|| ' AND d.cod_producto = '||CN_PRODUCTO
								|| ' AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE)';

							END IF;

							IF EV_SelTipo = 'R' THEN

							   SELECT COUNT(1)
							   INTO LN_contador
								FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e
								 WHERE a.cod_producto = b.cod_producto
								  	   AND a.cod_plantarif  = b.cod_plantarif
									   AND a.cod_plantarif = e.cod_plantarif(+)
									   AND a.cod_producto = e.cod_producto(+)
									   AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)
									   AND c.cod_cargobasico = a.cod_cargobasico
									   AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE)
									   AND a.tip_plantarif  = EV_tipoPlan
									   AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
									   AND d.cod_limconsumo = a.cod_limconsumo
									   AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
								  ORDER BY b.imp_inicial;


								  LV_Sql := 'SELECT distinct lpad(a.cod_plantarif,3) ,'
					   				 || ' a.des_plantarif || ''{ '' ||b.imp_inicial || '' - '' || b.imp_final || '' }'','
									 || ' d.cod_limconsumo,'
									 || ' d.des_limconsumo,'
									 || ' c.cod_cargobasico,'
		 							 || ' c.des_cargobasico,'
									 || ' b.imp_inicial,'
									 || ' b.imp_final,'
									 || ' a.num_dias,'
									 || ' a.tip_plantarif,'
									 || ' d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e'
								 || ' WHERE a.cod_producto = b.cod_producto'
								  	   || ' AND a.cod_plantarif  = b.cod_plantarif'
									   || ' AND a.cod_plantarif = e.cod_plantarif(+)'
									   || ' AND a.cod_producto = e.cod_producto(+)'
									   || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)'
									   || ' AND c.cod_cargobasico = a.cod_cargobasico'
									   || ' AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE) '
									   || ' AND a.tip_plantarif  = '''||EV_tipoPlan||''''
									   || ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)'
									   || ' AND d.cod_limconsumo = a.cod_limconsumo'
									   || ' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta'
								  || ' ORDER BY b.imp_inicial';
							END IF;

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar

						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_PLANESCOMER THEN -- tiene excepcion : planes comercializables
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa
-- 						    SELECT COUNT(1)
-- 						    INTO LN_contador
-- 							FROM ta_plantarif a,ert_solicitud_planes b
-- 							WHERE a.tip_plantarif = CV_PLANEMPRESA
-- 							AND a.ind_familiar <> CN_INDFAMILIA
-- 							AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
-- 							AND a.cod_plantarif = b.cod_plantarif;
--
-- 							LV_Sql := 'SELECT distinct'
-- 							|| ' a.cod_plantarif, a.des_plantarif '
-- 							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
-- 							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
-- 							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
-- 							|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
-- 							|| ' AND a.cod_plantarif = b.cod_plantarif';

							IF EV_SelTipo = 'P' THEN
								SELECT  COUNT(1)
								INTO LN_contador
								FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f
								WHERE a.cod_producto = CN_PRODUCTO
									AND a.tip_plantarif = EV_tipoPlan
									AND a.cod_plantarif = f.cod_plantarif(+)
									AND a.cod_producto = f.cod_producto(+)
									AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
									--AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia
									AND d.cod_limconsumo = a.cod_limconsumo
									AND a.cod_cargobasico = e.cod_cargobasico
								    AND e.cod_producto=CN_PRODUCTO
								 	AND d.cod_producto=CN_PRODUCTO
								 	AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) -- Inc. 75083 RAB 03-02-2009
									AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE);

								LV_Sql := 'SELECT  distinct a.cod_plantarif,'
							 	|| ' a.des_plantarif,'
								|| ' a.cod_limconsumo,'
								|| ' d.des_limconsumo,'
								|| ' a.cod_cargobasico,'
								|| ' e.des_cargobasico,'
								|| ' e.imp_cargobasico,'
								|| ' null imp_final,'
								|| ' a.num_dias,a.tip_plantarif,d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f'
								|| ' WHERE a.cod_producto = '||CN_PRODUCTO
								|| ' AND a.tip_plantarif = '''||EV_tipoPlan||''''
								|| ' AND a.cod_plantarif = f.cod_plantarif(+)'
								|| ' AND a.cod_producto = f.cod_producto(+)'
								|| ' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)'
								|| ' AND d.cod_limconsumo = a.cod_limconsumo'
								|| ' AND a.cod_cargobasico = e.cod_cargobasico'
								|| ' AND e.cod_producto = '||CN_PRODUCTO
								|| ' AND d.cod_producto = '||CN_PRODUCTO
								|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)' -- Inc. 75083 RAB 03-02-2009
								|| ' AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE)';

							END IF;

							IF EV_SelTipo = 'R' THEN

							   SELECT COUNT(1)
							   INTO LN_contador
								FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e
								 WHERE a.cod_producto = b.cod_producto
								  	   AND a.cod_plantarif  = b.cod_plantarif
									   AND a.cod_plantarif = e.cod_plantarif(+)
									   AND a.cod_producto = e.cod_producto(+)
									   AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)
									   AND c.cod_cargobasico = a.cod_cargobasico
									   AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE)
									   AND a.tip_plantarif  = EV_tipoPlan
									   AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
									   AND d.cod_limconsumo = a.cod_limconsumo
									   AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
								  ORDER BY b.imp_inicial;


								  LV_Sql := 'SELECT distinct lpad(a.cod_plantarif,3) ,'
					   				 || ' a.des_plantarif || ''{ '' ||b.imp_inicial || '' - '' || b.imp_final || '' }'','
									 || ' d.cod_limconsumo,'
									 || ' d.des_limconsumo,'
									 || ' c.cod_cargobasico,'
		 							 || ' c.des_cargobasico,'
									 || ' b.imp_inicial,'
									 || ' b.imp_final,'
									 || ' a.num_dias,'
									 || ' a.tip_plantarif,'
									 || ' d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e'
								 || ' WHERE a.cod_producto = b.cod_producto'
								  	   || ' AND a.cod_plantarif  = b.cod_plantarif'
									   || ' AND a.cod_plantarif = e.cod_plantarif(+)'
									   || ' AND a.cod_producto = e.cod_producto(+)'
									   || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)'
									   || ' AND c.cod_cargobasico = a.cod_cargobasico'
									   || ' AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE) '
									   || ' AND a.tip_plantarif  = '''||EV_tipoPlan||''''
									   || ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)'
									   || ' AND d.cod_limconsumo = a.cod_limconsumo'
									   || ' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta'
								  || ' ORDER BY b.imp_inicial';
							END IF;

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
			 WHEN CN_TODOSNOCOMER THEN -- tiene excepcion : planes no comercializables
				   CASE EV_tipoPlan
				   		WHEN CV_PLANINDIVIDUAL THEN
					    -- plan individual
							RAISE NO_DATA_FOUND_CURSOR;

				   		WHEN CV_PLANEMPRESA THEN
						-- plan empresa
-- 						    SELECT COUNT(1)
-- 						    INTO LN_contador
-- 							FROM ta_plantarif a,ert_solicitud_planes b
-- 							WHERE a.tip_plantarif = CV_PLANEMPRESA
-- 							AND a.ind_familiar <> CN_INDFAMILIA
-- 							AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
-- 							AND a.cod_plantarif = b.cod_plantarif;
--
-- 							LV_Sql := 'SELECT distinct'
-- 							|| ' a.cod_plantarif, a.des_plantarif '
-- 							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
-- 							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
-- 							|| ' AND a.ind_familiar <> ' || CN_INDFAMILIA
-- 							|| ' AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
-- 							|| ' AND a.cod_plantarif = b.cod_plantarif';

							IF EV_SelTipo = 'P' THEN
								SELECT  COUNT(1)
								INTO LN_contador
								FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f
								WHERE a.cod_producto = CN_PRODUCTO
									AND a.tip_plantarif = EV_tipoPlan
									AND a.cod_plantarif = f.cod_plantarif(+)
									AND a.cod_producto = f.cod_producto(+)
									AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)
									--AND f.cod_tecnologia = EO_PlanesTarifarios.cod_tecnologia
									AND d.cod_limconsumo = a.cod_limconsumo
									AND a.cod_cargobasico = e.cod_cargobasico
								    AND e.cod_producto=CN_PRODUCTO
								 	AND d.cod_producto=CN_PRODUCTO
									AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE);

								LV_Sql := 'SELECT  distinct a.cod_plantarif,'
							 	|| ' a.des_plantarif,'
								|| ' a.cod_limconsumo,'
								|| ' d.des_limconsumo,'
								|| ' a.cod_cargobasico,'
								|| ' e.des_cargobasico,'
								|| ' e.imp_cargobasico,'
								|| ' null imp_final,'
								|| ' a.num_dias,a.tip_plantarif,d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_limconsumo d, ta_cargosbasico e ,GA_PLANTECPLSERV f'
								|| ' WHERE a.cod_producto = '||CN_PRODUCTO
								|| ' AND a.tip_plantarif = '''||EV_tipoPlan||''''
								|| ' AND a.cod_plantarif = f.cod_plantarif(+)'
								|| ' AND a.cod_producto = f.cod_producto(+)'
								|| ' AND SYSDATE BETWEEN f.fec_desde AND NVL(f.fec_hasta,SYSDATE)'
								|| ' AND d.cod_limconsumo = a.cod_limconsumo'
								|| ' AND a.cod_cargobasico = e.cod_cargobasico'
								|| ' AND e.cod_producto = '||CN_PRODUCTO
								|| ' AND d.cod_producto = '||CN_PRODUCTO
								|| ' AND SYSDATE BETWEEN e.fec_desde	AND NVL(e.fec_hasta, SYSDATE)';

							END IF;

							IF EV_SelTipo = 'R' THEN

							   SELECT COUNT(1)
							   INTO LN_contador
								FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e
								 WHERE a.cod_producto = b.cod_producto
								  	   AND a.cod_plantarif  = b.cod_plantarif
									   AND a.cod_plantarif = e.cod_plantarif(+)
									   AND a.cod_producto = e.cod_producto(+)
									   AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)
									   AND c.cod_cargobasico = a.cod_cargobasico
									   AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE)
									   AND a.tip_plantarif  = EV_tipoPlan
									   AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
									   AND d.cod_limconsumo = a.cod_limconsumo
									   AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta
								  ORDER BY b.imp_inicial;


								  LV_Sql := 'SELECT distinct lpad(a.cod_plantarif,3) ,'
					   				 || ' a.des_plantarif || ''{ '' ||b.imp_inicial || '' - '' || b.imp_final || '' }'','
									 || ' d.cod_limconsumo,'
									 || ' d.des_limconsumo,'
									 || ' c.cod_cargobasico,'
		 							 || ' c.des_cargobasico,'
									 || ' b.imp_inicial,'
									 || ' b.imp_final,'
									 || ' a.num_dias,'
									 || ' a.tip_plantarif,'
									 || ' d.imp_limconsumo'
								|| ' FROM ta_plantarif a, ta_rango_planes_td b,ta_limconsumo d, ta_cargosbasico c , GA_PLANTECPLSERV e'
								 || ' WHERE a.cod_producto = b.cod_producto'
								  	   || ' AND a.cod_plantarif  = b.cod_plantarif'
									   || ' AND a.cod_plantarif = e.cod_plantarif(+)'
									   || ' AND a.cod_producto = e.cod_producto(+)'
									   || ' AND SYSDATE BETWEEN e.fec_desde AND NVL(e.fec_hasta,SYSDATE)'
									   || ' AND c.cod_cargobasico = a.cod_cargobasico'
									   || ' AND SYSDATE BETWEEN c.fec_desde	AND NVL(c.fec_hasta, SYSDATE) '
									   || ' AND a.tip_plantarif  = '''||EV_tipoPlan||''''
									   || ' AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)'
									   || ' AND d.cod_limconsumo = a.cod_limconsumo'
									   || ' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta'
								  || ' ORDER BY b.imp_inicial';
							END IF;

				   		WHEN CV_PLANFAMILIA THEN
					    -- plan familiar
						    SELECT COUNT(1)
						    INTO LN_contador
							FROM ta_plantarif a,ert_solicitud_planes b
							WHERE a.tip_plantarif = CV_PLANEMPRESA
							AND a.ind_familiar = CN_INDFAMILIA
							AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)
							AND a.cod_plantarif = b.cod_plantarif;

							LV_Sql := 'SELECT distinct'
							|| ' a.cod_plantarif, a.des_plantarif '
							|| ' FROM ta_plantarif a,ert_solicitud_planes b '
							|| ' WHERE a.tip_plantarif = ''' || CV_PLANEMPRESA || ''''
							|| ' AND a.ind_familiar = ' || CN_INDFAMILIA
							|| ' AND SYSDATE NOT BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE) '
							|| ' AND a.cod_plantarif = b.cod_plantarif';

			 			ELSE
						-- error tipo de plan
							RAISE NO_DATA_FOUND_CURSOR;

			   		END CASE;
 			 ELSE
			 	  RAISE NO_DATA_FOUND_CURSOR;
		END CASE;

		OPEN SC_cursordatos FOR LV_Sql;

		IF (LN_contador = 0) THEN
			RAISE NO_DATA_FOUND_CURSOR;
		END IF;

	EXCEPTION
			WHEN NO_DATA_FOUND_CURSOR THEN
				 SN_codRetorno:=1;
		         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
		            SV_menRetorno := CV_ERRORNOCLASIF;
		         END IF;
		         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
		         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
				 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR', LV_Sql, SN_codRetorno, LV_desError );
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'ER_servicios_evalriesgo_PG.ER_getListPlanTarifTipo_PR', LV_Sql, SQLCODE, LV_desError );
	END ER_getListPlanTarifTipo_PR;
	--------------------------------------------------------------------------------------------
	--* INSERTS y UPDATES
	--------------------------------------------------------------------------------------------

	PROCEDURE VE_insSolicitudVenta_PR(EV_numSolicitud  IN  VARCHAR2,
			  						  EV_numVenta      IN  VARCHAR2,
							          SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                  SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'VE_insSolicitudVenta_PR'
			Lenguaje='PL/SQL'
			Fecha='24-07-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno> N/A </Retorno>
		<Descripción>
				  Inserta relacion entre la venta y la solicitud
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom='EV_numSolicitud'  Tipo='STRING'> numero solicitud </param>
			   <param nom='EV_numVenta'      Tipo='STRING'> numero venta </param>
			 </Entrada>
	         <Salida>
			   <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
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

		LV_Sql:='INSERT INTO ert_solicitud_venta( '
		     || 'num_solicitud,num_venta)'
		     || 'VALUES (EV_numSolicitud,EV_numVenta)';

		INSERT INTO ert_solicitud_venta(num_solicitud,num_venta)
		VALUES (EV_numSolicitud,EV_numVenta);

	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_servicios_evalriesgo_PG.VE_insSolicitudVenta_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_servicios_evalriesgo_PG.VE_insSolicitudVenta_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_insSolicitudVenta_PR;

	PROCEDURE VE_updSolicPlanes_TermVend_PR(EV_numSolicitud  IN  VARCHAR2,
			  							    EV_cod_plantarif IN  VARCHAR2,
								            EV_cantidad      IN  VARCHAR2,
							                SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
		/*
		<Documentación TipoDoc = 'Procedimiento'>
			Elemento Nombre = 'VE_updSolicPlanes_TermVend_PR'
			Lenguaje='PL/SQL'
			Fecha='18-07-2007'
			Versión='1.0.0'
			Diseñador='wjrc'
			Programador='wjrc'
			Ambiente='BD'
		<Retorno> N/A </Retorno>
		<Descripción>
				  Actualiza cantidad de terminales vendidos
		</Descripción>
		<Parámetros>
	         <Entrada>
			   <param nom='EV_numSolicitud'  Tipo='STRING'> numero solicitud </param>
			   <param nom='EV_cod_plantarif' Tipo='STRING'> ccódigo plan tarifario </param>
			   <param nom='EV_cantidad'      Tipo='STRING'> cantidad vendidos </param>
			 </Entrada>
	         <Salida>
			   <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
	           <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
	           <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
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

		LV_Sql:='UPDATE ert_solicitud_planes a '
		     || ' SET a.val_cant_vendidos = a.val_cant_vendidos + ' || EV_cantidad
		     || ' WHERE a.num_solicitud = ' || EV_numSolicitud
			 || ' AND a.cod_plantarif = ' || EV_cod_plantarif;

		UPDATE ert_solicitud_planes a
		SET a.val_cant_vendidos = a.val_cant_vendidos + EV_cantidad
		WHERE a.num_solicitud = EV_numSolicitud
		AND a.cod_plantarif = EV_cod_plantarif;

	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_servicios_evalriesgo_PG.VE_updSolicPlanes_TermVend_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_servicios_evalriesgo_PG.VE_updSolicPlanes_TermVend_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_updSolicPlanes_TermVend_PR;

	PROCEDURE VE_insExcepcion_PR           (EV_CODCLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
											EV_INSERT      OUT VARCHAR2,
							                SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento   OUT NOCOPY ge_errores_pg.Evento)
	IS

	    LV_desError ge_errores_pg.desevent;
		LV_sql		ge_errores_pg.vquery;
		LV_COUNT    NUMBER(2);
	    LV_numIdent ERD_EXCEPCION.NUM_IDENT%TYPE;
 		LV_TipIdent ERD_EXCEPCION.COD_TIPIDENT%TYPE;
	BEGIN
		SN_codRetorno := 0;
		SV_menRetorno := NULL;
		SN_numEvento  := 0;

		--obtiene con cod_cliente los campos num_ident y tipident
		SELECT NUM_IDENT, COD_TIPIDENT
	      INTO LV_numIdent, LV_TipIdent
		  FROM GE_CLIENTES
		 WHERE COD_CLIENTE = EV_CODCLIENTE;

		LV_Sql:=' SELECT COUNT(1) FROM ERD_EXCEPCION WHERE NUM_IDENT= '|| LV_numIdent
		     || ' AND cod_tipident ' || LV_TipiDent;


		SELECT COUNT(1)
		INTO LV_COUNT
		FROM ERD_EXCEPCION
		WHERE NUM_IDENT=LV_numIdent
		AND COD_TIPIDENT = LV_Tipident;


		IF LV_COUNT=0 THEN

		   INSERT INTO ERD_EXCEPCION
           (FEC_DESDE_H, FEC_HASTA_H, NOM_USUARIO, FEC_ULTMOD_H, COD_RESTRIC,COD_TIPIDENT, NUM_IDENT )
           VALUES (sysdate,  TO_Date( '12/31/3000 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), USER,  sysdate, 0 , LV_Tipident, LV_NumIdent);
           EV_INSERT:=1;
	    ELSE
	       UPDATE ERD_EXCEPCION
		   SET FEC_HASTA_H = TO_Date( '12/31/3000 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM')
		   WHERE NUM_IDENT=LV_numIdent
		   AND COD_TIPIDENT=LV_tipident;
		   EV_INSERT:=2;
		END IF;
	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_servicios_evalriesgo_PG.VE_insExcepcion_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_servicios_evalriesgo_PG.VE_insExcepcion_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_insExcepcion_PR;

	PROCEDURE VE_delExcepcion_PR           (EV_CODCLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
											EV_INSERT     IN VARCHAR2,
											SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
	                       	                SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
	                                        SN_numEvento  OUT NOCOPY ge_errores_pg.Evento) IS


	LV_desError ge_errores_pg.desevent;
    LV_sql		ge_errores_pg.vquery;
	LV_COUNT    NUMBER(2);
    LV_numIdent ERD_EXCEPCION.NUM_IDENT%TYPE;
	LV_TipIdent ERD_EXCEPCION.COD_TIPIDENT%TYPE;

	BEGIN

	SN_codRetorno := 0;
	SV_menRetorno := NULL;
	SN_numEvento  := 0;

		--obtiene con cod_cliente los campos num_ident y tipident
		SELECT NUM_IDENT, COD_TIPIDENT
	      INTO LV_numIdent, LV_TipIdent
		  FROM GE_CLIENTES
		 WHERE COD_CLIENTE = EV_CODCLIENTE;

		IF EV_INSERT=1 THEN
		   --BORRO
           DELETE FROM ERD_EXCEPCION
		   WHERE NUM_IDENT=LV_numIdent
		   AND COD_TIPIDENT=LV_tipident;
	    ELSE
	       UPDATE ERD_EXCEPCION
		   SET FEC_HASTA_H = SYSDATE
		   WHERE NUM_IDENT=LV_numIdent
		   AND COD_TIPIDENT=LV_tipident;
		END IF;
	EXCEPTION
			 WHEN OTHERS THEN
				SN_codRetorno := 156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
				   SV_menRetorno := CV_ERRORNOCLASIF;
				END IF;
				LV_desError  := 'OTHERS:VE_servicios_evalriesgo_PG.VE_updSolicPlanes_TermVend_PR;- ' || SQLERRM;
				SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
				'VE_servicios_evalriesgo_PG.VE_updSolicPlanes_TermVend_PR', LV_Sql, SQLCODE, LV_desError );
	END VE_delExcepcion_PR;
END ER_servicios_evalriesgo_PG;
/
SHOW ERRORS
