CREATE OR REPLACE PACKAGE        GA_PE_BAJA_STB
 as
Procedure mi_principal(direccion in varchar2);
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
                       v_encontro in out number);
Procedure updatea_histor_desc(v_abonado in ga_abocel.num_abonado%type,
                             v_ciclo in ga_abocel.cod_ciclo%type,
                             v_error in out number);
Procedure updatea_clientes(v_cliente in ga_abocel.cod_cliente%type,
                          v_error in out number);
Procedure updatea_abocel(v_abonado in ga_abocel.num_abonado%type,
                         v_error in out number);
Procedure elimina_finciclo(v_abonado in ga_abocel.num_abonado%type,
                           v_error in out number);
Procedure elimina_cargos(v_cliente in ga_abocel.cod_cliente%type,
                         v_abonado in ga_abocel.num_abonado%type,
                         v_error in out number);
Procedure inserta_movimiento(v_abonado in ga_abocel.num_abonado%type,
                            v_celular in ga_abocel.num_celular%type,
                            v_cod_central in ga_abocel.cod_central%type,
                            v_seriehex in ga_abocel.num_seriehex%type,
                            v_tip_terminal in ga_abocel.tip_terminal%type,
                            v_error in out number);
Procedure inserta_movcontrol(v_abonado in ga_abocel.num_abonado%type,
                            v_celular in ga_abocel.num_celular%type,
                            v_plantarif in ga_abocel.cod_plantarif%type,
                            v_fec_alta in ga_abocel.fec_alta%type,
                            v_error in out number);
Procedure inserta_movstm(v_telefija in ga_abocel.num_telefija%type,
                        v_celular in ga_abocel.num_celular%type,
                        v_error in out number);
Procedure inserta_orserv(v_abonado in ga_abocel.num_abonado%type,
                        v_error in out number);
End;
/
SHOW ERRORS
