CREATE OR REPLACE PACKAGE pv_cambio_simcard_sb_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "PV_CAMBIO_SIMCARD_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="18-07-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios cambio de simcard</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (50)
                                       := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'PV';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';
   cv_prod_celular      CONSTANT NUMBER (2)    := 1;
   cv_cod_modulo_ga     CONSTANT VARCHAR2 (2)  := 'GA';
   cv_programa          CONSTANT VARCHAR2 (3)  := 'GPA';
   -----
   cn_def_retorno       CONSTANT NUMBER        := 156;
   cv_def_error         CONSTANT VARCHAR2 (50)
                                  := 'Error al realizar el cambio de simcard';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_val_cau_cam_serie_pr (
      eo_sesion         IN              ge_sesion_qt,
      eo_caucaser       IN              ga_caucaser_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_modalidad_pago_pr (
      eo_caucaser       IN              ga_caucaser_qt,
      eo_sesion         IN              ge_sesion_qt,
      sc_mod_pago       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reserva_simcard_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      en_nummovimientobloqdesb   OUT NOCOPY      al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_desreserva_simcard_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      en_nummovimientobloqdesb   OUT NOCOPY      al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_serie_en_bodega_fn (
      eo_sesion         IN              ge_sesion_qt,
      eo_uso            IN              al_uso_qt,
      eo_tip_terminal   IN              al_tipos_terminales_qt,
      eo_dat_abo        IN              pv_datos_abo_qt,
      eo_al_serie       IN              al_serie_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_verifica_plan_comercial_fn (
      eo_sesion         IN              ge_sesion_qt,
      eo_caucaser       IN              ga_caucaser_qt,
      eo_modventa       IN              ge_modventa_qt,
      eo_uso            IN              al_uso_qt,
      eo_tip_terminal   IN              al_tipos_terminales_qt,
      eo_al_serie       IN              al_serie_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_verifica_vendedor_bodega_fn (
      en_cod_vendedor   IN              ve_vendalmac.cod_vendedor%TYPE,
      en_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
      en_cod_bodega     IN              al_series.cod_bodega%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION pv_verifica_numero_desviado_fn (
      ev_num_desviado   IN              tol_rannume_td.NUM_LINI%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR2;
   
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   PROCEDURE pv_registra_nueva_simcard_pr (
      er_equipaboser    IN              ga_equipaboser%ROWTYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_datos_simcard_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sc_dat_sim        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

   /* inicio RRG   70904 - validar serie externa */
   PROCEDURE pv_valida_serie_externa_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   );
    /* inicio RRG   70904 - validar serie externa */


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END pv_cambio_simcard_sb_pg;
/
SHOW ERRORS