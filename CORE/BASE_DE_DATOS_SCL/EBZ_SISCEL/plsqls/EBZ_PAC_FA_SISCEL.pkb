CREATE OR REPLACE PACKAGE BODY            EBZ_PAC_FA_SISCEL
 AS
PROCEDURE FA_SALDO_CTA(
                identificacion in varchar2,
                tip_identifica in varchar2,
                tip_saldo      in varchar2,
                fecha_docto    out t_fecha_docto,   -- fecha del docuemnto
                descrip_docto  out t_descrip_docto, --descripcion del documento
                folio_docto    out t_folio_docto, --Folio del documento
                debe           out t_debe,      --Debe del docuemtno
                haber          out t_haber,     --Haber en el documento
                saldo          out t_saldo,     --Saldo en el documento
                num_cuotas     out t_num_cuotas,  --Cantidad de Cuotas
                cod_cliente    out t_cod_cliente, -- Codigo del Cliente due?o del documenro
                estado         out t_estado,    -- Estado puede ser MOROSO, VIGENTE O PAFADO
                error          out t_error
                ) IS
    /*
    Nombre del procedimeinto:FA_SALDO_CTA   --- Consulta de Saldo en Cuenta Corriente
    PARAMETROS DE ENTRADA:
        identificacion  Puede ser el rut de la cuenta o el codigo del cliente
    tip_identifica  un valor R indica identificacion corresponde al rut de la cuenta , C indica identificacion corresponde al Codigo del cliente
    tip_saldo       Desplegar saldos vigentes (V) o Historicos (H)
    */
    error_param    Exception;
    cod_cliente1   number(8);
    cod_clienteA   number(8);
    ssql           varchar2(1600);
    cur_datos      integer;
    resp_cur_datos integer;
    f_fecha        varchar2(1);
    i              integer;
    j              integer;
    n_error        integer;
    /* variables para traspaso de datos */
    col1           varchar2(10);
    col2           varchar2(40);
    col3           number(9);
    col4           number(14,4);
    col5           number(14,4);
    col6           number(14,4);
    col7           number(8);
    col8           number(8);
    col9           varchar2(10);  -- trae la fecha de vencimiento como string
    col10          varchar2(10);  -- trae la fecha de pago como string
    BEGIN
      n_error:= 1;
      i:=0;
      f_fecha := chr(39);
      if tip_saldo <> 'H' and tip_saldo <> 'V' then
         error (n_error):= 'Tipo de saldo puede ser H o V';
         n_error:= n_error +1;
         raise error_param;
      end if;
      if tip_identifica <> 'C' and tip_identifica <> 'R' then
         error (n_error):= 'Tipo de identificacion puede ser C o R';
         n_error:= n_error +1;
         raise error_param;
      end if;
      if tip_saldo = 'H' then
         if tip_identifica = 'R' then
            ssql:= 'SELECT cod_cuenta ' ||
                   'FROM ga_cuentas '   ||
                   'WHERE num_ident = '  || f_fecha || ltrim(rtrim(identificacion)) || f_fecha || ' ';
            cur_datos := dbms_sql.open_cursor;
            dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
            dbms_sql.define_column(cur_datos, 1, cod_clienteA );
            resp_cur_datos:= dbms_sql.execute (cur_datos);
            j:=dbms_sql.fetch_rows(cur_datos);
            if j = 0 then
               cod_cliente1:= 0;
            else
               dbms_sql.column_value (cur_datos,1,cod_clienteA);
               cod_cliente1:= cod_clienteA;
            end if;
            dbms_sql.close_cursor (cur_datos);
            /*------consulta doctos por cuenta obtenida del rut historico------------------*/
            ssql:= 'SELECT ' ||
                   'to_char(a.fec_efectividad,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fecha,' ||
				   'g.des_tipdocum, a.num_folio, sum(debe),sum(haber), sum(debe - haber) saldo,' ||
				   'a.num_cuota, a.cod_cliente,to_char( a.fec_vencimie,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fvencimiento,' ||
                   'to_char( a.fec_pago,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ' ) fpago' || ' ' ||
                   'from  ( ' || 'select a.cod_cliente, a.fec_efectividad, a.num_folio, count(*) registros,' ||
                   'sum(a.importe_debe) debe,  sum(a.importe_haber) haber, a.letra,a.cod_vendedor_agente,' ||
				   'a.cod_centremi, a.cod_tipdocum,a.num_secuenci,a.num_cuota,a.fec_vencimie,' ||
                   'a.fec_pago ' || 'from co_cartera a, ge_clientes b ' ||
				   'where a.cod_cliente = b.cod_cliente and  b.cod_cuenta = ' || cod_cliente1 || ' ' ||
                   'group by a.cod_cliente, a.fec_efectividad, a.num_folio,a.letra,a.cod_vendedor_agente,a.cod_centremi,' ||
				   'a.cod_tipdocum,a.num_secuenci,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
                   'UNION ALL ' ||
                   'select  a.cod_cliente, a.fec_efectividad, a.num_folio, count(*) registros,sum(a.importe_debe) debe,' ||
				   'sum(a.importe_haber) haber,a.letra,a.cod_vendedor_agente,a.cod_centremi,' ||
				   'a.cod_tipdocum,max(a.num_secuenci) num_secuenci,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
                   'from co_cancelados a, ge_clientes b ' ||
                   'where a.cod_cliente = b.cod_cliente and  b.cod_cuenta = ' || cod_cliente1 || ' ' ||
                   'group by a.cod_cliente, a.fec_efectividad, a.num_folio,a.letra,a.cod_vendedor_agente,a.cod_centremi,' ||
				   'a.cod_tipdocum,a.num_cuota,a.fec_vencimie,a.fec_pago ' || ') a ,ge_tipdocumen g ' ||
                   'WHERE  a.cod_tipdocum = g.cod_tipdocum  (+) ' ||
                   'group by  a.cod_cliente, a.fec_efectividad, g.des_tipdocum,a.num_folio,a.letra, a.cod_vendedor_agente,' ||
				   'a.cod_centremi,a.cod_tipdocum,a.num_secuenci,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
                   'order by  a.fec_efectividad ';
             /*----FIN--consulta doctos por cuenta obtenida del rut historico------------------*/
         elsif tip_identifica = 'C' then
               cod_cliente1 := to_number(ltrim(rtrim(identificacion)));
               ssql:= 'SELECT ' ||
                      'to_char( a.fec_efectividad,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fecha, g.des_tipdocum, a.num_folio,sum(debe),sum(haber),sum(debe - haber) saldo, a.num_cuota, a.cod_cliente,to_char(a.fec_vencimie,' || f_fecha || 'dd-mm-yyyy'|| f_fecha || ') fvencimiento, to_char(a.fec_pago,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ' ) fpago ' ||
                      'From ( ' ||
                      'select  a.cod_cliente, a.fec_efectividad, a.num_folio,a.cod_tipdocum, count(*) registros,  sum(a.importe_debe) debe,sum(a.importe_haber) haber,max(a.num_secuenci) num_secuenci,a.cod_vendedor_agente ,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
                      'from  co_cartera a, ge_clientes b ' ||
                      'where a.cod_cliente = b.cod_cliente and b.cod_cliente = ' || cod_cliente1 || ' ' ||
                      'group by a.cod_cliente, a.fec_efectividad, a.num_folio,a.cod_tipdocum, a.cod_vendedor_agente ,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
                      'UNION ALL ' ||
                      'select   a.cod_cliente, a.fec_efectividad, a.num_folio, a.cod_tipdocum,count(*) registros,  sum(a.importe_debe) debe, sum(a.importe_haber) haber ,max(a.num_secuenci) num_secuenci,a.cod_vendedor_agente ,a.num_cuota,a.fec_vencimie,a.fec_pago ' ||
					  'from co_cancelados a, ge_clientes b ' ||
                      'where a.cod_cliente = b.cod_cliente and b.cod_cliente =  ' || cod_cliente1 || ' ' ||
                      'group by a.cod_cliente, a.fec_efectividad,a.num_folio, a.cod_tipdocum,a.cod_vendedor_agente,a.num_cuota,a.fec_vencimie,a.fec_pago ) a ,ge_tipdocumen g ' ||
                      'WHERE  a.cod_tipdocum = g.cod_tipdocum  (+) ' ||
                      'group by a.cod_cliente, a.fec_efectividad,g.des_tipdocum, a.num_folio,a.cod_tipdocum,a.num_secuenci,a.cod_vendedor_agente,a.num_cuota,a.fec_vencimie,a.fec_pago ';
        end if;
    elsif tip_saldo = 'V' then
          if tip_identifica = 'R' then
             ssql:= 'SELECT cod_cuenta ' ||
                    'FROM ga_cuentas '   ||
                    'WHERE num_ident = '  || f_fecha || ltrim(rtrim(identificacion)) || f_fecha || ' ';
                    cur_datos := dbms_sql.open_cursor;
                    dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                    dbms_sql.define_column(cur_datos, 1, cod_clienteA );
                    resp_cur_datos:= dbms_sql.execute (cur_datos);
                    j:=dbms_sql.fetch_rows(cur_datos);
                    if j = 0 then
                       cod_cliente1:= 0;
                    else
                       dbms_sql.column_value (cur_datos,1,cod_clienteA);
                       cod_cliente1:= cod_clienteA;
                    end if;
                    dbms_sql.close_cursor (cur_datos);
             ssql := 'SELECT ' ||
                     'to_char(a.fec_efectividad,' || f_fecha || 'dd-mm-yyyy' || f_fecha || '),g.des_tipdocum, a.num_folio, sum(a.importe_debe) debe,sum(a.importe_haber) haber, sum(a.importe_debe-a.importe_haber) saldo ,a.num_cuota, a.cod_cliente, to_char(a.fec_vencimie,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fvencimiento, to_char(a.fec_pago,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ' ) fpago ' ||
                     'from co_cartera a, ge_clientes b,ge_tipdocumen g ' ||
                     'where a.cod_cliente = b.cod_cliente and ' ||
                     'a.cod_tipdocum = g.cod_tipdocum and b.cod_cuenta = ' || cod_cliente1 || ' ' ||
                     'group by a.cod_cliente, a.fec_efectividad,g.des_tipdocum, a.num_folio,a.letra,a.cod_vendedor_agente,a.cod_centremi,a.cod_tipdocum,a.num_cuota,a.fec_vencimie,a.fec_pago ';
          elsif tip_identifica = 'C' then
                cod_cliente1 := to_number(ltrim(rtrim(identificacion)));
                ssql := 'SELECT ' ||
                                         /*       1                                                                           2               3             4               5                           6                             7              8               9                                                                                              10*/
                        'to_char(g1.fec_efectividad,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fecha,g3.des_tipdocum,g1.num_folio,g1.importe_debe ,g1.importe_haber,(g1.importe_debe - g1.importe_haber) saldo,g1.num_cuota,g1.cod_cliente, to_char(g1.fec_vencimie,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ') fvencimiento, to_char(g1.fec_pago,' || f_fecha || 'dd-mm-yyyy' || f_fecha || ' ) fpago ' ||
                        'FROM co_cartera g1, ge_productos g2,ge_tipdocumen g3, co_conceptos g4 ' ||
                        'WHERE g1.cod_cliente = ' || cod_cliente1 || ' ' ||
                        'AND g1.cod_producto = g2.cod_producto '  ||
                        'AND g1.cod_tipdocum = g3.cod_tipdocum '  ||
                        'AND g1.cod_concepto = g4.cod_concepto '  ||
                        'order by g1.fec_efectividad ';
          end if;
     end if;
     cur_datos := dbms_sql.open_cursor;
     dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
     dbms_sql.define_column_char(cur_datos, 1, col1,10);
     dbms_sql.define_column_char(cur_datos, 2, col2,40);
     dbms_sql.define_column(cur_datos, 3, col3);
     dbms_sql.define_column(cur_datos, 4, col4);
     dbms_sql.define_column(cur_datos, 5, col5);
     dbms_sql.define_column(cur_datos, 6, col6);
     dbms_sql.define_column(cur_datos, 7, col7);
     dbms_sql.define_column(cur_datos, 8, col8);
     dbms_sql.define_column_char(cur_datos, 9, col9,10);
     dbms_sql.define_column_char(cur_datos, 10, col10,10);
     resp_cur_datos := dbms_sql.execute(cur_datos);
     i:=1;
     loop
        j:=dbms_sql.fetch_rows(cur_datos);
        if j = 0 then
           exit;
        end if;
        dbms_sql.column_value_char (cur_datos,1,col1);
        dbms_sql.column_value_char (cur_datos,2,col2);
        dbms_sql.column_value (cur_datos,3,col3);
        dbms_sql.column_value (cur_datos,4,col4);
        dbms_sql.column_value (cur_datos,5,col5);
        dbms_sql.column_value (cur_datos,6,col6);
        dbms_sql.column_value (cur_datos,7,col7);
        dbms_sql.column_value (cur_datos,8,col8);
        dbms_sql.column_value_char (cur_datos,9,col9);
        dbms_sql.column_value_char (cur_datos,10,col10);
        fecha_docto(i):= col1;
        descrip_docto(i):= col2;
        folio_docto(i):= col3;
        debe(i):= col4;
        haber(i):= col5;
        saldo(i):= col6;
        if col7 = 0 then
           num_cuotas(i):= 1;
        else
           num_cuotas(i):= col7;
        end if;
        cod_cliente(i):= col8;
        if to_date(col9,'dd-mm-yyyy') < sysdate and col10 IS NULL  then
            estado(i):= 'Impago';
        elsif not col10 is null then
                   if col6 > 0 then
              estado(i):= 'Impago';
                   elsif col6 <= 0 then
                      estado(i):= 'Pagado';
                   end if;
                else
                      estado(i):= 'Vigente';
        end if;
        i:= i + 1;
     end loop;
     dbms_sql.close_cursor(cur_datos);
     EXCEPTION
           WHEN error_param THEN
                error(n_error):= 'imposible continuar';
           WHEN OTHERS THEN
                 error(n_error):= TO_CHAR(SQLCODE);
           error(n_error+1):= sqlerrm;
