CREATE OR REPLACE PACKAGE AL_PAC_ANULA_GUIAS IS
  --
  PROCEDURE p_select_docguia(
  v_docguia IN OUT ga_datosgener.cod_docguia%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
;
 /* PROCEDURE p_genera_consumo(
  v_oficina IN al_consumo_documentos.cod_oficina%type ,
  v_docguia IN al_consumo_documentos.tip_docum%type ,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_usuario IN al_consumo_documentos.usu_consumo%type ,
  v_anula IN al_consumo_documentos.ind_anulacion%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN al_asig_documentos.cod_vendedor%type)
;*/
  PROCEDURE p_select_oficina(
  v_usuario IN ge_seg_usuario.nom_usuario%type ,
  v_oficina IN OUT ge_seg_usuario.cod_oficina%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
;
  PROCEDURE p_anula_guia(
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_prefijo IN al_consumo_documentos.pref_plaza%type,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_usuario IN al_consumo_documentos.usu_consumo%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type );
PROCEDURE p_actualiza_rango(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
;
  PROCEDURE p_parte_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
;
  PROCEDURE p_update_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
;
  PROCEDURE p_obtiene_vendedor(
   v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo   IN al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN OUT al_asig_documentos.cod_vendedor%type)
;

  PROCEDURE p_anula_consumo(
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_oficina IN al_consumo_documentos.cod_oficina%type ,
  v_docguia IN al_consumo_documentos.tip_docum%type ,
  v_prefijo IN al_consumo_documentos.pref_plaza%type,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN al_asig_documentos.cod_vendedor%type );
END AL_PAC_ANULA_GUIAS;
/
SHOW ERRORS
