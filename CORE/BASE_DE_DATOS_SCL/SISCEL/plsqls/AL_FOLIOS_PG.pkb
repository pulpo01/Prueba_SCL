CREATE OR REPLACE PACKAGE BODY al_folios_pg AS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "al_folios_pg" Lenguaje="PL/SQL" Fecha="dd-mm-yyyy" Versión="1.0.0"
        Diseñador= "****" Programador="****" Ambiente="BD">
<Retorno>		: NA</Retorno>
<Parámetros>
<Entrada></Entrada>
<Salida></Salida>
</Parámetros>
</Elemento>
</Documentación>
<Versionmod>="1.1"  </Versionmod>
<Fechamod> : 28-10-2010 </Fechamod>
<Desmod> : Se modificaca PL: AL_INS_ASIGDOCT_PR, donde se maneja el valor de rango usaro igual a el valor desde menos 1. Inc. 149620  </Desmod>
<Autor>   Zenén Muñoz H. </Autor>

*/
    
procedure AL_VALIDAR_FOLIOS_PR(
EN_num_solfolios    IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EN_cod_tipdocum     IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_resolucion       IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion   IN varchar2,
EV_serie            IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta         IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango     IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango        IN AL_SOLFOLIOS_TO.rango_hasta%TYPE,
EV_operadora        IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EV_accion           IN varchar2,
SN_num_solfolios    OUT NOCOPY AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS

ln_num_folios        AL_SOLFOLIOS_TO.num_solfolios%TYPE;
ln_num_solfolios_max  AL_SOLFOLIOS_TO.num_solfolios%TYPE;
LV_fecres            VARCHAR2(10);
LN_rango_hasta       AL_SOLFOLIOS_TO.rango_hasta%TYPE;
LN_rango_desde       AL_SOLFOLIOS_TO.rango_desde%TYPE;
LN_rango_desde_sgte  AL_SOLFOLIOS_TO.rango_desde%TYPE;
le_error_validacion  EXCEPTION;
LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin
SV_mens_retorno:=' ';
SN_cod_retorno:=0;
SN_num_evento:=0;
ln_num_folios:=0;
SN_num_solfolios:=0;

--Validar que resolución es única para el tipo de documento.
 if EV_resolucion IS NOT NULL then
       LV_sSql:=' Select a.num_solfolios into SN_num_solfolios from AL_SOLFOLIOS_TO a '||
               ' where a.cod_tipdocum='||EN_cod_tipdocum || 'and a.resolucion='''||EV_resolucion ||
               ''' and a.cod_estadosol<>'''||CV_anulada||'';
       begin
           Select a.num_solfolios into SN_num_solfolios from AL_SOLFOLIOS_TO a
           where a.cod_tipdocum=EN_cod_tipdocum and a.resolucion=EV_resolucion
             and a.cod_estadosol<>CV_anulada;
       exception
       when no_data_found then
            SN_num_solfolios:=0;
       end;
       if SN_num_solfolios > 0 then
          if EV_accion=CV_modificar and SN_num_solfolios=EN_num_solfolios then
             null;
          else
             SN_cod_retorno:=2770; --'La Resolucion ingresada existe para el Documento en la solicitud número:'
             RAISE le_error_validacion;
          end if;
       end if;

      --Se valida que la fecha de resolucion sea la misma si es que ya existe una,,,
      begin
        LV_fecres:=NULL;
        ln_num_folios:=0;
        LV_sSql:='Select to_char(a.fec_resolucion,''dd/mm/yyyy'') ,a.num_solfolios into LV_fecres,ln_num_folios from AL_SOLFOLIOS_TO a'||
                 ' Where a.resolucion='''||EV_resolucion||''' and a.num_solfolios <> '|| NVL(EN_num_solfolios, -1) || ' and a.cod_estadosol<>'''||CV_anulada||
                 ''' and rownum=1';
        Select to_char(a.fec_resolucion,'dd/mm/yyyy'),a.num_solfolios into LV_fecres,ln_num_folios
          from AL_SOLFOLIOS_TO a
         Where a.resolucion=EV_resolucion and a.num_solfolios <> NVL(EN_num_solfolios,-1) and a.cod_estadosol<>CV_anulada and rownum=1;

         if LV_fecres <> EV_fec_resolucion then
              SN_cod_retorno:=2771; --'La fecha de Resolucion ingresada no corresponde con la fecha de la Resolucion existente',
              RAISE le_error_validacion;
       end if;
      exception
      when no_data_found then
           null;
      end;

     --Validar en cambio de etiqueta o serie según operadora debe iniciar rango en 1.....
     LN_rango_hasta:=0;
     if EV_etiqueta IS NOT NULL then
       --Al ingresar una nueva etiqueta para documento-resolución-serie el "Inicio de Rango" debe ser 1.
         LV_sSql:='Select nvl(max(rango_hasta),0) INTO LN_rango_hasta '||
                  ' from AL_SOLFOLIOS_TO a where a.cod_tipdocum='||EN_cod_tipdocum||
                  ' and  a.etiqueta='''||EV_etiqueta||''' and cod_estadosol<>'''||CV_anulada||'';
         Select nvl(max(rango_hasta),0) INTO LN_rango_hasta
           from AL_SOLFOLIOS_TO a where a.cod_tipdocum=EN_cod_tipdocum
            and  a.serie = EV_serie AND a.etiqueta=EV_etiqueta and cod_estadosol<>CV_anulada;
         if LN_rango_hasta = 0 and EN_inicio_rango  <> 1 then
            SN_cod_retorno:=2773;--'Dado que la Etiqueta no existe para el Documento debe iniciar el rango de folios en 1.
            RAISE le_error_validacion;
         end if;

      else
       --Al ingresar una nueva serie para documento-resolución el "Inicio de Rango" debe ser 1.
         LV_sSql:='Select nvl(max(a.rango_hasta),0) INTO ln_rango_hasta '||
                  ' from AL_SOLFOLIOS_TO a where a.cod_tipdocum='||EN_cod_tipdocum||
                  ' and a.serie='''||EV_serie||''' and a.cod_estadosol<>'''||CV_anulada||'';
         Select nvl(max(a.rango_hasta),0) INTO ln_rango_hasta
           from AL_SOLFOLIOS_TO a where a.cod_tipdocum=EN_cod_tipdocum
            and a.serie=EV_serie and a.cod_estadosol<>CV_anulada;

         if LN_rango_hasta = 0 and EN_inicio_rango  <> 1 then
            SN_cod_retorno:=2774;--'Dado que la SERIE no existe para el Documento debe iniciar el rango de folios en 1.
            RAISE le_error_validacion;
         end if;

      end if;

    if EV_accion=CV_insertar then
        --Validar que rangos sean consecutivos...
         if LN_rango_hasta > 0 then
            LN_rango_desde_sgte:=LN_rango_hasta+1;
            if EN_inicio_rango <>LN_rango_desde_sgte  then
                 SN_num_solfolios:=LN_rango_desde_sgte;
                 SN_cod_retorno:= 2775;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
                RAISE le_error_validacion;
            end if;
         end if;
     else --modificar....
        --Obtener el rango anterior al k esta modificando....
         ln_rango_hasta:=0;
         if EV_etiqueta IS NOT NULL then
             LV_sSql:='Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a'||
                      ' where a.num_solfolios<'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||' and a.etiqueta='||EV_etiqueta||
                      ' and a.serie='||EV_serie||' and a.cod_estadosol<>'||CV_anulada;
             Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a
               where a.num_solfolios<EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum and a.etiqueta=EV_etiqueta
                and a.serie=EV_serie and a.cod_estadosol<>CV_anulada;
         else
              LV_sSql:='Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a'||
                      ' where a.num_solfolios<'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||
                      ' and a.serie='||EV_serie||' and a.cod_estadosol<>'||CV_anulada;
             Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a
               where a.num_solfolios<EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum
                and a.serie=EV_serie and a.cod_estadosol<>CV_anulada;

         end if;

         if ln_rango_hasta =0 then
           --Validar si el folio no existe para el documento comience en 1 ....
            if EN_inicio_rango <>1 then
               SN_cod_retorno:=2776;  --'No existen solicitudes de folios para el Documento. Por tanto debe iniciar el rango en 1
               RAISE le_error_validacion;
            end if;
         else
           --Si existe validar que sean consecutivos....
            if EN_inicio_rango <>ln_rango_hasta+1 then
               SN_num_solfolios:=ln_rango_hasta+1;
               SN_cod_retorno:= 2775;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
               RAISE le_error_validacion;
            end if;
         end if;

         --Obtener rango posterior al que esta modificando...
         ln_rango_desde:=0;
         begin
             if EV_etiqueta IS NOT NULL then
                 LV_sSql:='Select nvl(a.rango_desde,0) into ln_rango_desde from AL_SOLFOLIOS_TO a'||
                          ' where a.num_solfolios>'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||' and a.etiqueta='||EV_etiqueta||
                          ' and a.serie='||EV_serie||' and a.cod_estadosol<>'||CV_anulada||' and rownum=1';
                 Select nvl(a.rango_desde,0) into ln_rango_desde from AL_SOLFOLIOS_TO a
                   where a.num_solfolios>EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum and a.etiqueta=EV_etiqueta
                    and a.serie=EV_serie and a.cod_estadosol<>CV_anulada and rownum=1;
             else
                  LV_sSql:='Select nvl(a.rango_desde,0) into ln_rango_desde from AL_SOLFOLIOS_TO a'||
                          ' where a.num_solfolios<'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||
                          ' and a.serie='||EV_serie||' and a.cod_estadosol<>'||CV_anulada||' and rownum=1';
                 Select nvl(a.rango_desde,0) into ln_rango_desde from AL_SOLFOLIOS_TO a
                   where a.num_solfolios>EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum
                    and a.serie=EV_serie and a.cod_estadosol<>CV_anulada and rownum=1;

             end if;
         exception
         when no_data_found then
              ln_rango_desde:=0;
         end;

         if ln_rango_desde > 0 then
           --Si existe validar que sean consecutivos....
            if EN_fin_rango <>ln_rango_desde-1 then
               SN_num_solfolios:=ln_rango_desde-1;
               SN_cod_retorno:= 2777;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
               RAISE le_error_validacion;
            end if;
         end if;

     end if;

     ---Se valida que no exista solapamiento de rangos
      ln_num_folios:=0;
      if EV_etiqueta IS NOT NULL then
         LV_sSql:='Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a '||
                  'where a.cod_tipdocum='||EN_cod_tipdocum||'and a.serie='''||EV_serie ||''||
                  ' and a.etiqueta='''||EV_etiqueta||'''  and '||
                  ' (('||EN_inicio_rango||'  between a.rango_desde and a.rango_hasta) or ('||EN_fin_rango||' between a.rango_desde and a.rango_hasta))'||
                  '  and a.cod_estadosol<>'''||CV_anulada||'';
         Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a
        where a.cod_tipdocum=EN_cod_tipdocum
            and a.serie=EV_serie and a.etiqueta=EV_etiqueta and
               ((EN_inicio_rango  between a.rango_desde and a.rango_hasta) or (EN_fin_rango between a.rango_desde and a.rango_hasta))
           and a.cod_estadosol<>CV_anulada;

      else
           LV_sSql:='Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a '||
               ' where cod_tipdocum='||EN_cod_tipdocum||' and serie='''||EV_serie||''' and '||
               '  (('||EN_inicio_rango||'  between rango_desde and rango_hasta) or ('||EN_fin_rango||' between rango_desde and rango_hasta))'||
               ' and cod_estadosol<>'''||CV_anulada||'';
           Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a
            where cod_tipdocum=EN_cod_tipdocum  and serie=EV_serie and
                  ((EN_inicio_rango  between rango_desde and rango_hasta) or (EN_fin_rango between rango_desde and rango_hasta))
                  and cod_estadosol<>CV_anulada;
      end if;

       if ln_num_folios > 0  then
             if EV_accion=CV_modificar and LN_num_folios=EN_num_solfolios then
                null;
             else
                SN_cod_retorno:=2772;--'Existe solapamiento de rangos con otras solicitudes para el Documento.'
                RAISE le_error_validacion;
             end if;
      end if;



else
     if EV_accion=CV_insertar then
         --Validar si el folio no existe para el documento comience en 1 ....
         LN_rango_hasta:=0;
         LV_sSql:='Select nvl(max(rango_hasta),0) INTO LN_rango_hasta '||
                   'from AL_SOLFOLIOS_TO a where a.cod_tipdocum='||EN_cod_tipdocum||' and cod_estadosol<>'||CV_anulada;
          Select nvl(max(a.rango_hasta),0) INTO LN_rango_hasta
             from AL_SOLFOLIOS_TO a where a.cod_tipdocum=EN_cod_tipdocum and cod_estadosol<>CV_anulada;
          if LN_rango_hasta=0 and EN_inicio_rango  <> 1 then
             SN_cod_retorno:=2776;  --'No existen solicitudes de folios para el Documento. Por tanto debe iniciar el rango en 1
             RAISE le_error_validacion;
          end if;

          --Validar que los folios sean consecutivos....
          if LN_rango_hasta > 0 then
             LN_rango_desde_sgte:=LN_rango_hasta+1;
             if EN_inicio_rango <>LN_rango_desde_sgte then
                SN_num_solfolios:=LN_rango_desde_sgte;
                SN_cod_retorno:= 2775;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
                RAISE le_error_validacion;
             end if;
          end if;

     else ---esta modificando.....
        --Obtener el rango anterior al k esta modificando....
        LV_sSql:='Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a'||
           ' where a.num_solfolios<'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||' and a.cod_estadosol<>'||CV_anulada;
         ln_rango_hasta:=0;
         Select nvl(max(a.rango_hasta),0) into ln_rango_hasta from AL_SOLFOLIOS_TO a
           where a.num_solfolios<EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum and a.cod_estadosol<>CV_anulada;
         if ln_rango_hasta =0 then
           --Validar si el folio no existe para el documento comience en 1 ....
            if EN_inicio_rango <>1 then
               SN_cod_retorno:=2776;  --'No existen solicitudes de folios para el Documento. Por tanto debe iniciar el rango en 1
               RAISE le_error_validacion;
            end if;
         else
           --Si existe validar que sean consecutivos....
            if EN_inicio_rango <>ln_rango_hasta+1 then
               SN_num_solfolios:=ln_rango_hasta+1;
               SN_cod_retorno:= 2775;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
               RAISE le_error_validacion;
            end if;
         end if;

         --Obtener rango posterior al que esta modificando...
         ln_rango_desde:=0;
         LV_sSql:='Select a.rango_desde into ln_rango_desde from AL_SOLFOLIOS_TO a '||
           'where a.num_solfolios>'||EN_num_solfolios||' and a.cod_tipdocum='||EN_cod_tipdocum||' and a.cod_estadosol<>'||CV_anulada||' and rownum=1';
         begin
           Select a.rango_desde into ln_rango_desde from AL_SOLFOLIOS_TO a
           where a.num_solfolios>EN_num_solfolios and a.cod_tipdocum=EN_cod_tipdocum and a.cod_estadosol<>CV_anulada and rownum=1;
         exception
         when no_data_found then
              ln_rango_desde:=0;
         end;
         if ln_rango_desde > 0 then
           --Si existe validar que sean consecutivos....
            if EN_fin_rango <>ln_rango_desde-1 then
               SN_num_solfolios:=ln_rango_desde-1;
               SN_cod_retorno:= 2777;  --''El rango de folios debe ser consecutivo a los existentes. Debe comenzar en
               RAISE le_error_validacion;
            end if;
         end if;

    end if;
   ---Se valida que no exista solapamiento de rangos
   ln_num_folios:=0;
   LV_sSql:='Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a '||
              'where a.cod_tipdocum='||EN_cod_tipdocum||' and '||
           '(('||EN_inicio_rango||'  between a.rango_desde and a.rango_hasta) or ('||EN_fin_rango||' between a.rango_desde and a.rango_hasta))'||
           ' and a.cod_estadosol<>'''||CV_anulada||'';
   Select nvl(max(a.num_solfolios),0)  into  ln_num_folios from AL_SOLFOLIOS_TO a
   where a.cod_tipdocum=EN_cod_tipdocum and
       ((EN_inicio_rango  between a.rango_desde and a.rango_hasta) or (EN_fin_rango between a.rango_desde and a.rango_hasta))
    and a.cod_estadosol<>CV_anulada;

    if ln_num_folios > 0  then
             if EV_accion=CV_modificar and LN_num_folios=EN_num_solfolios then
                null;
             else
                SN_cod_retorno:=2772;--'Existe solapamiento de rangos con otras solicitudes para el Documento.'
                RAISE le_error_validacion;
             end if;
    end if;




end if;

exception
when le_error_validacion then
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('le_error_validacion: AL_VALIDAR_FOLIOS_PR('||EN_cod_tipdocum||','||EV_resolucion||','||EV_fec_resolucion||','||EV_Serie||','||EV_etiqueta||','||','||EN_inicio_rango||','||EN_fin_rango||','||EV_operadora||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_FOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
when others then
    SN_cod_retorno := '156'; --No es posible ejecutar este servicio.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_VALIDAR_FOLIOS_PR('||EN_cod_tipdocum||','||EV_resolucion||','||EV_fec_resolucion||','||EV_Serie||','||EV_etiqueta||','||','||EN_inicio_rango||','||EN_fin_rango||','||EV_operadora||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_FOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_VALIDAR_FOLIOS_PR;
------------------------------------------------------------------------
procedure AL_UPD_ESTADOASIGDOCT_PR (
EN_num_solfolios    IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EV_cod_estado       IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

       LV_sSql:='update AL_ASIG_DOCUMENTOST a set '||
                 ' a.cod_estadosol='||EV_cod_estado ||
                 ' where a.num_solfolios='||EN_num_solfolios;
       update AL_ASIG_DOCUMENTOST a set  a.cod_estadosol=EV_cod_estado
             where a.num_solfolios=EN_num_solfolios;


exception
when others then
    SN_cod_retorno := 2; --No se pudo actualizar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_UPD_ESTADOASIGDOCT_PR('||EN_num_solfolios||','||EV_cod_estado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_UPD_ESTADOASIGDOCT_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_UPD_ESTADOASIGDOCT_PR;
------------------------------------------------------------------------
procedure AL_UPD_ESTADOSOLFOLIOS_PR (
EN_num_solfolios    IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EV_cod_estado       IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
EV_usuario          IN AL_SOLFOLIOS_TO.usuario_crea%TYPE,
EV_observacion      IN AL_SOLFOLIOS_TO.observacion %TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

    if EV_cod_estado=CV_anulada then
         LV_sSql:='update AL_SOLFOLIOS_TO a set a.usuario_anula='||EV_usuario||','||
               'a.fec_anula=sysdate,a.observacion='||EV_observacion||','||
               'a.cod_estadosol='||EV_cod_Estado||
               'where a.num_solfolios='||EN_num_solfolios;
          update AL_SOLFOLIOS_TO a set a.usuario_anula= EV_usuario,
               a.fec_anula=sysdate,a.observacion=EV_observacion,
               a.cod_estadosol=EV_cod_Estado
               where a.num_solfolios=EN_num_solfolios;

    else
       LV_sSql:='update AL_SOLFOLIOS_TO a set '||
                 ' a.usuario_actualiza='||EV_usuario||',a.fec_actualiza=sysdate, a.cod_estadosol='||EV_cod_estado ||
                 ' where a.num_solfolios='||EN_num_solfolios;
       update AL_SOLFOLIOS_TO a set
             a.usuario_actualiza= EV_usuario, a.fec_actualiza=sysdate, a.cod_estadosol=EV_cod_estado
             where a.num_solfolios=EN_num_solfolios;
    end if;

exception
when others then
    SN_cod_retorno := 2; --No se pudo actualizar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_UPD_ESTADOSOLFOLIOS_PR('||EN_num_solfolios||','||EV_cod_estado||','||EV_usuario||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_UPD_ESTADOSOLFOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_UPD_ESTADOSOLFOLIOS_PR;
-----------------------------------------------------------------------
procedure AL_INS_SOLFOLIOS_PR (
EV_cod_oficina      IN AL_SOLFOLIOS_TO.cod_oficina%TYPE,
EV_cod_opera        IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EN_cod_tipdocum     IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_resolucion       IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion   IN varchar2,
EV_serie            IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta         IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango     IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango        IN AL_SOLFOLIOS_TO.rango_HASTA%TYPE,
EV_cod_estado       IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
EV_usuario_crea     IN AL_SOLFOLIOS_TO.usuario_crea%TYPE,
SN_num_solfolios    OUT NOCOPY AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
LV_resolucion        AL_SOLFOLIOS_TO.resolucion%TYPE;
LV_fec_resolucion    varchar2(10);
LV_serie             AL_SOLFOLIOS_TO.serie%TYPE;
LV_etiqueta          AL_SOLFOLIOS_TO.etiqueta%TYPE;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   SN_num_solfolios:=0;
    LV_resolucion:=EV_resolucion;
    if LV_resolucion='' then
       LV_resolucion:=NULL;
    end if;
    LV_fec_resolucion:=EV_fec_resolucion;
    if LV_fec_resolucion='' then
       LV_fec_resolucion:=NULL;
    end if;
    LV_serie:=EV_serie;
    if LV_serie='' then
       LV_serie:=NULL;
    end if;
    LV_etiqueta:=EV_etiqueta;
    if LV_etiqueta='' then
       LV_etiqueta:=NULL;
    end if;

    LV_sSql:='INSERT INTO AL_SOLFOLIOS_TO (Num_solfolios, cod_oficina, cod_tipdocum, cod_operadora, resolucion,'||
             'fec_resolucion,serie,etiqueta,rango_desde,rango_hasta, cod_estadosol, usuario_crea,fec_crea)'||
             ' Values (AL_SOLFOLIOS_SQ.NEXTVAL,'||EV_cod_oficina||','||EN_cod_tipdocum||','||EV_cod_opera||','||LV_resolucion||','||
             ' to_date('||EV_fec_resolucion||',''dd/mm/yyyy''),'||LV_serie||','||LV_etiqueta||','||EN_inicio_rango||
             ','||EN_fin_rango||','||EV_cod_estado||','||EV_usuario_crea||',sysdate)'||
             'RETURNING Num_solfolios INTO SN_num_solfolios';

    INSERT INTO AL_SOLFOLIOS_TO (Num_solfolios, cod_oficina, cod_tipdocum, cod_operadora, resolucion,
           fec_resolucion,serie,etiqueta,rango_desde,rango_hasta, cod_estadosol, usuario_crea,fec_crea)
    Values (AL_SOLFOLIOS_SQ.NEXTVAL,EV_cod_oficina,EN_cod_tipdocum,EV_cod_opera,LV_resolucion,
           to_date(LV_fec_resolucion,'dd/mm/yyyy'),LV_serie,LV_etiqueta,EN_inicio_rango,EN_fin_rango,EV_cod_estado,EV_usuario_crea,sysdate)
    RETURNING Num_solfolios INTO SN_num_solfolios;


exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_SOLFOLIOS_PR('||EV_cod_opera||','||EN_cod_tipdocum||','||EV_resolucion||','||EV_fec_resolucion||','||EV_Serie||','||EV_etiqueta||','||','||EN_inicio_rango||','||EN_fin_rango||','||EV_cod_estado||','||EV_usuario_crea||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_SOLFOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_SOLFOLIOS_PR;
------------------------------------------------------------------------
procedure AL_INS_ASIGDOCT_PR (
EN_numsolfolios    IN AL_ASIG_DOCUMENTOST.num_solfolios%TYPE,
EV_cod_oficina     IN AL_ASIG_DOCUMENTOST.cod_oficina%TYPE,
EN_cod_tipdocum    IN AL_ASIG_DOCUMENTOST.cod_tipdocum%TYPE,
EN_ran_desde       IN AL_ASIG_DOCUMENTOST.ran_desde%TYPE,
EN_ran_hasta       IN AL_ASIG_DOCUMENTOST.ran_hasta%TYPE,
EV_pref_plaza      IN AL_ASIG_DOCUMENTOST.pref_plaza%TYPE,
EV_cod_operadora   IN AL_ASIG_DOCUMENTOST.cod_operadora%TYPE,
EV_resolucion      IN AL_ASIG_DOCUMENTOST.resolucion%TYPE,
EV_fec_resolucion  IN varchar2,
EV_serie           IN AL_ASIG_DOCUMENTOST.serie%TYPE,
EV_etiqueta        IN AL_ASIG_DOCUMENTOST.etiqueta%TYPE,
EV_cod_estadosol   IN AL_ASIG_DOCUMENTOST.cod_estadosol%TYPE,
EV_fec_creafolio   IN varchar2,
SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='INSERT INTO AL_ASIG_DOCUMENTOST (COD_OFICINA,COD_TIPDOCUM,FEC_ASIGNA,RAN_DESDE,'||
           'RAN_HASTA,RAN_USADO,TIP_MOVIMIENTO,TIP_STOCK,COD_BODEGA,COD_ARTICULO,'||
           'COD_USO,COD_ESTADO,NUM_CANTIDAD,NUM_DESDE,NUM_HASTA,COD_TRANSACCION,'||
           'PREF_PLAZA,COD_OPERADORA,RESOLUCION,FEC_RESOLUCION,'||
           'SERIE,ETIQUETA,FEC_CREAFOLIO,'||
           'NUM_SOLFOLIOS,COD_ESTADOSOL)'||
           ' VALUES ('||EV_cod_oficina||','||EN_cod_tipdocum||',sysdate,'||EN_ran_desde||','||
           EN_ran_hasta||',NULL,NULL,NULL,NULL,NULL,'||
           'NULL,NULL,NULL,NULL,NULL,NULL,'||
           EV_pref_plaza||','||EV_cod_operadora||','||EV_resolucion||','||EV_fec_resolucion||','||
           EV_serie||','||EV_etiqueta||','||EV_fec_creafolio||','||
           EN_numsolfolios||','||EV_cod_estadosol||')';

     INSERT INTO AL_ASIG_DOCUMENTOST (COD_OFICINA,COD_TIPDOCUM,FEC_ASIGNA,RAN_DESDE,
           RAN_HASTA,RAN_USADO,
           PREF_PLAZA,COD_OPERADORA,RESOLUCION,FEC_RESOLUCION,
           SERIE,ETIQUETA,FEC_CREAFOLIO,
           NUM_SOLFOLIOS,COD_ESTADOSOL)
   VALUES (EV_cod_oficina,EN_cod_tipdocum,sysdate,EN_ran_desde,
--           EN_ran_hasta,0,EV_pref_plaza,EV_cod_operadora,EV_resolucion,to_date(EV_fec_resolucion,'dd/mm/yyyy'), inc. 149620, ZMH 28-10-2010
           EN_ran_hasta,(EN_ran_desde - 1),EV_pref_plaza,EV_cod_operadora,EV_resolucion,to_date(EV_fec_resolucion,'dd/mm/yyyy'),
           EV_serie,EV_etiqueta,to_date(EV_fec_creafolio,'dd/mm/yyyy hh24:mi:ss'),
           EN_numsolfolios, EV_cod_estadosol);


exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_ASIGDOCT_PR('||EN_numsolfolios||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_ASIGDOCT_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_ASIGDOCT_PR;
------------------------------------------------------------------------
procedure AL_INS_ASIGDOCUMENTO_PR (
EN_numsolfolios    IN AL_ASIG_DOCUMENTOST.num_solfolios%TYPE,
EV_cod_oficina     IN AL_ASIG_DOCUMENTOST.cod_oficina%TYPE,
EN_cod_tipdocum    IN AL_ASIG_DOCUMENTOST.cod_tipdocum%TYPE,
EN_ran_desde       IN AL_ASIG_DOCUMENTOST.ran_desde%TYPE,
EN_ran_hasta       IN AL_ASIG_DOCUMENTOST.ran_hasta%TYPE,
EN_ran_usado       IN AL_ASIG_DOCUMENTOST.ran_usado%TYPE,
EV_pref_plaza      IN AL_ASIG_DOCUMENTOST.pref_plaza%TYPE,
EV_cod_operadora   IN AL_ASIG_DOCUMENTOST.cod_operadora%TYPE,
EV_resolucion      IN AL_ASIG_DOCUMENTOST.resolucion%TYPE,
EV_fec_resolucion  IN varchar2,
EV_serie           IN AL_ASIG_DOCUMENTOST.serie%TYPE,
EV_etiqueta        IN AL_ASIG_DOCUMENTOST.etiqueta%TYPE,
EV_fec_creafolio   IN varchar2,
EV_tipofol         IN VARCHAR2,
SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

    LV_sSql:='INSERT INTO AL_ASIG_DOCUMENTOS (COD_OFICINA,COD_TIPDOCUM,FEC_ASIGNA,RAN_DESDE,'||
            ' RAN_HASTA,RAN_USADO,COD_VENDEDOR,IND_CONSUMO,'||
            'PREF_PLAZA,COD_OPERADORA,RESOLUCION,FEC_RESOLUCION,'||
            'SERIE,ETIQUETA,FEC_CREAFOLIO,'||
            'NUM_SOLFOLIOS)'||
            'VALUES('||EV_cod_oficina||','||EN_cod_tipdocum||',sysdate,'||EN_ran_desde||','||
             EN_ran_hasta||','||EN_ran_usado||',NULL,'||EV_tipofol||','||
             EV_pref_plaza||','||EV_cod_operadora||','||EV_resolucion||',to_date('||EV_fec_resolucion||',''dd/mm/yyyy''),'||
             EV_serie||','||EV_etiqueta||',to_date('||EV_fec_creafolio||',''dd/mm/yyyy hh24:mi:ss''),'||
             EN_numsolfolios||')';

     INSERT INTO AL_ASIG_DOCUMENTOS (COD_OFICINA,COD_TIPDOCUM,FEC_ASIGNA,RAN_DESDE,
           RAN_HASTA,RAN_USADO,COD_VENDEDOR,IND_CONSUMO,
           PREF_PLAZA,COD_OPERADORA,RESOLUCION,FEC_RESOLUCION,
           SERIE,ETIQUETA,FEC_CREAFOLIO,
           NUM_SOLFOLIOS)
     VALUES (EV_cod_oficina,EN_cod_tipdocum,sysdate,EN_ran_desde,
             EN_ran_hasta,EN_ran_usado,NULL,EV_tipofol,
             EV_pref_plaza,EV_cod_operadora,EV_resolucion,to_date(EV_fec_resolucion,'dd/mm/yyyy'),
             EV_serie,EV_etiqueta,to_date(EV_fec_creafolio,'dd/mm/yyyy hh24:mi:ss'),
             EN_numsolfolios);


exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_ASIGDOCUMENTO_PR('||EN_numsolfolios||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_ASIGDOCUMENTO_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_ASIGDOCUMENTO_PR;
----------------------------------------------------------------------
procedure AL_DEL_ASIGDOCT_PR (
EN_num_solfolios  IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) is

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   LV_sSql:='Delete from AL_ASIG_DOCUMENTOST a where  a.num_solfolios='||EN_num_solfolios;
   Delete from AL_ASIG_DOCUMENTOST a where  a.num_solfolios=EN_num_solfolios;
exception
when others then
    SN_cod_retorno := 3; --No se pudo eliminar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_DEL_ASIGDOCT ('||EN_num_solfolios||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_DEL_ASIGDOCT', LV_sSql, SQLCODE, LV_des_error );
end AL_DEL_ASIGDOCT_PR;
------------------------------------------------------------------------
procedure AL_UPD_SOLFOLIOS_PR (
EN_num_solfolios  IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
EN_cod_tipdocum   IN AL_SOLFOLIOS_TO.cod_tipdocum%TYPE,
EV_cod_oficina    IN AL_SOLFOLIOS_TO.cod_oficina%TYPE,
EV_resolucion     IN AL_SOLFOLIOS_TO.resolucion%TYPE,
EV_fec_resolucion IN VARCHAR2,
EV_serie          IN AL_SOLFOLIOS_TO.serie%TYPE,
EV_etiqueta       IN AL_SOLFOLIOS_TO.etiqueta%TYPE,
EN_inicio_rango   IN AL_SOLFOLIOS_TO.rango_desde%TYPE,
EN_fin_rango      IN AL_SOLFOLIOS_TO.rango_hasta%TYPE,
EV_cod_estado     IN AL_SOLFOLIOS_TO.cod_estadosol%TYPE,
EV_usuario        IN AL_SOLFOLIOS_TO.usuario_crea%TYPE,
EV_observacion    IN AL_SOLFOLIOS_TO.observacion %TYPE,
EV_accion         IN VARCHAR2,
EV_cod_operadora  IN AL_SOLFOLIOS_TO.cod_operadora%TYPE,
EV_fec_creafolio  IN VARCHAR2,
EV_pref_plaza     IN AL_ASIG_DOCUMENTOST.pref_plaza%TYPE,
EV_tipofol        IN VARCHAR2,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) is

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
LV_resolucion        AL_SOLFOLIOS_TO.resolucion%TYPE;
LV_fec_resolucion    varchar2(10);
LV_serie             AL_SOLFOLIOS_TO.serie%TYPE;
LV_etiqueta          AL_SOLFOLIOS_TO.etiqueta%TYPE;
LE_error             exception;
LV_pref_plaza        AL_ASIG_DOCUMENTOST.pref_plaza%TYPE;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

    LV_resolucion:=EV_resolucion;
    if LV_resolucion=' ' then
       LV_resolucion:=NULL;
    end if;
    LV_fec_resolucion:=EV_fec_resolucion;
    if LV_fec_resolucion=' ' then
       LV_fec_resolucion:=NULL;
    end if;
    LV_serie:=EV_serie;
    if LV_serie=' ' then
       LV_serie:=NULL;
    end if;
    LV_etiqueta:=EV_etiqueta;
    if LV_etiqueta=' ' then
       LV_etiqueta:=NULL;
    end if;


    case
    when EV_accion='M' then --modifica...
         LV_sSql:='update AL_SOLFOLIOS_TO a set '||
          'a.cod_tipdocum=EN_cod_tipdocum,a.resolucion='||LV_resolucion||','||
          'a.fec_resolucion=to_date('||LV_fec_resolucion||',''dd/mm/yyyy''), serie='||LV_serie||','||
          'a.etiqueta=LV_etiqueta,usuario_actualiza='||EV_usuario||', fec_actualiza=sysdate'||
          'where a.num_solfolios='||EN_num_solfolios;

         update AL_SOLFOLIOS_TO a set
          a.resolucion=LV_resolucion,
          a.fec_resolucion=to_date(LV_fec_resolucion, 'dd/mm/yyyy'), a.serie=LV_serie,
          a.etiqueta=LV_etiqueta,a.usuario_actualiza=EV_usuario, a.fec_actualiza=sysdate,a.rango_desde=EN_inicio_rango,
          a.rango_hasta=EN_fin_rango
         where a.num_solfolios=EN_num_solfolios;

    when EV_accion='A' then  --anula
         LV_sSql:='al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (('||EN_num_solfolios||','||EV_cod_Estado||','||EV_usuario||','||EV_observacion||')';
         al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (EN_num_solfolios,EV_cod_Estado,EV_usuario,EV_observacion,
                                                 SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
           raise LE_error;
         end if;

    when EV_accion='S' then --Asignar folios.....
      --1.- Obtener prefplaza
       LV_pref_plaza:=AL_DOCUMENTOS_PG.AL_PREF_DOCUMOFIC_FN(EV_cod_oficina,EN_cod_tipdocum,EN_num_solfolios);

       ---2.- Insertar en al_asig_documentost
       LV_sSql:='al_folios_pg.al_ins_asigdoct_pr('||EN_num_solfolios||','||EV_cod_oficina||','||EN_cod_tipdocum||','||EN_inicio_rango||','||EN_fin_rango||','||
                LV_pref_plaza||','||EV_cod_operadora||','||EV_resolucion||','||EV_fec_resolucion||','||
                EV_serie||','||EV_etiqueta||','||EV_cod_estado ||','||EV_fec_creafolio||','||
                'SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
       al_folios_pg.al_ins_asigdoct_pr (EN_num_solfolios,EV_cod_oficina,EN_cod_tipdocum,EN_inicio_rango,EN_fin_rango,
                LV_pref_plaza,EV_cod_operadora,EV_resolucion,EV_fec_resolucion,
                EV_serie,EV_etiqueta,EV_cod_estado,EV_fec_creafolio,
                SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
           raise LE_error;
        end if;

       --3.- Modificar estado  de la solicitud
         LV_sSql:='al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (('||EN_num_solfolios||','||EV_cod_Estado||','||EV_usuario||','||EV_observacion||')';
       al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (EN_num_solfolios,EV_cod_Estado,EV_usuario,EV_observacion,
                                               SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
          raise LE_error;
       end if;


   when EV_accion='R' then --Rechazar folios.....
      --1.- Eliminar registros desde AL_ASIG_DOCUMENTOST
       LV_sSql:='AL_DEL_ASIGDOCT_PR('||EN_num_solfolios||')';
       AL_DEL_ASIGDOCT_PR (EN_num_solfolios,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
           raise LE_error;
        end if;

      --2.- Cambiar estado de la solicitud...
        LV_sSql:='al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR('||EN_num_solfolios||','||EV_cod_Estado||','||EV_usuario||','||EV_observacion||')';
        al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (EN_num_solfolios,EV_cod_Estado,EV_usuario,EV_observacion,
                                               SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
          raise LE_error;
       end if;

   when EV_accion='D' then --Disponer folios.....
        --1.- Insertar en tabla al_asig_documentos
        LV_sSql:='al_folios_pg.AL_INS_ASIGDOCUMENTO_PR('||EN_num_solfolios||','||EV_cod_oficina||','||EN_cod_tipdocum||','||
        EN_inicio_rango||','||EN_fin_rango||',0,'||EV_pref_plaza||','||EV_cod_operadora||','||EV_resolucion||','||EV_fec_resolucion||','||
        EV_serie||','||EV_etiqueta||','||EV_fec_creafolio||','||EV_tipofol||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';

        al_folios_pg.AL_INS_ASIGDOCUMENTO_PR (EN_num_solfolios,EV_cod_oficina,EN_cod_tipdocum,
--               EN_inicio_rango,EN_fin_rango,0,EV_pref_plaza,EV_cod_operadora,EV_resolucion,EV_fec_resolucion, Inc. 149620, ZMH 28-10-2010
               EN_inicio_rango,EN_fin_rango,(EN_inicio_rango - 1),EV_pref_plaza,EV_cod_operadora,EV_resolucion,EV_fec_resolucion,
               EV_serie,EV_etiqueta,EV_fec_creafolio,EV_tipofol,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        if SN_cod_retorno<>0 then
          raise LE_error;
        end if;

        --2.- Modificar estado en al_asig_documentost....
        LV_sSql:='al_folios_pg.AL_UPD_ESTADOASIGDOCT_PR (('||EN_num_solfolios||','||EV_cod_Estado||')';
        al_folios_pg.AL_UPD_ESTADOASIGDOCT_PR (EN_num_solfolios,EV_cod_Estado,
                                               SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        if SN_cod_retorno<>0 then
          raise LE_error;
        end if;


        --3.- Modificar estado en al_solfolios_to....
        LV_sSql:='al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (('||EN_num_solfolios||','||EV_cod_Estado||','||EV_usuario||','||EV_observacion||')';
        al_folios_pg.AL_UPD_ESTADOSOLFOLIOS_PR (EN_num_solfolios,EV_cod_Estado,EV_usuario,EV_observacion,
                                               SN_cod_retorno,SV_mens_retorno,SN_num_evento);
       if SN_cod_retorno<>0 then
          raise LE_error;
       end if;
   end case;

exception
when LE_error then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('le_error: AL_UPD_SOLFOLIOS_PR('||EN_num_solfolios||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_UPD_SOLFOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );

when others then
    SN_cod_retorno := 2; --No se pudo actualizar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_UPD_SOLFOLIOS_PR('||EN_num_solfolios||','||EN_cod_tipdocum||','||EV_cod_oficina||','||EV_resolucion||','||EV_fec_resolucion||','||EV_Serie||','||EV_etiqueta||','||','||EN_inicio_rango||','||EN_fin_rango||','||EV_cod_estado||','||EV_usuario||','||EV_observacion||','||EV_accion||','||EV_fec_creafolio||','||EV_cod_operadora||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_UPD_SOLFOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_UPD_SOLFOLIOS_PR;
------------------------------------------------------------------------
procedure AL_DEL_SOLFOLIOS_PR (
EN_num_solfolios  IN AL_SOLFOLIOS_TO.num_solfolios%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) is

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin
   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   LV_sSql:='Delete from AL_SOLFOLIOS_TO a where  a.num_solfolios='||EN_num_solfolios;
   Delete from AL_SOLFOLIOS_TO a where  a.num_solfolios=EN_num_solfolios;
exception
when others then
    SN_cod_retorno := 3; --No se pudo eliminar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_DEL_SOLFOLIOS_PR ('||EN_num_solfolios||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_DEL_SOLFOLIOS_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_DEL_SOLFOLIOS_PR;
------------------------------------------------------------------------
procedure AL_INS_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_usuario           IN AL_TIPOS_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='INSERT INTO AL_TIPOS_DOCINF_TD (COD_TIPDOCUM_INF,DESC_DOCUM,FEC_CREA,USUARIO_CREA,FEC_ACTUALIZA,USUARIO_ACTUALIZA)'||
            ' VALUES ('||EV_cod_tipdocum_inf||','||EV_desc_docum||',sysdate,'||EV_usuario||',null,null)';

     INSERT INTO AL_TIPOS_DOCINF_TD (COD_TIPDOCUM_INF,DESC_DOCUM,FEC_CREA,USUARIO_CREA,FEC_ACTUALIZA,USUARIO_ACTUALIZA)
      VALUES (EV_cod_tipdocum_inf,EV_desc_docum,sysdate,EV_usuario,null,null);

exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_TIPOS_DOCINF_PR('||EV_cod_tipdocum_inf||','||EV_desc_docum||','||EV_usuario||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_TIPOS_DOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_TIPOS_DOCINF_PR;
------------------------------------------------------------------------
procedure AL_UPD_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_usuario           IN AL_TIPOS_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='UPDATE   AL_TIPOS_DOCINF_TD a'||
     ' SET   a.DESC_DOCUM='||EV_desc_docum||',a.FEC_ACTUALIZA=sysdate,a.USUARIO_ACTUALIZA='||EV_usuario||
     ' where a.cod_tipdocum_inf='||EV_cod_tipdocum_inf;

   UPDATE   AL_TIPOS_DOCINF_TD a
     SET   a.DESC_DOCUM=EV_desc_docum,a.FEC_ACTUALIZA=sysdate,a.USUARIO_ACTUALIZA=EV_usuario
     where a.cod_tipdocum_inf=EV_cod_tipdocum_inf;

exception
when others then
    SN_cod_retorno := 2; --No se pudo  modificar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_UPD_TIPOS_DOCINF_PR('||EV_cod_tipdocum_inf||','||EV_desc_docum||','||EV_usuario||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_UPD_TIPOS_DOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_UPD_TIPOS_DOCINF_PR;
------------------------------------------------------------------------
procedure AL_DEL_TIPOS_DOCINF_PR (
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='DELETE FROM AL_TIPOS_DOCINF_TD a where a.cod_tipdocum_inf='||EV_cod_tipdocum_inf;
   DELETE FROM AL_TIPOS_DOCINF_TD a where a.cod_tipdocum_inf=EV_cod_tipdocum_inf;

exception
when others then
    SN_cod_retorno := 2; --No se pudo  modificar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_DEL_TIPOS_DOCINF_PR('||EV_cod_tipdocum_inf||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_DEL_TIPOS_DOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_DEL_TIPOS_DOCINF_PR;
------------------------------------------------------------------------
procedure AL_INS_RELDOCINF_PR (
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
EV_usuario          IN AL_REL_DOCINF_TD.USUARIO_CREA%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='INSERT INTO AL_REL_DOCINF_TD (COD_TIPDOCUM_INF,COD_TIPDOCUM,FEC_CREA,USUARIO_CREA,FEC_ACTUALIZA)'||
            ' VALUES ('||EV_cod_tipdocum_inf||','||EN_cod_tipdocum||',sysdate,'||EV_usuario||')';

     INSERT INTO AL_REL_DOCINF_TD (COD_TIPDOCUM_INF,COD_TIPDOCUM,FEC_CREA,USUARIO_CREA)
      VALUES (EV_cod_tipdocum_inf,EN_cod_tipdocum,sysdate,EV_usuario);

exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_RELDOCINF_PR('||EV_cod_tipdocum_inf||','||EN_cod_tipdocum||','||EV_usuario||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_RELDOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_RELDOCINF_PR;
------------------------------------------------------------------------
procedure AL_DEL_RELDOCINF_PR (
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) as

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='delete from AL_REL_DOCINF_TD a where a.cod_tipdocum_inf='||EV_cod_tipdocum_inf||
            ' and a.cod_tipdocum='||EN_cod_tipdocum;

     delete from AL_REL_DOCINF_TD a where a.cod_tipdocum_inf=EV_cod_tipdocum_inf
       and a.cod_tipdocum=EN_cod_tipdocum;

exception
when others then
    SN_cod_retorno := 3; --No se pudo eliminar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_DEL_RELDOCINF_PR('||EV_cod_tipdocum_inf||','||EN_cod_tipdocum||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_DEL_RELDOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_DEL_RELDOCINF_PR;

------------------------------------------------------------------------
procedure AL_VALIDAR_DOCINF_PR(
EV_cod_tipdocum_inf  IN AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EV_desc_docum        IN AL_TIPOS_DOCINF_TD.DESC_DOCUM%TYPE,
EV_accion            in varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as


LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
le_error_validacion  exception;
ln_existe            number(4);
LV_cod_tipdocum_inf  AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   if EV_accion=CV_insertar then
      ---verificar si codigo ya existe....
      LV_sSql:='select count(1) into LN_existe FROM AL_TIPOS_DOCINF_TD a where  a.cod_tipdocum_inf='||EV_cod_tipdocum_inf;
      select count(1) into LN_existe FROM AL_TIPOS_DOCINF_TD a where  a.cod_tipdocum_inf=EV_cod_tipdocum_inf;
      if LN_existe > 0 then
         SN_cod_retorno:=2780;  --El código de documento ingresado ya existe
         raise le_error_validacion;
      end if;
   end if;

   if EV_accion=CV_insertar OR EV_accion=CV_modificar then
       --verificar si descripcion ya existe...
       LV_cod_tipdocum_inf:=NULL;
       LV_sSql:='select count(1) into LV_cod_tipdocum_inf FROM AL_TIPOS_DOCINF_TD a where  UPPER(a.desc_docum)=UPPER('||EV_desc_docum||')';
       BEGIN
          select cod_tipdocum_inf into LV_cod_tipdocum_inf FROM AL_TIPOS_DOCINF_TD a where  UPPER(a.desc_docum)=UPPER(EV_desc_docum);
       EXCEPTION
       WHEN NO_DATA_FOUND THEN
            NULL;
       END;
       if LV_cod_tipdocum_inf IS NOT NULL  then
          IF EV_accion=CV_modificar AND LV_cod_tipdocum_inf = EV_cod_tipdocum_inf THEN
             NULL;
          ELSE
             SN_cod_retorno:=2781; --La descripcion del documento ingresada ya existe
             raise le_error_validacion;
          END IF;
       end if;
    end if;

    if EV_accion=CV_eliminar then
       --Verificar si tiene registros de relaciones...
       LV_sSql:='select count(1) into LN_existe FROM AL_REL_DOCINF_TD a where  a.cod_tipdocum_inf='||EV_cod_tipdocum_inf;
       select count(1) into LN_existe FROM AL_REL_DOCINF_TD a where  a.cod_tipdocum_inf=EV_cod_tipdocum_inf;
       if LN_existe > 0 then
          SN_cod_retorno:=2782;---'El documento a informar posee relación con algún documento SCL, no es posible eliminarlo.
          raise le_error_validacion;
       end if;
    end if;

exception
when le_error_validacion then
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('le_error_validacion: AL_VALIDAR_DOCINF_PR('||EV_cod_tipdocum_inf||','||EV_desc_docum||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_DOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
when others then
    SN_cod_retorno := 1; --No se pudo recuperar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_VALIDAR_DOCINF_PR('||EV_cod_tipdocum_inf||','||EV_desc_docum||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_DOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_VALIDAR_DOCINF_PR;
------------------------------------------------------------------------
procedure AL_VALIDAR_RELDOCINF_PR(
EV_cod_tipdocum_inf IN AL_REL_DOCINF_TD.COD_TIPDOCUM_INF%TYPE,
EN_cod_tipdocum     IN AL_REL_DOCINF_TD.COD_TIPDOCUM%TYPE,
EV_accion            in varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) as


LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;
le_error_validacion  exception;
ln_existe            number(4);
LV_cod_tipdocum_inf  AL_TIPOS_DOCINF_TD.COD_TIPDOCUM_INF%TYPE;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   if EV_accion=CV_insertar then
      ---verificar si la relacion ya existe....
      LV_sSql:='select count(1) into LN_existe FROM AL_TIPOS_DOCINF_TD a where  a.cod_tipdocum_inf='||EV_cod_tipdocum_inf||
               ' AND a.cod_tipdocum='||EN_cod_tipdocum;
      select count(1) into LN_existe FROM AL_REL_DOCINF_TD a where  a.cod_tipdocum_inf=EV_cod_tipdocum_inf
           AND a.cod_tipdocum=EN_cod_tipdocum;
      if LN_existe > 0 then
         SN_cod_retorno:=2778;  --La relación de documentos ingresada ya existe.
         raise le_error_validacion;
      end if;
   end if;


    if EV_accion=CV_eliminar then
       --Verificar si tiene solicitudes de folios....
       LV_sSql:='select count(1) into LN_existe FROM AL_SOLFOLIOS_TO a where  a.cod_tipdocum='||EN_cod_tipdocum||
                ' and a.cod_estadosol<>'||CV_anulada;
        select count(1) into LN_existe FROM AL_SOLFOLIOS_TO a
        where  a.cod_tipdocum=EN_cod_tipdocum and a.cod_estadosol<>CV_anulada;
       if LN_existe > 0 then
          SN_cod_retorno:=2779;---'El documento SCL posee solicitudes de folios. No es posible eliminar la relación de documentos.
          raise le_error_validacion;
       end if;
    end if;

exception
when le_error_validacion then
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('le_error_validacion: AL_VALIDAR_RELDOCINF_PR('||EV_cod_tipdocum_inf||','||EN_cod_tipdocum||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_RELDOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
when others then
    SN_cod_retorno := 1; --No se pudo recuperar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_VALIDAR_RELDOCINF_PR('||EV_cod_tipdocum_inf||','||EN_cod_tipdocum||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_VALIDAR_RELDOCINF_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_VALIDAR_RELDOCINF_PR;

------------------------------------------------------------------------
procedure AL_INS_CONS_DOCCONSUMIDO_PR (
EV_usuario          IN AL_CONS_FOLIOS_TO.nom_usuario%TYPE,
EV_observacion      IN AL_CONS_FOLIOS_TO.observacion%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) is

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql              ge_errores_pg.vQuery;

begin

   SV_mens_retorno:='';
   SN_cod_retorno:=0;
   SN_num_evento:=0;

   LV_sSql:='insert into AL_CONS_FOLIOS_TO  (nom_usuario,fecha,observacion)'||
            'values ('||EV_usuario||',sysdate,'||EV_observacion||')';

   insert into AL_CONS_FOLIOS_TO   (nom_usuario,fecha,observacion)
   values (EV_usuario,sysdate,EV_observacion);

exception
when others then
    SN_cod_retorno := 4; --No se pudo agregar datos.
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_INS_CONS_DOCCONSUMIDO_PR('||EV_usuario||','||EV_observacion||','||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_INS_CONS_DOCCONSUMIDO_PR', LV_sSql, SQLCODE, LV_des_error );
end AL_INS_CONS_DOCCONSUMIDO_PR;

PROCEDURE AL_OBTFOLIO_GUIA_PR (
EN_cod_bodega       IN al_series.cod_bodega%TYPE,
EV_operadora        IN varchar2,
SN_consume          OUT NOCOPY NUMBER,
SV_num_folio        OUT NOCOPY varchar2,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS

LN_ind_remision     al_tipos_bodegas.ind_remision%TYPE;
LE_error            EXCEPTION;
LV_coddoc           GED_PARAMETROS.val_parametro%TYPE;
LV_consume_folio    GED_PARAMETROS.val_parametro%TYPE;
LV_oficina          GED_PARAMETROS.val_parametro%TYPE;
LV_des_error        ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;
LV_folio            varchar2(1000);
LV_cadena           varchar2(1000);
TYPE t_varchar      IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
LV_resultado_folios t_varchar;
i                   number(2);
j                   number(5);

BEGIN

  SV_mens_retorno:='';
  SN_cod_retorno:=0;
  SN_num_evento:=0;
  SV_num_folio:=NULL;
  LN_ind_remision:=0;
  SN_Consume:=0;


  --Verifica si el tipo de bodega requiere guia de remision...
  LV_sSql:='selectnvl(b.ind_remision,0) into LN_ind_remision from al_bodegas a, al_tipos_bodegas b '||
           ' where a.cod_bodega='||EN_cod_bodega ||' and a.tip_bodega=b.tip_bodega';
  begin
   select nvl(b.ind_remision,0) into LN_ind_remision
     from al_bodegas a, al_tipos_bodegas b
    where a.cod_bodega=EN_cod_bodega and
          a.tip_bodega=b.tip_bodega;
  exception
  when others then
       LN_ind_remision:=0;
  end;

  if LN_ind_remision=1 then
     --Verificar si la operadora consume folio.....
      LV_consume_folio:=NULL;
      LV_sSql:='select trim(a.VAL_PARAMETRO) into LV_consume_folio FROM GED_PARAMETROS a'||
               ' where a.NOM_PARAMETRO=GUIA_CONSFOL AND a.COD_MODULO=AL AND a.COD_PRODUCTO=1';
      begin
          select trim(a.VAL_PARAMETRO) into LV_consume_folio
            FROM GED_PARAMETROS a
           where a.NOM_PARAMETRO= 'GUIA_CONSFOL' AND a.COD_MODULO='AL' AND a.COD_PRODUCTO=1;
      exception
      when others then
           null;
      end;

      IF LV_consume_folio='TRUE' then
         --Obtener oficina genérica para guía de remision....
         LV_coddoc:=NULL;
         LV_sSql:='SELECT trim(a.VAL_PARAMETRO) into LV_oficina FROM GED_PARAMETROS a '||
                  'where a.NOM_PARAMETRO=GUIA_OFICINA AND a.COD_MODULO=AL AND a.COD_PRODUCTO=1';
         BEGIN
           SELECT trim(a.VAL_PARAMETRO) into LV_oficina FROM GED_PARAMETROS a
            where a.NOM_PARAMETRO='GUIA_OFICINA'
              AND a.COD_MODULO='AL' AND a.COD_PRODUCTO=1;
         exception
         when OTHERS then
              SN_cod_retorno :=1362; --No es posible recuperar parametros generales;
              raise LE_error;
         end;

         --Obtener código de documento de guía de remisión
         LV_coddoc:=NULL;
         LV_sSql:='SELECT  trim(a.VAL_PARAMETRO) into LV_coddoc FROM GED_PARAMETROS a '||
                  'where a.NOM_PARAMETRO=GUIA_CODDOC AND a.COD_MODULO=AL AND a.COD_PRODUCTO=1';

         BEGIN
           SELECT  trim(a.VAL_PARAMETRO) into LV_coddoc FROM GED_PARAMETROS a
            where a.NOM_PARAMETRO='GUIA_CODDOC' AND a.COD_MODULO='AL' AND a.COD_PRODUCTO=1;
         exception
         when OTHERS then
              SN_cod_retorno :=1362; --No es posible recuperar parametros generales;
              raise LE_error;
         end;

         --Obtener folio....
         LV_folio:=NULL;
         LV_sSql:='LV_folio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN('||LV_coddoc||',null,'||LV_oficina||','||EV_operadora||',0,null,null,sysdate,null)';
         begin
            LV_folio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(LV_coddoc,null,LV_oficina,EV_operadora,0,null,null,sysdate,null);
         exception
         when others then
              SN_cod_retorno := 2837; --No ha sido posible recuperar un folio....
              raise LE_error;
         end;
         -- serie, etiqueta y secuencia, separados por el carácter "-" (guión).
         if LV_folio is not null then
            LV_cadena:=LV_folio;
            for i in 1 .. 9 loop
                j:=instr(LV_cadena,';');
                if j>0 then
                   LV_resultado_folios(i):=trim(substr(LV_cadena,1,j-1));
                   LV_cadena:=substr(LV_cadena,j+1,length(LV_cadena)-1);
                else
                  LV_resultado_folios(i):='';
                end if;

            end loop;
            SV_num_folio:= LV_resultado_folios(5);
            if trim(LV_resultado_folios(6))<>''  or trim(LV_resultado_folios(6)) is not null then
                SV_num_folio:= SV_num_folio||'-'||LV_resultado_folios(6);
            end if;
            if trim(SV_num_folio)<>'' or trim(SV_num_folio) is not null then
                SV_num_folio:= SV_num_folio||'-'||LV_resultado_folios(3);
            else
                SV_num_folio:=LV_resultado_folios(3);
            end if;
        end if;
        SN_consume:=1;
      else
        SN_consume:=0;
      end if;
  else
     SN_consume:=2;
  end if;


EXCEPTION
WHEN LE_error THEN
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('le_error: AL_OBTFOLIO_GUIA_PR('||EN_cod_bodega||','||EV_operadora||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_OBTFOLIO_GUIA_PR', LV_sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
    SN_cod_retorno := 2837;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: AL_OBTFOLIO_GUIA_PR('||EN_cod_bodega||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'AL_OBTFOLIO_GUIA_PR', LV_sSql, SQLCODE, LV_des_error );
END AL_OBTFOLIO_GUIA_PR;

END al_folios_pg; 
/
SHOW ERROR