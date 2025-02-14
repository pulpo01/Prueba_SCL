CREATE OR REPLACE PACKAGE BODY        gr_pac_arpu_contrato AS
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
      universo      number(10));
   type tabla is table of reg_new
     index by binary_integer;
/* ---------------------------------------------------------- */
   v_entrada_emp        binary_integer:=0;
   v_entrada_nat        binary_integer:=1;
   v_salida_emp         binary_integer:=2;
   v_salida_nat         binary_integer:=3;
   v_eos_emp            binary_integer:=4;
   v_eos_nat            binary_integer:=5;
   v_eys_emp            binary_integer:=6;
   v_eys_nat            binary_integer:=7;
   donde                varchar2(30):='/samba/ready';
  /* ----------------------------------------------------------- */
  PROCEDURE ejecuta_sql(p_sql   in     varchar2,
			      p_resul in out number) As
    v_cursor     integer;
    v_resul      integer:=0;
    v_error      varchar2(300);
  BEGIN
    v_cursor := DBMS_SQL.OPEN_CURSOR;
    begin
      DBMS_SQL.PARSE(v_cursor, p_sql, DBMS_SQL.V7);
      v_resul := DBMS_SQL.EXECUTE(v_cursor);
    exception
      when others then
	v_resul:=-1;
	v_error:=to_char(sqlcode)||':'||substr(sqlerrm,1,100);
	raise_application_error(-20101,v_error);
    end;
    DBMS_SQL.CLOSE_CURSOR(v_cursor);
    p_resul:=v_resul;
  END ejecuta_sql;
/* ---------------------------------------------------------- */
PROCEDURE extrae (p_desde   in     number,
                  p_hasta   in     number,
                  p_ciclo   in     number,
                  p_tabla   in     varchar2,
                  arch_err  in out utl_file.file_type) AS
  v_sql      varchar2(3000);
  v_resul    number(8);
  v_error    varchar2(200);
begin
  v_sql:='insert into gr_exp_detalle_temp (correl,cliente,ciclo, ';
  v_sql:=v_sql||'tipdocu,abonado,reparto,cargo)  ';
  v_sql:=v_sql||'select ';
  v_sql:=v_sql||'a.ind_ordentotal,a.cod_cliente,a.cod_ciclfact, ';
  v_sql:=v_sql||'a.cod_tipdocum,b.num_abonado,0,sum(b.imp_facturable) ';
  v_sql:=v_sql||'from fa_histdocu a,'||p_tabla||' b,fa_conceptos c  ';
  v_sql:=v_sql||'where a.ind_ordentotal>='||p_desde||' ';
  v_sql:=v_sql||'and a.ind_ordentotal<='||p_hasta||' ';
  v_sql:=v_sql||'and a.cod_tipdocum in (2,69,40,73)  ';
  v_sql:=v_sql||'and a.cod_ciclfact='||p_ciclo||' ';
  v_sql:=v_sql||'and a.ind_ordentotal=b.ind_ordentotal  ';
  v_sql:=v_sql||'and b.cod_concepto=c.cod_concepto  ';
  v_sql:=v_sql||'and b.cod_producto in (1,5)  ';
  v_sql:=v_sql||'and c.cod_tipconce!=1  ';
  v_sql:=v_sql||'group by a.ind_ordentotal,a.cod_cliente,  ';
  v_sql:=v_sql||'a.cod_ciclfact,a.cod_tipdocum,b.num_abonado ';
  ejecuta_sql(v_sql,v_resul);
  if v_resul!=-1 then
    ejecuta_sql('commit',v_resul);
    v_error:='Carga de datos Ok. ciclo:'||p_ciclo;
    utl_file.put_line(arch_err,v_error);
  else
    ejecuta_sql('rollback',v_resul);
    v_error:='Carga de datos Con ERROR ciclo:'||p_ciclo;
    utl_file.put_line(arch_err,v_error);
  end if;
