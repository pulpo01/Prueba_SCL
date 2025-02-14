CREATE OR REPLACE TRIGGER "EBZ_SISCEL".NP_SERIEPEDIDOS_BEDE_TG
BEFORE DELETE
ON npt_serie_pedido
FOR EACH ROW
DECLARE
 v_cod_est_flujo  NUMBER(2);

BEGIN

  select nvl(cod_estado_flujo,0) into v_cod_est_flujo
  from npt_estado_pedido
  where cod_pedido = :old.cod_pedido
  and   nvl(cod_estado_flujo,cod_estado_flujo) in (49,14,15,83,23);

  exception
      when NO_DATA_FOUND then
	 raise_application_error(-20120,'Registro no puede ser borrado en NPT_SERIE_PEDIDO');
      when TOO_MANY_ROWS then
	  null;
End;
/
SHOW ERRORS