END FA_SALDO_CTA;
PROCEDURE FA_MINUTOS(
                    identificacion in varchar2,
                    tip_identifica in varchar2,
                    cod_cicloa     in varchar2,
                    cod_cliente    out t_cod_cliente,
                    celular        out t_celular,
                    mi_contratados out t_minutos,
	                mi_usadosf      out t_minutos_f,
                    mi_disponibles out t_minutos,
                    mi_promo       out t_minutos,
	                mi_promo_usadof out t_minutos_f,
                    mi_promo_dispo out t_minutos,
                    plan_tarif     out t_plan_tarif,
                    tip_plan_tarif out t_tip_plan_tarif,
                    mi_usados      out t_minutos,
                    mi_promo_usado out t_minutos,
                    error          out t_error
                    )IS
       error_param    Exception;
       c_formato      varchar2(12);
       n_error        integer;
       cod_ciclo2     varchar2(6);
       cod_cliente1   number(8);
       num_clientes   integer;
       ssql           varchar2(1400);
       ssql1          varchar2(1400);
       cur_datos      integer;
       cur_datos1     integer;
       cur_datos2     integer;
       resp_cur_datos integer;
       c              varchar2(1);
       i              integer;
       j              integer;
       j1             integer;
       col1           varchar2(3);
       col2           varchar2(30);
       col3           varchar2(1);
       col4           number(6);
       col5           number(6);
	   m_consumido    ta_acumaire.SEG_CONSUMIDO%type;
       col_ncel       number(8);
       col_abonado    number(8);
       cod_clienteA   number(8);
       aux            number(8);
	   hora			  varchar2(2);
	   min1			  varchar2(2);
	   segundos		  varchar2(2);
	   aux_num		  number(12,6);

    BEGIN
      i:=1;
	  n_error:= 1;
      c:= chr(39);
      if tip_identifica <> 'C' and tip_identifica <> 'R' and tip_identifica <> 'A' then
         error (n_error):= 'Tipo de identificacion puede ser C o R o A';
         n_error:= n_error +1;
         raise error_param;
      end if;
      select to_char(fa_ciclfact.cod_ciclfact) into cod_ciclo2
      from fa_ciclfact
      where fa_ciclfact.cod_ciclo = to_number(cod_cicloa)
      and sysdate between fec_desdellam and fec_hastallam;
      if tip_identifica = 'R' or tip_identifica = 'C' or tip_identifica = 'A' then
         if tip_identifica = 'R' then
            ssql1:= 'SELECT b.cod_cliente ' ||
                    'FROM ga_cuentas a, ge_clientes b '   ||
                    'WHERE a.num_ident = '  || c || ltrim(rtrim(identificacion)) || c || ' ' ||
                    'AND a.cod_tipident = ' || c || '01' || c || ' ' ||
                    'AND a.cod_cuenta = b.cod_cuenta';
             cur_datos2 := dbms_sql.open_cursor;
             dbms_sql.parse(cur_datos2,ssql1, DBMS_SQL.V7);
             dbms_sql.define_column(cur_datos2, 1, cod_clienteA );
             resp_cur_datos:= dbms_sql.execute (cur_datos2);
             j1:=dbms_sql.fetch_rows(cur_datos2);
             if j1 = 0 then
                cod_cliente1:= 0;
             else
                dbms_sql.column_value(cur_datos2,1,cod_clienteA);
                cod_cliente1:= cod_clienteA;
             end if;
           elsif tip_identifica = 'A' then
                 ssql1:= 'SELECT  g1.cod_cliente cod_cliente ' ||
                         'FROM ga_abocel  g1, ga_usuarios g2 ' ||
                         'WHERE g1.num_celular = ' || Rtrim(Ltrim(identificacion)) || ' ' ||
                         'AND g1.cod_usuario = g2.cod_usuario ' ||
                         'AND g1.cod_situacion <> ' || c || 'BAA' || c;
                cur_datos1 := dbms_sql.open_cursor;
                dbms_sql.parse(cur_datos1,ssql1, DBMS_SQL.V7);
                dbms_sql.define_column(cur_datos1, 1, cod_clienteA );
                resp_cur_datos:= dbms_sql.execute (cur_datos1);
                j1:=dbms_sql.fetch_rows(cur_datos1);
                if j1 = 0 then
                   cod_cliente1:= 0;
                else
                   dbms_sql.column_value (cur_datos1,1,cod_clienteA);
                   cod_cliente1:= cod_clienteA;
                end if;
                dbms_sql.close_cursor (cur_datos1);
          else
              cod_cliente1 := identificacion;
          end if;
          loop
             if cod_cliente1 > 0 then
		         --error (n_error):= 'cod_cliente =' || to_char(cod_cliente1,'99999999');
   			     --n_error:= n_error +1;
                 /* los abonados del cliente */
                 ssql1:= 'SELECT g1.num_celular celular, g1.num_abonado num_abonado, g1.cod_cliente cod_cliente ' ||
                         'FROM ga_abocel  g1, ga_usuarios g2 ' ||
                         'WHERE g1.cod_cliente = ' || Rtrim(Ltrim(cod_cliente1)) || ' ' ||
                         'AND g1.cod_usuario = g2.cod_usuario ';
                 if tip_identifica = 'A' then
                    ssql1:= ssql1 || 'AND g1.num_celular = ' ||   Rtrim(Ltrim(identificacion)) || ' ' ||
                            'AND g1.cod_situacion <> ' || c || 'BAA' || c;
                 else
                     ssql1:= ssql1 || 'AND g1.cod_situacion <> ' || c || 'BAA' || c;
                 end if;
                 cur_datos1 := dbms_sql.open_cursor;
                 dbms_sql.parse(cur_datos1,ssql1, DBMS_SQL.V7);
                 dbms_sql.define_column(cur_datos1, 1, col_ncel );
                 dbms_sql.define_column(cur_datos1, 2, col_abonado );
                 resp_cur_datos:= dbms_sql.execute(cur_datos1);
                 i:=1;
                 loop
                    j1:=dbms_sql.fetch_rows(cur_datos1);
                    if j1 = 0 then
                       exit;
                    end if;
                    dbms_sql.column_value (cur_datos1,1,col_ncel);
                    dbms_sql.column_value (cur_datos1,2,col_abonado);
			        --error (n_error):= 'n_abonado = ' || to_char(col_abonado,'99999999') ;
	       			--n_error:= n_error +1;
                    /* obtengo tipo de plan, minutos contratados, plan (descripcion o codigo) */
                    ssql:= 'SELECT g1.cod_plantarif,g3.des_plantarif,g3.TIP_PLANTARIF, g3.NUM_UNIDADES ' ||
                           'FROM ta_plantarif g3, ga_abocel g1 ' ||
                           'WHERE g1.cod_cliente = ' || cod_cliente1 || ' ' ||
                           'AND g1.num_abonado = ' || col_abonado || ' ' ||
                           'AND g3.cod_PRODUCTO = 1 ' ||
                           'AND g1.cod_plantarif = g3.cod_plantarif ';
				    --error (n_error):= 'get plan :' || ssql;
        			--n_error:= n_error +1;

                    cur_datos := dbms_sql.open_cursor;
                    dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                    dbms_sql.define_column_char(cur_datos, 1, col1,3 );
                    dbms_sql.define_column_char(cur_datos, 2, col2,30 );
                    dbms_sql.define_column_char(cur_datos, 3, col3 ,1);
                    dbms_sql.define_column(cur_datos, 4, col4 );
                    resp_cur_datos:=dbms_sql.execute(cur_datos);
                    loop
                       j:=dbms_sql.fetch_rows(cur_datos);
                       if j = 0 then
                          exit;
                       end if;
                       dbms_sql.column_value_char (cur_datos,1,col1);
                       dbms_sql.column_value_char (cur_datos,2,col2);
                       dbms_sql.column_value_char (cur_datos,3,col3);
                       dbms_sql.column_value (cur_datos,4,col4);
					   --error (n_error):= 'codigo plan tarifario ' || col1;
         			   --n_error:= n_error +1;
					   --error (n_error):= 'desc PTarif = ' || col2;
         			   --n_error:= n_error +1;
					   --error (n_error):= 'tip PTarif = ' || col3;
         			   --n_error:= n_error +1;
                       cod_cliente(i):= cod_cliente1;
                       celular(i):= col_ncel;
                       if not (col4 is null) then
                          mi_contratados(i):= col4;
                       else
                          mi_contratados(i):=null;
                       end if;
					   --error (n_error):= 'tipo plan' || col3;
         			   --n_error:= n_error +1;
                       if not (col3 is null) then
					      if col3 = 'I' then
                             tip_plan_tarif(i):= 'Individual';
						  elsif col3 = 'E' then
						     tip_plan_tarif(i):= 'Empresa';
						  end if;
                       else
                          tip_plan_tarif(i):= null;
                       end if;
                       if not (col2 is null) then
                          plan_tarif(i):= col2;
                       else
                          plan_tarif(i):= null;
                       end if;
                     end loop;
                    dbms_sql.close_cursor(cur_datos);
                    if tip_plan_tarif(i)= 'Individual' then
				   	   --error (n_error):= 'dentro I';
         			   --n_error:= n_error +1;
                       /* minutos de promocion */
                       ssql:= 'SELECT num_minutos ' ||
                              'FROM ga_dtostarif ' ||
                              'WHERE num_abonado = ' || col_abonado || ' ' ||
                              'AND COD_CICLFACT = ' || cod_cliente1;
                       cur_datos := dbms_sql.open_cursor;
                       dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                       dbms_sql.define_column(cur_datos, 1, col4);
                       resp_cur_datos:=dbms_sql.execute(cur_datos);
                       j:=dbms_sql.fetch_rows(cur_datos);
                       dbms_sql.column_value(cur_datos,1,col4);
                       if not (col4 is null) then
                          mi_promo(i):= col4;
                       else
                          mi_promo(i):= NULL;
                       end if;
                       dbms_sql.close_cursor(cur_datos);
                      /* minutos consumidos*/
                      ssql:= 'SELECT SEG_PROMCONS,SEG_CONSUMIDO ' ||
                             'FROM ta_acumaire ' ||
                             'WHERE NUM_ABONADO = ' || col_abonado || ' ' ||
                             'AND COD_CICLFACT = ' || cod_ciclo2 || ' ' ||
                             'AND COD_PLANTARIF = ' || c ||  ltrim(rtrim(col1)) || c;
                             cur_datos := dbms_sql.open_cursor;
					  --error (n_error):= 'm_consumido:' || ssql;
         			  --n_error:= n_error +1;

                      dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                      dbms_sql.define_column(cur_datos, 1, col4);
                      dbms_sql.define_column(cur_datos, 2, m_consumido);
                      resp_cur_datos:=dbms_sql.execute(cur_datos);
                      j:=dbms_sql.fetch_rows(cur_datos);
                      dbms_sql.column_value(cur_datos,1,col4);
                      dbms_sql.column_value(cur_datos,2,m_consumido);
                      mi_usados(i):= m_consumido/60;
					  --error (n_error):= 'var consumido I: ' || m_consumido;
         			  --n_error:= n_error +1;

                      if not (mi_contratados(i) is null) and not (mi_usados(i) is null) then
                         mi_disponibles(i):= mi_contratados(i)-mi_usados(i);
                      end if;
                      mi_promo_usado(i):= col4/60;
                      if not(mi_promo(i) is null) and not (mi_promo_usado(i) is null) then
                         mi_promo_dispo(i):= mi_promo(i)-mi_promo_usado(i);
                      end if;
                      dbms_sql.close_cursor(cur_datos);
                  elsif tip_plan_tarif(i)= 'Empresa' then
				   	   --error (n_error):= 'dentro E';
         			   --n_error:= n_error +1;
                        c_formato:= '000000' || cod_ciclo2;
                  c_formato:= substr(c_formato,length(c_formato)-5,2) || '-' || substr(c_formato,length(c_formato)-3,2) || '-' || substr(c_formato,length(c_formato)-1,2);
				   	   --error (n_error):= 'c_formato = '|| c_formato;
         			   --n_error:= n_error +1;
                  ssql:= 'SELECT cod_grupo ' ||
                         'FROM ga_intarcel ' ||
                         'WHERE cod_cliente = ' || cod_cliente1 || ' ' ||
                         'And fec_desde  <= TO_DATE(' || c || c_formato || c || ',' || c || 'dd-mm-yyyy' || c || ') ' ||
                         'And fec_hasta  >= TO_DATE(' || c || c_formato || c || ',' || c || 'dd-mm-yyyy' || c || ') ' ||
                         'And num_abonado = ' || col_abonado;
                  cur_datos := dbms_sql.open_cursor;
                  dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                  dbms_sql.define_column(cur_datos, 1, aux);
                  resp_cur_datos:=dbms_sql.execute(cur_datos);
                  j:=dbms_sql.fetch_rows(cur_datos);
                  dbms_sql.column_value(cur_datos,1,aux);
                  dbms_sql.close_cursor(cur_datos);
			   	  --error (n_error):= 'cod_grupo=' || to_char(aux,'99999');
        		  --n_error:= n_error +1;
                  if not (aux is null) then
                     ssql:= 'SELECT num_minutos ' ||
                            'FROM ga_dtostarif ' ||
                            'WHERE num_abonado = ' || aux  || ' ' ||
                            'and COD_CICLFACT = ' || cod_ciclo2;
                     cur_datos := dbms_sql.open_cursor;
                     dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                     dbms_sql.define_column(cur_datos, 1, col4);
                     resp_cur_datos:=dbms_sql.execute(cur_datos);
                     j:=dbms_sql.fetch_rows(cur_datos);
                     dbms_sql.column_value(cur_datos,1,col4);
                     dbms_sql.close_cursor(cur_datos);
                     mi_promo(i):= col4;
                  else
                       mi_promo(i):= null;
				   	  --error (n_error):= 'min_promo es null';
	        		  --n_error:= n_error +1;
                  end if;
                  ssql:= 'SELECT cod_empresa ' ||
                         'FROM ga_empresa ' ||
                         'WHERE cod_cliente = ' || cod_cliente1 || ' ' ||
                         'and cod_ciclo = ' || cod_cicloa;
                  cur_datos := dbms_sql.open_cursor;
                  dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                  dbms_sql.define_column(cur_datos, 1, aux);
                  resp_cur_datos:=dbms_sql.execute(cur_datos);
                  j:=dbms_sql.fetch_rows(cur_datos);
                  dbms_sql.column_value(cur_datos,1,aux);
                  dbms_sql.close_cursor(cur_datos);
				  --error (n_error):= 'cod_empresa ';
         		  --n_error:= n_error +1;
		   	      --error (n_error):= 'valor= ' || to_char(aux,'99999');
       			   --n_error:= n_error +1;
				 /* calculo de minutos consumidos promocionales y de contrato*/
				 --importado cuando plan tarifario = I

					 ssql:= 'SELECT SEG_PROMCONS,SEG_CONSUMIDO ' ||
					 		'FROM ta_acumaire ' ||
							'WHERE NUM_ABONADO = ' || col_abonado || ' ' ||
							'and COD_CICLFACT = ' || cod_ciclo2 || ' ' ||
							'and COD_PLANTARIF = ' || c ||  rtrim(ltrim(col1)) || c;
					   --error (n_error):= 'consulta m consumido E:' || ssql;
         			   --n_error:= n_error +1;


						     cur_datos := dbms_sql.open_cursor;
					 dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
					 dbms_sql.define_column(cur_datos, 1, col4);
					 dbms_sql.define_column(cur_datos, 2, col5);
                              resp_cur_datos:=dbms_sql.execute(cur_datos);
					 j:=dbms_sql.fetch_rows(cur_datos);
					 dbms_sql.column_value(cur_datos,1,col4);
					 --dbms_sql.column_value(cur_datos,2,col5);
					 dbms_sql.column_value(cur_datos,2,m_consumido);
					 mi_usados(i):= m_consumido/60;
					 mi_promo_usado(i):= col4/60;
					 /*if m_consumido is null then
					    error(n_error):= '*';
					 else
 				        error(n_error):= '*' || to_char(m_consumido,'99999999');
					 end if;
					 n_error:= n_error +1;*/
					 dbms_sql.close_cursor(cur_datos);

					 ssql:= 'SELECT sum(a.SEG_PROMCONS), sum(a.SEG_CONSUMIDO) ' ||
					        'FROM ta_acumaire a, ( ' ||
							'                      SELECT num_abonado ' ||
							'                      FROM ga_abocel ' ||
							'                      WHERE cod_cliente = ' || to_char(cod_cliente1,'99999999') || ' ' ||
							'                      AND cod_producto = 1 ' ||
							'                      AND cod_situacion <> ' || c || 'BAA' || c || ' ' ||
							'                    ) b ' ||
							'WHERE a.num_abonado = b.num_abonado ' ||
							'AND a.cod_ciclfact = ' || cod_ciclo2 || ' ' ||
							'AND a.COD_PLANTARIF = ' || c ||  rtrim(ltrim(col1)) || c || ' ';

						     cur_datos := dbms_sql.open_cursor;
					 dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
					 dbms_sql.define_column(cur_datos, 1, col4);
					 dbms_sql.define_column(cur_datos, 2, m_consumido);
                              resp_cur_datos:=dbms_sql.execute(cur_datos);
					 j:=dbms_sql.fetch_rows(cur_datos);
					 dbms_sql.column_value(cur_datos,1,col4);
					 --dbms_sql.column_value(cur_datos,2,col5);
					 dbms_sql.column_value(cur_datos,2,m_consumido);


					 if not (mi_contratados(i) is null) and not (m_consumido is null) then
					    mi_disponibles(i):= mi_contratados(i)-m_consumido/60;
					 else
					  	mi_disponibles(i):= null;
					 end if;

					 if not(mi_promo(i) is null) and not (col4 is null) then
					    mi_promo_dispo(i):= mi_promo(i)-col4/60;
					 else
					    mi_promo_dispo(i):=  null;
					 end if;
					 dbms_sql.close_cursor(cur_datos);



				 -- fin importacion con plan tarifario = I
				  /* Codigo antiguo de calculo de minutos consumidos promocionales y de contrato
                  if not (aux is null) THEN
                     ssql:= 'SELECT SEG_PROMCONS,SEG_CONSUMIDO ' ||
                            'FROM ta_acumaireEMP ' ||
                            'WHERE COD_EMPRESA = ' || aux || ' ' ||
                            'and COD_CICLFACT = ' || cod_ciclo2 || ' ' ||
                            'and COD_PLANTARIF = ' || c ||col1 || c;
                     cur_datos := dbms_sql.open_cursor;
                     dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
                     dbms_sql.define_column(cur_datos, 1, col4);
                     dbms_sql.define_column(cur_datos, 2, col5);
                     resp_cur_datos:=dbms_sql.execute(cur_datos);
                     j:=dbms_sql.fetch_rows(cur_datos);
                     dbms_sql.column_value(cur_datos,1,col4);
                     dbms_sql.column_value(cur_datos,2,col5);
                     dbms_sql.close_cursor(cur_datos);
                     mi_usados(i):= col5;
                     if not (mi_contratados(i) is null) and not (mi_usados(i) is null) then
                         mi_disponibles(i):= mi_contratados(i)-mi_usados(i);
                     end if;
                     mi_promo_usado(i):= col4;
                     if not (mi_promo(i) is null) and not (mi_promo_usado(i) is null) then
                        mi_promo_dispo(i):= mi_promo(i) - mi_promo_usado(i);
                     end if;
                  else
                      mi_usados(i):= null;
                      mi_disponibles(i):= null;
                      mi_promo_usado(i):= null;
                      mi_promo_dispo(i):= null;
                 end if;
				 */
			   	  --error (n_error):= 'fin este abonado';
        		  --n_error:= n_error +1;
            end if;
			--formateamos campos de tiempo consumido

			  --aux_num:= mi__usados(i) / 60;
			  --hora := to_char(trunc( aux_num),'99');
			  if not mi_usados(i) is null then
			     --error(n_error):= 'dentro' || to_char(mi_usados(i));
				 --n_error:= n_error +1;
				 --aux_num:= trunc(mi_usados(i) / 60);
				  hora := to_char(trunc( mi_usados(i)/60));
				  if length(hora) = 1 then
				     hora:= '0' || hora;
				  elsif length(hora) =0 then
				     hora:= '00';
				  end if;
				  min1 := to_char(trunc(mi_usados(i)));
				  if length(min1) = 1 then
				     min1:= '0' || min1;
				  elsif length(min1) = 0 then
				     min1:= '00';
				  end if;
				  segundos := to_char(trunc((mi_usados(i) -trunc(mi_usados(i)))*60));
				  if length(segundos) = 1 then
				     segundos:= '0' || segundos;
				  elsif	 length(segundos) = 0 then
				     segundos:= '00';
				  end if;
			 else
			    hora:= '00';
				min1:= '00';
				segundos:= '00';
			 end if;

              mi_usadosf(i):= hora || ':' || min1 || ':' || segundos;

			  if not mi_promo_usado(i) is null then
			     --error(n_error):= 'dentro2' || to_char(mi_promo_usado(i));
				 --n_error:= n_error +1;
				 --aux_num:= trunc(mi_usados(i) / 60);
				  hora := to_char(trunc( mi_promo_usado(i)/60));
				  if length(hora) = 1 then
				     hora:= '0' || hora;
				  elsif length(hora) =0 then
				     hora:= '00';
				  end if;
				  min1 := to_char(trunc(mi_promo_usado(i)));
				  if length(min1) = 1 then
				     min1:= '0' || min1;
				  elsif length(min1) = 0 then
				     min1:= '00';
				  end if;
				  segundos := to_char(trunc((mi_promo_usado(i) -trunc(mi_promo_usado(i)))*60));
				  if length(segundos) = 1 then
				     segundos:= '0' || segundos;
				  elsif	 length(segundos) = 0 then
				     segundos:= '00';
				  end if;
		     else
			    hora:= '00';
				min1:= '00';
				segundos:= '00';
			 end if;

              mi_promo_usadof(i):= hora || ':' || min1 || ':' || segundos;
			  --error(n_error):= 'usado f:' ||mi_usadosf(i);
			  --n_error:= n_error+1;
			  --error(n_error):= 'usado promo f:' ||mi_promo_usadof(i);
			  --n_error:= n_error+1;
            i := i + 1;
         end loop;
 /* sgte. abono */
                  dbms_sql.close_cursor(cur_datos1);
                  if tip_identifica = 'C' or tip_identifica = 'A' then
                     exit;
                  elsif tip_identifica = 'R' then
                    j1:=dbms_sql.fetch_rows(cur_datos2);
                    if j1 = 0 then
                       cod_cliente1:= 0;
                       exit;
                    else
                       dbms_sql.column_value (cur_datos2,1,cod_clienteA);
                       cod_cliente1:= cod_clienteA;
                    end if;
                  end if;
          end if;
               end loop;
            end if;
        EXCEPTION
            WHEN error_param THEN
             error(n_error):= 'imposible continuar';
                WHEN OTHERS THEN
             error(n_error):= TO_CHAR(SQLCODE);
           error(n_error+1):= sqlerrm;
             --dbms_output.put_line(TO_CHAR(SQLCODE) || ' ' || sqlerrm);
           --dbms_sql.close_cursor(cur_datos);
    END;

