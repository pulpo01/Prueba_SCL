CREATE OR REPLACE PACKAGE ga_facturas_pg
/*
<Documentación
  TipoDoc = "Package">
  <Elemento
      Nombre = "GA_FACTURAS_PG"
      Lenguaje="PL/SQL"
      Fecha="18-06-2005"
      Versión="1.0"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package negocio de  consulta de facturas</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
   </Elemento>
  </Documentación>
*/
AS
   -- Estructura de ga_segmentacion.ga_origen_cliente_pr --
   gn_num_abonado                  ga_abocel.num_abonado%TYPE;
   gn_cod_cliente                  ga_abocel.cod_cliente%TYPE;
   gn_cod_ciclo                    ga_abocel.cod_ciclo%TYPE;
   gn_fono_contacto                VARCHAR2 (15);
   gn_cod_cuenta                   ga_abocel.cod_cuenta%TYPE;
   gv_nom_abocli                   VARCHAR2 (91);
   gv_cod_situacion                ga_abocel.cod_situacion%TYPE;
   gv_cod_clave                    VARCHAR2 (7);
   gv_tip_plantarif                ga_abocel.tip_plantarif%TYPE;
   gv_cod_plantarif                ga_abocel.cod_plantarif%TYPE;
   gv_des_plantarif                ta_plantarif.des_plantarif%TYPE;
   gv_cod_tecnología               ga_abocel.cod_tecnologia%TYPE;
   gv_cod_perfil                   ge_valores_cli.des_valor%TYPE;
   gv_num_serie                    ga_abocel.num_serie%TYPE;
   gv_num_imei                     ga_abocel.num_imei%TYPE;
   gv_num_min_mdn                  ga_abocel.num_min_mdn%TYPE;
   gv_num_min                      ga_abocel.num_min%TYPE;
   gv_num_seriehex                 ga_abocel.num_seriehex%TYPE;
   gv_num_seriemec                 ga_abocel.num_seriemec%TYPE;
   gv_tip_terminal                 ga_abocel.tip_terminal%TYPE;
   gv_tip_abonado                  ta_plantarif.cod_tiplan%TYPE;
   gv_cod_estado                   ga_abocel.cod_estado%TYPE;
   gv_cod_tecnologia               ga_abocel.cod_tecnologia%TYPE;
   gv_nom_responsable              ga_cuentas.nom_responsable%TYPE;
   gn_cod_prod                     NUMBER (9);
   gv_cod_situacion_aaa   CONSTANT VARCHAR2 (3)                      := 'AAA';
   gv_cod_situacion_saa   CONSTANT VARCHAR2 (3)                      := 'SAA';
   gv_error_others        CONSTANT NUMBER                            := '156';
   gv_error_no_clasif     CONSTANT VARCHAR2 (100)   := 'Error no Clasificado';
   gn_largoerrtec         CONSTANT NUMBER (3)                        := 500;
   gn_largodesc           CONSTANT NUMBER (3)                        := 100;
   gv_cod_modulo          CONSTANT VARCHAR2 (2)                      := 'GA';
   gn_cod_atencion        CONSTANT NUMBER                            := 509;
   gv_cod_tiplan_post     CONSTANT VARCHAR2 (1)                      := '2';
   gv_cod_tiplan_hibr     CONSTANT VARCHAR2 (1)                      := '3';
   gn_cod_producto        CONSTANT NUMBER                            := 1;
   gn_cod_tipconce_e      CONSTANT NUMBER                            := 2;
   gn_cod_tipconce_f      CONSTANT NUMBER                            := 1;
   gn_cod_tipconce_g      CONSTANT NUMBER                            := 2;
   gn_cod_formulario      CONSTANT NUMBER                            := 2;
   cv_prepago             CONSTANT VARCHAR2 (1)                      := '1';

   TYPE refcursor IS REF CURSOR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ga_recupera_tablaenlace_fn (
      en_cod_ciclfact   IN              fa_enlacehist.cod_ciclfact%TYPE,
      sv_fa_histconc    OUT NOCOPY      fa_enlacehist.fa_histconc%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

--------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_consulta_detfactura_web_pr (
      en_num_celular    IN              NUMBER,
      en_num_folio      IN              NUMBER,
      sc_detfactura     OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_consulta_factura_web_pr (
      en_num_celular    IN              NUMBER,
      sc_factura        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

--------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_consulta_factura_touch_pr (
      en_num_celular    IN              NUMBER,
      sv_fec_ini        OUT NOCOPY      VARCHAR2,
      sv_fec_fin        OUT NOCOPY      VARCHAR2,
      sv_fec_emision    OUT NOCOPY      VARCHAR2,
      sv_fec_vencimie   OUT NOCOPY      VARCHAR2,
      sv_fec_susp       OUT NOCOPY      VARCHAR2,
      sn_saldo_ant      OUT NOCOPY      NUMBER,
      sn_saldo_act      OUT NOCOPY      NUMBER,
      sn_ult_pago       OUT NOCOPY      NUMBER,
      sn_tot_iptos      OUT NOCOPY      NUMBER,
      sn_tot_dctos      OUT NOCOPY      NUMBER,
      sn_tot_cargos     OUT NOCOPY      NUMBER,
      sn_tot_cargosme   OUT NOCOPY      NUMBER,
      sn_tot_cuotas     OUT NOCOPY      NUMBER,
      sn_tot_pagar      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------------------------------------------------------
END ga_facturas_pg;
/
SHOW ERRORS
