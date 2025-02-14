CREATE OR REPLACE PROCEDURE AL_NUMERA_MASIVA_PR(p_orden al_cab_numeracion.num_numeracion%type,
                                                p_numero_linea al_lin_numeracion.lin_numeracion%type,
                                                p_subalm al_ser_numeracion.cod_subalm%type,
                                                p_central al_ser_numeracion.cod_central%type,
                                                p_cat al_ser_numeracion.cod_cat%type,
                                                p_plan al_ser_numeracion.plan%type,
                                                p_carga al_ser_numeracion.carga%type)
IS
v_terminalGSM       al_articulos.tip_terminal%type;
v_estadoReserva     al_series.cod_estado%type;
v_estadoTemporal    al_series.cod_estado%type;
v_estadoTransito    al_series.cod_estado%type;
v_estadoReservaVta  al_series.cod_estado%type;
v_uso               al_lin_numeracion.cod_uso%type;
v_numeracion        al_ser_numeracion.ind_numerado%type;
v_stock             al_lin_numeracion.tip_stock%type;
v_cantnum           al_lin_numeracion.can_numera%type;
v_bodega            al_cab_numeracion.cod_bodega%type;
v_estado            al_lin_numeracion.cod_estado%type;
v_articulo          al_lin_numeracion.cod_articulo%type;
v_telefono          al_ser_numeracion.num_telefono%type;
v_num_asig          al_ser_numeracion.num_telefono%type;
v_serie             al_ser_numeracion.num_serie%type;
v_terminal          al_articulos.tip_terminal%type;
v_hlr               icg_central.cod_hlr%type;
v_hlr_aux           icg_central.cod_hlr%type;
v_ind               al_numeracion_masiva_to.ind_serie%type;
v_serieBuenas       al_lin_numeracion.can_numera%type;
v_nrosSistema       al_lin_numeracion.can_numera%type;
v_seriesNumeradas   al_lin_numeracion.can_numera%type;
v_producto          al_ser_numeracion.cod_producto%type;
v_serie_dec 		al_ser_numeracion.num_serie%type;
v_serie_hexa 		al_ser_numeracion.num_serhex%type;
EXITOSO   EXCEPTION;

CURSOR c_validaseries(p_orden al_cab_numeracion.num_numeracion%type, p_linea al_lin_numeracion.lin_numeracion%type)
IS
		SELECT num_numeracion, num_serie
		FROM al_numeracion_masiva_to
		WHERE num_numeracion=p_orden
		AND lin_numeracion =p_linea
;

v_validaseries      c_validaseries%ROWTYPE;
v_valida            PLS_INTEGER;
v_validaSer         al_ser_numeracion.num_serie%type;
v_error             PLS_INTEGER;
v_error_msg         VARCHAR(150);
sEstado             VARCHAR(2);
v_err               PLS_INTEGER;
v_cant              PLS_INTEGER;
v_ind_serie         al_numeracion_masiva_to.ind_serie%type;

