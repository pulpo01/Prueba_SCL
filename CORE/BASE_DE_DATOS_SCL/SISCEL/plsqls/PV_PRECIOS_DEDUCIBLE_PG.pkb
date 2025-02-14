CREATE OR REPLACE PACKAGE BODY PV_PRECIOS_DEDUCIBLE_PG AS

function pv_existe_articulo_fn (en_codarticulo    IN AL_articulos.COD_articulo%type) return boolean
AS
ln_existe number;
begin
  ln_existe:=0;
  begin
      select 1 into ln_existe from al_articulos where cod_articulo=en_codarticulo;
  exception
  when others then
       return false;
  end;
  if ln_existe>=1 then
     return true;
  end if;

end;

function pv_existe_moneda_fn (ev_codmoneda    IN GE_MONEDAS.COD_moneda%type) return boolean
AS
ln_existe number;
begin
  ln_existe:=0;
  begin
      select 1 into ln_existe from ge_monedas where cod_moneda=ev_codmoneda;
  exception
  when others then
       return false;
  end;
  if ln_existe>=1 then
     return true;
  end if;

end;
function pv_existe_reg_fn (en_codarticulo    IN  al_articulos.cod_articulo%type,
ev_codmoneda    IN GE_MONEDAS.COD_moneda%type,
ed_fecha_desde  IN al_precios_deducible_to.fec_desde%type) return boolean
AS
ln_existe   number;
begin
  ln_existe:=0;
  begin
      select 1 into ln_existe from al_precios_deducible_to
       where cod_articulo=en_codarticulo and cod_moneda=ev_codmoneda
         and fec_desde = ed_fecha_desde;
  exception
  when others then
       return false;
  end;
  return true;
end;

function pv_existe_solapamiento_fn (en_codarticulo    IN  al_articulos.cod_articulo%type,
ev_codmoneda    IN GE_MONEDAS.COD_moneda%type,
ed_fecha        IN al_precios_deducible_to.fec_desde%type,
ed_fecha_desde  IN al_precios_deducible_to.fec_desde%type) return boolean
AS
ln_existe number;
begin
      ln_existe:=0;

     begin 
         select 1 into ln_existe from al_precios_deducible_to
       where cod_articulo=en_codarticulo and cod_moneda=ev_codmoneda
         and fec_desde <> ed_fecha_desde
         and ed_fecha between fec_desde and fec_hasta;
     exception
     when others then 
          return false;
     end;
     return true;
end;

PROCEDURE PV_VALIDAR_ARCHIVO_PR(ENCarga         IN AL_PRECIOS_DEDUCIBLE_MAS_TO.COD_PROCESO%type,
sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) is

LB_EXISTE         BOOLEAN;
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
 
cursor cur_test (ENCarga in number) is
       SELECT  b.rowid,b.cod_articulo,b.cod_moneda,b.prc_deducible,b.fec_desde
        FROM AL_PRECIOS_DEDUCIBLE_MAS_TD B
       WHERE b.cod_proceso=ENCarga;
    
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

   tab_rowid.delete;
   tab_articulo.delete;
   tab_moneda.delete;   
   tab_precio.delete;     
   tab_fecha.delete;     
   tab_obs.delete;   
   LV_sSql:='open cur_test(ENCarga);';
   open cur_test(ENCarga);
   loop
        LV_sSql:='fetch cur_test bulk collect';
        fetch cur_test bulk collect into tab_rowid,
                                         tab_articulo,
                                         tab_Moneda,
                                         tab_Precio,tab_Fecha limit 100;
        exit when tab_rowid.count=0;
        
        LV_sSql:='FOR i  IN 1 ..tab_rowid.count loop';
        FOR i  IN 1 ..tab_rowid.count loop
                --Validar articulo
                 LV_sSql:='lb_existe:=pv_existe_articulo_fn(tab_Articulo(i)) :'||tab_Articulo(i);
                 lb_existe:=pv_existe_articulo_fn(tab_Articulo(i));
                 if not lb_existe then
                    tab_obs(i):= 'Articulo no existe';
                 else
                     --Validar  moneda
                     LV_sSql:='lb_existe:=pv_existe_moneda_fn(tab_MONEDA(i)) :'||tab_moneda(i);
                     lb_existe:=pv_existe_moneda_fn(tab_Moneda(i));
                     if not lb_existe then
                        tab_obs(i):='Moneda no existe';
                     else
                        tab_obs(i):='OK';
                     END IF; 
                 end if;
        end loop;

       LV_sSql:='forall i in 1..tab_rowid.count';
       forall i in 1..tab_rowid.count
           update al_precios_deducible_mas_td set observacion = tab_obs(i) where rowid = tab_rowid(i);
       commit;
       tab_rowid.delete;
       tab_articulo.delete;
       tab_moneda.delete;   
       tab_precio.delete;     
       tab_fecha.delete;     
       tab_obs.delete; 
   end loop;
   close cur_test;
     
