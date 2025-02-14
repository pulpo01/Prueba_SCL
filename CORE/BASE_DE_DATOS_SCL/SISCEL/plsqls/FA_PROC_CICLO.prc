CREATE OR REPLACE PROCEDURE        fa_proc_ciclo(
  v_ano IN varchar2 ,
  v_ciclo IN varchar2 ,
  v_fecemi IN varchar2 ,
  v_fecvenci IN varchar2 ,
  v_fecdesde IN varchar2 ,
  v_secini IN varchar2 ,
  v_caduci IN varchar2 ,
  v_dir_logs IN varchar2 ,
  v_dir_spool IN varchar2 )
IS
v_dias        number(3) := 0;
v_secuenci    number(2) := 0;
v_loop        number(2) := 0;
v_ciclofact   Fa_CiclFact.Cod_CiclFact%TYPE;
v_auxfecdesde date;
v_auxfechasta date;
v_auxfemision date;
v_auxfvenci   date;
v_auxdllam    date;
v_auxhllam    date;
v_auxdcfijo   date;
v_auxhcfijo   date;
v_auxdcargo   date;
v_auxhcargo   date;
v_auxdroa     date;
v_auxhroa     date;
v_kk1 varchar2(1);
v_kk2 varchar2(1);
v_kk3 varchar2(1);
v_kk4 varchar2(1);
v_kk5 varchar2(1);
v_kk6 varchar2(1);
v_kk7 varchar2(1);
  Begin
