CREATE OR REPLACE PACKAGE BODY        GR_PAC_ARPUPREPAGO AS
   type reg_new is record (
      mes           varchar2(10),
      abonados      number(10),
      segs_hn       number(14,4),
      mins_hn       number(14,4),
      segs_hb       number(14,4),
      mins_hb       number(14,4),
      mins_tot      number(14,4),
      mto_hn        number(14,4),
      mto_hb        number(14,4),
      llamadas      number(14,4),
      universo      number(10),
      min_noct      number(14,4),
      min_econ      number(14,4));
   type tabla is table of reg_new
     index by binary_integer;
   cursor paso is select
     num_celular     celular,
     fec_activacion  fecha
     from gr_pivote_prepago;
/* ---------------------------------------------------------- */
   v_entrada            binary_integer:=0;
   v_salida             binary_integer:=1;
   v_eos                binary_integer:=2;
   v_eys                binary_integer:=3;
   donde                varchar2(30):='/samba/ready';
/* ---------------------------------------------------------- */
PROCEDURE carga_pivote(v_fecha in     date,
                       arch    in out utl_file.file_type) AS
   cursor datos(p_fecha date) is select
     num_celular       celular,
     fec_activacion    fecha,
     estado_act        estado,
     ind_prepago       indicador
     from icg_prepago
     where ind_prepago in ('AMI','CTA','RAP')
     and fec_activacion< p_fecha
     and estado_act    != 1;
   v_contador    number(8):=0;
   v_sigue       number(1);
   v_paso        number(6);
begin
  v_sigue:=1;
  while v_sigue=1 loop
     delete from gr_pivote_prepago
     where rownum<100000;
     commit;
     if sql%rowcount=0 then
       v_sigue:=0;
     end if;
  end loop;
  for cc in datos(v_fecha) loop
     insert into gr_pivote_prepago
     (num_celular,fec_activacion,estado,ind_prepago)
     values (cc.celular,cc.fecha,cc.estado,cc.indicador);
     v_contador:=v_contador + 1;
     if mod(v_contador,500)=0 then
       commit;
     end if;
  end loop;
  utl_file.put_line(arch,'PROC CARGA_PIVOTE Salio Ok...');
  utl_file.put_line(arch,'Total filas ingresadas:'||to_char(v_contador));
exception
  when others then
    utl_file.put_line(arch,'Error PROC CARGA_PIVOTE:'||sqlerrm);
    utl_file.put_line(arch,sqlerrm);
end carga_pivote;
/* ---------------------------------------------------------- */
PROCEDURE limpia_psd(arch_err in out utl_file.file_type) as
   v_error     varchar2(100);
   v_estado    number(1);
   filas       number(6);
begin
  v_estado:=0;
  while v_estado=0 loop
    begin
      delete from gr_psd_comverse_valores
      where rownum<100000;
      commit;
      if sql%rowcount=0 then
	v_estado:=1;
      end if;
    exception
      when others then
	v_estado:=1;
    end;
  end loop;
  commit;
  v_error:='PROC LIMPIA_PSD_COMVERSE termina Ok.';
  utl_file.put_line(arch_err,v_error);
exception
 when others then
   v_error:='Error PROC LIMPIA_PSD_COMVERSE :'||sqlerrm;
   utl_file.put_line(arch_err,v_error);
end limpia_psd;
/* ---------------------------------------------------------- */
PROCEDURE pone_aboamist(arch_err in out utl_file.file_type) AS
  cursor paso is select
    a.rowid           r_id,
    max(b.fec_alta)   falta
    from gr_pivote_prepago a,ga_aboamist b
    where a.fec_activacion is null
    and a.num_celular=b.num_celular
    group by a.rowid;
  v_fecha       date;
  v_bandera     number(1);
begin
   update gr_pivote_prepago
   set fec_activacion = null
   where fec_activacion<'01-may-00';
   commit;
   for cc in paso loop
       update gr_pivote_prepago
       set fec_activacion=cc.falta
       where rowid=cc.r_id;
       commit;
   end loop;
   utl_file.put_line(arch_err,'PROC PONE_ABOAMIST Salio todo normal...');
exception
  when others then
    utl_file.put_line(arch_err,'Error PROC PONE_ABOAMIST:'||sqlerrm);
