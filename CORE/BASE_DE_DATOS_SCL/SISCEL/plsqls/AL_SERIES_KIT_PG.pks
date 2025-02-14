CREATE OR REPLACE PACKAGE al_series_kit_pg
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif    CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_moduloal           CONSTANT VARCHAR2 (5)  := 'AL';
   cv_version            CONSTANT VARCHAR2 (5)  := '1.0';
   cv_estadodestinores   CONSTANT NUMBER (5)    := 7;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_consulta_serie_kit_pr (
      ev_serie_kit      IN              al_series.num_serie%TYPE,
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_codbodega      OUT NOCOPY      al_series.cod_bodega%TYPE,
      sv_estadoserie    OUT NOCOPY      al_series.cod_estado%TYPE,
      sv_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sv_numcelular     OUT NOCOPY      al_series.num_telefono%TYPE,
      sv_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sv_codcentral     OUT NOCOPY      al_series.cod_central%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_capcode        OUT NOCOPY      al_series.cap_code%TYPE,
      sn_tiparticulo    OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_desarticulo    OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sv_codsubalm      OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sv_carga          OUT NOCOPY      VARCHAR2,
      sv_cod_hlr        OUT NOCOPY      al_series.cod_hlr%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_serie_kit_pr (
      ev_numserie       IN              al_series.num_serie%TYPE,
      ev_numimei        IN              al_series.num_serie%TYPE,
      sv_numkit         OUT NOCOPY      al_componente_kit.num_kit%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END al_series_kit_pg;
/

SHOW ERRORS