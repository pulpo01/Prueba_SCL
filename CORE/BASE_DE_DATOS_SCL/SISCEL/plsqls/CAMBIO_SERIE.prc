CREATE OR REPLACE PROCEDURE        CAMBIO_SERIE
(p_FECHA_DESDE in varchar2, p_FECHA_HASTA in VARCHAR2, SALIDA in varchar2 , ARCHIVO in varchar2) IS
v_fecha ga_modabocel.fec_modifica%type;
v_nom_usuarora ga_modabocel.nom_usuarora%type;
v_num_abonado ga_modabocel.num_abonado%type;
v_num_serie ga_modabocel.num_serie%type;
v_cod_cliente ga_abocel.cod_cliente%type;
v_num_celular ga_abocel.num_celular%type;
v_num_percontrato ga_abocel.num_percontrato%type;
v_fec_fincontra ga_abocel.fec_fincontra%type;
v_ind_procequi ga_abocel.ind_procequi%type;
v_fec_alta ga_abocel.fec_alta%type;
v_num_ident ge_clientes.num_ident%type;
v_nom_cliente ge_clientes.nom_cliente%type;
v_nom_apeclien1 ge_clientes.nom_apeclien1%type;
v_nom_apeclien2 ge_clientes.nom_apeclien2%type;
v_imp_cargo ge_cargos.imp_cargo%type;
desde date;
hasta date;
pp    varchar2(50);
arv   varchar2(50);
puntero utl_file.file_type;
CURSOR ccp(v_desde date, v_hasta date) IS
select fec_modifica, nom_usuarora, num_abonado
from ga_modabocel
where fec_modifica >= v_desde AND
fec_modifica < v_hasta and
cod_tipmodi='CE';
BEGIN
pp:=SALIDA;
arv:=ARCHIVO;
desde:=to_date(p_fecha_desde, 'dd-mon-yyyy hh24:mi');
hasta:=to_date(p_fecha_hasta, 'dd-mon-yyyy hh24:mi');
puntero:=utl_file.fopen(pp,arv,'w');
Utl_file.put_line(puntero,'Fecha Modificacion'||','||'Celular'||','||'Valor'||','||'Usuario'||','||'Proc. Equipo'||','||'Fecha Alta'||','||'Periodo Contrato'||','||'Fecha fin Contrato');
        OPEN ccp(desde, hasta);
        LOOP
                BEGIN
                        v_fecha:=null;
                        v_nom_usuarora:=null;
                        v_num_abonado:=null;
                        v_cod_cliente:=null;
                FETCH ccp into v_fecha, v_nom_usuarora, v_num_abonado;
                exit when ccp%notfound;
                BEGIN
select num_celular, cod_cliente, ind_procequi, num_percontrato, fec_fincontra, fec_alta, num_serie into v_num_celular, v_cod_cliente, v_ind_procequi, v_num_percontrato, v_fec_fincontra, v_fec_alta, v_num_serie
                from ga_abocel
                where num_abonado=v_num_abonado;
                EXCEPTION
                      when no_data_found then
                      null;
                END;
                                v_imp_cargo:=null;
                                BEGIN
                                 select imp_cargo into v_imp_cargo
                                 from ge_cargos
                                 where cod_cliente=v_cod_cliente and
                                 num_abonado=v_num_abonado and
                                 num_serie=v_num_serie and
                                 to_char(fec_alta, 'dd-mm-yy')=to_char(v_fecha, 'dd-mm-yy');
Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||v_num_celular||','||v_imp_cargo||','||v_nom_usuarora||','||v_ind_procequi||','||v_fec_alta||','||v_num_percontrato||','||v_fec_fincontra);
                                EXCEPTION
                                when no_data_found then
                                    BEGIN
                                        select imp_cargo into v_imp_cargo
                                        from fa_histcargos
                                        where cod_cliente=v_cod_cliente and
                                        num_abonado=v_num_abonado and
                        num_serie=v_num_serie and
                                        to_char(fec_alta, 'dd-mm-yy')=to_char(v_fecha, 'dd-mm-yy');
Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||v_num_celular||','||v_imp_cargo||','||v_nom_usuarora||','||v_ind_procequi||','||v_fec_alta||','||v_num_percontrato||','||v_fec_fincontra);
                                    EXCEPTION
                                    when no_data_found then
Utl_file.put_line(puntero,to_char(v_fecha, 'dd-mm-yyyy hh24:mi')||','||v_num_celular||','||v_imp_cargo||','||v_nom_usuarora||','||v_ind_procequi||','||v_fec_alta||','||v_num_percontrato||','||v_fec_fincontra);
                                    END;
                               END;
                END;
        END LOOP;
        CLOSE ccp;
        Utl_file.fclose(puntero);
END;
/
SHOW ERRORS
