CREATE OR REPLACE PROCEDURE P_AL_CIERRE(
  v_numcierre_x IN char ,
  v_cierre_x IN char ,
  v_mes_cierre_x IN char )
IS
  CURSOR operadora IS        -- 30-12-2002 Modificacion multiempresa Ulises Uribe
          select cod_operadora_scl
          from ge_operadora_scl;
  v_cierre        varchar2(1);
  v_mes_cierre    al_cierres_alma.mes_cierre%type;
  v_new_ejer      al_cierres_alma.fec_inicio%type;
  v_intercierre   al_intercierre%rowtype ;
  v_periodo       number;
  v_compacta      boolean:= true;
BEGIN
   for CC in operadora loop
        if v_cierre = 'A' then
                     -- Procesado de los pendientes del a?o
                         al_pac_mercaderia.p_trata_movim_pdte(v_periodo, cc.cod_operadora_scl, v_compacta);      -- 30-12-2002 Modificacion multiempresa Ulises Uribe
                         v_compacta := false;                                                           -- 30-12-2002 Modificacion multiempresa Ulises Uribe
        end if;
            -- Cierre por operadora..
            v_intercierre.num_cierre  := to_number(v_numcierre_x);
            v_intercierre.cod_retorno := 0;
            v_intercierre.des_cadena  := null;
            v_cierre                  := v_cierre_x;
            v_mes_cierre              := to_date(v_mes_cierre_x,'ddmmyyyy');
            al_proc_cierre.p_cierre (v_intercierre,
                                     v_cierre,
                                     v_mes_cierre,
                                     v_new_ejer,
                                                                 cc.cod_operadora_scl);         -- 30-12-2002 Modificacion multiempresa Ulises Uribe
            -- if v_cierre = 'A' then
            --    al_proc_calpdte.p_trata_movim(v_intercierre,
            --                                 v_new_ejer);
            -- end if;
            if v_intercierre.cod_retorno = 0 then
               v_intercierre.des_cadena := '/Proceso Finalizado/';
            end if;
            insert into al_intercierre (num_cierre,
                                        cod_retorno,
                                        des_cadena)
                                values (v_intercierre.num_cierre,
                                        v_intercierre.cod_retorno,
                                        v_intercierre.des_cadena);
   end loop;
EXCEPTION
   when OTHERS then
        raise_application_error (-20167,
                                 'Error Generacion Registro Resultado'
                                 || to_char(SQLCODE));
END P_AL_CIERRE;
/
SHOW ERRORS
