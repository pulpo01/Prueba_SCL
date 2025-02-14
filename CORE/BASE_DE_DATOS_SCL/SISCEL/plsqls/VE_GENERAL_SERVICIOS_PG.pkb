CREATE OR REPLACE PACKAGE BODY VE_GENERAL_SERVICIOS_PG
IS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	FUNCTION pv_rec_canal_venta_fn (
      eo_ve_tipcomis    IN OUT NOCOPY   ve_tipcomis_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	RETURN BOOLEAN
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';


        SELECT ind_vta_externa
		  INTO eo_ve_tipcomis.ind_vta_externa
          FROM ve_tipcomis
         WHERE cod_tipcomis = eo_ve_tipcomis.cod_tipcomis;


        RETURN TRUE;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := '1';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_tabla_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_eureka_pg.ga_valida_tabla_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := '156';
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_error_no_clasif;
       END IF;
       V_des_error := 'ga_valida_tabla_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_eureka_pg.ga_valida_tabla_fn', sSql, SQLCODE, v_des_error );
       RETURN FALSE;

    END pv_rec_canal_venta_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	PROCEDURE pv_ejec_restriccion_pr (
      pv_restricciones     IN              pv_restricciones_qt,
	  sn_cod_retorno_rest  OUT NOCOPY      NUMBER,
	  sv_mens_retorno_rest OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		seq_transacabo   NUMBER;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

		SELECT ga_seq_transacabo.NEXTVAL INTO seq_transacabo from dual;

        pv_pr_ejecuta_restriccion(seq_transacabo, pv_restricciones.cod_modulo, cv_prod_celular, pv_restricciones.cod_actuacion, pv_restricciones.cod_evento, pv_restricciones.parametros);

		SELECT cod_retorno, des_cadena
		  INTO sn_cod_retorno_rest, sv_mens_retorno_rest
          FROM ga_transacabo
         WHERE num_transaccion = seq_transacabo;


	EXCEPTION
    WHEN OTHERS THEN
       V_des_error := 'ga_valida_tabla_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_eureka_pg.ga_valida_tabla_fn', sSql, SQLCODE, v_des_error );

    END pv_ejec_restriccion_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE pv_rec_eventos_restriccion_pr (
      pv_restricciones     IN              pv_restricciones_qt,
	  SC_evento_restricc   OUT NOCOPY      refcursor,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
    )
    /*
    <Documentacion TipoDoc = "Function">
       <Elemento
          Nombre = "GA_CONSUL_PROMEDIO_FACTURAC_FN"
          Fecha modificacion=" "
          Fecha creacion="03-04-2006"
          Programador="Marcelo Godoy S. - Carlos Navarro"
          Diseñador=""
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>
          <Descripcion></Descripcion>
          <Parametros>
             <Entrada>
                <param nom="ev_nom_tabla" Tipo="NUMERICO">Nombre de tabla</param>
             </Entrada>
             <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
             </Salida>
          </Parametros>
       </Elemento>
    </Documentacion>
    */
	IS
	    V_des_error      ge_errores_pg.DesEvent;
	    sSql             ge_errores_pg.vQuery;
	    v_table_name     VARCHAR2(45);
		seq_transacabo   NUMBER;
	BEGIN

	    SN_cod_retorno := 0;
	    SN_num_evento  := 0;
	    SV_mens_retorno:= '';

          OPEN SC_evento_restricc FOR
        SELECT cod_evento
          FROM pv_actuac_restriccion a, pv_restricciones b
         WHERE a.cod_actuacion = pv_restricciones.cod_actuacion
           AND b.num_restriccion = a.num_restriccion;


	EXCEPTION
    WHEN OTHERS THEN
       V_des_error := 'ga_valida_tabla_fn(); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'ga_cons_eureka_pg.ga_valida_tabla_fn', sSql, SQLCODE, v_des_error );

    END pv_rec_eventos_restriccion_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END VE_GENERAL_SERVICIOS_PG;
/
SHOW ERRORS
