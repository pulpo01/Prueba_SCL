CREATE OR REPLACE PROCEDURE        p_getdeudant(
  v_rec_proceso IN Fa_Procesos%ROWTYPE ,
  v_tot_pagar OUT Fa_HistDocu.tot_pagar%TYPE )
IS
  Begin
   /* Select nvl(sum(imp_saldoant),0) + nvl(sum(imp_debicred),0)
    Into v_tot_pagar
    From Fa_EstaCuen
    Where cod_tipdocum = v_rec_proceso.cod_tipdocum
    And cod_agente   = v_rec_proceso.cod_agente
    And letra        = v_rec_proceso.letraag
    And cod_centremi = v_rec_proceso.cod_centremi
    And num_secuenci = v_rec_proceso.num_secuag;*/
    null;
  exception
    when too_many_rows then
         raise_application_error (-20558, 'Demasiadas filas FA_ESTACUEN');
    when no_data_found then
         raise_application_error (-20540, 'No hay dato en FA_ESTACUEN');
    when others then
         raise_application_error (-20522,SQLERRM);
  End p_getdeudant;
/
SHOW ERRORS