end extrae;
/* ---------------------------------------------------------- */
PROCEDURE pondera_clientes(arch_err  in out utl_file.file_type) AS
   cursor clientes is select
      cliente       cliente,
      abonado       abonado,
      cargo         cargo
      from gr_exp_detalle_temp
      where abonado=0;
   v_reparte         number(10);
   v_abonado         number(5);
   v_bandera         number(1);
   v_error           varchar2(100);
begin
  for cc in clientes loop
     v_bandera:=0;
     begin
       select count(distinct abonado)
       into v_abonado
       from gr_exp_detalle_temp
       where cliente=cc.cliente
       and abonado!=0;
       v_abonado:=nvl(v_abonado,0);
     exception
       when others then
	  v_error:='Error en cantidad de abonados para cliente:'||cc.cliente;
	  utl_file.put_line(arch_err,v_error);
	  utl_file.put_line(arch_err,sqlerrm);
	  v_bandera:=0;
     end;
     v_abonado:=nvl(v_abonado,0);
     if v_abonado=0 then
       v_bandera:=1;
     end if;
     if v_bandera=0 then
       v_reparte:=trunc((cc.cargo/v_abonado) + 0.5);
       update gr_exp_detalle_temp set reparto=v_reparte
       where cliente=cc.cliente
       and abonado!=0;
       commit;
     end if;
  end loop;
  v_error:='Salio todo bien...';
  utl_file.put_line(arch_err,v_error);
exception
  when others then
    v_error:='Se cayo  ...';
    utl_file.put_line(arch_err,v_error);
    utl_file.put_line(arch_err,sqlerrm);
end pondera_clientes;
/* ---------------------------------------------------------- */
PROCEDURE llena_archivo(arch_err in out utl_file.file_type) AS
  cursor paso is select
    abonado          abonado,
    count(*)         cuenta
    from gr_exp_detalle_temp
    group by abonado;
    arch_ok        utl_file.file_type;
    v_error        varchar2(100);
    celular        GA_ABOCEL.NUM_CELULAR%TYPE;
    v_bandera      number(1);
    fecha          varchar2(10);
    v_linea        varchar2(30);
begin
   arch_ok:=utl_file.fopen(donde,'celulares_contrato.txt','w');
   for cc in paso loop
     v_bandera:=0;
     if cc.abonado=0 then
       v_bandera:=1;
     end if;
     if v_bandera=0 then
       begin
         select num_celular,to_char(fec_alta,'mm-yyyy')
         into celular,fecha
         from ga_abocel
         where num_abonado=cc.abonado;
       exception
	 when no_data_found then
	   begin
	     select num_celular,to_char(fec_alta,'mm-yyyy')
	     into celular,fecha
	     from ga_habocel
	     where num_abonado=cc.abonado;
	   exception
	     when others then
		v_bandera:=1;
		utl_file.put_line(arch_err,'Error abonado:'||to_char(cc.abonado));
		utl_file.put_line(arch_err,sqlerrm);
	   end;
         when others then
	   v_bandera:=1;
	   utl_file.put_line(arch_err,'Error abonado:'||to_char(cc.abonado));
	   utl_file.put_line(arch_err,sqlerrm);
       end;
     end if;
     if v_bandera=0 then
       v_linea:=celular||'|'||fecha||'|'||cc.abonado;
       utl_file.put_line(arch_ok,v_linea);
     end if;
   end loop;
   utl_file.put_line(arch_err,'salio todo ok..');
   utl_file.fclose(arch_ok);
exception
  when others then
     utl_file.put_line(arch_err,'Se cayo en alguna parte...:'||sqlerrm);
     utl_file.fclose(arch_ok);
end llena_archivo;
/* ---------------------------------------------------------- */
Procedure inicia_matriz (v_tabla out tabla,
			 p_fecha in varchar2) is
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
Function tipo_rut(p_abonado number) Return number is
  v_retorno     number(1);
  p_rut         number(8);
