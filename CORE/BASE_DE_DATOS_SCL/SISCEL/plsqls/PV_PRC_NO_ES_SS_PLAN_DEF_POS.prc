CREATE OR REPLACE PROCEDURE pv_prc_no_es_ss_plan_def_pos(
                            v_param_entrada in  varchar2,
                                                        p_bresultado out varchar2,
                                                p_vmensaje   out ga_transacabo.des_cadena%type
                            )
is
  /* Retorna si el servicio no pertenece al plan tarifario del
     abonado como servicio de voz por defecto.
  */
  string GE_TABTYPE_VCH2ARRAY := GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

  v_cod_servicio ga_servsupl.cod_servicio%type;
  p_vcod_servicio ga_servsupl.cod_servicio%type;
  p_nnum_abonado ga_abocel.num_abonado%type;
begin
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
         p_vcod_servicio := string(11);
         p_nnum_abonado := string(5);

         select a.cod_servicio
           into v_cod_servicio
           from gad_servsup_plan a, ga_abocel b
          where a.cod_plantarif = b.cod_plantarif
            and b.num_abonado = p_nnum_abonado
                and b.cod_situacion = 'AAA'
            and a.cod_servicio = p_vcod_servicio
            and a.tip_relacion = 3;

                p_bresultado := 'FALSE';
                p_vmensaje := 'EL SERVICIO '||p_vcod_servicio||' ES SERVICIO POR DEFECTO';
exception
                 when no_data_found then
                           p_bresultado := 'TRUE';
                           p_vmensaje := 'EL SERVICIO '||p_vcod_servicio||' NO ES SERVICIO POR DEFECTO';
end;
/
SHOW ERRORS
