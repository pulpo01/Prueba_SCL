CREATE OR REPLACE procedure P_BUSCA_PAGOS
(p_FECHA_DESDE in varchar2, p_FECHA_HASTA in VARCHAR2, SALIDA in varchar2 , ARCHIVO in varchar2) IS
v_fecha CO_PAGOS.FEC_EFECTIVIDAD%type;
v_num_secuenci co_pagos.num_secuenci%type;
v_cod_tipdocum co_pagos.cod_tipdocum%type;
v_cod_vendedor_agente co_pagos.cod_vendedor_agente%type;
v_letra co_pagos.letra%type;
v_cod_centremi co_pagos.cod_centremi%type;
v_num_abonado co_pagosconc.num_abonado%type;
v_num_terminal ga_abocel.num_celular%type;
v_cod_cliente ga_abocel.cod_cliente%type;
v_num_ident ge_clientes.num_ident%type;
v_nom_cliente ge_clientes.nom_cliente%type;
v_nom_apeclien1 ge_clientes.nom_apeclien1%type;
v_nom_apeclien2 ge_clientes.nom_apeclien2%type;
v_cod_caja co_pagos.cod_caja%type;
v_imp_concepto co_pagosconc.imp_concepto%type;
v_cod_oripago co_pagos.cod_oripago%type;
v_cod_caupago co_pagos.cod_caupago%type;
v_des_pago co_pagos.des_pago%type;
v_cod_tipdocrel co_pagosconc.cod_tipdocrel%type;
v_monto_total co_pagos.imp_pago%type;
v_monto_acumulado co_pagos.imp_pago%type;
total co_pagos.imp_pago%type;
v_num_folio co_pagosconc.num_folio%type;
v_num_folioctc co_pagosconc.num_folioctc%type;
v_tipo varchar2(1);
v_docu varchar2(1);
v_correl_arch number(4):=1;
v_cuenta_filas number(8):=0;
desde date;
hasta date;
pp    varchar2(50);
arv   varchar2(50);
v_archivo varchar2(30);
sFormatoFecha varchar2(12);
sFormatoHora varchar2(12);