begin
  v_retorno:=0;
  begin
    select to_number(substr(b.num_ident,1,instr(b.num_ident,'-',1,1)-1))
    into p_rut
    from ga_abocel a,ge_clientes b
    where a.num_abonado=p_abonado
    and a.cod_cliente=b.cod_cliente
    and b.cod_tipident='01';
  exception
   when others then
     v_retorno:=-1;
  end;
  if v_retorno=0 then
    if p_rut<50000000 then
      v_retorno:=1;
    else
      v_retorno:=2;
    end if;
  else
    v_retorno:=1;
  end if;
  Return v_retorno;
end tipo_rut;
/* ---------------------------------------------------------- */
Procedure lista_matriz(v_tabla   in out tabla,
		       v_archivo in     binary_integer) is
/* Lista el contenido de la matrz en forma traspuesta         */
/* ---------------------------------------------------------- */
    v_linea          varchar2(500);
    v_titulo         varchar2(150);
    v_detalle        varchar2(50);
    arch             utl_file.file_type;
begin
    pone_minutos(v_tabla);
    arch:=utl_file.fopen(donde,'contrato_arpu.txt','a');
    utl_file.put_line(arch,' ');
    utl_file.put_line(arch,' ');
    if v_archivo=0 then
      v_titulo:='Detalle de Trafico Contrato Entrada Empresa';
      v_detalle:=' Entrada';
    elsif v_archivo=1 then
      v_titulo:='Detalle de Trafico Contrato Entrada Individual';
      v_detalle:=' Entrada';
    elsif v_archivo=2 then
      v_titulo:='Detalle de Trafico Contrato Salida Empresa';
      v_detalle:=' Salida';
    elsif v_archivo=3 then
      v_titulo:='Detalle de Trafico Contrato Salida Individual';
      v_detalle:=' Salida';
    elsif v_archivo=4 then
      v_titulo:='Detalle de Trafico Contrato Entrada o Salida Empresa';
      v_detalle:=' Entrada o Salida';
    elsif v_archivo=5 then
      v_titulo:='Detalle de Trafico Contrato Entrada o Salida Individual';
      v_detalle:=' Entrada o Salida';
    elsif v_archivo=6 then
      v_titulo:='Detalle de Trafico Contrato Entrada y Salida Empresa';
      v_detalle:=' Entrada y Salida';
    else
      v_titulo:='Detalle de Trafico Contrato Entrada y Salida Individual';
      v_detalle:=' Entrada y Salida';
    end if;
    utl_file.put_line(arch,v_titulo);
    -- mostramos en el archivo final, como quedaria la matriz...
    for i in 0..10 loop       -- primero por columnas....
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
	  if v_archivo>1 then
	    v_linea:='$ Monto'||v_detalle;
	  else
	    v_linea:='$ Monto Hor. Normal';
	  end if;
       elsif i=8 then
	  if v_archivo>1 then
	    v_linea:='-----';
	  else
	    v_linea:='$ Monto Hor. Bajo';
	  end if;
       elsif i=9 then
	  v_linea:='# Llamadas total';
       else
	  v_linea:='Universo Total Abonados';
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
	 else
	   v_linea:=v_linea||'|'||v_tabla(j).universo;
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
   else
     v_tabla(13).abonados:=v_tabla(13).abonados + p_cuenta;
     v_tabla(13).segs_hn :=v_tabla(13).segs_hn  + p_min_hn;
     v_tabla(13).segs_hb :=v_tabla(13).segs_hb  + p_min_hb;
     v_tabla(13).mto_hn  :=v_tabla(13).mto_hn   + p_mto_hn;
     v_tabla(13).mto_hb  :=v_tabla(13).mto_hb   + p_mto_hb;
     v_tabla(13).llamadas:=v_tabla(13).llamadas + p_llamadas;
     v_tabla(13).universo:=v_tabla(13).universo + 1;
   end if;
