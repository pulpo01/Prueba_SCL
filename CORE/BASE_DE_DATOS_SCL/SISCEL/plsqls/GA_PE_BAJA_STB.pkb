CREATE OR REPLACE PACKAGE BODY        GA_PE_BAJA_STB as
Procedure mi_principal(direccion in varchar2) is
  Cursor c1 is
   Select num_celular   a_num_celular
   From GA_TP_BAJA_TELEFIJA;
v_origen varchar2(5);
v_destino varchar2(5);
v_var3 varchar2(5);
v_proc varchar2(50);
v_tabla varchar2(50);
v_act varchar2(30);
v_sqlcode varchar2(30);
v_sqlerrm varchar2(100);
v_error varchar2(5);
v_sysdate date;
encontro number(1):=1;
error number(1):=0;
v_abonado ga_abocel.num_abonado%type;
v_cliente ga_abocel.cod_cliente%type;
v_opredfija ga_abocel.cod_opredfija%type;
v_ciclo ga_abocel.cod_ciclo%type;
v_telefija ga_abocel.num_telefija%type;
v_uso ga_abocel.cod_uso%type;
v_seriehex ga_abocel.num_seriehex%type;
v_tip_terminal ga_abocel.tip_terminal%type;
v_central ga_abocel.cod_central%type;
v_plantarif ga_abocel.cod_plantarif%type;
v_fec_alta  ga_abocel.fec_alta%type;
puntero utl_file.file_type;
puntero2 utl_file.file_type;
puntero3 utl_file.file_type;
arch_inex varchar2(40):='BAJA_STM_RECH';
arch_situac varchar2(40):='BAJA_STM_SITUAC';
arch_falla varchar2(40):='BAJA_STM_FALLA';
fecha_actual varchar2(6);
BEGIN
    fecha_actual:=to_char(sysdate,'ddmmyy');
    arch_inex:=arch_inex||fecha_actual||'.dat';
    arch_situac:=arch_situac||fecha_actual||'.dat';
    arch_falla:=arch_falla||fecha_actual||'.dat';
    puntero:=utl_file.fopen(direccion,arch_situac,'w');
    puntero2:=utl_file.fopen(direccion,arch_inex,'w');
    if utl_file.is_open(puntero) Then
       Utl_file.put_line(puntero,'INICIANDO.....');
    end if;
    Utl_file.fclose(puntero);
    if utl_file.is_open(puntero2) Then
       Utl_file.put_line(puntero2,'INICIANDO.....');
    end if;
    Utl_file.fclose(puntero2);
    For R in c1 Loop
       error:=0;
       busca_abocel(R.a_num_celular,direccion,v_cliente,
                    v_abonado,v_ciclo,v_seriehex,v_tip_terminal,v_central,
                    v_uso,v_plantarif,v_telefija,v_fec_alta,encontro);
       if encontro=1 Then
         updatea_histor_desc(v_abonado,v_ciclo,error);
         updatea_abocel(v_abonado,error);
         updatea_clientes(v_cliente,error);
         elimina_finciclo(v_abonado,error);
         elimina_cargos(v_cliente,v_abonado,error);
         inserta_movimiento(v_abonado,R.a_num_celular,v_central,v_seriehex,
                           v_tip_terminal,error);
         If (v_uso = 10) or (v_uso=15) Then
          inserta_movcontrol(v_abonado,R.a_num_celular,v_plantarif,v_fec_alta,
          error);
         end if;
         inserta_movstm(v_telefija,R.a_num_celular,error);
         if error=0 then
            v_origen:=' ';
            v_destino:=' ';
            v_var3:=' ';
            v_proc:=' ';
            v_tabla:=' ';
            v_act:=' ';
            v_sqlcode:=' ';
            v_sqlerrm:=' ';
            v_error:='0';
            v_sysdate:=sysdate;
            p_interfases_celular(1,'BA',v_abonado,v_origen,v_destino,v_var3,
            v_sysdate,v_proc,v_tabla,v_act,v_sqlcode,v_sqlerrm,v_error);
            inserta_orserv(v_abonado,v_error);
            if v_error='0' then
             commit;
            else
             rollback;
             puntero3:=utl_file.fopen(direccion,arch_inex,'w');
             if utl_file.is_open(puntero3) Then
                Utl_file.put_line(puntero3,'ERRORES...');
                Utl_file.put_line(puntero3,'PROC: '||v_proc);
                Utl_file.put_line(puntero3,'TABLA: '||v_tabla);
                Utl_file.put_line(puntero3,'ACT: '||v_act);
                Utl_file.put_line(puntero3,'SQLCODE: '||v_sqlcode);
                Utl_file.put_line(puntero3,'SQLERRM: '||v_sqlerrm);
             end if;
             Utl_file.fclose(puntero3);
           end if;
         end if;
        end if;
    End Loop;
