CREATE OR REPLACE PROCEDURE        p_getsecuenci(
  v_cod_tipdocum IN Fa_Procesos.cod_tipdocum%TYPE ,
  v_cod_centremi IN Fa_Procesos.cod_centremi%TYPE ,
  v_letra IN Fa_HistDocu.Letra%TYPE ,
  v_secuenci IN OUT Fa_HistDocu.num_secuenci%TYPE )
IS
  Begin
    Select num_secuenci + 1 into v_secuenci
    From Ge_Secuenciasemi
    Where cod_tipdocum = v_cod_tipdocum
    And cod_centremi = v_cod_centremi
    And letra = v_letra
    For Update Of Num_Secuenci;
    if v_secuenci = 99999999 then
       Update Ge_SecuenciasEmi set num_secuenci = 0
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    else
       Update Ge_SecuenciasEmi set num_secuenci = v_secuenci
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    end if;
  exception
    when no_data_found then
         raise_application_error (-20532, 'No hay dato en GE_SECUENCIASEMI');
    when too_many_rows then
         raise_application_error (-20551, 'Demasiadas filas GE_SECUENCIASEMI
');
    when others then
         raise_application_error (-20514,SQLERRM);
  End  p_getsecuenci;
/
SHOW ERRORS