FUNCTION GE_F_TIPALMAC(
                       Par_CiclFact in varchar2,
					   Par_NomCam   in varchar2
					   ) RETURN varchar2
					   IS

--Nombre de la Funcion : GE_F_TIPALMAC
--Creado Por : Marcelo Navarrete.
--Descripcion : La finalidad es determinar a que tabla se deben consultar los detalles de llamadas
-- y si estan o no disponibles para se consultadas.
--Parametros de Input : Par_CiclFact = Codigo de Ciclo.
-- Par_NomCamp = Nombre del campo sobre el cual realisar Select.
--Parametro de Salida : Retorna Numero de Estado y Nombre de la Tabla.
--Fecha e Historia : Viernes, 05 de Mayo del 2000.

    resp  		     varchar2(1400);
    Vl_CodTipAlm     varchar2(1); --number;
    Vl_NomTab        varchar2(40);
    Vl_ciclofact     varchar2(10);
    Ret_ciclofact    varchar2(10);
    Vl_Inv           number;
    ssql             varchar2(1400);
    cursor_name      integer;
    rows_processed   integer;
	aux              varchar2(1400);

Begin
      resp :='*Null';
      --begin
      if Par_ciclfact <> '*' Then
         SELECT SUBSTR(to_char(fec_emision,'dd-mm-yyyy'),1,10) into Ret_ciclofact
         FROM fa_ciclfact
         WHERE cod_ciclfact =  Par_CiclFact;
         Vl_ciclofact := SUBSTR(Ret_ciclofact, 1, 2) || SUBSTR(Ret_ciclofact, 4, 2) || SUBSTR(Ret_ciclofact, 7, 4);
      end if;

      if Par_NomCam = 'FA_DETCELULAR' And Par_ciclfact <> '*' And Par_ciclfact <> '19010101' Then
         Vl_ciclofact:= lpad(Vl_ciclofact,8,'0');
         Vl_Inv := to_number(substr(Vl_ciclofact, 5, 4) || substr(Vl_ciclofact, 3, 2) || substr(Vl_ciclofact, 1, 2));
         if Vl_Inv < 19990510 Then
            resp := '9FA_DETCELULAR';
         end if;
      end if;

	  ssql := 'SELECT to_char(cod_tipalmac),' || Par_NomCam || ' FROM fa_enlacehist ';
      if rtrim(ltrim(Par_ciclfact)) <> '*' then
         ssql:= ssql || 'WHERE cod_ciclfact = ' || Par_ciclfact;
      end if;

      cursor_name := dbms_sql.open_cursor;
      dbms_sql.parse(cursor_name, ssql , dbms_sql.v7);
      DBMS_SQL.DEFINE_COLUMN_char(cursor_name, 1, Vl_CodTipAlm,1);
      DBMS_SQL.DEFINE_COLUMN_char(cursor_name, 2, Vl_NomTab ,40);
      rows_processed := dbms_sql.execute(cursor_name);
      if dbms_sql.fetch_rows (cursor_name) > 0 then
         DBMS_SQL.column_value_char(cursor_name, 1, Vl_CodTipAlm);
         DBMS_SQL.column_value_char(cursor_name, 2, Vl_NomTab);
         resp :=  Vl_CodTipAlm || ltrim(rtrim(Vl_NomTab));
      end if;
	  dbms_sql.close_cursor (cursor_name);

      if to_number(substr(resp, 1, 1)) = 0 then
         resp := '*Llamadas Facturadas Pero NO Pasadas a Historicos.';
      elsif to_number(substr(resp, 1, 1)) = 2 then
         resp := '*Trafico No Disponible (Ya En Cinta)';
      elsif to_number(substr(resp, 1, 1)) = 3 then
         resp := '*Ciclo No Encontrado en La Tabla.';
      elsif to_number(substr(resp, 1, 1)) <> 1 and to_number(substr(resp, 1, 1)) <> 9 then
         resp := '*Tipo de Almacenamiento No reconocido.';
      end if;
	  return( resp );

   EXCEPTION
      WHEN OTHERS THEN
           resp :='*' || TO_CHAR(SQLCODE) || sqlerrm;
           return( resp );
      --end;
