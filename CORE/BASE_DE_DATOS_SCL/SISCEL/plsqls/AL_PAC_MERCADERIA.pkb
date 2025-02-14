CREATE OR REPLACE package body AL_PAC_MERCADERIA
 IS
--
  PROCEDURE p_trata_movim_pdte(
  v_periodo in number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type,
  v_compacta IN OUT boolean )

  IS
	v_dia_inicio_pdte DATE;
	v_dia_fin_pdte    DATE;
    v_ini_ejer        al_cierres_alma.fec_inicio%type;
    v_fin_ejer        al_cierres_alma.fec_fin%type;
       CURSOR c_pdte IS
            SELECT *
			  FROM al_pdte_calculo
		    WHERE cod_articulo > -1
		    AND fec_movimiento BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
	   	    AND (ind_valor_des <> 9 or ind_valor_des IS NULL)
	  	    ORDER BY DECODE(ind_entsal,'E',1,'T',2,'S',3), cod_articulo, num_movimiento
            FOR UPDATE;
       CURSOR c_merc IS
         SELECT *
		   FROM al_pmp_mercaderia
		  WHERE cod_articulo > -1
		    AND fec_ejercicio  = v_ini_ejer
		  ORDER BY cod_articulo
		  FOR UPDATE;
    v_inter        al_intercierre%rowtype;
    v_moneda_val   ge_monedas.cod_moneda%type;
    v_decim        ge_monedas.num_decimal%type;
    v_precio       al_pdte_calculo.prc_unidad%type;
    v_error        al_intercierre.cod_retorno%type;
    v_mensa        al_intercierre.des_cadena%type;
    v_pdte         al_pdte_calculo%rowtype;
	v_merc         al_pmp_mercaderia%rowtype;
	v_dia_fin DATE;
	v_pct_obs al_pmp_mercaderia.pct_obs%type;
	v_fecha DATE;
	v_cont NUMBER;
	v_nro_ventas NUMBER ;
	  v_nro_compras1 NUMBER;
	  v_nro_compras_extras NUMBER;
	  v_nro_compras2 NUMBER;
	  v_nro_total NUMBER;
	  v_nro_ventas_ant NUMBER ;
	  v_nro_ventas_tot NUMBER ;
	  v_pct_obs_ant al_pmp_mercaderia.pct_obs%type;
	  v_can_compras_mes al_pmp_mercaderia.can_compras_mes%type;
	  v_can_compras_mes1 al_pmp_mercaderia.can_compras_mes%type;
	  v_can_compras_mes2 al_pmp_mercaderia.can_compras_mes%type;
	  v_can_compras_mes_extras al_pmp_mercaderia.can_compras_mes%type;
	  v_can_compras_pesos al_pmp_mercaderia.can_compras_pesos%type;
	  v_operadora_scl ge_operadora_scl.cod_operadora_scl%type;
	  v_desc_cadena    VARCHAR2(255);
	  ERROR_VALIDA_CANTIDADES EXCEPTION;
	  ERROR_BLOQUEO_TABLAS_PMP1 EXCEPTION;
	  ERROR_BLOQUEO_TABLAS_PMP2 EXCEPTION;
	  ERROR_COMPACTACION  EXCEPTION;
	  ERROR_ACTUALIZA_REGISTROS  EXCEPTION;

        BEGIN
		v_desc_cadena:='';
        p_traza_procedimiento('FECHA INICIO: ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
        COMMIT;
	v_desc_cadena:='(1.Ini)';
     -- Obtiene operadora local
	SELECT ge_fn_operadora_scl
	INTO v_operadora_scl
	FROM dual;			--
	v_margen_obs := 5; -- margen para obsolescencia del 5%
    v_inter.cod_retorno:=0;
    v_inter.des_cadena:='OK';
	v_cont := 0;
        -- Borramos la tabla de errores AL_INTERCIERRE.
        --p_borra_errores;

	SELECT nvl(trunc(add_months(mes_cierre,1),'MONTH'),trunc(fec_inicio,'YEAR')),last_day(nvl(trunc(add_months(mes_cierre,1),'MONTH'),trunc(fec_inicio,'YEAR')))+1
	  INTO v_dia_inicio_pdte, v_dia_fin_pdte
	  FROM al_cierres_alma
	 WHERE ind_cerrado=0;


    p_act_mov_rezagados(v_dia_inicio_pdte, v_error);
	IF v_error = 1 THEN
	ROLLBACK;
        v_desc_cadena:=v_desc_cadena||'(O.Err act_rez)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
		RAISE_APPLICATION_ERROR (-20000,'/ErrActRez/' || to_char(SQLCODE));
	ELSE
		COMMIT;
		v_desc_cadena:= v_desc_cadena||'(1.5.Fin act_rez)';
	END IF;
        -- Se supone que un codigo de moneda nulo en pdte_calculo
        -- equivale a la moneda por defecto de al_datos_generales.
     -- Si el precio es nulo, se obtiene del registro de pmp_mercaderia
        -- mas reciente, que debe existir para cada articulo del almacen,
        -- y se asume que su moneda es la moneda por defecto.
        al_pac_validaciones.p_obtiene_moneda (v_moneda_val);
        al_pac_validaciones.p_decimales (v_moneda_val,v_decim);
 	-- Internamente usamos dos decimales que es lo maximo permitido
	v_decim := 2;
	al_pac_validaciones.p_obtiene_ejercicio (v_ini_ejer,v_fin_ejer, v_operadora);
	-- Podemos borrar entradas y salidas de tipo ind_valor_ori = 0 y
	-- ind_valor_des = NULL para ahorrar tiempo
	DELETE al_pdte_calculo
	WHERE ind_valor_ori = 0
	AND ind_valor_des IS NULL
	AND (ind_entsal='E' OR ind_entsal='S');
	   v_desc_cadena:=v_desc_cadena||'(2.Ini val_cant)';
	p_valida_cantidades (v_ini_ejer,v_error);
	IF v_error = 1 THEN
		RAISE ERROR_VALIDA_CANTIDADES;
	ELSE
		COMMIT;
		v_desc_cadena:= v_desc_cadena||'(3.Fin val_cant)';
	END IF;
        -- Bloqueamos la tabla de mercaderia, porque este proceso no se puede lanzar simultaneo
        p_bloqueo_tablas_pmp(v_error,v_mensa);
	IF v_error = 1 THEN
		RAISE ERROR_BLOQUEO_TABLAS_PMP1;
	END IF;
	v_desc_cadena:= v_desc_cadena||'(4.Fin bloq)';


    SELECT count(1)
	  INTO v_cont
	  FROM al_hpmp_mercaderia
     WHERE trunc(fec_historico,'MONTH') = trunc( add_months(v_dia_inicio_pdte,1) , 'MONTH')
       AND cod_articulo > 0;
	---------------------------------------------------------------------
	--Guardamos los registros antiguos de mercaderia en tabla historicos mercaderia
	-- JLV TEMPORAL modificado para que el 29 de JUNIO se pueda ejecutar el cierre de JULIO

	IF v_cont = 0 THEN
		-- JLV TEMPORAL modificado para que el 29 de JUNIO se pueda ejecutar el cierre de JULIO
		/*
		if v_Periodo = 1 then
		   select trunc(sysdate) into v_fecha from dual;
		else
		    if v_Periodo = 0 then
		       select trunc(ADD_MONTHS(sysdate,1), 'MONTH') into v_fecha from dual;
		    end if;
		end if;
		*/
		v_fecha := trunc(add_months(v_dia_inicio_pdte,1),'MONTH');
		INSERT INTO al_hpmp_mercaderia (cod_articulo,fec_ejercicio,can_stock,prc_pmp,
			fec_historico,pct_obs,pmp_obs,can_salida, can_salida_tot,
			stock_pmp, can_salida_pmp, can_compras_mes, can_compras_pesos,
			prc_compras_prom, can_compras_tot,pmp_obs_stock , cod_operadora_scl)
			SELECT cod_articulo,fec_ejercicio,can_stock,prc_pmp,
			v_fecha,pct_obs,pmp_obs,can_salida, can_salida_tot,
			stock_pmp, can_salida_pmp, can_compras_mes, can_compras_pesos,
			prc_compras_prom, can_compras_tot, pmp_obs_stock,cod_operadora_scl
			FROM al_pmp_mercaderia
			WHERE cod_articulo > -1 AND fec_ejercicio  = v_ini_ejer;
		COMMIT;
   v_desc_cadena:=v_desc_cadena||'(5.Ins hpmp)';
	END IF;
	v_desc_cadena:=v_desc_cadena||'(6.Ini Compact)';
   -- Se Cambia p_compacta fuera del ciclo if para que la realice en forma optima r.l.m 17/12/2003

		p_compacta(v_dia_inicio_pdte,v_dia_fin_pdte,v_error);
		IF v_error = 1 THEN
			RAISE ERROR_COMPACTACION;
		END IF;
		COMMIT;
    v_desc_cadena:=v_desc_cadena||'(7.Fin compac)';
	p_bloqueo_tablas_pmp(v_error,v_mensa);
	IF v_error = 1 THEN
		RAISE ERROR_BLOQUEO_TABLAS_PMP2;
	END IF;
    v_desc_cadena:=v_desc_cadena||'(8.Fin bloq)';
	v_cont := 0;
	v_desc_cadena:=v_desc_cadena||'(9.Ini c_pdte)';
     	OPEN c_pdte;
        LOOP
	     FETCH c_pdte INTO v_pdte;
             EXIT WHEN c_pdte%NOTFOUND;
                -- Si el movimiento corresponde al a?o siguiente a un a?o sin cerrar, no lo procesamos.
                -- Antes de procesar estos movimientos, hay que procesar los del a?o en curso,
                -- y cerrar el ejercicio.
                IF v_pdte.fec_movimiento <= v_fin_ejer THEN
                        IF v_pdte.ind_entsal='E' OR v_pdte.ind_entsal='T' THEN
                                IF v_pdte.cod_moneda IS NULL THEN
                                   v_pdte.cod_moneda := v_moneda_val;
                                END IF;
                                IF v_pdte.prc_unidad IS NULL THEN
                                        p_obtiene_prc_pmp(v_pdte.cod_articulo,v_pdte.prc_unidad,
                                                         v_inter.cod_retorno,v_inter.des_cadena);
                                END IF;
                        END IF;
                        IF v_pdte.ind_entsal='E' THEN
                                -- La sig. condicion solo se ha observado en el caso de
                                -- recepcion de equipo cliente STP, nunca en el caso de
                                -- articulos que entran por primera vez a bodega.
                                IF v_pdte.prc_unidad IS NULL THEN v_pdte.prc_unidad := 0;
						END IF;
                 END IF;
                        IF v_pdte.ind_entsal='E' OR v_pdte.ind_entsal='T' THEN
                                IF v_pdte.cod_moneda <> v_moneda_val THEN
                                   al_pac_validaciones.p_convertir_precio (v_pdte.cod_moneda,v_moneda_val,
                                   v_pdte.prc_unidad,v_precio,
                                   v_pdte.fec_movimiento);
                                   v_pdte.prc_unidad := v_precio;
                                END IF;
                        END IF;
                        IF v_pdte.ind_entsal='E' THEN
                                p_proceso_entrada (v_pdte,v_ini_ejer,v_inter.cod_retorno,v_inter.des_cadena,v_decim, v_operadora);
                        ELSIF v_pdte.ind_entsal='T' THEN
                          p_proceso_traspaso (v_pdte,v_ini_ejer,v_inter.cod_retorno,
                                                                v_inter.des_cadena,v_decim, v_operadora);
                        ELSIF v_pdte.ind_entsal='S' THEN
                                -- En salidas no importa el precio
                                p_proceso_salida (v_pdte,v_ini_ejer,v_inter.cod_retorno,
                                                           v_inter.des_cadena,v_decim);
                        END IF;
                        IF v_inter.cod_retorno = 0 THEN
                      	UPDATE al_pdte_calculo
						   SET ind_valor_des='9' --fue bien
   				        WHERE num_movimiento = v_pdte.num_movimiento;
                        ELSE
			    ROLLBACK;
                            p_guarda_error(v_pdte,v_inter.cod_retorno,v_inter.des_cadena);
			    COMMIT;
                        END IF;
                END IF;
        END LOOP;
        CLOSE c_pdte;
	     v_desc_cadena:=v_desc_cadena||'(10.Fin c_pdte)';
------------------------------------------------------------------------------------
	-- Ahora calculamos la obsolescencia... para cada articulo en PMP hallamos las
	-- salidas que ha habido en la tabla de pendientes, y solo para los movimientos
	-- que han ido bien... y ademas si y solo si todos los movimientos se procesaron bien
	-- JLV : Modificado 11-01-2001 . Si el articulo ha llegado a PCT_OBS 100%
	-- No se recalcula PCT_OBS
	-- JLV : Modificado 11-01-2001 . Si el articulo no registra compras en piriodo hasta
	-- tres meses atras, no se toca la obs, porque suponemos que estan haciendo acopio
	-- de mercaderia antes de promocion, y no corre OBS.
	-- JLV : Modificado 11-01-2001 . Ahora, la obsolescencia maneja solo los
	-- tipos de stock valorados
	-- JLV : Modificado 11-01-2001 . Ahora, la obsolescencia tambien corre para accesorios.
	-- JLV : Modificado 11-01-2001 . Aqadidas unidades de compras por mes.
	-- JLV : Modificado 11-01-2001 . Aqadidas pesos de las compras por mes.
	-- JLV : Modificado 11-01-2001 . Aqadidas OBS*Stock unidades
	SELECT count(1)
	  INTO v_cont
	  FROM al_pdte_calculo
	 WHERE cod_articulo > -1
   	   AND (ind_valor_des <> 9 OR ind_valor_des IS NULL)
	   AND fec_movimiento BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte;
	IF v_cont = 0 THEN --todos se procesaron bien, podemos calcular la obsolescencia
	COMMIT;
		-- JLV TEMPORAL modificado para que el 29 de JUNIO se pueda ejecutar el cierre de JULIO
		v_dia_fin := LAST_DAY(trunc(ADD_MONTHS(v_dia_inicio_pdte,-3),'MONTH')) + 1;
		--fecha inicio y fecha fin del mes hace tres meses
		-- (n=mes de los pdtes, n-3 = mes para calculo de compras,
		-- sysdate es n+1 que es cuando se lanza el proceso
     v_desc_cadena:=v_desc_cadena||'(11.ini c_merc)';
		OPEN c_merc;
	        LOOP
			FETCH c_merc INTO v_merc;
		    EXIT WHEN c_merc%NOTFOUND;
			v_nro_ventas :=0;
			v_nro_compras1 := 0;
			v_nro_compras2 := 0;
			v_nro_compras_extras := 0;
			v_nro_total := 0;
			v_nro_ventas_ant :=0;
	        v_nro_ventas_tot :=0;
			v_pct_obs_ant    :=0;
			v_can_compras_mes :=0;
			v_can_compras_mes1 :=0;
			v_can_compras_mes2 :=0;
			v_can_compras_mes_extras :=0;
	  	    v_can_compras_pesos :=0;
			-- 1) v_nro_ventas valoradas, ventas en periodo n PMP, para OBS y costo ventas
			SELECT NVL(sum(num_cantidad),0)
			  INTO v_nro_ventas
			  FROM al_pdte_calculo
			 WHERE cod_articulo = v_merc.cod_articulo
			   AND fec_movimiento BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
			   AND ind_entsal='S'
			   AND ind_valor_ori = 1; -- mercaderia
			-- 2) can_salida_tot, cantidad hasta el mes pasado de salidas para obsolescencia
			v_nro_ventas_ant := NVL(v_merc.can_salida_tot,0);
			-- total de ventas para obsolescencia
			v_nro_ventas_tot := v_nro_ventas_ant + v_nro_ventas;
