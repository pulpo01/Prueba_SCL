CREATE OR REPLACE PROCEDURE        p_updatesec(
  v_cod_tipdocum IN Fa_Procesos.cod_tipdocum%TYPE ,
  v_cod_centremi IN Fa_Procesos.cod_centremi%TYPE ,
  v_letra IN Fa_HistDocu.letra%TYPE ,
  v_secuencia IN Fa_HistDocu.num_secuenci%TYPE )
IS
  Begin
    if v_secuencia = 99999999 then
       Update Ge_SecuenciasEmi set num_secuenci = 0
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    else
       Update Ge_SecuenciasEmi set num_secuenci = v_secuencia
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    end if;
  exception
    when no_data_found then
         raise_application_error (-20533, 'No hay dato en GE_SECUENCIASEMI');
    when others then
         raise_application_error (-20515,SQLERRM);
  End p_updatesec;
/
SHOW ERRORS
