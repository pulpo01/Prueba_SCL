CREATE OR REPLACE package body pv_audi_detllama_pg as

 procedure pv_regis_audidetllam_pr(              eo_nom_usuario          in ge_seg_usuario.nom_usuario%type,
                                                 eo_cod_vendedor         in ge_seg_usuario.cod_vendedor%type,  
                                                 eo_cod_oficina          in ge_seg_usuario.cod_oficina%type,
                                                 eo_cod_cliente          in ga_abocel.cod_cliente%type,       
                                                 eo_num_abonado          in ga_abocel.num_abonado%type,
                                                 eo_rango_ini            in varchar2,
                                                 eo_rango_fin            in varchar2,
                                                 eo_ind_consulta         in number,
                                                 eo_cod_os               in varchar2,
                                                 sn_cod_retorno          out nocopy  ge_errores_td.cod_msgerror%type,
                                                 sv_mens_retorno         out nocopy  ge_errores_td.det_msgerror%type,
                                                 sn_num_evento           out nocopy  ge_errores_pg.evento)
is
 /*
 <documentación
   tipodoc = "procedure">>
    <elemento
       nombre = "pv_regis_audidetllam_pr"
       lenguaje="pl/sql"
       fecha="07-05-2009"
       versión="la del package"
       diseñador="orlando cabezas"
       programador="orlando cabezas"
       ambiente desarrollo="bd">
       <retorno>n/a</retorno>>
       <descripción></descripción>>
       <parámetros>
          <entrada>
             <param nom="eo_nom_usuario"   tipo="caracter">usuario  <param>>
             <param nom="eo_cod_vendedor"  tipo="numerico">codigo vendedor<param>>
             <param nom="eo_cod_oficina    tipo="numerico">codigo oficina<param>>
             <param nom="eo_cod_cliente "  tipo="numerico">codigo cliente<param>>
             <param nom="eo_num_abonado    tipo="numerico">numero abonado<param>>
             <param nom="eo_rango_ini      tipo="numerico">codigo oficina<param>>
             <param nom="eo_rango_fin "    tipo="numerico">codigo cliente<param>>
             <param nom=" eo_ind_consulta  tipo="numerico">numero abonado<param>>
             <param nom=" eo_icod_os       tipo="numerico">numero abonado<param>>
             
             
          </entrada>
          <salida>
             <param nom="sn_cod_retorno" tipo="numerico">codigo de retorno</param>>
             <param nom="sv_mens_retorno" tipo="caracter">mensaje de retorno</param>>
             <param nom="sn_num_evento" tipo="numerico">numero de evento</param>>
          </salida>
       </parámetros>
    </elemento>
 </documentación>
 */

 lv_des_error     ge_errores_pg.desevent;
 lv_ssql          ge_errores_pg.vquery;
 lv_cod_situacion ga_abocel.cod_situacion%type;
 lv_num_celular   ga_abocel.NUM_CELULAR%type;
 ld_rango_ini     date;
 ld_rango_fin     date;
 
 

pragma autonomous_transaction;
begin
    
    sn_cod_retorno  := 0;
    sv_mens_retorno := null;
    sn_num_evento   := 0;
 
    ld_rango_ini    :=to_date(eo_rango_ini,'dd-mm-yyyy hh24:mi:ss');
    ld_rango_fin    :=to_date(eo_rango_fin,'dd-mm-yyyy hh24:mi:ss');   
    
    select  num_celular,cod_situacion
    into 
    lv_num_celular, lv_cod_situacion
    from ga_abocel
    where 
    num_abonado= eo_num_abonado;
    
    
    insert into pv_audidetllam_th
    (num_abonado    ,  cod_cliente    ,  num_celular    ,  cod_situacion ,
     nom_usuarora   ,  cod_vendedor   ,  cod_oficina    ,  fec_solicitud  ,
     rango_ini      ,  rango_ter      ,  ind_factur     ,  cod_os)
     values
     (
        eo_num_abonado          ,
        eo_cod_cliente          ,
        lv_num_celular          ,
        lv_cod_situacion        ,
        eo_nom_usuario          ,
        eo_cod_vendedor         ,  
        eo_cod_oficina          ,
        sysdate                 ,                                
        ld_rango_ini            ,
        ld_rango_fin            ,
        eo_ind_consulta         ,
        eo_cod_os 
     );          
                                                    
    commit;                                 
                                                   
exception                                               
                when others then                        
                         sn_cod_retorno := 156;             
                         if not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) then
                                      sv_mens_retorno := cv_error_no_clasif;
                         end if;                        
                                                    
                         lv_des_error   := 'PV_AUDI_DETLLAMA_PG.PV_REGIS_AUDIDETLLAM_PR( ';
                         lv_des_error   := lv_des_error ||   eo_nom_usuario      || ',' ;
                         lv_des_error   := lv_des_error ||   eo_cod_vendedor     || ',' ;
                         lv_des_error   := lv_des_error ||   eo_cod_oficina      || ',' ;
                         lv_des_error   := lv_des_error ||   eo_cod_cliente      || ',' ;
                         lv_des_error   := lv_des_error ||   eo_num_abonado      || ',' ;
                         lv_des_error   := lv_des_error ||   ld_rango_ini        || ',' ;
                         lv_des_error   := lv_des_error ||   ld_rango_fin        || ',' ;
                         lv_des_error   := lv_des_error ||   eo_ind_consulta     || ',' ;
                         lv_des_error   := lv_des_error ||   eo_cod_os           || ',' ;
                         lv_des_error   := lv_des_error ||   sn_cod_retorno      || ',' ;
                         lv_des_error   := lv_des_error ||   sv_mens_retorno     || ',' ;
                         lv_des_error   := lv_des_error ||   sn_num_evento       || ',' ;
                         lv_des_error   := lv_des_error ||  ')' ||sqlerrm;
                            
                         sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, user, 'pv_audi_detllama_pg.pv_regis_audidetllam_pr', lv_ssql, sn_cod_retorno, lv_des_error );

end pv_regis_audidetllam_pr;
end pv_audi_detllama_pg; 
/
SHOW ERRORS