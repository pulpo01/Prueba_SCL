CREATE OR REPLACE PACKAGE BODY        MI_REPORT_BEEPER
 AS
Procedure proc_suspe_beeper(v_inicial in varchar2,
                            v_final in varchar2,
                            tabla in varchar2,
                            direccion in varchar2,
                            v_error in out  number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero_err utl_file.file_type;
arch_susp_beep varchar2(40):='susp_beep_';
formato varchar2(6):='ddmmyy';
sentencia_susp_beep varchar2(200);
num_beeper varchar2(9);
cursor_name integer;
filas integer;
fecha_actual varchar2(8);
begin
  Select to_char(sysdate,'ddmmyyyy')
  Into fecha_actual
  From dual;
  arch_susp_beep:=arch_susp_beep||fecha_actual||'.txt';
  sentencia_susp_beep:=
'SELECT to_char(ID) from '||tabla||' where cod_actuacion=5 and id < 9900000 and
trunc(fec_historico)>=to_date('||''''||v_inicial||''''||','||''''||formato||
''''||') and trunc(fec_historico)<=to_date('||''''||v_final||''''||','||''''
||formato||''''||')';
  cursor_name:=dbms_sql.open_cursor;
  dbms_sql.parse(cursor_name,sentencia_susp_beep,DBMS_SQL.V7);
  dbms_sql.define_column(cursor_name,1,num_beeper,9);
  filas:=dbms_sql.execute(cursor_name);
  puntero:=utl_file.fopen(direccion,arch_susp_beep,modo);
  if utl_file.is_open(puntero) Then
    Loop
     If dbms_sql.fetch_rows(cursor_name)>0 Then
       dbms_sql.column_value(cursor_name,1,num_beeper);
       Utl_file.put_line(puntero,'S'||num_beeper);
     else
       exit;
     end if;
    End Loop;
    Utl_file.fclose(puntero);
    dbms_sql.close_cursor(cursor_name);
    v_error:=0;
  end if;
Exception
  When utl_file.invalid_path then
    Utl_file.put_line(puntero,'PATH');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_mode then
    Utl_file.put_line(puntero,'MODE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_operation then
    Utl_file.put_line(puntero,'OPERACION ');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.internal_error then
    Utl_file.put_line(puntero,'INTERNAL ERROR');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_filehandle then
    Utl_file.put_line(puntero,'FILE HANDLE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When no_data_found Then
    Utl_file.put_line(puntero,'NO SE ENCONTRARON ABONADOS SUSPENSION BEEP.....');
  When others Then
    Utl_file.put_line(puntero,'OTROS..');
    If dbms_sql.is_open(cursor_name) then
      dbms_sql.close_cursor(cursor_name);
    End if;
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
end;
Procedure proc_repo_beeper(v_inicial in varchar2,
                           v_final in varchar2,
                           tabla in varchar2,
                           direccion in varchar2,
                           v_error in out  number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero_err utl_file.file_type;
arch_susp_beep varchar2(40):='repo_beep_';
formato varchar2(6):='ddmmyy';
sentencia_susp_beep varchar2(200);
num_beeper varchar2(9);
cursor_name integer;
filas integer;
fecha_actual varchar2(8);
begin
  Select to_char(sysdate,'ddmmyyyy')
  Into fecha_actual
  From dual;
  arch_susp_beep:=arch_susp_beep||fecha_actual||'.txt';
  sentencia_susp_beep:=
'SELECT to_char(ID) from '||tabla||' where cod_actuacion=6 and id < 9900000 and
trunc(fec_historico)>=to_date('||''''||v_inicial||''''||','||''''||formato||
''''||') and trunc(fec_historico)<=to_date('||''''||v_final||''''||','||''''
||formato||''''||')';
  cursor_name:=dbms_sql.open_cursor;
  dbms_sql.parse(cursor_name,sentencia_susp_beep,DBMS_SQL.V7);
  dbms_sql.define_column(cursor_name,1,num_beeper,9);
  filas:=dbms_sql.execute(cursor_name);
  puntero:=utl_file.fopen(direccion,arch_susp_beep,modo);
  if utl_file.is_open(puntero) Then
    Loop
     If dbms_sql.fetch_rows(cursor_name)>0 Then
       dbms_sql.column_value(cursor_name,1,num_beeper);
       Utl_file.put_line(puntero,'N'||num_beeper);
     else
       exit;
     end if;
    End Loop;
    Utl_file.fclose(puntero);
    dbms_sql.close_cursor(cursor_name);
    v_error:=0;
  end if;
Exception
  When utl_file.invalid_path then
    Utl_file.put_line(puntero,'PATH');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_mode then
    Utl_file.put_line(puntero,'MODE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_operation then
    Utl_file.put_line(puntero,'OPERACION ');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.internal_error then
    Utl_file.put_line(puntero,'INTERNAL ERROR');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_filehandle then
    Utl_file.put_line(puntero,'FILE HANDLE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When no_data_found Then
    Utl_file.put_line(puntero,'NO SE ENCONTRARON ABONADOS REPOSICION BEEP.....');
  When others Then
    Utl_file.put_line(puntero,'OTROS..');
    If dbms_sql.is_open(cursor_name) then
      dbms_sql.close_cursor(cursor_name);
    End if;
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
end;
Procedure proc_suspe_trunk(v_inicial in varchar2,
                            v_final in varchar2,
                            tabla in varchar2,
                            direccion in varchar2,
                            v_error in out  number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero_err utl_file.file_type;
arch_susp_beep varchar2(40):='susp_trun_';
formato varchar2(6):='ddmmyy';
sentencia_susp_beep long;
num_ident varchar2(9);
cod_cliente varchar2(8);
nom_cliente varchar2(50);
nom_apeclien1 varchar2(50);
nom_apeclien2 varchar2(50);
nombre_cliente varchar2(50);
num_serie varchar2(14);
palabra1 varchar2(200);
palabra2 varchar2(200);
palabra3 varchar2(200);
palabar4 varchar2(200);
cursor_name integer;
filas integer;
fecha_actual varchar2(8);
begin
  Select to_char(sysdate,'ddmmyyyy')
  Into fecha_actual
  From dual;
  arch_susp_beep:=arch_susp_beep||fecha_actual||'.txt';
  palabra1:='Select c.num_ident,to_char(c.cod_cliente),c.nom_cliente,c.nom_apeclien1,c.nom_apeclien2,b.num_serie from '||tabla||' a,ga_abobeep b,ge_clientes c';
  palabra2:=' Where cod_actuacion=5 and id >= 9900000 and a.num_abonado=b.num_abonado and b.cod_cliente=c.cod_cliente and trunc(a.fec_historico) >= to_date(';
  palabra3:=''''||v_inicial||''''||','||''''||formato|| ''''||') and trunc(a.fec_historico)<=to_date('||''''||v_final||''''||','||'''' ||formato||''''||')';
  cursor_name:=dbms_sql.open_cursor;
  dbms_sql.parse(cursor_name,palabra1||palabra2||palabra3,DBMS_SQL.V7);
  dbms_sql.define_column(cursor_name,1,num_ident,9);
  dbms_sql.define_column(cursor_name,2,cod_cliente,8);
  dbms_sql.define_column(cursor_name,3,nom_cliente,50);
  dbms_sql.define_column(cursor_name,4,nom_apeclien1,50);
  dbms_sql.define_column(cursor_name,5,nom_apeclien2,50);
  dbms_sql.define_column(cursor_name,6,num_serie,14);
  filas:=dbms_sql.execute(cursor_name);
  puntero:=utl_file.fopen(direccion,arch_susp_beep,modo);
  if utl_file.is_open(puntero) Then
    Loop
     If dbms_sql.fetch_rows(cursor_name)>0 Then
       dbms_sql.column_value(cursor_name,1,num_ident);
       dbms_sql.column_value(cursor_name,2,cod_cliente);
       dbms_sql.column_value(cursor_name,3,nom_cliente);
       dbms_sql.column_value(cursor_name,4,nom_apeclien1);
       dbms_sql.column_value(cursor_name,5,nom_apeclien2);
       dbms_sql.column_value(cursor_name,6,num_serie);
       nombre_cliente:=substr(ltrim(rtrim(nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2)),1,50);
       Utl_file.put_line(puntero,num_ident||'|'||cod_cliente||'|'||nombre_cliente||'|'||num_serie);
     else
       exit;
     end if;
    End Loop;
    utl_file.fclose(puntero);
    dbms_sql.close_cursor(cursor_name);
    v_error:=0;
  end if;
Exception
  When utl_file.invalid_path then
    Utl_file.put_line(puntero,'PATH');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_mode then
    Utl_file.put_line(puntero,'MODE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_operation then
    Utl_file.put_line(puntero,'OPERACION ');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.internal_error then
    Utl_file.put_line(puntero,'INTERNAL ERROR');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_filehandle then
    Utl_file.put_line(puntero,'FILE HANDLE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When no_data_found Then
    Utl_file.put_line(puntero,'NO SE ENCONTRARON ABONADOS SUSPENSION TRUN.....');
  When others Then
    Utl_file.put_line(puntero,'OTROS..');
    If dbms_sql.is_open(cursor_name) then
      dbms_sql.close_cursor(cursor_name);
    End if;
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
end;
Procedure proc_repo_trunk(v_inicial in varchar2,
                            v_final in varchar2,
                            tabla in varchar2,
                            direccion in varchar2,
                            v_error in out  number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero_err utl_file.file_type;
arch_susp_beep varchar2(40):='repo_trun_';
formato varchar2(6):='ddmmyy';
sentencia_susp_beep long;
num_ident varchar2(9);
cod_cliente varchar2(8);
nom_cliente varchar2(50);
nom_apeclien1 varchar2(50);
nom_apeclien2 varchar2(50);
nombre_cliente varchar2(50);
num_serie varchar2(14);
palabra1 varchar2(200);
palabra2 varchar2(200);
palabra3 varchar2(200);
palabar4 varchar2(200);
cursor_name integer;
filas integer;
fecha_actual varchar2(8);
begin
  Select to_char(sysdate,'ddmmyyyy')
  Into fecha_actual
  From dual;
  arch_susp_beep:=arch_susp_beep||fecha_actual||'.txt';
  palabra1:='Select c.num_ident,to_char(c.cod_cliente),c.nom_cliente,c.nom_apeclien1,c.nom_apeclien2,b.num_serie from '||tabla||' a,ga_abobeep b,ge_clientes c';
  palabra2:=' Where cod_actuacion=6 and id >= 9900000 and a.num_abonado=b.num_abonado and b.cod_cliente=c.cod_cliente and trunc(a.fec_historico) >= to_date(';
  palabra3:=''''||v_inicial||''''||','||''''||formato|| ''''||') and trunc(a.fec_historico)<=to_date('||''''||v_final||''''||','||'''' ||formato||''''||')';
  cursor_name:=dbms_sql.open_cursor;
  dbms_sql.parse(cursor_name,palabra1||palabra2||palabra3,DBMS_SQL.V7);
  dbms_sql.define_column(cursor_name,1,num_ident,9);
  dbms_sql.define_column(cursor_name,2,cod_cliente,8);
  dbms_sql.define_column(cursor_name,3,nom_cliente,50);
  dbms_sql.define_column(cursor_name,4,nom_apeclien1,50);
  dbms_sql.define_column(cursor_name,5,nom_apeclien2,50);
  dbms_sql.define_column(cursor_name,6,num_serie,14);
  filas:=dbms_sql.execute(cursor_name);
  puntero:=utl_file.fopen(direccion,arch_susp_beep,modo);
  if utl_file.is_open(puntero) Then
    Loop
     If dbms_sql.fetch_rows(cursor_name)>0 Then
       dbms_sql.column_value(cursor_name,1,num_ident);
       dbms_sql.column_value(cursor_name,2,cod_cliente);
       dbms_sql.column_value(cursor_name,3,nom_cliente);
       dbms_sql.column_value(cursor_name,4,nom_apeclien1);
       dbms_sql.column_value(cursor_name,5,nom_apeclien2);
       dbms_sql.column_value(cursor_name,6,num_serie);
       nombre_cliente:=substr(ltrim(rtrim(nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2)),1,50);
      Utl_file.put_line(puntero,num_ident||'|'||cod_cliente||'|'||nombre_cliente||'|'||num_serie);
     else
       exit;
     end if;
    End Loop;
    utl_file.fclose(puntero);
    dbms_sql.close_cursor(cursor_name);
    v_error:=0;
  end if;
Exception
  When utl_file.invalid_path then
    Utl_file.put_line(puntero,'PATH');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_mode then
    Utl_file.put_line(puntero,'MODE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_operation then
    Utl_file.put_line(puntero,'OPERACION ');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.internal_error then
    Utl_file.put_line(puntero,'INTERNAL ERROR');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When utl_file.invalid_filehandle then
    Utl_file.put_line(puntero,'FILE HANDLE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
  When no_data_found Then
    Utl_file.put_line(puntero,'NO SE ENCONTRARON ABONADOS REPOSICION TRUNK.....');
  When others Then
    Utl_file.put_line(puntero,'OTROS..');
    If dbms_sql.is_open(cursor_name) then
      dbms_sql.close_cursor(cursor_name);
    End if;
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_error:=1;
end;
Procedure proc_principal(fec_inicial in varchar2,
                         fec_final in varchar2,
                         path in varchar2) is
cod_error number;
tabla varchar2(20);
mes varchar2(2);
agno varchar2(2);
puntero utl_file.file_type;
status number;
Begin
  cod_error:=0;
  puntero:=utl_file.fopen(path,'REP_BEEP_ERR.LOG','w');
  Utl_file.put_line(puntero,'Proceso Iniciado .....');
  mes:=substr(fec_inicial,3,2);
  agno:=substr(fec_inicial,5,2);
  tabla:='ICB_HISTMOV'||mes||'20'||agno;
  proc_suspe_beeper(fec_inicial,fec_final,tabla,path,cod_error);
  proc_repo_beeper(fec_inicial,fec_final,tabla,path,cod_error);
  proc_suspe_trunk(fec_inicial,fec_final,tabla,path,cod_error);
  proc_repo_trunk(fec_inicial,fec_final,tabla,path,cod_error);
  if utl_file.is_open(puntero) Then
    if cod_error=1 then
       Utl_file.put_line(puntero,'Proceso Finalizado con Error...');
    else
       Utl_file.put_line(puntero,'Proceso Finalizado exitosamente...');
    end if;
  end if;
  Utl_file.fclose(puntero);
End;
End mi_report_beeper;
/
SHOW ERRORS