end pone_aboamist;
/* ---------------------------------------------------------- */
PROCEDURE pone_series(v_fecmax in     date,
                      arch_err in out utl_file.file_type) AS
  cursor paso is select
    num_celular     celular
    from gr_pivote_prepago
    where fec_activacion is null;
  v_fecha       date;
  v_bandera     number(1);
begin
   for cc in paso loop
     v_bandera:=0;
     v_fecha:=null;
     begin
       select max(fec_entrada)
       into v_fecha
       from al_Series_activas
       where num_telefono=cc.celular;
       v_bandera:=1;          -- tiene en al_series_activas
       if v_fecha >='01-may-00' then
  	   v_fecha:=to_date('31-dec-2002','dd-mon-yyyy');
       end if;
     exception
      when others then
	v_bandera:=0;
     end;
     if v_bandera=0 then
       v_fecha:='01-oct-98';
       v_bandera:=1;
     end if;
     if v_bandera!=0 then
       update gr_pivote_prepago
       set fec_activacion=v_fecha
       where num_celular=cc.celular;
       commit;
     end if;
   end loop;
   update gr_pivote_prepago set fec_activacion ='01-oct-98'
   where fec_activacion is null;
   commit;
   delete from gr_pivote_prepago
   where fec_activacion>=v_fecmax;
   commit;
   utl_file.put_line(arch_err,'PROC PONE_SERIES termina ok...');
exception
  when others then
    utl_file.put_line(arch_err,'Error PROC PONE_SERIES:'||sqlerrm);
end pone_series;
/* ---------------------------------------------------------- */
PROCEDURE sube_comverse (nombre in     varchar2,
                         arch   in out utl_file.file_type) AS
  arch_in       utl_file.file_type;
  v_linea       varchar2(100);
  v_subscriber  number(7);
  v_balance     varchar2(3);
  v_call        number(8);
  v_total       number(8);
  v_cantidad    number(6);
  v_pos1        number(3);
  v_pos2        number(3);
  v_estado      number(1):=1;
  v_contador    number(6):=0;
begin
  arch_in:=utl_file.fopen(donde,nombre,'r');
  v_estado:=1;
  while v_estado=1 loop
    begin
      utl_file.get_line(arch_in,v_linea);
      v_pos1:=2;
      v_pos2:=instr(v_linea,',',v_pos1,1);
      v_subscriber:=to_number(substr(v_linea,v_pos1,v_pos2-v_pos1));
      v_pos1:=v_pos2 +1;
      v_pos2:=instr(v_linea,',',v_pos1,1);
      v_balance:=substr(v_linea,v_pos1,v_pos2-v_pos1);
      v_pos1:=v_pos2 +1;
      v_pos2:=instr(v_linea,',',v_pos1,1);
      v_call:=to_number(substr(v_linea,v_pos1,v_pos2-v_pos1));
      v_pos1:=v_pos2 +1;
      v_pos2:=instr(v_linea,',',v_pos1,1);
      v_total:=to_number(substr(v_linea,v_pos1,v_pos2-v_pos1));
      v_pos1:=v_pos2 +1;
      v_pos2:=instr(v_linea,',',v_pos1,1);
      v_cantidad:=to_number(substr(v_linea,v_pos1,v_pos2-v_pos1));
      insert into gr_psd_comverse_valores (SUBSCRIBER_ID,BALANCE_TYPE,
      CALL_DURATION,TOTAL_CHARGE,CANTIDAD) values (v_subscriber,
      v_balance,v_call,v_total,v_cantidad);
      v_contador:=v_contador + 1;
      if mod(v_contador,500)=0 then
	commit;
      end if;
    exception
      when others then
	v_estado:=0;
	utl_file.put_line(arch,'Error loop:');
	utl_file.put_line(arch,sqlerrm);
    end;
  end loop;
  utl_file.put_line(arch,'Archivo a procesar:'||nombre);
  utl_file.put_line(arch,'Se cargaron :'||to_char(v_contador)||' filas...');
  utl_file.fclose(arch_in);
exception
  when others then
    utl_file.put_line(arch,'Se cayo el mierda....');
    utl_file.fclose(arch_in);
    utl_file.put_line(arch,sqlerrm);