--			-- compras del articulo totales
			SELECT NVL(sum(b.can_orden),0)
			  INTO v_nro_compras1
			  FROM al_cabecera_ordenes2 a, al_lineas_ordenes2 b, al_tipos_stock c
			 WHERE a.num_orden = b.num_orden
			   AND b.num_orden>0
			   AND a.cod_estado='CE'
			   AND b.cod_articulo = v_merc.cod_articulo
			   AND a.fec_creacion < v_dia_fin
			   AND b.tip_stock = c.tip_stock
		       AND c.ind_valorar = 1;
			SELECT NVL(sum(b.can_orden),0)
			  INTO v_nro_compras2
			  FROM al_hcabecera_ordenes2 a, al_hlineas_ordenes2 b, al_tipos_stock c
			 WHERE a.num_orden = b.num_orden
			   AND b.num_orden>0
			   AND a.cod_estado='CE'
			   AND b.cod_articulo = v_merc.cod_articulo
			   AND a.fec_creacion < v_dia_fin
			   AND b.tip_stock = c.tip_stock
			   AND c.ind_valorar = 1;
			-- compras del articulo totales por E/S extra
			SELECT NVL(sum(b.can_extra),0)
			  INTO v_nro_compras_extras
			  FROM al_cab_es_extras a, al_lin_es_extras b, al_tipos_stock c
			 WHERE a.num_extra = b.num_extra
			   AND b.num_extra>0
			   AND a.ind_entsal ='E'
			   AND a.cod_estado='CE'
			   AND b.cod_articulo + 0 = v_merc.cod_articulo
			   AND a.fec_extra < v_dia_fin
			   AND b.tip_stock = c.tip_stock
			   AND c.ind_valorar = 1;
			-- Compras del articulo para el mes de cierre
			SELECT NVL(sum(b.can_orden),0)
			  INTO v_can_compras_mes1
			  FROM al_cabecera_ordenes2 a, al_lineas_ordenes2 b, al_tipos_stock c
			 WHERE a.num_orden = b.num_orden
			   AND b.num_orden>0
			   AND a.cod_estado='CE'
			   AND b.cod_articulo = v_merc.cod_articulo
			   AND a.fec_creacion BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
			   AND b.tip_stock = c.tip_stock
			   AND c.ind_valorar = 1;
			SELECT NVL(sum(b.can_orden),0)
			  INTO v_can_compras_mes2
			  FROM al_hcabecera_ordenes2 a, al_hlineas_ordenes2 b, al_tipos_stock c
			 WHERE a.num_orden = b.num_orden
				AND b.num_orden>0
				AND a.cod_estado='CE'
				AND b.cod_articulo = v_merc.cod_articulo
				AND a.fec_creacion BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
				AND b.tip_stock = c.tip_stock
				AND c.ind_valorar = 1;
			SELECT NVL(sum(b.can_extra),0)
			  INTO v_can_compras_mes_extras
			  FROM al_cab_es_extras a, al_lin_es_extras b, al_tipos_stock c
		   	 WHERE a.num_extra = b.num_extra
				AND b.num_extra>0
				AND a.ind_entsal ='E'
				AND a.cod_estado='CE'
				AND b.cod_articulo + 0 = v_merc.cod_articulo
				AND a.fec_extra BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
				AND b.tip_stock = c.tip_stock
				AND c.ind_valorar = 1;
			v_can_compras_mes := v_can_compras_mes1 + v_can_compras_mes2 + v_can_compras_mes_extras;
			-- Cantidad en pesos de las compras del mes
	select sum(cantidad) into v_can_compras_pesos from  (
		select NVL(sum(can_orden * round((a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0)))),0) cantidad
      		from ge_conversion a,
           	al_lineas_ordenes2 b,
           	al_cabecera_ordenes2 c,
			al_tipos_stock d
     		where c.num_orden = b.num_orden
       		and a.cod_moneda = c.cod_moneda
   	   		and c.fec_creacion between v_dia_inicio_pdte and v_dia_fin_pdte
       		and c.fec_creacion between a.fec_desde and a.fec_hasta
  	   		and c.fec_creacion > TO_DATE('12-01-2001', 'DD-MM-YYYY')
       		and c.cod_estado='CE'
       		and b.cod_articulo = v_merc.cod_articulo
			and b.tip_stock = d.tip_stock
			and d.ind_valorar = 1
    	union all
    	select NVL(sum(can_orden * round((a.cambio * b.prc_unidad) + (a.cambio * nvl(prc_ff,0)) + (a.cambio * nvl(prc_adic,0)))),0) cantidad
      		from ge_conversion a,
           	al_hlineas_ordenes2 b,
           	al_hcabecera_ordenes2 c,
			al_tipos_stock d
     		where c.num_orden = b.num_orden
       		and a.cod_moneda = c.cod_moneda
       		and c.fec_creacion between v_dia_inicio_pdte and v_dia_fin_pdte
       		and c.fec_creacion between a.fec_desde and a.fec_hasta
  	   		and c.fec_creacion > TO_DATE('12-01-2001', 'DD-MM-YYYY')
       		and c.cod_estado='CE'
       		and b.cod_articulo = v_merc.cod_articulo
			and b.tip_stock = d.tip_stock
			and d.ind_valorar = 1
	 	union all
	 	select NVL(sum(can_orden * round((a.cambio * b.prc_unidad) + nvl(prc_ff,0) + nvl(prc_adic,0))),0) cantidad
      		from ge_conversion a,
           	al_lineas_ordenes2 b,
           	al_cabecera_ordenes2 c,
			al_tipos_stock d
     		where c.num_orden = b.num_orden
       		and a.cod_moneda = c.cod_moneda
   	   		and c.fec_creacion between v_dia_inicio_pdte and v_dia_fin_pdte
       		and c.fec_creacion between a.fec_desde and a.fec_hasta
  	   		and c.fec_creacion < TO_DATE('12-01-2001', 'DD-MM-YYYY')
       		and c.cod_estado='CE'
       		and b.cod_articulo = v_merc.cod_articulo
			and b.tip_stock = d.tip_stock
			and d.ind_valorar = 1
     	union all
    	select NVL(sum(can_orden * round((a.cambio * b.prc_unidad) + nvl(prc_ff,0) + nvl(prc_adic,0))),0) cantidad
      		from ge_conversion a,
           	al_hlineas_ordenes2 b,
           	al_hcabecera_ordenes2 c,
			al_tipos_stock d
     		where c.num_orden = b.num_orden
       		and a.cod_moneda = c.cod_moneda
       		and c.fec_creacion between v_dia_inicio_pdte and v_dia_fin_pdte
       		and c.fec_creacion between a.fec_desde and a.fec_hasta
  	   		and c.fec_creacion < TO_DATE('12-01-2001', 'DD-MM-YYYY')
       		and c.cod_estado='CE'
       		and b.cod_articulo = v_merc.cod_articulo
			and b.tip_stock = d.tip_stock
			and d.ind_valorar = 1
		union all
		select NVL(sum(round(b.can_extra * b.prc_unidad)),0) cantidad
			from al_cab_es_extras a, al_lin_es_extras b, al_tipos_stock c
			where a.num_extra = b.num_extra
			and b.num_extra>0
			and a.ind_entsal ='E'
			and a.cod_estado='CE'
			and b.cod_articulo + 0 = v_merc.cod_articulo
			and a.fec_extra between v_dia_inicio_pdte and v_dia_fin_pdte
			and b.tip_stock = c.tip_stock
			and c.ind_valorar = 1
	);
