CREATE OR REPLACE PROCEDURE        P_AL_GENINFOR(
  v_numreport_x IN char ,
  v_bodega_x IN char ,
  v_mes_report_x IN char ,
  v_moneda_x IN char )
IS
   v_interrep    al_interrep%rowtype;
   v_bodega      al_rep_consignacion.cod_bodega%type;
   v_mes_report  date;
   v_moneda      ge_monedas.cod_moneda%type;
BEGIN
   v_interrep.num_informe  := to_number(v_numreport_x);
   v_interrep.cod_retorno  := 0;
   v_interrep.des_cadena   := '';
   v_moneda                := v_moneda_x;
   v_bodega                := to_number(v_bodega_x);
   v_mes_report            := to_date(v_mes_report_x,'ddmmyyyy');
   al_pac_report.p_genera_report(v_interrep,
                                 v_bodega,
                                 v_mes_report,
                                 v_moneda);
   if v_interrep.cod_retorno = 0 then
      v_interrep.des_cadena  := '/Informe Generado/';
   end if;
   insert into al_interrep (num_informe,
                            cod_retorno,
                            des_cadena)
                    values (v_interrep.num_informe,
                            v_interrep.cod_retorno,
                            v_interrep.des_cadena);
EXCEPTION
   when OTHERS then
        raise_application_error (-20177,
                                 'Error Generacion Registro Resultado'
                                 || to_char(SQLCODE));
END P_AL_GENINFOR;
/
SHOW ERRORS