END GE_F_TIPALMAC;

    PROCEDURE FA_DOCTO_CLI (
                cod_cliente   in number,
                num_doctos    in number,
                tip_docto     in number,
                f_emision     out t_fecha_docto,
                f_vcto      out t_fecha_docto,
                num_docto     out t_num_folio,
                iva       out t_valor_pesos,
                tot_factura   out t_valor_pesos,
                tot_pagar   out t_valor_pesos,
                mes           out t_cod_tipdocum,
                estado        out t_estado,
                cod_ciclfact  out t_cod_ciclo_fact,
                cod_tipdocum  out t_cod_tipdocum,
                des_tipdocum  out t_des_tipdocum,
                tip_mov       out t_movimiento,
                num_proceso   out t_num_proceso,
                error         out t_error
                 )IS
    ordentotal     t_ordentotal;
    neto       t_valor_pesos;
    saldo_ant    t_valor_pesos;
    nom_user     t_nom_user;
    num_securel    t_num_securel;
    letra_rel    t_letra_rel;
    cod_tipdocrel  t_cod_tipdocrel;
    cod_vendedor   t_cod_vendedor;
    cod_central    t_cod_central;
    p_num_ctc    t_p_num_ctc;
    desc_despacho  t_desc_despacho;
    BEGIN
         /*                   1             2         3          4         5        6         7      8            9      10      11     12               13           14          15         16          17      18      19       20          21          22         23          24            25          26         27           28 */
     FA_DOCTO_CLI_SAC(cod_cliente, num_doctos, tip_docto, f_emision, f_vcto, num_docto, iva, tot_factura,tot_pagar, mes, estado, cod_ciclfact, cod_tipdocum, des_tipdocum, tip_mov, num_proceso,ordentotal,neto, saldo_ant,nom_user,num_securel, letra_rel, cod_tipdocrel, cod_vendedor, cod_central, p_num_ctc, desc_despacho, error );

    END FA_DOCTO_CLI;

    PROCEDURE FA_DOCTO_CLI_SAC (
                cod_cliente   in number,
                num_doctos    in number,
                tip_docto     in number,
                f_emision     out t_fecha_docto,
                f_vcto      out t_fecha_docto,
                num_docto     out t_num_folio,
                iva       out t_valor_pesos,
                tot_factura   out t_valor_pesos,
                tot_pagar   out t_valor_pesos,
                mes           out t_cod_tipdocum,
                estado        out t_estado,
                cod_ciclfact  out t_cod_ciclo_fact,
                cod_tipdocum  out t_cod_tipdocum,
                des_tipdocum  out t_des_tipdocum,
                tip_mov       out t_movimiento,
                num_proceso   out t_num_proceso,
                ordentotal    out t_ordentotal,
                neto      out t_valor_pesos,
                saldo_ant   out t_valor_pesos,
                nom_user    out t_nom_user,
                num_securel   out t_num_securel,
                letra_rel   out t_letra_rel,
                cod_tipdocrel out t_cod_tipdocrel,
                cod_vendedor  out t_cod_vendedor,
                cod_central   out t_cod_central,
                p_num_ctc   out t_p_num_ctc,
                desc_despacho out t_desc_despacho,
                error         out t_error
                 )IS
    error_param    Exception;
    n_error      integer;
    i          integer;
    tabla          varchar2(20);
    SSQL           VARCHAR2(1400);
    SSQL1      VARCHAR2(1400);
    cur_datos      integer;
    cur_datos1     integer;
        j1             integer;
    col1       date;
    col2       date;
    col3       number(9);
    col4       number(14,4);
    col5       number(14,4);
    col6       number(14,4);
    col7       number(8);
    col8       number(2);
    col9       varchar2(40);
    col10      number(8);
    col11      fa_histdocu.IND_ORDENTOTAL%type;
--ge_tipdocumen.DES_TIPDOCUM%type;
    col12      number(14,4);
    col13      number(14,4);
    col14      fa_histdocu.nom_usuarora%type;
    col15      fa_histdocu.num_securel%type;
    col16      fa_histdocu.letrarel%type;
    col17      fa_histdocu.cod_tipdocumrel%type;
    col18      fa_histdocu.cod_vendedor_agenterel%type;
    col19      fa_histdocu.cod_centrrel%type;
    col20      fa_histdocu.num_ctc%type;
    col21      fa_codespacho.DESC_DESPACHO%type;
    BEGIN
      i:=1;
	  n_error:= 1;
    if  cod_cliente is null or cod_cliente <0 or  num_doctos is null then --num_doctos < 0 or
       error (n_error):= 'Parametro no puede ser negativo o Null';
       n_error:= n_error +1;
       raise error_param;
    end if;
    if tip_docto IS NULL then
       error (n_error):= 'tipo de documento no puede ser Null';
       n_error:= n_error +1;
       raise error_param;
    end if;
    /*                   1             2                3            4           5               6                  7               8            9                  10                     11                  12                13              14  15              16                17                   18                         19          20            21        */
    SSQL:= 'SELECT f1.fec_emision, f1.fec_vencimie, f1.num_folio, f1.acum_iva, f1.tot_factura,f1.tot_pagar, f1.cod_ciclfact, f1.cod_tipdocum, f2.DES_TIPDOCUM, f1.num_proceso,f1.ind_ordentotal, f1.acum_netograv, f1.imp_saldoant, f1.nom_usuarora, f1.num_securel,f1.letrarel, f1.cod_tipdocumrel, f1.cod_vendedor_agenterel, f1.cod_centrrel,f1.num_ctc, f3.desc_despacho ' ||
         'FROM fa_codespacho f3 ,GE_TIPDOCUMEN f2,FA_HISTDOCU f1 ' ||
         'WHERE f1.ind_ordentotal <> 1 ' ||
         'AND f1.cod_cliente = ' || to_char(cod_cliente) || ' ' ||
         'AND f1.cod_tipdocum = f2.cod_tipdocum ' ||
         'AND f1.cod_despacho = f3.cod_despacho (+)'  ||
         'AND f1.ind_anulada = 0 AND f1.ind_factur = 1 ' ;
         if tip_docto = 36 or tip_docto = 69  then -- boleta
            ssql:= ssql || 'AND f2.cod_tipdocum in (36,69) ' || ' ';
         else
             ssql:= ssql || 'AND f2.cod_tipdocum = ' || rtrim(ltrim(to_char(tip_docto))) || ' ';
         end if;
