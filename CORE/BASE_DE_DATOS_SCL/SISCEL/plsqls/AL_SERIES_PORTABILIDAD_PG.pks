CREATE OR REPLACE PACKAGE al_series_portabilidad_pg
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif    CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_moduloal           CONSTANT VARCHAR2 (5)  := 'AL';
   cv_version            CONSTANT VARCHAR2 (5)  := '1.0';
   cv_estadodestinores   CONSTANT NUMBER (5)    := 7;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_reserva_series_pr (
      ev_num_serie        IN              VARCHAR2,
      ev_nom_usuario      IN              VARCHAR2,
      en_num_venta        IN              VARCHAR2,
      sn_num_movimiento   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_desreserva_series_pr (
      ev_num_serie        IN              VARCHAR2,
      ev_nom_usuario      IN              VARCHAR2,
      en_num_venta        IN              VARCHAR2,
      sn_num_movimiento   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_salida_def_series_pr (
      ev_num_serie        IN              VARCHAR2,
      ev_nom_usuario      IN              VARCHAR2,
      en_num_venta        IN              VARCHAR2,
      sn_num_movimiento   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_cambio_bodega_series_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      ev_nom_usuario    IN              VARCHAR2,
      en_cod_uso        IN              al_movimientos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_reingreso_series_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      ev_nom_usuario    IN              VARCHAR2,
      en_cod_USO        IN              al_bodegas.cod_bodega%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE al_sal_def_art_vend_pr (
      en_cod_articulo      IN              al_articulos.cod_articulo%TYPE,
      ev_nom_usuario       IN              ge_seg_usuario.nom_usuario%TYPE ,
      en_num_venta         IN              ga_ventas.num_venta%TYPE,
    en_cod_vendedor      IN              ve_vendedores.cod_vendedor%TYPE,
    en_num_cantidad      IN              NUMBER,
    en_cod_bodega      IN                al_stock.COD_BODEGA%TYPE,-- CSR-11002
      sn_num_movimiento    OUT NOCOPY      al_movimientos.num_movimiento%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   ) ;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END al_series_portabilidad_pg; 
/

SHOW ERRORS