EXCEPTION
WHEN OTHERS THEN
    SN_cod_retorno:=156;
    LV_des_error   :=SUBSTR('PV_MASIVO_PRECIOS_DEDUCIBLE_PR'||' - '||SQLERRM,1,250);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,250) || LV_des_error;   
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV',SV_mens_retorno,'1.0' , USER, 'PV_PRECIOS_DEDUCIBLE_PG.PV_VALIDAR_ARCHIVO_PR', LV_sSql, SN_cod_retorno, SV_mens_retorno );
END PV_VALIDAR_ARCHIVO_PR;



PROCEDURE PV_MASIVO_PRECIOS_DEDUCIBLE_PR(EVNombreArchivo IN AL_PRECIOS_DEDUCIBLE_MAS_TO.NOM_ARCHIVO%type,
                                     ENCarga         IN AL_PRECIOS_DEDUCIBLE_MAS_TO.COD_PROCESO%type,
                                     ev_usuario      IN AL_PRECIOS_DEDUCIBLE_MAS_TO.NOM_USUARIO%type,
                                     sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) is
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    LBDHayDatos       Boolean:=TRUE;
    LBRetorno         Boolean;
    indice            number;
    iInd              number := 1;
    
    LB_EXISTE         BOOLEAN;
    Lv_obs            al_precios_deducible_mas_td.OBSERVACION%TYPE;
    le_error          exception;
    ld_fec            al_precios_deducible_mas_td.fec_desde%TYPE;
    ln_rowid         urowid ;
    le_lee_otro      exception;
    ld_fec_desde     al_precios_deducible_to.fec_desde%TYPE;
    ld_fec_hasta     al_precios_deducible_to.fec_desde%TYPE;
    ld_fecha         al_precios_deducible_to.fec_desde%TYPE;
    ld_fecha_fin     al_precios_deducible_to.fec_desde%TYPE;
    ln_procesado     al_precios_deducible_mas_to.IND_PROCESO%type;
    
     cursor cur_carga (ENCarga in number) is
       SELECT  b.rowid,prc_deducible,b.fec_desde,b.cod_articulo,b.cod_moneda,b.observacion
        FROM AL_PRECIOS_DEDUCIBLE_MAS_TD B
       WHERE b.cod_proceso=ENCarga and b.observacion='OK';
    
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
    ld_fecha_fin:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');

    LV_sSql:='select ind_proceso into ln_procesado from al_precios_deducible_mas_to where cod_proceso='||ENCarga;   
    begin
      select ind_proceso into ln_procesado from al_precios_deducible_mas_to where cod_proceso=ENCarga;
    exception
    when others then
         raise error_controlado;
    end;
    
    if ln_procesado=1 then
       SN_cod_retorno := 156;
       LV_sSql:= 'El archivo ya fue procesado.';
       raise error_controlado;
    end if;
    
    
    LV_sSql:='PV_VALIDAR_ARCHIVO_PR('||ENcarga||',SN_cod_retorno,SN_num_evento,SV_mens_retorno);';
    PV_VALIDAR_ARCHIVO_PR(ENcarga,SN_cod_retorno,SN_num_evento,SV_mens_retorno);
    if  SN_cod_retorno<> 0 then
        raise error_controlado;
    end if;  
    
   tab_rowid.delete;
   tab_precio.delete;     
   tab_fecha.delete;     
   tab_articulo.delete;
   tab_moneda.delete;
   tab_obs.delete;   
   LV_sSql:='open cur_carga(ENCarga);';
   open cur_carga(ENCarga);
   loop
        LV_sSql:='fetch cur_test bulk collect';
        fetch cur_carga bulk collect into tab_rowid,
                                         tab_Precio,tab_Fecha,tab_articulo,tab_moneda,tab_obs limit 100;
        exit when tab_rowid.count=0;
        
        LV_sSql:='FOR i  IN 1 ..tab_rowid.count loop';
        FOR i  IN 1 ..tab_rowid.count loop
        begin
             tab_obs(i):=null;
             ld_fec_hasta:=null;
             LV_sSql:='if pv_existe_reg_fn ('||tab_articulo(i)||','||tab_moneda(i)||','||tab_fecha(i)||') then';
             if pv_existe_reg_fn (tab_articulo(i),tab_moneda(i),tab_fecha(i)) then
                begin
                      update AL_PRECIOS_DEDUCIBLE_TO set prc_deducible=tab_precio(i)
                       where cod_articulo=tab_articulo(i) and cod_moneda=tab_moneda(i) and
                             fec_desde=tab_fecha(i);
                      tab_obs(i):='OK.Registro modificado';
                exception
                when others then
                     tab_obs(i):='Error al modificar precio.';
                end; 
             else   
                 LV_sSql:='select max(fec_desde),max(fec_hasta) into ld_fec_desde,ld_fec_hasta '||
                          ' from AL_PRECIOS_DEDUCIBLE_TO where cod_articulo='||tab_articulo(i)||' and cod_moneda='''||tab_moneda(i)||'';
                 begin
                    select max(fec_desde),max(fec_hasta) into ld_fec_desde,ld_fec_hasta 
                     from AL_PRECIOS_DEDUCIBLE_TO 
                    where cod_articulo=tab_articulo(i) and cod_moneda=tab_moneda(i);

                    if ld_fec_hasta is null then
                       LV_sSql:='1.insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)';
                       BEGIN
                          insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)
                              values(tab_articulo(i),tab_moneda(i),tab_fecha(i),ld_fecha_fin,tab_precio(i),EV_usuario);
                          tab_obs(i):='OK.Registro ingresado';
                        
                       EXCEPTION
                       WHEN OTHERS THEN
                           tab_obs(i):='Error al insertar precio.';
                       END;
                    else
                       IF tab_fecha(i) = ld_fec_hasta then
                          tab_obs(i):='Error, existe solapamiento en otras fechas.';
                       else
                           if tab_fecha(i) > ld_fec_hasta then
                               LV_sSql:='2.insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)';
                              BEGIN
                                  insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)
                                      values(tab_articulo(i),tab_moneda(i),tab_fecha(i),ld_fecha_fin,tab_precio(i),EV_usuario);
                                  tab_obs(i):='OK.Registro ingresado';
                                
                               EXCEPTION
                               WHEN OTHERS THEN
                                   tab_obs(i):='Error al insertar precio.';
                               END;
                           else
                                if pv_existe_solapamiento_fn (tab_articulo(i),tab_moneda(i),tab_fecha(i),tab_fecha(i)) then
                                   tab_obs(i):='Error, existe solapamiento en otras fechas.';
                                else
                                    ld_fec_desde:=ld_fec_desde-(1/86400);
                                    if ld_fec_desde > tab_fecha(i) then
                                       LV_sSql:='3.insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)';
                                       BEGIN
                                          insert into AL_PRECIOS_DEDUCIBLE_TO (cod_articulo,cod_moneda,fec_desde,fec_hasta,prc_deducible,nom_usuario)
                                              values(tab_articulo(i),tab_moneda(i),tab_fecha(i),ld_fec_desde,tab_precio(i),EV_usuario);
                                          tab_obs(i):='OK.Registro ingresado';
                                            
                                       EXCEPTION
                                       WHEN OTHERS THEN
                                           tab_obs(i):='Error al insertar precio.';
                                       END;
                                        
                                    else
                                       tab_obs(i):='Error, existe solapamiento en otras fechas.';
                                    end if;
                                end if;
                           end if;
                       end if;
                    end if;

                 exception
                 when others  then
                      tab_obs(i):='Error al leer al_precios_deducible_to.';
                 end;
             end if;
            
                         
        exception
        when le_lee_otro then
             null;
        end;     
        end loop;


       LV_sSql:='forall i in 1..tab_rowid.count';
       forall i in 1..tab_rowid.count
           update al_precios_deducible_mas_td set observacion = tab_obs(i) where rowid = tab_rowid(i);
       commit;

       tab_rowid.delete;
       tab_precio.delete;     
       tab_fecha.delete;     
       tab_articulo.delete;
       tab_moneda.delete;
       tab_obs.delete;   

   end loop;
   close cur_carga;
   
   UPDATE AL_PRECIOS_DEDUCIBLE_MAS_TO SET IND_proceso=1 
   WHERE COD_PROCESO=ENCarga;     
   commit;
     
EXCEPTION
WHEN ERROR_CONTROLADO THEN
    LV_des_error   :=SUBSTR('PV_MASIVO_PRECIOS_DEDUCIBLE_PR'||' - '||SQLERRM,1,250);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,250) || LV_des_error;   
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV',SV_mens_retorno,'1.0' , USER, 'PV_PRECIOS_DEDUCIBLE_PG.PV_MASIVO_PRECIOS_DEDUCIBLE_PR', LV_sSql, SN_cod_retorno, SV_mens_retorno );

WHEN others THEN
    LV_des_error   :=SUBSTR('others-PV_MASIVO_PRECIOS_DEDUCIBLE_PR'||' - '||SQLERRM,1,250);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,250) || LV_des_error;   
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV',SV_mens_retorno,'1.0' , USER, 'PV_PRECIOS_DEDUCIBLE_PG.PV_MASIVO_PRECIOS_DEDUCIBLE_PR', LV_sSql, SN_cod_retorno, SV_mens_retorno );
  END PV_MASIVO_PRECIOS_DEDUCIBLE_PR;


END PV_PRECIOS_DEDUCIBLE_PG;
/
SHOW ERRORS