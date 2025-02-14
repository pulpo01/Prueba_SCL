CREATE OR REPLACE PACKAGE BODY AL_PAC_FOLIOS_GUIAS IS
  PROCEDURE p_asigna_folio(
  v_numguia IN al_cab_guias.num_guia%type ,
  v_venta IN al_cab_guias.num_venta%type ,
  v_operadora IN al_cab_guias.cod_operadora%type,
  v_prefijo   IN al_cab_guias.pref_plaza%type,
  v_folio IN al_cab_guias.num_folio%type ,
  v_usuario IN al_cab_guias.usu_folio%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
  IS
    v_docguia       ga_datosgener.cod_docguia%type;
    v_docventa      ga_docventa%rowtype;
    v_oficina       ge_seg_usuario.cod_oficina%type;
    v_vendedor      al_asig_documentos.cod_vendedor%type;
        v_desde         al_asig_documentos.ran_desde%type;
    CURSOR c_lineas is
           select num_cargo from al_lin_guias
           where num_guia  = v_numguia
           and num_cargo is not null;
    CURSOR c_series is
           select num_cargo from al_ser_guias
           where num_guia  = v_numguia
           and num_cargo is not null;
    BEGIN
      p_select_docguia (v_docguia);

	  p_select_oficina (v_usuario,v_oficina);

	  v_oficina:=fa_foliacion_pg.FA_OFICINA_CONSUMO_FN(v_oficina);

	  p_obtiene_vendedor (v_oficina,v_docguia,v_operadora,v_prefijo,v_folio,v_vendedor);

	  p_actualiza_rango (v_oficina,v_docguia,v_operadora,v_prefijo,v_folio,v_desde);

	  p_genera_consumo (v_operadora,v_oficina,v_docguia,v_prefijo,v_desde,v_folio,v_usuario,0,v_vendedor);

      if v_venta is not null then
          v_docventa.num_venta    := v_venta;
          v_docventa.cod_tipdocum := v_docguia;
          v_docventa.num_folio    := v_folio;
          p_genera_docventa (v_docventa);
       end if;
       if v_detalle = 0 then
          FOR v_lineas in c_lineas LOOP
              p_actualiza_cargos (v_lineas.num_cargo,v_prefijo,v_folio);
          end LOOP;
       else
          FOR v_series in c_series LOOP
              p_actualiza_cargos (v_series.num_cargo,v_prefijo,v_folio);
          end LOOP;
       end if;
    END p_asigna_folio;
  --
  PROCEDURE p_actualiza_cargos(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_prefijo IN ge_cargos.pref_plaza%type,
  v_folio IN al_cab_guias.num_folio%type )
  IS
    BEGIN
        update ge_cargos
           set num_guia  = v_folio,
               pref_plaza = v_prefijo   --JLA (TMM) 06012003
         where num_cargo = v_cargo;
    EXCEPTION
        when OTHERS then
             raise_application_error (-20177,'Error Actualizacion Cargos '
                                      || to_char(SQLCODE));
    END p_actualiza_cargos;
  --
  PROCEDURE p_genera_docventa(
  v_docventa IN ga_docventa%rowtype )
  IS
    BEGIN
       insert into ga_docventa (num_venta,
                                cod_tipdocum,
                                num_folio)
                        values (v_docventa.num_venta,
                                v_docventa.cod_tipdocum,
                                v_docventa.num_folio);
    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'Error Generacion Documento - Venta
  '
                                     || to_char(SQLCODE));
    END p_genera_docventa;
  --
  PROCEDURE p_select_docguia(
  v_docguia IN OUT ga_datosgener.cod_docguia%type )
  IS
    BEGIN
       select cod_docguia into v_docguia
              from ga_datosgener;
    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'Error Obtencion Documento Guia '
                                     || to_char(SQLCODE));
    END p_select_docguia;
  --
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

  IS
    v_respuesta varchar2(25);
        v_pos       NUMBER(3);
        v_codRespuesta varchar2(5);
    v_ind_consumo     al_consumo_documentos.ind_consumo%type;
        e_Error_Foliacion exception;
    BEGIN
      v_ind_consumo := 'A';
          SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIOPUNTUAL_FN( v_docguia, v_vendedor, v_oficina, v_operadora,
                                                             v_desde, NULL, NULL, SYSDATE, 2, v_prefijo, v_folio )
                   INTO v_respuesta
          FROM DUAL;

          v_Pos := INSTR(v_respuesta, ';');
          v_codRespuesta := SUBSTR(v_respuesta,1, v_Pos - 1);

          if to_number(v_codRespuesta) <> 2 then
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
           when e_Error_Foliacion then
                 raise_application_error (-20177,'Error al Consumir folio. Valor Retorno = '|| v_respuesta );
       when OTHERS then
            raise_application_error (-20177,'Error Generacion Consumo Folio'
                                     || to_char(SQLCODE));
    END p_genera_consumo;
  --
  PROCEDURE p_select_oficina(
  v_usuario IN ge_seg_usuario.nom_usuario%type ,
  v_oficina IN OUT ge_seg_usuario.cod_oficina%type )
  IS
    BEGIN
       select cod_oficina into v_oficina
         from ge_seg_usuario
        where nom_usuario = v_usuario;
    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'Error Obtencion Oficina '
                                     || to_char(SQLCODE));
    END p_select_oficina;
  --
  PROCEDURE p_actualiza_rango(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo   IN al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type,
  v_ran_desde OUT al_asig_documentos.ran_desde%type)
  IS
       v_rowid        rowid;
       v_usado        al_asig_documentos.ran_usado%type;
           v_desde        al_asig_documentos.ran_desde%type; -- JLA (TMM) 30122002
    BEGIN
       select rowid,ran_usado, ran_desde
         into v_rowid,v_usado, v_desde
         from al_asig_documentos
        where cod_oficina  = v_oficina
          and cod_tipdocum = v_docguia
                  and cod_operadora = v_operadora  -- JLA (TMM) 30122002
                  and pref_plaza    = v_prefijo    -- JLA (TMM) 30122002
          and ran_usado    < ran_hasta
          and ran_desde   <= v_folio
          and ran_hasta   >= v_folio;
       if v_usado + 1 <> v_folio then
          p_parte_rango (v_rowid,
                         v_folio);
          v_desde := v_folio;
         -- else
         -- p_update_rango (v_rowid,
          --                v_folio);
       end if;
           v_ran_desde := v_desde;
    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'');
    END p_actualiza_rango;
  --
  PROCEDURE p_obtiene_vendedor(
  v_oficina IN al_asig_documentos.cod_oficina%type ,
  v_docguia IN al_asig_documentos.cod_tipdocum%type ,
  v_operadora IN al_asig_documentos.cod_operadora%type,
  v_prefijo   IN al_asig_documentos.pref_plaza%type,
  v_folio IN al_asig_documentos.ran_usado%type,
  v_vendedor IN OUT al_asig_documentos.cod_vendedor%type)
  IS
    BEGIN
         --  v_vendedor := NULL;
         --  IF v_vendedor is not null then
       select cod_vendedor
         into v_vendedor
         from al_asig_documentos
        where cod_operadora = v_operadora --JLA (TMM) 30122002
                  and cod_oficina  = v_oficina
          and cod_tipdocum = v_docguia
                  and pref_plaza   = v_prefijo   --JLA (TMM) 30122002
          and ran_usado    < ran_hasta
          and ran_desde   <= v_folio
          and ran_hasta   >= v_folio;
         --  end if;
    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'Error Obtencion codigo de vendedor');
    END p_obtiene_vendedor;
  --
  PROCEDURE p_parte_rango(
  v_rowid IN rowid ,
  v_folio IN al_asig_documentos.ran_usado%type)
  IS
    v_uno   number(1) := 1;
    BEGIN
       insert into al_asig_documentos (cod_operadora,
                                           cod_oficina,
                                       cod_tipdocum,
                                       fec_asigna,
                                                                           pref_plaza,
                                       ran_desde,
                                       ran_hasta,
                                       ran_usado,
                                                                   cod_vendedor)
                                select cod_operadora, --JLA(TMM) 30122002
                                                                       cod_oficina,
                                       cod_tipdocum,
                                       fec_asigna,
                                                                           pref_plaza, --JLA(TMM) 30122002
                                       v_folio,
                                       ran_hasta,
                                       v_folio - v_uno, --JLA(TMM) 31122002
                                                                  cod_vendedor
                                  from al_asig_documentos
                                 where rowid = v_rowid;

       update al_asig_documentos
          set ran_hasta = v_folio - v_uno
              where rowid = v_rowid;

    EXCEPTION
       when OTHERS then
            raise_application_error (-20177,'');
    END p_parte_rango;
  --

END AL_PAC_FOLIOS_GUIAS;
/
SHOW ERRORS
