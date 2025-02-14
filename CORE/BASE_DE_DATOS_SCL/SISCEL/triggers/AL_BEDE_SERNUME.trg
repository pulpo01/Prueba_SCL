CREATE OR REPLACE TRIGGER SISCEL.AL_BEDE_SERNUME
BEFORE DELETE
ON SISCEL.AL_SER_NUMERACION
FOR EACH ROW

DECLARE
   v_num_numeracion   al_ser_numeracion.num_numeracion%type;
   v_lin_numeracion   al_ser_numeracion.lin_numeracion%type;
   v_cod_uso          al_lin_numeracion.cod_uso%type;
   v_cod_estado       al_cab_numeracion.cod_estado%type;
   v_reutil           al_celnum_reutil%rowtype;
   v_telefono         al_ser_numeracion.num_telefono%type;
   v_tip_numeracion   al_cab_numeracion.tip_numeracion%type;
BEGIN
--
   v_num_numeracion := :old.num_numeracion;
   v_lin_numeracion := :old.lin_numeracion;
   v_telefono       := :old.num_telefono;
   select cod_estado,tip_numeracion into v_cod_estado,v_tip_numeracion
	from al_cab_numeracion where num_numeracion = v_num_numeracion;
   if v_telefono is not null and v_cod_estado='NU' and v_tip_numeracion>0 then
   	select cod_uso into v_cod_uso
   		from al_lin_numeracion where num_numeracion = v_num_numeracion
		and lin_numeracion = v_lin_numeracion;
	dbms_output.put_line('Liberando numero:'||:old.num_telefono);
        v_reutil.num_celular    := :old.num_telefono;
	v_reutil.cod_subalm     := :old.cod_subalm;
        v_reutil.cod_producto   := :old.cod_producto;
        v_reutil.cod_central    := :old.cod_central;
        v_reutil.cod_cat        := :old.cod_cat;
        v_reutil.cod_uso        := v_cod_uso;
        al_pac_numeracion.p_libera_numero_al(v_reutil);
   end if;
END;
/
SHOW ERRORS
