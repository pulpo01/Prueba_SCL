CREATE OR REPLACE PACKAGE BODY al_series_kit_pg AS
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
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';

      SELECT a.cod_bodega, a.cod_estado, a.ind_telefono, a.num_telefono, a.cod_uso, a.tip_stock, a.cod_central, a.cap_code, a.cod_articulo, s.tip_articulo, s.des_articulo, a.cod_subalm, t.ind_valorar, a.carga, a.cod_hlr
        INTO sv_codbodega, sv_estadoserie, sv_indtelefono, sv_numcelular, sv_uso, sv_tipostock, sv_codcentral, sn_capcode, sn_codarticulo, sn_tiparticulo, sv_desarticulo, sv_codsubalm, sn_indvalorar, sv_carga, sv_cod_hlr
        FROM al_componente_kit a, al_series b, al_articulos s, al_tipos_stock t
       WHERE a.num_kit = ev_serie_kit
         AND a.num_kit = b.num_serie
         AND a.num_serie = ev_serie
       AND s.cod_articulo = a.cod_articulo
       AND a.tip_stock = t.tip_stock;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         SN_cod_retorno  := 199050;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
         SN_cod_retorno  := 199051;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END ve_consulta_serie_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_serie_kit_pr (
      ev_numserie       IN              al_series.num_serie%TYPE,
      ev_numimei        IN              al_series.num_serie%TYPE,
      sv_numkit         OUT NOCOPY      al_componente_kit.num_kit%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   AS
      LV_des_error       VARCHAR2(300);
      LV_sql             VARCHAR2(1000);
    canImeiKit         NUMBER;
    ERROR_SERIEKIT     EXCEPTION;
   BEGIN
      SN_cod_retorno := 0;
      SN_num_evento  := 0;
      SV_mens_retorno:= '';


    LV_sql := 'SELECT a.num_kit FROM al_componente_kit a, al_series b'
             || ' WHERE a.num_kit = b.num_serie'
             || ' AND a.num_serie = '||ev_numserie;

      SELECT a.num_kit
      INTO sv_numkit
        FROM al_componente_kit a, al_series b
       WHERE a.num_kit = b.num_serie
         AND a.num_serie = ev_numserie;



    LV_sql := 'SELECT count(1) FROM al_componente_kit a, al_series b WHERE a.num_kit = b.num_serie'
             || ' AND a.num_serie = '||ev_numimei
         || ' AND a.num_kit = '||sv_numkit;

      SELECT count(1)
      INTO canImeiKit
        FROM al_componente_kit a, al_series b
       WHERE a.num_kit = b.num_serie
         AND a.num_serie = ev_numimei
     AND a.num_kit = sv_numkit;

      IF canImeiKit < 1 THEN
       RAISE ERROR_SERIEKIT;
    END IF;

   EXCEPTION
      WHEN ERROR_SERIEKIT THEN
         SN_cod_retorno  := 199051;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
      WHEN NO_DATA_FOUND THEN
         sv_numkit := '';
         SN_cod_retorno := 0;
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
      WHEN OTHERS THEN
         SN_cod_retorno  := 199051;
         SV_mens_retorno := 'Error no definido en el reingreso de la serie a almacén';
         LV_des_error    := 'al_series_portabilidad_pg.al_reingreso_series_pr(); - ' || SQLERRM;
         SN_num_evento   := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_ModuloAL,SV_mens_retorno,CV_version , USER, 'al_series_portabilidad_pg.al_reingreso_series_pr()', LV_sql, SQLCODE, LV_des_error );
   END ve_valida_serie_kit_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 END al_series_kit_pg;
/

SHOW ERRORS