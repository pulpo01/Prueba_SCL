CREATE OR REPLACE procedure P_DEL_RESTITUCION(
V_PRODUCTO IN GA_ABOCEL.COD_PRODUCTO%TYPE,
VP_ERROR OUT VARCHAR2)
IS
   v_serie_nue          	ga_abocel.num_serie%TYPE;
   v_terminal_nue       	ga_abocel.tip_terminal%TYPE;
   v_cliente            	ga_abocel.cod_cliente%TYPE;
   v_central            	ga_abocel.cod_central%TYPE;
   v_estado             	al_series.cod_estado%TYPE;
   v_fila_reserva       	ROWID;
   v_fec_cambio         	ga_equipaboser.fec_alta%TYPE;
   v_ind_procequi       	ga_equipaboser.ind_procequi%TYPE;
   v_fila_equipaboser   	ROWID;
   v_fila_modabocel     	ROWID;
   v_serie_ant          	ga_abocel.num_serie%TYPE;
   v_terminal_ant       	ga_abocel.tip_terminal%TYPE;
   v_venta              	ga_ventas.num_venta%TYPE;
   v_fila_venta         	ROWID;
   v_transaccion        	ga_transacabo.num_transaccion%TYPE;
   vp_tabla             	VARCHAR2 (30);
   vp_proc              	VARCHAR2 (30);
   vp_act               	VARCHAR2 (2);
   v_abonado            	ga_abocel.num_abonado%TYPE;
   vp_estado            	icc_movimiento.cod_estado%TYPE;
   v_movimiento         	icc_movimiento.num_movimiento%TYPE;
   v_celular            	ga_abocel.num_celular%TYPE;
   filas_equipos        	NUMBER (5);
   v_serie              	ga_abocel.num_serie%TYPE;
   v_tip_terminal       	ga_abocel.tip_terminal%TYPE;
   v_cod_central        	ga_abocel.cod_central%TYPE;
   v_serie_hex_ant      	ga_abocel.num_seriehex%TYPE;
   v_serie_hex_nue      	ga_abocel.num_seriehex%TYPE;
   v_sql_errm           	VARCHAR2 (60);
   v_sqlcode            	VARCHAR2 (60);
   v_fec_alta           	ga_abocel.fec_alta%TYPE;
   v_eqprestado         	ga_abocel.ind_eqprestado%TYPE;
   error_proceso        	EXCEPTION;

   v_imei_nue           	ga_abocel.num_imei%TYPE;
   v_imei_ant           	ga_abocel.num_imei%TYPE;
   v_filas_ant_equ      	NUMBER(1);
   v_filas_nue_equ      	NUMBER(1);
   v_tecnologia_tdma    	ged_parametros.val_parametro%TYPE;
   v_tecnologia_gsm     	ged_parametros.val_parametro%TYPE;
   v_actcen             	ga_actabo.cod_actcen%TYPE;
   v_imsi_nue           	icc_movimiento.imsi_nue%TYPE;
   v_imsi_ant           	icc_movimiento.IMSI%TYPE;
   v_tecnologia_nue     	ged_parametros.val_parametro%TYPE;
   v_tecnologia_ant     	ged_parametros.val_parametro%TYPE;
   v_tecnologia_ori     	ged_parametros.val_parametro%TYPE;
   v_tecnologia         	ged_parametros.val_parametro%TYPE;
   v_codcentral_ori     	ga_celnum_uso.cod_central%TYPE;
   v_actabo             	ga_actabo.cod_actabo%TYPE;
   v_icc_nue            	icc_movimiento.icc_nue%TYPE;
   v_icc_ant            	icc_movimiento.icc%TYPE;
   v_serie_icc          	icc_movimiento.num_serie%TYPE;
   v_serie_nue_icc      	icc_movimiento.num_serie_nue%TYPE;

   --PAGC--
   v_serie_nue_desh             al_series.num_serie%type;
   v_serie_ant_desh             al_series.num_serie%type;
   --FIN--
   v_numtransacabo              ga_transacabo.NUM_TRANSACCION%TYPE;
   gMovRetResVenta              varchar2(1):= '5';
   gMovRetSalTemArr     	varchar2(1) := '7';
   sEstadoNuevo                 varchar2(3);
   sTipStockMercad              varchar2(1);
   v_al_movim                   al_movimientos.NUM_MOVIMIENTO%type;
   v_bodega_ori                 al_series.COD_BODEGA%type;
   v_bodega_dest                al_series.COD_BODEGA%type;
   v_estado_ori                 al_series.cod_estado%type;
   v_estado_dest                al_series.cod_estado%type;
   v_tipstock_ori               al_series.TIP_STOCK%type;
   v_tipstock_dest              al_series.tip_stock%type;
   v_articulo                   al_series.COD_ARTICULO%type;
   v_uso                        al_series.cod_uso%type;
   v_num_simcard                ga_abocel.NUM_SERIE%type;
   v_CodEstRevision             varchar2(3);
   v_CodBodComodato             varchar2(20);
   error                        varchar2(2);
   v_indprocequi_aboser 	ga_equipaboser.IND_PROCEQUI%type;
   ind_eqprestado_modabo 	ga_modabocel.IND_EQPRESTADO%type;
   fec_prorroga_modabo   	ga_modabocel.FEC_PRORROGA%type;
   cod_central_modabo    	ga_modabocel.COD_CENTRAL%type;
   cod_planserv_modabo   	ga_modabocel.COD_PLANSERV%type;
   sFORMATO_SEL2                ged_parametros.VAL_PARAMETRO%type;
   v_siniestro                  ga_siniestros.NUM_SINIESTRO%type;
   v_causa_sinies               ga_siniestros.COD_CAUSA%type;
   v_cod_servicio               ga_susprehabo.cod_servicio%type;
   v_NumMin                     icc_movimiento.NUM_MIN%type;
   v_fec_mod_modabo             ga_modabocel.FEC_MODIFICA%type;
   v_contrato_contcta    	ga_CONTCTA.NUM_CONTRATO%type;
   v_tipcontrato_contcta 	ga_CONTCTA.cod_tipcontrato%type;
   v_anexo_contcta              ga_CONTCTA.num_anexo%type;
   v_fec_contcta                ga_CONTCTA.fec_contrato%type;
   v_cuenta                     ga_abocel.cod_cuenta%type;
   v_tipcontrato                ga_abocel.cod_tipcontrato%type;
   v_contrato                   ga_abocel.num_contrato%type;
   v_anexo                      ga_abocel.num_anexo%type;
   v_fila_contcta               rowid;
   VP_ERROR_INTAR          	VARCHAR2(5);
   VP_CADENA_INTAR         	VARCHAR2(100);
   v_serv_tec                   ga_abocel.ind_disp%type;
   v_fec_fincont_modabocel 	ga_modabocel.FEC_FINCONTRATO%type;
   v_cod_retorno		ga_transacabo.COD_RETORNO%type;
   v_des_cadena			ga_transacabo.DES_CADENA%type;
   bHayCargos			boolean;
   v_fec_cargos			ge_cargos.FEC_ALTA%type;
   --TMM-04026 Ini
   v_tec_dma			ga_equipaboser.COD_TECNOLOGIA%type;
   v_tec_gsm			ga_equipaboser.COD_TECNOLOGIA%type;
   --TMM-04026 Fin
   CURSOR c1
   IS
      SELECT a.num_abonado, a.num_celular, a.num_serie, a.num_seriehex,
             a.tip_terminal, a.cod_central, b.ind_procequi,a.ind_disp
        FROM ga_abocel a, ga_equipaboser b
       WHERE a.num_abonado = b.num_abonado
         AND a.num_serie = b.num_serie
         AND a.cod_situacion = 'RTP'
         AND TRUNC (b.fec_alta) <=   SYSDATE - 1
      UNION
      SELECT a.num_abonado, a.num_celular, a.num_serie, a.num_seriehex,
             a.tip_terminal, a.cod_central, b.ind_procequi,a.ind_disp
        FROM ga_aboamist a, ga_equipaboser b
       WHERE a.num_abonado = b.num_abonado
         AND a.num_serie = b.num_serie
         AND a.cod_situacion = 'RTP'
         AND TRUNC (b.fec_alta) <=   SYSDATE - 1;

