CREATE OR REPLACE PACKAGE Ve_Validacion_Linea_Pg IS


           cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
           cn_largoerrtec       CONSTANT NUMBER        := 4000;
           cn_largodesc         CONSTANT NUMBER        := 2000;
           CV_codproducto               CONSTANT VARCHAR(1)  :='1';
           CV_error_no_clasif   CONSTANT VARCHAR2(30):='Error no clasificado';
           CV_codmodulo         CONSTANT VARCHAR2(2) :='GA';
           CI_TRUE              CONSTANT PLS_INTEGER := 1;
           CI_FALSE             CONSTANT PLS_INTEGER := 0;
           CV_baja_abonado      CONSTANT VARCHAR2(3) :='BAA';
           CV_tipodireccion             CONSTANT VARCHAR2(1) :='1';
       CV_VENTA_RECHAZADA        CONSTANT VARCHAR2(5)  :='RE';

       TYPE ARRAY_PARAMETROS_     IS TABLE OF VARCHAR2(5) INDEX BY BINARY_INTEGER;

           FUNCTION VE_convertir_FN (EB_valor IN BOOLEAN) RETURN PLS_INTEGER;

           PROCEDURE VE_existeserieabonado_PR(EV_seriesimcard    IN  ga_abocel.num_serie%TYPE,
                                                                                 SB_resultado      OUT NOCOPY BOOLEAN,
                                                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_existeserieabonado_PR(EV_seriesimcard    IN  ga_abocel.num_serie%TYPE,
                                                                                  SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_serieterminalenabonado_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_serieterminalenabonado_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existeseriebodega_PR(EV_serie               IN  al_series.num_serie%TYPE,
                                                                                 SB_resultado       OUT NOCOPY BOOLEAN,
                                                                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existeseriebodega_PR(EV_serie               IN  al_series.num_serie%TYPE,
                                                                                 SN_resultado       OUT NOCOPY PLS_INTEGER,
                                                                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_vendedorbodega_PR(EV_codvendedor           IN  ve_vendedores.cod_vendedor%TYPE,
                                                                          EV_codbodega             IN  al_series.cod_bodega%TYPE,
                                                                  SB_resultado         OUT NOCOPY BOOLEAN,
                                                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_vendedorbodega_PR(EV_codvendedor           IN  ve_vendedores.cod_vendedor%TYPE,
                                                                          EV_codbodega             IN  al_series.cod_bodega%TYPE,
                                                                  SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_terminallistanegra_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SB_resultado      OUT NOCOPY BOOLEAN,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_terminallistanegra_PR(EV_serieterminal  IN  ga_abocel.num_serie%TYPE,
                                                                                  SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                                  SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------

	PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
	                                      EN_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
	                                      EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
	                                      SB_resultado      OUT NOCOPY BOOLEAN,
	                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
	                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
	                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------

	PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
   	                                      EN_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
	                                      EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
	                                      SN_resultado      OUT NOCOPY PLS_INTEGER,
	                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
	                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
	                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------

	PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
	                                      EN_codproducto	IN ga_modvent_aplic.cod_producto%TYPE,
	                                      EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
	                                      EN_CodCliente     IN GE_CLIENTES.COD_CLIENTE%TYPE,
	                                      SB_resultado      OUT NOCOPY BOOLEAN,
	                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
	                                      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
	                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------

    PROCEDURE VE_existe_plan_tarifario_PR(EV_plantarif      IN ta_plantarif.cod_plantarif%TYPE,
                                          EN_codproducto    IN ga_modvent_aplic.cod_producto%TYPE,
                                          EV_tecnologia     IN al_tecnologia.cod_tecnologia%TYPE,
                                          EN_CodCliente     IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                          SN_resultado      OUT NOCOPY PLS_INTEGER,
                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

----------------------------------------------------------------------------------------
										  
	PROCEDURE VE_vendedor_numero_PR(EV_numcelular     IN  ga_abocel.num_celular%TYPE,
 	                                EV_codcliente         IN  ge_clientes.cod_cliente%TYPE,
	                                SV_codvendedor        OUT NOCOPY ve_vendedores.cod_vendedor%TYPE,
	                                SV_coduso             OUT NOCOPY al_usos.cod_uso%TYPE,
	                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
	                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
	                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

       FUNCTION VE_existe_vendedor_FN(EV_cod_vendedor  IN ve_vendedores.cod_vendedor%TYPE,
                                                                          EV_ind_interno   OUT NOCOPY ve_vendedores.ind_interno%TYPE,
                                                                          SV_cod_cliente   OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN;



           PROCEDURE VE_existe_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                          SB_resultado     OUT NOCOPY BOOLEAN,
                                                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existe_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                          SN_resultado     OUT NOCOPY PLS_INTEGER,
                                                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_existe_cliente_empresa_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                  SB_resultado     OUT NOCOPY BOOLEAN,
                                                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_existe_cliente_empresa_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                  SN_resultado     OUT NOCOPY PLS_INTEGER,
                                                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);



           PROCEDURE VE_agente_comercial_PR(EV_codcliente        IN ge_clientes.cod_cliente%TYPE,
                                            SB_resultado         OUT NOCOPY BOOLEAN,
                                                                            SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_agente_comercial_PR(EV_codcliente        IN ge_clientes.cod_cliente%TYPE,
                                            SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                            SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existe_evaluacion_riesgo_PR(EV_numident             IN ge_clientes.num_ident%TYPE,
                                                                                                EV_tipident             IN ge_clientes.cod_tipident%TYPE,
                                                                                                EN_tipo_solicitud       IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                                EN_ind_evento                   IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                                EV_cod_estado           IN VARCHAR2,
                                                                                                EV_tipocliente          IN VARCHAR2,
                                                                                                SB_resultado            OUT NOCOPY BOOLEAN,
                                                                                                SN_cod_retorno                  OUT NOCOPY ge_errores_pg.CodError,
                                                                SV_mens_retorno                 OUT NOCOPY ge_errores_pg.MsgError,
                                                                SN_num_evento                   OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existe_evaluacion_riesgo_PR(EV_numident             IN ge_clientes.num_ident%TYPE,
                                                                                                EV_tipident             IN ge_clientes.cod_tipident%TYPE,
                                                                                                EN_tipo_solicitud       IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                                EN_ind_evento           IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                                EV_cod_estado           IN VARCHAR2,
                                                                                                EV_tipocliente          IN VARCHAR2,
                                                                                                SN_resultado            OUT NOCOPY PLS_INTEGER,
                                                                                                SN_cod_retorno                  OUT NOCOPY ge_errores_pg.CodError,
                                                                SV_mens_retorno                 OUT NOCOPY ge_errores_pg.MsgError,
                                                                SN_num_evento                   OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existe_eriesgo_ptarif_PR(EV_numident                IN ge_clientes.num_ident%TYPE,
                                                                                         EV_tipident                    IN ge_clientes.cod_tipident%TYPE,
                                                                                         EN_tipo_solicitud              IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                         EN_ind_evento                  IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                         EV_cod_estado                  IN VARCHAR2,
                                                                                         EV_plantarif                   IN ert_solicitud_planes.cod_plantarif%TYPE,
                                                                                         SB_resultado           OUT NOCOPY BOOLEAN,
                                                                                         SN_cod_retorno                 OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno                OUT NOCOPY ge_errores_pg.MsgError,
                                                         SN_num_evento                  OUT NOCOPY ge_errores_pg.Evento);

           PROCEDURE VE_existe_eriesgo_ptarif_PR(EV_numident            IN ge_clientes.num_ident%TYPE,
                                                                                         EV_tipident                    IN ge_clientes.cod_tipident%TYPE,
                                                                                         EN_tipo_solicitud              IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                                                                         EN_ind_evento                  IN ERT_SOLICITUD.ind_evento%TYPE,
                                                                                         EV_cod_estado                  IN VARCHAR2,
                                                                                         EV_plantarif                   IN ert_solicitud_planes.cod_plantarif%TYPE,
                                                                                         SN_resultado           OUT NOCOPY PLS_INTEGER,
                                                                                         SN_cod_retorno                 OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno                OUT NOCOPY ge_errores_pg.MsgError,
                                                         SN_num_evento                  OUT NOCOPY ge_errores_pg.Evento);

       PROCEDURE VE_existe_contrato_PR(EV_numcontrato    IN ga_contcta.num_contrato%TYPE,
                                           SB_resultado      OUT NOCOPY BOOLEAN,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


       PROCEDURE VE_existe_contrato_PR(EV_numcontrato    IN ga_contcta.num_contrato%TYPE,
                                           SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


           PROCEDURE VE_actualiza_eriesgo_PR(EV_numsolicitud    IN ERT_SOLICITUD.num_solicitud%TYPE,
                                                                                 EV_cod_estado      IN ERT_SOLICITUD.cod_estado%TYPE,
                                                                                 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_tipostock_valido_PR(EV_tipstock           IN al_series.tip_stock%TYPE,
                                                                           EV_modventa           IN ga_modvent_aplic.cod_modventa%TYPE,
                                                                           EV_codproducto        IN ga_modvent_aplic.cod_producto%TYPE,
                                                                           EV_codcanal           IN ga_modvent_aplic.cod_canal%TYPE,
                                                                           SB_resultado      OUT NOCOPY BOOLEAN,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_tipostock_valido_PR(EV_tipstock           IN al_series.tip_stock%TYPE,
                                                                           EV_modventa           IN ga_modvent_aplic.cod_modventa%TYPE,
                                                                           EV_codproducto        IN ga_modvent_aplic.cod_producto%TYPE,
                                                                           EV_codcanal           IN ga_modvent_aplic.cod_canal%TYPE,
                                                                           SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


      PROCEDURE VE_existe_cuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                        SB_resultado         OUT NOCOPY BOOLEAN,
                                                                        SV_descuenta             OUT NOCOPY ga_cuentas.des_cuenta%TYPE,
                                                                        SV_codcategoria      OUT NOCOPY ga_cuentas.cod_categoria%TYPE,
                                                                        SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_existe_cuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                        SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                        SV_descuenta             OUT NOCOPY ga_cuentas.des_cuenta%TYPE,
                                                                        SV_codcategoria      OUT NOCOPY ga_cuentas.cod_categoria%TYPE,
                                                                        SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);




          PROCEDURE VE_existe_subcuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                        SB_resultado         OUT NOCOPY BOOLEAN,
                                                                        SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_existe_subcuenta_PR(EV_codcuenta         IN  ga_cuentas.cod_cuenta%TYPE,
                                                                        SN_resultado         OUT NOCOPY PLS_INTEGER,
                                                                        SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento        OUT NOCOPY ge_errores_pg.Evento);



          PROCEDURE VE_verifica_rechazo_serie_PR (EV_num_serie_equipo IN ga_det_preliq.num_serie_orig%TYPE,
                                                                                          SN_resultado           OUT NOCOPY PLS_INTEGER,
                                                                                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento          OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_numeroreservadoOK_PR(EN_numcelular     IN  GA_RESERVA.num_celular%TYPE,
                                                    EN_codcliente     IN  GA_RESERVA.cod_cliente%TYPE,
                                                                                EN_codvendedor    IN  GA_RESERVA.cod_vendedor%TYPE,
                                                                                SB_resultado      OUT NOCOPY BOOLEAN,
                                                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

      PROCEDURE VE_numeroreservadoOK_PR(EN_numcelular     IN  GA_RESERVA.num_celular%TYPE,
                                                    EN_codcliente     IN  GA_RESERVA.cod_cliente%TYPE,
                                                                                EN_codvendedor    IN  GA_RESERVA.cod_vendedor%TYPE,
                                                                                SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


         PROCEDURE VE_RESTRINGESTOCK_PR(EN_CANAL          IN  VARCHAR,
                                                EN_NUM_SERIE      IN  AL_SERIES.NUM_SERIE%TYPE,
                                                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


         PROCEDURE VE_existeimeienabonado_PR  (EV_serieterminal IN  ga_abocel.num_imei%TYPE,
                                                                                   SB_resultado      OUT NOCOPY BOOLEAN,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


        PROCEDURE VE_existeimeienabonado_PR(EV_serieterminal IN  ga_abocel.num_imei%TYPE,
                                                                                    SN_resultado      OUT NOCOPY PLS_INTEGER,
                                                                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);


END Ve_Validacion_Linea_Pg; 
/
SHOW ERRORS
