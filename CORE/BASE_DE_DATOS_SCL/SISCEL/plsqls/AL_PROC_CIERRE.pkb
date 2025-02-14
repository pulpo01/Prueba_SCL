CREATE OR REPLACE PACKAGE BODY AL_PROC_CIERRE IS
  PROCEDURE p_cierre(
  v_intercierre IN OUT al_intercierre%rowtype ,
  v_cierre IN varchar2 ,
  v_mes_cierre IN date ,
  v_new_ejer IN OUT al_cierres_alma.fec_inicio%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                        v_ini_ejer       al_cierres_alma.fec_inicio%type;
                        v_fin_ejer       al_cierres_alma.fec_fin%type;
                        v_ult_mes        al_cierres_alma.mes_cierre%type;
                        v_mes_forzado    date;
                        v_dia            al_datos_generales.dia_afijo_mes%type;
                        v_moneda_val     ge_monedas.cod_moneda%type;
                        v_decim          ge_monedas.num_decimal%type;
                      BEGIN
                        p_bloqueo_tablas (v_intercierre.cod_retorno,
                                          v_intercierre.des_cadena);
                        if v_intercierre.cod_retorno <> 0 then
                           raise exception_error;
                        end if;
                        al_pac_validaciones.p_obtiene_moneda(v_moneda_val);
                        al_pac_validaciones.p_decimales(v_moneda_val,
                                                        v_decim);
                        p_obtiene_ejercicio(v_ini_ejer,
                                            v_fin_ejer,
                                            v_ult_mes,
                                            v_intercierre.cod_retorno,
                                            v_intercierre.des_cadena,
                                                                                        v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                        if v_intercierre.cod_retorno <> 0 then
                           raise exception_error;
                        end if;
                        p_obtiene_dia (v_dia,
                                       v_intercierre.cod_retorno,
                                       v_intercierre.des_cadena);
                        if v_intercierre.cod_retorno <> 0 then
                           raise exception_error;
                        end if;
                        if v_ult_mes is null then
                           v_ult_mes := add_months(v_ini_ejer,-1);
                        end if;
                        if add_months(v_ult_mes,1) < v_mes_cierre then
                           v_mes_forzado    := v_ult_mes;
                           for i in 1..months_between(v_mes_cierre,
                               add_months(v_ult_mes,1)) loop
                               v_mes_forzado := add_months(v_mes_forzado,1);
                               p_calculo_pmp_afijo(v_mes_forzado,
                                                   v_cierre,
                                                   v_ini_ejer,
                                                   v_fin_ejer,
                                                   v_dia,
                                                   v_moneda_val,
                                                   v_decim,
                                                   v_intercierre.cod_retorno,
                                                   v_intercierre.des_cadena,
                                                                                                   v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                               if v_intercierre.cod_retorno <> 0 then
                                  raise exception_error;
                               end if;
                           end loop;
                        end if;
                        if v_cierre = 'A' then
                                     p_cierre_anual (v_mes_cierre,
                                           v_cierre,
                                           v_ini_ejer,
                                           v_fin_ejer,
                                           v_dia,
                                           v_moneda_val,
                                           v_decim,
                                           v_intercierre.cod_retorno,
                                           v_intercierre.des_cadena,
                                                                                   v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                   if v_intercierre.cod_retorno <> 0 then
                              raise exception_error;
                           end if;
                        else
                           p_calculo_pmp_afijo (v_mes_cierre,
                                                v_cierre,
                                                v_ini_ejer,
                                                v_fin_ejer,
                                                v_dia,
                                                v_moneda_val,
                                                v_decim,
                                                v_intercierre.cod_retorno,
                                                v_intercierre.des_cadena,
                                                                                                v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                           if v_intercierre.cod_retorno <> 0 then
                              raise exception_error;
                           end if;
                        end if;
                        p_update_cierres (v_ini_ejer,
                                          v_fin_ejer,
                                          v_mes_cierre,
                                          v_intercierre.cod_retorno,
                                          v_intercierre.des_cadena,
                                                                                  v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                        if v_intercierre.cod_retorno <> 0 then
                           raise exception_error;
                        end if;
                        if v_cierre = 'A' then
                             p_genera_ejercicio (v_fin_ejer,
                                               v_intercierre.cod_retorno,
                                               v_intercierre.des_cadena,
                                                                                           v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                           if v_intercierre.cod_retorno <> 0 then
                              raise exception_error;
                           end if;
                                   v_new_ejer := v_fin_ejer + 1;
                        end if;
                      EXCEPTION
                        when EXCEPTION_ERROR then
                             v_intercierre.cod_retorno := 1;
                        when OTHERS then
                           v_intercierre.cod_retorno := 1;
                           v_intercierre.des_cadena
                     := '/Error Obtencion Moneda y Decimales/';
                      END p_cierre;
  PROCEDURE p_calculo_pmp_afijo(
  v_mes_cierre IN date ,
  v_cierre IN varchar2 ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_dia IN al_datos_generales.dia_afijo_mes%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type )  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
      CURSOR c_afijo is
        select a.* from al_pmp_afijo a, al_series b, al_bodeganodo c, ge_operadora_scl d -- 30-12-2002 Modificacion multiempresa Ulises Uribe
        where a.fec_finafijo is null
         and nvl(a.num_meses,0) < mes_vida
         and a.mes_vida <> 0
         and trunc(a.fec_afijo,'MONTH') <= v_mes_cierre
                 and   a.num_serie = b.num_Serie
                 and b.cod_bodega = c.cod_bodega
                 and c.cod_bodeganodo = d.cod_bodeganodo
                 and d.cod_operadora_scl = v_operadora  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
        for update of prc_calculo;
        v_afijo       al_pmp_afijo%rowtype;
        v_ipc         v_rec_ipc;
        v_mes         v_rec_mes;
        v_mes_cal     date;
        v_acum        al_acum_pmp_afijo%rowtype;
        v_ipc_acum    number(9,4);
        v_nro         number(9) := 0;
       BEGIN
        v_nro := 0;
        p_obtiene_ipc (v_ini_ejer,
                       v_ipc,
                       v_mes,
                       v_nro,
                       v_error,
                       v_mensa);
        if v_error <> 0 then
         raise exception_error;
        end if;
        for v_afijo in c_afijo loop
         if v_afijo.fec_calculo is not null
            or
            (v_afijo.fec_calculo is null and
            to_number(to_char(v_afijo.fec_afijo,'dd')) > v_dia and
            trunc(v_afijo.fec_afijo,'MONTH') < v_mes_cierre)
            or
            (v_afijo.fec_calculo is null and
            to_number(to_char(v_afijo.fec_afijo,'dd')) <= v_dia)
           then
           if to_number(to_char(v_afijo.fec_afijo,'dd')) >= v_dia then
            v_mes_cal := trunc(add_months(v_afijo.fec_afijo,1)
                        ,'month');
           else
            v_mes_cal := trunc(v_afijo.fec_afijo,'month');
           end if;
           v_ipc_acum := 1;
           v_acum.num_activo := v_afijo.num_activo;
           v_acum.fec_calculo := v_mes_cierre;
           for i in 1..12 LOOP
            if i > v_nro then
             exit;
            end if;
           if v_mes(i) >= v_mes_cal
               and v_mes(i) <= v_mes_cierre then
            --  || ':' || to_char(v_ipc(i)));
            --  || ':' || to_char(v_mes(i)));
            v_ipc_acum := v_ipc_acum * ((v_ipc(i) / 100) + 1);
           end if;
           end LOOP;
           v_ipc_acum := (v_ipc_acum - 1) * 100;
           if v_ipc_acum is not null and
              v_ipc_acum <> 0 then
              v_acum.imp_correccion :=
              round((v_afijo.prc_actual * v_ipc_acum) / 100,v_decim);
              v_acum.imp_depreciacion :=
                        round(((v_afijo.prc_actual + v_acum.imp_correccion)
                        / v_afijo.mes_vida)
                  * (nvl(v_afijo.num_meses,0) + 1),v_decim);
              v_afijo.prc_calculo  := round((v_afijo.prc_actual
                                     + v_acum.imp_correccion)
                                     - v_acum.imp_depreciacion,v_decim);
              if v_afijo.num_meses + 1 = v_afijo.mes_vida then
                v_afijo.fec_finafijo := v_acum.fec_calculo;
                v_afijo.prc_actual   := 1;
              end if;
              if v_afijo.prc_calculo = 0 then
                v_afijo.fec_finafijo   := v_acum.fec_calculo;
                v_afijo.prc_actual     := 1;
              end if;
              if v_cierre = 'A' then
                v_afijo.prc_actual := v_afijo.prc_calculo;
              end if;
              p_inserta_acumulado(v_acum,
                                  v_error,
                                  v_mensa);
              if v_error <> 0 then
                raise exception_error;
              end if;
              update al_pmp_afijo
                 set num_meses = nvl(num_meses,0) + 1,
                     fec_finafijo = v_afijo.fec_finafijo,
                     prc_actual   = v_afijo.prc_actual,
                     prc_calculo  = v_afijo.prc_calculo,
                     fec_calculo  = v_mes_cal
               where current of c_afijo;
            end if;
           end if;
          end loop;
      EXCEPTION
        when EXCEPTION_ERROR then
              v_error := 1;
        when OTHERS then
              v_error := 1;
              v_mensa := '/Error Calculo Activo Fijo/';
    END p_calculo_pmp_afijo;
PROCEDURE p_cierre_anual(
  v_mes_cierre IN date ,
  v_cierre IN varchar2 ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_dia IN al_datos_generales.dia_afijo_mes%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                    BEGIN
                                p_borrado_nuevo (v_fin_ejer + 1,
                                          v_error,
                                          v_mensa,
                                                                                  v_operadora);
                         p_calculo_pmp_mercaderia(v_ini_ejer,
                                                  v_fin_ejer,
                                                  v_moneda_val,
                                                  v_decim,
                                                  v_error,
                                                  v_mensa,
                                                                                                  v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                         if v_error = 0 then
                            p_calculo_pmp_afijo (v_mes_cierre,
                                                 v_cierre,
                                                 v_ini_ejer,
                                                 v_fin_ejer,
                                                 v_dia,
                                                 v_moneda_val,
                                                 v_decim,
                                                 v_error,
                                                 v_mensa,
                                                                                                 v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                         end if;
                         if v_error = 0 then
                            p_paso_historico (v_ini_ejer,
                                              v_error,
                                              v_mensa,
                                                                                          v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                         end if;
  END p_cierre_anual;
  PROCEDURE p_obtiene_ipc(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_ipc IN OUT v_rec_ipc ,
  v_mes IN OUT v_rec_mes ,
  v_nro IN OUT number ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
                   CURSOR c_ipc is
                     select * from ge_ipc
                     where trunc(mes_ipc,'month') >= trunc(v_ini_ejer,'month')
                        and trunc(mes_ipc,'month') <= trunc(sysdate,'month')
                     order by mes_ipc;
                     vc_ipc ge_ipc%rowtype;
                     BEGIN
                        open c_ipc;
                        for i in 1..12 LOOP
                            fetch c_ipc into vc_ipc;
                            EXIT when c_ipc%NOTFOUND;
                            v_mes(i) := trunc(vc_ipc.mes_ipc,'month');
                            v_ipc(i) := vc_ipc.pct_ipc;
                            v_nro := i;
                        end LOOP;
                        close c_ipc;
                      EXCEPTION
                         when OTHERS then
                               if c_ipc%ISOPEN then
                                  close c_ipc;
                               end if;
                               v_error := 1;
                               v_mensa := '/Error Obtencisn IPC/';
                      END p_obtiene_ipc;
  PROCEDURE p_obtiene_dia(
  v_dia IN OUT al_datos_generales.dia_afijo_mes%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
                      BEGIN
                         select dia_afijo_mes
                           into v_dia
                                from al_datos_generales;
                      EXCEPTION
                         when OTHERS then
                              v_error := 1;
                              v_mensa := '/Error Obtencion Dia/';
                      END p_obtiene_dia;
  PROCEDURE p_inserta_acumulado(
  v_acum IN al_acum_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
  BEGIN
   insert into al_acum_pmp_afijo (num_activo,
               fec_calculo,
               imp_correccion,
               imp_depreciacion)
          values (v_acum.num_activo,
               v_acum.fec_calculo,
               v_acum.imp_correccion,
               v_acum.imp_depreciacion);
  EXCEPTION
    when OTHERS then
         v_error := 1;
         v_mensa := '/Error generacion acumulado A.Fijo/';
  END p_inserta_acumulado;
  PROCEDURE p_calculo_pmp_mercaderia(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                         CURSOR c_mercaderia IS
                                select cod_articulo from al_articulos
                                       order by cod_articulo;
                         v_articulo   al_articulos.cod_articulo%type;
                         v_fec_min    date;
                         v_fec_max    date;
                         v_fec_1er    date;
                         v_fec_2do    date;
                         v_existe_1o  number(1) := 0;
                         v_existe_2o  number(1) := 0;
                         v_existe_ant number(1) := 0;
                         v_ipc        v_rec_ipc;
                         v_mes        v_rec_mes;
                         v_nro        number;
                         v_pmp_merc   al_pmp_mercaderia%rowtype;
                         v_precio     al_pmp_mercaderia.prc_pmp%type;
                         v_error_s    number(1) := 0;
                         v_precio_act al_pmp_mercaderia.prc_pmp%type;
                         v_correccion number(15,2) := 0;
                      BEGIN
                                v_fec_1er := to_date('3105' ||
               to_char(v_ini_ejer,'yy'),'ddmmyy');
                         v_fec_2do := to_date('3112' ||
               to_char(v_ini_ejer,'yy'),'ddmmyy');
                         p_obtiene_ipc (v_ini_ejer,
                                        v_ipc,
                                        v_mes,
                                        v_nro,
                                        v_error,
                                        v_mensa);
                         if v_error = 0 then
                            OPEN c_mercaderia;
                            LOOP
                               fetch c_mercaderia into v_articulo;
                               EXIT when c_mercaderia%NOTFOUND;
                                         v_pmp_merc.prc_pmp := 0;
                                         v_pmp_merc.can_stock := 0;
                                         v_precio_act := 0;
                               p_sel_precio_act (v_articulo,
                                                 v_ini_ejer,
                                                 v_precio_act,
                                                                                                 v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                               p_sel_fecha_minima (v_articulo,
                                                   v_fec_min,
                                                   v_error_s,
                                                                                                   v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                               if v_error_s = 0  or
                                  v_fec_min is not null then
                                  p_mira_primer_trim (v_articulo,
                                                      v_fec_1er,
                                                      v_ini_ejer,
                                                      v_error_s,
                                                                                                          v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  if v_error_s = 0 then
                                     v_existe_1o := 1;
                                  else
                                     v_existe_1o := 0;
                                     v_error_s := 0;
                                  end if;
                                        p_mira_segundo_trim (v_articulo,
                                                       v_fec_1er,
                                                       v_fec_2do,
                                                       v_error_s,
                                                                                                           v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  if v_error_s = 0 then
                                     v_existe_2o := 1;
                                  else
                                     v_existe_2o := 0;
                                     v_error_s := 0;
                                  end if;
                                  if v_fec_min < v_ini_ejer then
                                     v_existe_ant := 1;
                                  else
                                     v_existe_ant := 0;
                                  end if;
                                  if v_existe_ant = 0 and
                                     v_existe_1o = 0 and
                                     v_existe_2o = 1 then
                                     p_select_max_precio (v_articulo,
                                                          v_fec_1er,
                                                          v_precio,
                                                          v_error_s,
                                                                                                                  v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  end if;
                                  if (v_existe_ant = 0 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 1)
                                  or (v_existe_ant = 1 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 1)
                                  or (v_existe_ant = 0 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 0)
                                  or (v_existe_ant = 1 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 0)
                                  or (v_existe_ant = 1 and
                                      v_existe_1o = 0 and
                                      v_existe_2o = 1) then
                                     p_select_max_precio (v_articulo,
                                                          v_ini_ejer,
                                                          v_precio,
                                                          v_error_s,
                                                                                                                  v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  end if;
                                  if v_existe_ant = 1 and
                                     v_existe_1o = 0 and
                                     v_existe_2o = 0 then
                                                 p_select_pmp_ant (v_articulo,
                                                       v_ini_ejer,
                                                       v_precio,
                                                                                                           v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  end if;
                                  v_pmp_merc.cod_articulo     := v_articulo;
                                  v_pmp_merc.fec_ejercicio    := v_fin_ejer + 1;
                                                                  v_pmp_merc.cod_operadora_scl:= v_operadora;    -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  p_select_can_stock (v_articulo,
                                                      v_pmp_merc.can_stock,
                                                                                                          v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  if (v_existe_ant = 0 and
                                      v_existe_1o = 0 and
                                      v_existe_2o = 1)
                                  or
                                     (v_existe_ant = 0 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 1)
                                  or
                                     (v_existe_ant = 1 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 1)
                                  or
                                     (v_existe_ant = 1 and
                                      v_existe_1o = 0 and
                                      v_existe_2o = 1)
                                  then
                                     v_pmp_merc.prc_pmp := v_precio;
                                  end if;
                                  if (v_existe_ant = 0 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 0)
                                  or (v_existe_ant = 1 and
                                      v_existe_1o = 1 and
                                      v_existe_2o = 0) then
                                     p_aplica_ipc (v_fec_1er + 1,
                                                   v_precio,
                                                   v_ipc,
                                                   v_mes,
                                                   v_nro,
                                                   v_pmp_merc.prc_pmp,
                                                   v_moneda_val,
                                                   v_decim,
                                                   v_error,
                                                   v_mensa);
                                     if v_error <> 0 then
                                        raise exception_error;
                                     end if;
                                  end if;
                                  if v_existe_ant = 1 and
                                     v_existe_1o = 0 and
                                     v_existe_2o = 0 then
                                     p_aplica_ipc (v_ini_ejer,
                                                   v_precio,
                                                   v_ipc,
                                                   v_mes,
                                                   v_nro,
                                                   v_pmp_merc.prc_pmp,
                                                   v_moneda_val,
                                                   v_decim,
                                                   v_error,
                                                   v_mensa);
                                     if v_error <> 0 then
                                        raise exception_error;
                                     end if;
                                  end if;
                                v_correccion := round((v_pmp_merc.prc_pmp * v_pmp_merc.can_stock) -
                                        (v_pmp_merc.can_stock * v_precio_act),v_decim);
                                  if v_pmp_merc.can_stock > 0 then
                                                        v_pmp_merc.prc_pmp := round(
                                                        ((v_pmp_merc.can_stock * v_precio_act)
                                                        + v_correccion) / v_pmp_merc.can_stock ,v_decim);
                                            else
                                                      v_pmp_merc.prc_pmp := 0;
                                            end if;
                                  p_inserta_pmp_mercaderia(v_pmp_merc,
                                                           v_error,
                                                           v_mensa);
                                  if v_error <> 0 then
                                     raise exception_error;
                                  end if;
                               end if;
                            end LOOP;
                            CLOSE c_mercaderia;
                         end if;
                      EXCEPTION
                         when EXCEPTION_ERROR then
                              if c_mercaderia%ISOPEN then
                                 close c_mercaderia;
                              end if;
                      END p_calculo_pmp_mercaderia;
  PROCEDURE p_sel_fecha_minima(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_min IN OUT date ,
  v_error IN OUT number ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select min(mes_compra) into v_fec_min
                               from al_compras_mercaderia
                                         where cod_articulo = v_articulo
                                         and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                      EXCEPTION
                        when OTHERS then
                                        v_error := 1;
                      END p_sel_fecha_minima;
  PROCEDURE p_mira_primer_trim(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_1er IN date ,
  v_ini_ejer IN date ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
  BEGIN
   select 0 into v_error
          from al_compras_mercaderia
          where cod_operadora_scl = v_operadora  and
                        cod_articulo = v_articulo and
                   rownum < 2 and
               mes_compra between v_ini_ejer and v_fec_1er;
  EXCEPTION
    when OTHERS then
         v_error := 1;
  END p_mira_primer_trim;
  PROCEDURE p_mira_segundo_trim(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_1er IN date ,
  v_fec_2do IN date ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select 0 into v_error
                               from al_compras_mercaderia
                               where cod_operadora_scl = v_operadora  and -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                                                 cod_articulo = v_articulo and
                                                 rownum < 2 and
                                     mes_compra between v_fec_1er and v_fec_2do;
                      EXCEPTION
                        when OTHERS then
                              v_error := 1;
                      END p_mira_segundo_trim;
  PROCEDURE p_select_max_precio(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_fecha IN al_compras_mercaderia.mes_compra%type ,
  v_precio IN OUT al_compras_mercaderia.prc_compra%type ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select nvl(max(prc_compra),0) into v_precio
                               from al_compras_mercaderia
                               where cod_operadora_scl = v_operadora -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                                             and cod_articulo = v_articulo
                                 and mes_compra > v_fecha;
                      EXCEPTION
                         when OTHERS then
                              v_error := 1;
                      END p_select_max_precio;
  PROCEDURE p_select_pmp_ant(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_precio IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select prc_pmp into v_precio
                               from al_pmp_mercaderia
                               where cod_articulo = v_articulo
                                                             and cod_operadora_scl = v_operadora -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                 and fec_ejercicio < v_ini_ejer
                                 and rownum = 1
                                 order by fec_ejercicio;
                      EXCEPTION
                        when OTHERS then
                             v_precio := 0;
                      END p_select_pmp_ant;
  PROCEDURE p_select_can_stock(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_stock IN OUT al_pmp_mercaderia.can_stock%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select can_stock into v_stock
                               from al_pmp_mercaderia
                               where cod_operadora_scl = v_operadora  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                                           and   cod_articulo = v_articulo
                                 and rownum = 1
                                 order by cod_articulo,
                                          fec_ejercicio desc;
                      EXCEPTION
                        when OTHERS then
                             v_stock := 0;
                      END p_select_can_stock;
  PROCEDURE p_aplica_ipc(
  v_fecha IN date ,
  v_precio IN al_pmp_mercaderia.prc_pmp%type ,
  v_ipc IN v_rec_ipc ,
  v_mes IN v_rec_mes ,
  v_nro IN number ,
  v_pmp IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
  v_acum_ipc number(9,4) := 1;
  BEGIN
    for i in 1..v_nro loop
        if v_mes(i) >= trunc(v_fecha,'MONTH') then
           v_acum_ipc := v_acum_ipc * ((v_ipc(i) / 100) + 1);
        end if;
    end loop;
    v_acum_ipc := (v_acum_ipc - 1) * 100 ;
    v_pmp := round(v_precio
             + ((v_precio * v_acum_ipc) / 100),v_decim);
    EXCEPTION
      when OTHERS then
        v_error := 1;
        v_mensa := '/Error Calculo IPC/';
    END p_aplica_ipc;
  PROCEDURE p_inserta_pmp_mercaderia(
  v_pmp_merc IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type)
  IS
    BEGIN
     insert into al_pmp_mercaderia (cod_articulo,
                                    fec_ejercicio,
                                                                        cod_operadora_scl, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                    can_stock,
                                    prc_pmp)
                              values (v_pmp_merc.cod_articulo,
                                     v_pmp_merc.fec_ejercicio,
                                                                         v_pmp_merc.cod_operadora_scl, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                     v_pmp_merc.can_stock,
                                     v_pmp_merc.prc_pmp
                                                                         );
    EXCEPTION
      when OTHERS then
        v_error := 1;
        v_mensa := '/Error creacion nuevo Precio Medio Compra/';
    END p_inserta_pmp_mercaderia;
  PROCEDURE p_obtiene_ejercicio(
  v_ini_ejer IN OUT al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN OUT al_cierres_alma.fec_fin%type ,
  v_ult_mes IN OUT al_cierres_alma.mes_cierre%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                         select fec_inicio,fec_fin,mes_cierre
                           into v_ini_ejer,v_fin_ejer,v_ult_mes
                           from al_cierres_alma
                          where ind_cerrado = 0
                                                   and cod_operadora_scl = v_operadora -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                            and rownum = 1
                          order by fec_inicio;
                      EXCEPTION
                         when OTHERS then
                              v_error := 1;
                              v_mensa := '/Error Obtencion Ejercicio/';
                      END p_obtiene_ejercicio;
  PROCEDURE p_update_cierres(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_mes IN al_cierres_alma.mes_cierre%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
    BEGIN
    if v_mes = trunc(v_fin_ejer,'MONTH') then
      update al_cierres_alma
       set mes_cierre = v_mes
          ,ind_cerrado = 1
          ,fec_fin_real = SYSDATE
         where fec_inicio = v_ini_ejer
                 and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
     else
      update al_cierres_alma
        set mes_cierre = v_mes
       where fec_inicio = v_ini_ejer
           and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
     end if;
     EXCEPTION
      when OTHERS then
       v_error := 1;
       v_mensa := '/Error Actualizacion Cierres/';
     END p_update_cierres;
  PROCEDURE p_genera_ejercicio(
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
     BEGIN
      insert into al_cierres_alma (fec_inicio,
                                  fec_fin,
                                                                  cod_operadora_scl, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  ind_cerrado,
                                  mes_cierre,
                                  fec_fin_real)
                               values (v_fin_ejer + 1,
                                  last_day(add_months(v_fin_ejer + 1,11)),
                                                                  v_operadora, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                  0,
                                  null,
                                  null);
                      EXCEPTION
                         when OTHERS then
                              v_error := 1;
                              v_mensa := '/Error Creacion Nuevo Ejercicio/';
                      END p_genera_ejercicio;
  PROCEDURE p_bloqueo_tablas(
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
                      BEGIN
                        LOCK TABLE al_stock
                             IN EXCLUSIVE MODE
                             NOWAIT;
                        LOCK TABLE al_series
                             IN EXCLUSIVE MODE
                             NOWAIT;
                      EXCEPTION
                        when OTHERS then
                             v_error := 1;
                             v_mensa := '/Error Bloqueo Tablas/';
                      END p_bloqueo_tablas;
  PROCEDURE p_paso_historico(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                        CURSOR c_acum is
                               select a.* from al_acum_pmp_afijo a,
                                                                         al_pmp_afijo b,
                                                                         al_series c,
                                                                                         al_bodeganodo d,
                                                                                         ge_operadora_scl e
                                                           where e.cod_operadora_scl = v_operadora
                                                             and a.num_activo         = b.num_activo
                                                                 and b.num_serie         = c.num_serie
                                                             and c.cod_bodega        = d.cod_bodega
                                                             and d.cod_bodeganodo    = e.cod_bodeganodo
                                 for update of a.num_activo;
                      BEGIN
                        for v_acum in c_acum loop
                            p_inserta_historico (v_acum,
                                                 v_ini_ejer,
                                                 v_error,
                                                 v_mensa);
                            if v_error <> 0 then
                               exit;
                            end if;
                            delete al_acum_pmp_afijo where current of c_acum;
                        end loop;
                        if c_acum%ISOPEN then
                           close c_acum;
                        end if;
                      EXCEPTION
                        when OTHERS then
                             if c_acum%ISOPEN then
                                close c_acum;
                             end if;
                             v_error := 1;
                             v_mensa := '/Error Borrado Acumulado/';
                      END p_paso_historico;
  PROCEDURE p_inserta_historico(
  v_acum IN al_acum_pmp_afijo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
  BEGIN
    insert into al_hacum_pmp_afijo (num_activo,
                fec_calculo,
                fec_ejercicio,
                imp_correccion,
                imp_depreciacion)
           values (v_acum.num_activo,
                  v_acum.fec_calculo,
                  v_ini_ejer,
                  v_acum.imp_correccion,
                  v_acum.imp_depreciacion);
  EXCEPTION
     when OTHERS then
          v_error := 1;
          v_mensa := '/Error Generacion Historico/';
  END p_inserta_historico;
  PROCEDURE p_borrado_nuevo(
  v_ejercicio IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                         delete al_pmp_mercaderia
                                where fec_ejercicio = v_ejercicio
                                                                and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                      EXCEPTION
                         when OTHERS then
                              v_error := 1;
                              v_mensa := '/Error Borrado PMC Nuevos/';
                      END p_borrado_nuevo;
  PROCEDURE p_sel_precio_act(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_precio IN OUT al_pmp_mercaderia.prc_pmp%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
                      BEGIN
                        select prc_pmp into v_precio
                               from al_pmp_mercaderia
                              where cod_articulo  = v_articulo
                                and fec_ejercicio = v_ini_ejer
                                                                and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                      EXCEPTION
                        when OTHERS then
                             v_precio := 0;
                      END p_sel_precio_act;
END AL_PROC_CIERRE;
/
SHOW ERRORS