BEGIN
   OPEN c1;

   ----TMM-04026 Ini
   --v_tecnologia_tdma:=ge_fn_devvalparam('GA', 1, 'TECNOLOGIA_TDMA');
   --v_tecnologia_gsm:=ge_fn_devvalparam('GA', 1, 'TECNOLOGIA_GSM');
   --TMM-04026 Fin

   if v_producto is null then
          raise error_proceso;
   end if;
   LOOP
      FETCH c1 INTO v_abonado,
                    v_celular,
                    v_serie,
                    v_serie_hex_nue,
                    v_tip_terminal,
                    v_cod_central,
                    v_ind_procequi,
                    v_serv_tec;
      EXIT WHEN c1%NOTFOUND;
      -- busca movimiento
      p_consulta_movimiento_cs (v_celular, vp_estado, v_movimiento, vp_error);

      IF vp_error = '1' AND Nvl(v_serv_tec,1) != 0
      THEN -- no encuentra movimiento
         BEGIN
            vp_proc := 'P_DEL_CAMSERIE';

            BEGIN
               vp_tabla := 'GA_ABOCEL';
               vp_act := 'S';
               SELECT num_serie, tip_terminal, cod_cliente, cod_central, num_imei, cod_cuenta,cod_tipcontrato,num_contrato,num_anexo
                 INTO v_serie_nue, v_terminal_nue, v_cliente, v_central, v_imei_nue,v_cuenta,v_tipcontrato,v_contrato,v_anexo
                 FROM ga_abocel
                WHERE num_abonado = v_abonado;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  vp_tabla := 'GA_ABOAMIST';
                  vp_act := 'S';
                  SELECT num_serie, tip_terminal, cod_cliente, cod_central, num_imei,cod_cuenta,cod_tipcontrato,num_contrato,num_anexo
                    INTO v_serie_nue, v_terminal_nue, v_cliente, v_central, v_imei_nue,v_cuenta,v_tipcontrato,v_contrato,v_anexo
                    FROM ga_aboamist
                   WHERE num_abonado = v_abonado;
            END;
                                   v_num_simcard := v_serie_nue;
            IF v_serie_nue <> ' '
            THEN
               BEGIN
                  vp_tabla := 'AL_SERIES';
                  vp_act := 'S';

                                  Begin
                          SELECT cod_estado
                            INTO v_estado
                            FROM al_series
                           WHERE num_serie = v_imei_nue
                             AND cod_estado != 8;
                                                 v_serie_nue:=v_imei_nue;
                                  Exception
                                          When no_data_found then
                                                  SELECT cod_estado
                                    INTO v_estado
                                    FROM al_series
                                   WHERE num_serie = v_serie_nue
                                     AND cod_estado != 8;
                                  End;

                  IF    v_estado = 7
                     OR v_estado = 1
                  THEN
                     BEGIN
                        vp_tabla := 'GA_RESERVART 1';
                        vp_act := 'S';

                        IF v_estado = 7 THEN

                           /*homolog. CH-200312111563
                           Se coloco una excepcion al select de la ga_reservart, para que
                           cuando no encuentre datos, pueda seguir el proceso
                           */
                           begin
				SELECT ROWID
	                        INTO v_fila_reserva
	                        FROM ga_reservart
	                        WHERE num_serie = v_serie_nue
	                        AND ROWNUM = 1;
			   exception
			   	when no_data_found then
					v_fila_reserva := '.';
			   end;
                           /*FIN Homolog.CH-200312111563*/

                        ELSE
                           v_fila_reserva := '.';
                        END IF;

                        IF v_fila_reserva <> ' '
                        THEN
                           BEGIN
                              vp_tabla := 'GA_EQUIPABOSER';
                              vp_act := 'S';
                              SELECT fec_alta, ROWID
                                INTO v_fec_cambio, v_fila_equipaboser
                                FROM ga_equipaboser
                               WHERE num_abonado = v_abonado
                                 AND num_serie   = v_serie_nue
                                 AND fec_alta IN (SELECT MAX (fec_alta)
                                                    FROM ga_equipaboser
                                                   WHERE num_abonado = v_abonado
                                                     AND num_serie   = v_serie_nue);


                              SELECT COUNT(*) INTO v_filas_ant_equ
                                FROM ga_equipaboser
                               WHERE num_abonado = v_abonado
                                 AND fec_alta    = (SELECT MAX(fec_alta)
                                                      FROM ga_equipaboser
                                                     WHERE num_abonado = v_abonado
                                                       AND fec_alta < v_fec_cambio);


                              IF v_filas_ant_equ = 1 THEN
                              	    --TMM-04026 Ini
                                    SELECT num_serie,    tip_terminal,  num_imei, cod_tecnologia
                                      INTO v_serie_ant,  v_terminal_ant,v_imei_ant, v_tec_dma
                                    --TMM-04026 Fin
                                      FROM ga_equipaboser
                                     WHERE num_abonado = v_abonado
                                       AND fec_alta    IN (SELECT MAX (fec_alta)
                                                             FROM ga_equipaboser
                                                            WHERE num_abonado = v_abonado
                                                              AND fec_alta < v_fec_cambio);

                              ELSIF v_filas_ant_equ = 2 THEN
                              	    --TMM-04026 Ini
                                    SELECT num_serie,    tip_terminal,  num_imei, cod_tecnologia
                                      INTO v_serie_ant,  v_terminal_ant,v_imei_ant, v_tec_gsm
                                    --TMM-04026 Fin
                                      FROM ga_equipaboser
                                     WHERE num_abonado = v_abonado AND
                                           fec_alta    IN (SELECT MAX (fec_alta)
                                                             FROM ga_equipaboser
                                                            WHERE num_abonado = v_abonado AND
                                                                  fec_alta < v_fec_cambio) AND
                                           num_imei IS NOT NULL;
                              ELSE
                                     RAISE NO_DATA_FOUND;
                              END IF;



                              IF v_imei_ant IS NOT NULL THEN
                                  -- TECNOLOGMA ANTIGUA ES GSM
                                  --TMM-04026 Ini
                                  v_tecnologia := v_tec_gsm;
                                  --TMM-04026 Fin
                                                                  v_serie_hex_ant := '0';
                              ELSE
                                  -- TECNOLOGMA ANTIGUA ES TDMA
                                  --TMM-04026 Ini
                                  v_tecnologia := v_tec_dma;
                                  --TMM-04026 Fin
                                                                  --p_transforma_hexa (v_serie_nue, v_serie_hex_ant);
                                                                  p_transforma_hexa (v_serie_ant, v_serie_hex_ant); -- ahott CH-190620030922 23-06-2003
                              END IF;



                              vp_tabla := 'GA_MODABOCEL';
                              vp_act := 'S';

                              SELECT MAX (ROWID)
                                INTO v_fila_modabocel
                                FROM ga_modabocel
                               WHERE num_abonado = v_abonado
                                 AND cod_tipmodi in ('RE')
                                 AND nvl(num_serie,NVL(v_serie_ant,'0')) = NVL(v_serie_ant,'0')
                                 AND nvl(num_imei, NVL(v_imei_ant,'0' )) = NVL(v_imei_ant, '0')
                                 --AND TRUNC (fec_modifica) = TRUNC (v_fec_cambio) -- Ahott 23-04-2004 CH-200403231765_22042004
		                           AND fec_modifica >=TRUNC (v_fec_cambio) and fec_modifica <= TRUNC (v_fec_cambio)+23/24+59/1440+59/86400 -- Ahott 23-04-2004 CH-200403231765_22042004


                                                                 AND ROWNUM=1 --Evitar que seleccione mas de un registro en el caso que exista
                                                                 Order by fec_modifica desc;--mas de un cambio de serie en un dia

                              vp_tabla := 'GE_CARGOS';
                              vp_act := 'S';

                                                          sEstadoNuevo:=ge_fn_devvalparam('GA', 1, 'COD_ESTNUEVO');

                                                          --Deshacer si la serie esta en reserva de venta --
                                                          if v_estado=7 then
                                                              vp_tabla := 'P_GA_INTERAL';
                                                                  vp_act := 'E';

                                                                  BEGIN
                                                                    select cod_bodega ,cod_articulo,cod_uso,tip_stock into
                                                                                   v_bodega_ori, v_articulo,v_uso,v_tipstock_ori
                                                                        From al_series
                                                                        where num_serie=v_serie_nue;

                                                                        select GA_SEQ_TRANSACABO.nextval into v_numtransacabo from dual;
                                                                        P_GA_INTERAL(v_numtransacabo, --v_transac_x,
                                                                                                 gMovRetResVenta,--gMovRetResVenta,
                                                                                                 v_tipstock_ori,--sTipStockMercad,
                                                                                                 v_bodega_ori,--v_bodega_x,
                                                                                                 v_articulo,--v_articulo_x ,
                                                                                                 v_uso,--v_uso_x ,
                                                                                                 sEstadoNuevo,--v_estado_x ,
                                                                                                 NULL,--v_venta_x,
                                                                                                 '1',--v_cantid_x ,
                                                                                                 v_serie_nue,--v_serie_x ,
                                                                                                 NULL--v_indtel_x
                                                                                                 );
																				 BEGIN
																					 select cod_retorno,des_cadena into v_cod_retorno,v_des_cadena
																					 from ga_transacabo
																					 where num_transaccion = v_numtransacabo;

																					 if v_cod_retorno = 0 then
																					 	if v_des_cadena is null then
																					 	   dbms_output.put_line('Error ejecutando actualizacion de stock.');
																					 	   raise error_proceso;
																						end if;
																					 else
																					 	 dbms_output.put_line('Error ejecutando actualizacion de stock.['||v_numtransacabo||':'||v_des_cadena||']');
																					 	 raise error_proceso;
																					 end if;

	                                                                                 delete ga_reservart
	                                                                                 where num_serie=v_num_simcard
	                                                                                           and rownum=1;

																				 exception
																				 		  when others then
																						  	   raise error_proceso;
																				 end;


                                                                         /* Homolog. CH-200312111563
                                                                         si la variable se inicializo con un punto no se ejecuta el delete
                                                                         */
                                                                         if v_fila_reserva<>'.' then
                                                                         delete ga_reservart
                                                                         where rowid = v_fila_reserva;
	                                                                 end if;
	                                                                 /*FIN Homolog. CH-200312111563 */

                                                                  EXCEPTION
                                                                                   WHEN OTHERS THEN
                                                                                                RAISE error_proceso;
                                                                  END;
                                                          End if;

                                                          -- Se debe revisar la Simcard para el caso de cambio de tecnologia
                                                          -- TDMA -> GSM  --Existen 2 entradas en la tabla GA_EQUIPABOSER
                                                          if v_imei_nue Is Not Null and
                                                                                        v_imei_ant is Null and
                                                                                                           v_serie != v_serie_ant --!CE
                                                                                                                                                          THEN --!SA
                                                                 Begin
                                                                         select cod_estado,tip_stock ,cod_bodega,cod_articulo,cod_uso
                                                                         into v_estado_ori,v_tipstock_ori,v_bodega_ori,v_articulo,v_uso
                                                                         from al_series where num_serie=v_num_simcard;

                                                                         if v_estado_ori = 7 then
                                                                              vp_tabla := 'P_GA_INTERAL';
                                                                                  vp_act := 'E';

                                                                                select GA_SEQ_TRANSACABO.nextval into v_numtransacabo from dual;
                                                                                P_GA_INTERAL(v_numtransacabo, --v_transac_x,
                                                                                                         gMovRetResVenta,--gMovRetResVenta,
                                                                                                         v_tipstock_ori,--sTipStockMercad,
                                                                                                         v_bodega_ori,--v_bodega_x,
                                                                                                         v_articulo,--v_articulo_x ,
                                                                                                         v_uso,--v_uso_x ,
                                                                                                         sEstadoNuevo,--v_estado_x ,
                                                                                                         NULL,--v_venta_x,
                                                                                                         '1',--v_cantid_x ,
                                                                                                         v_num_simcard,--v_serie_x ,
                                                                                                         NULL--v_indtel_x
                                                                                                         );

																				 BEGIN
																					 select cod_retorno,des_cadena into v_cod_retorno,v_des_cadena
																					 from ga_transacabo
																					 where num_transaccion = v_numtransacabo;

																					 if v_cod_retorno = 0 then
																					 	if v_des_cadena is null then
																					 	   dbms_output.put_line('Error ejecutando actualizacion de stock.');
																					 	   raise error_proceso;
																						end if;
																					 else
																					 	 dbms_output.put_line('Error ejecutando actualizacion de stock.['||v_numtransacabo||':'||v_des_cadena||']');
																					 	 raise error_proceso;
																					 end if;

	                                                                                 delete ga_reservart
	                                                                                 where num_serie=v_num_simcard
	                                                                                           and rownum=1;

																				 exception
																				 		  when others then
																						  	   raise error_proceso;
																				 end;

                                                                                 delete ga_reservart
                                                                                 where num_serie=v_num_simcard
                                                                                           and rownum=1;

                                                                         end if;
                                                                 Exception
                                                                         When no_data_found then
                                                                      vp_tabla := 'P_PV_DESHACER_STOCK';
                                                                          vp_act := 'E';
                                                                          BEGIN
                                                                         --Serie Simcard tuvo salida definitiva debemos realizar entrada
                                                                          p_pv_deshacer_stock(v_abonado,
                                                                                                                  v_num_simcard,
                                                                                                                  NULL,
                                                                                                                   error);
																			  	  if error != '0' then
																				  	 	 dbms_output.put_line('Error al intentar devolver Simcard. p_pv_deshacer_stock='||error);
																					 	 raise error_proceso;
																				  end if;
                                                                          Exception
                                                                                           When Others then
                                                                                               raise error_proceso;
                                                                          END;
                                                                 End;
                                                          End if;

                              BEGIN
							  	 bHayCargos:=FALSE;
                                 SELECT num_venta,fec_alta
                                   INTO v_venta,v_fec_cargos
                                   FROM ge_cargos
                                  WHERE cod_cliente = v_cliente
                                    AND num_abonado = v_abonado
                                    AND num_serie = v_serie_nue
                                    --AND TRUNC (fec_alta) = TRUNC(v_fec_cambio) -- Ahott 23-04-2004 CH-200403231765_22042004
	                                  AND fec_alta >=TRUNC (v_fec_cambio) and fec_alta <= TRUNC (v_fec_cambio)+23/24+59/1440+59/86400 -- Ahott 23-04-2004 CH-200403231765_22042004



                                    AND ROWNUM=1;
								 bHayCargos:=TRUE;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    v_venta := 0;
                              END;

                              vp_tabla := 'GA_EQUIPABOSER';
                              vp_act := 'D';

                              DELETE  ga_equipaboser
                               WHERE  num_abonado = v_abonado
                                 AND  fec_alta = (SELECT MAX(fec_alta)
                                                    FROM ga_equipaboser
                                                   WHERE num_abonado = v_abonado
                                                     AND num_serie   = v_serie_nue);


                              vp_tabla := 'GE_CARGOS';
                              vp_act := 'E';

							   --Si existe venta
							   if v_venta > 0 then
							   	  Delete ge_cargos where num_venta=v_venta;

	                              vp_tabla := 'GA_VENTAS';
	                              vp_act := 'E';

	                              DELETE ga_ventas
	                              WHERE num_venta = v_venta;

							   elsif bHayCargos = True then --Si la venta fue a ciclo
                                    DELETE ge_cargos
                                    WHERE cod_cliente = v_cliente
                                    AND num_abonado = v_abonado
									AND  fec_alta = v_fec_cargos;
							   end if;

                              p_ins_audrest (
                                 v_producto,
                                 v_abonado,
                                 'P_DEL_RESTITUCION',
                                 vp_error
                              );

                              IF vp_error <> '0'
                              THEN
                                 RAISE error_proceso;
                              END IF;
							  --Inicio HOMOLOG. CH-021220031546
								begin
	                                SELECT COD_SERVICIO into v_cod_servicio
	                                FROM GA_SUSPREHABO
	                                WHERE NUM_ABONADO = v_abonado
	                                AND IND_SINIESTRO = 1
	                                AND ROWNUM=1;
									SELECT NUM_SINIESTRO,COD_CAUSA
									into v_siniestro,v_causa_sinies
									FROM GA_HSINIESTROS
									Where Num_abonado = v_abonado
									And   cod_producto = V_PRODUCTO
									And   Cod_estado = 'RE'
									--TMM-04026 Ini
									And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
									--TMM-04026 Fin
									Decode(v_actabo,'SA',v_serie_ant,v_imei_ant))
									And Fec_siniestro in (select max(fec_siniestro)
									from  Ga_Hsiniestros
									Where Num_abonado = v_abonado
									and   cod_producto = V_PRODUCTO
									And   Cod_estado = 'RE'
									--TMM-04026 Ini
									And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
									--TMM-04026 Fin
									Decode(v_actabo,'SA',v_serie_ant,v_imei_ant)));

			                        INSERT INTO GA_SINIESTROS (
	                                                        NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
	                                                        NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO,
	                                                        FEC_FORMALIZA, FEC_ANULA, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
	                                                        ) (SELECT
	                                                        NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, 'FO',
	                                                        NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO,
	                                                        FEC_FORMALIZA, FEC_ANULA, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
	                                                        FROM GA_HSINIESTROS WHERE NUM_SINIESTRO = v_siniestro);

	                                                        DELETE GA_HSINIESTROS WHERE NUM_SINIESTRO=v_siniestro;

	                                                        INSERT INTO GA_DETSINIE
	                                                        (NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
	                                                        OBS_DETALLE )
	                                                        (SELECT
	                                                        NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
	                                                        OBS_DETALLE
	                                                        FROM GA_HDETSINIE WHERE NUM_SINIESTRO = v_siniestro);

	                                                        DELETE GA_HDETSINIE where NUM_SINIESTRO = v_siniestro;
								exception
									when no_data_found then
										 dbms_output.put_line('Siniestro no encontrado en historico');
								end;
                                UPDATE GA_SUSPREHABO
                                SET FEC_REHABD = NULL
                                WHERE NUM_ABONADO = v_abonado
                                AND IND_SINIESTRO = 1
                                AND COD_SERVICIO = v_cod_servicio;
							  -- Fin HOMOLOG. CH-021220031546
                              vp_tabla := 'GA_ABOCEL';
                              vp_act := 'S';

                                                          --if v_imei_ant is Null then
                                                                                        Select ind_procequi into v_indprocequi_aboser
                                                                                        From ga_equipaboser
                                                                                        Where num_abonado=v_abonado
                                                                                        and        num_serie=v_serie_ant
                                                                                        And fec_alta in (Select max(fec_alta)
                                                                                                                        From ga_equipaboser
                                                                                                                        Where num_abonado=v_abonado
                                                                                                                        and num_serie=v_serie_ant);
                                                          /*else
                                                                                        Select ind_procequi  into v_indprocequi_aboser
                                                                                        From ga_equipaboser
                                                                                        Where num_abonado=v_abonado
                                                                                        and        num_serie=v_imei_ant
                                                                                        And fec_alta in (Select max(fec_alta)
                                                                                                                                From ga_equipaboser
                                                                                                                                 Where num_abonado=v_abonado
                                                                                                                                 and num_serie=v_imei_ant);
                                                          end if;*/

                              vp_tabla := 'GA_MODABOCEL';
                              vp_act := 'S';

                                                          select fec_modifica, ind_eqprestado,fec_prorroga,cod_central,cod_planserv,fec_fincontrato
                                                          into v_fec_mod_modabo,ind_eqprestado_modabo,fec_prorroga_modabo,cod_central_modabo,cod_planserv_modabo,v_fec_fincont_modabocel
                                                          from ga_modabocel where ROWID = v_fila_modabocel;

                              vp_tabla := 'GA_CONTCTA';
                              vp_act := 'S';

                                                          BEGIN
                                                                  select fec_contrato,rowid into v_fec_contcta,v_fila_contcta
                                                                  from ga_contcta
                                                                  where cod_cuenta  = v_cuenta
                                                                  And   cod_producto= v_producto
                                                                  And   cod_tipcontrato = v_tipcontrato
                                                                  And   num_contrato = v_contrato
                                                                  And   num_anexo = v_anexo
                                                                  And   num_abonado = v_abonado
                                                                  And   fec_contrato >= v_fec_mod_modabo
                                                                  And   rownum=1;

                                                                  select num_contrato,cod_tipcontrato,num_anexo into
                                                                                 v_contrato_contcta,v_tipcontrato_contcta,v_anexo_contcta
                                                                  from ga_contcta
                                                                  where cod_cuenta  = v_cuenta
                                                                  And   cod_producto= v_producto
                                                                  And   num_abonado = v_abonado
                                                                  And   fec_contrato = (select max(fec_contrato)
                                                                                                                 From ga_contcta
                                                                                                                  where cod_cuenta  = v_cuenta
                                                                                                                  And   cod_producto= v_producto
                                                                                                                  And   num_abonado = v_abonado
                                                                                                                  And   fec_contrato < v_fec_contcta);

                                                                  delete ga_contcta where rowid=v_fila_contcta;

                                                           Exception
                                                                                when no_data_found then--No hubo cambio numero contrato
                                                                                v_contrato_contcta:=NULL;
                                                                                v_tipcontrato_contcta:=NULL;
                                                                                v_anexo_contcta:=NULL;
                                                           END;



                              vp_tabla := 'GA_ABOCEL';
                              vp_act := 'U';

                              UPDATE ga_abocel A
                                 SET num_serie        = v_serie_ant,
                                     num_seriehex     = v_serie_hex_ant,
                                     tip_terminal     = v_terminal_ant,
                                     cod_situacion    = 'SAA',
                                     ind_eqprestado   = nvl(ind_eqprestado_modabo,A.IND_EQPRESTADO),
                                     fec_prorroga     = nvl(fec_prorroga_modabo,A.FEC_PRORROGA),
                                                                         num_imei         = v_imei_ant,
                                                                         cod_tecnologia   = v_tecnologia,
                                                                         cod_central      = nvl(cod_central_modabo,A.cod_central),
                                                                         ind_procequi     = nvl(v_indprocequi_aboser,A.IND_PROCEQUI),
                                                                         cod_planserv     = nvl(cod_planserv_modabo,A.COD_PLANSERV),
                                                                         cod_tipcontrato  = nvl(v_tipcontrato_contcta,A.cod_tipcontrato),
                                                                         num_contrato     = nvl(v_contrato_contcta,A.NUM_CONTRATO),
                                                                         num_anexo                = nvl(v_anexo_contcta,A.num_anexo),
                                                                         fec_fincontra    = nvl(v_fec_fincont_modabocel,A.fec_fincontra)
                               WHERE A.num_abonado = v_abonado;

                              vp_tabla := 'GA_MODABOCEL';
                              vp_act := 'D';

                              DELETE ga_modabocel
                               WHERE ROWID = v_fila_modabocel;

                              vp_tabla := 'GA_ABOAMIST';
                              vp_act := 'U';

                              UPDATE ga_aboamist A
                                 SET num_serie          = v_serie_ant,
                                     num_seriehex       = v_serie_hex_ant,
                                     tip_terminal       = v_terminal_ant,
                                     cod_situacion      = 'SAA',
