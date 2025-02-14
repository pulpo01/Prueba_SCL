CREATE OR REPLACE PACKAGE BODY        GA_CAMBIA_FIJO_STB
 as
Procedure mi_principal(direccion in varchar2) is
  Cursor c1 is
   Select num_telefija  a_num_telefija,
          new_telefija  a_new_telefija,
          num_celular   a_num_celular
   From ga_camb_telefija;
encontro number(1):=1;
error number(1):=0;
v_abonado ga_abocel.num_abonado%type;
v_cliente ga_abocel.cod_cliente%type;
v_opredfija ga_abocel.cod_opredfija%type;
v_ciclo ga_abocel.cod_ciclo%type;
puntero utl_file.file_type;
puntero2 utl_file.file_type;
arch_inex varchar2(40):='REDFIJA_RECHAZADO_';
arch_situac varchar2(40):='REDFIJA_SITUAC_';
fecha_actual varchar2(6);
BEGIN
    Select to_char(sysdate,'ddmmyy')
    Into fecha_actual
    From dual;
    arch_inex:=arch_inex||fecha_actual||'.dat';
    arch_situac:=arch_situac||fecha_actual||'.dat';
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
       busca_abocel(R.a_num_celular,R.a_num_telefija,R.a_new_telefija,direccion,
v_cliente,
                    v_abonado,v_ciclo,v_opredfija,encontro);
       if encontro=1 Then
         inserta_modabocel(v_abonado,R.a_num_telefija,v_opredfija,error);
         update_abocel(v_abonado,R.a_new_telefija,error);
         update_infaccel(v_cliente,v_abonado,R.a_new_telefija,v_ciclo,error);
         if error=0 then
               commit;
         else
            rollback;
         end if;
        end if;
    End Loop;
END;
Procedure busca_abocel(v_num_celular in ga_abocel.num_celular%type,
                       v_num_telefija in ga_abocel.num_telefija%type,
                       v_new_telefija in ga_abocel.num_telefija%type,
                       v_direccion in varchar2,
                       v_cliente out ga_abocel.cod_cliente%type,
                       v_abonado out ga_abocel.num_abonado%type,
                       v_ciclo out ga_abocel.cod_ciclo%type,
                       v_opredfija out ga_abocel.cod_opredfija%type,
                       v_encontro in out number) is
modo varchar2(1):='w';
puntero utl_file.file_type;
puntero2 utl_file.file_type;
arch_inex varchar2(40):='REDFIJA_RECHAZADO_';
arch_situac varchar2(40):='REDFIJA_SITUAC_';
formato varchar2(6):='ddmmyy';
fecha_actual varchar2(6);
v_cod_situacion ga_abocel.cod_situacion%type;
BEGIN
  Select to_char(sysdate,'ddmmyy')
  Into fecha_actual
  From dual;
  arch_inex:=arch_inex||fecha_actual||'.dat';
  arch_situac:=arch_situac||fecha_actual||'.dat';
  Select num_abonado,cod_cliente,cod_situacion,cod_ciclo,cod_opredfija
  Into v_abonado,v_cliente,v_cod_situacion,v_ciclo,v_opredfija
  From ga_abocel
  Where num_celular=v_num_celular
  and num_telefija=v_num_telefija
  and ind_supertel=1;
  IF v_cod_situacion !='AAA' Then
    puntero2:=utl_file.fopen(v_direccion,arch_situac,'a');
    if utl_file.is_open(puntero2) Then
       Utl_file.put_line(puntero2,v_num_telefija);
    end if;
    Utl_file.fclose(puntero2);
    v_encontro:=0;
  ELSE
    v_encontro:=1;
  END IF;
Exception
  When no_data_Found Then
    puntero:=utl_file.fopen(v_direccion,arch_inex,'a');
    if utl_file.is_open(puntero) Then
       Utl_file.put_line(puntero,v_num_telefija);
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
Procedure inserta_modabocel(v_abonado in ga_abocel.num_abonado%type,
                            v_num_telefija in ga_abocel.num_telefija%type,
                            v_cod_opredfija in ga_abocel.cod_opredfija%type,
                            v_error in out number) is
Begin
    INSERT INTO GA_MODABOCEL(NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,
    NOM_USUARORA,NUM_TELEFIJA,COD_OPREDFIJA)
    VALUES(v_abonado,'MG',sysdate,'AWILSON',v_num_telefija,v_cod_opredfija);
     v_error:=0;
Exception
   When others then
     v_error:=1;
End;
Procedure update_abocel(v_abonado in ga_abocel.num_abonado%type,
                        v_new_telefija in ga_abocel.num_telefija%type,
                        v_error in out number) is
Begin
    Update ga_abocel
       set num_telefija=v_new_telefija
    Where num_abonado=v_abonado;
    v_error:=0;
Exception
   When others Then
      v_error:=1;
End;
Procedure update_infaccel(v_cliente in ga_abocel.cod_cliente%type,
                          v_abonado in ga_abocel.num_abonado%type,
                          v_new_telefija in ga_abocel.num_telefija%type,
                          v_ciclo in ga_abocel.cod_ciclo%type,
                          v_error in out number) is
v_ciclfact ga_infaccel.cod_ciclfact%type;
Begin
    Select cod_ciclfact
    Into v_ciclfact
    From fa_ciclfact
    Where cod_ciclo=v_ciclo
    and ind_facturacion=0
    and sysdate between fec_desdellam and fec_hastallam;
    Update GA_INFACCEL
         set num_telefija=v_new_telefija
    Where cod_cliente=v_cliente
    and num_abonado =v_abonado
    and cod_ciclfact=v_ciclfact;
    v_error:=0;
Exception
   When no_data_found Then
      v_error:=1;
   When others then
      v_error:=1;
End;
End GA_CAMBIA_FIJO_STB;
/
SHOW ERRORS
