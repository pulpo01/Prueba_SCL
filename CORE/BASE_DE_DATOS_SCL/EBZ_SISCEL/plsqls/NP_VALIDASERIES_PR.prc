CREATE OR REPLACE PROCEDURE NP_VALIDASERIES_PR(pCodPedido npt_pedido.COD_PEDIDO%type)
IS

-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : NP_VALIDASERIES_PR
-- * Descripcion        : Procedimiento encargado de validar las series ingresadas
-- * Fecha de creacion  : 17-10-2003
-- * Responsable        : Freddy Zavala G.
-- *************************************************************


 v_serie  		  			npt_serie_pedido.cod_serie_pedido%type;
 v_existe_serie_en_bodega   number(1);
 v_coinciden_bodegas        number(1);
 v_coincide_articulo		number(1);
 v_uso_valido				number(1);
 v_tip_stock_valido			number(1);
 v_estado_nuevo				number(1);
 v_traspaso_masivo			number(1);
 v_serie_valida				number(1);
 v_kit 						number(1);
 v_serie_temp				number(1);
 v_tip_stock				npt_detalle_pedido.tip_stock%type;
 v_cod_articulo				npt_detalle_pedido.cod_articulo%type;
 v_cod_uso					npt_detalle_pedido.cod_uso%type;
 v_cod_bodega				npt_detalle_pedido.cod_bodega%type;
 v_tip_stock_al				npt_detalle_pedido.tip_stock%type;
 v_cod_articulo_al			npt_detalle_pedido.cod_articulo%type;
 v_cod_uso_al				npt_detalle_pedido.cod_uso%type;
 v_cod_bodega_al			npt_detalle_pedido.cod_bodega%type;
 v_cod_tecnologia			npt_detalle_pedido.cod_tecnologia%type;
 v_num_telefono				al_componente_kit.num_telefono%type;
 v_existe_serie_pedido		npt_serie_pedido.cod_serie_pedido%type;
 v_ind_tel                  al_series.ind_telefono%type;
 v_cod_Art_num              al_articulos.cod_articulo%type;
 v_aux_lin_det_pedido       npt_detalle_pedido.lin_det_pedido%type;
 v_lin_det_pedido			npt_detalle_pedido.lin_det_pedido%type;
 v_validahistorico			varchar2(3);
 v_num_telefono_serie		al_series.NUM_TELEFONO%type;
 v_cod_central				al_series.COD_CENTRAL%type;
 v_codTecno_central			icg_central.COD_TECNOLOGIA%type;
 v_cod_central_kit			al_series.COD_CENTRAL%type;

 -- Obtencion de series desde tabla temporal.
 cursor c_series is select a.num_serie, b.tip_stock, b.cod_articulo, b.cod_uso,
	   				b.cod_bodega, b.lin_det_pedido, b.cod_tecnologia
                    from NP_VALIDACION_SERIES_TO a,
					npt_detalle_pedido b
                    where a.cod_pedido = pCodPedido
                    and a.estado is null
					and b.cod_pedido=a.cod_pedido
					and b.lin_det_pedido=a.lin_det_pedido;