end sube_comverse;
/* ---------------------------------------------------------- */
Procedure inicia_matriz (v_tabla out tabla,
			 p_fecha in varchar2,
			 v_flag  in binary_integer) is
/* Procedure que inicializa la matriz con los meses y los     */
/* acumuladores en 0.                                         */
/* Parametro: Fecha de inicio para el llenado de la matriz.   */
/* ---------------------------------------------------------- */
   v_fecha       date;
begin
    v_fecha:=to_date(p_fecha,'mmyyyy');
    for i in 0..13 loop
      if i=0 then
        v_tabla(i).mes:=to_char(v_fecha,'mm-yyyy');
      elsif i=13 then
        v_tabla(i).mes:='<'||to_char(add_months(v_fecha,-12),'mm-yyyy');
      else
        v_tabla(i).mes:=to_char(add_months(v_fecha,-i),'mm-yyyy');
      end if;
      v_tabla(i).abonados:=0;
      v_tabla(i).segs_hn :=0;
      v_tabla(i).mins_hn :=0;
      v_tabla(i).segs_hb :=0;
      v_tabla(i).mins_hb :=0;
      v_tabla(i).mins_tot:=0;
      v_tabla(i).mto_hn  :=0;
      v_tabla(i).mto_hb  :=0;
      v_tabla(i).llamadas:=0;
      v_tabla(i).universo:=0;
      if v_flag=1 then      -- la tabla es de salida...
	v_tabla(i).min_noct:=0;
	v_tabla(i).min_econ:=0;
      end if;
    end loop;
end;
/* ---------------------------------------------------------- */
Procedure pone_minutos(v_tabla in out tabla) is
/* Procedimidneto que rellena las filas de minutos para una   */
/*      Matriz en particular...                               */
/* ---------------------------------------------------------- */
begin
  for i in 0..13 loop
     v_tabla(i).mins_hn:=trunc((v_tabla(i).segs_hn/60)+0.5);
     v_tabla(i).mins_hb:=trunc((v_tabla(i).segs_hb/60)+0.5);
     v_tabla(i).mins_tot:=v_tabla(i).mins_hn + v_tabla(i).mins_hb;
  end loop;
end;
/* ---------------------------------------------------------- */
Procedure lista_matriz(v_tabla   in out tabla,
		       v_archivo in     binary_integer) is
/* Lista el contenido de la matrz en forma traspuesta         */
/* ---------------------------------------------------------- */
    v_linea          varchar2(500);
    v_donde          varchar2(50);
    v_titulo         varchar2(150);
    v_detalle        varchar2(50);
    arch             utl_file.file_type;
    v_limite         number(3);
