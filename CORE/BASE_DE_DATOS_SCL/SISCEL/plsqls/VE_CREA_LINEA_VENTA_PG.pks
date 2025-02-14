CREATE OR REPLACE PACKAGE VE_crea_linea_venta_PG IS

/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "VE_crea_linea_venta_PG
          Lenguaje="PL/SQL"
          Fecha="02-05-2007"
          Versión="1.0"
          Diseñador= "Roberto Perez"
                  Programador="Roberto Perez"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package crea linea de Ventas</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
           CV_error_no_clasif   CONSTANT VARCHAR2(30):='Error no clasificado';
           CV_codmodulo         CONSTANT VARCHAR2(2) :='GA';
           CV_tipodireccion             CONSTANT VARCHAR2(1) :='1';
           GV_sSql              ge_errores_pg.vQuery;
           CN_cero 			    CONSTANT  PLS_INTEGER:=0;
           CN_uno 				CONSTANT  PLS_INTEGER:=1;
	       CN_dos 				CONSTANT  PLS_INTEGER:=2;
	       CN_tres 	    		CONSTANT  PLS_INTEGER:=3;
	       CN_MOVSAL    		CONSTANT  PLS_INTEGER:=3;
	       CN_cuatro            CONSTANT  PLS_INTEGER:=4;
	       CN_ocho              CONSTANT  PLS_INTEGER:=8;
           ERROR_OC   			EXCEPTION;
	       ERROR_FN   			EXCEPTION;
           GN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
           GV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
           GN_num_evento       ge_errores_pg.Evento;
           GV_des_error        ge_errores_pg.DesEvent;
           PROCEDURE VE_obtiene_datos_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                  SV_codcuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                                                                  SV_codsubcuenta  OUT NOCOPY ga_subcuentas.cod_subcuenta%TYPE,
                                                                                  SV_nomusuario    OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                                                                  SV_nomapellido1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                                                                  SV_numident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                                                                  SV_codtipident   OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                                                                  SV_nomapellido2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                                                                  SV_fecnaciomien  OUT NOCOPY ge_clientes.fec_nacimien%TYPE,
                                                                                  SV_indestcivil   OUT NOCOPY ge_clientes.ind_estcivil%TYPE,
                                                                                  SV_indsexo       OUT NOCOPY ge_clientes.ind_sexo%TYPE,
                                                                                  SV_codactividad  OUT NOCOPY ge_clientes.cod_actividad%TYPE,
                                                                                  SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                                                                  SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                                                                  SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                                                                  SV_codcelda      OUT NOCOPY ge_ciudades.cod_celda%TYPE,
                                                                                  SV_codcalclien   OUT NOCOPY ge_clientes.cod_calclien%TYPE,
                                                                                  SV_indfactur     OUT NOCOPY ge_clientes.ind_factur%TYPE,
                                                                                  SV_codciclo      OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
                                                                                  SV_codoperadora  OUT NOCOPY VARCHAR2,
                                                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_obtiene_datos_vendedor_PR(EV_codvendedor    IN ve_vendedores.cod_vendedor%TYPE,
                                                                                   SV_codvende_raiz      OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                                                                   SV_codvendealer       OUT NOCOPY ve_vendealer.cod_vendealer%TYPE,
                                                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_IN_ga_usuarios_PR(EV_codusuario    IN ga_usuarios.cod_usuario%TYPE,
                                                                           EV_codcuenta         IN ga_usuarios.cod_cuenta%TYPE,
                                                                           EV_codsubcuenta      IN ga_usuarios.cod_subcuenta%TYPE,
                                                                           EV_nomusuario        IN ga_usuarios.nom_usuario%TYPE,
                                                                           EV_nomapellido1      IN ga_usuarios.nom_apellido1%TYPE,
                                                                           EV_nomapellido2      IN ga_usuarios.nom_apellido2%TYPE,
                                                                           EV_numident          IN ga_usuarios.num_ident%TYPE,
                                                                           EV_codtipident       IN ga_usuarios.cod_tipident%TYPE,
                                                                           EV_indestado         IN ga_usuarios.ind_estado%TYPE,
                                                                           EV_fecnacimien       IN VARCHAR2,
                                                                           EV_codestcivil       IN ga_usuarios.cod_estcivil%TYPE,
                                                                           EV_indsexo           IN ga_usuarios.ind_sexo%TYPE,
                                                                           EV_indtipotrab       IN ga_usuarios.ind_tipotrab%TYPE,
                                                                           EV_nomempresa        IN ga_usuarios.nom_empresa%TYPE,
                                                                           EV_codactemp         IN ga_usuarios.cod_actemp%TYPE,
                                                                           EV_codocupacion      IN ga_usuarios.cod_ocupacion%TYPE,
                                                                           EN_numpercargo       IN ga_usuarios.num_percargo%TYPE,
                                                                           EN_impbruto          IN ga_usuarios.imp_bruto%TYPE,
                                                                           EV_indprocoper       IN ga_usuarios.ind_procoper%TYPE,
                                                                           EV_codoperador       IN ga_usuarios.cod_operador%TYPE,
                                                                           EV_nomconyuge        IN ga_usuarios.nom_conyuge%TYPE,
                                                                           EV_codpinusuar       IN ga_usuarios.cod_pinusuar%TYPE,
                                                                           EV_CodEstrato    IN ga_usuarios.cod_estrato%TYPE,
                                                                           EV_EMAIL         IN ga_usuarios.email%TYPE,
                                                                           EV_NUM_TEF       IN ga_usuarios.TELEF_CONTACTO%TYPE,
                                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);


                PROCEDURE VE_OBTIENE_SECUENCIA_PR(EV_nomsecuencia IN VARCHAR2,
                                                                  SV_secuencia    OUT NOCOPY VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                                 );

                PROCEDURE VE_OBTIENE_DATOS_GENERALES_PR(
                                                   EV_codproducto          IN ga_grpserv.cod_producto%TYPE,
                                       SV_cod_calclien     OUT NOCOPY ga_datosgener.cod_calclien%TYPE,
                                                   SV_cod_abc          OUT NOCOPY ga_datosgener.cod_abc%TYPE,
                                                   SN_cod_123          OUT NOCOPY ga_datosgener.cod_123%TYPE,
                                                   SN_codestcobros         OUT NOCOPY ga_datosgener.cod_estcobros%TYPE,
                                                   SV_codgrpsrv            OUT NOCOPY ga_grpserv.cod_grupo%TYPE,
                                                   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_obtiene_subalm_PR(EV_codregion      IN ge_regiones.cod_region%TYPE,
                                                                           EV_codprovincia   IN ge_provincias.cod_provincia%TYPE,
                                                                           EV_codciudad          IN ge_ciudades.cod_ciudad%TYPE,
                                                                           SV_codsubalm          OUT NOCOPY ge_celdas.cod_subalm%TYPE,
                                                                           SV_codsubalm2         OUT NOCOPY ge_celdas.cod_subalm2%TYPE,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_obtiene_planserv_PR(EV_codproducto    IN ga_planserv.cod_producto%TYPE,
                                                                                 EV_codtecnologia  IN ga_plantecplserv.cod_tecnologia%TYPE,
                                                                                 EV_codplantarif   IN ga_plantecplserv.cod_plantarif%TYPE,
                                                                                 SV_codplanserv    OUT NOCOPY ga_planserv.cod_planserv%TYPE,
                                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_obtiene_subcuentas_PR(EN_codcuenta      IN ga_subcuentas.cod_cuenta%TYPE,
                                                   SV_codsubcuenta   OUT NOCOPY ga_subcuentas.cod_subcuenta%TYPE,
                                                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


                PROCEDURE VE_IN_ga_abocel_PR(EV_num_abonado               IN ga_abocel.num_abonado%TYPE,
                                                                         EV_num_celular                   IN ga_abocel.num_celular%TYPE,
                                                                         EV_cod_producto                  IN ga_abocel.cod_producto%TYPE,
                                                                         EV_cod_cliente                   IN ga_abocel.cod_cliente%TYPE,
                                                                         EV_cod_cuenta                    IN ga_abocel.cod_cuenta%TYPE,
                                                                         EV_cod_subcuenta             IN ga_abocel.cod_subcuenta%TYPE,
                                                                         EV_cod_usuario                   IN ga_abocel.cod_usuario%TYPE,
                                                                         EV_cod_region                    IN ga_abocel.cod_region%TYPE,
                                                                         EV_cod_provincia                 IN ga_abocel.cod_provincia%TYPE,
                                                                         EV_cod_ciudad                    IN ga_abocel.cod_ciudad%TYPE,
                                                                         EV_cod_celda                     IN ga_abocel.cod_celda%TYPE,
                                                                         EV_cod_central                   IN ga_abocel.cod_central%TYPE,
                                                                         EV_cod_uso                               IN ga_abocel.cod_uso%TYPE,
                                                                         EV_cod_situacion                 IN ga_abocel.cod_situacion%TYPE,
                                                                         EV_ind_procalta                  IN ga_abocel.ind_procalta%TYPE,
                                                                         EV_ind_procequi                  IN ga_abocel.ind_procequi%TYPE,
                                                                         EV_cod_vendedor                  IN ga_abocel.cod_vendedor%TYPE,
                                                                         EV_cod_vendedor_agente   IN ga_abocel.cod_vendedor_agente%TYPE,
                                                                         EV_tip_plantarif                 IN ga_abocel.tip_plantarif%TYPE,
                                                                         EV_tip_terminal                  IN ga_abocel.tip_terminal%TYPE,
                                                                         EV_cod_plantarif                 IN ga_abocel.cod_plantarif%TYPE,
                                                                         EV_cod_cargobasico               IN ga_abocel.cod_cargobasico%TYPE,
                                                                         EV_cod_planserv                  IN ga_abocel.cod_planserv%TYPE,
                                                                         EV_cod_limconsumo                IN ga_abocel.cod_limconsumo%TYPE,
                                                                         EV_num_serie                     IN ga_abocel.num_serie%TYPE,
                                                                         EV_num_seriehex                  IN ga_abocel.num_seriehex%TYPE,
                                                                         EV_nom_usuarora                  IN ga_abocel.nom_usuarora%TYPE,
                                                                         EV_fec_alta                      IN VARCHAR2,
                                                                         EV_num_percontrato               IN ga_abocel.num_percontrato%TYPE,
                                                                         EV_cod_estado                    IN ga_abocel.cod_estado%TYPE,
                                                                         EV_num_seriemec                  IN ga_abocel.num_seriemec%TYPE,
                                                                         EV_cod_holding                   IN ga_abocel.cod_holding%TYPE,
                                                                         EV_cod_empresa                   IN ga_abocel.cod_empresa%TYPE,
                                                                         EV_cod_grpserv                   IN ga_abocel.cod_grpserv%TYPE,
                                                                         EV_ind_supertel                  IN ga_abocel.ind_supertel%TYPE,
                                                                         EV_num_telefija                  IN ga_abocel.num_telefija%TYPE,
                                                                         EV_cod_opredfija                 IN ga_abocel.cod_opredfija%TYPE,
                                                                         EV_cod_carrier                   IN ga_abocel.cod_carrier%TYPE,
                                                                         EV_ind_prepago                   IN ga_abocel.ind_prepago%TYPE,
                                                                         EV_ind_plexsys                   IN ga_abocel.ind_plexsys%TYPE,
                                                                         EV_cod_central_plex      IN ga_abocel.cod_central_plex%TYPE,
                                                                         EV_num_celular_plex      IN ga_abocel.num_celular_plex%TYPE,
                                                                         EV_num_venta                     IN ga_abocel.num_venta%TYPE,
                                                                         EV_cod_modventa                  IN ga_abocel.cod_modventa%TYPE,
                                                                         EV_cod_tipcontrato               IN ga_abocel.cod_tipcontrato%TYPE,
                                                                         EV_num_contrato                  IN ga_abocel.num_contrato%TYPE,
                                                                         EV_num_anexo                     IN ga_abocel.num_anexo%TYPE,
                                                                         EV_fec_cumplan                   IN VARCHAR2,
                                                                         EV_cod_credmor                   IN ga_abocel.cod_credmor%TYPE,
                                                                         EV_cod_credcon                   IN ga_abocel.cod_credcon%TYPE,
                                                                         EV_cod_ciclo                     IN ga_abocel.cod_ciclo%TYPE,
                                                                         EV_ind_factur                    IN ga_abocel.ind_factur%TYPE,
                                                                         EV_ind_suspen                    IN ga_abocel.ind_suspen%TYPE,
                                                                         EV_ind_rehabi                    IN ga_abocel.ind_rehabi%TYPE,
                                                                         EV_ind_insguias                  IN ga_abocel.ind_insguias%TYPE,
                                                                         EV_fec_fincontra                 IN VARCHAR2,
                                                                         EV_fec_recdocum                  IN VARCHAR2,
                                                                         EV_fec_cumplimen                 IN VARCHAR2,
                                                                         EV_fec_acepventa                 IN VARCHAR2,
                                                                         EV_fec_actcen                    IN VARCHAR2,
                                                                         EV_fec_baja                      IN VARCHAR2,
                                                                         EV_fec_bajacen                   IN VARCHAR2,
                                                                         EV_fec_ultmod                    IN VARCHAR2,
                                                                         EV_cod_causabaja                 IN ga_abocel.cod_causabaja%TYPE,
                                                                         EV_num_personal                  IN ga_abocel.num_personal%TYPE,
                                                                         EV_ind_seguro                    IN ga_abocel.ind_seguro%TYPE,
                                                                         EV_clase_servicio                IN ga_abocel.clase_servicio%TYPE,
                                                                         EV_perfil_abonado                IN ga_abocel.perfil_abonado%TYPE,
                                                                         EV_num_min                               IN ga_abocel.num_min%TYPE,
                                                                         EV_cod_vendealer                 IN ga_abocel.cod_vendealer%TYPE,
                                                                         EV_ind_disp                      IN ga_abocel.ind_disp%TYPE,
                                                                         EV_cod_password                  IN ga_abocel.cod_password%TYPE,
                                                                         EV_ind_password                  IN ga_abocel.ind_password%TYPE,
                                                                         EV_cod_afinidad                  IN ga_abocel.cod_afinidad%TYPE,
                                                                         EV_fec_prorroga                  IN VARCHAR2,
                                                                         EV_ind_eqprestado                IN ga_abocel.ind_eqprestado%TYPE,
                                                                         EV_flg_contdigi                  IN ga_abocel.flg_contdigi%TYPE,
                                                                         EV_fec_altantras                 IN VARCHAR2,
                                                                         EV_cod_indemnizacion             IN ga_abocel.cod_indemnizacion%TYPE,
                                                                         EV_num_imei                      IN ga_abocel.num_imei%TYPE,
                                                                         EV_cod_tecnologia                IN ga_abocel.cod_tecnologia%TYPE,
                                                                         EV_num_min_mdn                   IN ga_abocel.num_min_mdn%TYPE,
                                                                         EV_fec_activacion                IN VARCHAR2,
                                                                         EV_ind_telefono                  IN ga_abocel.ind_telefono%TYPE,
                                                                         EV_cod_oficina_principal         IN ga_abocel.cod_oficina_principal%TYPE,
                                                                         EV_cod_causa_venta               IN ga_abocel.cod_causa_venta%TYPE,
                                                                         EV_cod_operacion                 IN ga_abocel.cod_operacion%TYPE,
                                                                         EV_cod_prestacion                IN ga_abocel.COD_PRESTACION%TYPE,
                                                                         EV_MTO_VALOR_REF                 IN GA_ABOCEL.MTO_VALOR_REFERENCIA%TYPE,
                                                                         EV_COD_MONEDA                    IN GA_ABOCEL.COD_MONEDA%TYPE,
                                                                         EV_OBS_INSTANCIA                 IN GA_ABOCEL.OBS_INSTANCIA%TYPE,
                                                                         EV_TipoPrimariaCarrier           IN GA_ABOCEL.TIPO_PRIMARIACARRIER%TYPE,
                                                                         EN_IMP_LIMCONSUMO                IN GA_LCABO_TO.IMP_LIMCONS%TYPE,
                                                                         SN_cod_retorno                   OUT NOCOPY ge_errores_pg.CodError,
                                                                         SV_mens_retorno                  OUT NOCOPY ge_errores_pg.MsgError,
                                                                         SN_num_evento                    OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE VE_IN_GA_EQUIPABOSER_PR(EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                                                  EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                                                  EN_cod_producto    IN ga_equipaboser.cod_producto%TYPE,
                                                                  EV_ind_procequi    IN ga_equipaboser.ind_procequi%TYPE,
                                                                  EV_fec_alta        IN VARCHAR2,
                                                                  EV_ind_propiedad   IN ga_equipaboser.ind_propiedad%TYPE,
                                                                  EN_cod_bodega      IN ga_equipaboser.cod_bodega%TYPE,
                                                                  EN_tipstock        IN ga_equipaboser.tip_stock%TYPE,
                                                                  EN_codarticulo     IN ga_equipaboser.cod_articulo%TYPE,
                                                                  EV_indequiacc      IN ga_equipaboser.ind_equiacc%TYPE,
                                                                  EN_cod_modventa    IN ga_equipaboser.cod_modventa%TYPE,
                                                                  EV_tip_terminal    IN ga_equipaboser.tip_terminal%TYPE,
                                                                  EN_coduso          IN ga_equipaboser.cod_uso%TYPE,
                                                                  EV_cod_cuota       IN ga_equipaboser.cod_cuota%TYPE,
                                                                  EN_cod_estado      IN ga_equipaboser.cod_estado%TYPE,
                                                                  EN_capcode         IN ga_equipaboser.cap_code%TYPE,
                                                                  EV_cod_protocolo   IN ga_equipaboser.cod_protocolo%TYPE,
                                                                  EN_num_velocidad   IN ga_equipaboser.num_velocidad%TYPE,
                                                                  EN_cod_frecuencia  IN ga_equipaboser.cod_frecuencia%TYPE,
                                                                  EN_cod_version     IN ga_equipaboser.cod_version%TYPE,
                                                                  EV_num_seriemec    IN ga_equipaboser.num_seriemec%TYPE,
                                                                  EV_des_equipo      IN ga_equipaboser.des_equipo%TYPE,
                                                                  EN_cod_paquete     IN ga_equipaboser.cod_paquete%TYPE,
                                                                  EN_num_movimiento  IN ga_equipaboser.num_movimiento%TYPE,
                                                                  EV_cod_causa       IN ga_equipaboser.cod_causa%TYPE,
                                                                  EV_ind_eqprestado  IN ga_equipaboser.ind_eqprestado%TYPE,
                                                                  EV_num_imei            IN ga_equipaboser.num_imei%TYPE,
                                                                  EV_cod_tecnologia  IN ga_equipaboser.cod_tecnologia%TYPE,
                                                                  EN_imp_cargo           IN ga_equipaboser.imp_cargo%TYPE,
                                                                  EV_tip_dto             IN ga_equipaboser.tip_dto%TYPE,
                                                                  EV_val_dto             IN ga_equipaboser.val_dto%TYPE,
                                                                  EN_precioEquipo    IN  GA_EQUIPABOSER.PRC_VENTA%TYPE,  
                                                                  SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);
                PROCEDURE VE_UPD_GA_EQUIPABOSER_PR(EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                                                   EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                                                   EV_num_imei            IN ga_equipaboser.num_imei%TYPE,
                                                                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_GET_DATOS_GENERALES_PR(
                                       SV_cod_calclien     OUT NOCOPY ga_datosgener.cod_calclien%TYPE,
                                                   SV_cod_abc          OUT NOCOPY ga_datosgener.cod_abc%TYPE,
                                                   SN_cod_123          OUT NOCOPY ga_datosgener.cod_123%TYPE,
                                                   SN_codestcobros         OUT NOCOPY ga_datosgener.cod_estcobros%TYPE,
                                                   SV_codgrpsrv            OUT NOCOPY ga_grpserv.cod_grupo%TYPE,
                                                   SV_COD_DOCANEX      OUT NOCOPY ga_datosgener.COD_DOCANEX%TYPE,
                                                   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
                           
PROCEDURE VE_INS_USUAMIST_PR (
      EV_num_abonado   IN   ga_aboamist.num_abonado%TYPE,
      EV_cod_tipident  IN   ge_clientes.cod_tipident%TYPE,
      EV_num_ident     IN   ge_clientes.num_ident%TYPE,
      EV_cod_usuario   IN   ga_usuarios.cod_usuario%TYPE,
	  ED_FecNacim      IN   VARCHAR2,
	  EV_Nombre       IN VARCHAR2,
	  EV_Apell1       IN VARCHAR2,
	  EV_Apell2       IN VARCHAR2,
      SN_cod_retorno   IN  OUT NOCOPY       ge_errores_pg.CodError,
      SV_mens_retorno  IN  OUT NOCOPY       ge_errores_pg.MsgError,
      SN_num_evento    IN  OUT NOCOPY       ge_errores_pg.Evento);                           
PROCEDURE ve_insertar_ga_aboamist (
      v_num_abonado           IN       ga_aboamist.num_abonado%TYPE,
      v_cod_articulo          IN       al_articulos.cod_articulo%TYPE,
      v_num_terminal          IN       al_series.num_telefono%TYPE,
      v_cod_producto          IN       ga_aboamist.cod_producto%TYPE,
      v_cod_cliente           IN       ge_clientes.cod_cliente%TYPE,
      v_cod_cuenta            IN       NUMBER,
      v_cod_central           IN       al_series.cod_central%TYPE,
      v_cod_uso               IN       al_series.cod_uso%TYPE,
      v_cod_vendedor          IN       ga_ventas.cod_vendedor%TYPE,
      v_cod_vendedor_agente   IN       ga_ventas.cod_vendedor_agente%TYPE,
      v_num_serie             IN       al_series.num_serie%TYPE,
      v_num_venta             IN       ga_ventas.num_venta%TYPE,
      v_cod_modventa          IN       ga_ventas.cod_modventa%TYPE,
      v_cod_servicios         IN OUT   VARCHAR2,
      v_ind_telefono          IN       al_series.ind_telefono%TYPE,
      v_cod_plantarif         IN       ga_aboamist.cod_plantarif%TYPE,
      v_tip_plantarif         IN       ga_aboamist.tip_plantarif%TYPE,
      v_cod_usuario           IN       ga_usuarios.cod_usuario%TYPE,
      vs_ind_telefono         IN       al_series.ind_telefono%TYPE,
      vs_plan                 IN       al_series.PLAN%TYPE,
      vs_carga                IN       al_series.carga%TYPE,
      v_cod_tecnologia        IN       al_tecnologia.cod_tecnologia%TYPE, -- GSM
      v_imei                  IN       icc_movimiento.imei%TYPE, -- GSM
      v_cod_bodega_det        IN       npt_detalle_pedido.cod_bodega%TYPE,
	  v_min_mdn				  IN	   ga_aboamist.NUM_MIN_MDN%TYPE,
	  v_cod_celda			  IN	   GA_ABOAMIST.COD_CELDA%TYPE,
	  EN_Cliente              IN       ge_clientes.cod_cliente%type,
	  EN_Vendealer            IN       ga_aboamist.cod_vendealer%type,
      Ev_clase_servicio       IN       GA_ABOAMIST.CLASE_SERVICIO%TYPE, 
	  EV_COD_SITUACION        IN       GA_ABOAMIST.COD_SITUACION%TYPE, 
      EV_NOM_USUARORA         IN       GA_ABOAMIST.NOM_USUARORA%TYPE, 
      EV_Cod_Planserv         IN       GA_ABOAMIST.COD_PLANSERV%TYPE,
      EV_codPrestacion        IN       GA_ABOAMIST.COD_PRESTACION%TYPE,  
      EV_tipTerminal          IN       GA_ABOAMIST.TIP_TERMINAL%TYPE,
      EV_CodOperacion         IN       GA_ABOAMIST.COD_OPERACION%TYPE,
      EV_CodCausaVenta        IN       GA_ABOAMIST.COD_CAUSA_VENTA%TYPE,  
      EV_codCargoBasico       IN       GA_ABOAMIST.COD_CARGOBASICO%TYPE,
      SN_cod_retorno          IN  OUT NOCOPY  ge_errores_pg.CodError,
      SV_mens_retorno         IN  OUT NOCOPY  ge_errores_pg.MsgError,
      SN_num_evento           IN  OUT NOCOPY  ge_errores_pg.Evento   );
      
END VE_crea_linea_venta_PG;
/
SHOW ERRORS