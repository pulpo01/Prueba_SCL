CREATE OR REPLACE PACKAGE BODY AL_PROC_CALPDTE IS
  PROCEDURE p_trata_movim(
  v_inter IN OUT al_intercierre%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type )
  IS
       CURSOR c_pdte is
                           select * from al_pdte_calculo
               for update of ind_valor_des
                   order by fec_movimiento;
       v_moneda_val      ge_monedas.cod_moneda%type;
       v_decim           ge_monedas.num_decimal%type;
       v_precio          al_pdte_calculo.prc_unidad%type;
       v_operadora       ge_operadora_scl.cod_operadora_scl%type;           -- 30-12-2002 Modificacion multiempresa Ulises Uribe
    BEGIN
         al_pac_validaciones.p_obtiene_moneda (v_moneda_val);
       al_pac_validaciones.p_decimales (v_moneda_val,
                                        v_decim);
       for v_pdte in c_pdte LOOP
               -- selecciono operadora por movimiento -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                   select d.cod_operadora_scl into v_operadora
                   from   al_pdte_calculo a, al_movimientos b,
                          al_bodeganodo c, ge_operadora_scl d
                   where  a.num_movimiento = v_pdte.num_movimiento
                   and    a.num_movimiento = b.num_movimiento
                   and    b.cod_bodega = c.cod_bodega
                   and    c.cod_bodeganodo = d.cod_bodeganodo;
           if v_pdte.cod_moneda <> v_moneda_val then
              al_pac_validaciones.p_convertir_precio (v_pdte.cod_moneda,
                                                      v_moneda_val,
                                                      v_pdte.prc_unidad,
                                                      v_precio,
                                                      v_pdte.fec_movimiento);
              v_pdte.prc_unidad := v_precio;
           end if;
               if v_pdte.ind_entsal = 'E' then
                  p_proceso_entrada (v_pdte,
                                 v_ini_ejer,
                                 v_inter.cod_retorno,
                                 v_inter.des_cadena,
                                 v_decim,
                                                                 v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
           elsif v_pdte.ind_entsal = 'S' then
                  p_proceso_salida (v_pdte,
                                   v_ini_ejer,
                                   v_inter.cod_retorno,
                                   v_inter.des_cadena,
                                                                   v_operadora);
           else
                 p_proceso_traspaso (v_pdte,
                                     v_ini_ejer,
                                     v_inter.cod_retorno,
                                     v_inter.des_cadena,
                                     v_decim,
                                                                         v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
           end if;
           if v_inter.cod_retorno = 0 then
              delete al_pdte_calculo
                     where current of c_pdte;
      else
         raise_application_error
          (-20001,'Error ');
           end if;
       end LOOP;
    EXCEPTION
       when OTHERS then
            if c_pdte%ISOPEN then
               close c_pdte;
            end if;
            v_inter.cod_retorno := 1;
            if SQLCODE = -20185 then
               v_inter.des_cadena := '/Error Obtencion Decimales/';
            elsif SQLCODE = -20149 then
                  v_inter.des_cadena := '/Error Obtencion Moneda/';
            elsif SQLCODE = 20147 then
                  v_inter.des_cadena := '/Error Conversion Precio/';
            else
            v_inter.des_cadena  := 'Error Actualizacion de Calculos Pendientes/
  ';
            end if;
    END p_trata_movim;
  --
  -- Retrofitted
  PROCEDURE p_proceso_entrada(
  v_pdte     IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error    IN OUT al_intercierre.cod_retorno%type ,
  v_mensa    IN OUT al_intercierre.des_cadena%type ,
  v_decim    IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
      v_mercaderia   al_pmp_mercaderia%rowtype;
      v_fijo         al_pmp_afijo%rowtype;
      v_compra       al_compras_mercaderia%rowtype;
    BEGIN
       if v_pdte.ind_valor_ori = 1 then
          v_mercaderia.cod_articulo            := v_pdte.cod_articulo;
          v_mercaderia.fec_ejercicio           := v_ini_ejer;
          v_mercaderia.can_stock               := v_pdte.num_cantidad;
          v_mercaderia.prc_pmp                     := nvl(v_pdte.prc_unidad,0);
                  v_mercaderia.cod_operadora_scl       := v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          -- dbms_output.put_line('Articulo:'||to_char(v_mercaderia.cod_articulo));
          -- dbms_output.put_line('Fec_ejercicio:'||to_char(v_mercaderia.fec_ejercicio));
          p_entrada_mercaderia (v_mercaderia,
                                v_error,
                                v_mensa,
                                v_decim);
          if v_error <> 0 then
             raise exception_error;
          end if;
          v_compra.cod_articulo         := v_pdte.cod_articulo;
          v_compra.mes_compra           := trunc(sysdate,'MONTH');
          v_compra.prc_compra           := v_pdte.prc_unidad;
          v_compra.can_stock                := v_pdte.num_cantidad;
                  v_compra.cod_operadora_scl    := v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          p_entrada_compra (v_compra,
                            v_error,
                            v_mensa);
          if v_error <> 0 then
             raise exception_error;
          end if;
       elsif v_pdte.ind_valor_ori = 2 then
          al_pac_validaciones.p_obtiene_meses (v_pdte.cod_articulo,
                                               v_fijo.mes_vida);
          if v_error <> 0 then
             raise exception_error;
          end if;
          for v_veces in 1..v_pdte.num_cantidad loop
              v_fijo.cod_articulo  := v_pdte.cod_articulo;
              v_fijo.fec_afijo     := sysdate;
              v_fijo.prc_compra    := v_pdte.prc_unidad;
              v_fijo.prc_actual    := v_pdte.prc_unidad;
              v_fijo.num_serie     := v_pdte.num_serie;
              v_fijo.fec_finafijo  := null;
              p_entrada_afijo (v_fijo,
                               v_error,
                               v_mensa);
              if v_error <> 0 then
                 raise exception_error;
              end if;
         end loop;
       end if;
    EXCEPTION
       when EXCEPTION_ERROR then
            v_error := 1;
       when OTHERS then
            v_error := 1;
  --          v_mensa := '/Error Obtencion Meses/';
            v_mensa := 'Entrada '||SQLERRM;
    END p_proceso_entrada;
  --
  -- Retrofitted
  PROCEDURE p_proceso_salida(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
       v_mescompra       al_compras_mercaderia.mes_compra%type;
    BEGIN
       v_mescompra := null;
       if v_pdte.ind_valor_ori = 1 then
          p_salida_mercaderia (v_pdte.cod_articulo,
                               v_ini_ejer,
                               v_pdte.num_cantidad,
                               v_error,
                               v_mensa,
                                                           v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          if v_error <> 0 then
             raise exception_error;
          end if;
          p_salida_compras (v_pdte.cod_articulo,
                            v_mescompra,
                            v_pdte.num_cantidad,
                            v_error,
                            v_mensa,
                                                    v_operadora);                                                -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          if v_error <> 0 then
             raise exception_error;
          end if;
       elsif v_pdte.ind_valor_ori = 2 then
          if v_pdte.num_serie is not null  then
             p_salida_afijo_s (v_pdte.num_serie,
                               v_pdte.fec_movimiento,
                               v_error,
                               v_mensa);
             if v_error <> 0 then
                raise exception_error;
             end if;
          else
             for v_veces in 1..v_pdte.num_cantidad loop
                 p_salida_afijo_ns (v_pdte.cod_articulo,
                                    v_pdte.fec_movimiento,
                                    v_error,
                                    v_mensa,
                                                                        v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                 if v_error <> 0 then
                    raise exception_error;
                 end if;
             end loop;
          end if;
       end if;
    EXCEPTION
       when EXCEPTION_ERROR then
           v_error := 1;
       when OTHERS then
           raise;
    END p_proceso_salida;  --
  -- Retrofitted
  PROCEDURE p_obtiene_mes_ingreso(
  v_serie IN al_series.num_serie%type ,
  v_mescompra IN OUT al_series.fec_entrada%type )
  IS
        BEGIN
           select fec_entrada into v_mescompra
                  from al_series
                  where num_serie = v_serie;
        EXCEPTION
          when OTHERS then
                if SQLCODE =100 then
                        null;
                else
                        raise_application_error (-20139,'<ALMACEN> Series '
                                        || to_char(SQLCODE));
                end if;
        END p_obtiene_mes_ingreso;
  -- Retrofitted
  PROCEDURE p_proceso_traspaso(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- modificacion nultiempresa Ulises Uribe
  IS
      no_hace_nada   exception;
      v_mescompra    al_compras_mercaderia.mes_compra%type;
      v_mercaderia   al_pmp_mercaderia%rowtype;
      v_fijo         al_pmp_afijo%rowtype;
      v_compra       al_compras_mercaderia%rowtype;
      v_tipo         al_articulos.tip_articulo%type;
      v_prc_pmp      al_pmp_mercaderia.prc_pmp%type;
      v_prc_compra   al_pmp_afijo.prc_compra%type;
      v_prc_actual   al_pmp_afijo.prc_actual%type;
      v_fecafijo     al_pmp_afijo.fec_afijo%type;
      v_meses        al_articulos.mes_afijo%type;
      v_serie_borrada    NUMBER(1):=0;
    BEGIN
      if v_pdte.ind_valor_ori = v_pdte.ind_valor_des or
         v_pdte.ind_valor_des is null then
         raise no_hace_nada;
      end if;
      if v_pdte.ind_valor_ori = 0 and
        (v_pdte.ind_valor_des = 1 or
         v_pdte.ind_valor_des = 2) then
         v_error := 1;
         v_mensa := '/Traspaso no permitido/';
         raise exception_error;
      end if;
      --
      if v_pdte.num_serie is not null then
         p_obtiene_mes_ingreso (v_pdte.num_serie,v_mescompra);
                --dbms_output.put_line('Mes Encontrado:'||to_char(v_mescompra,'DD-MM-YYYY'));
         if v_mescompra is null then
                      -- si no ha encontrado la serie en AL_SERIES, procedemos como si fuera no seriada
                v_serie_borrada:=1;
         end if;
         if v_error <> 0 then
             raise exception_error;
         end if;
      else
         v_mescompra := null;
      end if;
      if v_pdte.ind_valor_ori = 1 and
         v_pdte.ind_valor_des = 0 then
         if (v_pdte.num_serie is null OR v_serie_borrada = 1) then
            p_salida_compra_ns (v_pdte.cod_articulo,
                                v_pdte.num_cantidad,
                                v_error,
                                v_mensa,
                                                                v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            if v_error <> 0 then
               raise exception_error;
            end if;
         else
            p_salida_compras (v_pdte.cod_articulo,
                              v_mescompra,
                              v_pdte.num_cantidad,
                              v_error,
                              v_mensa,
                                                          v_operadora);   -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            if v_error <> 0 then
               raise exception_error;
            end if;
         end if;
         p_salida_mercaderia (v_pdte.cod_articulo,
                              v_ini_ejer,
                              v_pdte.num_cantidad,
                              v_error,
                              v_mensa,
                                                          v_operadora);  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
         if v_error <> 0 then
            raise exception_error;
         end if;
      end if;
      if v_pdte.ind_valor_ori = 2 and
         v_pdte.ind_valor_des = 0 then
         if (v_pdte.num_serie is null OR v_serie_borrada=1) then
            for v_veces in 1..v_pdte.num_cantidad loop
                p_salida_afijo_ns (v_pdte.cod_articulo,
                                   v_pdte.fec_movimiento,
                                   v_error,
                                   v_mensa,
                                                                   v_operadora);  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                if v_error <> 0 then
                     raise exception_error;
                end if;
            end loop;
         else
            p_salida_afijo_s (v_pdte.num_serie,
                              v_pdte.fec_movimiento,
                              v_error,
                              v_mensa);
            if v_error <> 0 then
                 raise exception_error;
            end if;
         end if;
      end if;
      if v_pdte.ind_valor_ori = 1 and
         v_pdte.ind_valor_des = 2 then
         p_valor_mercaderia (v_pdte.cod_articulo,
                             v_ini_ejer,
                             v_prc_pmp,
                             v_error,
                             v_mensa,
                                                         v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
         if v_error <> 0 then
            raise exception_error;
         end if;
         for v_veces in 1..v_pdte.num_cantidad loop
            al_pac_validaciones.p_obtiene_meses (v_pdte.cod_articulo,
                                                 v_meses);
            if v_error <> 0 then
               raise exception_error;
            end if;
            v_fijo.cod_articulo := v_pdte.cod_articulo;
            v_fijo.fec_afijo    := sysdate;
            v_fijo.mes_vida     := v_meses;
            v_fijo.prc_compra   := v_prc_pmp;
            v_fijo.prc_actual   := v_prc_pmp;
            v_fijo.num_serie    := v_pdte.num_serie;
            v_fijo.fec_finafijo := null;
            p_entrada_afijo (v_fijo,
                             v_error,
                             v_mensa);
            if v_error <> 0 then
               raise exception_error;
            end if;
         end loop;
         if (v_pdte.num_serie is not null AND v_serie_borrada=0)  then
            p_salida_compras (v_pdte.cod_articulo,
                              v_mescompra,
                              v_pdte.num_cantidad,
                              v_error,
                              v_mensa,
                                                          v_operadora);   -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            if v_error <> 0 then
               raise exception_error;
            end if;
         else
            p_salida_compra_ns (v_pdte.cod_articulo,
                                v_pdte.num_cantidad,
                                v_error,
                                v_mensa,
                                                                v_operadora);  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            if v_error <> 0 then
               raise exception_error;
            end if;
         end if;
         p_salida_mercaderia (v_pdte.cod_articulo,
                              v_ini_ejer,
                              v_pdte.num_cantidad,
                              v_error,
                              v_mensa,
                                                          v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
         if v_error <> 0 then
            raise exception_error;
         end if;
      end if;
      if v_pdte.ind_valor_ori = 2 and
         v_pdte.ind_valor_des = 1 then
         if (v_pdte.num_serie is not null AND v_serie_borrada = 0) then
            p_valor_afijo(v_pdte.num_serie,
                          v_fecafijo,
                          v_prc_compra,
                          v_prc_actual,
                          v_error,
                          v_mensa);
            if v_error <> 0 then
               raise exception_error;
            end if;
            v_compra.cod_articulo     := v_pdte.cod_articulo;
            v_compra.mes_compra       := trunc(v_fecafijo,'MONTH');
            v_compra.prc_compra       := v_prc_compra;
            v_compra.can_stock        := v_pdte.num_cantidad;
                        v_compra.cod_operadora_scl:= v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            p_entrada_compra (v_compra,
                              v_error,
                              v_mensa);
            if v_error <> 0 then
               raise exception_error;
            end if;
            p_actualiza_fec_entrada (v_pdte.num_serie,
                                     v_compra.mes_compra,
                                     v_error,
                                     v_mensa);
            if v_error <> 0 then
               raise exception_error;
            end if;
            v_mercaderia.cod_articulo     := v_pdte.cod_articulo;
            v_mercaderia.fec_ejercicio    := v_ini_ejer;
            v_mercaderia.can_stock        := v_pdte.num_cantidad;
            v_mercaderia.prc_pmp          := v_prc_actual;
                        v_mercaderia.cod_operadora_scl:= v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            p_entrada_mercaderia (v_mercaderia,
                                  v_error,
                                  v_mensa,
                                  v_decim);
            if v_error <> 0 then
               raise exception_error;
            end if;
            p_salida_afijo_s (v_pdte.num_serie,
                              v_pdte.fec_movimiento,
                              v_error,
                              v_mensa);
            if v_error <> 0 then
               raise exception_error;
            end if;
         else
            p_afijo_mercaderia (v_pdte.cod_articulo,
                                v_pdte.num_cantidad,
                                v_ini_ejer,
                                v_error,
                                v_mensa,
                                v_decim,
                                                                v_operadora);   -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            if v_error <> 0 then
               raise exception_error;
            end if;
         end if;
      end if;
    EXCEPTION
      when NO_HACE_NADA then
           null;
      when EXCEPTION_ERROR then
           v_error := 1;
      when OTHERS then
           v_error := 1;
           v_mensa := '/Error Obtencion Meses/';
           v_mensa := 'Traspaso '||SQLERRM;
    END p_proceso_traspaso;
  --
  -- Retrofitted
  PROCEDURE p_entrada_mercaderia(
  v_mercaderia IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type )
  IS
      v_pmp     al_pmp_mercaderia.prc_pmp%type;
      v_can     al_pmp_mercaderia.can_stock%type;
      v_pmp_new al_pmp_mercaderia.prc_pmp%type;
    BEGIN
    --
    -- Verificacion de existencia del articulo para el ejercicio en curso
    --
       select prc_pmp,can_stock into v_pmp,v_can
              from al_pmp_mercaderia
              where cod_articulo = v_mercaderia.cod_articulo
                and fec_ejercicio = v_mercaderia.fec_ejercicio
                                and cod_operadora_scl = v_mercaderia.cod_operadora_scl;                 -- 30-12-2002 Modificacion multiempresa Ulises Uribe
    --
         v_pmp_new :=
           round((((v_pmp * v_can) +
                   (v_mercaderia.prc_pmp * v_mercaderia.can_stock)
                  ) / (v_can + v_mercaderia.can_stock)),v_decim);
    --
         update al_pmp_mercaderia set prc_pmp = nvl(v_pmp_new,0),
                                      can_stock = can_stock +
                                      v_mercaderia.can_stock
                where cod_articulo   = v_mercaderia.cod_articulo and
                      fec_ejercicio  = v_mercaderia.fec_ejercicio and
                                          cod_operadora_scl = v_mercaderia.cod_operadora_scl; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
    EXCEPTION
       when NO_DATA_FOUND then
          insert into al_pmp_mercaderia (cod_articulo,
                                         fec_ejercicio,
                                                                                 cod_operadora_scl, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                         can_stock,
                                         prc_pmp)
                                 values (v_mercaderia.cod_articulo,
                                         v_mercaderia.fec_ejercicio,
                                                                                 v_mercaderia.cod_operadora_scl, -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                         v_mercaderia.can_stock,
                                         nvl(v_mercaderia.prc_pmp,0));
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Entrada AL_PMP_MERCADERIA /';
    END p_entrada_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_entrada_afijo(
  v_fijo IN al_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
       insert into al_pmp_afijo (num_activo,
                                 cod_articulo,
                                 fec_afijo,
                                 mes_vida,
                                 prc_compra,
                                 prc_actual,
                                 num_serie,
                                 fec_finafijo,
                                 fec_calculo,
                                 prc_calculo)
                         values (al_seq_afijo.nextval,
                                 v_fijo.cod_articulo,
                                 v_fijo.fec_afijo,
                                 nvl(v_fijo.mes_vida,0),
                                 v_fijo.prc_compra,
                                 v_fijo.prc_actual,
                                 v_fijo.num_serie,
                                 v_fijo.fec_finafijo,
                                 null,
                                 null);
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error ingreso Activo Fijo/';
    END p_entrada_afijo;
  --
  -- Retrofitted
  PROCEDURE p_entrada_compra(
  v_compra IN al_compras_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type)
  IS
      v_precio   al_compras_mercaderia.prc_compra%type;
      v_precio1  al_compras_mercaderia.prc_compra%type;
      v_rowid    rowid;
    BEGIN
         select prc_compra,rowid into v_precio,v_rowid
         from al_compras_mercaderia
         where cod_articulo = v_compra.cod_articulo
         and mes_compra   = v_compra.mes_compra
                 and cod_operadora_scl = v_compra.cod_operadora_scl ; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
      if v_precio > v_compra.prc_compra then
    --
    -- En caso de que el precio registrado sea mayor al del movimiento
    -- almacenaremos el obtenido en la select de AL_COMPRAS_MERCADERIA
    --
         v_precio1 := v_precio;
      else
         v_precio1 := v_compra.prc_compra;
      end if;
      update al_compras_mercaderia
             set prc_compra = v_precio1,
                 can_stock  = can_stock + v_compra.can_stock
           where rowid = v_rowid;
    EXCEPTION
       when NO_DATA_FOUND then
            -- dbms_output.put_line('Creando al_compras merc: cod.art:'||v_compra.cod_articulo||'mes:'||v_compra.mes_compra||'prc:'||v_compra.prc_compra||'can:'||v_compra.can_stock);
            insert into al_compras_mercaderia (cod_articulo,
                                               mes_compra,
                                               prc_compra,
                                               can_stock,
                                                                                           cod_operadora_scl) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                       values (v_compra.cod_articulo,
                                               v_compra.mes_compra,
                                               v_compra.prc_compra,
                                               v_compra.can_stock,
                                                                                           v_compra.cod_operadora_scl); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
      when OTHERS then
           v_error := 1;
           v_mensa := '/Error Compras/';
    END p_entrada_compra;
  --
  -- Retrofitted
  PROCEDURE p_salida_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_cantidad IN al_pmp_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
    BEGIN
    Update al_pmp_mercaderia
              set can_stock = can_stock - v_cantidad
              where cod_articulo = v_articulo
              and fec_ejercicio = v_ini_ejer
                          and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida Mercaderia/';
    END p_salida_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_salida_compras(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_mescompra IN al_compras_mercaderia.mes_compra%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
      v_rowid  rowid;
      v_cant   al_compras_mercaderia.can_stock%type;
      v_existe_compra   NUMBER;
    BEGIN
      if v_mescompra is null then
         p_salida_compra_ns (v_articulo,
                             v_cantidad,
                             v_error,
                             v_mensa,
                                                         v_operadora); -- 30-12-2002 Modificacion multiempresa Ulises Uribe
      else
         select count(*) into v_existe_compra
                from al_compras_mercaderia
                where cod_articulo = v_articulo and
                      mes_compra  = trunc(v_mescompra,'MONTH') and
                                          cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
         if v_existe_compra = 0 then
         select rowid,can_stock into v_rowid,v_cant
               from al_compras_mercaderia
               where cod_articulo = v_articulo and
                      mes_compra  < trunc(v_mescompra,'MONTH') and
                                          cod_operadora_scl = v_operadora and            -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                rownum<2;
         else
        select rowid,can_stock into v_rowid,v_cant
              from al_compras_mercaderia
              where cod_articulo = v_articulo and
                      mes_compra  = trunc(v_mescompra,'MONTH') and
                                          cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
         end if;
          if v_cantidad = v_cant then
              delete al_compras_mercaderia
                    where rowid = v_rowid;
          else
             update al_compras_mercaderia set can_stock = can_stock - v_cantidad
                    where rowid = v_rowid;
          end if;
       end if;
    EXCEPTION
      when OTHERS then
        v_error := 1;
        v_mensa := '/Error Salida Compras/';
 END p_salida_compras;
  --
  -- Retrofitted
  PROCEDURE p_salida_compra_ns(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
       CURSOR c_compras is
              select can_stock from al_compras_mercaderia
                     where    cod_articulo = v_articulo
                                     and      cod_operadora_scl = v_operadora -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                     order by cod_articulo,mes_compra
                     for update of can_stock;
       v_c_compras c_compras%rowtype;
       v_cant al_compras_mercaderia.can_stock%type;
    BEGIN
       v_cant := v_cantidad;
       for v_c_compras in c_compras loop
           if v_c_compras.can_stock <= v_cant then
              v_cant := v_cant - v_c_compras.can_stock;
              delete al_compras_mercaderia
                     where current of c_compras;
           else
              update al_compras_mercaderia
                     set can_stock = can_stock - v_cant
                     where current of c_compras;
              exit;
           end if;
        end loop;
    EXCEPTION
       when OTHERS then
            if c_compras%ISOPEN then
               close c_compras;
            end if;
                v_error := 1;
                v_mensa := '/Error Salida Compras/';
    END p_salida_compra_ns;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_s(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
       update al_pmp_afijo set fec_finafijo = v_fecha
              where num_serie = v_serie
                and fec_finafijo is null;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida A.Fijo/';
    END p_salida_afijo_s;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_ns(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
    BEGIN
        update al_pmp_afijo  set fec_finafijo = v_fecha
    where num_activo in (select num_activo   -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                    from al_pmp_afijo a,al_series b, al_bodeganodo c, ge_operadora_scl d
                                                                        where  d.cod_operadora_scl = v_operadora
                                                                        and  a.num_serie = b.num_serie
                                                                        and  b.cod_bodega = c.cod_bodega
                                                                        and  c.cod_bodeganodo = d.cod_bodeganodo
                                    and    a.fec_finafijo is null)
         and fec_finafijo is null
     and   fec_afijo               =(select min(a.fec_afijo) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                                    from al_pmp_afijo a,al_series b, al_bodeganodo c, ge_operadora_scl d
                                                                        where  d.cod_operadora_scl = v_operadora
                                                                        and  a.num_serie = b.num_serie
                                                                        and  b.cod_bodega = c.cod_bodega
                                                                        and  c.cod_bodeganodo = d.cod_bodeganodo
                                    and    a.fec_finafijo is null);
/*       update al_pmp_afijo set fec_finafijo = v_fecha
              where cod_articulo = v_articulo
                and fec_finafijo is null
                and fec_afijo = (select min(fec_afijo)
                                   from al_pmp_afijo
                                   where cod_articulo = v_articulo
                                     and fec_finafijo is null);*/
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida A.Fijo /';
    END p_salida_afijo_ns;
  --
  -- Retrofitted
  PROCEDURE p_valor_afijo(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fecafijo IN OUT al_pmp_afijo.fec_afijo%type ,
  v_compra IN OUT al_pmp_afijo.prc_compra%type ,
  v_precio IN OUT al_pmp_afijo.prc_actual%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
       select prc_compra,prc_actual,fec_afijo
         into v_compra,v_precio,v_fecafijo
         from al_pmp_afijo
         where num_serie    = v_serie and
               fec_finafijo is null;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Lectura Activo Fijo/';
    end p_valor_afijo;
  --
  -- Retrofitted
  PROCEDURE p_valor_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_pmp IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
    BEGIN
       select prc_pmp into v_pmp
              from al_pmp_mercaderia
              where cod_articulo      = v_articulo
                and fec_ejercicio     = v_ini_ejer
                                and cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Lectura Coste Promedio/';
    END p_valor_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_afijo_mercaderia(
  v_articulo  IN al_pmp_afijo.cod_articulo%type ,
  v_cantidad  IN al_movimientos.num_cantidad%type ,
  v_ini_ejer  IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_error     IN OUT al_intercierre.cod_retorno%type ,
  v_mensa     IN OUT al_intercierre.des_cadena%type ,
  v_decim     IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
      CURSOR c_afijo IS
             select a.* from al_pmp_afijo a, al_series b, al_bodeganodo c, ge_operadora_scl d -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                    where a.cod_articulo = v_articulo
                      and a.fec_finafijo is null
                                          and a.num_serie = b.num_serie
                                          and b.cod_bodega = c.cod_bodega
                                          and c.cod_bodeganodo = d.cod_bodeganodo
                      for update of fec_finafijo;
      v_afijo al_pmp_afijo%rowtype;
      v_mercaderia   al_pmp_mercaderia%rowtype;
      v_compra       al_compras_mercaderia%rowtype;
    BEGIN
      open c_afijo;
      for v_veces in 1..v_cantidad loop
          fetch c_afijo into v_afijo;
          exit when c_afijo%NOTFOUND;
          v_compra.cod_articulo := v_articulo;
          v_compra.mes_compra   := trunc(v_afijo.fec_afijo,'MONTH');
          v_compra.prc_compra   := v_afijo.prc_compra;
          v_compra.can_stock    := 1;
                  v_compra.cod_operadora_scl    := v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                  p_entrada_compra (v_compra,
                            v_error,
                            v_mensa);
          if v_error <> 0 then
             raise exception_error;
          end if;
          v_mercaderia.cod_articulo    := v_articulo;
          v_mercaderia.fec_ejercicio   := v_ini_ejer;
          v_mercaderia.can_stock       := 1;
          v_mercaderia.prc_pmp         := v_afijo.prc_actual;
                  v_mercaderia.cod_operadora_scl := v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          p_entrada_mercaderia (v_mercaderia,
                                v_error,
                                v_mensa,
                                v_decim);
          if v_error <> 0 then
             raise exception_error;
          end if;
          update al_pmp_afijo
             set fec_finafijo = sysdate
             where current of c_afijo;
       end loop;
       close c_afijo;
    EXCEPTION
       when EXCEPTION_ERROR then
            if c_afijo%ISOPEN then
               close c_afijo;
            end if;
       when OTHERS then
            if c_afijo%ISOPEN then
               close c_afijo;
            end if;
            v_error := 1;
            v_mensa := '/Error paso a A.Fijo/';
    END p_afijo_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_actualiza_fec_entrada(
  v_serie IN al_series.num_serie%type ,
  v_fecha IN al_series.fec_entrada%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
       update al_series set fec_entrada = v_fecha
              where num_serie = v_serie;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Actualizacion Fecha/';
    END p_actualiza_fec_entrada;
END AL_PROC_CALPDTE;
/
SHOW ERRORS
