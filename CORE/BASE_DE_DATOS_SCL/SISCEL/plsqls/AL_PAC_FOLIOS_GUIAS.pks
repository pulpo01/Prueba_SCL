CREATE OR REPLACE PACKAGE AL_PAC_FOLIOS_GUIAS IS
  PROCEDURE p_asigna_folio(
  v_numguia IN al_cab_guias.num_guia%type ,
  v_venta IN al_cab_guias.num_venta%type ,
  v_operadora IN al_cab_guias.cod_operadora%type,
  v_prefijo   IN al_cab_guias.pref_plaza%type,
  v_folio IN al_cab_guias.num_folio%type ,
  v_usuario IN al_cab_guias.usu_folio%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
;
  PROCEDURE p_actualiza_cargos(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_prefijo IN ge_cargos.pref_plaza%type,
  v_folio IN al_cab_guias.num_folio%type )
;
  PROCEDURE p_genera_docventa(
  v_docventa IN ga_docventa%rowtype )
;
  PROCEDURE p_select_docguia(
  v_docguia IN OUT ga_datosgener.cod_docguia%type )
;
  PROCEDURE p_genera_consumo(
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_oficina IN al_consumo_documentos.cod_oficina%type ,
  v_docguia IN al_consumo_documentos.tip_docum%type ,
  v_prefijo IN al_consumo_documentos.pref_plaza%type,
  v_desde IN al_asig_documentos.ran_desde%type,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_usuario IN al_consumo_documentos.usu_consumo%type ,
  v_anula IN al_consumo_documentos.ind_anulacion%type,
  v_vendedor IN OUT al_asig_documentos.cod_vendedor%type)
;
  PROCEDURE p_select_oficina(
  v_usuario IN ge_seg_usuario.nom_usuario%type ,
  v_oficina IN OUT ge_seg_usuario.cod_oficina%type )
;
  PROCEDURE p_actualiza_rango(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo IN al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type,
  v_ran_desde OUT al_asig_documentos.ran_desde%type )
;
  PROCEDURE p_parte_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type )
;
  PROCEDURE p_obtiene_vendedor(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo   IN  al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type,
  v_vendedor IN OUT al_asig_documentos.cod_vendedor%type)
;
END AL_PAC_FOLIOS_GUIAS;
/
SHOW ERRORS
