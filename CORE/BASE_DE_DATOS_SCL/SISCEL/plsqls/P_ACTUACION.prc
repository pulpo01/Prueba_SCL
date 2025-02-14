CREATE OR REPLACE PROCEDURE p_actuacion(
  v_actuacion IN icg_actuacion.cod_actuacion%type ,
  v_tipo IN OUT char )
IS
  v_act ga_actabo.cod_actcen%TYPE;
  v_des ga_actabo.cod_actcen%TYPE;
BEGIN
--   select cod_actuacion_act,cod_actuacion_des
--     into v_act,v_des
--     from al_datos_generales;
	 --
	 SELECT cod_actcen
	 INTO   v_act
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
	 AND    cod_producto = 1
	 AND    cod_tecnologia ='CDMA'
	 AND    cod_actabo ='AA';
	 --
	 SELECT cod_actcen
	 INTO   v_des
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
	 AND    cod_producto = 1
     AND    cod_tecnologia ='CDMA'
	 AND    cod_actabo ='MI';
  if v_act = v_actuacion then
     v_tipo := 'A';
  else
     v_tipo := 'D';
  end if;
END p_actuacion;
/
SHOW ERRORS