end;
/* ---------------------------------------------------------- */
PROCEDURE principal (v_parametro in     varchar2,
		     arch_err    in out utl_file.file_type) AS
   cursor minutos(p_celular GA_ABOCEL.NUM_CELULAR%TYPE, p_fecha date) is select
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
   t_entrada_emp        tabla;
   i_entrada_emp        binary_integer;
   t_salida_emp         tabla;
   i_salida_emp         binary_integer;
   t_eys_emp            tabla;
   i_eys_emp            binary_integer;
   t_eos_emp            tabla;
   i_eos_emp            binary_integer;
   t_entrada_nat        tabla;
   i_entrada_nat        binary_integer;
   t_salida_nat         tabla;
   i_salida_nat         binary_integer;
   t_eys_nat            tabla;
   i_eys_nat            binary_integer;
   t_eos_nat            tabla;
   i_eos_nat            binary_integer;
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
   v_linea              varchar2(500);
/* -----------------------------------------------------------  */
   arch_in              utl_file.file_type;
   arch_out             utl_file.file_type;
   v_error              varchar2(1000);
   v_estado             number(1);
   v_cantidad           number(1);
   v_fecha              date;
   v_falta              varchar2(30);
   v_abonado            number(8);
   v_celular            GA_ABOCEL.NUM_CELULAR%TYPE;
   v_switch             number(1);
   v_flag_e             number(1);
   v_flag_s             number(1);
   v_pos_separador_1    NUMBER(3);
   v_pos_separador_2    NUMBER(3);