--        if tip_docto > 0 then
--          ssql:= ssql || 'AND f2.cod_tipdocum = ' || rtrim(ltrim(to_char(tip_docto))) || ' ';
--       end if;
    ssql := ssql || ' ORDER BY f1.fec_emision desc ';
    cur_datos := dbms_sql.open_cursor;
    dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
    dbms_sql.define_column(cur_datos, 1, col1 );
    dbms_sql.define_column(cur_datos, 2, col2 );
    dbms_sql.define_column(cur_datos, 3, col3 );
    dbms_sql.define_column(cur_datos, 4, col4 );
    dbms_sql.define_column(cur_datos, 5, col5 );
    dbms_sql.define_column(cur_datos, 6, col6 );
    dbms_sql.define_column(cur_datos, 7, col7 );
    dbms_sql.define_column(cur_datos, 8, col8 );
    dbms_sql.define_column_char(cur_datos, 9, col9, 40 );
    dbms_sql.define_column(cur_datos, 10, col10);
    --dbms_sql.define_column_char(cur_datos, 11, col11,40);
        dbms_sql.define_column(cur_datos, 11, col11);
    dbms_sql.define_column(cur_datos, 12, col12);
    dbms_sql.define_column(cur_datos, 13, col13);
    dbms_sql.define_column_char(cur_datos, 14, col14,30);
    dbms_sql.define_column(cur_datos, 15, col15);
    dbms_sql.define_column_char(cur_datos, 16, col16,1);
    dbms_sql.define_column(cur_datos, 17, col17);
    dbms_sql.define_column(cur_datos, 18, col18);
    dbms_sql.define_column(cur_datos, 19, col19);
    dbms_sql.define_column_char(cur_datos, 20, col20,12);
    dbms_sql.define_column_char(cur_datos, 21, col21,30);
    j1:= dbms_sql.execute (cur_datos);
    loop
      begin
      j1:=dbms_sql.fetch_rows(cur_datos);
          if i > num_doctos then
             exit;
          end if;
      if j1 = 0 then
         exit;
      else
         dbms_sql.column_value(cur_datos, 1, col1 );
         dbms_sql.column_value(cur_datos, 2, col2 );
         dbms_sql.column_value(cur_datos, 3, col3 );
         dbms_sql.column_value(cur_datos, 4, col4 );
         dbms_sql.column_value(cur_datos, 5, col5 );
         dbms_sql.column_value(cur_datos, 6, col6 );
         dbms_sql.column_value(cur_datos, 7, col7 );
         dbms_sql.column_value(cur_datos, 8, col8 );
         dbms_sql.column_value_char(cur_datos, 9, col9 );
         dbms_sql.column_value(cur_datos, 10, col10);
         dbms_sql.column_value(cur_datos, 11, col11);
         dbms_sql.column_value(cur_datos, 12, col12);
         dbms_sql.column_value(cur_datos, 13, col13);
         dbms_sql.column_value_char(cur_datos, 14, col14);
         dbms_sql.column_value(cur_datos, 15, col15);
         dbms_sql.column_value_char(cur_datos, 16, col16);
         dbms_sql.column_value(cur_datos, 17, col17);
         dbms_sql.column_value(cur_datos, 18, col18);
         dbms_sql.column_value(cur_datos, 19, col19);
         dbms_sql.column_value_char(cur_datos, 20, col20);
         dbms_sql.column_value_char(cur_datos, 21, col21);
        f_emision(i):= to_char(col1,'dd-mm-yyyy');
        f_vcto(i):= to_char(col2,'dd-mm-yyyy');
        num_docto(i):= col3;
        iva (i):= col4;
        tot_factura(i):= col5;
        tot_pagar(i):= col6;
        mes(i):= to_number(substr(to_char(col1,'dd-mm-yyyy'),4,2));
        estado(i):= Null;
        cod_ciclfact(i):= col7;
        cod_tipdocum(i):= col8;
        des_tipdocum(i):= 'ciclo';
        Tip_mov(i):= col9;
        num_proceso(i):= col10;
        ordentotal(i):= col11;
        neto(i):= col12;
        saldo_ant(i):= col13;
        nom_user(i):= col14;
        num_securel(i):= col15;
        letra_rel(i):= col16;
        cod_tipdocrel(i):= col17;
        cod_vendedor(i):= col18;
        cod_central(i):= col19;
        p_num_ctc(i):= col20;
        desc_despacho(i):= col21;
        SSQL1:= 'SELECT fec_efectividad ' ||
                 'FROM co_cancelados ' ||
                 'WHERE cod_cliente = ' || rtrim(ltrim(to_char(cod_cliente))) || ' ' ||
             --'AND cod_tipdocum = ' || rtrim(ltrim(to_char(tip_docto))) || ' ' ||
			 'AND cod_tipdocum = ' || rtrim(ltrim(to_char(col8))) || ' ' ||
             'AND num_folio = ' || rtrim(ltrim(to_char(col3))) || ' ' ||
             'ORDER BY NUM_FOLIO ';
        col1:= null;
        cur_datos1 := dbms_sql.open_cursor;
        dbms_sql.parse(cur_datos1,ssql1, DBMS_SQL.V7);
        dbms_sql.define_column(cur_datos1, 1, col1 );
        j1:= dbms_sql.execute (cur_datos1);
        j1:=dbms_sql.fetch_rows(cur_datos1);
        dbms_sql.column_value(cur_datos1, 1, col1 );
        if to_date(f_vcto(i),'dd-mm-yyyy') < sysdate and col1 is null then
           estado(i):= 'Impago';
        elsif to_date(f_vcto(i),'dd-mm-yyyy')>= sysdate and col1 is null then
           estado(i):= 'VIGENTE';
        elsif not (col1 is null) then
           estado(i):= 'PAGADA';
        end if;
        dbms_sql.close_cursor (cur_datos1);
        i:= i +1;
      end if;
      exception
        when others then
          error(0):= sqlerrm;
      end;
    end loop;
    dbms_sql.close_cursor (cur_datos);
        EXCEPTION
            WHEN error_param THEN
             error(n_error):= 'imposible continuar';
                WHEN OTHERS THEN
             error(n_error):= TO_CHAR(SQLCODE);
           error(n_error+1):= sqlerrm;
    END;
    PROCEDURE FA_DET_LLAM (
                   identificacion in varchar2,
                 tip_identifica in varchar2,
                 tip_llamada    in varchar2,
                 t_facturacion  in varchar2,
                 cod_cicl_fact  in number,
                 tipo_documento in number,
                 num_proceso    in number,
                 f_llamada    out t_fecha_docto,
                 h_llamada    out t_hora,
                 tipo_llamada   out t_tipo_llamada,
                 clasif_llamada out t_clasif_llamada,
                 dur_llamada    out t_dur_llamada,
                 num_origen   out t_num_origen,
                 num_destino    out t_num_destino,
                 horario      out t_horario,
                 destino      out t_destino,
                 valor      out t_valor,
                 error      out t_error,
				 depura		out t_error
                  ) IS
    error_param exception;
    n_error     integer;
	n_depura	integer;
    i     INTEGER;
 /*indice de insercion */
    j           integer;
 /*indice de rescate*/
    max_reg     integer;
 /*registros a rescatar*/
        limite      integer;

    col1    t_fecha_docto;
    col2    t_hora;
    col3    t_tipo_llamada;
    col4    t_clasif_llamada;
    col5    t_dur_llamada;
    col6    t_num_origen;
    col7    t_num_destino;
    col8    t_horario;
    col9    t_destino;
    col10   t_valor;

        aux     varchar2(15);
    BEGIN
        i:= 1;
        n_error:= 1;
		n_depura:= 1;
        if not (tip_identifica in ('C','A') ) then
           error (n_error):= 'Tipo de identificacion puede ser C o A';
           n_error:= n_error +1;
           raise error_param;
        end if;
        if not (t_facturacion in ('F' , 'NF') ) then
           error (n_error):= 'Tipo de Facturacion puede ser F o NF';
           n_error:= n_error +1;
           raise error_param;
        end if;
        if not (tip_llamada in ('L','I','E','T','R') ) then
           error (n_error):= 'Tipo llamada puede ser L= Local,I=Interzona, E=Especial, T=inTernacional, R=Roaming';
           n_error:= n_error +1;
           raise error_param;
        end if;
        if ( (tip_llamada = 'I' or tip_llamada = 'E' )  and tipo_documento in (69,2,23,36,40,43) ) or tip_llamada = 'L' then

          EBZ_PAC_FA_SISCEL.FC_locales (identificacion,tip_identifica,cod_cicl_fact,tip_llamada,tipo_documento,t_facturacion,col1,col2,col3,col4,col5,col6,col7,col8,col10,col9,max_reg,depura);
		  --ERROR(n_error):= 'ejecutado fc_locales';
		  --n_error:= n_error +1;



		  --ERROR(n_error):= to_char(max_reg,'99999');
		  --n_error:= n_error +1;

          if not max_reg is null then
             limite:= max_reg;
          else
             limite:= 1;
          end if;
          j:=1;
		  i:= 1;
          loop
             if j > limite then
                exit;
             end if;
             f_llamada(i):= col1(j);
             h_llamada(i):=col2(j);
             tipo_llamada(i):=col3(j);
             clasif_llamada(i):=col4(j);
             dur_llamada(i):=col5(j);
             num_origen(i):=col6(j);
             num_destino(i):=col7(j);
             horario(i):=col8(j);
             destino(i):=col9(j);
             valor(i):=col10(j);
             i:=i +1;
             j:=j +1;
          end loop;
        elsif ((tip_llamada = 'T' or tip_llamada = 'R') and tipo_documento in (69,2,23,36,40,43) ) and t_facturacion = 'F' then
              i:= 1;
              EBZ_PAC_FA_SISCEL.FTR(identificacion,tip_identifica,cod_cicl_fact,tip_llamada,num_proceso,col1,col2,col3,col4,col5,col6,col7,col8,col10,col9,max_reg);
            if not max_reg is null then
               limite:= max_reg;
            else
               limite:= 1;
            end if;
            j:=1;
            loop
               if j > limite then
                  exit;
               end if;
               f_llamada(i):= col1(j);
               h_llamada(i):=col2(j);
               tipo_llamada(i):=col3(j);
               clasif_llamada(i):=col4(j);
               dur_llamada(i):=col5(j);
               num_origen(i):=col6(j);
               num_destino(i):=col7(j);
               horario(i):=col8(j);
               destino(i):=col9(j);
               valor(i):=col10(j);
               i:=i +1;
               j:=j +1;
            end loop;
        end if;
    EXCEPTION
            WHEN error_param THEN
             error(n_error):= 'imposible continuar';
                  WHEN OTHERS THEN
             error(n_error):= TO_CHAR(SQLCODE);
           error(n_error+1):= sqlerrm;
    END FA_DET_LLAM;