--                                                                       fec_prorroga       = nvl(fec_prorroga_modabo,A.FEC_PRORROGA),
                                     num_imei           = v_imei_ant,
                                     cod_tecnologia     = v_tecnologia,
                                                                         cod_central            = nvl(cod_central_modabo,A.cod_central),
                                                                         ind_procequi       = nvl(v_indprocequi_aboser,A.IND_PROCEQUI),
                                                                         cod_planserv       = nvl(cod_planserv_modabo,A.COD_PLANSERV),
                                                                         cod_tipcontrato    = nvl(v_tipcontrato_contcta,A.cod_tipcontrato),
                                                                         num_contrato       = nvl(v_contrato_contcta,A.NUM_CONTRATO),
                                                                         num_anexo                  = nvl(v_anexo_contcta,A.num_anexo),
                                                                         fec_fincontra    = nvl(v_fec_fincont_modabocel,A.fec_fincontra)
                               WHERE num_abonado        = v_abonado;

                              /*IF v_terminal_ant <> v_terminal_nue
                              THEN
                                 vp_tabla := 'OPENSERV';
                                 vp_act := 'U';
                                 SELECT ga_seq_transacabo.NEXTVAL
                                   INTO v_transaccion
                                   FROM DUAL;
                                 p_openserv_terminal (
                                    v_transaccion,
                                    1,
                                    v_abonado,
                                    v_terminal_ant,
                                    v_central,
                                    0
                                 );
                              END IF;*/

                        VP_ERROR_INTAR := '0';
                        VP_CADENA_INTAR := '';

                        PV_PR_REVINTARCEL(v_abonado,VP_ERROR_INTAR, VP_CADENA_INTAR);

