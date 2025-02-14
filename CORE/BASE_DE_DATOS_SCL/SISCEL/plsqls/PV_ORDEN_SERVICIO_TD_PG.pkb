CREATE OR REPLACE PACKAGE BODY PV_ORDEN_SERVICIO_TD_PG IS

	PROCEDURE PV_INS_ENC_PROC_OOSS_PR(  EO_PV_ORDEN_SERVICIO IN PV_ORDEN_DE_SERVICIO_QT,
	                                    EO_PARAMETRO_DTO     IN BLOB,
										SN_NUM_PROC_OS		 OUT NOCOPY PV_ORDEN_DE_SERVICIO_TD.NUM_PROCESO%TYPE,
 						                SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_INS_ENC_PROC_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Inserta encabezado del estado de proceso de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_num_proc_os"  Tipo="NUMBER"> numero de proceso de la orden de servicio</param>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error ge_errores_pg.DesEvent;
	   LV_sSql      ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_ORDEN_SERVICIO IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;

		LV_sSql := 'INSERT INTO pv_orden_de_servicio_td ';
		LV_sSql := LV_sSql || ' (num_proceso,';
		LV_sSql := LV_sSql || ' cod_os, estado, ';
		LV_sSql := LV_sSql || ' fec_actualizacion,';
		LV_sSql := LV_sSql || ' parametros)';
		LV_sSql := LV_sSql || ' VALUES ( pv_num_proc_os_sq.nextval, ';
		LV_sSql := LV_sSql || EO_PV_ORDEN_SERVICIO.cod_os||', ';
		LV_sSql := LV_sSql || EO_PV_ORDEN_SERVICIO.estado||', ';
		LV_sSql := LV_sSql || EO_PV_ORDEN_SERVICIO.fec_actualizacion||', ';
		LV_sSql := LV_sSql || ' OBJETO)';

	    INSERT INTO pv_orden_de_servicio_td
			   (num_proceso,
			    cod_os, estado,
				fec_actualizacion,
				parametros)
		VALUES ( pv_num_proc_os_sq.nextval,
			     EO_PV_ORDEN_SERVICIO.cod_os,
			     EO_PV_ORDEN_SERVICIO.estado,
				 EO_PV_ORDEN_SERVICIO.fec_actualizacion,
		         EO_PARAMETRO_DTO)
		RETURNING num_proceso INTO SN_NUM_PROC_OS;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 64;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_INS_ENC_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_INS_ENC_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_Ins_Enc_Proc_OOSS_PR;


	PROCEDURE PV_INS_DET_PROC_OOSS_PR(  EO_PV_DETALLE_OS     IN  PV_DETALLE_OS_QT,
 						                SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_INS_DET_PROC_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Inserta detalle del estado de proceso de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_DETALLE_OS"  Tipo="Estructura"> Estructura de datos tabla PV_DETALLE_OS_TO</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error 	ge_errores_pg.DesEvent;
	   LV_sSql      	ge_errores_pg.vQuery;
	   LV_count_detalle	number(10);
	   ERROR_PARAMETROS EXCEPTION;
	   ERROR_DUPLICADO	EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_DETALLE_OS IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;


		LV_sSql := 'SELECT COUNT(1) ' ;
		LV_sSql := LV_sSql || ' FROM PV_DETALLE_OS_TO A' ;
		LV_sSql := LV_sSql || ' WHERE A.NUM_ABONADO =' || EO_PV_DETALLE_OS.num_abonado ;
		LV_sSql := LV_sSql || ' AND A.COD_CLIENTE = ' || EO_PV_DETALLE_OS.cod_cliente ;
		LV_sSql := LV_sSql || ' AND A.ESTADO NOT IN (PROCESADO,ERROR)';

		SELECT COUNT(1)
		INTO   LV_count_detalle
		FROM   PV_DETALLE_OS_TO A
		WHERE  A.NUM_ABONADO = EO_PV_DETALLE_OS.num_abonado
		AND    A.COD_CLIENTE = EO_PV_DETALLE_OS.cod_cliente
		AND    A.ESTADO NOT IN ('PROCESADO','ERROR');

		IF LV_count_detalle > 0 THEN
		   RAISE ERROR_DUPLICADO;
		END IF;

		LV_sSql := ' INSERT INTO pv_detalle_os_to';
		LV_sSql := LV_sSql || '(num_proceso,';
		LV_sSql := LV_sSql || 'num_os,';
		LV_sSql := LV_sSql || 'cod_error, ';
		LV_sSql := LV_sSql || 'des_error, ';
		LV_sSql := LV_sSql || 'estado, ';
		LV_sSql := LV_sSql || 'fec_estado, ';
		LV_sSql := LV_sSql || 'num_evento,';
		LV_sSql := LV_sSql || 'num_abonado,';
		LV_sSql := LV_sSql || 'cod_cliente)';
		LV_sSql := LV_sSql || 'VALUES ( '||EO_PV_DETALLE_OS.num_proceso||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.num_os||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.cod_error||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.des_error||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.estado||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.fec_estado||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.num_evento||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.num_abonado||', ';
		LV_sSql := LV_sSql || EO_PV_DETALLE_OS.cod_cliente||')';

	    INSERT INTO pv_detalle_os_to
			        (num_proceso,
					 num_os,
					 cod_error,
					 des_error,
			   		 estado,
					 fec_estado,
					 num_evento,
					 num_abonado,
					 cod_cliente)
		VALUES ( EO_PV_DETALLE_OS.num_proceso,
			     EO_PV_DETALLE_OS.num_os,
			     EO_PV_DETALLE_OS.cod_error,
				 EO_PV_DETALLE_OS.des_error,
		         EO_PV_DETALLE_OS.estado,
				 EO_PV_DETALLE_OS.fec_estado,
				 EO_PV_DETALLE_OS.num_evento,
				 EO_PV_DETALLE_OS.num_abonado,
				 EO_PV_DETALLE_OS.cod_cliente);


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_INS_DET_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN ERROR_DUPLICADO THEN
			 SN_cod_retorno := 1845;
	      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         	SV_mens_retorno := CV_error_no_clasif;
		  	 END IF;
			 LV_des_error := 'Registro duplicado - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_INS_DET_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN OTHERS THEN
			 SN_cod_retorno:=4;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_INS_DET_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_INS_DET_PROC_OOSS_PR;


	PROCEDURE PV_ACT_ESTADO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN  PV_ORDEN_DE_SERVICIO_QT,
	                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ACT_ESTADO_PROC_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Actualiza estado de proceso en tabla encabezado de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error     ge_errores_pg.DesEvent;
	   LV_sSql          ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_ORDEN_SERVICIO IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;

		LV_sSql := 'UPDATE pv_orden_de_servicio_td'
		           || ' SET estado = ''' || EO_PV_ORDEN_SERVICIO.estado || ''','
				   || ' fec_actualizacion = ''' || EO_PV_ORDEN_SERVICIO.fec_actualizacion || ''''
				   || ' WHERE num_proceso = ' || EO_PV_ORDEN_SERVICIO.num_proceso;

	    UPDATE pv_orden_de_servicio_td
		SET    estado = EO_PV_ORDEN_SERVICIO.estado,
			   fec_actualizacion = EO_PV_ORDEN_SERVICIO.fec_actualizacion
		WHERE  num_proceso = EO_PV_ORDEN_SERVICIO.num_proceso;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 130;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_ESTADO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_ESTADO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_ACT_ESTADO_PROC_OOSS_PR;

	PROCEDURE PV_ACT_OBJETO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN  PV_ORDEN_DE_SERVICIO_QT,
			  						 	 EO_PARAMETRO_DTO     IN BLOB,
	                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ACT_OBJETO_PROC_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Actualiza objeto en tabla encabezado de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error     ge_errores_pg.DesEvent;
	   LV_sSql          ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PARAMETRO_DTO IS NULL AND EO_PV_ORDEN_SERVICIO IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;

		LV_sSql := 'UPDATE pv_orden_de_servicio_td'
				   || ' SET parametros = <OBJETO>'
				   || ' WHERE num_proceso = ' || EO_PV_ORDEN_SERVICIO.num_proceso;

	    UPDATE pv_orden_de_servicio_td
		SET    parametros = EO_PARAMETRO_DTO
		WHERE  num_proceso = EO_PV_ORDEN_SERVICIO.num_proceso;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 130;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_OBJETO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_OBJETO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_ACT_OBJETO_PROC_OOSS_PR;


	PROCEDURE PV_CON_ESTADO_PROC_OOSS_PR(EO_PV_ORDEN_SERVICIO IN  PV_ORDEN_DE_SERVICIO_QT,
	                                     SV_estado            OUT NOCOPY pv_orden_de_servicio_td.estado%TYPE,
			  						 	 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_CON_ESTADO_PROC_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Consulta estado proceso de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error     ge_errores_pg.DesEvent;
	   LV_sSql          ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_ORDEN_SERVICIO IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;

		LV_sSql := 'SELECT a.estado'
				   || ' FROM pv_orden_de_servicio_td a'
				   || ' WHERE a.num_os = ' || EO_PV_ORDEN_SERVICIO.num_proceso;

	    SELECT a.estado
		INTO   SV_estado
		FROM   pv_orden_de_servicio_td a
		WHERE  a.num_proceso = EO_PV_ORDEN_SERVICIO.num_proceso;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 1642;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	    WHEN NO_DATA_FOUND THEN
			 SN_cod_retorno:=1642;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := 'No se encontraron datos para el proceso '|| EO_PV_ORDEN_SERVICIO.num_proceso ||' - '||SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );

		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_PROC_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CON_ESTADO_PROC_OOSS_PR;

	PROCEDURE PV_ACT_ESTADO_DET_OOSS_PR( EO_PV_DETALLE_OS     IN         PV_DETALLE_OS_QT,
	                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_ACT_ESTADO_DET_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Actualiza estado de proceso en tabla encabezado de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error     ge_errores_pg.DesEvent;
	   LV_sSql          ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_DETALLE_OS IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;
		IF (EO_PV_DETALLE_OS.cod_error IS NULL or EO_PV_DETALLE_OS.cod_error = 0) THEN
			LV_sSql := ' UPDATE pv_detalle_os_to';
			LV_sSql := LV_sSql || ' SET estado = '||EO_PV_DETALLE_OS.estado;
			LV_sSql := LV_sSql || ' fec_estado = '||EO_PV_DETALLE_OS.fec_estado;
			LV_sSql := LV_sSql || ' WHERE num_proceso = '||EO_PV_DETALLE_OS.num_proceso;
			LV_sSql := LV_sSql || ' AND num_os = '||EO_PV_DETALLE_OS.num_os;

		    UPDATE pv_detalle_os_to
			SET    estado = EO_PV_DETALLE_OS.estado,
				   fec_estado = EO_PV_DETALLE_OS.fec_estado
			WHERE  num_proceso = EO_PV_DETALLE_OS.num_proceso
			AND    num_os = EO_PV_DETALLE_OS.num_os;
		ELSE
			LV_sSql := ' UPDATE pv_detalle_os_to';
			LV_sSql := LV_sSql || ' SET estado = '||EO_PV_DETALLE_OS.estado;
			LV_sSql := LV_sSql || ' ,fec_estado = '||EO_PV_DETALLE_OS.fec_estado;
			LV_sSql := LV_sSql || ' ,cod_error = '||EO_PV_DETALLE_OS.cod_error;
			LV_sSql := LV_sSql || ' ,des_error = '||EO_PV_DETALLE_OS.des_error;
			LV_sSql := LV_sSql || ' ,num_evento = '||EO_PV_DETALLE_OS.num_evento;
			LV_sSql := LV_sSql || ' WHERE num_proceso = '||EO_PV_DETALLE_OS.num_proceso;
			LV_sSql := LV_sSql || ' AND num_os = '||EO_PV_DETALLE_OS.num_os;

		    UPDATE pv_detalle_os_to
			SET    estado = EO_PV_DETALLE_OS.estado,
				   fec_estado = EO_PV_DETALLE_OS.fec_estado,
				   cod_error = EO_PV_DETALLE_OS.cod_error,
				   des_error = EO_PV_DETALLE_OS.des_error,
				   num_evento = EO_PV_DETALLE_OS.num_evento
			WHERE  num_proceso = EO_PV_DETALLE_OS.num_proceso
			AND    num_os = EO_PV_DETALLE_OS.num_os;

			LV_sSql := ' UPDATE pv_detalle_os_to';
			LV_sSql := LV_sSql || ' SET estado = '||EO_PV_DETALLE_OS.estado;
			LV_sSql := LV_sSql || ' ,fec_estado = '||EO_PV_DETALLE_OS.fec_estado;
			LV_sSql := LV_sSql || ' WHERE num_proceso = '||EO_PV_DETALLE_OS.num_proceso;

			UPDATE pv_detalle_os_to
			SET estado = EO_PV_DETALLE_OS.estado
			,fec_estado = EO_PV_DETALLE_OS.fec_estado
			WHERE num_proceso = EO_PV_DETALLE_OS.num_proceso;

		END IF;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 130;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_ESTADO_DET_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_ACT_ESTADO_DET_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_ACT_ESTADO_DET_OOSS_PR;

	PROCEDURE PV_CON_ESTADO_DET_OOSS_PR( EO_PV_DETALLE_OS     IN         PV_DETALLE_OS_QT,
			  							 SO_ESTADO			  OUT NOCOPY refcursor,
	                                     SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
	                  		             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
	                         	         SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
	/*--
	<Documentacion TipoDoc = "Procedimiento">
		Elemento Nombre = "PV_CON_ESTADO_DET_OOSS_PR"
		Lenguaje="PL/SQL"
		Fecha="17-12-2007"
		Version="1.0.0"
		Dise?ador="Héctor Hermosilla"
		Programador="Héctor Hermosilla"
		Ambiente="BD"
	<Retorno>NA</Retorno>
	<Descripcion>
		Actualiza estado de proceso en tabla encabezado de OOSS
	</Descripcion>
	<Parametros>
	<Entrada>
		<param nom="EO_PV_ORDEN_SERVICIO"  Tipo="Estructura"> Estructura de datos tabla PV_ORDEN_SERVICIO_TD</param>
		<param nom="EO_PARAMETRO_DTO"  Tipo="Estructura"> Objeto asociado al proceso</param>
	</Entrada>
	<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
		<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	--*/

	   LV_des_error     ge_errores_pg.DesEvent;
	   LV_sSql          ge_errores_pg.vQuery;
	   ERROR_PARAMETROS EXCEPTION;

	BEGIN
		SN_num_evento:= 0;
		SN_cod_retorno:=0;
		SV_mens_retorno:='';

		IF EO_PV_DETALLE_OS IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	    END IF;


		IF (EO_PV_DETALLE_OS.num_abonado = null or EO_PV_DETALLE_OS.num_abonado = 0) THEN

			LV_sSql := ' SELECT estado, num_proceso';
			LV_sSql := LV_sSql || ' FROM   pv_detalle_os_to ';
			LV_sSql := LV_sSql || ' WHERE num_abonado = '||EO_PV_DETALLE_OS.num_abonado;

			OPEN SO_ESTADO FOR
			SELECT estado, num_proceso
			FROM   pv_detalle_os_to
			WHERE  cod_cliente = EO_PV_DETALLE_OS.cod_cliente;

		ELSE
			LV_sSql := ' SELECT estado, num_proceso';
			LV_sSql := LV_sSql || ' FROM   pv_detalle_os_to ';
			LV_sSql := LV_sSql || ' WHERE num_abonado = '||EO_PV_DETALLE_OS.num_abonado;

			OPEN SO_ESTADO FOR
		    SELECT estado, num_proceso
			FROM   pv_detalle_os_to
			WHERE  num_abonado = EO_PV_DETALLE_OS.num_abonado
			AND	   cod_cliente = EO_PV_DETALLE_OS.cod_cliente;
		END IF;


	EXCEPTION
	    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 204;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
		  END IF;
			 LV_des_error := 'Objeto de entrada no válido - '|| SQLERRM;
	   	 	 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_DET_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	    WHEN NO_DATA_FOUND THEN
			 SN_cod_retorno:=204;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := 'No se encontraron datos para el proceso '|| EO_PV_DETALLE_OS.num_proceso ||' y Abonado '|| EO_PV_DETALLE_OS.num_abonado ||'- '||SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_DET_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
		WHEN OTHERS THEN
			 SN_cod_retorno:=156;
	         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	            SV_mens_retorno := CV_error_no_clasIF;
	         END IF;
	         LV_des_error := CV_error_no_clasif ||' - '|| SQLERRM;
	         SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
			 'PV_ORDEN_SERVICIO_TD_PG.PV_CON_ESTADO_DET_OOSS_PR', LV_sSql, SN_cod_retorno, LV_des_error );
	END PV_CON_ESTADO_DET_OOSS_PR;

END PV_ORDEN_SERVICIO_TD_PG;
/
SHOW ERRORS
