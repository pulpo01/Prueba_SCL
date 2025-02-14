CREATE OR REPLACE PACKAGE Pv_Serv_Suplementario_Sb_Pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "PV_CAMBIO_SERIE_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="18-07-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios base para dirección</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif    CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   cv_cod_modulo         CONSTANT VARCHAR2 (2)  := 'GA';
   cv_version            CONSTANT VARCHAR2 (2)  := '1';
   cv_prod_celular       CONSTANT NUMBER (2)    := 1;
   cv_serv_suplabo          CONSTANT VARCHAR2(2)    := 'SS';-- 'Servicios suplementarios
   cv_serv_suplementario CONSTANT VARCHAR2(2)    := '2';
   cv_facturacion          CONSTANT VARCHAR2(2)    := 'FA';
   cv_uso_amistar        CONSTANT VARCHAR2 (2)  := '3';
   CV_cod_producto_post     CONSTANT ged_parametros.cod_producto%TYPE:=1;
   CV_param_usuario         CONSTANT ged_parametros.nom_parametro%TYPE:='USUARIO_SERV_PL_SQL';
   CV_separador             VARCHAR2(1):='|';
   CV_cod_actabo_ss         CONSTANT VARCHAR(2) := 'SS';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE pv_rec_serv_supl_abonado_pr (
      eo_dat_abo        IN OUT NOCOPY   pv_datos_abo_qt,
      tip_servicio      IN              NUMBER,
      sc_servsupl        OUT             refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      Ge_Errores_Pg.evento
    );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE pv_rec_serv_disp_pr (
      eo_dat_abo        IN OUT NOCOPY   pv_datos_abo_qt,
       eo_sesion         IN              GE_SESION_QT,
      sc_servicios      OUT             refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
    );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_reglas_valid_vig_ss_pr(
            eo_dat_abo                 IN OUT NOCOPY  pv_datos_abo_qt,
            so_cursor                 OUT NOCOPY        refcursor,
               sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
               sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
               sn_num_evento            OUT NOCOPY        ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_act_desact_ss_pr (
      EN_num_abonado             IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_num_celular             IN              GA_ABOCEL.num_celular%TYPE,
      EV_ss_comercial_act         IN              VARCHAR2 DEFAULT NULL,
      EV_ss_comercial_desact     IN              VARCHAR2 DEFAULT NULL,
      EN_secuencia                 IN              NUMBER,
      EN_cod_ooss_ss             IN              NUMBER,
      EN_imp_total                 IN                 PV_MOVIMIENTOS.carga%TYPE,
      EV_usuario                 IN              VARCHAR2,
       ev_comentario              IN              pv_iorserv.comentario%TYPE,
      SN_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento              OUT NOCOPY      Ge_Errores_Pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_ss_black_berry_abo_pr(
                                    eo_dat_abo                 IN OUT NOCOPY  pv_datos_abo_qt,
                                    so_cursor                 OUT NOCOPY        refcursor,
                                       sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                       sn_num_evento            OUT NOCOPY        Ge_Errores_Pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END Pv_Serv_Suplementario_Sb_Pg;
/
SHOW ERRORS