--  v_auxfemision := to_date(v_fecemi,'ddmmyyyy');
    v_auxfvenci   := to_date(v_fecvenci,'ddmmyyyy');
    v_auxfechasta := (add_months(to_date(v_fecdesde,'ddmmyyyy'),1) - 1);
    v_auxfecdesde := to_date(v_fecdesde,'ddmmyyyy');
    v_loop        := lpad(to_number(to_char(v_auxfecdesde,'mm')),2,'0');
    v_dias        := to_number(v_caduci);
    v_secuenci    := to_number(v_secini);
    dbms_output.put_line('PARAMETROS DE ENTRADA');
    dbms_output.put_line('V_ANO = '||v_ano);
    dbms_output.put_line('V_CICLO = '||v_ciclo);
    dbms_output.put_line('V_FECEMI = '||v_fecemi);
    dbms_output.put_line('V_FECVENCI = '||v_fecvenci);
    dbms_output.put_line('V_FECDESDE = '||v_fecdesde);
    dbms_output.put_line('V_SECINI = '||v_secini);
    dbms_output.put_line('V_CADUCI = '||v_caduci);
    dbms_output.put_line('V_DIR_LOGS = '||v_dir_logs);
    dbms_output.put_line('V_DIR_SPOOL = '||v_dir_spool);
    dbms_output.put_line('PARAMETROS DE PROGRAMA');
    dbms_output.put_line('V_AUXFVENCI = '||to_char(v_auxfvenci,'ddmmyyyy'));
    dbms_output.put_line('V_AUXFECHASTA = '||to_char(v_auxfechasta,'ddmmyyyy
'));
    dbms_output.put_line('V_AUXFECDESDE = '||to_char(v_auxfecdesde,'ddmmyyyy
'));
    dbms_output.put_line('V_LOOP = '||to_char(v_loop));
    dbms_output.put_line('V_DIAS = '||to_char(v_dias));
    dbms_output.put_line('V_SECUENCI = '||to_char(v_secuenci));
/* bucle para calcular los n registros  */
    For i in 0..12 - v_loop Loop
    dbms_output.put_line('DENTRO DEL FOR');
    dbms_output.put_line('V_DIAS ='||to_char(v_dias));
    dbms_output.put_line('VALOR DE I ='||to_char(i));
    v_ciclofact := to_number(v_ciclo||lpad(to_char(v_secuenci),2,0)||v_ano);
    dbms_output.put_line('V_CICLOFACT = '||v_ciclofact||'*');
   -- v_ciclofact2 := to_number(v_ciclofact);
   -- dbms_output.put_line('V_CICLOFACT2 = '||to_char(v_ciclofact2));
    dbms_output.put_line('V_CICLOFACT = '||v_ciclofact);
        v_auxfemision := add_months(to_date(v_fecemi,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXFEMISION = '||to_char(v_auxfemision,'ddmmyyyy
'));
        v_auxfvenci   := add_months(to_date(v_fecvenci,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXFVENCI = '||to_char(v_auxfvenci,'ddmmyyyy'));
        v_auxdllam    := add_months(to_date(v_fecdesde,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXDLLAM = '||to_char(v_auxdllam,'ddmmyyyy'));
        v_auxdcfijo   := add_months(to_date (v_fecdesde,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXDCFIJO = '||to_char(v_auxdcfijo,'ddmmyyyy'));
        v_auxdcargo   := add_months(to_date(v_fecdesde,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXDCARGO = '||to_char(v_auxdcargo,'ddmmyyyy'));
        v_auxdroa     := add_months(to_date(v_fecdesde,'ddmmyyyy'),i);
    dbms_output.put_line('V_AUXDROA = '||to_char(v_auxdroa,'ddmmyyyy'));
        v_auxhllam    := add_months(v_auxfechasta,i);
    dbms_output.put_line('V_AUXHLLAM = '||to_char(v_auxhllam,'ddmmyyyy'));
        v_auxhcfijo   := add_months(to_date (v_fecdesde,'ddmmyyyy'),i+1)-1;
    dbms_output.put_line('V_AUXHCFIJO = '||to_char(v_auxhcfijo,'ddmmyyyy'));
        v_auxhcargo   := add_months(v_auxfechasta,i);
    dbms_output.put_line('V_AUXHCARGO = '||to_char(v_auxhcargo,'ddmmyyyy'));
        v_auxhroa     := add_months(v_auxfechasta,i);
    dbms_output.put_line('V_AUXHROA = '||to_char(v_auxhroa,'ddmmyyyy'));
    dbms_output.put_line('PONIENDO HORAS A LAS FECHAS');
        v_auxdllam    := to_date(to_char(v_auxdllam,'ddmmyyyy')
              ||'000000','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXDLLAM = '||to_char(v_auxdllam,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxhllam    := to_date(to_char(v_auxhllam,'ddmmyyyy')
                  ||'235959','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXHLLAM = '||to_char(v_auxhllam,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxdcfijo   := to_date(to_char(v_auxdcfijo,'ddmmyyyy')
                  ||'000000','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXDCFIJO = '||to_char(v_auxdcfijo,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxhcfijo   := to_date(to_char(v_auxhcfijo,'ddmmyyyy')
                  ||'235959','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXHCFIJO = '||to_char(v_auxhcfijo,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxdcargo   := to_date(to_char(v_auxdcargo,'ddmmyyyy')
                  ||'000000','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXDCARGO = '||to_char(v_auxdcargo,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxhcargo   := to_date(to_char(v_auxhcargo,'ddmmyyyy')
                  ||'235959','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXHCARGO = '||to_char(v_auxhcargo,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxdroa     := to_date(to_char(v_auxdroa,'ddmmyyyy')
                  ||'000000','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXDROA = '||to_char(v_auxdroa,
                                          'ddmmyyyy hh24:mi:ss'));
        v_auxhroa     := to_date(to_char(v_auxhroa,'ddmmyyyy')
                  ||'235959','ddmmyyyyhh24miss');
    dbms_output.put_line('V_AUXHROA = '||to_char(v_auxhroa,
                                          'ddmmyyyy hh24:mi:ss'));
        Insert Into Fa_CiclFact
              (cod_ciclo,ano,cod_ciclfact,fec_vencimie,fec_emision,
               fec_caducida,fec_proxvenc,fec_desdellam,fec_hastallam,
               fec_desdecfijos,fec_hastacfijos,fec_desdeocargos,
               fec_hastaocargos,fec_desderoa,fec_hastaroa,ind_facturacion,
               dir_logs,dir_spool,dia_periodo)
        Values(to_number(v_ciclo),to_number(v_ano),v_ciclofact,
               v_auxfvenci,v_auxfemision,(v_auxfvenci+v_dias),
               add_months(v_auxfvenci,1),v_auxdllam,v_auxhllam,v_auxdcfijo,
               v_auxhcfijo,v_auxdcargo,v_auxhcargo, v_auxdroa,v_auxhroa,0,
               v_dir_logs,v_dir_spool,30);
        v_secuenci    := v_secuenci + 1;
    End Loop;
    Commit;
  exception
    when others then
         raise_application_error(-20546,'<FA_CICLFACT> - '||sqlerrm);
  End fa_proc_ciclo;
/
SHOW ERRORS
