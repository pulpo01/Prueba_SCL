SET serveroutput on
SET term on
SET feedback off
SET verify off

DECLARE 
  EN_TIP_BUSQUEDA     NUMBER;
  EN_COD_CLIENTE      NUMBER;
  EN_COD_CLIENTE_FIN  NUMBER;
  SV_MENS_RETORNO     VARCHAR2(200);
  SN_NUM_EVENTO       NUMBER;
BEGIN
  EN_TIP_BUSQUEDA := &1;
  IF  EN_TIP_BUSQUEDA = 0 THEN
      EN_COD_CLIENTE        := NULL;
      EN_COD_CLIENTE_FIN    := NULL;
      SV_MENS_RETORNO := 'Tipo de busqueda total';
  ELSIF EN_TIP_BUSQUEDA = 1 THEN
      EN_COD_CLIENTE        := &2;
      EN_COD_CLIENTE_FIN    := NULL;
      SV_MENS_RETORNO := 'Tipo de busqueda cliente';
  ELSIF EN_TIP_BUSQUEDA = 2 THEN
      EN_COD_CLIENTE        := &2;
      EN_COD_CLIENTE_FIN    := &3;
      SV_MENS_RETORNO := 'Tipo de busqueda rango';
  END IF;
  dbms_output.put_line('Tipo Ejecución : '||SV_MENS_RETORNO);
  VE_UPD_INFO_CLIENTES_PG.VE_CLASIF_CREDIT_PR ( EN_COD_CLIENTE, EN_COD_CLIENTE_FIN, SV_MENS_RETORNO, SN_NUM_EVENTO );
 dbms_output.put_line('RESULTADO : '||SV_MENS_RETORNO);
 COMMIT;
END; 
/
SET serveroutput off
SET term off

EXIT
