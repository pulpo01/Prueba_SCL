CREATE OR REPLACE PROCEDURE AL_det_error_PR(p_serie al_ser_numeracion.num_serie%type,
                                                      p_articulo al_lin_numeracion.cod_articulo%type,
													  p_bodega al_cab_numeracion.cod_bodega%type,
													  p_stock al_lin_numeracion.tip_stock%type,
													  p_uso al_lin_numeracion.cod_uso%type,
													  p_estado al_lin_numeracion.cod_estado%type,
													  p_hlr icg_central.cod_hlr%type,
													  p_estadoReserva al_series.cod_estado%type,
													  p_estadoTemporal al_series.cod_estado%type,
													  p_estadoTransito al_series.cod_estado%type,
													  p_estadoReservaVta al_series.cod_estado%type,
													  p_error OUT PLS_INTEGER)
IS
v_ind_telefono      al_series.ind_telefono%type;
v_num_telefono      al_series.num_telefono%type;
v_serie_existente   al_ser_numeracion.num_serie%type;
v_hlr        		icg_central.cod_hlr%type;

BEGIN
    p_error:=1;
    BEGIN
	    --Buscar serie
		SELECT a.cod_hlr, a.ind_telefono, a.num_telefono
		INTO v_hlr, v_ind_telefono, v_num_telefono
		FROM al_series a
		WHERE a.num_serie = p_serie
		AND a.cod_articulo = p_articulo
		AND a.cod_bodega = p_bodega
		AND a.tip_stock = p_stock
		AND a.cod_uso = p_uso
		AND a.cod_estado   = p_estado
	    AND a.cod_estado not in (p_estadoReserva , p_estadoTemporal, p_estadoTransito,p_estadoReservaVta);
	EXCEPTION
		WHEN no_data_found THEN
		   p_error:=2; --No existe serie para las condiciones dadas mas arriba
	END;

	IF p_error = 1 THEN
	   --Verificar si tienen distinto HLR
	   IF (v_hlr <> p_hlr AND p_hlr is not null) THEN
	      p_error := 3; --Error, no coincide HLR
       elsif (v_ind_telefono <> 0 OR  v_num_telefono IS NOT NULL) THEN
	      p_error := 4; --Error, serie tiene telefono asignado o ind_telefono  no es cero.
	   else
	       --Verificar si existe serie en orden de numeracion no cerrada
	      BEGIN
	   	   	select d.num_serie
			INTO v_serie_existente
			from al_ser_numeracion d, al_lin_numeracion b, al_cab_numeracion c
			where d.num_numeracion = b.num_numeracion
			and d.lin_numeracion = b.lin_numeracion
			and d.num_serie = p_serie
			and c.num_numeracion = d.num_numeracion
			and c.cod_estado = 'NU';
		  EXCEPTION
		  WHEN no_data_found THEN
		     v_serie_existente:=null;
		  END;

		  IF v_serie_existente IS NOT NULL THEN
		  	 p_error := 5;
		  END IF;

	  END IF;

	END IF;

EXCEPTION
     WHEN OTHERS THEN
       raise_application_error (-20100,to_char(SQLCODE)||' - '||SQLERRM);
END;
/
SHOW ERRORS
