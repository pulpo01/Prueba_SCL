CREATE OR REPLACE PACKAGE BODY AL_PAC_ANULA_GUIAS IS
  PROCEDURE p_select_docguia(
  v_docguia IN OUT ga_datosgener.cod_docguia%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
  BEGIN
     select cod_docguia
       into v_docguia
       from ga_datosgener;
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Obtencion Documento Guia de Despacho/';
  END p_select_docguia;
  --
/*    PROCEDURE p_genera_consumo(
  v_oficina IN al_consumo_documentos.cod_oficina%type ,
  v_docguia IN al_consumo_documentos.tip_docum%type ,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_usuario IN al_consumo_documentos.usu_consumo%type ,
  v_anula IN al_consumo_documentos.ind_anulacion%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN al_asig_documentos.cod_vendedor%type )
  IS
    v_ind_consumo     al_consumo_documentos.ind_consumo%type;
    BEGIN
      v_ind_consumo := 'A';
    insert into al_consumo_documentos (cod_oficina,
                                       tip_docum,
                                       num_folio,
                                       usu_consumo,
                                       fec_consumo,
                                       ind_consumo,
                                       ind_anulacion,
                                                            cod_vendedor)
                               values (v_oficina,
                                       v_docguia,
                                       v_folio,
                                       v_usuario,
                                       sysdate,
                                       v_ind_consumo,
                                       v_anula,
                                                            v_vendedor);
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Generacion Consumo Folio/';
  END p_genera_consumo;*/
  PROCEDURE p_anula_consumo(
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_oficina IN al_consumo_documentos.cod_oficina%type ,
  v_docguia IN al_consumo_documentos.tip_docum%type ,
  v_prefijo IN al_consumo_documentos.pref_plaza%type,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN al_asig_documentos.cod_vendedor%type )
  IS
    v_respuesta varchar2(25);
        v_pos       NUMBER(3);
        v_codRespuesta varchar2(5);
    v_ind_consumo     al_consumo_documentos.ind_consumo%type;
        e_Error_Foliacion exception;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('p_anula_consumo 1');
      v_ind_consumo := 'A';
          SELECT FA_FOLIACION_PG.FA_ANULA_FOLIO_FN( v_docguia,
                                v_vendedor ,
                                v_oficina  ,
                                v_operadora,
                                v_prefijo ,
                                v_folio  )
      INTO v_respuesta
          FROM DUAL;
          DBMS_OUTPUT.PUT_LINE('RESPUESTA ' || v_respuesta);
          v_Pos := INSTR(v_respuesta, ';');
          v_codRespuesta := SUBSTR(v_respuesta,1, v_Pos - 1);

          if to_number(v_codRespuesta) <> 3 then
                 raise e_Error_Foliacion;
          end if;
   /* insert into al_consumo_documentos (cod_oficina,
                                       tip_docum,
                                       num_folio,
                                       usu_consumo,
                                       fec_consumo,
                                       ind_consumo,
                                       ind_anulacion,
                                                            cod_vendedor)
                               values (v_oficina,
                                       v_docguia,
                                       v_folio,
                                       v_usuario,
                                       sysdate,
                                       v_ind_consumo,
                                       v_anula,
                                                            v_vendedor);*/
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Anulacion Folio/';
  END p_anula_consumo;
  --
  PROCEDURE p_select_oficina(
  v_usuario IN ge_seg_usuario.nom_usuario%type ,
  v_oficina IN OUT ge_seg_usuario.cod_oficina%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
  ERROR_OBTENGO_OFICINA      EXCEPTION;
  BEGIN
     select cod_oficina
       into v_oficina
       from ge_seg_usuario
      where nom_usuario = v_usuario;

	 v_oficina:=fa_foliacion_pg.FA_OFICINA_CONSUMO_FN(v_oficina);

	 IF v_oficina IS NULL THEN
	   RAISE ERROR_OBTENGO_OFICINA;
	 END IF;

  EXCEPTION
     when ERROR_OBTENGO_OFICINA then
          v_error := 1;
          v_mensa := '/Error Obtencion Oficina/';
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Obtencion Oficina/';
  END p_select_oficina;
  --
  PROCEDURE p_anula_guia(
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_prefijo IN al_consumo_documentos.pref_plaza%type,
  v_folio IN al_consumo_documentos.num_folio%type ,
  v_usuario IN al_consumo_documentos.usu_consumo%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
     v_docguia       ga_datosgener.cod_docguia%type;
     v_oficina       ge_seg_usuario.cod_oficina%type;
  --   v_uno           number(1);
        v_vendedor      al_asig_documentos.cod_vendedor%type;
        v_desde         al_asig_documentos.ran_desde%type;
  BEGIN
   --  v_uno := 1;
     p_select_docguia (v_docguia,
                       v_mensa,
                       v_error);

     if v_error <> 1 then
        p_select_oficina (v_usuario,
                          v_oficina,
                          v_mensa,
                          v_error);

     end if;
     if v_error <> 1 then
        p_obtiene_vendedor (v_oficina,
                           v_docguia,
                                                   v_operadora,
                                                   v_prefijo,
                           v_folio,
                           v_mensa,
                           v_error,
                                               v_vendedor);

     end if;
/*     if v_error <> 1 then  --JLA (TMM) 03012002
        p_actualiza_rango (v_oficina,
                           v_docguia,
                                                   v_operadora,
                                                   v_prefijo,
                           v_folio,
                                                   v_desde,
                           v_mensa,
                           v_error);
     end if;*/
     if v_error <> 1 then
 /*       p_genera_consumo (v_oficina,
                          v_docguia,
                                                  v_operadora,
                                                  v_prefijo,
                          v_folio,
                          v_usuario,
                          v_uno,
                          v_mensa,
                          v_error,
                                         v_vendedor);*/



       p_anula_consumo (v_operadora,
                              v_oficina,
                          v_docguia,
                                                  v_prefijo,
                          v_folio,
                          v_mensa,
                          v_error,
                                         v_vendedor);
     end if;

  EXCEPTION
      when OTHERS then
           v_error := 1;
  END p_anula_guia;
  --
  PROCEDURE p_actualiza_rango(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
     v_rowid        rowid;
     v_usado        al_asig_documentos.ran_usado%type;
  BEGIN
     select rowid,ran_usado
       into v_rowid,v_usado
       from al_asig_documentos
      where cod_oficina  = v_oficina
        and cod_tipdocum = v_docguia
        and ran_usado    < ran_hasta
        and ran_desde   <= v_folio
        and ran_hasta   >= v_folio;
     if v_usado + 1 <> v_folio then
        p_parte_rango (v_rowid,
                       v_folio,
                       v_mensa,
                       v_error);
     else
        p_update_rango (v_rowid,
                        v_folio,
                        v_mensa,
                        v_error);
     end if;
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Obtencion Rango/';
  END p_actualiza_rango;
  --
  PROCEDURE p_obtiene_vendedor(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo   IN al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type,
  v_vendedor IN OUT al_asig_documentos.cod_vendedor%type)
  IS
  BEGIN
     select cod_vendedor
       into v_vendedor
       from al_asig_documentos
      where cod_operadora = v_operadora --JLA (TMM) 03012003
            and cod_oficina  = v_oficina
        and cod_tipdocum = v_docguia
                and pref_plaza   = v_prefijo  --JLA (TMM) 03012003
        and ran_usado    < ran_hasta
        and ran_desde   <= v_folio
        and ran_hasta   >= v_folio;
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Obtencion Codigo de Vendedor/';
  END p_obtiene_vendedor;
  --
  PROCEDURE p_parte_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
     v_uno   number(1);
  BEGIN
     v_uno := 1;
     insert into al_asig_documentos (cod_oficina,
                                     cod_tipdocum,
                                     fec_asigna,
                                     ran_desde,
                                     ran_hasta,
                                     ran_usado,
                                                          cod_vendedor)
                              select cod_oficina,
                                     cod_tipdocum,
                                     fec_asigna,
                                     v_folio,
                                     ran_hasta,
                                     v_folio,
                                                          cod_vendedor
                                from al_asig_documentos
                               where rowid = v_rowid;
     update al_asig_documentos
        set ran_hasta = v_folio - v_uno
      where rowid = v_rowid;
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error al Partir Rango/';
  END p_parte_rango;
  --
  PROCEDURE p_update_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type ,
  v_mensa IN OUT al_interguias.des_cadena%type ,
  v_error IN OUT al_interguias.cod_retorno%type )
  IS
  BEGIN
     update al_asig_documentos
        set ran_usado = v_folio
      where rowid = v_rowid;
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Actualizacion Rango/';
  END p_update_rango;
END AL_PAC_ANULA_GUIAS;
/
SHOW ERRORS