--			-- calculo de obsolescencia
			if v_merc.pct_obs >= 100 then
				v_pct_obs:=100; -- PCT OBS queda quieto cuando PCT_OBS ES 100
			else
				if (v_nro_compras1 + v_nro_compras2 + v_nro_compras_extras) = 0 then
					v_pct_obs := v_merc.pct_obs;  -- PCT OBS queda igual que estaba
				else
					if v_nro_ventas_tot = 0 then
						-- No hay ventas, no podemos calcular la obsolescencia, la castigamos
						v_pct_obs := NVL(v_merc.pct_obs,0) + 10; --Castigo de 10%
					else
						v_nro_total := ROUND(v_nro_ventas_tot / (v_nro_compras1 + v_nro_compras2 + v_nro_compras_extras),4);
						if v_nro_total >=1 then
							v_pct_obs := 0;
						else
							v_pct_obs := (1 - v_nro_total) * 100;
							v_pct_obs_ant := NVL(v_merc.pct_obs,0);
							if abs(v_pct_obs - v_pct_obs_ant) <= v_margen_obs then
								-- castigamos al equipo
								v_pct_obs := v_pct_obs + 10; --Castigo de 10%
							end if;
						end if;
					end if;
				end if;
			end if;
			if v_pct_obs > 100 then
				 v_pct_obs:=100;
			end if;
			update al_pmp_mercaderia set pct_obs = round(v_pct_obs,v_decim) ,
			pmp_obs = round((v_merc.prc_pmp * v_pct_obs) / 100,v_decim),
			can_salida = v_nro_ventas ,
			can_salida_tot = v_nro_ventas_tot,
			can_compras_mes = v_can_compras_mes,
			can_compras_pesos = v_can_compras_pesos,
			can_compras_tot = can_compras_tot + v_can_compras_mes
			where cod_articulo = v_merc.cod_articulo
		        and fec_ejercicio  = v_ini_ejer;
		END LOOP;
		close c_merc;
	   v_desc_cadena:=v_desc_cadena||'(12.Fin c_merc)';
		delete al_pdte_calculo where
		ind_valor_des = 9 and
		fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte;
        v_desc_cadena:=v_desc_cadena||'(13.Del pdte=9)';
		-- Actualizamos valores adicionales
		update al_pmp_mercaderia set
		stock_pmp = round ( NVL(prc_pmp,0) * NVL(can_stock,0),v_decim),
		can_salida_pmp = round( NVL(can_salida,0) * NVL(prc_pmp,0),v_decim),
		prc_compras_prom = round( can_compras_pesos / DECODE (can_compras_mes,0,1,can_compras_mes), v_decim),
		pmp_obs_stock = round( NVL(pmp_obs, 0) * NVL(can_stock,0) , v_decim)
		where fec_ejercicio  = v_ini_ejer;
		COMMIT;
        v_desc_cadena:=v_desc_cadena||'(14.Upd pmp_merc)';
	else
		RAISE ERROR_ACTUALIZA_REGISTROS;
	END IF;
    	v_desc_cadena:= v_desc_cadena||'(15.Fin proc)';
		p_traza_procedimiento(v_desc_cadena);
		commit;

        p_traza_procedimiento('FECHA FIN: ' || to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'));
        commit;

	if to_char(v_dia_inicio_pdte,'YYYYMM') <= to_char(sysdate,'YYYYMM') then
           update al_cierres_alma
           set mes_cierre = v_dia_inicio_pdte,
               fec_fin_real = sysdate
           where ind_cerrado=0;
           commit;
	end if;
-------------------------------------------------------------------------------------
        EXCEPTION
        WHEN ERROR_VALIDA_CANTIDADES THEN
		ROLLBACK;
        	v_desc_cadena:=v_desc_cadena||'(Err valida cantidad)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
        WHEN ERROR_BLOQUEO_TABLAS_PMP1 THEN
		ROLLBACK;
		v_desc_cadena:=v_desc_cadena||'(Err bloqueo 1)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
	WHEN ERROR_BLOQUEO_TABLAS_PMP2 THEN
		ROLLBACK;
		v_desc_cadena:=v_desc_cadena||'(Err bloqueo 2)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
	WHEN ERROR_COMPACTACION THEN
		ROLLBACK;
		v_desc_cadena:=v_desc_cadena||'(Err compacta)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
	WHEN ERROR_ACTUALIZA_REGISTROS THEN
		ROLLBACK;
	    	v_desc_cadena:=v_desc_cadena||'(Err actualiza)';
		p_traza_procedimiento(v_desc_cadena);
		COMMIT;
       when OTHERS then
            if c_pdte%ISOPEN then close c_pdte;
            ROLLBACK;
			   v_desc_cadena:= v_desc_cadena||'(E.Err c_pdte)';
			   p_traza_procedimiento(v_desc_cadena);
			   commit;

            end if;
	    if c_merc%ISOPEN then close c_merc;
	    ROLLBACK;
			  v_desc_cadena:= v_desc_cadena||'(F.Err c_merc)';
			  p_traza_procedimiento(v_desc_cadena);
			   commit;
	    end if;
            if SQLCODE = -20185 then
			ROLLBACK;
			 v_desc_cadena:= v_desc_cadena||'(G.SQL 20185)';
			 p_traza_procedimiento(v_desc_cadena);
			 commit;
                        raise_application_error (-20185,'/Error Obtencion Decimales/' || to_char(SQLCODE));
            elsif SQLCODE = -20149 then
			ROLLBACK;
			 v_desc_cadena:= v_desc_cadena||'(H.SQL 20149)';
			 p_traza_procedimiento(v_desc_cadena);
			 commit;
                        raise_application_error (-20149,'/Error Obtencion Moneda/' || to_char(SQLCODE));
            elsif SQLCODE = 20147 then
			ROLLBACK;
			v_desc_cadena:= v_desc_cadena||'(I.SQL 20147)';
			 p_traza_procedimiento(v_desc_cadena);
			 commit;
                        raise_application_error (-20147,'/Error Conversion Precio/' || to_char(SQLCODE));
            else
    			ROLLBACK;
			  v_desc_cadena:=v_desc_cadena || '(Err general/' || TO_CHAR(SQLCODE) ||' )';
		      p_traza_procedimiento(v_desc_cadena);
		       commit;
            end if;
        END p_trata_movim_pdte;
  --
  -- Retrofitted
-----------------------------
PROCEDURE p_valida_cantidades (
v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type,
v_error IN OUT al_intercierre.cod_retorno%type)
IS
	CURSOR c_articulos is
		select a.cod_articulo articulo,a.des_articulo descri
		from al_articulos a ORDER BY COD_ARTICULO;
	v_articulos c_articulos%rowtype;
	v_pdte_cantidad al_pdte_calculo.num_cantidad%type;
	v_stock_cantidad al_stock.can_stock%type;
	v_pmp_cantidad al_pmp_mercaderia.can_stock%type;
	v_pdte_cantidad2 al_pmp_mercaderia.can_stock%type;
	v_compras_cantidad al_compras_mercaderia.can_stock%type;
	v_can_aux al_compras_mercaderia.can_stock%type;
begin
	v_error:=0;
	open c_articulos;
        LOOP
	       	fetch c_articulos into v_articulos;
                EXIT when c_articulos%NOTFOUND;
		begin
		select NVL(sum(a.can_stock),0) into v_stock_cantidad
		from al_stock a, al_tipos_stock b
		where a.tip_stock=b.tip_stock and b.ind_valorar=1
		and a.cod_Articulo = v_articulos.articulo;
		exception
			when NO_DATA_FOUND then
				v_stock_cantidad:=0;
			when OTHERS then
			raise;
		end;
		begin
		select NVL(sum(DECODE(IND_ENTSAL,'E',num_cantidad, 'S', -1*num_cantidad,'T', -1*num_cantidad ,0)),0)
		into v_pdte_cantidad
		from al_pdte_calculo where
		((ind_valor_ori =1 and ind_valor_des IS NULL and ind_entsal='E' ) or
		(ind_valor_ori =1 and ind_valor_des IS NULL and ind_entsal='S' ) or
		(ind_valor_ori =1 and ind_valor_des = 0 and ind_entsal='T' ) or
		(ind_valor_ori =1 and ind_valor_des = 2 and ind_entsal='T' )
		)
		and cod_articulo = v_articulos.articulo;
		exception
			when NO_DATA_FOUND then
				v_pdte_cantidad:=0;
			when OTHERS then
			raise;
		end;
		begin
		select NVL(sum(DECODE(IND_ENTSAL,'T', num_cantidad ,0)),0)
		into v_pdte_cantidad2
		from al_pdte_calculo where
		(ind_valor_ori =2 and ind_valor_des =1 and ind_entsal='T' )
		and cod_articulo = v_articulos.articulo;
		exception
			when NO_DATA_FOUND then
				v_pdte_cantidad2:=0;
			when OTHERS then
			raise;
		end;
		v_pdte_cantidad:= v_pdte_cantidad + v_pdte_cantidad2;
		begin
		select NVL(sum(can_stock),0) into v_pmp_cantidad from al_pmp_mercaderia
		where trunc(fec_ejercicio) =trunc(v_ini_ejer, 'YEAR') and cod_articulo = v_articulos.articulo;
		exception
			when NO_DATA_FOUND then
				v_pmp_cantidad :=0;
			when OTHERS then
			raise;
		end;
		begin
		select NVL(sum(can_stock),0) into v_compras_cantidad from al_compras_mercaderia
  		where cod_articulo = v_articulos.articulo;
		exception
			when NO_DATA_FOUND then
				v_compras_cantidad:=0;
			when OTHERS then
			raise;
		end;
		if v_stock_cantidad <> (v_pmp_cantidad + v_pdte_cantidad) then
				v_error:=1;
		end if;
		if (v_stock_cantidad <> (v_compras_cantidad + v_pdte_cantidad)) then
			v_error:=1;
	                begin
	                        select can_stock into v_can_aux
	                        from al_compras_mercaderia
	                        where  cod_articulo = v_articulos.articulo
	                        and mes_compra = (select min(mes_compra)
	                                                from al_compras_mercaderia
	                                                where  cod_articulo = v_articulos.articulo);
	                        exception
	                        when NO_DATA_FOUND then
	                                  v_can_aux:=0;
	                        when OTHERS then
	                                  raise;
	                end;
		end if;
	end loop;
        close c_articulos;
end;
------------------------------
  PROCEDURE p_proceso_entrada(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type )
  IS
     v_mercaderia   al_pmp_mercaderia%rowtype;
     v_fijo         al_pmp_afijo%rowtype;
     v_compra       al_compras_mercaderia%rowtype;
  BEGIN
      	v_error := 0;
        if v_pdte.ind_valor_ori = 1 then
          v_mercaderia.cod_articulo  := v_pdte.cod_articulo;
          v_mercaderia.fec_ejercicio := v_ini_ejer;
          v_mercaderia.can_stock     := v_pdte.num_cantidad;
          v_mercaderia.prc_pmp       := v_pdte.prc_unidad;
          p_entrada_mercaderia (v_mercaderia,v_error,v_mensa,v_decim, v_operadora);
          if v_error <> 0 then
                        raise exception_error;
                end if;
          v_compra.cod_articulo   := v_pdte.cod_articulo;
          v_compra.mes_compra     := trunc(v_pdte.fec_movimiento,'MONTH');
          v_compra.prc_compra     := v_pdte.prc_unidad;
          v_compra.can_stock      := v_pdte.num_cantidad;
          p_entrada_compra (v_compra,v_error,v_mensa, v_operadora);
          if v_error <> 0 then
                  raise exception_error;
          end if;
     elsif v_pdte.ind_valor_ori = 2 then
          al_pac_validaciones.p_obtiene_meses (v_pdte.cod_articulo,v_fijo.mes_vida);
          for v_veces in 1..v_pdte.num_cantidad loop
                  v_fijo.cod_articulo  := v_pdte.cod_articulo;
                      v_fijo.fec_afijo     := v_pdte.fec_movimiento;
                      v_fijo.prc_compra    := v_pdte.prc_unidad;
                      v_fijo.prc_actual    := v_pdte.prc_unidad;
                      v_fijo.num_serie     := v_pdte.num_serie;
                      v_fijo.fec_finafijo  := null;
                      p_entrada_afijo (v_fijo,v_error,v_mensa, v_operadora);
                      if v_error <> 0 then
                       raise exception_error;
                      end if;
                 end loop;
     end if;
            EXCEPTION
             when EXCEPTION_ERROR then
                  v_error := 1;
                when OTHERS then
                        if SQLCODE = 20133 then
                                v_error := 1;
v_mensa := '/Obtiene Meses Afijo/'||SQLCODE;
                        else
                                v_error := 1;
v_mensa := '/Proceso Entrada/'||SQLCODE;
                        end if;
  END p_proceso_entrada;
  --
  -- Retrofitted
  PROCEDURE p_proceso_salida(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type )
  IS
  BEGIN
 		      v_error := 0;
          if v_pdte.ind_valor_ori = 1 then
p_salida_mercaderia (v_pdte.cod_articulo,v_ini_ejer,
                                  v_pdte.num_cantidad,v_error,v_mensa);
             if v_error <> 0 then
                     raise exception_error;
             end if;
                -- A estas alturas, la serie ya no esta en bodega,
                -- asi que tratamos el articulo como no seriado
             p_salida_compra_ns (v_pdte.cod_articulo,v_pdte.num_cantidad,
                                                v_error,v_mensa);
             if v_error <> 0 then
                     raise exception_error;
             end if;
     elsif v_pdte.ind_valor_ori = 2 then
             if v_pdte.num_serie is not null  then
                  p_salida_afijo_s (v_pdte.num_serie,v_pdte.fec_movimiento,
                                    v_error,v_mensa);
                     if v_error <> 0 then
                       raise exception_error;
                  end if;
          else
                  for v_veces in 1..v_pdte.num_cantidad loop
                       p_salida_afijo_ns (v_pdte.cod_articulo,v_pdte.fec_movimiento,
                                          v_error,v_mensa);
                       if v_error <> 0 then
                               raise exception_error;
                       end if;
                     end loop;
          end if;
     end if;
            EXCEPTION
             when EXCEPTION_ERROR then
                           v_error := 1;
               when OTHERS then
                  v_error := 1;
v_mensa := '/Proceso Salida/'||SQLCODE;
  END p_proceso_salida;
  --
  -- Retrofitted
  PROCEDURE p_proceso_traspaso(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
  IS
     no_hace_nada   exception;
     v_mercaderia   al_pmp_mercaderia%rowtype;
     v_fijo         al_pmp_afijo%rowtype;
     v_compra       al_compras_mercaderia%rowtype;
     v_prc_pmp      al_pmp_mercaderia.prc_pmp%type;
     v_prc_compra   al_pmp_afijo.prc_compra%type;
     v_prc_actual   al_pmp_afijo.prc_actual%type;
     v_fecafijo     al_pmp_afijo.fec_afijo%type;
  BEGIN
		    v_error := 0;
        if v_pdte.ind_valor_ori = v_pdte.ind_valor_des or
             v_pdte.ind_valor_des is null then
             raise no_hace_nada;
     end if;
     if v_pdte.ind_valor_ori = 0 and
             (v_pdte.ind_valor_des = 1 or v_pdte.ind_valor_des = 2) then
                 v_error := 1;
                 v_mensa := '/Traspaso no permitido/';
                    raise exception_error;
     end if;
     -- VALORADO -> SIN VALORAR
        if v_pdte.ind_valor_ori = 1 and v_pdte.ind_valor_des = 0 then
                p_salida_compra_ns (v_pdte.cod_articulo,v_pdte.num_cantidad,
                              v_error,v_mensa);
          if v_error <> 0 then
                     raise exception_error;
             end if;
                 p_salida_mercaderia (v_pdte.cod_articulo,v_ini_ejer,
                               v_pdte.num_cantidad,v_error,v_mensa);
          if v_error <> 0 then
                  raise exception_error;
             end if;
        end if;
     -- ACTIVO FIJO -> SIN VALORAR
        if v_pdte.ind_valor_ori = 2 and v_pdte.ind_valor_des = 0 then
             if v_pdte.num_serie is null then
                  for v_veces in 1..v_pdte.num_cantidad loop
                       p_salida_afijo_ns (v_pdte.cod_articulo,v_pdte.fec_movimiento,
                                          v_error,v_mensa);
                       if v_error <> 0 then
                                raise exception_error;
                        end if;
                    end loop;
                 else
                    p_salida_afijo_s (v_pdte.num_serie,v_pdte.fec_movimiento,
                                    v_error,v_mensa);
                    if v_error <> 0 then
                                 raise exception_error;
                    end if;
                 end if;
     end if;
     -- VALORADO -> ACTIVO FIJO
     if v_pdte.ind_valor_ori = 1 and v_pdte.ind_valor_des = 2 then
             p_valor_mercaderia (v_pdte.cod_articulo,v_ini_ejer,
                              v_prc_pmp,v_error,v_mensa);
          if v_error <> 0 then
                  raise exception_error;
          end if;
                 al_pac_validaciones.p_obtiene_meses (v_pdte.cod_articulo,v_fijo.mes_vida);
          for v_veces in 1..v_pdte.num_cantidad loop
                    v_fijo.cod_articulo := v_pdte.cod_articulo;
                    v_fijo.fec_afijo    := v_pdte.fec_movimiento;
                    v_fijo.prc_compra   := v_prc_pmp;
                    v_fijo.prc_actual   := v_prc_pmp;
                    v_fijo.num_serie    := v_pdte.num_serie;
                    v_fijo.fec_finafijo := null;
                    p_entrada_afijo (v_fijo,v_error,v_mensa,v_operadora);
                    if v_error <> 0 then
                       raise exception_error;
                  end if;
          end loop;
                p_salida_mercaderia (v_pdte.cod_articulo,v_ini_ejer,
                               v_pdte.num_cantidad,v_error,v_mensa);
          if v_error <> 0 then
                  raise exception_error;
          end if;
          p_salida_compra_ns (v_pdte.cod_articulo,v_pdte.num_cantidad,
                              v_error,v_mensa);
          if v_error <> 0 then
                  raise exception_error;
          end if;
        end if;
     -- ACTIVO FIJO -> VALORADO
     if v_pdte.ind_valor_ori = 2 and v_pdte.ind_valor_des = 1 then
                 if v_pdte.num_serie is not null then
                        p_valor_afijo(v_pdte.num_serie,v_pdte.fec_movimiento,v_fecafijo,v_prc_compra,
                                      v_prc_actual,v_error,v_mensa);
                    if v_error <> 0 then
                       raise exception_error;
                  end if;
                    v_compra.cod_articulo := v_pdte.cod_articulo;
                    v_compra.mes_compra   := trunc(v_fecafijo,'MONTH');
                    v_compra.prc_compra   := v_prc_compra;
                    v_compra.can_stock    := v_pdte.num_cantidad;
                    p_entrada_compra (v_compra,v_error,v_mensa, v_operadora);
                    if v_error <> 0 then
                       raise exception_error;
                    end if;
                    v_mercaderia.cod_articulo    := v_pdte.cod_articulo;
                    v_mercaderia.fec_ejercicio   := v_ini_ejer;
                    v_mercaderia.can_stock       := v_pdte.num_cantidad;
                    v_mercaderia.prc_pmp         := v_prc_actual;
                    p_entrada_mercaderia (v_mercaderia,v_error,v_mensa,v_decim, v_operadora);
                    if v_error <> 0 then
                       raise exception_error;
                    end if;
                    p_salida_afijo_s (v_pdte.num_serie,v_pdte.fec_movimiento,
                                 v_error,v_mensa);
                    if v_error <> 0 then
                       raise exception_error;
                    end if;
                else
                    p_afijo_mercaderia (v_pdte.cod_articulo,v_pdte.num_cantidad,
                                      v_ini_ejer,v_pdte.fec_movimiento,v_error,v_mensa,v_decim, v_operadora);
                    if v_error <> 0 then
                       raise exception_error;
                    end if;
                 end if;
        end if;
     --
            EXCEPTION
     when NO_HACE_NADA then
             null;
     when EXCEPTION_ERROR then
          v_error := 1;
     when OTHERS then
          v_error := 1;
v_mensa := '/Proceso Traspaso/'||SQLCODE;
  END p_proceso_traspaso;
  --
  -- Retrofitted
  PROCEDURE p_entrada_mercaderia(
  v_mercaderia IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type )
  IS
      v_pmp     al_pmp_mercaderia.prc_pmp%type;
      v_can     al_pmp_mercaderia.can_stock%type;
      v_pmp_new al_pmp_mercaderia.prc_pmp%type;
      v_pmp_prom al_pmp_mercaderia.prc_pmp%type;

    BEGIN
		  	v_error := 0;



	--
    -- Verificacion de existencia del articulo para el ejercicio en curso
    --
       select prc_pmp,can_stock into v_pmp,v_can
              from al_pmp_mercaderia
              where cod_articulo = v_mercaderia.cod_articulo
                and fec_ejercicio = v_mercaderia.fec_ejercicio;
    --
	-- aqadido para que precios extremos no rompan PMP
	if v_mercaderia.prc_pmp <= (v_pmp * (v_margen_obs/100)) then
		v_pmp_prom := v_pmp;
	else
		v_pmp_prom := v_mercaderia.prc_pmp;
	end if;
        v_pmp_new :=
           round((((v_pmp * v_can) +
                   (v_pmp_prom * v_mercaderia.can_stock)
                  ) / (v_can + v_mercaderia.can_stock)),v_decim);
    --
         update al_pmp_mercaderia set prc_pmp = nvl(v_pmp_new,0),
                                      can_stock = can_stock +
                                                  v_mercaderia.can_stock
                where cod_articulo   = v_mercaderia.cod_articulo and
                      fec_ejercicio  = v_mercaderia.fec_ejercicio;
    EXCEPTION
       when NO_DATA_FOUND then
          insert into al_pmp_mercaderia (cod_articulo,
                                         fec_ejercicio,
                                         can_stock,
                                         prc_pmp,
										 cod_operadora_scl)
                                 values (v_mercaderia.cod_articulo,
                                         v_mercaderia.fec_ejercicio,
                                         v_mercaderia.can_stock,
                                         nvl(v_mercaderia.prc_pmp,0),
										 v_operadora);
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Entrada AL_PMP_MERCADERIA /';
    END p_entrada_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_entrada_afijo(
  v_fijo IN al_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora ge_operadora_scl.cod_operadora_scl%type)
  IS
    BEGIN
			 v_error := 0;
       insert into al_pmp_afijo (num_activo,
                                 cod_articulo,
                                 fec_afijo,
                                 mes_vida,
                                 prc_compra,
                                 prc_actual,
                                 num_serie,
                                 fec_finafijo,
                                 fec_calculo,
                                 prc_calculo)
                         values (al_seq_afijo.nextval,
                                 v_fijo.cod_articulo,
                                 v_fijo.fec_afijo,
                                 nvl(v_fijo.mes_vida,0),
                                 v_fijo.prc_compra,
                                 v_fijo.prc_actual,
                                 v_fijo.num_serie,
                                 v_fijo.fec_finafijo,
                                 null,
                                 null);
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error ingreso Activo Fijo/';
    END p_entrada_afijo;
  --
  -- Retrofitted
  PROCEDURE p_entrada_compra(
  v_compra IN al_compras_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
  IS
      v_precio   al_compras_mercaderia.prc_compra%type;
      v_precio1  al_compras_mercaderia.prc_compra%type;
      v_rowid    rowid;

    BEGIN
			 v_error := 0;



	--
        select prc_compra,rowid into v_precio,v_rowid
        from al_compras_mercaderia
       where cod_articulo = v_compra.cod_articulo
         and mes_compra   = v_compra.mes_compra;
        if v_precio > v_compra.prc_compra then
    --
    -- En caso de que el precio registrado sea mayor al del movimiento
    -- almacenaremos el obtenido en la select de AL_COMPRAS_MERCADERIA
    --
         v_precio1 := v_precio;
      else
         v_precio1 := v_compra.prc_compra;
      end if;
      update al_compras_mercaderia
             set prc_compra = v_precio1,
                 can_stock  = can_stock + v_compra.can_stock
           where rowid = v_rowid;
    EXCEPTION
       when NO_DATA_FOUND then
               insert into al_compras_mercaderia (cod_articulo,
                                               mes_compra,
                                               prc_compra,
                                               can_stock,
											   cod_operadora_scl)
                                       values (v_compra.cod_articulo,
                                               v_compra.mes_compra,
                                               v_compra.prc_compra,
                                               v_compra.can_stock,
											   v_operadora);
      when OTHERS then
           v_error := 1;
           v_mensa := '/Error Compras/';
    END p_entrada_compra;
  --
  -- Retrofitted
  PROCEDURE p_salida_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_cantidad IN al_pmp_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
        v_cont NUMBER := 0;
    BEGIN
		      v_error := 0;
          select count(1) into v_cont
                from al_pmp_mercaderia
                where cod_articulo = v_articulo
                and can_stock>0
          and fec_ejercicio = v_ini_ejer;
          if v_cont = 0 then
                raise exception_error;
          end if;
          update al_pmp_mercaderia
              set can_stock = can_stock - v_cantidad
              where cod_articulo = v_articulo
                and fec_ejercicio = v_ini_ejer;
    EXCEPTION
     when EXCEPTION_ERROR then
                     v_error := 1;
            v_mensa := '/Error Salida Mercaderia/';
        when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida Mercaderia/';
    END p_salida_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_salida_compra_ns(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
       CURSOR c_compras is
              select can_stock from al_compras_mercaderia
                     where cod_articulo = v_articulo
                     order by cod_articulo,mes_compra
                     for update of can_stock;
       v_c_compras c_compras%rowtype;
       v_cant al_compras_mercaderia.can_stock%type;
          v_cont al_compras_mercaderia.can_stock%type;
    BEGIN
			    v_error := 0;
          v_cant := v_cantidad;
          select NVL(sum(can_stock),0) into v_cont
                from al_compras_mercaderia
          where cod_articulo = v_articulo;
          if v_cont < v_cant then
                raise exception_error;
          end if;
          open c_compras;
          LOOP
               fetch c_compras into v_c_compras;
                      EXIT when c_compras%NOTFOUND;
  if v_c_compras.can_stock <= v_cant then
                       v_cant := v_cant - v_c_compras.can_stock;
                  delete al_compras_mercaderia where current of c_compras;
               else
                  update al_compras_mercaderia
   set can_stock = can_stock - v_cant
                     where current of c_compras;
                  exit;
               end if;
       end loop;
          close c_compras;
    EXCEPTION
          when EXCEPTION_ERROR then
                 v_error := 1;
                 v_mensa := '/Error Salida Compras/';
          when OTHERS then
          if c_compras%ISOPEN then close c_compras;
end if;
             v_error := 1;
                 v_mensa := '/Error Salida Compras/';
    END p_salida_compra_ns;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_s(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    v_cont NUMBER :=0;
    BEGIN
			  v_error := 0;
        select count(1) into v_cont from al_pmp_afijo
		where num_serie = v_serie
                and fec_finafijo is null;
        if v_cont = 0 then
                raise exception_error;
        end if;
	update al_pmp_afijo set fec_finafijo = v_fecha
               	where num_serie = v_serie
          	and fec_finafijo is null
	and fec_afijo = (select min(fec_afijo)
        	from al_pmp_afijo
		where num_serie = v_serie
          	and fec_finafijo is null);
    EXCEPTION
          when EXCEPTION_ERROR then
                  v_error := 1;
            v_mensa := '/Error Salida A.Fijo/';
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida A.Fijo/';
    END p_salida_afijo_s;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_ns(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
        v_cont NUMBER :=0;
     BEGIN
		   	  v_error := 0;
          select count(1) into v_cont from al_pmp_afijo
            where cod_articulo = v_articulo
         and fec_finafijo is null
         and fec_afijo = (select min(fec_afijo)
                          from al_pmp_afijo
                          where cod_articulo = v_articulo
                          and fec_finafijo is null);
          if v_cont = 0 then raise exception_error;
end if;
       update al_pmp_afijo set fec_finafijo = v_fecha
              where cod_articulo = v_articulo
                and fec_finafijo is null
                and fec_afijo = (select min(fec_afijo)
                                   from al_pmp_afijo
                                   where cod_articulo = v_articulo
                                     and fec_finafijo is null);
    EXCEPTION
          when EXCEPTION_ERROR then
                  v_error := 1;
            v_mensa := '/Error Salida A.Fijo /';
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Salida A.Fijo /';
    END p_salida_afijo_ns;
  --
  -- Retrofitted
  PROCEDURE p_valor_afijo(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fec_movimiento IN al_pmp_afijo.fec_afijo%type ,
  v_fecafijo IN OUT al_pmp_afijo.fec_afijo%type ,
  v_compra IN OUT al_pmp_afijo.prc_compra%type ,
  v_precio IN OUT al_pmp_afijo.prc_actual%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
			v_error := 0;
   select prc_compra,prc_actual,fec_afijo
   into   v_compra,v_precio,v_fecafijo
   from   al_pmp_afijo
   where  num_serie    = v_serie
   and    fec_afijo    < v_fec_movimiento
   and    fec_finafijo is null
   and    num_activo    = (SELECT MAX(num_activo)
                          from   al_pmp_afijo
			              where  num_serie    = v_serie
				          and    fec_afijo    < v_fec_movimiento
                          and    fec_finafijo is null);
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Lectura Activo Fijo/';
    end p_valor_afijo;
  --
  -- Retrofitted
  PROCEDURE p_valor_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_pmp IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
    BEGIN
			 v_error := 0;
       select prc_pmp into v_pmp
              from al_pmp_mercaderia
              where cod_articulo  = v_articulo
                and fec_ejercicio = v_ini_ejer;
    EXCEPTION
       when OTHERS then
            v_error := 1;
            v_mensa := '/Error Lectura Coste Promedio/';
    END p_valor_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_afijo_mercaderia(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_cantidad IN al_movimientos.num_cantidad%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_fec_movim IN al_pdte_calculo.fec_movimiento%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora ge_operadora_scl.cod_operadora_scl%type)
  IS
      CURSOR c_afijo IS
             select * from al_pmp_afijo
                    where cod_articulo = v_articulo
                      and fec_finafijo is null
                      for update of fec_finafijo;
      v_afijo al_pmp_afijo%rowtype;
      v_mercaderia   al_pmp_mercaderia%rowtype;
      v_compra       al_compras_mercaderia%rowtype;
    BEGIN
		  v_error := 0;
      open c_afijo;
      for v_veces in 1..v_cantidad loop
          fetch c_afijo into v_afijo;
          exit when c_afijo%NOTFOUND;
          v_compra.cod_articulo := v_articulo;
          v_compra.mes_compra   := trunc(v_afijo.fec_afijo,'MONTH');
          v_compra.prc_compra   := v_afijo.prc_compra;
          v_compra.can_stock    := 1;
          p_entrada_compra (v_compra,v_error,v_mensa, v_operadora);
          if v_error <> 0 then
             raise exception_error;
          end if;
          v_mercaderia.cod_articulo    := v_articulo;
          v_mercaderia.fec_ejercicio   := v_ini_ejer;
          v_mercaderia.can_stock       := 1;
          v_mercaderia.prc_pmp         := v_afijo.prc_actual;
          p_entrada_mercaderia (v_mercaderia,v_error,v_mensa,v_decim, v_operadora);
          if v_error <> 0 then
             raise exception_error;
          end if;
                update al_pmp_afijo
             set fec_finafijo = v_fec_movim
             where current of c_afijo;
       end loop;
       close c_afijo;
    EXCEPTION
       when EXCEPTION_ERROR then
            if c_afijo%ISOPEN then
               close c_afijo;
            end if;
       when OTHERS then
            if c_afijo%ISOPEN then
               close c_afijo;
            end if;
            v_error := 1;
            v_mensa := '/Error paso a A.Fijo/';
    END p_afijo_mercaderia;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_prc_pmp(
  v_cod_articulo IN al_pmp_mercaderia.cod_articulo%type,
  v_prc_pmp IN OUT al_pmp_mercaderia.prc_pmp%type,
  v_error IN OUT al_intercierre.cod_retorno%type,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
     BEGIN
		    	v_error := 0;
        select prc_pmp into v_prc_pmp from al_pmp_mercaderia
                where fec_ejercicio = (select max(fec_ejercicio) from al_pmp_mercaderia where
           cod_articulo=v_cod_articulo)
                        and cod_articulo=v_cod_articulo;
          EXCEPTION
             when OTHERS then
                        v_error := 1;
                  v_mensa := '/Error Obtencion Precio PMP/';
         END p_obtiene_prc_pmp;
  --
  -- Retrofitted
  PROCEDURE p_bloqueo_tablas_pmp(
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
  IS
  BEGIN
	   	v_error := 0;
     LOCK TABLE al_pmp_mercaderia
     IN EXCLUSIVE MODE NOWAIT;
     LOCK TABLE al_compras_mercaderia
     IN EXCLUSIVE MODE NOWAIT;
     EXCEPTION
             when OTHERS then
                  v_error := 1;
               v_mensa := '/Error Bloqueo Tablas/';
  END p_bloqueo_tablas_pmp;
  --
  -- Retrofitted
  PROCEDURE p_guarda_error(
  v_pdte  IN al_pdte_calculo%rowtype ,
  v_error IN al_intercierre.cod_retorno%type ,
  v_mensa IN al_intercierre.des_cadena%type )
  IS
     v_texto al_intercierre.des_cadena%type;
        BEGIN
          v_texto := USER || '|' || to_char(SYSDATE,'DD-MM-YY HH24:MI') || '|'
                           || to_char(v_pdte.num_movimiento) || '|' || v_mensa;
          insert into al_intercierre (num_cierre,cod_retorno,des_cadena)
                values (al_seq_cierre.nextval,v_error,v_texto);
    EXCEPTION
       when OTHERS then
                raise_application_error (-20001,'Error escribiendo Intercierre:'
                                                                  || to_char(SQLCODE));
  END p_guarda_error;
  --
  -- Retrofitted
  PROCEDURE p_borra_errores
  IS
     BEGIN
          delete AL_INTERCIERRE;
     EXCEPTION
       when OTHERS then
                raise_application_error (-20001,'Error Borrando Intercierres:'
                                                                  || to_char(SQLCODE));
  END p_borra_errores;
  PROCEDURE p_traza_procedimiento(p_des_cadena in Varchar2) IS
  BEGIN
  -- La idea es grabar en la tabla al_intercierre las trazas del procedimiento
  -- r.l.m 17/10/2003}
            insert into al_intercierre (num_cierre,cod_retorno,des_cadena)
                values (al_seq_cierre.nextval ,1,p_des_cadena);
    EXCEPTION
       when OTHERS then
                raise_application_error (-20001,'Error escribiendo Intercierre:'|| to_char(SQLCODE));
  END p_Traza_procedimiento;
  PROCEDURE p_compacta(v_dia_inicio_pdte IN DATE, v_dia_fin_pdte IN DATE,
		       v_error IN OUT al_intercierre.cod_retorno%TYPE)
  IS
	-- este PL agrupa los pendientes para agilizar el proceso de cierre, solo para seriados,
	-- y solo para entradas y salidas, NO traspasos. Ademas solo si hay mas de un registro
	-- del tipo por articulo
	-- Hay cuatro grandes grupos que podemos limpiar (y solo para mercaderia ,para activo
	-- fijo se considera la serie) :
	-- 1-Entradas con precio y moneda
	-- 2-Entradas con precio sin moneda (asume peso)
	-- 3-Salidas sin precio
	-- 4-Salidas con precio (son una 'irregularidad' del reingreso)
	CURSOR c_c_pdte_sal  IS -- 3-
		SELECT cod_articulo,ind_entsal,ind_valor_ori,prc_unidad,cod_moneda,ind_valor_des,sum(num_cantidad) cantidad, COUNT(*)
		FROM al_pdte_calculo a
		WHERE fec_movimiento BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
		AND ind_entsal = 'S'
		AND ind_valor_ori = 1
		AND prc_unidad IS NULL
		AND cod_moneda IS NULL
		AND ind_valor_des IS NULL
		AND num_serie IS NOT NULL
		AND num_cantidad = 1
		AND num_movimiento > -1
		GROUP BY cod_articulo,ind_entsal,ind_valor_ori,prc_unidad,cod_moneda,ind_valor_des
		HAVING count(*) > 1;
	CURSOR c_c_pdte_sal_prc  IS -- 4-
		SELECT cod_articulo,ind_entsal,ind_valor_ori,prc_unidad,cod_moneda,ind_valor_des,sum(num_cantidad) cantidad, COUNT(*)
		FROM al_pdte_calculo a
		WHERE fec_movimiento BETWEEN v_dia_inicio_pdte AND v_dia_fin_pdte
		AND ind_entsal = 'S'
		AND ind_valor_ori = 1
		AND prc_unidad IS NOT NULL
		AND cod_moneda IS NULL
		AND ind_valor_des IS NULL
		AND num_serie IS NOT NULL
		AND num_cantidad = 1
		AND num_movimiento > -1
		GROUP BY cod_articulo,ind_entsal,ind_valor_ori,prc_unidad,cod_moneda,ind_valor_des
		HAVING count(*) > 1;
	cursor c_c_pdte_ent  is -- 1-
		select COD_ARTICULO,IND_ENTSAL,IND_VALOR_ORI,
		PRC_UNIDAD,COD_MONEDA,IND_VALOR_DES,sum(NUM_CANTIDAD) cantidad, count(*)
		from al_pdte_calculo a where
		fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
		and ind_entsal = 'E'
		and ind_valor_ori = 1
		and prc_unidad is not null
		and cod_moneda is not null
		and ind_valor_des is null
		and num_serie is not null
		and num_cantidad = 1
		and num_movimiento > -1
		group by COD_ARTICULO,IND_ENTSAL,IND_VALOR_ORI,
		PRC_UNIDAD,COD_MONEDA,IND_VALOR_DES
		having count(*) > 1;
	cursor c_c_pdte_ent_mon  is -- 2-
		select COD_ARTICULO,IND_ENTSAL,IND_VALOR_ORI,
		PRC_UNIDAD,COD_MONEDA,IND_VALOR_DES,sum(NUM_CANTIDAD) cantidad, count(*)
		from al_pdte_calculo a where
		fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
		and ind_entsal = 'E'
		and ind_valor_ori = 1
		and prc_unidad is not null
		and cod_moneda is null
		and ind_valor_des is null
		and num_serie is not null
		and num_cantidad = 1
		and num_movimiento > -1
		group by COD_ARTICULO,IND_ENTSAL,IND_VALOR_ORI,
		PRC_UNIDAD,COD_MONEDA,IND_VALOR_DES
		having count(*) > 1;
     BEGIN
     v_error := 0;
	     	for v_c_pdte in c_c_pdte_sal loop
			insert into al_pdte_calculo (
				COD_ARTICULO  ,NUM_MOVIMIENTO,FEC_MOVIMIENTO,IND_ENTSAL    ,IND_VALOR_ORI ,
				NUM_CANTIDAD  ,PRC_UNIDAD    ,COD_MONEDA    ,NUM_SERIE     ,IND_VALOR_DES )
				values (
				v_c_pdte.cod_articulo,al_seq_mvto.nextval,v_dia_inicio_pdte,v_c_pdte.ind_entsal,v_c_pdte.ind_valor_ori,
				v_c_pdte.cantidad,NULL,NULL,NULL,NULL);
			delete al_pdte_calculo where
				COD_ARTICULO = v_c_pdte.cod_articulo and IND_ENTSAL = v_c_pdte.ind_entsal
				and IND_VALOR_ORI =v_c_pdte.ind_valor_ori and NUM_CANTIDAD =1
				and PRC_UNIDAD IS NULL and COD_MONEDA IS NULL
				and num_serie is not null and num_movimiento > 0
				and fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
				and IND_VALOR_DES IS NULL and rownum < v_c_pdte.cantidad + 1;
	        end LOOP;
	     	for v_c_pdte in c_c_pdte_sal_prc loop
			insert into al_pdte_calculo (
				COD_ARTICULO  ,NUM_MOVIMIENTO,FEC_MOVIMIENTO,IND_ENTSAL    ,IND_VALOR_ORI ,
				NUM_CANTIDAD  ,PRC_UNIDAD    ,COD_MONEDA    ,NUM_SERIE     ,IND_VALOR_DES )
				values (
				v_c_pdte.cod_articulo,al_seq_mvto.nextval,v_dia_inicio_pdte,v_c_pdte.ind_entsal,v_c_pdte.ind_valor_ori,
				v_c_pdte.cantidad,v_c_pdte.prc_unidad,NULL,NULL,NULL);
			delete al_pdte_calculo where
				COD_ARTICULO = v_c_pdte.cod_articulo and IND_ENTSAL = v_c_pdte.ind_entsal
				and IND_VALOR_ORI =v_c_pdte.ind_valor_ori and NUM_CANTIDAD =1
				and PRC_UNIDAD = v_c_pdte.prc_unidad and COD_MONEDA IS NULL
				and num_serie is not null and num_movimiento > 0
				and fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
				and IND_VALOR_DES IS NULL and rownum < v_c_pdte.cantidad + 1;
	        end LOOP;
	     	for v_c_pdte in c_c_pdte_ent loop
			insert into al_pdte_calculo (
				COD_ARTICULO  ,NUM_MOVIMIENTO,FEC_MOVIMIENTO,IND_ENTSAL    ,IND_VALOR_ORI ,
				NUM_CANTIDAD  ,PRC_UNIDAD    ,COD_MONEDA    ,NUM_SERIE     ,IND_VALOR_DES )
				values (
				v_c_pdte.cod_articulo,al_seq_mvto.nextval,v_dia_inicio_pdte,v_c_pdte.ind_entsal,v_c_pdte.ind_valor_ori,
				v_c_pdte.cantidad,v_c_pdte.prc_unidad,v_c_pdte.cod_moneda,NULL,NULL);
			delete al_pdte_calculo where
				COD_ARTICULO = v_c_pdte.cod_articulo and IND_ENTSAL = v_c_pdte.ind_entsal
				and IND_VALOR_ORI =v_c_pdte.ind_valor_ori and NUM_CANTIDAD =1
				and PRC_UNIDAD = v_c_pdte.prc_unidad and COD_MONEDA = v_c_pdte.cod_moneda
				and num_serie is not null and num_movimiento > 0
				and fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
				and IND_VALOR_DES IS NULL and rownum < v_c_pdte.cantidad + 1;
	        end LOOP;
		for v_c_pdte in c_c_pdte_ent_mon loop
			insert into al_pdte_calculo (
				COD_ARTICULO  ,NUM_MOVIMIENTO,FEC_MOVIMIENTO,IND_ENTSAL    ,IND_VALOR_ORI ,
				NUM_CANTIDAD  ,PRC_UNIDAD    ,COD_MONEDA    ,NUM_SERIE     ,IND_VALOR_DES )
				values (
				v_c_pdte.cod_articulo,al_seq_mvto.nextval,v_dia_inicio_pdte,v_c_pdte.ind_entsal,v_c_pdte.ind_valor_ori,
				v_c_pdte.cantidad,v_c_pdte.prc_unidad,NULL,NULL,NULL);
			delete al_pdte_calculo where
				COD_ARTICULO = v_c_pdte.cod_articulo and IND_ENTSAL = v_c_pdte.ind_entsal
				and IND_VALOR_ORI =v_c_pdte.ind_valor_ori and NUM_CANTIDAD =1
				and PRC_UNIDAD = v_c_pdte.prc_unidad and COD_MONEDA IS NULL
				and num_serie is not null and num_movimiento > 0
				and fec_movimiento between v_dia_inicio_pdte and v_dia_fin_pdte
				and IND_VALOR_DES IS NULL and rownum < v_c_pdte.cantidad + 1;
	        end LOOP;
     EXCEPTION
       when OTHERS then
       	v_error := 1;
  END p_compacta;
  PROCEDURE p_act_mov_rezagados(v_dia_inicio_pdte IN     al_pmp_mercaderia.fec_ejercicio%type,
                        v_error    IN OUT al_intercierre.cod_retorno%type)
    	IS
  BEGIN
	v_error := 0;

	UPDATE al_pdte_calculo
	SET    fec_movimiento = v_dia_inicio_pdte + 24/3600/600
	WHERE  fec_movimiento < v_dia_inicio_pdte;

	EXCEPTION WHEN OTHERS then
			  v_error := 1;
  END p_act_mov_rezagados;
END AL_PAC_MERCADERIA;
/
SHOW ERRORS