PROCEDURE FC_locales (
              cod_clientes   in varchar2,
              tip_identifica in varchar2,
              cod_cicl_fact  in number,
              tip_llamada    in varchar2,
              tipo_documento in number,
              facturable     in varchar2,
              f_llamada    out t_fecha_docto,
              h_llamada    out t_hora,
              tipo_llamada   out t_tipo_llamada,
              clasif_llamada out t_clasif_llamada,
              dur_llamada    out t_dur_llamada,
              num_origen     out t_num_origen,
              num_destino    out t_num_destino,
              horario      out t_horario,
              valor      out t_valor,
              destino      out t_destino,
              max_reg      out integer,
			  error		   out t_error
               ) IS

   error_param exception;
   n_error	 integer;
   SSQL_SELECT   varchar2(300);
   SSQL_FROM   varchar2(100);
   SSQL_WHERE  varchar2(1000);
   ssql          varchar2(1400);
   i             integer;
   tabla     varchar2(1400);
   cur_datos     integer;
   j       integer;
   cod_cliente1  number(8);
   col1      varchar2(18);
   col2      varchar2(10); --date;
   col3      varchar2(8);
   col4      number(3);
   col5      number(1);
   col6      varchar2(30);
   col7      varchar2(18);
   col8      varchar2(6);
   col9      number(3);
   col10     number(14,4);
   c		 varchar2(1);

   begin
    c:= chr(39);
   	n_error:= 1;
	--error(n_error):= 'dentro de fc_locales:';
	--n_error:= n_error +1;
    i:= 1;
    max_reg := 0;
    if facturable = 'F' then
	   --error(n_error):= 'cod_cicl_fact=' || to_char(cod_cicl_fact,'999999');
	   --n_error:= n_error +1;
       tabla:= EBZ_PAC_FA_SISCEL.ge_f_tipalmac(to_char(cod_cicl_fact,'9999999'), 'FA_DETCELULAR');

	   --error(n_error):= 'post ge_f_tipalmac:' || tabla;
	   --n_error:= n_error +1;
	   if tabla= 'NADA' or tabla= '3' or substr(tabla,1,1) = '*' then
	      error(n_error):= '*DATA NOT FOUND';
		  n_error:= n_error +1;
		  raise error_param;
	   end if;
	   --error(n_error):= 'tabla F:' || tabla;
	   --n_error:= n_error +1;
    end if;
	--error(n_error):= 'por validar segundo if:';
	--n_error:= n_error +1;

    if tip_identifica = 'C' then
       if facturable = 'NF' then
              tabla := '*TA_TARIFICADAS' || substr(cod_clientes,length(cod_clientes),1);
			   --error(n_error):= 'tabla NF:' || tabla;
			   --n_error:= n_error +1;
       end if;
       if tip_llamada = 'L' then /*Local*/
          SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c || 'DD-MM-YYYY' || c || '),tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_local1, cod_franhorasoc, imp_local1 ';
          SSQL_WHERE:=  'WHERE cod_cliente = ' || cod_clientes || ' ' ||
                        'AND (ind_tiplla1 <> 2 OR (ind_tiplla1 = 2 AND ind_local1 = 1)) ';
          elsif tip_llamada = 'I' then /*Interzona*/
                SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c || 'DD-MM-YYYY' || c || '), tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_larga2, cod_franhorasoc, imp_larga2 ';
                SSQL_WHERE:=  'WHERE cod_cliente = ' || cod_clientes || ' ' ||
                              'AND ind_tiplla1 <> 2 AND IMP_LARGA2 > 0 ';
              elsif tip_llamada = 'E' then /*Especiales*/
                    SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c ||  'DD-MM-YYYY' || c || '), tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_larga2, cod_franhorasoc, imp_larga2 ';
                    SSQL_WHERE:=  'WHERE cod_cliente = ' || cod_clientes || ' ' ||
                                  'AND ind_tiplla1 = 2 ';
        end if;
     elsif tip_identifica = 'A' then
           select cod_cliente into cod_cliente1 from ga_abocel where num_abonado = cod_clientes;
           if facturable = 'NF' then
              tabla := '*TA_TARIFICADAS' || substr(cod_cliente1,length(cod_cliente1),1);
           end  if;
           if tip_llamada = 'L' then /*Local*/
              SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c || 'DD-MM-YYYY' || c || '), tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_local1, cod_franhorasoc, imp_local1 ';
              SSQL_WHERE:=  'WHERE num_abonado = ' || cod_clientes || ' ' ||
                            'AND cod_cliente = ' || to_char (cod_cliente1) ||
                            'AND (ind_tiplla1 <> 2 OR (ind_tiplla1 = 2 AND ind_local1 = 1)) ';
           elsif tip_llamada = 'I' then /*Interzona*/
                 SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c || 'DD-MM-YYYY' || c || '), tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_larga2, cod_franhorasoc, imp_larga2 ';
                 SSQL_WHERE:=  'WHERE num_abonado = ' || cod_clientes || ' ' ||
                               'AND cod_cliente = ' || to_char (cod_cliente1) ||
                               'AND ind_tiplla1 <> 2 AND IMP_LARGA2 > 0 ';
              elsif tip_llamada = 'E' then /*Especiales*/
                    SSQL_SELECT:= 'SELECT num_movil1, to_char(fec_initasa,' || c ||  'DD-MM-YYYY' || c || '), tie_inillam, cod_central, ind_entsal1, des_movil2, num_movil2, dur_larga2, cod_franhorasoc, imp_larga2 ';
                    SSQL_WHERE:=  'WHERE num_abonado = ' || cod_clientes || ' ' ||
                                  'AND cod_cliente = ' || to_char (cod_cliente1) ||
                                  'AND ind_tiplla1 = 2 ';
           end if;
     end if;

     if tip_llamada in( 'L','I','E' ) then
        SSQL_FROM:=   'FROM  ' || substr(tabla,2,length(tabla)) || ' ';
	 end if;
     if substr(tabla,1,1) = '9' then
        SSQL_WHERE:= SSQL_WHERE || 'AND cod_periodo = ' || cod_cicl_fact || ' ';
     end if;
     SSQL_WHERE:= SSQL_WHERE || 'ORDER BY fec_initasa, tie_inillam ASC ';
     SSQL:= SSQL_SELECT || SSQL_FROM || SSQL_WHERE;

	 /*error(n_error):= 'SSQL_SELECT:' || SSQL_SELECT;
	 n_error:= n_error +1;
	 error(n_error):= 'SSQL_FROM:' || SSQL_FROM;
	 n_error:= n_error +1;
	 error(n_error):= 'SSQL_WHERE:' || SSQL_WHERE;
	 n_error:= n_error +1;
	 error(n_error):= 'POR EJECUTAR CURSOR';
	 n_error:= n_error +1;*/

     cur_datos:= dbms_sql.open_cursor;
     dbms_sql.parse(cur_datos,SSQL, DBMS_SQL.V7);
     dbms_sql.define_column_char(cur_datos, 1, col1,18 );
     dbms_sql.define_column_char(cur_datos, 2, col2,10 );
     dbms_sql.define_column_char(cur_datos, 3, col3,8  );
     dbms_sql.define_column(cur_datos, 4, col4 );
     dbms_sql.define_column(cur_datos, 5, col5 );
     dbms_sql.define_column_char(cur_datos, 6, col6,30 );
     dbms_sql.define_column_char(cur_datos, 7, col7,18 );
     dbms_sql.define_column_char(cur_datos, 8, col8,6 );
     dbms_sql.define_column(cur_datos, 9, col9 );
     dbms_sql.define_column(cur_datos, 10, col10 );
     j:= dbms_sql.execute (cur_datos);
	 --error(n_error):= 'EJECUTADO CURSOR';
	 --n_error:= n_error +1;

     loop
        j:=dbms_sql.fetch_rows(cur_datos);

        if j = 0 then
			 --error(n_error):= 'fin loop';
			 --n_error:= n_error +1;

           exit;
        else
            dbms_sql.column_value_char(cur_datos, 1, col1);
            dbms_sql.column_value_char(cur_datos, 2, col2 );
            dbms_sql.column_value_char(cur_datos, 3, col3 );
            dbms_sql.column_value(cur_datos, 4, col4 );
            dbms_sql.column_value(cur_datos, 5, col5 );
            dbms_sql.column_value_char(cur_datos, 6, col6);
            dbms_sql.column_value_char(cur_datos, 7, col7);
            dbms_sql.column_value_char(cur_datos, 8, col8);
            dbms_sql.column_value(cur_datos, 9, col9 );
            dbms_sql.column_value(cur_datos, 10, col10 );
         end if;
         f_llamada(i):=col2;

         if not col3 is null then
            h_llamada(i):=substr(col3,1,2) || ':' || substr(col3,3,2) || ':' || substr(col3,5,2);
         else
             h_llamada(i):= Null;
         end if;

		 if not col5 is null then
	         if col5 = 1 then
	            tipo_llamada(i):='Entrante';
	         elsif col5 = 2 then
	               tipo_llamada(i):='Saliente';
	            elsif col5= 3 then
	                  tipo_llamada(i):='Transferencia';
	               else
	                  tipo_llamada(i):='Otros';
	         end if;
		 else
		   tipo_llamada(i):= null;
		 end if;

         if tip_llamada = 'L' then
             clasif_llamada(i):='Local';
         elsif tip_llamada = 'I' then
               clasif_llamada(i):='Interzona';
            elsif tip_llamada = 'E' then
                  clasif_llamada(i):='Especiales';
         end if;
         if not col8 is null then
	         dur_llamada(i):=substr(col8,1,2) || ':' || substr(col8,3,2) || ':' || substr(col8,5,2);
		 else
		     dur_llamada(i):= null;
		 end if;

         num_origen(i):=col1;

         num_destino(i):=col7;

         if col9 = 1 then
            horario(i):='BAJO';
         elsif col9 = 2 then
               horario(i):='NORMAL';
            else
               horario(i):='NORMAL';
         end if;

         valor(i):=col10;

         destino(i):= col6;


         i:= i + 1;
		 --error(n_error):= 'sgte record ' || to_char(i,'99999999');
		 --n_error:= n_error +1;
		 --if i > 313 then
		 --   raise error_param;
	     --end if;

       end loop;
	   		 --error(n_error):= 'fuera de loop';
		     --n_error:= n_error +1;


           max_reg := i - 1;
		 --error(n_error):= 'FIN FC_LOCALES';
		 --n_error:= n_error +1;
    EXCEPTION
            WHEN error_param THEN
             error(n_error):= 'imposible continuar';
            WHEN OTHERS THEN
            error(n_error):= TO_CHAR(SQLCODE);
            error(n_error+1):= sqlerrm;

END FC_locales;
/*----------------*/
PROCEDURE FTR (
                  cod_clientes   in varchar2,
              tip_identifica in varchar2,
              cod_cicl_fact  in number,
              tip_llamada    in varchar2,
              num_proceso     in number,
                f_llamada    out t_fecha_docto,
                h_llamada    out t_hora,
                tipo_llamada   out t_tipo_llamada,
                clasif_llamada out t_clasif_llamada,
                dur_llamada    out t_dur_llamada,
                num_origen     out t_num_origen,
                num_destino    out t_num_destino,
                horario      out t_horario,
                valor      out t_valor,
              destino      out t_destino,
              max_reg      out integer
               ) IS

   SSQL_SELECT   varchar2(300);
   SSQL_FROM   varchar2(100);
   SSQL_WHERE  varchar2(1000);
   ssql          varchar2(1400);
   i             integer;
   tabla     varchar2(1400);
   cur_datos     integer;
   j       integer;
   cod_cliente1  number(8);
   col1      varchar2(18);
   col2      date;
   col3      varchar2(8);
   col4      number(3);
   col5      number(1);
   col6      varchar2(30);
   col7      varchar2(18);
   col8      varchar2(6);
   col9      number(3);
   col10     number(14,4);
   begin
      i:= 1;
    if tip_llamada = 'T' then
       tabla:= EBZ_PAC_FA_SISCEL.ge_f_tipalmac(cod_cicl_fact, 'FA_DETFORTAS') ;
    elsif tip_llamada = 'R' then
       tabla:= EBZ_PAC_FA_SISCEL.ge_f_tipalmac(cod_cicl_fact, 'FA_DETROAMING') ;
    end if;
    if tabla <> 'NADA' or tabla<> '3' or substr(tabla,1,1) <> '*' then
       if tip_identifica = 'C' then
          if tip_llamada = 'T' then /*inTernacional*/
            /*                    1                  2            3           4           5            6                7               8             9              10         */
          SSQL_SELECT:= 'SELECT f.cod_operador, f.fec_call, f.hora_call, null aux2, null   aux3, f.des_entrada, f.ind_entrada, f.minutos_tasado, null aux4, f.acum_netollam ';
          SSQL_WHERE:=  'WHERE b.cod_cliente = ' || cod_clientes || ' ' ||
                  'AND b.num_proceso = ' || num_proceso || ' ' ||
                  'AND b.cod_tipconce = 4 ' ||
                  'AND f.cod_cliente = b.cod_cliente ' ||
                  'AND f.cod_periodo = b.cod_periodo ' ||
                  'AND f.cod_operador = b.cod_operador ' ||
                  'AND f.num_abonado = b.num_abonado ' ||
                  'ORDER BY f.fec_call, f.hora_call ASC';
        elsif tip_llamada = 'R' then /*Roaming*/
            /*                    1                  2           3                4           5            6                7               8        9              10                             */
          SSQL_SELECT:= 'SELECT null aux1     , a.fec_llamada, a.hor_llamada, null aux2, a.ind_entsal, a.des_destino, a.num_destino, a.seg_dura  , null aux4, a.imp_montolarga + a.imp_montoaire ';
          SSQL_WHERE:=  'WHERE b.cod_cliente = ' || cod_clientes || ' ' ||
                  'AND b.IND_TABLA = 3 ' ||
                  'AND a.cod_cliente = b.cod_cliente ' ||
                  'AND a.num_abonado = b.num_abonado ' ||
                  'AND a.cod_ciclfact = b.cod_ciclfact ' ||
                  'AND c.ind_operacion = 0 ' ||
                  'AND c.num_bloque = a.num_bloque ' ||
                  'AND c.cod_operador = b.cod_tarificacion ' ||
                  'ORDER BY a.fec_llamada, a.hor_llamada ';
        end if;
      elsif tip_identifica = 'A' then
        select cod_cliente into cod_cliente1 from ga_abocel where num_abonado = cod_clientes;
          if tip_llamada = 'T' then /*inTernacional*/
            /*                    1                  2            3           4           5            6                7               8             9              10         */
          SSQL_SELECT:= 'SELECT f.cod_operador, f.fec_call, f.hora_call, null aux2, null   aux3, f.des_entrada, f.ind_entrada, f.minutos_tasado, null aux4, f.acum_netollam ';
          SSQL_WHERE:=  'WHERE b.num_abonado = ' || cod_clientes || ' ' ||
                  'AND f.cod_cliente = ' || cod_cliente1 || ' ' ||
                  'AND b.num_proceso = ' || num_proceso || ' ' ||
                  'AND b.cod_tipconce = 4 ' ||
                  'AND f.cod_cliente = b.cod_cliente ' ||
                  'AND f.cod_periodo = b.cod_periodo ' ||
                  'AND f.cod_operador = b.cod_operador ' ||
                  'AND f.num_abonado = b.num_abonado ' ||
                  'ORDER BY f.fec_call, f.hora_call ASC';
        elsif tip_llamada = 'R' then /*Roaming*/
            /*                    1                  2           3                4           5            6                7               8        9              10                             */
          SSQL_SELECT:= 'SELECT null aux1     , a.fec_llamada, a.hor_llamada, null aux2, a.ind_entsal, a.des_destino, a.num_destino, a.seg_dura  , null aux4, a.imp_montolarga + a.imp_montoaire ';
          SSQL_WHERE:=  'WHERE b.cod_cliente = ' || cod_clientes || ' ' ||
                  'AND a.cod_cliente = ' || cod_cliente1 || ' ' ||
                  'AND b.IND_TABLA = 3 ' ||
                  'AND a.cod_cliente = b.cod_cliente ' ||
                  'AND a.num_abonado = b.num_abonado ' ||
                  'AND a.cod_ciclfact = b.cod_ciclfact ' ||
                  'AND c.ind_operacion = 0 ' ||
                  'AND c.num_bloque = a.num_bloque ' ||
                  'AND c.cod_operador = b.cod_tarificacion ' ||
                  'ORDER BY a.fec_llamada, a.hor_llamada ';
        end if;
      end if;
            if tip_llamada = 'T' then
         SSQL_FROM:=   'FROM ' || substr(tabla,2,length(tabla)) || ' f, FA_ACUMFORTAS b ';
      elsif tip_llamada = 'R' then
         SSQL_FROM:=   'FROM ' || substr(tabla,2,length(tabla)) || ' a, FA_HISTACUMLLAM  b, TA_CONCILIACION c ';
      end if;
      SSQL:= SSQL_SELECT || SSQL_FROM || SSQL_WHERE;
      cur_datos:= dbms_sql.open_cursor;
      dbms_sql.parse(cur_datos,SSQL, DBMS_SQL.V7);
      dbms_sql.define_column_char(cur_datos, 1, col1,18 );
      dbms_sql.define_column(cur_datos, 2, col2 );
      dbms_sql.define_column_char(cur_datos, 3, col3,6  );
      dbms_sql.define_column(cur_datos, 4, col4 );
      dbms_sql.define_column(cur_datos, 5, col5 );
      dbms_sql.define_column_char(cur_datos, 6, col6,30 );
      dbms_sql.define_column_char(cur_datos, 7, col7,18 );
      dbms_sql.define_column_char(cur_datos, 8, col8,6 );
      dbms_sql.define_column(cur_datos, 9, col9 );
      dbms_sql.define_column(cur_datos, 10, col10 );
      j:= dbms_sql.execute (cur_datos);
      loop
        j:=dbms_sql.fetch_rows(cur_datos);
        if j = 0 then
           exit;
        else
          dbms_sql.column_value_char(cur_datos, 1, col1);
          dbms_sql.column_value(cur_datos, 2, col2 );
          dbms_sql.column_value_char(cur_datos, 3, col3 );
          dbms_sql.column_value(cur_datos, 4, col4 );
          dbms_sql.column_value(cur_datos, 5, col5 );
          dbms_sql.column_value_char(cur_datos, 6, col6);
          dbms_sql.column_value_char(cur_datos, 7, col7);
          dbms_sql.column_value_char(cur_datos, 8, col8);
          dbms_sql.column_value(cur_datos, 9, col9 );
          dbms_sql.column_value(cur_datos, 10, col10 );
        end if;
        f_llamada(i):=col2;
        if not col3 is null then
           h_llamada(i):=substr(col3,1,2) || ':' || substr(col3,3,2) || ':' || substr(col3,5,2);
        else
           h_llamada(i):= Null;
        end if;
        if col5 = 1 then
           tipo_llamada(i):='Entrante';
        elsif col5 = 2 then
           tipo_llamada(i):='Saliente';
        elsif col5 = 3 then
           tipo_llamada(i):='Transferencia';
        elsif col5 is null then
           tipo_llamada(i):= null;
        else
           tipo_llamada(i):='';
        end if;
        if tip_llamada = 'T' then
           clasif_llamada(i):='Internacional';
        elsif tip_llamada = 'R' then
           clasif_llamada(i):='Roaming';
        end if;
        dur_llamada(i):=substr(col8,1,2) || ':' || substr(col8,3,2) || ':' || substr(col8,5,2);
        num_origen(i):=col1;
        num_destino(i):=col7;
        horario(i):=col9;
        valor(i):=col10;
        destino(i):= col6;
        i:= i +1;
      end loop;
      --dbms_sql.close_cursor(cur_datos);
      max_reg:= i-1;
    else
      max_reg:= 0;
    end if;
