CREATE OR REPLACE PACKAGE AL_PAC_BOLETA
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PAC_BOLETA
-- * Descripcion        : Rutinas para logistica
-- * Fecha de creacion  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE al_p_pasohis(
  v_numboleta IN al_cab_boleta.num_boleta%type )
;
  PROCEDURE al_p_pasohis_lin(
  v_numboleta IN al_cab_boleta.num_boleta%type,
  v_fechahis  IN al_hcab_boleta.fec_historico%type)
;
  PROCEDURE al_p_pasohis_ser(
  v_numboleta IN al_cab_boleta.num_boleta%type,
  v_numlinea  IN al_lin_boleta.num_linea%type,
  v_fechahis  IN al_hcab_boleta.fec_historico%type)
;
  PROCEDURE al_p_trata_boleta(
  v_cabboleta IN al_cab_boleta%rowtype )
;
  PROCEDURE al_p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_seriado IN OUT al_articulos.ind_seriado%type )
;
  PROCEDURE al_p_proceso_seriados(
  v_numboleta IN al_cab_boleta.num_boleta%type ,
  v_linboleta IN al_lin_boleta.num_linea%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_movim IN OUT al_movimientos%rowtype )
;
  PROCEDURE al_p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%type )
;
  PROCEDURE al_p_insert_activas(
  v_activas IN al_series_activas%rowtype )
;
PROCEDURE al_p_select_actuacion
         (v_actuacion_ami in out icg_actuacion.cod_actuacion%type,
          v_actuacion_act in out icg_actuacion.cod_actuacion%type,
          v_actuacion_gsm_ami in out icg_actuacion.cod_actuacion%type,
                  v_actuacion_act_gsm in out icc_movimiento.cod_actuacion%type)
;
PROCEDURE al_p_activar_central
        (v_actuacion in icc_movimiento.cod_actuacion%type,
         v_prefijo al_usos_min.num_min%type,
              v_central   in icc_movimiento.cod_central%type,
              v_celular   in icc_movimiento.num_celular%type,
              v_serie     in icc_movimiento.num_serie%type,
              v_terminal  in icc_movimiento.tip_terminal%type,
              v_movimiento in out icc_movimiento.num_movimiento%type,
              v_error     in out number,
                          p_serie_dec IN al_series.num_serie%TYPE);
END AL_PAC_BOLETA;
/
SHOW ERRORS
