CREATE OR REPLACE PACKAGE BODY "GA_SERVICIOS_ABONADOS_PG"
IS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_DIRECCION_PR (EN_num_celular       IN     ga_abocel.num_celular%TYPE,
                                     EV_cod_region       IN     ge_direcciones.cod_region%TYPE,
                                     EV_cod_provincia    IN     ge_direcciones.cod_provincia%TYPE,
                                     EV_cod_ciudad       IN     ge_direcciones.cod_ciudad%TYPE,
                                     EV_cod_comuna       IN     ge_direcciones.cod_comuna%TYPE,
                                     EV_nom_calle        IN     ge_direcciones.nom_calle%TYPE,
                                     EV_num_calle        IN     ge_direcciones.num_calle%TYPE,
                                     EV_num_piso         IN     ge_direcciones.num_piso%TYPE,
                                     EV_cod_postal       IN     ge_direcciones.zip%TYPE,
                                     EV_observacion      IN     ge_direcciones.obs_direccion%TYPE,
                                     EV_desdir1          IN     ge_direcciones.des_direc1%TYPE,
                                     EV_desdir2          IN     ge_direcciones.des_direc2%TYPE,
                                     EV_cod_tipdireccion IN     ge_tipdireccion.cod_tipdireccion%TYPE,
 									 SN_numos		     OUT    NOCOPY   ci_orserv.num_os%TYPE,
							  		 SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              		 SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
	                              	 SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                                     )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_DIRECCION_PR"
      Lenguaje="PL/SQL"
      Fecha="26-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para servicio Actualización de dirección ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_region" Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_provincia" Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_cuidad" Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna" Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle" Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle" Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_cod_postal" Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_observacion" Tipo="CARACTER">Otros indicadores</param>
            <param nom="EV_desdir1" Tipo="CARACTER">Descripcion direccion 1</param>
            <param nom="EV_desdir2" Tipo="CARACTER">Descripcion direccion 2</param>
            <param nom="EV_cod_tipdireccion" Tipo="CARACTER">Código del tipo de direccion a modificar</param>
         </Entrada>
         <Salida>
            <param nom="SN_numos"     Tipo="Numerico">Orden de servicio generada</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
		sSql2               ge_errores_pg.vQuery;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_cod_provincia	ge_comunas.cod_provincia%TYPE;
 	    SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		LV_ejec_rest	    VARCHAR2(500);

    BEGIN
		--Inicializar variables...
	    sSql:=NULL;
	    sSql2:=NULL;
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_cod_retorno:=0;
        SN_num_evento:=0;
		SN_numos:=NULL;
		SV_mens_retorno:=NULL;

        -- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'')',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
        --Validar restricción-
		LN_num_transaccion:=NULL;
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - ',1,CN_largoquery);
		sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
	       SN_cod_retorno := '314';
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		--Validar datos de la direccion....
		-- 0.- Validar tipo de dirección válido...
		sSql:='ge_validaciones_pg.ge_valida_tipdir_fn('||EV_cod_tipdireccion||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
		IF NOT ge_validaciones_pg.ge_valida_tipdir_fn(EV_cod_tipdireccion,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '313';
           RAISE  error_ejecucion;
        END IF;

		--1.- Validar region...
		IF EV_cod_region IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_region_fn('||EV_cod_region||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
		   IF NOT ge_validaciones_pg.ge_valida_region_fn(EV_cod_region,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '304';
           RAISE  error_ejecucion;
		END IF;

		--2.- Validar provincia...
		IF EV_cod_provincia IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_provincia_fn('||EV_cod_provincia||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
		   IF NOT ge_validaciones_pg.ge_valida_provincia_fn(EV_cod_provincia,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '305';
           RAISE  error_ejecucion;
        END IF;

		--3.- Validar comuna...
		IF EV_cod_comuna IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_comuna_fn('||EV_cod_comuna||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
		   IF NOT ge_validaciones_pg.ge_valida_comuna_fn(EV_cod_comuna,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '307';
           RAISE  error_ejecucion;
		END IF;

		--4.- Validar cuidad...
		IF EV_cod_ciudad IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_ciudad_fn('||EV_cod_ciudad||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
		   IF NOT ge_validaciones_pg.ge_valida_ciudad_fn(EV_cod_ciudad,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '320';
           RAISE  error_ejecucion;
		END IF;

   		--Ejecutar procedimiento que obtiene datos del abonado, entre ellos el cod_cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
    	   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL  THEN
           SN_cod_retorno := '146';
    	   RAISE  error_ejecucion;
		END IF;

        --Solicitar cambio de direccion ...
		sSql:=SUBSTR('pv_cambiodireccion_pg.PV_CAMBDIRECCLI_PR('||SN_cod_cliente||','||
		       EV_cod_tipdireccion||','||EV_nom_calle||','||EV_num_calle||','||
			   EV_num_piso||','||EV_cod_region||','||EV_cod_provincia||','||
			   EV_cod_ciudad||','||EV_cod_comuna||','||EV_cod_postal||','||
			   EV_observacion||','||EV_desdir1||','||EV_desdir2||')',1,CN_largoquery);

		pv_cambiodireccion_pg.PV_CAMBDIRECCLI_PR(SN_cod_cliente,EV_cod_tipdireccion, EV_nom_calle,EV_num_calle, EV_num_piso, EV_cod_region, EV_cod_provincia, EV_cod_ciudad, EV_cod_comuna, EV_cod_postal, EV_observacion, EV_desdir1, EV_desdir2, SN_numos, SN_cod_retorno, V_des_error);
		IF SN_cod_retorno<>1 THEN
           SN_cod_retorno := '302'; -- No fue posible modificar dirección---
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
   		   V_des_error:=SUBSTR('GA_MODIFICAR_DIRECCION_PR: '||V_des_error,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'pv_cambiodireccion_pg.PV_CAMBDIRECCLI_PR', sSql, SQLCODE, V_des_error);
		   RAISE error_ejecucion;
		END IF;
        SN_COD_RETORNO:=0;
	    SV_mens_retorno:=NULL;


   EXCEPTION
    WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion : GA_MODIFICAR_DIRECCION_PR('||EN_num_celular||', '||EV_cod_region||', '||EV_cod_provincia||', '||EV_cod_ciudad||', '||EV_cod_comuna||', '||EV_nom_calle||', '||EV_num_calle||', '
                            ||EV_num_piso||', '||EV_cod_postal||', '||EV_observacion||', '||EV_desdir1||', '||EV_desdir2||','||EV_cod_tipdireccion||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_MODIFICAR_DIRECCION_PR', sSql, SQLCODE, V_des_error );
     WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('OTHERS : GA_MODIFICAR_DIRECCION_PR('||EN_num_celular||', '||EV_cod_region||', '||EV_cod_provincia||', '||EV_cod_ciudad||', '||EV_cod_comuna||', '||EV_nom_calle||', '||EV_num_calle||', '
                            ||EV_num_piso||', '||EV_cod_postal||', '||EV_observacion||', '||EV_desdir1||', '||EV_desdir2||','||EV_cod_tipdireccion||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_MODIFICAR_DIRECCION_PR', sSql, SQLCODE, V_des_error );
END GA_MODIFICA_DIRECCION_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_CLAVE_WEB_PR (EN_num_celular   IN     ga_abocel.num_celular%TYPE,
                                SV_clave         OUT NOCOPY     ga_abocel.cod_password%TYPE,
							  	SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                              	SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              	SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_CLAVE_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que retorna la clave secreta de acceso a la web de un abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_clave" Tipo="CARACTER">Contraseña web de un abonado/param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
 	    SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	    ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
    BEGIN
		SN_cod_retorno := '0';
        SN_num_evento  := 0;

		 --Inicializacion de variables de salida...
		SV_clave:=NULL;
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;

		-- Ejecutar procedimiento que obtiene datos del abonado, entre ellos la clave web
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
	       SN_cod_retorno := '146';
		   RAISE  error_ejecucion;
		ELSE
		   SV_clave:=SV_cod_password;
		END IF;


    EXCEPTION
    WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error := SUBSTR('error_ejecucion : GA_CONS_CLAVE_WEB_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
     WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error := SUBSTR('others : GA_CONS_CLAVE_WEB_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
END GA_CONS_CLAVE_WEB_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_VALIDA_CLAVE_WEB_PR (EN_num_celular   IN     ga_abocel.num_celular%TYPE,
                                  EV_clave         IN     ga_abocel.cod_password%TYPE,
                                  SN_validacion    OUT NOCOPY     NUMBER,
							  	  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_VALIDA_CLAVE_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio ejecuta servicio Check pin ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_clave" Tipo="CARACTER">Contraseña web a validar/param>
         </Entrada>
         <Salida>
            <param nom="SN_validacion"    Tipo="NUMERICO">Valor que indica si clave es valida.0=error,otro valor es ok</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
		SV_clave		    ga_abocel.cod_password%TYPE;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	    VARCHAR2(500);
		LV_val_parametro	ged_parametros.nom_parametro%TYPE;
		SN_num_abonado		ga_abocel.num_abonado%TYPE;

    BEGIN
	   -- Inicializacion de variables...
	   sSql:=NULL;
	   SV_clave:=NULL;
	   SN_validacion:=0;
	   SN_num_abonado:=NULL;

	   -- Validar si numero celular cumple con el largo definido...
	    sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	        SN_cod_retorno := '303';
            RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - ',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
       --Validar restricción-
		SN_cod_retorno := '0';
        SN_num_evento  := 0;
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - ',1,CN_largoquery);
		sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
           SN_cod_retorno := '314';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		--Obtiene largo de la clave web y compara si es el largo de la variable ingresada....
	    LV_val_parametro:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_len_pin||','||CV_cod_modulo||','||CV_cod_producto_post||');';
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_len_pin,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '302';
			 RAISE  error_ejecucion;
		END IF;

		IF LV_val_parametro IS NULL THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

        sSql:='LV_val_parametro:=TO_NUMBER('||LV_val_parametro||')';
   	    LV_val_parametro:=TO_NUMBER(LV_val_parametro);
		IF LV_val_parametro<1 THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;


        sSql:='LENGTH('||EV_clave||')>'||LV_val_parametro||')';
		IF LENGTH(EV_clave)> LV_val_parametro THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

	     sSql:='LENGTH('||EV_clave||')<'||LV_val_parametro||')';
		IF LENGTH(EV_clave)< LV_val_parametro THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

       -- Ejecutar procedimiento que consulta la clave web a validar...
       sSql:=SUBSTR('GA_SERVICIOS_ABONADOS_PG.GA_CONS_CLAVE_WEB_PR('||EN_num_celular||','||SV_clave||','
	          ||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
	   GA_SERVICIOS_ABONADOS_PG.GA_CONS_CLAVE_WEB_PR(EN_num_celular,SV_clave,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		-- Comparar la clave a validar v/s clave obtenida...
		IF EV_clave = SV_clave THEN
		   SN_validacion:=1;
		END IF;

    EXCEPTION
    WHEN error_ejecucion  THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('error_ejecucion : GA_VALIDA_CLAVE_WEB_PR('||EN_num_celular||', '||EV_clave||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_VALIDA_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );

    WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('OTHERS : GA_VALIDA_CLAVE_WEB_PR('||EN_num_celular||', '||EV_clave||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_VALIDA_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
END GA_VALIDA_CLAVE_WEB_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_ABONADO_PR (EV_clave        IN ga_abocel.cod_password%TYPE,
								  EN_num_abonado  IN ga_abocel.num_abonado%TYPE,
								  EV_cod_tipmodi  IN ga_modabocel.cod_tipmodi%TYPE,
								  EV_tip_terminal IN ga_abocel.tip_terminal%TYPE,
								  EV_serie        IN ga_abocel.num_serie%TYPE,
								  EV_numseriehex  IN ga_abocel.num_seriehex%TYPE,
								  EV_seriemec     IN ga_abocel.num_seriemec%TYPE,
		  						  EV_tipo_abonado IN VARCHAR2,
							  	  SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que actualiza contraseña web del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_clave"  	   	    Tipo="CARACTER">Nueva Contraseña web del abonado</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EV_cod_tipmodi"    Tipo="CARACTER">Tipo de modIFicacion</param>
            <param nom="EV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
            <param nom="EV_serie"           Tipo="CARACTER">Numero de serie decimal</param>
            <param nom="EV_numseriehex"    Tipo="CARACTER">Numero de serie hexadecimal</param>
            <param nom="EV_seriemec"    Tipo="CARACTER">Numero de serie mecanico</param>
            <param nom="EV_tipo_abonado"    Tipo="CARACTER">Tipo de Abonado PREPAGO, POSTPAGO</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        V_des_error      ge_errores_pg.DesEvent;
        sSql             ge_errores_pg.vQuery;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

        -- 1.- Actualizar clave del abonado...
		IF EV_tipo_abonado=CV_postpago THEN
		   sSql:='UPDATE GA_ABOCEL SET COD_PASSWORD='||EV_clave;
		   sSql:=sSql||' WHERE NUM_ABONADO='||EN_num_abonado;
		   UPDATE GA_ABOCEL
		      SET COD_PASSWORD=EV_clave
		   WHERE NUM_ABONADO=EN_num_abonado;
		ELSE
		   sSql:='UPDATE GA_ABOAMIST SET COD_PASSWORD='||EV_clave;
		   sSql:=sSql||' WHERE NUM_ABONADO='||EN_num_abonado;
		   UPDATE GA_ABOAMIST
		      SET COD_PASSWORD=EV_clave
		   WHERE NUM_ABONADO=EN_num_abonado;
		END IF;

        -- 2.- Insertar registro en modIFicaciones para abonado..
		sSql:=SUBSTR('INSERT INTO GA_MODABOCEL	(NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,'||
		      'NOM_USUARORA,TIP_TERMINAL,NUM_SERIE,NUM_SERIEHEX,NUM_SERIEMEC)'||
		      ' VALUES('||EN_num_abonado||','||EV_cod_tipmodi||',SYSDATE,'||
	   	      USER||','||EV_tip_terminal||','||EV_serie||','||EV_numseriehex||','||
		      EV_seriemec||');',1,CN_largoquery);

		INSERT INTO GA_MODABOCEL
		(NUM_ABONADO,
		 COD_TIPMODI,
		 FEC_MODIFICA,
		 NOM_USUARORA,
		 TIP_TERMINAL,
		 NUM_SERIE,
		 NUM_SERIEHEX,
		 NUM_SERIEMEC)
		 VALUES
		 (EN_num_abonado,
		  EV_cod_tipmodi,
		  SYSDATE,
		  USER,
		  EV_tip_terminal,
		  EV_serie,
		  EV_numseriehex,
		  EV_seriemec);

	EXCEPTION
    WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('OTHERS : GA_MODIFICA_ABONADO_PR('||EV_clave||','||EN_num_abonado||','||EV_cod_tipmodi||','
				            ||EV_tip_terminal||','||EV_serie||','||EV_numseriehex||','||EV_seriemec||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_ABONADO_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;
END GA_MODIFICA_ABONADO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MODIFICA_CLAVE_WEB_PR (EN_num_celular IN     ga_abocel.num_celular%TYPE,
		  						  EV_clave_p       IN     ga_abocel.cod_password%TYPE,
								  SN_numos         OUT NOCOPY   ci_orserv.num_os%TYPE,
							  	  SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_CLAVE_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que ModIFica contraseña web del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EV_clave"  	   	    Tipo="CARACTER">Nueva Contraseña web del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_numos"       Tipo="NUMERICO">Numero de ordern de servicio</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
		sSql2				ge_errores_pg.vQuery;
 	    SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		SN_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;
		SV_cod_grupo        al_tecnologia.cod_grupo%TYPE;
		SS_mensaje		    VARCHAR2(10);
		SV_val_parametro    ged_parametros.val_parametro%TYPE;
		VP_secuencia        NUMBER;
		LV_val_grupo_tdma   ged_parametros.val_parametro%TYPE;
		LV_val_grupo_gsm    ged_parametros.val_parametro%TYPE;
		SN_cod_servsupl     ga_servsuplabo.cod_servsupl%TYPE;
		SN_cod_nivel        ga_servsuplabo.cod_nivel%TYPE;
		VP_ICC			    ICC_MOVIMIENTO.ICC%TYPE;
		VP_IMEI			    ICC_MOVIMIENTO.IMEI%TYPE;
		VP_IMSI_NUE		    ICC_MOVIMIENTO.IMSI%TYPE;
 		LV_grupo		    ci_tiporserv.grupo%TYPE;
		VP_COD_INTER        CI_ORSERV.COD_INTER%TYPE;
        LV_esn              ga_abocel.num_serie%TYPE;
	    V_descripcion 	    ci_tiporserv.descripcion%TYPE;
		V_cod_tipmodi 	    ci_tiporserv.cod_tipmodi%TYPE;
        V_nom_exe 	   	    ci_tiporserv.nom_exe%TYPE;
		V_menu    	   	    ci_tiporserv.menu%TYPE;
		V_cod_aplic   	    ci_tiporserv.cod_aplic%TYPE;
		N_tip_ooss          ci_tiporserv.tip_ooss%TYPE;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_val_parametro    ged_parametros.val_parametro%TYPE;
		EV_clave            ga_abocel.cod_password%TYPE;
		LV_ejec_rest	    VARCHAR2(500);
		LN_cod_central      ga_abocel.cod_central%TYPE;
		VP_ERRORSEV			VARCHAR2(500);
		LV_comentario       ci_orserv.comentario%TYPE;

    BEGIN
	    EV_clave:=TRIM(EV_clave_p);
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

	    --Inicializacion de variables de salida...
	    sSql:=NULL;
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_cod_ciclfact:=NULL;
		SV_cod_grupo:=NULL;
		SS_mensaje:=NULL;
		LV_val_grupo_tdma:=NULL;
		LV_val_grupo_gsm:=NULL;
		SV_val_parametro:=NULL;
		SN_cod_servsupl:=NULL;
		SN_cod_nivel:=NULL;
		VP_ICC:=NULL;
		VP_IMEI:=NULL;
		VP_IMSI_NUE:=NULL;
		LV_grupo:=NULL;
		VP_COD_INTER:=NULL;
		LV_esn:=NULL;
		SN_numos:=NULL;
		VP_ERRORSEV:=NULL;

 	    -- Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');-',1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
            SN_cod_retorno := '303';
            RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - ',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - ',1,CN_largoquery);
		sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '314';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		-- Obtiene largo de la clave web y compara si es el largo de la variable ingresada....
	    LV_val_parametro:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_len_pin||','||CV_cod_modulo||','||CV_cod_producto_post||'); - ',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_len_pin,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '302';
			 RAISE  error_ejecucion;
		END IF;

		IF LV_val_parametro IS NULL THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

        sSql:='LV_val_parametro:=TO_NUMBER('||LV_val_parametro||')';
   	    LV_val_parametro:=TO_NUMBER(LV_val_parametro);
		IF LV_val_parametro<1 THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

		sSql:='EV_clave IS NULL OR LENGTH('||EV_clave||') IS NULL';
		IF EV_clave IS NULL OR LENGTH(EV_clave) IS NULL  THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

        sSql:='LENGTH('||EV_clave||')>'||LV_val_parametro||')';
		IF LENGTH(EV_clave)> LV_val_parametro THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

	    sSql:='LENGTH('||EV_clave||')<'||LV_val_parametro||')';
		IF LENGTH(EV_clave)< LV_val_parametro THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

		-- Ejecutar procedimiento que obtiene datos del abonado.....
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
 	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
           SN_cod_retorno := '146';
		   RAISE  error_ejecucion;
		END IF;

		-- Si es postpago  se verifica el ciclo de facturacion..
		IF SV_tipo_abonado=CV_postpago THEN  -- es postpago----
     		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_ciclo_fn('||EN_num_celular||','||SN_cod_cliente
			      ||','||SN_num_abonado||','||SN_cod_ciclo||');',1,CN_largoquery);
		   IF NOT ge_validaciones_pg.ge_valida_ciclo_fn (EN_num_celular,SN_cod_cliente,SN_num_abonado,
		   	  					  SN_cod_ciclo,SN_cod_ciclfact,
		        				  SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '310';
			 RAISE  error_ejecucion;
		  END IF;
		END IF;

		-- Obtener el grupo tecnologico..
		SV_cod_grupo:=NULL;
        sSql:=SUBSTR('GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||SV_tecnologia||');-',1,CN_largoquery);
		SV_cod_grupo:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(SV_tecnologia);
		IF TRIM(SV_cod_grupo)=CV_ERROR THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

		-- Obtener datos desde GED_parametros para grupo tdma...OJO QUE ES DISTINTO PARA CADA PRODUCTO!!!
        SV_val_parametro:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_grupo_tdma||','||CV_cod_modulo||','||CV_cod_producto_post||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_grupo_tdma,CV_cod_modulo,
		   	   				  CV_cod_producto_post,SV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

		LV_val_grupo_tdma:=SV_val_parametro;

		-- 4.2.- Obtener datos desde GED_parametros para grupo gsm...OJO QUE ES DISTINTO PARA CADA PRODUCTO!!!
        SV_val_parametro:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_grupo_gsm||','||CV_cod_modulo||','||CV_cod_producto_post||');-',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_grupo_gsm,CV_cod_modulo,
		   	   				  CV_cod_producto_post,SV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

		LV_val_grupo_gsm:=SV_val_parametro;

		 IF SV_cod_grupo=LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
		    VP_ICC:=SV_num_serie;
		    VP_IMEI:=SV_num_imei;
		    VP_IMSI_NUE:=FN_RECUPERA_IMSI(SV_num_serie);
		    LV_esn:=SV_num_imei;
		ELSE
		    IF SV_cod_grupo=LV_val_grupo_tdma THEN
			   LV_esn:=SV_num_serie;
			END IF;
		END IF;

		-- 5.- Ejecutar procedimiento  que modifica la contraseña del abonado...
		sSql:=SUBSTR('GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_ABONADO_PR('||EV_clave ||','||SN_num_abonado||','||CV_cod_actabo||','||SV_tip_terminal
		      ||','||LV_esn||','||SV_num_seriehex||','
		      ||SV_num_seriemec||','||SV_tipo_abonado||','||SN_cod_retorno||','
			  ||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
 	    GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_ABONADO_PR(EV_clave, SN_num_abonado,
		     CV_cod_actabo, SV_tip_terminal,LV_esn,SV_num_seriehex,
		      SV_num_seriemec, SV_tipo_abonado,SN_cod_retorno,
		      SV_mens_retorno, SN_num_evento);

		-- 6.- Ejecutar funcion que valida los servicios de acuerdo a lo que sigue...
		-- Servicio_1 = 110 (SV_tipo_abonado = 'POSTPAGO' o SV_tipo_abonado = 'PREPAGO')
  	    -- Servicio_2 = 74 (sólo en caso que SV_tipo_abonado = 'POSTPAGO')
		-- Servicio_3= 126 (sólo en caso que SV_tipo_abonado = 'PREPAGO')

	    -- 6.1.- verificar servicio 110 --
        sSql:=SUBSTR('ge_validaciones_pg.ge_cons_ss_mensajeria_fn('||SN_num_abonado||','||CV_cod_serv1||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_cons_ss_mensajeria_fn(SN_num_abonado,CV_cod_serv1,SN_cod_servsupl,
		   SN_cod_nivel,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		   IF SN_cod_retorno<>0 THEN
		   	  RAISE error_ejecucion;
		   END IF;
  		   IF SV_tipo_abonado=CV_postpago THEN  -- es postpago----
		      --6.2 verificar servicio 74
			  sSql:=SUBSTR('ge_validaciones_pg.ge_cons_ss_mensajeria_fn('||SN_num_abonado||','||CV_cod_serv2||');',1,CN_largoquery);
			  IF NOT ge_validaciones_pg.ge_cons_ss_mensajeria_fn(SN_num_abonado,CV_cod_serv2,SN_cod_servsupl,
		   	  	 	 SN_cod_nivel,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		          IF SN_cod_retorno<>0 THEN
		   	         RAISE error_ejecucion;
		          END IF;
			  END IF;
		   ELSE
			  --6.3. verificar servicio 126...
	          sSql:=SUBSTR('ge_validaciones_pg.ge_cons_ss_mensajeria_fn('||SN_num_abonado||','||CV_cod_serv3||');',1,CN_largoquery);
			  IF NOT ge_validaciones_pg.ge_cons_ss_mensajeria_fn(SN_num_abonado,CV_cod_serv3,SN_cod_servsupl,
		   	  	 	 SN_cod_nivel,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		          IF SN_cod_retorno<>0 THEN
		   	         RAISE error_ejecucion;
		          END IF;
		   	  END IF;
		  	NULL;
		   END IF;
		END IF;

		SS_mensaje:=trim(to_char(SN_cod_servsupl,'00'))||trim(to_char(SN_cod_nivel,'0009'));
		   LV_comentario:=NULL;
		   sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_comentario||','||CV_cod_modulo_pv||','||CV_cod_producto_post||');',1,CN_largoquery);
		   IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_comentario,CV_cod_modulo_pv,
		   	   				  CV_cod_producto_post,LV_comentario,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
              SN_cod_retorno := '302';
 		      RAISE  error_ejecucion;
		   END IF;

		   --7.0. Obtener central del abonado....
		  LN_cod_central:=NULL;
	      sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_codcen_fn('||SN_num_abonado||');',1,CN_largoquery);
		  IF NOT ge_validaciones_pg.ge_obtiene_codcen_fn(SN_num_abonado,LN_cod_central,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		  END IF;


	       --7.1.- Obtener grupo de la orden de servicio....
		   VP_COD_INTER:=SN_cod_cliente;
           sSql:=SUBSTR('ge_validaciones_pg.ge_recupera_tiporserv_fn('||CV_cod_os_10105||');',1,CN_largoquery);
		   IF ge_validaciones_pg.ge_recupera_tiporserv_fn(CV_cod_os_10105,V_descripcion,V_cod_tipmodi,LV_grupo,V_nom_exe,V_menu,V_cod_aplic,N_tip_ooss,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
	          IF LV_grupo = '1' THEN
		         IF SN_num_abonado IS NOT NULL THEN
   			        VP_COD_INTER:=SN_num_abonado;
			      END IF;
			  END IF;
		   END IF;
		   IF SN_cod_retorno<>0 THEN
		      RAISE error_ejecucion;
		   END IF;

   		   -- 7.2.- Ejecutar procedimiento que aprovisiona en centrales ...
		   sSql:='SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO VP_secuencia FROM DUAL';
		   VP_secuencia:=NULL;
	       SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO VP_secuencia FROM DUAL;

		   sSql:=SUBSTR('GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_SRV_PR('||VP_secuencia||','||
		   	    SN_num_abonado||',''1'','''||CV_cod_actabo||''','||CV_cod_modulo||','||USER||','||TO_CHAR(SYSDATE,'DD-MM-YYYY')||','||SV_tip_terminal||','||
				LN_cod_central||',0,NULL,'||EN_num_celular||','||SV_num_seriehex||','||'NULL,NULL,NULL,'||
				SS_mensaje||','||SV_num_min||','||'NULL,'||SV_tecnologia||','||VP_IMSI_NUE||','||
				VP_IMEI||','||'NULL,'||VP_ICC||',NULL,NULL,NULL,NULL,NULL,NULL,'||
				VP_ERRORSEV||','||SN_num_evento||','||SV_mens_retorno||');',1,CN_largoquery);

		   GA_APROVISIONAR_CENTRAL_PG.GA_APROVISIONAR_SRV_PR
			   (VP_secuencia,SN_num_abonado,1,CV_cod_actabo,CV_cod_modulo,
				USER,TO_CHAR(SYSDATE,'DD-MM-YYYY'),SV_tip_terminal,
				LN_cod_central,
				0,
				NULL,
  			    EN_num_celular,
				SV_num_seriehex,
				NULL,
				NULL,
				NULL,
				SS_mensaje,
				SV_num_min,
				NULL,
				SV_cod_grupo,
				VP_IMSI_NUE,
				VP_IMEI,
				NULL,
				VP_ICC,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				VP_ERRORSEV,
				SN_num_evento,SV_mens_retorno);

		   IF SN_num_evento<> 0 THEN
		   	  SN_cod_retorno:='302';
		      RAISE error_ejecucion;
		   END IF;

		   --8.2.- Ejecutar la orden de servicio....
           sSql:=SUBSTR('ge_validaciones_pg.ge_registra_ooss_fn('||CV_cod_os_10105||','||CV_cod_producto_post||','||LV_grupo||','||VP_COD_INTER||','||USER||'NULL,NULL,'||CV_cod_modulo||',NULL,NULL,NULL,'||SN_numos||');',1,CN_largoquery);
		   IF NOT ge_validaciones_pg.ge_registra_ooss_fn(CV_cod_os_10105,CV_cod_producto_post,LV_grupo,VP_COD_INTER,USER,LV_comentario,NULL,CV_cod_modulo,NULL,NULL,NULL,SN_numos,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                SN_cod_retorno := '302';
 	   		    RAISE error_ejecucion;
 	       END IF;


EXCEPTION
WHEN error_ejecucion  THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_MODIFICA_CLAVE_WEB_PR('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MODIFICA_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;

WHEN NO_DATA_FOUND  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('no_data_found: GA_MODIFICA_CLAVE_WEB_PR('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MODIFICA_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('others: GA_MODIFICA_CLAVE_WEB_PR('||EN_num_celular||','||EV_clave||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MODIFICA_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;

END GA_MODIFICA_CLAVE_WEB_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DEFAULT_CLAVE_WEB_PR (EN_num_celular  IN           ga_abocel.num_celular%TYPE,
							  	  SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DEFAULT_CLAVE_WEB_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que reseta contraseña web del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"     Tipo="NUMERICO">Secuencia nro del abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
 	    SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
	    SN_numos            ci_orserv.num_os%TYPE;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_val_parametro    ged_parametros.val_parametro%TYPE;
		LV_ejec_rest	    VARCHAR2(500);

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

	    --Inicializacion de variables ..
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_numos:=NULL;

 	    -- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           SN_cod_retorno:= '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - ',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||');',1,CN_largoquery);
		sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '314';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		--  Ejecutar procedimiento que obtiene datos del abonado, entre ellos la serie...
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0  THEN
 		   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL OR SV_num_serie IS NULL  THEN
           SN_cod_retorno:= '146';
 		   RAISE  error_ejecucion;
		END IF;

        -- Obtener largo de la clave web...
	    LV_val_parametro:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_len_pin||','||CV_cod_modulo||','||CV_cod_producto_post||');';
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_len_pin,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '302';
			 RAISE  error_ejecucion;
		END IF;


		IF LV_val_parametro IS NULL THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

        sSql:='LV_val_parametro:=TO_NUMBER('||LV_val_parametro||')';
   	    LV_val_parametro:=TO_NUMBER(LV_val_parametro);
		IF LV_val_parametro<1 THEN
           SN_cod_retorno:= '302';
		   RAISE  error_ejecucion;
		END IF;

        -- Obtener clave por default (X ultimos digitos del numero de serie)
        sSql:='SV_num_serie:=SUBSTR('||SV_num_serie||',length('||SV_num_serie||')((to_number('||LV_val_parametro||')-1)),'||LV_val_parametro||');';
		SV_num_serie:=SUBSTR(SV_num_serie,length(SV_num_serie)-((to_number(LV_val_parametro)-1)),LV_val_parametro);
        -- Ejecutar la modIFicación de la clave del abonado ..
		sSql:='GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_CLAVE_WEB_PR('||EN_num_celular||','||SV_num_serie||','||');';
	    GA_SERVICIOS_ABONADOS_PG.GA_MODIFICA_CLAVE_WEB_PR(EN_num_celular,SV_num_serie,
		    SN_numos, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
			 RAISE  error_ejecucion;
		END IF;


	EXCEPTION
    WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_DEFAULT_CLAVE_WEB_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
		        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DEFAULT_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
    WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('Others: GA_DEFAULT_CLAVE_WEB_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
		        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DEFAULT_CLAVE_WEB_PR', sSql, SQLCODE, V_des_error );
END GA_DEFAULT_CLAVE_WEB_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DATOS_ABO_PR   (EN_num_celular   IN          ga_abocel.num_celular%TYPE,
								  SN_num_abonado   OUT NOCOPY  ga_abocel.num_abonado%TYPE,
 								  SV_tip_plantarif OUT NOCOPY  ga_abocel.tip_plantarif%TYPE,
								  SN_cod_categoria OUT NOCOPY  ge_clientes.cod_categoria%TYPE,
								  SV_tip_terminal  OUT NOCOPY  ga_abocel.tip_terminal%TYPE,
 								  SV_cod_plantarif OUT NOCOPY  ga_abocel.cod_plantarif%TYPE,
   								  SV_cod_valor     OUT NOCOPY  ge_valores_cli.cod_valor%TYPE,
 								  SV_des_valor     OUT NOCOPY  ge_valores_cli.des_valor%TYPE,
								  SV_cod_tiplan    OUT NOCOPY  ged_codigos.cod_valor%TYPE,
								  SV_des_tiplan    OUT NOCOPY  ged_codigos.des_valor%TYPE,
							  	  SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
                              	  SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
                              	  SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_DATOS_ABO_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que retorna datos de una cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SV_tip_plantarif"   Tipo="CARACTER">Tipo de plan tarIFario</param>
            <param nom="SN_cod_categoria"     Tipo="NUMERICO">Categoria del Cliente</param>
            <param nom="SV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
            <param nom="SV_cod_plantarif"   Tipo="CARACTER">Codigo plan tarIFario</param>
            <param nom="SV_cod_valor"   Tipo="CARACTER">Código del valor de comportamiento del cliente</param>
            <param nom="SV_des_valor"   Tipo="CARACTER">Descripción del código del valor de comportamiento del cliente</param>
            <param nom="SV_cod_tiplan"   Tipo="CARACTER">Código del tipo de plan</param>
            <param nom="SV_des_tiplan"   Tipo="CARACTER">Descripción del tipo de plan</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion    EXCEPTION ;
        V_des_error        ge_errores_pg.DesEvent;
        sSql               ge_errores_pg.vQuery;
        sSql2               ge_errores_pg.vQuery;
		SN_cod_cliente     ga_abocel.cod_cliente%TYPE;
		SN_cod_producto    ga_abocel.cod_producto%TYPE;
		SV_cod_situacion   ga_abocel.cod_situacion%TYPE;
		SN_cod_ciclo	   ga_abocel.cod_ciclo%TYPE;
		SV_num_imei        ga_abocel.num_imei%TYPE;
		SV_num_min_mdn     ga_abocel.num_min_mdn%TYPE;
		SV_cod_password    ga_abocel.cod_password%TYPE;
		SV_num_min         ga_abocel.num_min%TYPE;
		SV_num_serie	   ga_abocel.num_serie%TYPE;
		SV_num_seriehex    ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	   ga_abocel.num_seriemec%TYPE;
		SV_tecnologia	   ga_abocel.cod_tecnologia%TYPE;
		SV_tipo_abonado    VARCHAR2(10);
		SN_cod_cuenta	   ga_abocel.cod_cuenta%TYPE;
		SV_cod_tipident    ge_clientes.cod_tipident%TYPE;
		SV_num_ident       ge_clientes.num_ident%TYPE;
		SV_des_tipident    ge_tipident.des_tipident%TYPE;
		LN_num_transaccion ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno     ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena	   ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	   VARCHAR2(500);

    BEGIN
        SN_cod_retorno :=0;
        SN_num_evento  :=0;

		--Inicializacion de variables ....
	    sSql:=NULL;
		SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
		SN_cod_ciclo:=NULL;
		SV_num_serie:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SV_tecnologia:=NULL;
 		SN_cod_categoria:=NULL;
		SV_cod_tipident:=NULL;
		SV_num_ident:=NULL;
		SV_des_tipident:=NULL;
		SV_cod_tiplan:=NULL;
		SV_des_tiplan:=NULL;

 	    -- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'')',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||');',1,CN_largoquery);
		 sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '314';
		   SN_num_abonado:=NULL;
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		-- Ejecutar procedimiento que obtiene datos del abonado
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
  	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
	       SN_cod_retorno := '146';
		   RAISE  error_ejecucion;
		END IF;

		-- Ejecutar procedimiento que obtiene datos del cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR('||SN_cod_cliente||','||SN_cod_cuenta||','||SN_cod_categoria||','
			  ||SV_cod_tipident||','||SV_num_ident||','||SV_des_tipident||','||SN_cod_retorno||','
			  ||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR(SN_cod_cliente,SN_cod_cuenta,SN_cod_categoria,
			   SV_cod_tipident,SV_num_ident,SV_des_tipident,
			   SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;

		-- Ejecutar procedimiento que obtiene clasificación del cliente....
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_COMPOR_CLIENTE_PR('||SN_cod_cliente||','||SV_cod_valor||','
			  ||SV_des_valor||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_COMPOR_CLIENTE_PR(SN_cod_cliente,SV_cod_valor,
			   SV_des_valor,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

		IF SN_cod_retorno<>0 THEN  --Implica que hay error
		   RAISE  error_ejecucion;
		END IF;

		-- Ejecutar procedimiento que obtiene codigo y descripcion del tipo de producto asociado al plan del abonado....
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR('||SV_cod_plantarif||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR(SV_cod_plantarif,SV_cod_tiplan,
			   SV_des_tiplan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error
		   RAISE  error_ejecucion;
		END IF;



EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('error_ejecucion: GA_CONS_DATOS_ABO_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_DATOS_ABO_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('Others: GA_CONS_DATOS_ABO_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_DATOS_ABO_PR', sSql, SQLCODE, V_des_error );
END GA_CONS_DATOS_ABO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_CONS_DAT_TERMINAL_ABO_PR (EN_num_celular   IN          ga_abocel.num_celular%TYPE,
								       SV_num_min       OUT NOCOPY  ga_abocel.num_min%TYPE,
								       SV_esn           OUT NOCOPY  ga_abocel.num_serie%TYPE,
								  	   SV_imsi          OUT NOCOPY  ga_abocel.num_imei%TYPE,
								  	   SV_des_tipident  OUT NOCOPY  ge_tipident.des_tipident%TYPE,
								  	   SV_num_ident     OUT NOCOPY  ge_clientes.num_ident%TYPE,
 								  	   SV_cod_tipident  OUT NOCOPY  ge_clientes.cod_tipident%TYPE,
							  		   SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
                              		   SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
                              		   SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
                                  	  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONS_DAT_TERMINAL_ABO_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio que consulta datos del terminal e identificacion de un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_num_min     Tipo="CARACTER">Numero min</param>
            <param nom="SV_esn"   Tipo="CARACTER">Serie del terminal / simcard</param>
            <param nom="SV_imsi"     Tipo="CARACTER">Serie del terminal GSM</param>
            <param nom="SV_des_tipident"    Tipo="CARACTER">Descripción tipo de identIFicación</param>
            <param nom="SV_num_ident"   Tipo="CARACTER">Número de identIFicación</param>
            <param nom="SV_cod_tipident"   Tipo="CARACTER">Código de identIFicación</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        sSql2               ge_errores_pg.vQuery;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
        SN_cod_categoria    ge_clientes.cod_categoria%TYPE;
		LV_val_grupo_tdma   ged_parametros.val_parametro%TYPE;
		LV_val_grupo_gsm    ged_parametros.val_parametro%TYPE;
 		LV_grupo		    ci_tiporserv.grupo%TYPE;
		SV_cod_grupo        al_tecnologia.cod_grupo%TYPE;
		SV_val_parametro    ged_parametros.val_parametro%TYPE;
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	    VARCHAR2(500);

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializacion de variables....
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
		SN_cod_ciclo:=NULL;
		SV_num_serie:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SV_tecnologia:=NULL;
		SV_cod_tipident:=NULL;
		SV_num_ident:=NULL;
		SV_des_tipident:=NULL;
	    SN_cod_categoria:=NULL;
        SV_esn:=NULL;
		SV_imsi:=NULL;
		LV_val_grupo_tdma:=NULL;
		LV_val_grupo_gsm:=NULL;
		LV_grupo:=NULL;
		SV_cod_grupo:=NULL;
		SV_val_parametro:=NULL;

 	    -- Validar si numero celular cumple con el largo definido...
		sSql:='ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');';
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'') - ',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

/* Inicio - 29-06-2005 - Eliminar restricción sólo postpago....
	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||');',1,CN_largoquery);
		sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '314';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 Fin - 29-06-2005 */

		-- Ejecutar procedimiento que obtiene datos del abonado
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
 	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
	       SN_cod_retorno:='146';
		   RAISE  error_ejecucion;
		END IF;

		-- Ejecutar procedimiento que obtiene datos del cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR('||SN_cod_cliente||','||SN_cod_cuenta||','||SN_cod_categoria||','
			  ||SV_cod_tipident||','||SV_num_ident||','||SV_des_tipident||','||SN_cod_retorno||','
			  ||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
  	    GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR(SN_cod_cliente,SN_cod_cuenta,SN_cod_categoria,
			   SV_cod_tipident,SV_num_ident,SV_des_tipident,
			   SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
		   RAISE  error_ejecucion;
		END IF;

		-- Obtener grupo tecnologico....
        sSql:='GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN('||SV_tecnologia||');';
		SV_cod_grupo:=GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(SV_tecnologia);
		IF TRIM(SV_cod_grupo)=CV_ERROR THEN
            SN_cod_retorno:='302';
			RAISE  error_ejecucion;
		END IF;

		-- Obtener datos desde GED_parametros para grupo tdma...OJO QUE ES DISTINTO PARA CADA PRODUCTO!!!
        SV_val_parametro:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_grupo_tdma||','||CV_cod_modulo||','||CV_cod_producto_post||');';
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_grupo_tdma,CV_cod_modulo,
		   	   				  CV_cod_producto_post,SV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno:='302';
		   RAISE  error_ejecucion;
		END IF;

		LV_val_grupo_tdma:=SV_val_parametro;

		-- Obtener datos desde GED_parametros para grupo gsm...OJO QUE ES DISTINTO PARA CADA PRODUCTO!!!
        SV_val_parametro:=NULL;
        sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_grupo_gsm||','||CV_cod_modulo||','||CV_cod_producto_post||');';
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_grupo_gsm,CV_cod_modulo,
		   	   				  CV_cod_producto_post,SV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno :='302';
		   RAISE  error_ejecucion;
		END IF;

		LV_val_grupo_gsm:=SV_val_parametro;

		--Retornar valores...
		IF SV_cod_grupo=LV_val_grupo_gsm  THEN  --Si grupo tecnologico es GSM ....
		   SV_imsi:=SV_num_serie;
		   SV_esn:=SV_num_imei;
		ELSE
		    IF SV_cod_grupo=LV_val_grupo_tdma THEN
			   SV_esn:=SV_num_serie;
			   SV_imsi:=SV_num_serie;
			END IF;
		END IF;


EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('OTHERS : GA_CONS_DAT_TERMINAL_ABO_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_DAT_TERMINAL_ABO_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
				V_des_error :=SUBSTR('OTHERS : GA_CONS_DAT_TERMINAL_ABO_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
		        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_CONS_DAT_TERMINAL_ABO_PR', sSql, SQLCODE, V_des_error );
END GA_CONS_DAT_TERMINAL_ABO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GE_VAL_ACTIVA_PREPAGO_FN (
   EN_num_celular     IN   	     ga_abocel.num_celular%TYPE,
   EV_cod_region      IN         ge_direcciones.cod_region%TYPE,
   EV_cod_provincia   IN         ge_direcciones.cod_provincia%TYPE,
   EV_cod_ciudad      IN         ge_direcciones.cod_ciudad%TYPE,
   EV_cod_comuna      IN         ge_direcciones.cod_comuna%TYPE,
   EV_cod_tipident    IN         ge_clientes.cod_tipident%TYPE,
   EV_num_ident       IN  OUT    ge_clientes.num_ident%TYPE,
   SN_num_abonado     OUT NOCOPY ga_abocel.num_abonado%TYPE,
   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GE_VAL_ACTIVA_PREPAGO_FN"
      Lenguaje="PL/SQL"
      Fecha="04-07-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Modularizacion de validaciones para servicio Activacion de Prepago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"       Tipo="NUMERICO">Numero del abonado</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
        error_ejecucion       EXCEPTION ;
        V_des_error           ge_errores_pg.DesEvent;
   		sSql                  ge_errores_pg.vQuery;
   		sSql2                 ge_errores_pg.vQuery;
		LN_num_transaccion 	  ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno        ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		  ga_transacabo.des_cadena%TYPE;
		LV_ejec_rest	      VARCHAR2(500);
		LV_ret_valida		  VARCHAR2(200);
		LV_ejecuta			  ged_parametros.val_parametro%TYPE;
        SV_num_identOK        ge_clientes.num_ident%TYPE;     

BEGIN

        SN_cod_retorno := '0';
        SN_num_evento  := 0;
		LV_ret_valida:=NULL;
		LV_ejec_rest:=NULL;

        -- 1.- Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||');',1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--1.1.- Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'')',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;


/* Inicio - 29-06-2005 - Agregar restricción sólo para prepago... */
	    --1.3.- Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''DESBLOQUEO'','||LV_ejec_rest||');',1,CN_largoquery);
        sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'DESBLOQUEO',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '298';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;
 /* Fin - 29-06-2005 */

		--2.- Validar datos de la direccion....
		--2.1.- Validar region...
		IF EV_cod_region IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_region_fn('||EV_cod_region||')';
		   IF NOT ge_validaciones_pg.ge_valida_region_fn(EV_cod_region,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '304';
           RAISE  error_ejecucion;
		END IF;

		--2.2.- Validar provincia...
		IF EV_cod_provincia IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_provincia_fn('||EV_cod_provincia||')';
		   IF NOT ge_validaciones_pg.ge_valida_provincia_fn(EV_cod_provincia,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '305';
           RAISE  error_ejecucion;
        END IF;

		--2.3.- Validar comuna...
		IF EV_cod_comuna IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_comuna_fn('||EV_cod_comuna||')';
	       IF NOT ge_validaciones_pg.ge_valida_comuna_fn(EV_cod_comuna,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
	       END IF;
		ELSE
	       SN_cod_retorno := '307';
           RAISE  error_ejecucion;
		END IF;

		--2.4.- Validar cuidad...
		IF EV_cod_ciudad IS NOT NULL THEN
		   sSql:='ge_validaciones_pg.ge_valida_ciudad_fn('||EV_cod_ciudad||')';
		   IF NOT ge_validaciones_pg.ge_valida_ciudad_fn(EV_cod_ciudad,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
              RAISE  error_ejecucion;
		   END IF;
		ELSE
	       SN_cod_retorno := '320';
           RAISE  error_ejecucion;
		END IF;

        --2.5.- Validar si region-provincia-cuidad-comuna existe!!!
		sSql:='ge_validaciones_pg.ge_valida_regprovciucom_fn('||EV_cod_region||','||EV_cod_provincia||','||EV_cod_ciudad||','||EV_cod_comuna||');';
		IF NOT ge_validaciones_pg.ge_valida_regprovciucom_fn(EV_cod_region,EV_cod_provincia,EV_cod_ciudad,EV_cod_comuna,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           RAISE  error_ejecucion;
		END IF;

		--3.- Validar que tipo de identificacion es valido....
		VE_INTERMEDIARIO_PG.VE_ValidarIdentificador_PR
                                            (CV_MODULO_GE,
                                             1,
                                             EV_num_ident, 
                                             EV_cod_tipident,
                                             SV_num_identOK,  
                                             SN_cod_retorno,
                                             SV_mens_retorno,
                                             SN_num_evento );
       
       IF SN_cod_retorno <> 0 THEN 
          SN_cod_retorno:= '324';
          RAISE ERROR_EJECUCION; 
       ELSE 
          EV_num_ident:= SV_num_identOK;
       END IF;
        
        
        --sSql:='VE_VALIDACION_PG.VE_VALIDARUC_FN('''||EV_num_ident||''','''||EV_cod_tipident||''')';
		--LV_ret_valida:=VE_VALIDACION_PG.VE_VALIDARUC_FN(EV_num_ident,EV_cod_tipident);
		--IF TRIM(LV_ret_valida)<>TRIM(EV_num_ident) THEN
	    --   SN_cod_retorno:= '324';
        --   RAISE  error_ejecucion;
		--END IF;

 		--4.- Validar que numero de celular prepago requiere personalizacion y desbloqueo..
		sSql:='ge_validaciones_pg.ge_valida_desbloqueo_fn('||EN_num_celular||');';
		IF NOT ge_validaciones_pg.ge_valida_desbloqueo_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           SN_cod_retorno := '317';
           --RAISE  error_ejecucion;
        END IF;

   		RETURN  TRUE;


EXCEPTION
WHEN  error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion:  GE_VAL_ACTIVA_PREPAGO_FN('||EN_num_celular||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GE_VAL_ACTIVA_PREPAGO_FN', sSql, SQLCODE, V_des_error );
      			RETURN  FALSE;
WHEN  OTHERS   THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others:  GE_VAL_ACTIVA_PREPAGO_FN('||EN_num_celular||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GE_VAL_ACTIVA_PREPAGO_FN', sSql, SQLCODE, V_des_error );
      			RETURN  FALSE;
END  GE_VAL_ACTIVA_PREPAGO_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_PREPAGO_PR (EN_num_celular     IN       ga_abocel.num_celular%TYPE,
                                 EV_cod_provincia  IN       ge_direcciones.cod_provincia%TYPE,
 		  						 EV_cod_region     IN       ge_direcciones.cod_region%TYPE,
                                 EV_cod_ciudad     IN       ge_direcciones.cod_ciudad%TYPE,
                                 EV_cod_comuna     IN       ge_direcciones.cod_comuna%TYPE,
                                 EV_nom_calle      IN       ge_direcciones.nom_calle%TYPE,
                                 EV_num_calle      IN       ge_direcciones.num_calle%TYPE,
                                 EV_num_piso       IN       ge_direcciones.num_piso%TYPE,
                                 EV_num_casilla    IN       ge_direcciones.num_casilla%TYPE,
                                 EV_obs_direccion  IN       ge_direcciones.obs_direccion%TYPE,
                                 EV_des_direc1     IN       ge_direcciones.des_direc1%TYPE,
                                 EV_des_direc2     IN       ge_direcciones.des_direc2%TYPE,
                                 EV_cod_pueblo     IN       ge_direcciones.cod_pueblo%TYPE,
                                 EV_cod_estado     IN       ge_direcciones.cod_estado%TYPE,
 								 EV_cod_tipident   IN       ge_clientes.cod_tipident%TYPE,
								 EV_num_ident      IN OUT   ge_clientes.num_ident%TYPE,
								 EV_nom_cliente    IN       ge_clientes.nom_cliente%TYPE,
								 EV_nom_apeclien1  IN       ge_clientes.nom_apeclien1%TYPE,
								 EV_nom_apeclien2  IN       ge_clientes.nom_apeclien2%TYPE,
								 SC_numos		   OUT NOCOPY   REFCURSOR,
								 SN_cod_retorno    OUT NOCOPY   ge_errores_pg.CodError,
                              	 SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
                              	 SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ACTIVA_PREPAGO_PR"
      Lenguaje="PL/SQL"
      Fecha="26-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> XXX</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"    Tipo="NUMERICO">Numero de Celular</param>
            <param nom="EV_cod_provincia"  Tipo="CARACTER">Codigo de Provincia</param>
            <param nom="EV_cod_region"     Tipo="CARACTER">Codigo de Region</param>
            <param nom="EV_cod_cuidad"     Tipo="CARACTER">Codigo de Cuidad</param>
            <param nom="EV_cod_comuna"     Tipo="CARACTER">Codigo de Comuna</param>
            <param nom="EV_nom_calle"      Tipo="CARACTER">Nombre de la Calle</param>
            <param nom="EV_num_calle"      Tipo="CARACTER">Piso y departamento</param>
            <param nom="EV_num_piso"       Tipo="CARACTER">Numero del Piso</param>
            <param nom="EV_num_casilla"    Tipo="CARACTER">Numero de la casilla</param>
            <param nom="EV_obs_direccion"  Tipo="CARACTER">Otros indicadores</param>
            <param nom="EV_des_direc1"     Tipo="CARACTER">Descripcion direccion 1</param>
            <param nom="EV_des_direc2"     Tipo="CARACTER">Descripcion direccion 2</param>
            <param nom="EV_cod_pueblo"     Tipo="CARACTER">Codigo de pueblo</param>
			<param nom="EV_cod_estado"     Tipo="CARACTER">Codigo de estado</param>
            <param nom="EV_cod_tipident"   Tipo="CARACTER">Código de identIFicación</param>
            <param nom="EV_num_ident"      Tipo="CARACTER">Número de identIFicación</param>
            <param nom="EV_nom_cliente"    Tipo="CARACTER">Nombre de Cliente</param>
            <param nom="EV_nom_apeclien1"  Tipo="CARACTER">Primer apellido</param>
            <param nom="EV_nom_apeclien2"  Tipo="CARACTER">Segundo apellido</param>
         </Entrada>
         <Salida>
            <param nom="SC_numos"          Tipo="CURSOR">Cursor con Ordenes de servicio generada</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        sSql2               ge_errores_pg.vQuery;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_ant_cod_cliente  ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
        SV_num_min          ga_abocel.num_min%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_cod_actabo       ga_actabo.COD_ACTABO%TYPE;
		SV_cod_clientedist  ga_aboamist.COD_CLIENTE_DIST%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		SN_ant_cod_cuenta   ga_abocel.cod_cuenta%TYPE;
		SV_cod_catribut     ga_cuentas.cod_catribut%TYPE;
		SV_tip_cuenta       ga_cuentas.tip_cuenta%TYPE;
		EN_cod_usuario	    NUMBER;
		VP_NUMTRANSABABO    VARCHAR2(50);
		LV_ciclo_amistar    ged_parametros.val_parametro%TYPE;
		LV_causa_desbloqueo ged_parametros.val_parametro%TYPE;
		SN_cod_subcuenta    ga_subcuentas.cod_subcuenta%TYPE;
		SN_cod_categoria	ge_clientes.cod_categoria%TYPE;
		LV_cod_tipident		ge_clientes.cod_tipident%TYPE;
		LV_num_ident		ge_clientes.num_ident%TYPE;
		LV_des_tipident		ge_tipident.des_tipident%TYPE;
		VP_SQLCODE			VARCHAR2(100);
		LV_ejecuta			ged_parametros.val_parametro%TYPE;
		LN_val_estado		NUMBER(1);
		LN_numos			ci_orserv.num_os%TYPE;
		LT_numos		    TA_numos;
		LN_i				NUMBER(1);
		LN_j				NUMBER(1);
		LV_cod_cliente      ged_parametros.val_parametro%TYPE;
		SW_actualiza_datos  NUMBER(1);
		-- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
		SV_CargaTributaria ged_parametros.val_parametro%TYPE;
		-- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760


    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;
		SW_actualiza_datos := 0;
		SN_num_abonado:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
		SN_cod_ciclo:=NULL;
		SV_num_serie:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_ant_cod_cuenta:=NULL;
		SV_cod_actabo:=NULL;
		SV_tecnologia:=NULL;
		SN_cod_cliente:=NULL;
		SN_ant_cod_cliente:=NULL;
		SV_cod_catribut:=NULL;
		SV_tip_cuenta:=NULL;
 		EN_cod_usuario:=NULL;
		LV_ciclo_amistar:=NULL;
		SN_cod_categoria:=NULL;
		LV_cod_tipident:=NULL;
		LV_num_ident:=NULL;
		LV_des_tipident:=NULL;
		LV_ejecuta:=NULL;
		LN_i:=1;

        sSql:='SELECT NULL AS num_os FROM DUAL ';
        OPEN SC_numos FOR sSql;

		--Obtener ciclo de prepago....
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_CICLO_AMI||','||CV_cod_modulo||','||CV_cod_producto_post||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_CICLO_AMI,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_ciclo_amistar,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

		--2.- Validaciones activacion de prepago..
        sSql:=SUBSTR('GE_VAL_ACTIVA_PREPAGO_FN('||EN_num_celular||','||EV_cod_region||','||EV_cod_provincia||','||
					  EV_cod_ciudad||','||EV_cod_comuna||','||EV_cod_tipident||','||EV_num_ident||','||SN_num_abonado||');',1,CN_largoquery);
		IF NOT GE_VAL_ACTIVA_PREPAGO_FN(EN_num_celular,EV_cod_region,EV_cod_provincia,EV_cod_ciudad,
		       EV_cod_comuna,EV_cod_tipident,EV_num_ident,SN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
			 RAISE  error_ejecucion;
		ELSE
		     IF SN_cod_retorno = '317' THEN
			    SW_actualiza_datos := 1;
			    SN_cod_retorno := 0;
			 END IF;
		END IF;

		-- 2.1.- Ejecutar procedimiento que obtiene datos del abonado
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||');-',1,CN_largoquery);
 	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_ant_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_ant_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		IF SN_cod_retorno<>0 THEN
   	      RAISE  error_ejecucion;
		END IF;
		IF SN_ant_cod_cliente IS NULL THEN
          SN_cod_retorno := '146';
   	      RAISE  error_ejecucion;
		END IF;

		--Obtener Cliente prepago desde ged_parametros....
		LV_cod_cliente:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_cliente||','||CV_cod_modulo||','||CV_cod_producto_post||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_cliente,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_cod_cliente,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

        sSql:='SN_cod_cliente:=TO_NUMBER(TRIM('||LV_cod_cliente||'))';
		SN_cod_cliente:=TO_NUMBER(TRIM(LV_cod_cliente));

		--obtener causa de desbloqueo....
        LV_causa_desbloqueo:=NULL;
		sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_causa_desbloqueo ||','||CV_cod_modulo||','||CV_cod_producto_post||'); - ',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_causa_desbloqueo ,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_causa_desbloqueo ,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno := '302';
			 RAISE  error_ejecucion;
		END IF;

		--Obtener parametro para ver si debe o no ejecutar validacion de estado de nota de pedido.....
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_valida_np||','||CV_cod_modulo||','||CV_cod_producto_post||'); - ',1,CN_largoquery);
		IF ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_valida_np,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_ejecuta,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		   IF LV_ejecuta = CV_si_ejecuta THEN
		      --Validar estado de las notas de pedidos en el dealer...
		      LN_val_estado:=ca_fn_valida_estado_pedido(SV_num_serie);
		      IF LN_val_estado=0 THEN
	       	     SN_cod_retorno := '315';
           		 RAISE  error_ejecucion;
		      END IF;
		  END IF;
		END IF;

		-- Inicio modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012
		-- Validacion de que el celular no se encuentre activo en SCL
		sSql := SUBSTR('ge_validaciones_pg.ge_valida_situacion_celular_fn('||EN_num_celular||')',1,CN_largoquery);
		IF ge_validaciones_pg.ge_valida_situacion_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
		   RAISE error_ejecucion;
		END IF;
		-- Fin modificacion by SAQL/Soporte 11/11/2005 - RA-200511010012

		--Validar en icc_movimiento si celular posee algun movimiento pendiente...
	    sSql:=SUBSTR('ge_validaciones_pg.ge_valida_icc_pend_celular_fn('||EN_num_celular||')',1,CN_largoquery);
	-- Inicio PBARRIA XO-200510110850 15-10-2005
        --IF ge_validaciones_pg.ge_valida_icc_pend_celular_fn(SN_cod_cliente,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
        IF ge_validaciones_pg.ge_valida_icc_pend_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
        -- Fin PBARRIA XO-200510110850 15-10-2005
    	   RAISE  error_ejecucion;
	    END IF;

		--	Validar que exista cliente en ge_clientes....
	    sSql:=SUBSTR('ge_validaciones_pg.ge_valida_existe_cliente_fn('||SN_cod_cliente||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');-',1,CN_largoquery);

          --XO-200509290760: German Espinoza Z; 01/10/2005
          --cambios no comentados de desarrollo
	  IF TRUE THEN
--        IF 	NOT ge_validaciones_pg.ge_valida_existe_cliente_fn(SN_cod_cliente,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) OR LV_cod_cliente IS NULL THEN
          --FIN/XO-200509290760: German Espinoza Z; 01/10/2005

   	       --Crear estructura completa de cliente prepago..
   	       -- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
   	       SELECT VAL_PARAMETRO INTO SV_CargaTributaria
   	       FROM GED_PARAMETROS
   	       WHERE NOM_PARAMETRO = 'CAT_TRIB_DEFAULT'
   	       AND COD_MODULO = 'GA'
   	       AND COD_PRODUCTO = 1;
   	       -- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760

  	       sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_CREA_ESTRUCTURA_ABONADO_PR('||SN_num_abonado||','||EV_cod_provincia||','||EV_cod_region||
		          ','||EV_cod_ciudad||','||EV_cod_comuna||','||EV_nom_calle||','||EV_num_calle||
				  ','||EV_num_piso||','||EV_num_casilla||','||EV_obs_direccion||','||EV_des_direc1||','||EV_des_direc2||
				  ','||EV_cod_pueblo||','||EV_cod_estado||','||EV_cod_tipident||','||EV_num_ident||','||EV_nom_cliente||
				  -- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
				  --','||EV_nom_apeclien1||','||EV_nom_apeclien2||','||CV_tip_cuenta||','||LV_ciclo_amistar||','||CV_cod_catribut||','||SN_ant_cod_cliente||');',1,CN_largoquery);
				  ','||EV_nom_apeclien1||','||EV_nom_apeclien2||','||CV_tip_cuenta||','||LV_ciclo_amistar||','||SV_CargaTributaria||','||SN_ant_cod_cliente||');',1,CN_largoquery);
				  -- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760

 	   GA_ESTRUCTURA_PG.GA_CREA_ESTRUCTURA_ABONADO_PR
					            (SN_num_abonado,
                                 EV_cod_provincia,
 		  						 EV_cod_region,
                                 EV_cod_ciudad,
                                 EV_cod_comuna,
                                 EV_nom_calle,
                                 EV_num_calle,
                                 EV_num_piso,
                                 EV_num_casilla,
                                 EV_obs_direccion,
                                 EV_des_direc1,
                                 EV_des_direc2,
                                 EV_cod_pueblo,
                                 EV_cod_estado,
 								 EV_cod_tipident,
								 EV_num_ident,
								 EV_nom_cliente,
								 EV_nom_apeclien1,
								 EV_nom_apeclien2,
								 SN_cod_categoria,
								 CV_tip_cuenta,
								 LV_ciclo_amistar,
								 -- Inicio modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760
								 -- CV_cod_catribut,
								 SV_CargaTributaria,
								 -- Fin modificacion by SAQL/Soporte 29/09/2005 - XO-200509290760

								 SN_ant_cod_cliente,
                                 SN_cod_retorno,
                                 SV_mens_retorno,
                                 SN_num_evento);

			IF SN_cod_retorno<>0 THEN
               SN_cod_retorno := '302';
 		       RAISE error_ejecucion;
			END IF;

		ELSE
          	SN_cod_cuenta:=NULL;
    		-- Obtener la cuenta del cliente prepago al que se asociará el prepago ....
    		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR('||SN_cod_cliente||');',1,CN_largoquery);
    		GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR(SN_cod_cliente,SN_cod_cuenta,SN_cod_categoria,
    			   LV_cod_tipident,LV_num_ident,LV_des_tipident,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    		IF SN_cod_retorno<>0 THEN
                 SN_cod_retorno := '302';
       	         RAISE  error_ejecucion;
    		END IF;
    		IF LV_num_ident IS NULL OR SN_cod_cuenta IS NULL  THEN
    		     sSql:=SUBSTR(sSql||'- Cliente o Cuenta de nuevo cliente No existe.',1,CN_largoquery);
                 SN_cod_retorno := '302';
       	         RAISE  error_ejecucion;
    		END IF;

       		-- Ejecutar procedimiento que obtiene datos de la cuenta del cliente al que se asociará el prepago...
       		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_CUENTA_PR('||SN_cod_cuenta||','||SV_cod_catribut||','
       		      ||SV_tip_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');',1,CN_largoquery);
        	GA_CONSULTAS_PG.GA_CONSULTA_CUENTA_PR(SN_cod_cuenta, SV_cod_catribut,
       		     SV_tip_cuenta, SN_cod_retorno,SV_mens_retorno, SN_num_evento);
       		IF SN_cod_retorno<>0 THEN
        	   RAISE  error_ejecucion;
       		END IF;
       	    IF SV_tip_cuenta IS NULL THEN
       		   sSql:=SUBSTR(sSql||'- Cuenta del cliente al que se asociará No existe.',1,CN_largoquery);
               SN_cod_retorno := '302';
        	   RAISE  error_ejecucion;
       		END IF;

    		--Validar si existe usuario para abonado....
    		EN_cod_usuario:=NULL;
    		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_existe_usuamist_fn('||SN_num_abonado||')',1,CN_largoquery);
    		IF  NOT ge_validaciones_pg.ge_valida_existe_usuamist_fn(SN_num_abonado,EN_cod_usuario,SN_cod_retorno,
    		    SV_mens_retorno,SN_num_evento) THEN
    		      -- Crear un usuario ..
    	          sSql:='SELECT GA_SEQ_USUARIOS.NEXTVAL INTO EN_cod_usuario FROM DUAL';
    	          SELECT GA_SEQ_USUARIOS.NEXTVAL INTO EN_cod_usuario FROM DUAL;

                  sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_CREA_USUAMIST_PR('||EN_cod_usuario||','||SN_num_abonado||
    		          ','||EV_COD_TIPIDENT||','||EV_NUM_IDENT||','||EV_NOM_CLIENTE||','||EV_NOM_APECLIEN1||
    				  ','||EV_NOM_APECLIEN2||','||CV_ind_estado||');',1,CN_largoquery);

			      GA_ESTRUCTURA_PG.GA_CREA_USUAMIST_PR(EN_cod_usuario,
                		     SN_num_abonado,
                		     EV_cod_tipident,
                		     EV_num_ident,
                		     EV_nom_cliente,
                		     EV_nom_apeclien1,
                		     EV_nom_apeclien2,
                		     CV_ind_estado,
                		     SN_cod_retorno,
                		     SV_mens_retorno,
                		     SN_num_evento);

    		END IF;

           	IF SN_cod_retorno<>0 OR EN_cod_usuario IS NULL THEN
           	   SN_cod_retorno:= '302';
           	   RAISE error_ejecucion;
           	END IF;

    		--Modifica usuario existente...
            sSql:=SUBSTR('GA_ESTRUCTURA_PG.GA_MOD_USUAMIST_PR('||EN_cod_usuario||','||
    		          ','||EV_COD_TIPIDENT||','||EV_NUM_IDENT||','||EV_NOM_CLIENTE||','||EV_NOM_APECLIEN1||
    				  ','||EV_NOM_APECLIEN2||','||CV_ind_estado||');',1,CN_largoquery);

    		GA_ESTRUCTURA_PG.GA_MOD_USUAMIST_PR(EN_cod_usuario,
                		     EV_cod_tipident,
                		     EV_num_ident,
                		     EV_nom_cliente,
                		     EV_nom_apeclien1,
                		     EV_nom_apeclien2,
                		     CV_ind_estado,
                		     SN_cod_retorno,
                		     SV_mens_retorno,
            		         SN_num_evento);

           	IF SN_cod_retorno<>0 THEN
           	   SN_cod_retorno:= '302';
           	   RAISE error_ejecucion;
           	END IF;


			IF SW_actualiza_datos = 0 then
		      	sSql:=SUBSTR('GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR('||SN_cod_cliente||','||SN_ant_cod_cliente||','||SN_num_abonado||','||EN_cod_usuario||','||SN_cod_cuenta||');',1,CN_largoquery);
		    	GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR(
		    		   	  SN_cod_cliente,
		    			  SN_ant_cod_cliente,
		    		      SN_num_abonado,
		    			  EN_cod_usuario,
		    			  SN_cod_cuenta,
		    			  SN_cod_retorno,
		                  SV_mens_retorno,
		                  SN_num_evento);

		    	IF SN_cod_retorno<>0 THEN
		           SN_cod_retorno := '302';
		    	   RAISE error_ejecucion;
		    	END IF;
			END IF;
	END IF;

		-- 6.- Desbloquear celular en centrales ....

		-- XO-200505190402 Christian Estay M 22-08-2005
		-- Obtener codigo de cod_actabo de Desbloque desde la ged_parametro
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_actabo_np||','||CV_cod_modulo||','||CV_cod_producto_post||'); - ',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_actabo_np,CV_cod_modulo,
		   	   				  CV_cod_producto_post,SV_cod_actabo,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN

           SN_cod_retorno:= '302';
		   RAISE error_ejecucion;

		END IF;

		VP_NUMTRANSABABO:=NULL;
		VP_SQLCODE:=NULL;
		sSql:=SUBSTR('PV_PRC_BLODESQUEO_PR('||SN_num_abonado||','||SV_cod_actabo||',NULL,'||USER||',0,'||LV_causa_desbloqueo||');',1,CN_largoquery);

        PV_PRC_BLODESQUEO_PR(SN_num_abonado,
	       SV_cod_actabo,
	       NULL,
	       USER,
	       0,
	       LV_causa_desbloqueo, --causa de desbloqueo....
	       SN_cod_retorno,--VP_RESULTADO,
	       VP_SQLCODE,--VP_SQLCODE,
	       SV_mens_retorno,--VP_SQLERRM,
	       VP_NUMTRANSABABO);

		IF SN_cod_retorno<>1 THEN
           SN_cod_retorno:= '302';
		   SN_num_evento:=0;
		   RAISE error_ejecucion;

		END IF;
        SN_cod_retorno:=0;
	    SV_mens_retorno:=NULL;

		--7.- Inscribir ordenes de servicio....
		--7.1. Desbloqueo de registro...
		LN_numos:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_registra_ooss_fn('||CV_cod_os_10003||','||CV_cod_producto_post||','||CV_tip_inter||','||SN_num_abonado||','||USER||','||CV_comentario_10003||','||CV_num_cargo||',NULL,NULL,NULL,NULL,'||LN_numos||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_registra_ooss_fn(CV_cod_os_10003,CV_cod_producto_post,CV_tip_inter,SN_num_abonado,USER,CV_comentario_10003,CV_num_cargo,NULL,NULL,NULL,NULL,LN_numos,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno := '302';
 	   	   RAISE error_ejecucion;
 	    END IF;
		LT_numos(LN_i):=LN_numos;
		LN_i:=LN_i+1;

		--7.2. Modificación datos generales...
		LN_numos:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_registra_ooss_fn('||CV_cod_os_10009||','||CV_cod_producto_post||','||CV_tip_inter||','||SN_num_abonado||','||USER||','||CV_comentario_10009||','||CV_num_cargo||',NULL,NULL,NULL,NULL,'||LN_numos||');',1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_registra_ooss_fn(CV_cod_os_10009,CV_cod_producto_post,CV_tip_inter,SN_num_abonado,USER,CV_comentario_10009,CV_num_cargo,NULL,NULL,NULL,NULL,LN_numos,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno := '302';
 	   	   RAISE error_ejecucion;
 	    END IF;
		LT_numos(LN_i):=LN_numos;
		LN_i:=LN_i+1;

	    sSql:=NULL;
	    IF LN_i > 1 THEN
	  	  FOR LN_j IN 1..LN_i-1 LOOP
	        sSql:=sSql||'SELECT '||LT_numos(LN_j)||' AS num_os FROM DUAL ';
			IF LN_j < LN_i-1  THEN
			 	sSql:=sSql||' UNION ';
	       END IF;
          END LOOP;
		  IF sSql IS NOT NULL THEN
		     OPEN SC_numos FOR sSql;
		  END IF;
 	    END IF;

EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion:  GA_ACTIVA_PREPAGO_PR('||EN_num_celular||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_ACTIVA_PREPAGO_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('others:  GA_ACTIVA_PREPAGO_PR('||EN_num_celular||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_ACTIVA_PREPAGO_PR', sSql, SQLCODE, V_des_error );
END GA_ACTIVA_PREPAGO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GA_MOD_GE_CLIENTES_FN (
   EN_cod_cliente   IN           ge_clientes.cod_cliente%TYPE,
   EN_num_abocel    IN           NUMBER,
   SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_MOD_GE_CLIENTES_FN"
      Lenguaje="PL/SQL"
      Fecha="04-07-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Modifica la cantidad de abonados asociados a un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abocel"     Tipo="NUMERICO">Cantidad a sumar o restar </param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   N_codretorno             ge_errores_td.cod_msgerror%TYPE;
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   V_val_parametro          ged_parametros.val_parametro%TYPE;
   sCantidadDealer          NUMBER; -- Modificacion by SAQL/Soporte 20/10/2005 - XO-200510130874

BEGIN
       SN_cod_retorno:= '0';
       SN_num_evento:= 0;

       --Actualizar num_abocel de  cliente....
       sSql:='UPDATE GE_CLIENTES cliente '||
	   		 ' SET cliente.NUM_ABOCEL=NVL(cliente.NUM_ABOCEL,0) +  '||EN_num_abocel||
	   		 ' WHERE cliente.cod_cliente='||EN_cod_cliente;
	   -- Inicio modificacion by SAQL/Soporte 20/10/2005 - XO-200510130874
	   SELECT COUNT(1) INTO sCantidadDealer
	   FROM VE_VENDEDORES
	   WHERE COD_CLIENTE = EN_cod_cliente;
	   IF sCantidadDealer = 0 THEN
	      UPDATE GE_CLIENTES cliente
	      SET cliente.NUM_ABOCEL=NVL(cliente.NUM_ABOCEL,0) + EN_num_abocel
	      WHERE cliente.cod_cliente=EN_cod_cliente;
	   END IF;

       RETURN  TRUE;

EXCEPTION
WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('others  : GA_MOD_GE_CLIENTES_FN('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_MOD_GE_CLIENTES_FN', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  GA_MOD_GE_CLIENTES_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_ASOCIA_CLI_PR (EN_cod_cliente     IN          ge_clientes.cod_cliente%TYPE,
		  				    EN_ant_cod_cliente IN          ge_clientes.cod_cliente%TYPE,
							EN_num_abonado     IN          ga_abocel.num_abonado%TYPE,
							EN_cod_usuario     IN 	       ga_abocel.cod_usuario%TYPE,
							EN_cod_cuenta      IN          ge_clientes.cod_cuenta%TYPE,
							SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                            SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                            SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
                            )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ASOCIA_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Actualiza un abonado prepago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo del cliente al que se asocia</param>
            <param nom="EN_ant_cod_cliente"  Tipo="NUMERICO">Codigo del antiguo cliente que lo poseia</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EN_cod_usuario"     Tipo="NUMERICO">Codigo del usuario</param>
            <param nom="EN_cod_cuenta"     Tipo="NUMERICO">Codigo de la cuenta</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;

    BEGIN
	    --Inicializacion de variables de salida...
	    sSql:=NULL;
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

	    sSql:='UPDATE ga_aboamist  prepago '||
		      ' SET prepago.cod_cliente='||EN_cod_cliente||
			  '    ,prepago.cod_usuario='||EN_cod_usuario||
			  '    ,prepago.cod_cuenta='||EN_cod_cuenta||
			  '	   ,prepago.fec_ultmod=SYSDATE'||
			  '    ,prepago.ind_telefono=6'||
			  '    ,prepago.fec_acepventa=NVL(prepago.fec_acepventa,SYSDATE)'||
		      ' WHERE prepago.num_abonado='||EN_num_abonado;

  	    UPDATE GA_ABOAMIST  prepago
		     SET prepago.cod_cliente = EN_cod_cliente,
			     prepago.cod_usuario=EN_cod_usuario,
			 	 prepago.cod_cuenta = EN_cod_cuenta,
				 prepago.fec_ultmod = SYSDATE,
				 prepago.ind_telefono = 6,
				 prepago.fec_acepventa=NVL(prepago.fec_acepventa,SYSDATE)
		   WHERE prepago.num_abonado = EN_num_abonado;

	   --Actualizar num_abocel de nuevo cliente...
        sSql:=SUBSTR('GA_MOD_GE_CLIENTES_FN('||EN_cod_cliente||',1); - num_abocel de nuevo cliente.',1,CN_largoquery);
		IF NOT GA_MOD_GE_CLIENTES_FN(EN_cod_cliente,1,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno := '302';
 	   	   RAISE error_ejecucion;
 	    END IF;

	   --Actualizar num_abocel de antiguo cliente...
        sSql:=SUBSTR('GA_MOD_GE_CLIENTES_FN('||EN_ant_cod_cliente||',-1); - num_abocel de antiguo cliente.',1,CN_largoquery);
		IF NOT GA_MOD_GE_CLIENTES_FN(EN_ant_cod_cliente,-1,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           SN_cod_retorno := '302';
 	   	   RAISE error_ejecucion;
 	    END IF;

EXCEPTION
WHEN error_ejecucion  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
  	            V_des_error :=SUBSTR('error_ejecucion: GA_ASOCIA_CLI_PR('||EN_cod_cliente||','||EN_ant_cod_cliente||','||EN_num_abonado||','||EN_cod_usuario||','||EN_cod_cuenta||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;

WHEN OTHERS   THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
  	            V_des_error :=SUBSTR('OTHERS: GA_ASOCIA_CLI_PR('||EN_cod_cliente||','||EN_ant_cod_cliente||','||EN_num_abonado||','||EN_cod_usuario||','||EN_cod_cuenta||');-'||SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ABONADOS_PG.GA_ASOCIA_CLI_PR', sSql, SQLCODE, V_des_error );
				ROLLBACK;
END GA_ASOCIA_CLI_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END GA_SERVICIOS_ABONADOS_PG;
/
SHOW ERRORS