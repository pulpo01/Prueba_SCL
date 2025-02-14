CREATE OR REPLACE PACKAGE BODY PV_SERV_SUPLE_II_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_CODTECNICO_FN (EV_ss_comercial   IN  VARCHAR2,
		 						  EV_separador		 IN  VARCHAR2,
								  SV_ss_tecnico      OUT NOCOPY   VARCHAR2,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
								  )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_OBTENER_CODTECNICO_FN"
      Lenguaje="PL/SQL"
      Fecha="02-05-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener codigos tecnicos a partir de codigos comerciales de serv.supl.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_ss_comercial" Tipo="CARACTER">Cadena con códigos comerciales</param>
            <param nom="EV_separador" Tipo="CARACTER">Separador de codigos</param>

         </Entrada>
         <Salida>
            <param nom="SV_ss_tecnico" Tipo="CARACTER">Cadena con códigos tecnicos </param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    error_ejecucion   EXCEPTION;
	V_des_error		  ge_errores_pg.DesEvent;
    sSql              ge_errores_pg.vQuery;
	SN_numooss		  CI_ORSERV.NUM_OS%TYPE;
	SV_deserror 	  ge_errores_pg.DesEvent;
	vn_Pos	   	      NUMBER;
	vn_MaxParam       NUMBER;
	vv_Caracter       VARCHAR2(1);
	vv_CodServicio	  ga_servsupl.cod_servicio%TYPE;
	LV_cod_tecnico	  VARCHAR2(6);
	LV_cod_servsupl   ga_servsupl.cod_servsupl%TYPE;
	LN_cod_nivel 	  ga_servsupl.cod_nivel%TYPE;

	BEGIN
	   --Inicializar variables.....
       SN_cod_retorno:= '0';
   	   SN_num_evento:= 0;
	   SV_ss_tecnico:=EV_separador;

       sSql:='vn_MaxParam:=LENGTH('||EV_ss_comercial||')';
	   vn_MaxParam:=LENGTH(EV_ss_comercial);
       sSql:='Largo de servicios ingresados menor que 3...vn_MaxParam<3';
	   IF  vn_MaxParam<3 THEN
	   	   RAISE error_ejecucion;
	   END IF;

	   IF SUBSTR(EV_ss_comercial,1,1)<>EV_separador THEN
	       sSql:='Validar primer caracter sea igual al separador..'||SUBSTR(EV_ss_comercial,1,1)||'<>'||EV_separador;
	   	   RAISE error_ejecucion;
	   ELSE
	      IF SUBSTR(EV_ss_comercial,vn_MaxParam,1)<>EV_separador THEN
	         sSql:='Validar ultimo caracter sea igual al separador...'||SUBSTR(EV_ss_comercial,1,vn_MaxParam)||'<>'||EV_separador;
	   	     RAISE error_ejecucion;
	      END IF;
	   END IF;
	   vv_CodServicio:='';
       sSql:=SUBSTR('Recorriendo lista de servicios..'||EV_ss_comercial,1,CN_largoquery);
	   FOR vn_Pos in 2..vn_MaxParam LOOP
			vv_Caracter:=SUBSTR(EV_ss_comercial,vn_Pos,1);
			IF LENGTH(vv_Caracter)<>0  THEN
			   IF vv_Caracter<>EV_separador THEN
				  vv_CodServicio:=vv_CodServicio||vv_Caracter;
	  		   ELSE
					IF LENGTH(vv_CodServicio)<>0 THEN
					   sSql:='SELECT  COD_SERVSUPL, COD_NIVEL '||
					   		 ' FROM GA_SERVSUPL '||
					         ' WHERE COD_SERVICIO='||vv_CodServicio;
					   SELECT  COD_SERVSUPL, COD_NIVEL
					     INTO LV_cod_servsupl,LN_cod_nivel
						 FROM GA_SERVSUPL
					    WHERE COD_SERVICIO=vv_CodServicio;
					    sSql:='SV_ss_tecnico:='||SV_ss_tecnico||LV_cod_servsupl||EV_separador||trim(to_char(LN_cod_nivel,'0009'))||EV_separador;
						SV_ss_tecnico:=SV_ss_tecnico||LV_cod_servsupl||EV_separador||trim(to_char(LN_cod_nivel,'0009'))||EV_separador;
						vv_CodServicio:=NULL;
 				    ELSE
					   sSql:='Largo del servicio leido es cero';
 					   RAISE error_ejecucion;
					END IF;
			   END IF;
			ELSE
			   sSql:='Caracter leido es nulo.';
			   RAISE error_ejecucion;
			END IF;
		END LOOP;
  	    RETURN TRUE;

   EXCEPTION
   WHEN error_ejecucion THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('error_ejecucion: PV_OBTENER_CODTECNICO_FN('||EV_ss_comercial||'); - ' || SQLERRM,1,CN_largoerrtec);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_OBTENER_CODTECNICO_FN', sSql, SQLCODE, V_des_error );
				RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'no_data_found: PV_OBTENER_CODTECNICO_FN('||EV_ss_comercial||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_OBTENER_CODTECNICO_FN', sSql, SQLCODE, V_des_error );
				RETURN FALSE;

   WHEN OTHERS THEN
                SN_cod_retorno := '302'; -- Nuevo Error
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'Others: PV_OBTENER_CODTECNICO_FN('||EV_ss_comercial||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_OBTENER_CODTECNICO_FN', sSql, SQLCODE, V_des_error );
				RETURN FALSE;