--                        DBMS_OUTPUT.PUT_LINE (VP_ERROR_INTAR || ' --- ' || VP_CADENA_INTAR);

                        IF VP_ERROR_INTAR <> '0' THEN
                           RAISE error_proceso;
                        ELSE
                           VP_ERROR := VP_ERROR_INTAR;
                        END IF;


  --                            vp_error := '0';
                              vp_tabla := 'FA_HISTDOCU';
                              vp_act := 'U';
                              p_upd_histdocu (v_cliente, v_venta, vp_error);

                              IF vp_error <> '0'
                              THEN
                                 RAISE error_proceso;
                              END IF;

                              COMMIT;

                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 ROLLBACK;
                              WHEN error_proceso
                              THEN
                                 ROLLBACK;
                              WHEN OTHERS
                              THEN
                                 ROLLBACK;
                           END;
                        END IF;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           ROLLBACK;
                     END;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN --serie no se encontro
                     BEGIN
                        SELECT ROWID --busca reserva
                          INTO v_fila_reserva
                          FROM ga_reservart
                         WHERE num_serie = v_serie;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN --serie no encontro, genera movimiento
                           BEGIN
                                                          vp_error:='0';
                              vp_tabla := 'GA_EQUIPABOSER';
                              vp_act := 'S';
                              SELECT fec_alta, ROWID
                                INTO v_fec_cambio, v_fila_equipaboser
                                FROM ga_equipaboser
                               WHERE num_abonado = v_abonado
                                 AND num_serie   = v_serie_nue
                                 AND fec_alta IN (SELECT MAX (fec_alta)
                                                    FROM ga_equipaboser
                                                   WHERE num_abonado = v_abonado
                                                     AND num_serie   = v_serie_nue);

                              SELECT COUNT(*) INTO filas_equipos
                                FROM (SELECT DISTINCT fec_alta
                                        FROM ga_equipaboser
                                       WHERE num_abonado = v_abonado
                                    GROUP BY fec_alta);

                              IF filas_equipos > 1
                              THEN
                                 vp_tabla := 'GA_EQUIPABOSER';
                                 vp_act := 'S2';

                                 SELECT COUNT(*) INTO v_filas_ant_equ
                                   FROM ga_equipaboser
                                  WHERE num_abonado  = v_abonado AND
                                        fec_alta     = (SELECT MAX(fec_alta)
                                                          FROM ga_equipaboser
                                                         WHERE num_abonado = v_abonado AND
                                                               fec_alta < v_fec_cambio);
                                 IF v_filas_ant_equ = 1 THEN
                                    --TMM-04026 Ini
                                    SELECT num_serie,   tip_terminal,   num_imei, cod_tecnologia
                                      INTO v_serie_ant, v_terminal_ant, v_imei_ant, v_tec_dma
                                    --TMM-04026 Fin
                                      FROM ga_equipaboser
                                     WHERE num_abonado = v_abonado
                                       AND fec_alta IN
                                                      (SELECT MAX (fec_alta)
                                                         FROM ga_equipaboser
                                                        WHERE num_abonado = v_abonado
                                                          AND fec_alta < v_fec_cambio);
                                 ELSE
                                    --TMM-04026 Ini
                                    SELECT num_serie,   tip_terminal,   num_imei, cod_tecnologia
                                      INTO v_serie_ant, v_terminal_ant, v_imei_ant, v_tec_gsm
                                    --TMM-04026 Fin
                                      FROM ga_equipaboser
                                     WHERE num_abonado = v_abonado
                                       AND fec_alta IN
                                                      (SELECT MAX (fec_alta)
                                                         FROM ga_equipaboser
                                                        WHERE num_abonado = v_abonado
                                                          AND fec_alta < v_fec_cambio)
                                       AND num_imei IS NOT NULL;
                                 END IF;


                                 IF v_imei_ant IS NOT NULL THEN -- TECNOLOGMA ANTERIOR ERA GSM
                                     v_serie_icc := v_serie_ant;
                                     --v_serie_hex_ant := v_serie_ant;   -- num_serie
                                     --TMM-04026 Ini
                                     v_tecnologia_ant := v_tec_gsm;
                                     --TMM-04026 Fin

                                 ELSE  -- TECNOLOGMA ANTERIOR ERA TDMA
                                     p_transforma_hexa (v_serie_ant, v_serie_hex_ant);
                                     v_serie_icc :=v_serie_hex_ant;
                                     --TMM-04026 Ini
                                     v_tecnologia_ant := v_tec_dma;  --num_serie
                                     --TMM-04026 Fin
                                 END IF;


                                 IF v_imei_nue IS NOT NULL THEN  -- TECNOLOGMA NUEVA ES GSM
                                     --TMM-04026 Ini
                                     v_tecnologia_nue := v_tec_gsm;
                                     --TMM-04026 Fin
                                 ELSE                            -- TECNOLOGMA ANTERIOR ERA TDMA
                                     --v_serie_hex_nue           --num_serie_nue
                                     --TMM-04026 Ini
                                     v_tecnologia_nue := v_tec_dma;
                                     --TMM-04026 Fin
                                 END IF;

                                 SELECT cod_central
                                   INTO v_codcentral_ori
                                   FROM ga_celnum_uso
                                  WHERE (v_celular BETWEEN num_desde and num_hasta) AND
                                        cod_producto = v_producto;

                                 SELECT cod_tecnologia
                                   INTO v_tecnologia_ori
                                   FROM ICG_CENTRAL
                                  WHERE cod_central = v_codcentral_ori
                                    AND cod_producto = v_producto;

                                 SELECT count(*)
                                   INTO v_filas_nue_equ
                                   FROM ga_equipaboser
                                  WHERE num_abonado = v_abonado
                                  and fec_alta = v_fec_cambio;

				 --TMM-04026 Ini
                                 IF v_tecnologia_nue = v_tecnologia_ant AND
                                       v_tecnologia_nue = v_tec_gsm THEN
                                         IF v_filas_nue_equ = 1 THEN
                                            v_actabo := 'SA';
                                         ELSE
                                            v_actabo := 'CE';
                                         END IF;
                                 ELSIF v_tecnologia_nue = v_tecnologia_ant AND
                                         v_tecnologia_nue = v_tec_dma THEN
                                         v_actabo := 'CE';
                                 ELSE
	                                 SELECT cod_actabo into v_actabo
	                                 FROM pv_tecno_actabo_td
					 WHERE cod_Tecnologia_ini = v_tecnologia_ori
					 AND   cod_Tecnologia_act = v_tecnologia_ant
					 AND   cod_tecnologia_fin = v_tecnologia_nue;
                                 /*ELSIF v_tecnologia_ant = v_tec_dma AND
                                         v_tecnologia_nue = v_tec_gsm  AND
                                         v_tecnologia_ori = v_tec_dma THEN
                                         v_actabo := 'TG';
                                 ELSIF v_tecnologia_ant = v_tec_gsm   AND
                                         v_tecnologia_nue = v_tec_dma  AND
                                         v_tecnologia_ori = v_tec_dma THEN
                                         v_actabo := 'ET';
                                 ELSIF v_tecnologia_ant = v_tec_gsm  AND
                                         v_tecnologia_nue = v_tec_dma  AND
                                         v_tecnologia_ori = v_tec_gsm THEN
                                         v_actabo := 'GT';
                                 ELSIF v_tecnologia_ant = v_tec_dma AND
                                         v_tecnologia_nue = v_tec_gsm  AND
                                         v_tecnologia_ori = v_tec_gsm THEN
                                         v_actabo := 'EG';*/
                                 END IF;
				--TMM-04026 Fin

                                 SELECT cod_actcen INTO v_actcen
                                   FROM ga_actabo
                                  WHERE cod_producto   = 1
                                    AND cod_modulo     = 'GA'
                                    AND cod_actabo     = v_actabo
                                    AND cod_tecnologia = v_tecnologia_ant;--v_tecnologia_nue;


                                 IF v_actabo = 'GT' or v_actabo = 'ET' THEN  -- DE GSM A TDMA
                                      v_serie_nue_icc := v_serie_hex_nue;
                                      SELECT fRecuperSIMCARD_FN( v_serie_icc, 'IMSI')
                                        INTO v_imsi_ant
                                        FROM dual;

                                      v_imsi_nue := NULL;
				      --TMM-04026 Ini
                                      v_tecnologia := v_tec_gsm;
                                      --TMM-04026 Fin
                                      v_icc_nue    := NULL;
                                      v_icc_ant    := v_serie_icc;

                                 ELSIF v_actabo = 'TG' or v_actabo = 'EG' THEN   -- DE TDMA A GSM
                                       v_serie_nue_icc := v_serie;--v_serie_nue;
                                      SELECT fRecuperSIMCARD_FN( v_serie_nue_icc, 'IMSI')
                                        INTO v_imsi_nue
                                        FROM dual;
                                      v_imsi_ant := NULL;
                                      --TMM-04026 Ini
                                      v_tecnologia := v_tec_dma;
                                      --TMM-04026 Fin
                                      v_icc_nue    := v_serie_nue_icc;
                                      v_icc_ant    := NULL;
                                     --v_serie_hex_nue := NULL; --A GSM no importa este numero porq' tiene icc_nue
				 --TMM-04026 Ini
                                 ELSIF (v_actabo = 'CE' or v_actabo = 'SA') and GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue) = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm) THEN -- DE GSM a GSM
                                 --TMM-04026 Fin
                                      v_serie_nue_icc := v_serie;--v_serie_nue;
                                      SELECT fRecuperSIMCARD_FN( v_serie_nue_icc, 'IMSI')
                                        INTO v_imsi_nue
                                        FROM dual;

                                      SELECT fRecuperSIMCARD_FN( v_serie_icc, 'IMSI')
                                        INTO v_imsi_ant
                                        FROM dual;
				      --TMM-04026 Ini
                                      v_tecnologia := v_tec_gsm;
                                      --TMM-04026 Fin
                                      v_icc_nue    := v_serie_nue_icc;
                                      v_icc_ant    := v_serie_icc;
                                      v_serie_hex_nue := NULL; --A GSM no importa este numero porq' tiene icc_nue
                                  --TMM-04026 Ini
                                  ELSIF v_actabo = 'CE' and GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue) = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma) THEN --DE TDMA a TDMA
                                  --TMM-04026 Fin
                                      v_serie_nue_icc := v_serie_hex_nue;
                                      v_imsi_nue := NULL;
                                      v_imsi_ant := NULL;

				      --TMM-04026 Ini
                                      v_tecnologia := v_tec_dma;
                                      --TMM-04026 Fin
                                      v_icc_nue    := NULL;
                                      v_icc_ant    := NULL;

                                 END IF;
			      /* Inicio modificacion ahott 20-11-2003 HB-311020030133spool off-311020030134 */
			      vp_tabla := 'GA_MODABOCEL';
                              vp_act := 'S';
                              SELECT MAX (ROWID)
                                INTO v_fila_modabocel
                                FROM ga_modabocel
                               WHERE num_abonado = v_abonado
                                 AND cod_tipmodi in ('RE')
                                 AND nvl(num_serie,NVL(v_serie_ant,'0')) = NVL(v_serie_ant,'0')
                                 AND nvl(num_imei, NVL(v_imei_ant,'0' )) = NVL(v_imei_ant, '0')
                                 --AND TRUNC (fec_modifica) = TRUNC (v_fec_cambio)
				 --AND TRUNC (fec_modifica) = TRUNC (v_fec_cambio) -- Ahott 23-04-2004 CH-200403231765_22042004
	                           AND fec_modifica >=TRUNC (v_fec_cambio) and fec_modifica <= TRUNC (v_fec_cambio)+23/24+59/1440+59/86400 -- Ahott 23-04-2004 CH-200403231765_22042004




                                                                 AND ROWNUM=1 --Evitar que seleccione mas de un registro en el caso que exista
                                                                 Order by fec_modifica desc;--mas de un cambio de serie en un dia
			      /*Fin modificacion ahott 20-11-2003 HB-311020030133-311020030134 */
                                                                 v_NumMin:=AL_FN_PREFIJO_NUMERO(v_celular);

                                                         vp_tabla := 'ICC_MOVIMIENTO';
                                 vp_act := 'I';

                                 INSERT INTO icc_movimiento
                                             (cod_estado,    num_movimiento,
                                              num_abonado,   cod_modulo,
                                              cod_actuacion, nom_usuarora,
                                              fec_ingreso,   cod_central,
                                              num_celular,
                                              num_serie,     num_serie_nue,
                                              imsi,          imsi_nue,
                                              imei,          imei_nue,
                                              icc,           icc_nue,
                                              tip_terminal_nue, cod_actabo,
                                              num_intentos,
                                              des_respuesta,
                                              tip_terminal,
                                              ind_bloqueo,
                                              tip_tecnologia,num_min)
                                 VALUES       (1,            icc_seq_nummov.NEXTVAL,
                                              v_abonado,     'GA',
                                              v_actcen,      'MIGRACION',
                                              SYSDATE,       v_central,
                                              v_celular,
                                              --TMM-04026 Ini
                                                                                          Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_ant),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_icc,' '),
                                              Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_nue_icc,NULL),
                                              Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_ant),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_imsi_ant,NULL),
                                                                                          Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),Decode(v_actabo,'CE',NULL,v_imsi_nue),NULL),
                                              Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_ant),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_imei_ant,NULL),
                                                                                          Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),Decode(v_actabo,'SA',NULL,v_imei_nue),NULL),
                                              Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_ant),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_icc_ant,NULL),
                                                                                          Decode(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia_nue),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),Decode(v_actabo,'CE',NULL,v_icc_nue),NULL),
                                              --TMM-04026 Fin
                                              v_terminal_nue,v_actabo,
                                              0,             'PENDIENTE RESTITUCION EQUIPO REST.',
                                              DECODE (v_terminal_ant,
                                                                     NULL, 'D',
                                                                     v_terminal_ant),
                                              0,
                                              v_tecnologia,v_NumMin);

                                 BEGIN
                                    IF v_ind_procequi = 'E'
                                    THEN
                                       SELECT distinct num_venta /* ahott 20-11-2003 HB-311020030133-311020030134 */
                                         INTO v_venta
                                         FROM ge_cargos
                                        WHERE cod_cliente = v_cliente
                                          AND num_abonado = v_abonado
                                          AND fec_alta > v_fec_cambio;
                                                                                  /*AND TRUNC (fec_alta) =
                                                 (SELECT TRUNC (fec_alta)
                                                    FROM ga_equipaboser
                                                   WHERE num_abonado = v_abonado
                                                     AND fec_alta IN
                                                            (SELECT MAX (fec_alta)
                                                               FROM ga_equipaboser
                                                              WHERE num_abonado = v_abonado)) AND ROWNUM = 1;*/
                                    ELSE
                                       SELECT num_venta
                                         INTO v_venta
                                         FROM ge_cargos
                                        WHERE cod_cliente = v_cliente
                                          AND num_abonado = v_abonado
                                          AND num_serie IN (v_serie_nue,v_imei_nue)
										  AND fec_alta >= v_fec_cambio -- homolog. CH-021220031546
                                          AND ROWNUM = 1;
                                    END IF;

                                    UPDATE fa_interfact
                                       SET cod_estadoc = 100,
                                           cod_estproc = 3
                                     WHERE num_venta = v_venta
                                       AND cod_tipmovimien = 1
                                       AND cod_estadoc = 0
                                       AND num_venta > 0;

									-- inicio Homolog. CH-021220031546
									p_ins_audrest (
									v_producto,
									v_abonado,
									'P_DEL_RESTITUCION(PASA MOV.)',
									vp_error
									);
									dbms_output.put_line('p_ins_audrest vp_error = '||vp_error);
	                                 IF vp_error <> '0'
	                                 THEN
	                                    RAISE error_proceso;
	                                 END IF;
	                                  sFORMATO_SEL2:=ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
									  dbms_output.put_line('FORMATO_SEL2');
	                                  -- Debemos finalizar la restitucion
									  begin --ahott 30-12-2003 CH-021220031546
		                                  SELECT NUM_SINIESTRO,COD_CAUSA
		                                  into v_siniestro,v_causa_sinies
		                                  FROM GA_SINIESTROS
		                                  Where Num_abonado = v_abonado
		                                  And   cod_producto = V_PRODUCTO
		                                  And   Cod_estado = 'FO'
		                                  --TMM-04026 Ini
		                                  And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
		                                  --TMM-04026 Fin
		                                                                                                            Decode(v_actabo,'SA',v_serie_ant,
		                                                                                                                                                          v_imei_ant))
		                                  And Fec_siniestro in (select max(fec_siniestro)
		                                                                            from  Ga_siniestros
		                                                                            Where Num_abonado = v_abonado
		                                                                            and   cod_producto = V_PRODUCTO
		                                                                            And   Cod_estado = 'FO'
		                                                                            --TMM-04026 Ini
		                                                                            And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
		                                                                            --TMM-04026 Fin
		                                                                                                                                                    Decode(v_actabo,'SA',v_serie_ant,
		                                                                                                                                                                                                    v_imei_ant)));

										  dbms_output.put_line('select ga_siniesros FO');
		                                  UPDATE GA_SINIESTROS
		                                  SET COD_ESTADO = 'RE',
		                                          FEC_RESTITUC = (Select TO_DATE(Sysdate,sFORMATO_SEL2) from dual)
		                                  Where Num_siniestro = v_siniestro;

		                                  INSERT INTO GA_HDETSINIE
		                                  (NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
		                                  FEC_HISTORICO, OBS_DETALLE )
		                                  (SELECT
		                                  NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
		                                  SYSDATE, OBS_DETALLE
		                                  FROM GA_DETSINIE WHERE NUM_SINIESTRO = v_siniestro);

		                                  DELETE GA_DETSINIE where NUM_SINIESTRO = v_siniestro;

		                                  INSERT INTO GA_HSINIESTROS (
		                                  NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
		                                  NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, FEC_HISTORICO, COD_CARGOBASICO, COD_SERVICIO,
		                                  FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
		                                  ) (SELECT
		                                  NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
		                                  NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, SYSDATE, COD_CARGOBASICO, COD_SERVICIO,
		                                  FEC_FORMALIZA, FEC_ANULA, FEC_RESTITUC, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
		                                  FROM GA_SINIESTROS WHERE NUM_SINIESTRO = v_siniestro);

		                                  DELETE GA_SINIESTROS WHERE NUM_SINIESTRO=v_siniestro;
									  exception --ahott 30-12-2003 CH-021220031546
									  	  when no_data_found then --ahott 30-12-2003 CH-021220031546
										   		dbms_output.put_line('Siniestro ya esta en historico'); --ahott 30-12-2003 CH-021220031546
									  end; --ahott 30-12-2003 CH-021220031546

	                                  UPDATE GA_ABOCEL
	                                  SET COD_SITUACION = DECODE (COD_SITUACION,  'SAA','RTP',
		                                                                          'AOS','RAO',
		                                                                          'ATS','RAT',
		                                                                          'CVS','RCV',
		                                                                          'RDS','RRD',
                                                                                  'RTP'),
	                                          FEC_ULTMOD = SYSDATE
	                                  WHERE NUM_ABONADO = v_abonado;
									  dbms_output.put_line('update ga_abocel');
	                                  SELECT COD_SERVICIO into v_cod_servicio
	                                  FROM GA_SUSPREHABO
	                                  WHERE NUM_ABONADO = v_abonado
	                                  AND IND_SINIESTRO = 1
	                                  AND ROWNUM=1;
									  dbms_output.put_line('select ga_susprehabo');
	                                  UPDATE GA_SUSPREHABO
	                                  SET FEC_REHABD = SYSDATE ,  TIP_REGISTRO = 3
	                                  WHERE NUM_ABONADO = v_abonado
	                                  AND IND_SINIESTRO = 1
	                                  AND COD_SERVICIO = v_cod_servicio;
									  dbms_output.put_line('Insert RT icc_movimiento');
	                                  INSERT INTO ICC_MOVIMIENTO (
	                                                          NUM_MOVIMIENTO,
	                                                          NUM_ABONADO,
	                                                          COD_ESTADO,
	                                                          COD_MODULO,
	                                                          NOM_USUARORA,
	                                                          COD_CENTRAL,
	                                                          NUM_CELULAR,
	                                                          COD_ACTUACION,
	                                                          FEC_INGRESO,
	                                                          NUM_SERIE,
	                                                          COD_SUSPREHA,
	                                                          TIP_TERMINAL,
	                                                          COD_ACTABO,
	                                                          NUM_MIN,
	                                                          STA,
	                                                          TIP_TECNOLOGIA
	                                                      ,IMSI,
	                                                      IMEI,
	                                                      ICC

	                                     ) VALUES (
	                                                           ICC_SEQ_NUMMOV.NEXTVAL,
	                                                           v_abonado,
	                                                           '1',
	                                                           'GA',
	                                                           'MIGRACION',
	                                                           v_central,
	                                                           v_celular,
	                                                           FN_CODACTCEN (v_producto,'RT','GA',v_tecnologia),
	                                                           SYSDATE,
	                                                           --TMM-04026 Ini
	                                                           DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_nue_icc,' '),
	                                                           --TMM-04026 Fin
	                                                           v_cod_servicio,
	                                                           v_terminal_ant,
	                                                           'RT',
	                                                           v_NumMin,
	                                                           'N',
	                                                           v_tecnologia,
	                                                           --TMM-04026 Ini
	                                                           DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_imsi_nue,NULL),
	                                                           DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_imei_nue,NULL),
	                                                           DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_gsm),v_icc_nue,NULL)
	                                                          );
								   --TMM-04026 Fin
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       v_venta := 0;
                                                                           ROLLBACK;
                                                                           --No se generaron cargos debemos deshacer Cambio de Serie.
                                                                           IF v_imei_ant IS NOT NULL and v_actabo!='SA'  THEN --Tecnologia de serie anterior es GSM
                                                                                     v_serie_ant_desh := v_imei_ant;
                                                                           else
                                                                                         v_serie_ant_desh := v_serie_ant;
                                                                           end if;
                                                                           IF v_imei_nue IS NOT NULL and v_actabo!='SA'  THEN --Tecnologia de serie nueva es GSM
                                                                                     v_serie_nue_desh := v_imei_nue;
                                                                           else
                                                                                         v_serie_nue_desh := v_serie;-- v_serie_nue;
                                                                           end if;

                                                                                P_PV_DESHACER_STOCK ( v_abonado,
                                                                                                                                         v_serie_nue_desh,
                                                                                                                                         v_serie_ant_desh,
                                                                                                                                         vp_error );
                                                                                if vp_error='0' then
                                                                                        P_DESHACER_REST_ABO (
                                                                                           v_abonado,
                                                                                           v_imei_nue,
                                                                                           v_serie,
                                                                                           vp_error);
                                                                                           if vp_error<>'0' then
                                                                                                        rollback;
                                                                                           else --ahott 05-01-2004 CH-021220031546
																								-- ahott 19-12-2003 CH-021220031546
																                                SELECT COD_SERVICIO into v_cod_servicio
																                                FROM GA_SUSPREHABO
																                                WHERE NUM_ABONADO = v_abonado
																                                AND IND_SINIESTRO = 1
																                                AND ROWNUM=1;
																								begin
																									SELECT NUM_SINIESTRO,COD_CAUSA
																									into v_siniestro,v_causa_sinies
																									FROM GA_HSINIESTROS
																									Where Num_abonado = v_abonado
																									And   cod_producto = V_PRODUCTO
																									And   Cod_estado = 'RE'
																									--TMM-04026 Ini
																									And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
																									--TMM-04026 Fin
																									Decode(v_actabo,'SA',v_serie_ant,v_imei_ant))
																									And Fec_siniestro in (select max(fec_siniestro)
																									from  Ga_Hsiniestros
																									Where Num_abonado = v_abonado
																									and   cod_producto = V_PRODUCTO
																									And   Cod_estado = 'RE'
																									--TMM-04026 Ini
																									And   Num_serie = DECODE(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tecnologia),GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(v_tec_dma),v_serie_ant,
																									--TMM-04026 Fin
																									Decode(v_actabo,'SA',v_serie_ant,v_imei_ant)));


																			                        INSERT INTO GA_SINIESTROS (
									                                                                NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, COD_ESTADO,
									                                                                NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO,
									                                                                FEC_FORMALIZA, FEC_ANULA, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
									                                                                ) (SELECT
									                                                                NUM_SINIESTRO, NUM_ABONADO, COD_PRODUCTO, COD_CAUSA, 'FO',
									                                                                NUM_TERMINAL, NUM_SERIE, FEC_SINIESTRO, COD_CARGOBASICO, COD_SERVICIO,
									                                                                FEC_FORMALIZA, FEC_ANULA, NUM_CONSTPOL, NUM_SOLLIQ, NUM_SERIEREP,IND_SUSP,TIP_TERMINAL
									                                                                FROM GA_HSINIESTROS WHERE NUM_SINIESTRO = v_siniestro);

									                                                                DELETE GA_HSINIESTROS WHERE NUM_SINIESTRO=v_siniestro;

									                                                                INSERT INTO GA_DETSINIE
                                                                (NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
									                                                                OBS_DETALLE )
                                                                (SELECT
                                                                NUM_SINIESTRO, COD_ESTADO, FEC_DETALLE, NOM_USUARORA,
									                                                                OBS_DETALLE
									                                                                FROM GA_HDETSINIE WHERE NUM_SINIESTRO = v_siniestro);

									                                                                DELETE GA_HDETSINIE where NUM_SINIESTRO = v_siniestro;
																								exception
																									when no_data_found then
																										 dbms_output.put_line('Siniestro no encontrado en historico');
																								end;
																                                UPDATE GA_SUSPREHABO
																                                SET FEC_REHABD = NULL
																                                WHERE NUM_ABONADO = v_abonado
																                                AND IND_SINIESTRO = 1
																                                AND COD_SERVICIO = v_cod_servicio;
																						   end if;
																								-- ahott 19-12-2003 CH-021220031546
                                                                                ELSE
                                                                                        rollback;
                                                                                END IF;
                                 END;

-- FIN Homolog. CH-021220031546
-- ****************
                                 COMMIT;
                              END IF;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 ROLLBACK;
                              WHEN OTHERS
                              THEN
                                 ROLLBACK;
                           END;
                     END;
               END;
            END IF;
         EXCEPTION
			when error_proceso then
			  	rollback;
            WHEN NO_DATA_FOUND THEN
               ROLLBACK;
			when others then
			   rollback;
         END;
      END IF; -- busca abonado CSP en Abocel, ya que no existe movimiento pendiente
   END LOOP;
   CLOSE c1;

exception
                         when OTHERs then
                                  rollback;
                                  vp_error:='99';

END;
/
SHOW ERRORS
