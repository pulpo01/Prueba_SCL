CREATE OR REPLACE PACKAGE VE_desbloqueaprepago_sms_PG IS
/*
<Documentación
 TipoDoc = "Package">
 <Elemento
 Nombre = SISCEL."VE_desbloqueaprepago_sms_PG"
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Rayen Ceballos"
          Programador="Roberto Perez"
      Migración="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Servicio de negocio para desbloqueo de prepago</Descripción>
      <Parámetros>
            <Entrada>
                </Entrada>
                <Salida>
            </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
SUBTYPE codvendealer IS ve_vendealer.cod_vendealer%TYPE;
SUBTYPE codtipident  IS ge_clientes.cod_tipident%TYPE;
SUBTYPE numident     IS ge_clientes.num_ident%TYPE;
SUBTYPE numserie     IS ga_aboamist.num_serie%TYPE;
SUBTYPE numimei      IS ga_aboamist.num_imei%TYPE;
SUBTYPE nomcliente   IS ge_clientes.nom_cliente%TYPE;
SUBTYPE nomapeclien1 IS ge_clientes.nom_apeclien1%TYPE;
SUBTYPE nomapeclien2 IS ge_clientes.nom_apeclien2%TYPE;
SUBTYPE codplantarif IS ta_plantarif.cod_plantarif%TYPE;
SUBTYPE codcliente   IS ge_clientes.cod_cliente%TYPE;
SUBTYPE numventa     IS ga_ventas.num_venta%TYPE;
SUBTYPE numcelular   IS ga_aboamist.num_celular%TYPE;
SUBTYPE fecalta      IS ga_aboamist.fec_alta%TYPE;

CV_version           CONSTANT VARCHAR2(5):= '1.0';
CV_codmodulo         CONSTANT VARCHAR2(2):='GA';
CV_codactabo         CONSTANT VARCHAR2(2):='VA';
CV_sta                   CONSTANT CHAR:='N';
CV_desrespuesta      CONSTANT VARCHAR2(10):='PENDIENTE';
CN_codestado         CONSTANT NUMBER(1):=1;
CV_idioma                        CONSTANT VARCHAR2(5):='1';
CV_indmuluso         CONSTANT CHAR:='N';
CV_clienpoten        CONSTANT CHAR:='N';
CV_error_no_clasif   CONSTANT VARCHAR2(60):='Error no clasificado';
CV_ciclo_ami         CONSTANT ged_parametros.nom_parametro%TYPE:='COD_AMI_CICLO';
CV_error                 CONSTANT VARCHAR2(5):= 'ERROR';
CV_tipcuenta             CONSTANT CHAR:= 'P';
/*INICIO : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/
CV_indestado             CONSTANT CHAR:= 'C';
CV_indsituacion          CONSTANT CHAR:= 'C';
/*INICIO : RA-200511010031 ; FECHA : 24/11/2005 ; USER: JEIM*/
CV_indtraspaso           CONSTANT CHAR:= 'S';
CV_indagente             CONSTANT CHAR:= 'N';
CV_indalta               CONSTANT CHAR:= 'M';
--Incio: RA-200511250201 ; FECHA : 28/11/2005 ; USER: NRCA
CV_indacepta             CONSTANT CHAR:= 'O';
CN_indfact               CONSTANT NUMBER(1):=1;
CV_canalvendedor         CONSTANT CHAR(1):='D';
CN_codprod               CONSTANT NUMBER(1):=1;
CV_ind_procequi      CONSTANT ga_equipaboser.ind_procequi%TYPE:='E';
CV_ind_propiedad     CONSTANT ga_equipaboser.ind_propiedad%TYPE:='C';
CV_prod_celular      CONSTANT ged_parametros.nom_parametro%TYPE:='PROD_CELULAR';
CV_ind_vtacero       CONSTANT ged_parametros.nom_parametro%TYPE:='IND_EST_VEN_CERO';
CV_ejecuta_commit    CONSTANT ged_parametros.nom_parametro%TYPE:='EJEC_COMMIT_DESBLSMS';
CV_si_ejecuta_commit CONSTANT ged_parametros.nom_parametro%TYPE:='SI';
CV_nom_tabla             CONSTANT ged_codigos.nom_tabla%TYPE:='DESBLOQUEO_PREPAGO';
CV_nom_columna           CONSTANT ged_codigos.nom_columna%TYPE:='PROCESO_EXITOSO';
CV_mod_venta         CONSTANT ged_parametros.nom_parametro%TYPE:='COD_MODCONTADO';
CV_alta_act_abonado      CONSTANT ga_situabo.cod_situacion%TYPE:='AAA';
CV_EquipoExterno         CONSTANT CHAR(1):= 'E';
CV_EquipoInterno         CONSTANT CHAR(1):= 'I';
CV_Aplic_Preliq          CONSTANT ged_parametros.nom_parametro%TYPE:='APLICA_PRELIQ_CONSIG';
CV_comision_lim          CONSTANT ged_parametros.nom_parametro%TYPE:='COMISION_LIMITE';
CV_dcto_marginal         CONSTANT ged_parametros.nom_parametro%TYPE:='DCTO_MARGINAL';
ncodvendealer           ve_vendealer.cod_vendealer%TYPE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VALIDA_IMEI_EXTERNO (EV_num_imei        IN         ga_aboamist.num_imei%TYPE,
                                                                  SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_VALIDA_USO   (EN_codcliente_dist IN         ga_aboamist.cod_cliente_dist%TYPE,
                                                   EV_icc             IN         ga_aboamist.num_serie%TYPE,
                                                   EV_num_imei        IN         ga_aboamist.num_imei%TYPE,
                                                   EV_indprocequi         IN                    CHAR,
                                                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_desbloqueo_PR(EN_codvendealer   IN      ve_vendealer.cod_vendealer%TYPE,
                           EV_tipident       IN         ge_clientes.cod_tipident%TYPE,
                           EV_numident       IN         ge_clientes.num_ident%TYPE,
                           EV_icc            IN         ga_aboamist.num_serie%TYPE,
                           EV_num_imei       IN         ga_aboamist.num_imei%TYPE,
                           EV_nomcliente     IN         ge_clientes.nom_cliente%TYPE,
                           EV_apeclien1      IN         ge_clientes.nom_apeclien1%TYPE,
                           EV_apeclien2      IN         ge_clientes.nom_apeclien2%TYPE,
                           EV_codplantarif   IN         icc_movimiento.plan%TYPE,
                           EV_canalvendedor  IN         VARCHAR2,
                           EV_indprocequi    IN         CHAR,
                           EV_codarticulo    IN         al_articulos.cod_articulo%TYPE,
                           EV_NUMTELEFONO    IN         ge_clientes.tef_cliente1%TYPE := 0  ,
                           EV_codprovincia   IN         ge_direcciones.COD_PROVINCIA%TYPE := ' ',
                           EV_codciudad      IN         ge_direcciones.cod_ciudad%TYPE := ' ',
                           EV_codcomuna      IN         ge_direcciones.COD_COMUNA%TYPE := ' ',
                           EV_nomcalle       IN         ge_direcciones.nom_calle%TYPE := ' ',
                           EV_observacion    IN         ge_direcciones.OBS_DIRECCION%TYPE := ' ',
                           EN_desbloq_sms    IN         NUMBER DEFAULT NULL,
                           SN_codcliente OUT NOCOPY     ge_clientes.cod_cliente%TYPE,
                           SN_numventa           OUT NOCOPY ga_ventas.num_venta%TYPE,
                           SN_numcelular     OUT NOCOPY ga_aboamist.num_celular%TYPE,
                           SD_fecalta        OUT NOCOPY ga_aboamist.fec_alta%TYPE,
                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                                   );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_insertamovimiento_PR(
                                                        EN_numabonado   IN  ga_aboamist.num_abonado%TYPE,
                            EV_codtecno     IN  ga_aboamist.cod_tecnologia%TYPE,
                                                    EV_tipterminal  IN  ga_aboamist.tip_terminal%TYPE,
                                                    EN_codcentral   IN  ga_aboamist.cod_central%TYPE,
                                                    EN_numcelular   IN  ga_aboamist.num_celular%TYPE,
                                                    EV_codplantarif IN  ta_plantarif.cod_plantarif%TYPE,
                                                    EV_nummin       IN  ga_aboamist.num_min%TYPE,
                                                        EV_seriesim     IN  icc_movimiento.num_serie%TYPE,
                                                        EV_imei         IN  icc_movimiento.imsi%TYPE,
                                                        LV_num_imsi     OUT NOCOPY icc_movimiento.imsi%TYPE,
                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_EXISTE_PLANTARIF_PR (
                                                                  EV_codplantarif  IN         ta_plantarif.cod_plantarif%TYPE,
                                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                                                 );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENENUMABONADO_PR(
                            EN_codcliente_dist IN         ga_aboamist.cod_cliente_dist%TYPE,
                            EV_icc                 IN         ga_aboamist.num_serie%TYPE,
                            SN_numabonado      OUT NOCOPY ga_aboamist.num_abonado%TYPE,
                            SV_codtecno        OUT NOCOPY ga_aboamist.cod_tecnologia%TYPE,
                                    SV_tipterminal     OUT NOCOPY ga_aboamist.tip_terminal%TYPE,
                                        SV_numseriehex     OUT NOCOPY ga_aboamist.num_seriehex%TYPE,
                                        SN_codcentral      OUT NOCOPY ga_aboamist.cod_central%TYPE,
                                        SN_numcelular      OUT NOCOPY ga_aboamist.num_celular%TYPE,
                                        SV_nummin          OUT NOCOPY ga_aboamist.num_min%TYPE,
                                                        SV_indtelefono     OUT NOCOPY ga_aboamist.ind_telefono%TYPE,
                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_generaventacero_PR (
                                                        EN_numabonado     IN         ga_aboamist.num_abonado%TYPE,
                                                        EN_codvendealer   IN              ga_aboamist.cod_vendealer%type,
                                                    EN_codcliente         IN              ga_aboamist.cod_cliente%type,
                                                        EN_codvendedoragente  IN                 ga_ventas.cod_vendedor_agente%TYPE,
                            SN_numventa       OUT NOCOPY ga_aboamist.num_venta%TYPE,
                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_creacuenta_PR( EV_descta              IN ga_cuentas.des_cuenta%TYPE,
                            EV_nomresp         IN ga_cuentas.nom_responsable%TYPE,
                                                    EV_tipident        IN ga_cuentas.cod_tipident%TYPE,
                                                    EV_numident        IN ga_cuentas.num_ident%TYPE,
                                                    EN_coddireccion    IN ga_cuentas.cod_direccion%TYPE,
                                                    SN_codcta          OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
                                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_creacliente_PR(EN_codcta        IN ga_cuentas.cod_cuenta%TYPE,
                           EV_nomcliente     IN ge_clientes.nom_cliente%TYPE,
                                                   EV_tipident       IN ge_clientes.cod_tipident%TYPE,
                           EV_numident           IN ge_clientes.num_ident%TYPE,
                           EV_nomapeclien1   IN ge_clientes.nom_apeclien1%TYPE,
                                                   EV_nomapeclien2   IN ge_clientes.nom_apeclien2%TYPE,
                                                   EV_NUMTELEFONO    IN ge_clientes.tef_cliente1%TYPE,
                                                   SN_codcliente     OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_OBTIENE_PRECIO_DESCUENTO(EV_COD_OPERACION    IN gad_descuentos.COD_OPERACION%TYPE,
                                                                         EV_COD_CLIENTE           IN ga_aboamist.COD_CLIENTE%TYPE,
                                                                         EV_NUM_ABONADO           IN ga_aboamist.NUM_ABONADO%TYPE,
                                                                         EV_COD_ARTICULO      IN gad_descuentos.COD_ARTICULO%TYPE,
                                                                     EV_PRECIO_VENTA      IN al_precios_venta.prc_venta%TYPE,
                                                                         SN_PRECIO_VENTA          OUT NOCOPY al_precios_venta.prc_venta%TYPE,
                                                                         SN_VAL_DESCUENTO         OUT NOCOPY gad_descuentos.VAL_DESCUENTO%TYPE,
                                                                     SN_cod_retorno               OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento                OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inicio Inc. 175777 - 13/10/2011 - FADL
FUNCTION pv_busca_cliente_vendedor_fn (
    en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
    sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
    sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
    sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
    )
    RETURN NUMBER;
--Fin Inc. 175777 - 13/10/2011 - FADL

END VE_desbloqueaprepago_sms_PG; 
/