END PV_OBTENER_CODTECNICO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTDES_SS_PR        (
   EN_num_celular      IN           ga_abocel.num_celular%TYPE,
   EV_ss_activa        IN           VARCHAR2,
   EV_ss_desactiva     IN           VARCHAR2,
   SC_num_solicitudes  OUT NOCOPY   refcursor,
   SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento
)
/*
   <Documentación TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ACTDES_SS_PR"
      Lenguaje="PL/SQL"
      Fecha="29-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Activa-desactiva servicios ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_ss_activa" Tipo="CARACTER">Servicios a activar</param>
            <param nom="EV_ss_desactiva" Tipo="CARACTER">Servicios a desactivar</param>
         </Entrada>
         <Salida>
            <param nom="SC_num_solicitudes" Tipo="Cursor">Solicitudes generadas</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
   </Documentación>
*/
AS
   error_ejecucion      EXCEPTION;
   V_des_error          ge_errores_pg.DesEvent;
   sSql                 ge_errores_pg.vQuery;
   sSql2                ge_errores_pg.vQuery;
   SV_deserror          ge_errores_pg.DesEvent;
   EV_cadena_servicio   VARCHAR2(4000);
   SN_num_solicitud     NUMBER;
   LN_num_transaccion   ga_transacabo.num_transaccion%TYPE;
   LN_cod_retorno       ga_transacabo.cod_retorno%TYPE;
   LV_des_cadena        ga_transacabo.des_cadena%TYPE;
   LN_i                 NUMBER;
   LV_ejec_rest         VARCHAR2(500);
   ST_num_solicitudes   TA_num_solicitudes;
   LV_val_parametro     ged_parametros.val_parametro%TYPE;
   LN_num_abonado       ga_abocel.num_abonado%TYPE;
   LV_usuario           ged_parametros.val_parametro%TYPE;

   -- INI COL|06-02-2009|SAQL
   LV_ss_activa         VARCHAR2(1000);
   LV_ss_desactiva      VARCHAR2(1000);
   -- FIN COL|06-02-2009|SAQL