END;
Procedure busca_abocel(v_celular in ga_abocel.num_celular%type,
                        v_direccion in varchar2,
                       v_cliente out ga_abocel.cod_cliente%type,
                       v_abonado out ga_abocel.num_abonado%type,
                       v_ciclo out ga_abocel.cod_ciclo%type,
                       v_seriehex out ga_abocel.num_seriehex%type,
                       v_tip_terminal out ga_abocel.tip_terminal%type,
                       v_central out ga_abocel.cod_central%type,
                       v_uso out ga_abocel.cod_uso%type,
                       v_plantarif out ga_abocel.cod_plantarif%type,
                       v_telefija out ga_abocel.num_telefija%type,
                       v_fec_alta out ga_abocel.fec_alta%type,
                       v_encontro in out number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero2 utl_file.file_type;
arch_inex varchar2(40):='BAJA_STM_RECH';
arch_situac varchar2(40):='BAJA_STM_SITUAC';
formato varchar2(6):='ddmmyy';
fecha_actual varchar2(6);
v_cod_situacion ga_abocel.cod_situacion%type;
v_ind_supertel ga_abocel.ind_supertel%type;
v_cod_ciclo ga_abocel.cod_ciclo%type;
v_cod_opredfija ga_abocel.cod_opredfija%type;
v_ind_disp ga_abocel.ind_disp%type;
BEGIN
  v_ind_supertel:=1;
  v_cod_situacion:='AAA';
  v_cod_ciclo:=10;
  v_cod_opredfija:=9901;
  v_ind_disp:=0;
  fecha_actual:=to_char(sysdate,'ddmmyy');
  arch_inex:=arch_inex||fecha_actual||'.dat';
  arch_situac:=arch_situac||fecha_actual||'.dat';
  Select num_abonado,cod_cliente,cod_situacion,cod_ciclo,cod_central,
         cod_plantarif,num_seriehex,cod_uso,tip_terminal,fec_alta,num_telefija
  Into v_abonado,v_cliente,v_cod_situacion,v_ciclo,v_central,v_plantarif,
       v_seriehex,v_uso,v_tip_terminal,v_fec_alta,v_telefija
  From ga_abocel
  Where num_celular=v_celular
  and ind_supertel=v_ind_supertel
  and cod_situacion=v_cod_situacion
  and cod_ciclo=v_cod_ciclo
  and (ind_disp != v_ind_disp or ind_disp is null);
  v_encontro:=1;
Exception
  When no_data_Found Then
    puntero:=utl_file.fopen(v_direccion,arch_inex,'a');
    if utl_file.is_open(puntero) Then
       Utl_file.put_line(puntero,v_celular);
    end if;
    Utl_file.fclose(puntero);
    v_encontro:=0;
  When utl_file.invalid_path then
    Utl_file.put_line(puntero,'PATH');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_encontro:=0;
  When utl_file.invalid_mode then
    Utl_file.put_line(puntero,'MODE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_encontro:=0;
  When utl_file.invalid_operation then
    Utl_file.put_line(puntero,'OPERACION ');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_encontro:=0;
  When utl_file.internal_error then
    Utl_file.put_line(puntero,'INTERNAL ERROR');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_encontro:=0;
  When utl_file.invalid_filehandle then
    Utl_file.put_line(puntero,'FILE HANDLE');
    Utl_file.put_line(puntero,'SQLCODE: '||to_char(sqlcode));
    Utl_file.put_line(puntero,'SQLERRM: '||sqlerrm);
    v_encontro:=0;
END;
Procedure updatea_histor_desc(v_abonado in ga_abocel.num_abonado%type,
                             v_ciclo in ga_abocel.cod_ciclo%type,
                             v_error in out number) is
v_ciclfact fa_ciclfact.cod_ciclfact%type;
Begin
    Select cod_ciclfact
    Into v_ciclfact
    From fa_ciclfact
    where cod_ciclo=v_ciclo
    and ind_facturacion=0
    and sysdate between fec_desdellam and fec_hastallam;
    INSERT INTO GA_HDTOSTARIF (NUM_ABONADO, COD_CICLFACT, NUM_MINUTOS,
               TIP_PLANTARIF, COD_VENDEDOR, NOM_USUARORA,FEC_GRABACION,FEC_BAJA)
    Select num_abonado,cod_ciclfact,num_minutos,tip_plantarif,cod_vendedor,
           nom_usuarora,fec_grabacion,sysdate
    From GA_DTOSTARIF
    Where num_abonado=v_abonado
    and cod_ciclfact!=v_ciclfact;
    DELETE GA_DTOSTARIF
    WHERE NUM_ABONADO = v_abonado
    AND COD_CICLFACT != cod_ciclfact;
    v_error:=0;
Exception
   when no_data_found then
       null;
       v_error:=0;
   when others then
       v_error:=1;
End;
Procedure updatea_abocel(v_abonado in ga_abocel.num_abonado%type,
                         v_error in out number) is
v_situacion ga_abocel.cod_situacion%type;
v_causabaja number(2):=27;
Begin
    v_situacion:='BAP';
    Update ga_abocel
      set cod_situacion=v_situacion,
          fec_baja=sysdate,
          fec_ultmod=sysdate,
          cod_causabaja=v_causabaja
    Where num_abonado=v_abonado;
    v_error:=0;
Exception
   When others then
      v_error:=1;
End;
Procedure updatea_clientes(v_cliente in ga_abocel.cod_cliente%type,
                          v_error in out number) is
Begin
   Update Ge_clientes
       set num_abocel=num_abocel -1
   where cod_cliente=v_cliente;
   v_error:=0;
Exception
   When others then
     v_error:=1;
End;
Procedure elimina_finciclo(v_abonado in ga_abocel.num_abonado%type,
                           v_error in out number) is
Begin
   delete ga_finciclo
   where num_abonado=v_abonado;
   v_error:=0;
Exception
   When others Then
     v_error:=1;
End;
Procedure elimina_cargos(v_cliente in ga_abocel.cod_cliente%type,
                         v_abonado in ga_abocel.num_abonado%type,
                         v_error in out number) is
Begin
    Delete ge_cargos
    Where cod_cliente =v_cliente
    and num_abonado =v_abonado;
    v_error:=0;
Exception
    When others then
      v_error:=1;
End;
Procedure inserta_movimiento(v_abonado in ga_abocel.num_abonado%type,
                            v_celular in ga_abocel.num_celular%type,
                            v_cod_central in ga_abocel.cod_central%type,
                            v_seriehex in ga_abocel.num_seriehex%type,
                            v_tip_terminal in ga_abocel.tip_terminal%type,
                            v_error in out number) is
Begin
    Insert into icc_movimiento(NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_ACTABO,
    COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,NOM_USUARORA,
    FEC_INGRESO,TIP_TERMINAL,COD_CENTRAL,IND_BLOQUEO,NUM_CELULAR,NUM_SERIE)
    Values(ICC_SEQ_NUMMOV.nextval,v_abonado,1,'BA','GA',0,'BAJA STM CTC.',9,
    'CESADO_CTC',sysdate,v_tip_terminal,v_cod_central,0,v_celular,v_seriehex);
     v_error:=0;
Exception
    When others then
         v_error:=1;
End;
Procedure inserta_movcontrol(v_abonado in ga_abocel.num_abonado%type,
                            v_celular in ga_abocel.num_celular%type,
                            v_plantarif in ga_abocel.cod_plantarif%type,
                            v_fec_alta in ga_abocel.fec_alta%type,
                            v_error in out number) is
Begin
  Insert into ga_movccontrol(num_linea,fec_inicio,cod_plantarif,ind_tipmov,
                            ind_procesado)
  Values(v_celular,v_fec_alta,v_plantarif,1,0);
  v_error:=0;
Exception
  When others then
    v_error:=1;
End;
Procedure inserta_movstm(v_telefija in ga_abocel.num_telefija%type,
                        v_celular in ga_abocel.num_celular%type,
                        v_error in out number) is
Begin
   Insert into ga_ctc_movimientos(num_redfija,fec_movimiento,tip_movimiento,
   num_celular1,num_celular2)
   Values(v_telefija,sysdate,2,v_celular,0);
   v_error:=0;
Exception
  When others then
    v_error:=1;
End;
Procedure inserta_orserv(v_abonado in ga_abocel.num_abonado%type,
                        v_error in out number) is
sequencia number(8);
Begin
   Insert into ci_orserv (num_os,cod_os,producto,tip_inter,cod_inter,usuario,fecha,comentario)
   values(ci_seq_numos.nextval,'10223',1,1,v_abonado,'CESADO_CTC',sysdate,
   'Baja Masiva de Abonados Super Telefono [Cesado por CTC S.A]');
   v_error:=0;
Exception
  When others then
    v_error:=1;
End;
End GA_PE_BAJA_STB;
/
SHOW ERRORS
