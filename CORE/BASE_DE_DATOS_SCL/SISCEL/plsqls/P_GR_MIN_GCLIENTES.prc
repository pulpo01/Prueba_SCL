CREATE OR REPLACE PROCEDURE        P_GR_MIN_GCLIENTES
 (p_tabla in varchar2, p_fec_desde in date , p_fec_hasta in date, p_dir in varchar2, p_archivo in varchar2) IS
 v_cod_cliente                ve_vendcliente.cod_cliente%TYPE;
 v_rut                        ge_clientes.num_Ident%TYPE;
 v_fecha_emision        fa_histdocu.fec_emision%TYPE;
 v_num_folio                fa_histdocu.num_folio%TYPE;
 v_cod_vendedor                ve_vendcliente.cod_vendedor%TYPE;
 v_minutos                varchar(6);
 v_cursor                INTEGER;
 v_resul                INTEGER;
 v_consulta1                varchar2(3000);
 v_cod_tipcomis                char(2);
 v_num_ident            varchar2(2);
 v_file                        UTL_FILE.FILE_TYPE;
 v_cantidad             integer;
BEGIN
 v_cod_tipcomis:='14' ;
 v_num_ident:='7';
 v_cursor:=DBMS_SQL.OPEN_CURSOR;
 v_consulta1:='SELECT a.cod_cliente,b.num_Ident,c.fec_emision,c.num_folio,a.cod_vendedor,'||
                'sum(substr(dur_local1,1,2)*60+substr(dur_local1,3,2)), count(*) '||
                'from ve_vendcliente a,ge_clientes b,fa_histdocu c,'||p_tabla||
                ' e, ve_vendedores f where f.cod_tipcomis='||chr(39)||v_cod_tipcomis||chr(39)||
                ' and f.cod_vendedor=a.cod_vendedor and a.fec_desasignac is null and '||
                'a.cod_cliente=b.cod_cliente and b.num_ident<'||chr(39)||v_num_ident||chr(39)||
                ' and b.cod_cliente=c.cod_cliente and c.cod_tipdocum=2 and c.fec_emision>='||
                chr(39)||p_fec_desde||chr(39)|| 'and c.fec_emision<'||chr(39)||p_fec_hasta||chr(39)||
                ' and c.cod_cliente=e.cod_cliente and ind_tiplla1<>2 '||
                'group by a.cod_cliente,b.num_Ident,c.fec_emision, c.num_folio,a.cod_vendedor';
 DBMS_SQL.PARSE(v_cursor, v_consulta1, DBMS_SQL.V7);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 1,v_cod_cliente);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 2,v_rut,11);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 3,v_fecha_emision);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 4,v_num_folio);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 5,v_cod_vendedor);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 6,v_minutos,6);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 7,v_cantidad);
 v_file:=UTL_FILE.FOPEN(p_dir,p_archivo, 'w');
 v_resul:=DBMS_SQL.EXECUTE(v_cursor);
 LOOP
  if DBMS_SQL.FETCH_ROWS(v_cursor) = 0 then
   exit;
  end if;
  DBMS_SQL.COLUMN_VALUE(v_cursor, 1,v_cod_cliente);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 2,v_rut);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 3,v_fecha_emision);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 4,v_num_folio);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 5,v_cod_vendedor);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 6,v_minutos);
  DBMS_SQL.COLUMN_VALUE(v_cursor,7,v_cantidad);
  UTL_FILE.PUT_LINE(v_file, v_cod_cliente||'|'||v_rut||'|'||v_fecha_emision||'|'||v_num_folio||'|'||v_cod_vendedor||'|'||v_minutos||'|'||v_cantidad);
 END LOOP;
 DBMS_SQL.CLOSE_CURSOR(v_cursor);
 v_num_ident:='7';
 v_cursor:=DBMS_SQL.OPEN_CURSOR;
 v_consulta1:='SELECT a.cod_cliente,b.num_Ident,c.fec_emision,c.num_folio,a.cod_vendedor,'||
            'sum(substr(dur_local1,1,2)*60+substr(dur_local1,3,2)), count(*) '||
            'from ve_vendcliente a,ge_clientes b,fa_histdocu c,'||p_tabla||
            ' e, ve_vendedores f where f.cod_tipcomis='||chr(39)||v_cod_tipcomis||chr(39)||
            ' and f.cod_vendedor=a.cod_vendedor and a.fec_desasignac is null and '||
            'a.cod_cliente=b.cod_cliente and b.num_ident>'||chr(39)||v_num_ident||chr(39)||
            ' and b.cod_cliente=c.cod_cliente and c.cod_tipdocum=2 and c.fec_emision>='||
            chr(39)||p_fec_desde||chr(39)|| 'and c.fec_emision<'||chr(39)||p_fec_hasta||chr(39)||
            ' and c.cod_cliente=e.cod_cliente and ind_tiplla1<>2 '||
            'group by a.cod_cliente,b.num_Ident,c.fec_emision, c.num_folio,a.cod_vendedor';
 DBMS_SQL.PARSE(v_cursor, v_consulta1, DBMS_SQL.V7);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 1,v_cod_cliente);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 2,v_rut,11);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 3,v_fecha_emision);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 4,v_num_folio);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 5,v_cod_vendedor);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 6,v_minutos,6);
 DBMS_SQL.DEFINE_COLUMN(v_cursor, 7,v_cantidad);
 v_resul:=DBMS_SQL.EXECUTE(v_cursor);
 LOOP
  if DBMS_SQL.FETCH_ROWS(v_cursor) = 0 then
   exit;
  end if;
  DBMS_SQL.COLUMN_VALUE(v_cursor, 1,v_cod_cliente);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 2,v_rut);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 3,v_fecha_emision);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 4,v_num_folio);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 5,v_cod_vendedor);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 6,v_minutos);
  DBMS_SQL.COLUMN_VALUE(v_cursor, 7,v_cantidad);
  UTL_FILE.PUT_LINE(v_file, v_cod_cliente||'|'||v_rut||'|'||v_fecha_emiSion||'|'||v_num_folio||'|'||v_cod_vendedor||'|'||v_minutos||'|'||v_cantidad);
 END LOOP;
 DBMS_SQL.CLOSE_CURSOR(v_cursor);
 UTL_FILE.FCLOSE(v_file);
end;
/
SHOW ERRORS
