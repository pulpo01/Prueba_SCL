CREATE OR REPLACE PACKAGE        GA_CAMBIA_FIJO_STB
 as
Procedure mi_principal(direccion in varchar2);
Procedure busca_abocel(v_num_celular in ga_abocel.num_celular%type,
                       v_num_telefija in ga_abocel.num_telefija%type,
                       v_new_telefija in ga_abocel.num_telefija%type,
                       v_direccion in varchar2,
                       v_cliente out ga_abocel.cod_cliente%type,
                       v_abonado out ga_abocel.num_abonado%type,
                       v_ciclo out ga_abocel.cod_ciclo%type,
                       v_opredfija out ga_abocel.cod_opredfija%type,
                       v_encontro in out number);
Procedure inserta_modabocel(v_abonado in ga_abocel.num_abonado%type,
                            v_num_telefija in ga_abocel.num_telefija%type,
                            v_cod_opredfija in ga_abocel.cod_opredfija%type,
                            v_error in out number);
Procedure update_abocel(v_abonado in ga_abocel.num_abonado%type,
                        v_new_telefija in ga_abocel.num_telefija%type,
                        v_error in out number);
Procedure update_infaccel(v_cliente in ga_abocel.cod_cliente%type,
                          v_abonado in ga_abocel.num_abonado%type,
                          v_new_telefija in ga_abocel.num_telefija%type,
                          v_ciclo in ga_abocel.cod_ciclo%type,
                          v_error in out number);
End;
/
SHOW ERRORS