END FTR;
    PROCEDURE FA_MINUTOS_RUT (
                           identificacion  in varchar2,
                 --ciclo       in number,
                 cod_clientes    out t_cod_cliente_,
                 nombre      out t_nom_cliente_,
                 min_contratados out t_minutos,
                 min_utilizados  out t_minutos,
                 min_promo     out t_minutos,
                 min_promo_utili out t_minutos,
                 tipo_plan_tarif out t_tip_plan_tarif,
                 plan_tarif    out t_plan_tarif,
 				 error		   out t_error
                  ) IS
    i     		  number;
    j       	  integer;
    cli_aux2      number(8);
    cli_aux3  	  number(8);
    cli_aux5  	  number(8);
    cli_aux6  	  number(8);
    tot_min   	  number(10);
    tot_promo     number(10);
    tot_contr 	  number(10);
    tot_minE  	  number(10);
    tot_promoE    number(10);
    tot_contrE    number(10);
    cargado2      integer;
    cargado3  	  integer;
    cargado5  	  integer;
    cargado6  	  integer;
    c2_data   	  integer;
 /* 1 = no tiene datos*/
    c3_data   	 integer;
    c5_data   	 integer;
    c6_data   	 integer;

	error_param  exception;
	n_error		 integer;


    cursor c1 is
      --SELECT g1.cod_plantarif,g3.des_plantarif des_plantarif,g3.TIP_PLANTARIF tip_plantarif, g3.NUM_UNIDADES, a.cod_cliente cod, a.num_abonado num_abonado, a.nom_cliente nom
      SELECT distinct g1.cod_plantarif,g3.des_plantarif des_plantarif,g3.TIP_PLANTARIF tip_plantarif, sum(g3.NUM_UNIDADES) min_contratados, a.cod_cliente cod, a.nom_cliente nom, count (a.cod_cliente) cantidad
      FROM ta_plantarif g3, ga_abocel g1, (
                          SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, a.nom_cliente nom_cliente
                        FROM ga_abocel  g1, ga_usuarios g2,
                                           (select b.cod_cliente cod_cliente, b.nom_cliente nom_cliente
                                          from ga_cuentas a, ge_clientes b
                                          where a.num_ident = identificacion
                                          and b.cod_tipident = a.cod_tipident
                                          and a.cod_tipident in ( '01', '02')
                                          and a.cod_cuenta = b.cod_cuenta
                                           ) a
                        WHERE g1.cod_cliente = a.cod_cliente
                        AND g1.cod_usuario = g2.cod_usuario
                        AND g1.cod_situacion <> 'BAA'
      ) a
      WHERE
       g3.cod_PRODUCTO = 1
      AND g1.cod_plantarif = g3.cod_plantarif
      AND g1.num_abonado = a.num_abonado
      AND G1.COD_CLIENTE = a.cod_cliente
      group by g1.cod_plantarif,g3.des_plantarif,g3.TIP_PLANTARIF, a.cod_cliente , a.nom_cliente
      order by a.cod_cliente;
     cursor c2 is
          SELECT sum(c.num_minutos) num_minutos_promo, a.cod_cliente
          FROM ga_dtostarif c, (
                              SELECT  g1.num_abonado num_abonado, a.cod_cliente, a.cod_ciclfact cod_ciclfact
                              FROM ga_abocel  g1, ga_usuarios g2,
                                             (
                                              select b.cod_cliente cod_cliente, c.COD_CICLFACT COD_CICLFACT
                                              from ga_cuentas a, ge_clientes b, fa_ciclfact c
                                              where a.num_ident = identificacion --'4692887-3'
                                              and b.cod_tipident = a.cod_tipident
                                              and a.cod_tipident in ( '01', '02')
                                              and a.cod_cuenta = b.cod_cuenta
                            and c.COD_CICLO = b.cod_ciclo
                            and sysdate between c.fec_desdellam and c.fec_hastallam
                                             ) a
                              WHERE g1.cod_cliente = a.cod_cliente
                              AND g1.cod_usuario = g2.cod_usuario
                              AND g1.cod_situacion <> 'BAA'
                              ) a
          WHERE c.num_abonado = a.num_abonado
          and c.COD_CICLFACT = a.cod_ciclfact
          and c.TIP_PLANTARIF = 'I'
          group by a.cod_cliente
          order by a.cod_cliente;
          --SELECT c.num_minutos num_minutos_promo, a.num_abonado, b.cod_ciclfact, a.cod_cliente
/*          SELECT sum(c.num_minutos) num_minutos_promo, a.cod_cliente
          FROM ga_dtostarif c, (
                              SELECT  g1.num_abonado num_abonado, a.cod_cliente
                              FROM ga_abocel  g1, ga_usuarios g2,
                                             (
                                              select b.cod_cliente cod_cliente
                                              from ga_cuentas a, ge_clientes b
                                              where a.num_ident = identificacion --'4692887-3'
                                              and b.cod_tipident = a.cod_tipident
                                              and a.cod_tipident in ( '01', '02')
                                              and a.cod_cuenta = b.cod_cuenta
                                             ) a
                              WHERE g1.cod_cliente = a.cod_cliente
                              AND g1.cod_usuario = g2.cod_usuario
                              AND g1.cod_situacion <> 'BAA'
                              ) a,
                              (
                               select fa_ciclfact.cod_ciclfact cod_ciclfact
                               from fa_ciclfact
                               where fa_ciclfact.cod_ciclo = ciclo --5
                               and sysdate between fec_desdellam and fec_hastallam
                              ) b
          WHERE c.num_abonado = a.num_abonado
          and c.COD_CICLFACT = b.cod_ciclfact
          and c.TIP_PLANTARIF = 'I'
          group by a.cod_cliente
          order by a.cod_cliente;
*/
    cursor c3 is
        SELECT sum(d.SEG_PROMCONS) m_promo_consu, sum(d.SEG_CONSUMIDO) min_consumi, c.cod_cliente
        FROM ta_acumaire d,
         (
          SELECT a.cod_plantarif cod_plantarif, a.num_abonado num_abonado, a.cod_cliente cod_cliente, a.cod_ciclfact cod_ciclfact
          FROM ta_plantarif g3,  (
             SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, g1.cod_plantarif cod_plantarif, a.cod_ciclfact cod_ciclfact
             FROM ga_abocel  g1,
             (
             select b.cod_cliente cod_cliente, c.COD_CICLFACT cod_ciclfact
             from ga_cuentas a, ge_clientes b, fa_ciclfact c
             where a.num_ident = identificacion --'96786140-5'
             and b.cod_tipident = a.cod_tipident
             and a.cod_tipident in ( '01', '02')
             and a.cod_cuenta = b.cod_cuenta
           and c.COD_CICLO = b.cod_ciclo
           and sysdate between c.fec_desdellam and c.fec_hastallam
             ) a
             WHERE g1.cod_cliente = a.cod_cliente
             AND g1.cod_situacion <> 'BAA'
            ) a
          WHERE g3.cod_PRODUCTO = 1
          AND a.cod_plantarif = g3.cod_plantarif
          and g3.TIP_PLANTARIF = 'I'
         ) c
        WHERE d.NUM_ABONADO = c.num_abonado
        and d.COD_CICLFACT = c.cod_ciclfact
        and d.COD_PLANTARIF = c.cod_plantarif
        group by c.cod_cliente
        order by c.cod_cliente;
