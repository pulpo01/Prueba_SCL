CREATE OR REPLACE PACKAGE ve_cargos_accesorios_pg
AS
   cv_modulove   CONSTANT VARCHAR2 (5) := 'VE';

   cv_cod_calificacion    CONSTANT VARCHAR (2)   := 'A'; --CSR-11002

   TYPE refcursor IS REF CURSOR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_preccargoacce_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      ev_ind_recambio   IN              al_precios_venta.ind_recambio%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_descuentoAcce_isc_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
	  en_tip_stock		IN              al_series.tip_stock%TYPE,
	  en_cod_uso		IN              al_series.cod_uso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_cargos_accesorios_pg;
/

SHOW ERRORS