begin
  v_fecha:=to_date(v_parametro,'mmyyyy');
  arch_in:=utl_file.fopen(donde,'celulares_contrato.txt','r');
  arch_out:=utl_file.fopen(donde,'contrato_arpu.txt','w');
  inicia_matriz(t_entrada_emp,v_parametro);
  inicia_matriz(t_entrada_nat,v_parametro);
  inicia_matriz(t_salida_emp,v_parametro);
  inicia_matriz(t_salida_nat,v_parametro);
  inicia_matriz(t_eos_emp,v_parametro);
  inicia_matriz(t_eos_nat,v_parametro);
  inicia_matriz(t_eys_emp,v_parametro);
  inicia_matriz(t_eys_nat,v_parametro);
  v_error:=to_char(v_fecha,'yyyy-mm');
  v_error:='DETALLE DE TRAFICO DE CLIENTES CONTRATO '||v_error;
  utl_file.put_line(arch_out,v_error);
  utl_file.fclose(arch_out);
  utl_file.put_line(arch_err,'Inicia las matrices...');
  v_estado:=1;
  while v_estado=1 loop
    begin
       utl_file.get_line(arch_in,v_linea);
       v_pos_separador_1 := INSTR(v_linea, '|', 1, 1);
       v_pos_separador_2 := INSTR(v_linea, '|', v_pos_separador_1 + 1, 1);
       v_celular:=to_number(substr(v_linea, 1, v_pos_separador_1 - 1));
       v_falta:=substr(v_linea, v_pos_separador_1 + 1, v_pos_separador_2 - v_pos_separador_1 - 1);
       v_abonado:=to_number(substr(v_linea, v_pos_separador_2 + 1));
       v_switch:=tipo_rut(v_abonado);
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
       v_contador        :=v_contador + 1;
       if mod(v_contador,10000)=0 then
         v_error:='Va en la fila :'||v_contador;
         utl_file.put_line(arch_err,v_error);
       end if;
       for dd in minutos(v_celular,v_fecha) loop
	 v_monto:=0;
         if dd.tipo=1 then  -- Entrada
	   v_flag_e:=1;
         else
	   if v_flag_s=0 then
	     -- Monto de salida...
	     begin
	       v_flag_s:=1;
	       select cargo+reparto into v_monto_s
	       from gr_exp_detalle_temp
	       where abonado=v_abonado;
	       v_monto_s:=nvl(v_monto_s,0);
	     exception
	       when others then
	         v_monto_s:=0;
	     end;
	   end if;
         end if;
         -- v_falta:=to_char(cc.fecha,'mm-yyyy');
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
         v_error:='Error en abonado:'||v_celular||' tiene a :'||v_fecha;
	 utl_file.put_line(arch_err,v_error);
       else
	 if v_switch=1 then
	    inserta_matriz(v_minutos_hn_e,
			   v_minutos_hb_e,
			   v_monto_hn_e,
			   v_monto_hb_e,
			   v_llamadas_e,
			   v_cantidad,
			   v_falta,
			   t_entrada_nat);
	 else
	   inserta_matriz(v_minutos_hn_e,
			  v_minutos_hb_e,
			  v_monto_hn_e,
			  v_monto_hb_e,
			  v_llamadas_e,
			  v_cantidad,
			  v_falta,
			  t_entrada_emp);
	 end if;
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
	v_error:='Error en abonado:'||v_celular||' tiene a :'||v_fecha;
	utl_file.put_line(arch_err,v_error);
       else
	 if v_switch=1 then
	   inserta_matriz(v_minutos_hn_s,
	                  v_minutos_hb_s,
			  v_monto_s,
			  0,
			  v_llamadas_s,
			  v_cantidad,
			  v_falta,
			  t_salida_nat);
	 else
	   inserta_matriz(v_minutos_hn_s,
			  v_minutos_hb_s,
			  v_monto_s,
			  0,
			  v_llamadas_s,
			  v_cantidad,
			  v_falta,
			  t_salida_emp);
	 end if;
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
	 v_error:='Error en la fecha del abonado:'||v_celular||' tiene a :'||v_fecha;
	 utl_file.put_line(arch_err,v_error);
       else
	 if v_switch=1 then
	   inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			  v_minutos_hb_s+v_minutos_hb_e,
			  v_monto_s+v_monto_hn_e+v_monto_hb_e,
			  0,
			  v_llamadas_s+v_llamadas_e,
			  v_cantidad,
			  v_falta,
			  t_eos_nat);
	 else
	   inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			  v_minutos_hb_s+v_minutos_hb_e,
			  v_monto_s+v_monto_hn_e+v_monto_hb_e,
			  0,
			  v_llamadas_s+v_llamadas_e,
			  v_cantidad,
			  v_falta,
			  t_eos_emp);
	 end if;
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
	  v_error:='Error en abonado:'||v_celular||' tiene a :'||v_fecha;
	  utl_file.put_line(arch_err,v_error);
       else                                        -- se acumula
	  if v_switch=1 then
	  inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			 v_minutos_hb_s+v_minutos_hb_e,
			 v_monto_s+v_monto_hn_e+v_monto_hb_e,
			 0,
			 v_llamadas_s+v_llamadas_e,
			 v_cantidad,
			 v_falta,
			 t_eys_nat);
	 else
	   inserta_matriz(v_minutos_hn_s+v_minutos_hn_e,
			  v_minutos_hb_s+v_minutos_hb_e,
			  v_monto_s+v_monto_hn_e+v_monto_hb_e,
			  0,
			  v_llamadas_s+v_llamadas_e,
			  v_cantidad,
			  v_falta,
			  t_eys_emp);
	 end if;
       end if;
    exception
      when others then
	v_estado:=0;
    end;
  end loop;
  v_error:='Termino el proceso de la informacion...';
  utl_file.put_line(arch_err,v_error);
  lista_matriz(t_entrada_emp,v_entrada_emp);
  lista_matriz(t_entrada_nat,v_entrada_nat);
  lista_matriz(t_salida_emp,v_salida_emp);
  lista_matriz(t_salida_nat,v_salida_nat);
  lista_matriz(t_eos_emp,v_eos_emp);
  lista_matriz(t_eos_nat,v_eos_nat);
  lista_matriz(t_eys_emp,v_eys_emp);
  lista_matriz(t_eys_nat,v_eys_nat);
  v_error:='Salio sin problemas, filas procesadas:'||v_contador;
  utl_file.put_line(arch_err,v_error);
  utl_file.fclose(arch_in);
  utl_file.fclose(arch_out);
exception
  when others then
    utl_file.put_line(arch_err,'Se cayo...:'||sqlerrm);
    utl_file.fclose(arch_in);
    utl_file.fclose(arch_out);
end principal;
end gr_pac_arpu_contrato;
/
SHOW ERRORS
