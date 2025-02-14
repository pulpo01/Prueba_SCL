CREATE OR REPLACE PACKAGE Ga_Consumo_Pg
/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GA_CONSUMO_PG"
       Lenguaje="PL/SQL"
       Fecha="18-06-2005"
       Versión="1.0"
       Diseñador="Carlos Navarro H. - Marcelo Godoy S."
       Programador="Marcelo Godoy S. - Carlos Navarro H."
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package negocio de consultas a Cobranzas y TOL</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>
    </Elemento>
</Documentación>
<Código de Incidencia>
   <Datos Incidencia="MCO-200608180004" Descripción="Solicitud de retorno de Tiempo Extra y Plan por separado"></Datos>
   <Fecha Cambio="29/09/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
<Código de Incidencia>
   <Datos Incidencia="35869" Descripción="Se agrega indicador de unidad en trama de consulta tasación"></Datos>
   <Fecha Cambio="05/12/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
*/
AS
   TYPE refcursor IS REF CURSOR;

   -- Estructura de ga_segmentacion.ga_origen_cliente_pr --
   GN_num_abonado                  GA_ABOCEL.NUM_ABONADO%TYPE;
   GN_cod_cliente                  GA_ABOCEL.cod_cliente%TYPE;
   GN_cod_ciclo                    GA_ABOCEL.cod_ciclo%TYPE;
   GN_fono_contacto                VARCHAR2 (15);
   GN_cod_cuenta                   GA_ABOCEL.cod_cuenta%TYPE;
   GV_cod_transaccion              VARCHAR2 (2);
   GV_nom_abocli                   VARCHAR2 (91);
   GV_cod_situacion                GA_ABOCEL.cod_situacion%TYPE;
   GV_cod_clave                    VARCHAR2 (7);
   GV_tip_plantarif                GA_ABOCEL.tip_plantarif%TYPE;
   GV_cod_plantarif                GA_ABOCEL.cod_plantarif%TYPE;
   GV_cod_tecnología               GA_ABOCEL.cod_tecnologia%TYPE;
   GV_cod_perfil                   GE_VALORES_CLI.des_valor%TYPE;
   GV_num_serie                    GA_ABOCEL.num_serie%TYPE;
   GV_num_imei                     GA_ABOCEL.num_imei%TYPE;
   GV_num_min_mdn                  GA_ABOCEL.num_min_mdn%TYPE;
   GV_num_min                      GA_ABOCEL.num_min%TYPE;
   GV_num_seriehex                 GA_ABOCEL.num_seriehex%TYPE;
   GV_num_seriemec                 GA_ABOCEL.num_seriemec%TYPE;
   GV_tip_terminal                 GA_ABOCEL.tip_terminal%TYPE;
   GV_tip_abonado                  TA_PLANTARIF.cod_tiplan%TYPE;
   GV_cod_estado                   GA_ABOCEL.cod_estado%TYPE;
   GV_cod_tecnologia               GA_ABOCEL.cod_tecnologia%TYPE;
   GV_nom_responsable              GA_CUENTAS.nom_responsable%TYPE;
   GV_des_plantarif                TA_PLANTARIF.des_plantarif%TYPE;
   GN_cod_prod                     NUMBER (9);
   CV_version            CONSTANT VARCHAR2(5)           := '1.0';
   GV_cod_situacion_aaa   CONSTANT VARCHAR2 (3)                      := 'AAA';
   GV_cod_situacion_saa   CONSTANT VARCHAR2 (3)                      := 'SAA';
   GV_error_no_clasif     CONSTANT VARCHAR2 (100)   := 'Error no Clasificado';
   GN_largoerrtec         CONSTANT NUMBER (3)                        := 500;
   GN_largodesc           CONSTANT NUMBER (3)                        := 100;
   GV_cod_modulo          CONSTANT VARCHAR2 (2)                      := 'GA';
   GV_cod_actabo          CONSTANT VARCHAR2 (2)                      := 'TC';
   GN_cod_atencion        CONSTANT NUMBER                            := 509;
   GV_cod_tiplan          CONSTANT VARCHAR2 (1)                      := '2';
   GN_cod_producto        CONSTANT NUMBER                            := 1;
   GN_num_unidades        CONSTANT NUMERIC (1)                       := 1;
   GN_ind_factur          CONSTANT NUMERIC (1)                       := 1;
   GN_num_transaccion     CONSTANT NUMERIC (1)                       := 0;
   GN_num_venta           CONSTANT NUMERIC (1)                       := 0;
   CV_prepago             CONSTANT VARCHAR2 (1)                      := '1';
   CN_abonado_prepago     CONSTANT NUMBER (1)                        := 1;
   CN_abonado_hibrido      CONSTANT NUMBER(1)                      := 3;


   cv_error_no_clasif    CONSTANT VARCHAR2(30):='Error no clasificado';
   cv_cod_modulo         CONSTANT VARCHAR(2):= 'GA';
   CV_subversion         CONSTANT VARCHAR2(2) :='0';

   LV_PREFIJOX      VARCHAR2(4);