begin
    pone_minutos(v_tabla);
    v_donde:='/samba/ready';
    arch:=utl_file.fopen(v_donde,'prepago_arpu.txt','a');
    utl_file.put_line(arch,'');
    utl_file.put_line(arch,'');
    if v_archivo=0 then
      v_titulo:='Detalle de Trafico Prepago Entrada';
      v_detalle:=' Entrada';
      v_limite:=10;
    elsif v_archivo=1 then
      v_titulo:='Detalle de Trafico Prepago Salida';
      v_detalle:=' Salida';
      v_limite:=12;
    elsif v_archivo=2 then
      v_titulo:='Detalle de Trafico Prepago Total (Entrada o Salida)';
      v_detalle:=' Entrada o Salida';
      v_limite:=10;
    else
      v_titulo:='Detalle de Trafico Prepago Entrada y Salida';
      v_detalle:=' Entrada y Salida';
      v_limite:=10;
    end if;
    utl_file.put_line(arch,v_titulo);
    -- mostramos en el archivo final, como quedaria la matriz...
    for i in 0..v_limite loop       -- primero por columnas....
       if i=0 then
	  v_linea:='Concepto';
       elsif i=1 then
	  v_linea:='# Abonados';
       elsif i=2 then
	  v_linea:='# Segundos Hor. Normal';
       elsif i=3 then
	  v_linea:='# Minutos Hor. Normal';
       elsif i=4 then
	  v_linea:='# Segundos Hor. Bajo';
       elsif i=5 then
	  v_linea:='# Minutos Hor. Bajo';
       elsif i=6 then
	  v_linea:='# Minutos Total'||v_detalle;
       elsif i=7 then
	  if v_archivo>=1 then
	    v_linea:='$ Monto'||v_detalle;
	  else
	    v_linea:='$ Monto Hor. Normal';
	  end if;
       elsif i=8 then
	  if v_archivo>=1 then
	    v_linea:='-----';
	  else
	    v_linea:='$ Monto Hor. Bajo';
	  end if;
       elsif i=9 then
	  v_linea:='# Llamadas total';
       elsif i=10 then
	  v_linea:='Universo Total Abonados';
       elsif i=11 then
	  v_linea:='# Minutos Nocturnos';
       else
	 v_linea:='# Minutos Economicos';
       end if;
       for j in 0..13 loop   -- segundo por filas....
	 if i=0 then
	   v_linea:=v_linea||'|'||v_tabla(j).mes;
	 elsif i=1 then
	   v_linea:=v_linea||'|'||v_tabla(j).abonados;
	 elsif i=2 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).segs_hn);
	 elsif i=3 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).mins_hn);
	 elsif i=4 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).segs_hb);
	 elsif i=5 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).mins_hb);
	 elsif i=6 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).mins_tot);
	 elsif i=7 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).mto_hn);
	 elsif i=8 then
	   v_linea:=v_linea||'|'||trunc(v_tabla(j).mto_hb);
	 elsif i=9 then
	   v_linea:=v_linea||'|'||v_tabla(j).llamadas;
	 elsif i=10 then
	   v_linea:=v_linea||'|'||v_tabla(j).universo;
	 elsif i=11 then
	   v_linea:=v_linea||'|'||v_tabla(j).min_noct;
	 else
	   v_linea:=v_linea||'|'||v_tabla(j).min_econ;
	 end if;
       end loop;
       utl_file.put_line(arch,v_linea);
    end loop;
    utl_file.fclose(arch);
end;
/* ---------------------------------------------------------- */
Procedure inserta_matriz(p_min_hn      number,
			 p_min_hb      number,
			 p_mto_hn      number,
			 p_mto_hb      number,
			 p_llamadas    number,
			 p_cuenta      number,
			 p_fecha       varchar2,
			 p_min_noct    number,
			 p_min_econ    number,
			 p_archivo     binary_integer,
			 v_tabla in out tabla) is
/* Inserta los valores de segundos y llamadas en la matriz    */
/* dada la fecha de ingreso del abonado....                   */
/* Ya valido que la fecha esta dentro del rango, por lo que   */
/* si no la encuentra en la busqueda, asume que es anterior a */
/* la fecha en estudio.                                       */
/* Parametros:                                                */
/*    p_min_hn   : Minutos hablados en h. normal              */
/*    p_min_hb   : Minutos hablados en h. Bajo                */
/*    p_mto_hn   : Monto por trafico en h. Normal             */
/*    p_mto_hb   : Monto por trafico en h. Bajo               */
/*    p_llamadas : Cantidad de Llamadas realizadas            */
/*    p_cuenta   : Si se cuenta como parte de la muestra      */
/*    p_fecha    : Fecha que determina la fila...             */
/*    p_min_noct : Minutos nocturnos, solo tabla de salida    */
/*    p_min_econ : Minutos economicos, solo tabla de salida   */
/*    p_archivo  : Indicador de la tabla que se esta update   */
/*    v_tabla    : Tabla final a modificar                    */
/* ---------------------------------------------------------- */
  v_existe     number(1);
  v_fila       binary_integer:=0;
