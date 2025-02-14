CREATE OR REPLACE FUNCTION        GA_FN_OBT_CONT_TELEF_MPR (venta in number)
return number is
  retorno number(1);
begin
  select ind_cont_telef into retorno from ga_ventas where num_venta = venta;
  return(retorno);
end;
/
SHOW ERRORS
