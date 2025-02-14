CREATE OR REPLACE PACKAGE ve_tipificacion_pg
AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   cn_ind_recambio   CONSTANT NUMBER       := 9;
   cv_modulove       CONSTANT VARCHAR2 (5) := 'VE';
   cv_version        CONSTANT VARCHAR2 (5) := '1.0';
   cv_otro           CONSTANT VARCHAR2 (1) := 'O';
   cv_categoria      CONSTANT VARCHAR2 (5) := 'ZZZ';
   cv_cod_calificacion    CONSTANT VARCHAR (2)   := 'A'; --CSR-11002

   TYPE refcursor IS REF CURSOR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*PROCEDURE ve_recupera_tipificacion_pr(
		  							  ev_dato_ingresado IN VARCHAR2,
									  en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
									  sn_cod_articulo   OUT NOCOPY al_articulos.cod_articulo%TYPE,
									  sv_serie			OUT NOCOPY al_series.num_serie%TYPE,
									  sv_descripccion	OUT NOCOPY al_articulos.des_articulo%TYPE,
									  sv_precio			OUT NOCOPY al_precios_venta.prc_venta%TYPE,
									  sn_num_celular	OUT NOCOPY al_series.num_telefono%TYPE,
									  sv_equiacc		OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                                      sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
							          sn_prc_itbm       OUT NOCOPY NUMBER,
							          sn_prc_isc        OUT NOCOPY NUMBER,
									  sn_des_prc        OUT NOCOPY NUMBER,
									  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      							  sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      							  sn_num_evento     OUT NOCOPY ge_errores_pg.evento);*/


PROCEDURE ve_recupera_articulo_pr(
		  							  ev_dato_ingresado IN VARCHAR2,
									  en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
									  sn_cod_articulo   OUT NOCOPY al_articulos.cod_articulo%TYPE,
									  sv_serie			OUT NOCOPY al_series.num_serie%TYPE,
									  sv_descripccion	OUT NOCOPY al_articulos.des_articulo%TYPE,
									  sv_precio			OUT NOCOPY al_precios_venta.prc_venta%TYPE,
									  sn_num_celular	OUT NOCOPY al_series.num_telefono%TYPE,
									  sv_equiacc		OUT NOCOPY al_articulos.ind_equiacc%TYPE,
                                      sv_tip_terminal   OUT NOCOPY al_articulos.tip_terminal%TYPE,
							          sn_prc_itbm       OUT NOCOPY NUMBER,
							          sn_prc_isc        OUT NOCOPY NUMBER,
									  sn_des_prc        OUT NOCOPY NUMBER,
									  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      							  sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      							  sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_selc_kit_pr (
      ev_dato_ingresado   IN              VARCHAR2,
      sv_equiacc          OUT NOCOPY      al_articulos.ind_equiacc%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE ve_recupera_kit_pr(
		  				     ev_dato_ingresado IN VARCHAR2,
 		  				     en_cod_vendedor   IN ve_vendalmac.COD_VENDEDOR%TYPE,
                             sc_datos_kit      OUT NOCOPY refcursor,
                             sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      				     sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	      				     sn_num_evento     OUT NOCOPY ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_insert_tipificacion_pr(
                                    ev_cod_tipificacion  IN ga_tipificacion_td.cod_tipificacion%TYPE,
                                    en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                                    en_flag_clientizable IN ga_tipificacion_td.flag_clientizable%TYPE,
                                    en_nom_usuario       IN ga_tipificacion_td.nom_usuario%TYPE,
									ev_des_tipificacion  IN ga_tipificacion_td.DES_TIPIFICACION%TYPE,
                                    sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    sn_num_evento        OUT NOCOPY ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_selec_curs_tipifica_pr (
      sc_tipificacion   OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_selec_tipifica_pr (
      en_cod_articulo        IN              ga_tipificacion_td.cod_articulo%TYPE,
      sv_cod_tipificacion    OUT NOCOPY      ga_tipificacion_td.cod_tipificacion%TYPE,
      sn_flag_clientizable   OUT NOCOPY      ga_tipificacion_td.flag_clientizable%TYPE,
      sn_nom_usuario         OUT NOCOPY      ga_tipificacion_td.nom_usuario%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_update_tipifica_pr(
                                en_cod_articulo      IN ga_tipificacion_td.cod_articulo%TYPE,
                                ev_cod_tipificacion  IN ga_tipificacion_td.cod_tipificacion%TYPE,
                                en_flag_clientizable IN ga_tipificacion_td.flag_clientizable%TYPE,
                                sn_nom_usuario       IN ga_tipificacion_td.nom_usuario%TYPE,
								en_des_tipificacion  IN ga_tipificacion_td.DES_TIPIFICACION%TYPE,
                                sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento        OUT NOCOPY ge_errores_pg.evento);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_delete_tipifica_pr (
      en_cod_articulo   IN              ga_tipificacion_td.cod_articulo%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_recupera_zip_pr (
      ev_cod_region      IN              ge_ciucom.cod_region%TYPE,
      ev_cod_provincia   IN              ge_ciucom.cod_provincia%TYPE,
      ev_cod_ciudad      IN              ge_ciucom.cod_ciudad%TYPE,
      ev_cod_comuna      IN              ge_ciucom.cod_comuna%TYPE,
      sv_zip             OUT NOCOPY      ge_zipcode_td.zip%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_celular_serie_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      ev_num_venta      IN              ga_ventas.num_venta%TYPE,
      sv_num_celular    OUT NOCOPY      ga_aboamist.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_tipificacion_pg;
/

SHOW ERRORS