puntero utl_file.file_type;
CURSOR ccp(v_desde date, v_hasta date) IS
select fec_efectividad, num_secuenci, cod_tipdocum, cod_vendedor_agente,
letra, cod_centremi, cod_cliente, cod_caja, cod_oripago, cod_caupago, imp_pago, des_pago from co_pagos
where fec_efectividad >= v_desde AND
fec_efectividad < v_hasta;
BEGIN
   pp:=SALIDA;
   v_archivo:=substr(ARCHIVO,1,instr(ARCHIVO,'.',1,1)-1);
   arv:=v_archivo||'_'||v_correl_arch||'.txt';

   SELECT SP_FN_FORMATOFECHA('FORMATO_SEL2'), SP_FN_FORMATOFECHA('FORMATO_SEL21')  into sFormatoFecha, sFormatoHora FROM DUAL;	-- unir

   --desde:=to_date(p_fecha_desde, 'dd-mm-yyyy');
   desde:=to_date(p_fecha_desde, sFormatoFecha);
   --hasta:=to_date(p_fecha_hasta, 'dd-mm-yyyy');
   hasta:=to_date(p_fecha_hasta, sFormatoFecha);

   puntero:=utl_file.fopen(pp,arv,'w');
   if utl_file.is_open(puntero) Then
       Utl_file.put_line(puntero,'Fecha de Pago'||','||'Monto Total'||','||'Valor'||','||'Numero terminal'||','||'Producto'||','||'Abonado'||','||'Codigo Cliente'||','||'Rut'||','||'Nombre o Razon Social'||','||'Caja'||','||'Origen Pago'||','||'Causa Pago
'||','||'Folio'||','||'Folio Ctc'||','||'Tipo Pago'||','||'Descripcion Pago');
   end if;
   Utl_file.fclose(puntero);
   puntero:=utl_file.fopen(pp,arv,'a');
   OPEN ccp(desde, hasta);
   LOOP
     BEGIN
       FETCH ccp into v_fecha, v_num_secuenci, v_cod_tipdocum, v_cod_vendedor_agente,
       v_letra, v_cod_centremi, v_cod_cliente, v_cod_caja, v_cod_oripago, v_cod_caupago, v_monto_total, v_des_pago;
       exit when ccp%notfound;
       BEGIN
         select num_ident, nom_cliente, nom_apeclien1, nom_apeclien2 into v_num_ident, v_nom_cliente, v_nom_apeclien1, v_nom_apeclien2
         from ge_clientes
         where cod_cliente=v_cod_cliente;
         EXCEPTION
           when no_data_found  then
           null;
         END;

         DECLARE
            CURSOR cpg (p_num_secuenci co_pagos.num_secuenci%type, p_cod_tipdocum co_pagos.cod_tipdocum%type
                             , p_cod_vendedor_agente co_pagos.cod_vendedor_agente%type, p_cod_centremi co_pagos.cod_centremi%type) IS
                 select num_abonado, imp_concepto, num_folio, num_folioctc, cod_tipdocrel
                 from co_pagosconc
                 where num_secuenci=p_num_secuenci and cod_tipdocum=p_cod_tipdocum and
                       cod_vendedor_agente=p_cod_vendedor_agente and cod_centremi=p_cod_centremi;
         BEGIN
           v_monto_acumulado:=0;
           OPEN cpg (v_num_secuenci, v_cod_tipdocum
                             , v_cod_vendedor_agente, v_cod_centremi);
           LOOP
             BEGIN
               FETCH cpg into v_num_abonado, v_imp_concepto, v_num_folio, v_num_folioctc, v_cod_tipdocrel;
               exit when cpg%notfound;
               if v_cod_tipdocrel<>8 or v_cod_tipdocrel<>9 or v_cod_tipdocrel<>33 or v_cod_tipdocrel<>25 then
                  v_monto_acumulado:=v_monto_acumulado+v_imp_concepto;
               end if;
               select num_celular, 'C' into v_num_terminal, v_tipo
               from ga_abocel
               where num_abonado=v_num_abonado;
               if v_cod_tipdocrel=8 or v_cod_tipdocrel=9 or v_cod_tipdocrel=33 or v_cod_tipdocrel=25 then
                  v_docu:='2';
               else
                  v_docu:='1';
               end if;
               if utl_file.is_open(puntero) Then
                  --Utl_file.put_line(puntero,to_char(v_fecha,'dd-mm-yyyy hh24:mi')||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||v_num_terminal||','||v_tipo||','||v_num_abonado||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||
                                  Utl_file.put_line(puntero,to_char(v_fecha, sFormatoFecha || ' ' || sFormatoHora)||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||v_num_terminal||','||v_tipo||','||v_num_abonado||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||
v_nom_apeclien1||' '||v_nom_apeclien2||','||v_cod_caja||','||v_cod_oripago||','||v_cod_caupago||','||v_num_folio||','||v_num_folioctc||','||v_docu||','||v_des_pago);
                  v_cuenta_filas:=v_cuenta_filas+1;
                  if mod(v_cuenta_filas,50000)=0 then
                     v_correl_arch:=v_correl_arch + 1;
                     utl_file.fclose(puntero);
                     arv:=v_archivo||'_'||v_correl_arch||'.txt';
                     puntero:=utl_file.fopen(pp,arv,'w');
                  end if;
               end if;
               EXCEPTION
                  when no_data_found then
                    BEGIN
                      select num_beeper, 'B' into v_num_terminal, v_tipo
                      from ga_abobeep
                      where num_abonado=v_num_abonado;
                      if v_num_terminal>9900000 then
                         v_tipo:='T';
                      end if;
                      if v_cod_tipdocrel=8 or v_cod_tipdocrel=9 or v_cod_tipdocrel=33 or v_cod_tipdocrel=25 then
                         v_docu:='2';
                      else
                         v_docu:='1';
                      end if;
                      If utl_file.is_open(puntero) Then
                         --Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||v_num_terminal||','||v_tipo||','||v_num_abonado||','||v_cod_cliente||','||
                                                 Utl_file.put_line(puntero,to_char(v_fecha, sFormatoFecha || ' ' || sFormatoHora)||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||v_num_terminal||','||v_tipo||','||v_num_abonado||','||v_cod_cliente||','||
                                                 v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '||v_nom_apeclien2||','||v_cod_caja||','||v_cod_oripago||','||v_cod_caupago||','||v_num_folio||','||v_num_folioctc||','||v_docu||','||v_des_pago);
                         v_cuenta_filas:=v_cuenta_filas+1;
                         if mod(v_cuenta_filas,50000)=0 then
                            v_correl_arch:=v_correl_arch + 1;
                            utl_file.fclose(puntero);
                            arv:=v_archivo||'_'||v_correl_arch||'.txt';
                            puntero:=utl_file.fopen(pp,arv,'w');
                         end if;
                      end if;
                      EXCEPTION
                      when no_data_found then
                         if v_cod_tipdocrel=8 or v_cod_tipdocrel=9 or v_cod_tipdocrel=33 or v_cod_tipdocrel=25 then
                            v_docu:='2';
                         else
                            v_docu:='1';
                         end if;
                         If utl_file.is_open(puntero) Then
                            --Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||'0'||','||'G'||','||'0'||','||v_cod_cliente||','
                                                        Utl_file.put_line(puntero,to_char(v_fecha, sFormatoFecha || ' ' || sFormatoHora)||','||nvl(v_monto_total,0)||','||nvl(v_imp_concepto,0)||','||'0'||','||'G'||','||'0'||','||v_cod_cliente||','
                                                        ||v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '||v_nom_apeclien2||','||v_cod_caja||','||v_cod_oripago||','||v_cod_caupago||','||v_num_folio||','||v_num_folioctc||','||v_docu||','||v_des_pago);
                            v_cuenta_filas:=v_cuenta_filas+1;
                            if mod(v_cuenta_filas,50000)=0 then
                               v_correl_arch:=v_correl_arch + 1;
                               utl_file.fclose(puntero);
                               arv:=v_archivo||'_'||v_correl_arch||'.txt';
                               puntero:=utl_file.fopen(pp,arv,'w');
                            end if;
                         end if;
                    END;
             END;
           END LOOP;
           CLOSE cpg;
           if v_cod_tipdocrel=8 or v_cod_tipdocrel=9 or v_cod_tipdocrel=33 or v_cod_tipdocrel=25 then
              v_docu:='2';
           else
              v_docu:='1';
           end if;
           if (v_monto_total-v_monto_acumulado)<>0 then
              if v_monto_acumulado=0 then
                 if v_cod_tipdocum=10 or v_cod_tipdocum=17 then
                    v_docu:='4';
                 end if;
                 if v_num_folio<>'' then
                    --Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||nvl(v_monto_total,0)||','||nvl(v_monto_total,0)||','||'0'||','||'G'||','||'0'||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '||
                                        Utl_file.put_line(puntero,to_char(v_fecha, sFormatoFecha || ' ' || sFormatoHora)||','||nvl(v_monto_total,0)||','||nvl(v_monto_total,0)||','||'0'||','||'G'||','||'0'||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '||
v_nom_apeclien2||','||v_cod_caja||','||v_cod_oripago||','||v_cod_caupago||','||'0'||','||'0'||','||v_docu||','||v_des_pago);
                 end if;
                 v_cuenta_filas:=v_cuenta_filas+1;
                 if mod(v_cuenta_filas,50000)=0 then
                    v_correl_arch:=v_correl_arch + 1;
                    utl_file.fclose(puntero);
                    arv:=v_archivo||'_'||v_correl_arch||'.txt';
                    puntero:=utl_file.fopen(pp,arv,'w');
                 end if;
              else
                 total:=v_monto_total-v_monto_acumulado;
                 if v_cod_tipdocum=10 or v_cod_tipdocum=17 then
                    v_docu:='4';
                    total:=v_monto_total;
                 end if;
                 if v_num_folio<>'' then
                    --Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||nvl(v_monto_total,0)||','||nvl(total,0)||','||'0'||','||'G'||','||v_num_abonado||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '
                                        Utl_file.put_line(puntero,to_char(v_fecha, sFormatoFecha || ' ' || sFormatoHora)||','||nvl(v_monto_total,0)||','||nvl(total,0)||','||'0'||','||'G'||','||v_num_abonado||','||v_cod_cliente||','||v_num_ident||','||v_nom_cliente||' '||v_nom_apeclien1||' '
||v_nom_apeclien2||','||v_cod_caja||','||v_cod_oripago||','||v_cod_caupago||','||v_num_folio||','||v_num_folioctc||','||'3'||','||v_des_pago);
                 end if;
                 v_cuenta_filas:=v_cuenta_filas+1;
                 if mod(v_cuenta_filas,50000)=0 then
                    v_correl_arch:=v_correl_arch + 1;
                    utl_file.fclose(puntero);
                    arv:=v_archivo||'_'||v_correl_arch||'.txt';
                    puntero:=utl_file.fopen(pp,arv,'w');
                 end if;
              end if;
           end if;
      END;
   END;
 END LOOP;
 CLOSE ccp;
 Utl_file.fclose(puntero);
END P_BUSCA_PAGOS;
/
SHOW ERRORS