begin
v_aux_lin_det_pedido:= 0;
 open c_series;
    loop
       fetch c_series into v_serie, v_tip_stock, v_cod_articulo, v_cod_uso, v_cod_bodega, v_lin_det_pedido, v_cod_tecnologia;
       exit when c_series%notfound;

	   -- Inicializacion de variables.

	   v_existe_serie_en_bodega:=0;
	   v_coinciden_bodegas:=0;
	   v_coincide_articulo:=0;
	   v_uso_valido:=0;
	   v_tip_stock_valido:=0;
	   v_estado_nuevo:=0;
	   v_traspaso_masivo:=0;
	   v_serie_valida:=0;
	   v_kit:=0;
	   v_num_telefono:=null;
	   v_existe_serie_pedido:='NO ESTA';


	   BEGIN
           -- Valido que el tipo de stock de la serie coincida con el suo especificado por el pedido
		   select tip_stock, cod_articulo, cod_uso, cod_bodega, num_telefono, cod_central
		   into   v_tip_stock_al, v_cod_articulo_al, v_cod_uso_al, v_cod_bodega_al, v_num_telefono_serie, v_cod_central
		   from   al_series
		   where num_serie=v_serie;

		   -- Valido que el tipo de stock de la serie coincida con el uso especificado por el pedido
		   if v_tip_stock_al<>v_tip_stock then
		      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=50
			  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
			  commit;
		   end if;

		   if v_cod_articulo_al<>v_cod_articulo then
		      -- Si el articulo no coincide dejo error en tabla temporal.
			  update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=30
			  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
			  commit;
		   end if;

		   -- Valido que el uso de la serie coincida con el uso especificado por el pedido
		   if v_cod_uso_al<>v_cod_uso then
		      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=40
			  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
			  commit;
		   end if;

		   -- Valido que la bodega en la que se encuentra la serie coincida con la que indica el pedido
		   if v_cod_bodega_al<>v_cod_bodega then
		      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=20
			  where  cod_pedido=pCodPedido and num_serie=v_serie  and estado is null;
			  commit;
		   end if;

		   --Valido que la tecnologia asociado a la central de la serie corresponda a la selecciona por el usuario

		   if v_num_telefono_serie >0 then
			  Select cod_tecnologia
			  into v_codTecno_central
			  from icg_central
			  where cod_central = v_cod_central;

			  if v_cod_tecnologia<>v_codTecno_central then
			  	 update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=25
				 where  cod_pedido=pCodPedido and num_serie=v_serie  and estado is null;
			  	 commit;

			  end if;


		   end if;

	   -- si la serie no existe en siscel, deja error en la tabla temporal, para esa serie.
	        EXCEPTION
	            WHEN NO_DATA_FOUND THEN
				BEGIN
			      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=10
				  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
				  commit;
		        END;

	   END;


	   -- Valido que el estado de la serie sea nuevo.
	   BEGIN
		   select 1 into v_estado_nuevo from al_series where num_serie=v_serie and cod_estado=1;

		   -- Si el estado de la serie no es nuevo deja error en tabla temporal.
		   EXCEPTION
	            WHEN NO_DATA_FOUND THEN
				BEGIN
			      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=60
				  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
				  commit;
			    END;
       END;

	   -- Valido que la serie no exista en la tabla de validaciones temporal.
	   BEGIN
		   select count(*) into v_serie_temp from NP_VALIDACION_SERIES_TO where num_serie=v_serie;

		   -- Si la serie existe en la tabla deja error en tabla temporal de validacion.
		   if v_serie_temp>1 then
			  update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=90
			  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
			  commit;
		   end if;
       END;


	   BEGIN
		   -- Valido que la serie no este ingresada en las tablas temporales de traspaso de bodegas.
		   select 1 into v_traspaso_masivo from al_traspasos_masivo
		   where num_serie=v_serie and cod_pedido=pCodPedido;

		   EXCEPTION
	            WHEN NO_DATA_FOUND THEN
		          null;
	   END;

	   -- Si la serie se encuentra en las tablas temporales de traspaso de bodegas
	   -- deja error en la tabla temporal.
	   if v_traspaso_masivo=1 then
	      update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=70
		  where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
		  commit;
       end if;

       BEGIN
		   -- reviso si la serie corresponde a un kit
		   select 1 into v_kit from al_articulos where cod_articulo=v_cod_articulo_al
		   and tip_articulo=20;

		   EXCEPTION
	            WHEN NO_DATA_FOUND THEN
				   null;
	   END;

	   -- Si la serie corresponde a un kit valido que el kit este numerado.
	   if v_kit=1 then
	      BEGIN


		      select num_telefono, cod_central into v_num_telefono, v_cod_central_kit from al_componente_kit
			  where num_kit=v_serie and ind_telefono>0;


			  EXCEPTION
	            WHEN NO_DATA_FOUND THEN
			     BEGIN
				     update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=80
				  	 where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
				  	 commit;
				 END;
		  END;

		  BEGIN
  			  Select cod_tecnologia
			  into v_codTecno_central
			  from icg_central
			  where cod_central = v_cod_central_kit;


  	  		  if v_cod_tecnologia<>v_codTecno_central then
			  	 update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=25
				 where  cod_pedido=pCodPedido and num_serie=v_serie  and estado is null;
				 commit;
			  end if;

		  END;


	   end if;

       --Valido que la serie no haya sido ingresada por otro pedido a la tabla npt_serie_pedido.
	   BEGIN

  		 select valor_parametro into v_validahistorico from npt_parametro
		 where alias_parametro = 'VALHISSER';

		 if v_validahistorico='NO' then

		     select a.cod_serie_pedido into v_existe_serie_pedido
			 from 	npt_serie_pedido a
			 where  a.cod_serie_pedido=v_serie;
		end if;

		if v_validahistorico='SI' then
		     select a.cod_serie_pedido into v_existe_serie_pedido
			 from 	npt_serie_pedido a, npt_pedido b
			 where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido
			 union
		     select a.cod_serie_pedido
			 from 	npt_serie_pedido_hist_th a, npt_pedido_hist_th b
			 where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido;

		 end if;

		 EXCEPTION
            WHEN NO_DATA_FOUND THEN
				 begin
				 	  select a.cod_serie_pedido into v_existe_serie_pedido
					  from 	npt_serie_pedido a, npt_pedido b
			 		  where  a.cod_serie_pedido=v_serie and a.cod_pedido=b.cod_pedido;
			   		  EXCEPTION
		 		            WHEN NO_DATA_FOUND THEN
							null;


				 end;
	   END;

	   if v_existe_serie_pedido<>'NO ESTA' then
	     update NP_VALIDACION_SERIES_TO set estado='ERROR', cod_error=15
		 where  cod_pedido=pCodPedido and num_serie=v_serie and estado is null;
		 commit;
	   end if;


	   --Si es SIMCARD debe estar numerado--
	  if  v_lin_det_pedido <> v_aux_lin_det_pedido then
	      v_aux_lin_det_pedido := v_lin_det_pedido;
		  begin
		  select count(1)
		  into 	 v_cod_art_num
		  from 	 al_articulos
          where  ind_equiacc='E'
       	  and  	 tip_terminal = 'G'
		  and 	 cod_articulo = v_cod_articulo;
		  end;
	   end if;

	   if v_cod_art_num > 0 then
	       begin
		       select count(1)
			   into	  v_ind_tel
			   from	  al_series
			   where  ind_telefono > 0
			   and 	  num_serie = v_serie
			   and 	  num_telefono is not null;
			   if v_ind_tel = 0 then
			       begin
				       update np_validacion_series_to
					   set    estado= 'ERROR', cod_error = 85
					   where  cod_pedido = pcodpedido
					   and    num_serie = v_serie
					   and    estado is null;
					   commit;
					   exception
					       when others then
						       null;
			 	 	end;
				end if;
			end;
		end if;




	   -- Pregunto si la serie contiene errores.
	   begin
	   select 1 into v_serie_valida from NP_VALIDACION_SERIES_TO
	   where  cod_pedido=pCodPedido and num_serie=v_serie
	   and estado is null;

	   EXCEPTION
            WHEN NO_DATA_FOUND THEN
			 null;
	   END;

	   -- Si la serie no contiene errores, se marca como serie valida.
	   if v_serie_valida=1 then
	      update NP_VALIDACION_SERIES_TO set estado='OK'
		  where  cod_pedido=pCodPedido and num_serie=v_serie;
		  commit;
	   end if;

    end loop;
 close c_series;
end NP_VALIDASERIES_PR;
/
SHOW ERRORS