BEGIN
   	 v_producto := 1;
	 v_error:=0;
     sEstado:='NU';
     v_ind:=0;

     SELECT val_parametro
     INTO v_terminalGSM
     FROM ged_parametros
     WHERE cod_modulo='AL'
       AND cod_producto=1
       AND nom_parametro='COD_SIMCARD_GSM';

     SELECT cod_estado_res, cod_estado_tem, cod_estado_tra, cod_estado_rvt
     INTO v_estadoReserva, v_estadoTemporal, v_estadoTransito, v_estadoReservaVta
     FROM al_datos_generales;

     BEGIN
        --Datos asociados a la Orden de Numeracion
        SELECT a.cod_bodega, a.tip_numeracion, b.cod_estado, b.cod_articulo,
               b.cod_uso, b.tip_stock, b.can_numera
        INTO v_bodega, v_numeracion, v_estado, v_articulo,
             v_uso,  v_stock, v_cantnum
        FROM al_cab_numeracion a, al_lin_numeracion b
        WHERE a.num_numeracion =p_orden
           AND a.num_numeracion=b.num_numeracion
           AND b.lin_numeracion=p_numero_linea;

        EXCEPTION
            WHEN no_data_found THEN
                v_error:=1;
                v_error_msg:= 'Revise Orden de Numeracion nro: '||to_char(p_orden) ||' No se encontro Orden o linea de numeracion ' ;
                raise_application_error (-20155,v_error_msg);
            END;

        IF v_error = 0 THEN
            --Valido Existencia de Numeros suficientes
            v_nrosSistema:=0;

            SELECT count(1)
            INTO v_nrosSistema
            FROM al_celnum_reutil
            WHERE cod_subalm   = p_subalm
              AND cod_uso      IN (v_uso, ge_fn_uso_sin_uso)
              AND cod_central  = p_central
              AND cod_cat      = p_cat
              AND (fec_baja + ge_fn_dias_hibernacion(cod_uso) <= TRUNC(SYSDATE)
                                OR ge_fn_dias_hibernacion(cod_uso) = 0)
               AND ind_equipado = 1;

         IF (v_nrosSistema > 0  AND v_nrosSistema >= v_cantnum)  THEN
			SELECT tip_terminal
			INTO v_terminal
			FROM al_articulos
			WHERE cod_articulo=v_articulo;

            v_hlr:=null;

            IF v_terminalGSM= v_terminal THEN
			   SELECT cod_hlr
			   INTO v_hlr
			   FROM icg_central
			   WHERE cod_central = p_central;
	        END IF;

            v_serieBuenas:=0;

            --Validacion de todas las series cargadas
            OPEN c_validaseries(p_orden, p_numero_linea);
            LOOP
            FETCH c_validaseries INTO v_validaseries;
            EXIT WHEN c_validaseries%NOTFOUND;
            v_ind:=0; --Inicializo indicador de serie valida
            BEGIN
                 v_serie:=v_validaseries.num_serie;
                 IF (v_terminalGSM = v_terminal AND v_hlr is not null) THEN
                    SELECT a.num_serie
                    INTO v_validaSer
                    FROM al_series a
                    WHERE a.num_serie = v_serie
                      AND a.cod_articulo    = v_articulo
                      AND a.cod_bodega =v_bodega
                      AND a.tip_stock = v_stock
                      AND a.cod_uso = v_uso
                      AND a.cod_estado   =v_estado
                      AND a.cod_hlr   = v_hlr
                      AND a.cod_estado not in (v_estadoReserva , v_estadoTemporal, v_estadoTransito,v_estadoReservaVta)
                      AND a.ind_telefono <> 8
                      AND NOT EXISTS (
                                      SELECT d.num_serie
                                      FROM al_ser_numeracion d, al_lin_numeracion b, al_cab_numeracion c
                                      WHERE d.num_numeracion = b.num_numeracion
                                        AND d.lin_numeracion = b.lin_numeracion
                                        AND d.num_serie = a.num_serie
                                        AND c.num_numeracion = d.num_numeracion
                                        AND c.cod_estado = 'NU')
                                        AND a.num_telefono is null;
                 ELSE
                    SELECT a.num_serie
                    INTO v_validaSer
                    FROM al_series a
                    WHERE a.num_serie = v_serie
                      AND a.cod_articulo = v_articulo
                      AND a.cod_bodega =v_bodega
                      AND a.tip_stock = v_stock
                      AND a.cod_uso = v_uso
                      AND a.cod_estado = v_estado
                      AND a.cod_estado not in (v_estadoReserva , v_estadoTemporal, v_estadoTransito,v_estadoReservaVta)
                      AND a.ind_telefono <> 8
                      AND NOT EXISTS (
                                      SELECT d.num_serie
                                      FROM al_ser_numeracion d, al_lin_numeracion b, al_cab_numeracion c
                                      WHERE d.num_numeracion = b.num_numeracion
                                        AND d.lin_numeracion = b.lin_numeracion
                                        AND d.num_serie = a.num_serie
                                        AND c.num_numeracion = d.num_numeracion
                                        AND c.cod_estado = 'NU')
                                        AND a.num_telefono is null;
                 END IF;

            EXCEPTION
                WHEN no_data_found THEN
                        v_ind:=1; --No existe serie para las condiciones dadas mas arriba
            END;

            IF v_ind = 1 THEN
               --Determinar cual es el error
               IF (v_terminalGSM = v_terminal AND v_hlr is not null) THEN
                  v_hlr_aux := v_hlr;
               ELSE
                  v_hlr_aux := NULL;
               END IF;
               AL_det_Error_PR(v_serie,v_articulo,v_bodega,v_stock,v_uso,v_estado,v_hlr_aux,v_estadoReserva,v_estadoTemporal,v_estadoTransito,v_estadoReservaVta,v_ind_serie);

               UPDATE al_numeracion_masiva_to
               SET ind_serie=v_ind_serie
               WHERE num_numeracion=p_orden
                 AND lin_numeracion = p_numero_linea
                 AND num_serie=v_validaseries.num_serie;

			  --SE CONFIRMA TRNSACCION PARA PODER VER SERIE ERRORNEA
              COMMIT;

			  v_error:=3;
              raise EXITOSO;

			ELSE
              UPDATE al_numeracion_masiva_to
              SET ind_serie=1
              WHERE num_numeracion=p_orden
                AND lin_numeracion = p_numero_linea
                AND num_serie=v_validaseries.num_serie;

                v_serieBuenas:=v_serieBuenas + 1;
            END IF;

            END LOOP;
            CLOSE c_validaseries;

            IF v_serieBuenas > 0 THEN
               --Insercion de series validadadas en al_ser_numeracion

 			   IF (v_terminal = v_terminalGSM) then
						-- GSM
	              INSERT INTO al_ser_numeracion(num_serie,num_serhex,num_numeracion,lin_numeracion,ind_numerado,cod_producto,num_telefono,cod_central,cod_subalm,cod_cat,carga,plan)
	              SELECT num_serie,'0',num_numeracion,p_numero_linea,v_numeracion,v_producto,null,p_central,p_subalm,p_cat,p_carga,p_plan
	              FROM al_numeracion_masiva_to
	              WHERE num_numeracion=p_orden
	                AND lin_numeracion=p_numero_linea
	                AND ind_serie=1;
			   ELSE
	              INSERT INTO al_ser_numeracion(num_serie,num_serhex,num_numeracion,lin_numeracion,ind_numerado,cod_producto,num_telefono,cod_central,cod_subalm,cod_cat,carga,plan)
	              SELECT num_serie,al_conv_serhex_fn(num_serie),num_numeracion,p_numero_linea,v_numeracion,v_producto,null,p_central,p_subalm,p_cat,p_carga,p_plan
				  FROM al_numeracion_masiva_to
	              WHERE num_numeracion=p_orden
	                AND lin_numeracion=p_numero_linea
	                AND ind_serie=1;
			   END IF;

               --Actualizacion cantidad de series en al_lin_numeracion
               IF v_serieBuenas <> v_cantnum THEN
                 UPDATE al_lin_numeracion
                 SET can_numera=v_serieBuenas + 1
                 WHERE num_numeracion=p_orden
                 AND lin_numeracion=1;
               END IF;

               --Entro al Proceso de Numeracion
               v_err:=0;
               v_cant:=v_serieBuenas;

               AL_asigna_numero_PR(p_orden,p_numero_linea,p_subalm,p_central,v_uso,v_cant,p_cat,v_err);

               IF v_err <> 0 THEN
                 v_error_msg:= 'Error al_pac_numeracion.p_asigna_numero_ordenes.'||' Orden:'||to_char(p_orden)||' SubAlm:'||p_subalm||' Central:'||to_char(p_central)||' Uso:'||to_char(v_uso)||' Categoria:'||to_char(p_cat) ;
                 raise_application_error (-20100,v_error_msg);
               END IF;
            END IF;
         ELSE
            v_error:=2;
            v_error_msg:= 'No hay Suficientes Numeros.Se requieren: '|| to_char(v_nrosSistema) ||' y hay : '|| to_char(v_cantnum) ;
            raise_application_error (-20100,v_error_msg);
         END IF;
        END IF;

EXCEPTION
	WHEN EXITOSO THEN
		return;
    WHEN OTHERS THEN
		raise_application_error (-20100,to_char(SQLCODE)||' - '||SQLERRM);

END;
/
SHOW ERRORS
