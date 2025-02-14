CREATE OR REPLACE PACKAGE        AL_PROC_ES_EXTRA
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PROC_ES_EXTRA
-- * Descripcisn        : Rutinas para procesos entrada/salida extras
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE p_trata_extra(
  v_cabextra IN al_cab_es_extras%ROWTYPE )
;
  PROCEDURE p_select_movim(
  v_motivo IN al_motivos_es_extras.cod_motivo%TYPE ,
  v_tipmov IN OUT al_tipos_movimientos.tip_movimiento%TYPE )
;
  PROCEDURE p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_seriado IN OUT al_articulos.ind_seriado%TYPE )
;
  PROCEDURE p_proceso_seriados(
  v_numextra IN al_cab_es_extras.num_extra%TYPE ,
  v_linextra IN al_lin_es_extras.num_linea%TYPE ,
  v_entsal IN al_tipos_movimientos.ind_entsal%TYPE ,
  v_uso IN al_usos.cod_uso%TYPE ,
  v_movim IN OUT al_movimientos%ROWTYPE )
;
  PROCEDURE p_select_tipmovim(
  v_tipmov IN al_tipos_movimientos.tip_movimiento%TYPE ,
  v_entsal IN OUT al_tipos_movimientos.ind_entsal%TYPE )
;
  PROCEDURE p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%TYPE )
;
  PROCEDURE p_select_ind_telefono(
  v_serie IN al_series.num_serie%TYPE,
  v_indtelefono IN OUT al_series.ind_telefono%TYPE )
;
  PROCEDURE p_conv_serhex(
  v_serie IN al_series.num_serie%TYPE ,
  v_serhex IN OUT al_fic_series.num_serhex%TYPE )
;
PROCEDURE p_hex(v_num IN NUMBER,
                          v_hex IN OUT VARCHAR2)
;
END AL_PROC_ES_EXTRA;
/
SHOW ERRORS