-------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_recupera_consumo_fn (
      EN_ind_ordentotal   IN   FA_HISTDOCU.ind_ordentotal%TYPE,
      EN_cod_ciclfact     IN   FA_HISTDOCU.cod_ciclfact%TYPE
   )
      RETURN NUMBER;

-------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cobro_consulta_tasacion_pr (
      EN_num_celular    IN              NUMBER,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ingreso_cobro_pr (
      EN_cod_cliente    IN              GE_CARGOS.cod_cliente%TYPE,
      EN_cod_producto   IN              GE_CARGOS.cod_producto%TYPE,
      EN_num_abonado    IN              GE_CARGOS.NUM_ABONADO%TYPE,
      EN_num_celular    IN              GE_CARGOS.num_terminal%TYPE,
      EN_cod_plancom    IN              GE_CARGOS.cod_plancom%TYPE,
      EN_cod_ciclfact   IN              GE_CARGOS.cod_ciclfact%TYPE,
      EN_cod_concepto   IN              GE_CARGOS.cod_concepto%TYPE,
      EN_imp_tarifa     IN              GE_CARGOS.imp_cargo%TYPE,
      EV_cod_moneda     IN              GE_CARGOS.cod_moneda%TYPE,
      EV_num_serie      IN              GE_CARGOS.num_serie%TYPE,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_saldo_pr (
      EN_num_celular    IN              NUMBER,
      SN_saldo          OUT NOCOPY      NUMBER,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_consumo_6meses_pr (
      EN_num_celular    IN              GA_ABOCEL.num_celular%TYPE,
      SC_cur_consumo    OUT NOCOPY      refcursor,
      SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_plan_detallado_pr (
      EN_num_celular       IN              GA_ABOCEL.num_celular%TYPE,
      SV_cod_plantarif     OUT NOCOPY      TA_PLANTARIF.cod_plantarif%TYPE,
      SV_fec_vigencia      OUT NOCOPY      GA_ABOCEL.fec_cumplan%TYPE,
      SN_num_unidades      OUT NOCOPY      TA_PLANTARIF.num_unidades%TYPE,
      SN_imp_cargobasico   OUT NOCOPY      TA_CARGOSBASICO.imp_cargobasico%TYPE,
      SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_mensaje_pr (
      EN_num_celular         IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      SN_cargo_basico        OUT NOCOPY      NUMBER,
      SN_can_mensaje_recib   OUT NOCOPY      NUMBER,
      SN_val_mensaje_recib   OUT NOCOPY      NUMBER,
      SN_can_mensaje_envia   OUT NOCOPY      NUMBER,
      SN_val_mensaje_envia   OUT NOCOPY      NUMBER,
      SN_tot_valor_servic    OUT NOCOPY      NUMBER,
      SN_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento          OUT NOCOPY      ge_errores_pg.evento
   );


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_consulta_tasacion_pr  (
      EN_num_abonado       IN  GA_ABOCEL.NUM_ABONADO%TYPE,
      SN_tim_llam_ent      OUT NOCOPY NUMBER,
      SN_val_llam_ent      OUT NOCOPY NUMBER,
      SN_tim_llam_sal      OUT NOCOPY NUMBER,
      SN_val_llam_sal      OUT NOCOPY NUMBER,
      SN_tim_llam_dat      OUT NOCOPY NUMBER,
      SN_val_llam_dat      OUT NOCOPY NUMBER,
      SN_tim_tota_voz      OUT NOCOPY NUMBER,
      SN_tim_text_voz      OUT NOCOPY NUMBER,  -- 34629 -rast- 28/09/2006 Tiempo Extra
      SN_val_tota_voz      OUT NOCOPY NUMBER,
      SN_tim_oper_tot      OUT NOCOPY NUMBER,
      SN_tim_cons_pla      OUT NOCOPY NUMBER,
      SN_tim_cons_npl      OUT NOCOPY NUMBER,
      SN_ind_unidad        OUT NOCOPY NUMBER,  -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
      SN_minutos_prom      OUT NOCOPY NUMBER,
      SN_cont_tasacion     OUT NOCOPY NUMBER,
      SN_VAL_MINTOTAL      OUT NOCOPY NUMBER,
      SN_VAL_USADO         OUT NOCOPY NUMBER,
      SN_VAL_DISPONIBLE    OUT NOCOPY NUMBER,
      SN_USADO_BOLSA       OUT NOCOPY NUMBER,
      SN_DISPONIBLE_BOLSA  OUT NOCOPY NUMBER,
      SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
   );

-------------------------------------------------------------------------------------------------------------------
END Ga_Consumo_Pg;
/
SHOW ERRORS
