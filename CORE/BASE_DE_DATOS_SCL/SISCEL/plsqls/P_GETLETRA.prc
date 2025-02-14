CREATE OR REPLACE PROCEDURE        p_getletra(
  v_cod_cliente IN Fa_PreFactura.cod_cliente%TYPE ,
  v_fecha IN Fa_PreFactura.fec_valor%TYPE ,
  v_cod_tipdocum IN Fa_Procesos.cod_tipdocum%TYPE ,
  v_letra OUT Fa_HistDocu.Letra%TYPE )
IS
  Begin
    Select a.letra Into v_letra
    From Ge_Letras a,Ge_CatImpClientes b
    Where b.cod_cliente = v_cod_cliente
    And b.fec_desde <= v_fecha
    And b.fec_hasta >= v_fecha
    And a.cod_catimpos = b.cod_catimpos
    And a.cod_tipdocum = v_cod_tipdocum;
  exception
    when no_data_found then
         raise_application_error (-20531, 'No hay dato en GE_LETRAS');
    when too_many_rows then
         raise_application_error (-20550, 'Demasiadas filas GE_LETRAS');
    when others then
         raise_application_error (-20513,SQLERRM);
  End p_getletra;
/
SHOW ERRORS