/*        SELECT sum(d.SEG_PROMCONS) m_promo_consu, sum(d.SEG_CONSUMIDO) min_consumi, c.cod_cliente
        FROM ta_acumaire d,
         (
         select fa_ciclfact.cod_ciclfact cod_ciclfact
         from fa_ciclfact
         where fa_ciclfact.cod_ciclo = ciclo
         and sysdate between fec_desdellam and fec_hastallam
         ) b,
         (
          SELECT a.cod_plantarif cod_plantarif, a.num_abonado num_abonado, a.cod_cliente cod_cliente
          FROM ta_plantarif g3,  (
             SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, g1.cod_plantarif cod_plantarif
             FROM ga_abocel  g1,
             (
             select b.cod_cliente cod_cliente
             from ga_cuentas a, ge_clientes b
             where a.num_ident = identificacion --'96786140-5'
             and b.cod_tipident = a.cod_tipident
             and a.cod_tipident in ( '01', '02')
             and a.cod_cuenta = b.cod_cuenta
             ) a
             WHERE g1.cod_cliente = a.cod_cliente
             AND g1.cod_situacion <> 'BAA'
            ) a
          WHERE g3.cod_PRODUCTO = 1
          AND a.cod_plantarif = g3.cod_plantarif
          and g3.TIP_PLANTARIF = 'I'
         ) c
        WHERE d.NUM_ABONADO = c.num_abonado
        and d.COD_CICLFACT = b.cod_ciclfact
        and d.COD_PLANTARIF = c.cod_plantarif
        group by c.cod_cliente
        order by c.cod_cliente;
*/
    cursor c7 is
          SELECT sum(g3.NUM_UNIDADES) min_contratados,a.cod_cliente cod_cliente
          FROM ta_plantarif g3,  (
                      SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, g1.cod_plantarif cod_plantarif
                        FROM ga_abocel  g1, ga_usuarios g2,
                                    (select b.cod_cliente cod_cliente
                                    from ga_cuentas a, ge_clientes b
                                    where a.num_ident = identificacion  --'4179820-3'
                                    and b.cod_tipident = a.cod_tipident
                                    and a.cod_tipident in ( '01', '02')
                                    and a.cod_cuenta = b.cod_cuenta
                                    ) a
                        WHERE g1.cod_cliente = a.cod_cliente
                        AND g1.cod_usuario = g2.cod_usuario
                        AND g1.cod_situacion <> 'BAA'
                      ) a
          WHERE g3.cod_PRODUCTO = 1
          AND a.cod_plantarif = g3.cod_plantarif
          AND g3.TIP_PLANTARIF ='E'
          GROUP BY a.cod_cliente
          ORDER BY A.COD_CLIENTE;
    cursor c6 is
          SELECT sum(a.SEG_PROMCONS)/60, sum(a.SEG_CONSUMIDO)/60, a.cod_cliente--, a.num_abonado
          FROM ta_acumaire a,
                   (
                  SELECT a.cod_cliente cod_cliente, g3.COD_PLANTARIF COD_PLANTARIF, a.COD_CICLFACT  cod_ciclfact, a.num_abonado num_abonado
                  FROM ta_plantarif g3,  (
                              SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, g1.cod_plantarif cod_plantarif, a.COD_CICLFACT cod_ciclfact
                                FROM ga_abocel  g1,
                                            (select b.cod_cliente cod_cliente, c.COD_CICLFACT cod_ciclfact
                                            from ga_cuentas a, ge_clientes b, fa_ciclfact c
                                            where a.num_ident = '85275700-0' --'4179820-3'
                                            and b.cod_tipident = a.cod_tipident
                                            and a.cod_tipident in ( '01', '02')
                                            and a.cod_cuenta = b.cod_cuenta
                                            and c.COD_CICLO = b.COD_CICLO
                                            and sysdate between c.fec_desdellam and c.fec_hastallam
                                            ) a
                                WHERE g1.cod_cliente = a.cod_cliente
                                AND g1.cod_situacion <> 'BAA'
                              ) a
                  WHERE g3.cod_PRODUCTO = 1
                  and g3.TIP_PLANTARIF = 'E'
                  AND a.cod_plantarif = g3.cod_plantarif
                   ) d
          WHERE a.num_abonado = d.num_abonado--a.COD_EMPRESA = b.COD_EMPRESA
          and a.COD_CICLFACT = d.cod_ciclfact
          and a.COD_PLANTARIF = d.cod_plantarif
          and a.COD_CLIENTE = d.cod_cliente
          group by a.cod_cliente
          order by a.cod_cliente;
          --SELECT a.SEG_PROMCONS,a.SEG_PROMPEND, b.cod_cliente
--          SELECT sum(a.SEG_PROMCONS)/60 , sum(a.SEG_CONSUMIDO)/60, b.cod_cliente
--          FROM ta_acumaireEMP a, ga_empresa b,
--                   (
--                  SELECT a.cod_cliente cod_cliente, g3.COD_PLANTARIF COD_PLANTARIF, a.COD_CICLFACT  cod_ciclfact
--                  FROM ta_plantarif g3,  (
--                              SELECT  g1.num_abonado num_abonado, g1.cod_cliente cod_cliente, g1.cod_plantarif cod_plantarif, a.COD_CICLFACT cod_ciclfact
--                                FROM ga_abocel  g1, ga_usuarios g2,
--                                            (select b.cod_cliente cod_cliente, c.COD_CICLFACT cod_ciclfact
--                                            from ga_cuentas a, ge_clientes b, fa_ciclfact c
--                                            where a.num_ident = identificacion --'4179820-3'
--                                            and b.cod_tipident = a.cod_tipident
--                                            and a.cod_tipident in ( '01', '02')
--                                            and a.cod_cuenta = b.cod_cuenta
--                                            and c.COD_CICLO = b.COD_CICLO
--                                            and sysdate between c.fec_desdellam and c.fec_hastallam
--                                            ) a
--                                WHERE g1.cod_cliente = a.cod_cliente
--                                AND g1.cod_usuario = g2.cod_usuario
--                              AND g1.cod_situacion <> 'BAA'
--                              ) a
--                  WHERE g3.cod_PRODUCTO = 1
--                  and g3.TIP_PLANTARIF = 'E'
--                  AND a.cod_plantarif = g3.cod_plantarif
--                   ) d
--          WHERE a.COD_EMPRESA = b.COD_EMPRESA
--          /*and a.cod_ciclfact = b.COD_CICLO*/
--          and a.COD_CICLFACT = d.cod_ciclfact
--          and a.COD_PLANTARIF = d.cod_plantarif
--          and b.COD_CLIENTE = d.cod_cliente
--          and b.cod_producto = 1
--          group by b.cod_cliente
--          order by b.cod_cliente;






cursor c5 is
                        select a.num_minutos num_minutos, b.cod_cliente cod_cliente
                        from ga_dtostarif a, (
                                                                        select a.COD_GRUPO cod_grupo ,b.cod_ciclfact cod_ciclfact, b.cod_cliente cod_cliente
                                                                        from ga_intarcel a,(
                                        select b.cod_cliente cod_cliente, c.COD_CICLFACT cod_ciclfact, '000000' || c.cod_ciclfact c_formato
                                                                                                                from ga_cuentas a, ge_clientes b, fa_ciclfact c
                                                                                                                where a.num_ident = identificacion  --'4179820-3'
                                                                                                                and b.cod_tipident = a.cod_tipident
                                                                                                                and a.cod_tipident in ( '01', '02')
                                                                                                                and a.cod_cuenta = b.cod_cuenta
                                                                                                                and c.COD_CICLO = b.cod_ciclo
                                                                                                                and sysdate between c.fec_desdellam and c.fec_hastallam
                                                                                           ) b
                                                                        where a.cod_cliente = b.cod_cliente
                                                                        and to_date(to_char(a.FEC_DESDE,'dd-mm-yy'),'dd-mm-yy') <= to_date(substr(c_formato,length(c_formato)-5,2) || '-' || substr(c_formato,length(c_formato)-3,2) || '-' || substr(c_formato,length(c_formato)-1,2),'dd-mm-yy')
                                                                        and to_date(to_char(a.FEC_HASTA, 'dd-mm-yy'),'dd-mm-yy') >= to_date(substr(c_formato,length(c_formato)-5,2) || '-' || substr(c_formato,length(c_formato)-3,2) || '-' || substr(c_formato,length(c_formato)-1,2),'dd-mm-yy')
                                                                ) b
                        where a.NUM_ABONADO = b.cod_grupo
                        and a.cod_ciclfact = b.cod_ciclfact;
    BEGIN

	   n_error:=1;
       i:= 1;
       cargado2:= 2;
 /* 0 = no cargo datos 1= cargo datos 2= nunca consultado*/
       cargado3:= 2;
 /* 0 = no cargo datos 1= cargo datos 2= nunca consultado*/
       cargado5:= 2;
 /* 0 = no cargo datos 1= cargo datos 2= nunca consultado*/
       cargado6:= 2;
 /* 0 = no cargo datos 1= cargo datos 2= nunca consultado*/
       c2_data:= 0;
       c3_data:= 0;
       c5_data:= 0;
       c6_data:= 0;
	   --error(n_error):= 'inicio';
	   --n_error:= n_error+1;
       FOR L in c1 LOOP
           cod_clientes (i):= L.cod;
           nombre(i):= L.nom;
           if L.tip_plantarif = 'I' then
      	 	tipo_plan_tarif(i):= 'Individual';
           elsif L.tip_plantarif = 'E' then
              tipo_plan_tarif(i):= 'Empresa';
           end if;
           plan_tarif(i):= L.des_plantarif;
           if L.tip_plantarif = 'I' then
              min_contratados(i):= L.min_contratados;
              if not  c2%ISOPEN then
                 OPEN c2;
              end if;
	          if c2_data = 0 then
	            if cargado2= 1 or cargado2 = 2 then
	               fetch c2 into tot_min, cli_aux2;
	               if NOT c2%FOUND then
	                  c2_data := 1;
	               end if;
	               if c2_data = 0 then
	                 if cli_aux2 = cod_clientes(i) then
	                    min_promo(i):= tot_min;
	                  cargado2:= 1;
	                 else
	                    cargado2:= 0;
	                 end if;
	               end if;
	            elsif cargado2 = 0 then
	               if cli_aux2 = cod_clientes(i) then
	                  min_promo(i):= tot_min;
	                  cargado2:= 1;
	               else
	                  cargado2:= 0;
	               end if;
            	end if;
              end if;
	          if NOT c3%ISOPEN then
	             OPEN c3;
	          end if;
	          if c3_data = 0 then
	            if cargado3= 1 or cargado3 = 2 then
	               fetch c3 into tot_promo,tot_contr, cli_aux3;
	               if NOT c3%FOUND then
	                  c3_data:= 1;
	               end if;
	               if c3_data = 0 then
	                 if cli_aux3 = cod_clientes(i) then
	                    min_promo_utili(i):= tot_promo;
	                  min_utilizados(i):=tot_contr;
	                  cargado3:= 1;
	                 else
	                    cargado3:= 0;
	                 end if;
	               end if;
	            elsif cargado3 = 0 then
	               if cli_aux3 = cod_clientes(i) then
	                  min_promo_utili(i):= tot_promo;
	                min_utilizados(i):=tot_contr;
	                cargado3:= 1;
	               else
	                  cargado3:= 0;
	               end if;
	            end if;
	          end if;
           elsif L.tip_plantarif = 'E' then
		      --error(n_error):= 'dentro empresa';
			  --n_error:= n_error+1;
			  if L.cantidad > 0 then
                 min_contratados(i):= L.min_contratados/L.cantidad;
			  else
			     min_contratados(i):= null;
			  end if;
		      --error(n_error):= to_char(L.cantidad,'999999') || '--' || to_char(L.min_contratados,'9999999') || '+++';
			  --n_error:= n_error+1;

              if NOT c5%ISOPEN then
                 OPEN c5;
              end if;
		      --error(n_error):= 'Abierto c5';
			  --n_error:= n_error+1;

	          if c5_data= 0 then
	            if cargado5= 1 or cargado5 = 2 then
	               fetch c5 into tot_minE, cli_aux5;
			       --error(n_error):= 'tot_minE y cli_aux5' || to_char(tot_minE,'9999999') || '--' || to_char(cli_aux5,'99999999') || '+++';
				   --n_error:= n_error+1;

	               if not c5%FOUND then
	                  c5_data:= 1;
	               end if;
	               if c5_data = 0 then
	                 if cli_aux5 = cod_clientes(i) then
	                    min_promo(i):= tot_minE;
	                  cargado2:= 1;
	                 else
	                    cargado2:= 0;
	                 end if;
	               end if;
	            elsif cargado5 = 0 then
	               if cli_aux5 = cod_clientes(i) then
	                  min_promo(i):= tot_minE;
	                cargado5:= 1;
	               else
	                  cargado5:= 0;
	               end if;
	            end if;
	          end if;
	          if NOT  c6%ISOPEN then
	             OPEN c6;
	          end if;
		      --error(n_error):= 'abierto c6';
			  --n_error:= n_error+1;

	          if c6_data = 0 then
			       --error(n_error):= 'dentro if c6_data = 0';
				   --n_error:= n_error+1;

	            if cargado6= 1 or cargado6 = 2 then
			       --error(n_error):= 'dentro if cargado6= 1 or cargado6 = 2';
				   --n_error:= n_error+1;

	               fetch c6 into tot_promoE,tot_contrE, cli_aux6;
			       --error(n_error):= to_char(tot_promoE,'99999999') || '--' || to_char(tot_contrE,'99999999') || '--' || to_char(cli_aux6,'9999999');
				   --n_error:= n_error+1;

	               if NOT c6%FOUND then
	                  c6_data:= 1;
	               end if;
	               if c6_data = 0 then
	                 if cli_aux6 = cod_clientes(i) then
	                    min_promo_utili(i):= tot_promoE;
	                  min_utilizados(i):=tot_contrE;
	                  cargado6:= 1;
	                 else
	                    cargado6:= 0;
	                 end if;
	               end if;
	            elsif cargado6 = 0 then
			       --error(n_error):= 'dentro if cargado6 = 0';
				   --n_error:= n_error+1;

	               if cli_aux6 = cod_clientes(i) then
	                  min_promo_utili(i):= tot_promoE;
	                  min_utilizados(i):=tot_contrE;
	                  cargado6:= 1;
	               else
	                  cargado6:= 0;
	               end if;
	            end if;
	          end if;
           end if;
           i:= i +1;
	       --error(n_error):= 'sgte i' || to_char(i,'9999999');
		   --n_error:= n_error+1;

       END LOOP;
	EXCEPTION
	   WHEN OTHERS THEN
	   		error(n_error):= 'Error: Imposible Continuar';

    END FA_MINUTOS_RUT;
end;
/
SHOW ERRORS