begin
   v_existe:=0;
   while v_existe=0 and v_fila<14 loop
     if v_tabla(v_fila).mes=p_fecha then
       v_existe:=1;
     else
       v_fila:=v_fila + 1;
     end if;
   end loop;
   if v_existe=1 then
     v_tabla(v_fila).abonados:=v_tabla(v_fila).abonados + p_cuenta;
     v_tabla(v_fila).segs_hn :=v_tabla(v_fila).segs_hn  + p_min_hn;
     v_tabla(v_fila).segs_hb :=v_tabla(v_fila).segs_hb  + p_min_hb;
     v_tabla(v_fila).mto_hn  :=v_tabla(v_fila).mto_hn   + p_mto_hn;
     v_tabla(v_fila).mto_hb  :=v_tabla(v_fila).mto_hb   + p_mto_hb;
     v_tabla(v_fila).llamadas:=v_tabla(v_fila).llamadas + p_llamadas;
     v_tabla(v_fila).universo:=v_tabla(v_fila).universo + 1;
     if p_archivo=1 then
       v_tabla(v_fila).min_noct:=v_tabla(v_fila).min_noct + p_min_noct;
       v_tabla(v_fila).min_econ:=v_tabla(v_fila).min_econ + p_min_econ;
     end if;
   else
     v_tabla(13).abonados:=v_tabla(13).abonados + p_cuenta;
     v_tabla(13).segs_hn :=v_tabla(13).segs_hn  + p_min_hn;
     v_tabla(13).segs_hb :=v_tabla(13).segs_hb  + p_min_hb;
     v_tabla(13).mto_hn  :=v_tabla(13).mto_hn   + p_mto_hn;
     v_tabla(13).mto_hb  :=v_tabla(13).mto_hb   + p_mto_hb;
     v_tabla(13).llamadas:=v_tabla(13).llamadas + p_llamadas;
     v_tabla(13).universo:=v_tabla(13).universo + 1;
     if p_archivo=1 then
       v_tabla(13).min_noct:=v_tabla(13).min_noct + p_min_noct;
       v_tabla(13).min_econ:=v_tabla(13).min_econ + p_min_econ;
     end if;
   end if;
end;
/* ---------------------------------------------------------- */
PROCEDURE principal(v_parametro in     varchar2,
                    arch_err    in out utl_file.file_type) AS
   cursor paso is select
     num_celular     celular,
     fec_activacion  fecha
     from gr_pivote_prepago;
   cursor minutos(p_celular number,p_fecha date) is select
     cod_franhora             horario,   -- 1:bajo   2:normal
     ind_entsal               tipo,
     sum(segs_traf)           minutos,
     sum(llamadas_traf)       llamadas,
     sum(monto_intercon)      monto
     from ta_trafico_celular_mes
     where num_celular=p_celular
     and fecha_traf between p_fecha and last_day(p_fecha)
     and ind_entsal in (1,2)
     group by ind_entsal,cod_franhora;
   v_tab_entrada        tabla;
   v_ind_entrada        binary_integer:=0;
   v_tab_salida         tabla;
   v_ind_salida         binary_integer:=0;
   v_tab_eys            tabla;
   v_ind_eys            binary_integer:=0;
   v_tab_eos            tabla;
   v_ind_eos            binary_integer:=0;
   v_celular            number(8);
   v_contador           number(8):=0;
   v_minutos_hn_e       number(8);
   v_minutos_hb_e       number(8);
   v_minutos_hn_s       number(8);
   v_minutos_hb_s       number(8);
   v_llamadas_e         number(8);
   v_llamadas_s         number(8);
   v_monto              number(14,4);
   v_monto_hn_e         number(14,4);
   v_monto_hb_e         number(14,4);
   v_monto_s            number(14,4);
   v_min_noct           number(14,4);
   v_min_econ           number(14,4);
   v_linea              varchar2(500);
   arch_out             utl_file.file_type;
   v_error              varchar2(1000);
   v_estado             number(1);
   v_cantidad           number(1);
   v_fecha              date;
   v_falta              varchar2(30);
   v_flag_e             number(1);
   v_flag_s             number(1);