BEGIN
   SN_cod_retorno:='0';
   SN_num_evento:=0;
   LN_i:=1;
   ST_num_solicitudes(LN_i):=NULL;

   sSql:='SELECT NULL AS num_os FROM DUAL ';
   OPEN SC_num_solicitudes FOR sSql;
   -- Validar si numero celular cumple con el largo definido...
   sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
   IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
      SN_cod_retorno := '303';
      RAISE  error_ejecucion;
   END IF;

   --Validar que suscriptor exista.....
   sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - '||SQLERRM,1,CN_largoquery);
   IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,LN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
      RAISE  error_ejecucion;
   END IF;

   /* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
   LV_ejec_rest:=EN_num_celular||'|';
   --Validar restricción-
   LN_num_transaccion:=NULL;
   sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
   SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
   sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
   CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - '||SQLERRM,1,CN_largoquery);
   PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

   LN_cod_retorno:=NULL;
   LV_des_cadena:=NULL;
   sSql:=SUBSTR('SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
      'FROM  GA_TRANSACABO '||
      'WHERE  NUM_TRANSACCION='||LN_num_transaccion,1,CN_largoquery);
   SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
   FROM  GA_TRANSACABO
   WHERE  NUM_TRANSACCION=LN_num_transaccion;
   IF LN_cod_retorno<>0 then
      SN_cod_retorno := '314'; -- Nuevo Error
      sSql:=LV_des_cadena;
      RAISE error_ejecucion;
   END IF;
   Fin - 29-06-2005 */

   -- Obtener datos desde GED_parametros para parametro EJECUTA_COMMIT
   LV_val_parametro:=NULL;
   sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_ejecuta_commit||','||CV_cod_modulo||','||
   CV_cod_producto_post||',);';
   IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_ejecuta_commit,CV_cod_modulo,CV_cod_producto_post,LV_val_parametro,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      SN_cod_retorno := '302'; -- Nuevo Error
      RAISE error_ejecucion;
   END IF;

   --Obtener usuario interno
   LV_usuario:=NULL;
   sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_usuario||','||'GE'||','||CV_cod_producto_post||');';
   IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_usuario,'GE',CV_cod_producto_post,LV_usuario,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
      SN_cod_retorno:= '302';
      RAISE  error_ejecucion;
   END IF;

   SELECT REPLACE(REPLACE(EV_SS_DESACTIVA,' ',''),'|','') INTO LV_SS_DESACTIVA FROM DUAL; -- COL 77556|06-02-2009|SAQL

   --IF EV_ss_desactiva IS NOT NULL THEN -- 70065|22-01-2009|EFR
   --if length(trim(EV_ss_desactiva)) > 0 then --inc. 45381|COL|26/10/2007|JJR
   -- IF NVL(LENGTH(EV_ss_desactiva),0) > 0 THEN -- 70065|22-01-2009|EFR -- COL 77556|06-02-2009|SAQL
   IF NVL(LENGTH(TRIM(LV_SS_DESACTIVA)),0) > 0  THEN -- COL 77556|06-02-2009|SAQL
      EV_cadena_servicio:=NULL;
      --3.- obtener codigos TECNICOS de la cadena de servicios a desactivar...
      -- y dejarlo en EV_cadena_servicio...
      sSql:=SUBSTR('Desactivando...PV_SERV_SUPLE_II_PG.PV_OBTENER_CODTECNICO_FN('||EV_ss_desactiva||','||CV_separador||')'||SQLERRM,1,CN_largoquery);
      IF not PV_SERV_SUPLE_II_PG.PV_OBTENER_CODTECNICO_FN (EV_ss_desactiva,CV_separador,EV_cadena_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         IF LV_val_parametro=CV_si_ejecuta_commit THEN
            SN_cod_retorno := '312';
         ELSE
            SN_cod_retorno := '302';
         END IF;
         --Limpia num_os.....
         sSql2:='SELECT NULL AS num_os FROM DUAL ';
         OPEN SC_num_solicitudes FOR sSql2;
         RAISE error_ejecucion;
      END IF;
      /*cambio por incidencia XO-200509070608  autor Fernando García */
      --2.- Desactivar....
      sSql:=SUBSTR('PV_SERVICIO_SUPLEMENTARIO_PG.PV_DESACTIVA_SS_PR('||EN_num_celular||','||EV_cadena_servicio
      ||','||EV_ss_desactiva||','||LV_usuario||','||SN_num_solicitud||','||SV_mens_retorno
      ||','||SN_cod_retorno||')',1,CN_largoquery);
      PV_SERVICIO_SUPLEMENTARIO_PG.PV_DESACTIVA_SS_PR(EN_num_celular,EV_cadena_servicio,EV_ss_desactiva,LV_usuario,SN_num_solicitud,SV_mens_retorno,SN_cod_retorno);
      IF SN_cod_retorno=0 THEN
         ST_num_solicitudes(LN_i):=SN_num_solicitud;
         LN_i:=LN_i+1;
      ELSE
         IF LV_val_parametro=CV_si_ejecuta_commit THEN
            SN_cod_retorno := '312';
         ELSE
            SN_cod_retorno := '302';
         END IF;
         sSql:=SUBSTR(sSql||'-'||SV_mens_retorno,1,CN_largoquery);
         --Limpia num_os.....
         sSql2:='SELECT NULL AS num_os FROM DUAL ';
         OPEN SC_num_solicitudes FOR sSql2;
         RAISE error_ejecucion;
      END IF;
      --end if;--inc. 45381|COL|26/10/2007|JJR
   END IF;

   EV_cadena_servicio:=NULL;
   SELECT REPLACE(REPLACE(EV_SS_ACTIVA,' ',''),'|','') INTO LV_SS_ACTIVA FROM DUAL; -- COL 77556|06-02-2009|SAQL

   --IF EV_ss_activa IS NOT NULL THEN---- 70065|22-01-2009|EFR
   --if length(trim(EV_ss_activa)) > 0 then --inc. 45381|COL|26/10/2007|JJR
   -- IF NVL(LENGTH(EV_ss_activa),0) > 0 THEN -- 70065|22-01-2009|EFR -- COL 77556|06-02-2009|SAQL
   IF NVL(LENGTH(TRIM(LV_SS_ACTIVA)),0) > 0 THEN -- COL 77556|06-02-2009|SAQL
      --1.- Obtener codigos TECNICOS de la cadena de servicios a activar y dejarlo en EV_cadena_servicio...
      sSql:=SUBSTR('Activando...PV_SERV_SUPLE_II_PG.PV_OBTENER_CODTECNICO_FN('||EV_ss_activa||','||CV_separador||')'||SQLERRM,1,CN_largoquery);
      IF NOT PV_SERV_SUPLE_II_PG.PV_OBTENER_CODTECNICO_FN (EV_ss_activa,CV_separador,EV_cadena_servicio,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         SN_cod_retorno := '302'; -- Nuevo Error
         RAISE error_ejecucion;
      END IF;
      --2.- Activar....
      sSql:=SUBSTR('PV_SERVICIO_SUPLEMENTARIO_PG.PV_ACTIVA_SS_PR('||EN_num_celular||','||EV_cadena_servicio
         ||','||EV_ss_activa||','||LV_usuario||','||SN_num_solicitud||','||SV_mens_retorno
         ||','||SN_cod_retorno||')'||SQLERRM,1,CN_largoquery);
      PV_SERVICIO_SUPLEMENTARIO_PG.PV_ACTIVA_SS_PR(EN_num_celular,EV_cadena_servicio,EV_ss_activa,LV_usuario,SN_num_solicitud,SV_mens_retorno,SN_cod_retorno);
      IF SN_cod_retorno=0 THEN
         ST_num_solicitudes(LN_i):=SN_num_solicitud;
         LN_i:=LN_i+1;
      ELSE
         SN_cod_retorno := '302';
         sSql:=SUBSTR(sSql||'-'||SV_mens_retorno,1,CN_largoquery);
         RAISE error_ejecucion;
      END IF;
      --end if;--inc. 45381|COL|26/10/2007|JJR
   END IF;
   /*fin cambio por incidencia XO-200509070608 autor Fernando García*/
   SV_mens_retorno:=NULL;

   sSql2:=NULL;
   IF LN_i > 1 THEN
      FOR LN_j IN 1..LN_i-1 LOOP
         sSql2:=sSql2||'SELECT '||ST_num_solicitudes(LN_j)||' AS num_os FROM DUAL ';
         IF LN_j < LN_i-1  THEN
            sSql2:=sSql2||' UNION ';
         END IF;
      END LOOP;
      sSql:=sSql2;
      IF sSql2 IS NOT NULL THEN
         OPEN SC_num_solicitudes FOR sSql2;
      END IF;
   END IF;
EXCEPTION
   WHEN error_ejecucion THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error :=SUBSTR('error_ejecucion: PV_ACTDES_SS_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_ACTDES_SS_PR', sSql, SQLCODE, V_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno := '302'; -- Nuevo Error
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := SUBSTR('Others: PV_ACTDES_SS_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'PV_ACTDES_SS_PR', sSql, SQLCODE, V_des_error );
END PV_ACTDES_SS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_SS_PR          (EN_num_celular      IN  ga_abocel.num_celular%TYPE,
	                              SC_ss_activos      OUT NOCOPY   refcursor,
								  SC_ss_activables   OUT NOCOPY   refcursor,
								  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_SS_PR"
      Lenguaje="PL/SQL"
      Fecha="29-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta de servicios contratados y contratables de un abonado ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SC_ss_activos" Tipo="CURSOR">Cursor de los servicios contratados</param>
            <param nom="SC_ss_activables" Tipo="CURSOR">Cursor de los servicios contratables</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion      EXCEPTION;
		V_des_error		 	 ge_errores_pg.DesEvent;
        sSql             	 ge_errores_pg.vQuery;
		sSql2             	 ge_errores_pg.vQuery;
		SN_numooss			 CI_ORSERV.NUM_OS%TYPE;
		SV_deserror 		 ge_errores_pg.DesEvent;
		LN_num_transaccion   ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno       ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		 ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	     VARCHAR2(500);
		LN_num_abonado	     ga_abocel.num_abonado%TYPE;
		LV_usuario			 ged_parametros.val_parametro%TYPE;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;
		SV_mens_retorno:=NULL;

	    --Inicializar cursores....
		OPEN SC_ss_activos FOR
        SELECT NULL COD_SERVICIO, NULL DES_SERVICIO, NULL COD_SERVSUPL, NULL COD_NIVEL, NULL IMP_TARIFA, NULL DES_MONEDA, NULL COD_CONCEPTO
        FROM DUAL
        WHERE ROWNUM = 0;

	    OPEN SC_ss_activables FOR
        SELECT NULL COD_SERVICIO, NULL DES_SERVICIO, NULL COD_SERVSUPL, NULL COD_NIVEL, NULL IMP_TARIFA, NULL DES_MONEDA, NULL COD_CONCEPTO
        FROM DUAL
        WHERE ROWNUM = 0;

 	    -- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	        SN_cod_retorno := '303';
            RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,LN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....

	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - '||SQLERRM,1,CN_largoquery);
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 then
           SN_cod_retorno := '314';
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		--Obtener usuario interno
		LV_usuario:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_usuario||','||'GE'||','||CV_cod_producto_post||');';
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_usuario,'GE',
		   	   				  CV_cod_producto_post,LV_usuario,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '302';
			 RAISE  error_ejecucion;
		END IF;

	    --1.- Consulta de servicios activos......
        sSql:='PV_SERVICIO_SUPLEMENTARIO_PG.PV_REC_SS_ACTIVOS_PR('||EN_num_celular||','||LV_usuario||')';
        PV_SERVICIO_SUPLEMENTARIO_PG.PV_REC_SS_ACTIVOS_PR(EN_num_celular,LV_usuario,
	  							   SC_ss_activos,SV_mens_retorno,SN_cod_retorno);

  	    IF SN_cod_retorno<>0  THEN
		   IF SC_ss_activos%ISOPEN THEN
		     CLOSE SC_ss_activos;
		   END IF;
		   OPEN SC_ss_activos FOR
           SELECT NULL COD_SERVICIO, NULL DES_SERVICIO, NULL COD_SERVSUPL, NULL COD_NIVEL, NULL IMP_TARIFA, NULL DES_MONEDA, NULL COD_CONCEPTO
           FROM DUAL
           WHERE ROWNUM = 0;

		   IF SC_ss_activables%ISOPEN THEN
		      CLOSE SC_ss_activables;
		   END IF;
		   OPEN SC_ss_activables FOR
           SELECT NULL COD_SERVICIO, NULL DES_SERVICIO, NULL COD_SERVSUPL, NULL COD_NIVEL, NULL IMP_TARIFA, NULL DES_MONEDA, NULL COD_CONCEPTO
           FROM DUAL
           WHERE ROWNUM = 0;
		   sSql:=SUBSTR(sSql||'-'||SV_mens_retorno,1,CN_largoquery);
           SN_cod_retorno := '302';
	       RAISE error_ejecucion;
	    END IF;

	    --2.- Consulta de servicios activables....
	    sSql:='PV_SERVICIO_SUPLEMENTARIO_PG.PV_REC_SS_DISPONIBLES_PR('||EN_num_celular||','||LV_usuario||')';
	    PV_SERVICIO_SUPLEMENTARIO_PG.PV_REC_SS_DISPONIBLES_PR(EN_num_celular,LV_usuario,
	  							   SC_ss_activables,SV_mens_retorno,SN_cod_retorno);

  	    IF SN_cod_retorno<>0  THEN
		   IF SC_ss_activables%ISOPEN THEN
		      CLOSE SC_ss_activables;
		   END IF;
		   OPEN SC_ss_activables FOR
           SELECT NULL COD_SERVICIO, NULL DES_SERVICIO, NULL COD_SERVSUPL, NULL COD_NIVEL, NULL IMP_TARIFA, NULL DES_MONEDA, NULL COD_CONCEPTO
           FROM DUAL
           WHERE ROWNUM = 0;
		   sSql:=SUBSTR(sSql||'-'||SV_mens_retorno,1,CN_largoquery);
           SN_cod_retorno := '302';
	       RAISE error_ejecucion;
        END IF;

   EXCEPTION
   WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('error_ejecucion: PV_CONS_SS_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SV_mens_retorno, '1.0', USER, 'PV_CONS_SS_PR', sSql, SQLCODE, V_des_error );
   WHEN OTHERS THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := SUBSTR('Others: PV_CONS_SS_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SS', SV_mens_retorno, '1.0', USER, 'PV_CONS_SS_PR', sSql, SQLCODE, V_des_error );
END PV_CONS_SS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END PV_SERV_SUPLE_II_PG;
/
SHOW ERRORS