begin
  v_fecha:=to_date(v_parametro,'mmyyyy');
  arch_out:=utl_file.fopen(donde,'prepago_arpu.txt','w');
  v_error:=to_char(v_fecha,'yyyy-mm');
  v_error:='DETALLE TRAFICO PREPAGO PARA PERIODO :'||v_error;
  utl_file.put_line(arch_out,v_error);
  utl_file.fclose(arch_out);
  inicia_matriz(v_tab_entrada,v_parametro,v_entrada);
  inicia_matriz(v_tab_salida,v_parametro,v_salida);
  inicia_matriz(v_tab_eos,v_parametro,v_eos);
  inicia_matriz(v_tab_eys,v_parametro,v_eys);
  for cc in paso loop
    begin
       v_minutos_hn_e    :=0;
       v_minutos_hb_e    :=0;
       v_minutos_hn_s    :=0;
       v_minutos_hb_s    :=0;
       v_llamadas_e      :=0;
       v_llamadas_s      :=0;
       v_monto_hn_e      :=0;
       v_monto_hb_e      :=0;
       v_monto_s         :=0;
       v_flag_e          :=0;
       v_flag_s          :=0;
       v_cantidad        :=0;
       v_contador        :=0;
       v_contador        :=v_contador + 1;
       -- Minutos especiales solo para tabla de salida....
       v_min_noct        :=0;
       v_min_econ        :=0;
       if mod(v_contador,10000)=0 then
         v_error:='Va en la fila :'||v_contador;
         utl_file.put_line(arch_err,v_error);
       end if;
       for dd in minutos(cc.celular,v_fecha) loop
	 v_monto:=0;
         if dd.tipo=1 then  -- Entrada
	   v_flag_e:=1;
         else
	   if v_flag_s=0 then
	     -- minutos nocturnos...
	     begin
	       select sum(total_charge) into v_min_noct
	       from gr_psd_comverse_valores
	       where subscriber_id=cc.celular
	       and balance_type='3';
	       v_min_noct:=nvl(v_min_noct,0);
	     exception
	       when others then
		 v_min_noct:=0;
	     end;
	     -- minutos economicos...
	     begin
	       select sum(total_charge) into v_min_econ
	       from gr_psd_comverse_valores
	       where subscriber_id=cc.celular
	       and balance_type='2';
	       v_min_econ:=nvl(v_min_econ,0);
	     exception
	       when others then
		 v_min_econ:=0;
	     end;
	     -- Monto de salida...
	     begin
	       v_flag_s:=1;
	       select sum(total_charge) into v_monto
	       from gr_psd_comverse_valores
	       where subscriber_id=cc.celular
	       and balance_type='0';
	       v_monto_s:=v_monto_s + v_monto;
	     exception
	       when others then
	         v_monto:=0;
		 v_monto_s:=v_monto_s + v_monto;
	     end;
	   end if;
         end if;
         v_falta:=to_char(cc.fecha,'mm-yyyy');
         if dd.horario=1 then    -- horario bajo
	   if dd.tipo = 1 then
	     v_minutos_hb_e:=v_minutos_hb_e + dd.minutos;
	     v_llamadas_e:=v_llamadas_e + dd.llamadas;
	     v_monto_hb_e:=v_monto_hb_e + dd.monto;
	   else
	     v_minutos_hb_s:=v_minutos_hb_s + dd.minutos;
	     v_llamadas_s:=v_llamadas_s + dd.llamadas;
	   end if;
         else                    -- horario normal
	   if dd.tipo = 1 then
	     v_minutos_hn_e:=v_minutos_hn_e + dd.minutos;
	     v_llamadas_e:=v_llamadas_e + dd.llamadas;
	     v_monto_hn_e:=v_monto_hn_e + dd.monto;
	   else
	     v_minutos_hn_s:=v_minutos_hn_s + dd.minutos;
	     v_llamadas_s:=v_llamadas_s + dd.llamadas;
	   end if;
         end if;
       end loop;
       v_minutos_hn_s  :=nvl(v_minutos_hn_s,0);
       v_minutos_hb_s  :=nvl(v_minutos_hb_s,0);
       v_minutos_hn_e  :=nvl(v_minutos_hn_e,0);
       v_minutos_hb_e  :=nvl(v_minutos_hb_e,0);
       v_monto_hn_e    :=nvl(v_monto_hn_e,0);
       v_monto_hb_e    :=nvl(v_monto_hb_e,0);
       v_monto_s       :=nvl(v_monto_s,0);
       v_llamadas_s    :=nvl(v_llamadas_s,0);
       v_llamadas_e    :=nvl(v_llamadas_e,0);
       v_cantidad:=1;
       -- Cuadro de entrada....
       if (v_minutos_hn_e+v_minutos_hb_e)=0 then
        v_cantidad      :=0;
	v_monto_hn_e    :=0;
	v_monto_hb_e    :=0;
	v_llamadas_e    :=0;
       else
        v_cantidad:=1;
       end if;
       if to_date(v_falta,'mm-yyyy')>v_fecha then  -- fuera del rango
         v_error:='Error en abonado:'||cc.celular||' tiene a :'||v_fecha;
	 utl_file.put_line(arch_err,v_error);
       else
	 inserta_matriz(v_minutos_hn_e,
			v_minutos_hb_e,
			v_monto_hn_e,
			v_monto_hb_e,
			v_llamadas_e,
			v_cantidad,
			v_falta,
			0,0,v_entrada,
			v_tab_entrada);
       end if;
       v_cantidad:=1;
       -- Cuadro de Salida....
       if (v_minutos_hn_s+v_minutos_hb_s)=0 then
	v_cantidad      :=0;
	v_monto_s       :=0;
	v_llamadas_s    :=0;
       else
	v_cantidad:=1;
       end if;
       if to_date(v_falta,'mm-yyyy')>v_fecha then  -- fuera del rangoi
	v_error:='Error en abonado:'||cc.celular||' tiene a :'||v_fecha;
	utl_file.put_line(arch_err,v_error);
       else
	 inserta_matriz(v_minutos_hn_s,
	                v_minutos_hb_s,
			v_monto_s,
			0,
			v_llamadas_s,
			v_cantidad,
			v_falta,
			v_min_noct,v_min_econ,v_salida,
			v_tab_salida);
       end if;
       v_cantidad:=1;
       -- Cuadro de EoS
       if (v_minutos_hn_s+v_minutos_hb_s+v_minutos_hn_e+v_minutos_hb_e)=0 then
         v_cantidad      :=0;
         v_monto_s       :=0;
         v_llamadas_s    :=0;
         v_monto_hn_e    :=0;
         v_monto_hb_e    :=0;
         v_llamadas_e    :=0;
       else
	 v_cantidad:=1;
       end if;
       if to_date(v_falta,'mm-yyyy')>v_fecha then  -- fuera del rango
	 v_error:='Error en la fecha del abonado:'||cc.celular||' tiene a :'||v_fecha;
	 utl_file.put_line(arch_err,v_error);
       else
	 inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			v_minutos_hb_s+v_minutos_hb_e,
			v_monto_s+v_monto_hn_e+v_monto_hb_e,
			0,
			v_llamadas_s+v_llamadas_e,
			v_cantidad,
			v_falta,
			0,0,v_eos,
			v_tab_eos);
       end if;
       v_cantidad:=1;
       -- Cuadro de EyS
       if v_flag_e + v_flag_s < 2 then          -- No tiene ambas llamadas..
	 v_cantidad      :=0;
	 v_monto_s       :=0;
	 v_llamadas_s    :=0;
	 v_monto_hn_e    :=0;
	 v_monto_hb_e    :=0;
	 v_llamadas_e    :=0;
	 v_minutos_hn_e  :=0;
	 v_minutos_hb_e  :=0;
	 v_minutos_hn_s  :=0;
	 v_minutos_hb_s  :=0;
       end if;
       if to_date(v_falta,'mm-yyyy')>v_fecha then  -- fuera del rango
	  v_error:='Error en abonado:'||cc.celular||' tiene a :'||v_fecha;
	  utl_file.put_line(arch_err,v_error);
       else                                        -- se acumula
	  inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			 v_minutos_hb_s+v_minutos_hb_e,
			 v_monto_s+v_monto_hn_e+v_monto_hb_e,
			 0,
			 v_llamadas_s+v_llamadas_e,
			 v_cantidad,
			 v_falta,
			 0,0,v_eys,
			 v_tab_eys);
       end if;
    exception
      when others then
        v_error:='Se cayo en la fila:'||cc.celular;
        utl_file.put_line(arch_err,v_error);
        utl_file.put_line(arch_err,sqlerrm);
    end;
  end loop;
  v_error:='Termino el proceso de la informacion...';
  utl_file.put_line(arch_err,v_error);
  lista_matriz(v_tab_entrada,v_entrada);
  lista_matriz(v_tab_salida,v_salida);
  lista_matriz(v_tab_eos,v_eos);
  lista_matriz(v_tab_eys,v_eys);
  v_error:='Salio sin problemas, filas procesadas:'||v_contador;
  utl_file.put_line(arch_err,v_error);
exception
  when others then
    utl_file.put_line(arch_err,'Se cayo...:'||sqlerrm);
end principal;
end GR_PAC_ARPUPREPAGO;
/
SHOW ERRORS
