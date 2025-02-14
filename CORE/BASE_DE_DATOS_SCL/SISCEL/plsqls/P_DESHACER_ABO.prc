CREATE OR REPLACE PROCEDURE P_DESHACER_ABO (
   vp_numabonado   IN       ga_abocel.num_abonado%TYPE,
   vp_imei              IN                ga_abocel.NUM_IMEI%type,
   vp_numserie  IN                ga_abocel.NUM_SERIE%type,
   vp_error     OUT       VARCHAR2

)
IS
   v_producto                   ga_abocel.COD_PRODUCTO%Type;
   v_serie_nue          ga_abocel.num_serie%TYPE;
   v_terminal_nue       ga_abocel.tip_terminal%TYPE;
   v_cliente            ga_abocel.cod_cliente%TYPE;
   v_central            ga_abocel.cod_central%TYPE;
   v_estado             al_series.cod_estado%TYPE;
   v_fila_reserva       ROWID;
   v_fec_cambio         ga_equipaboser.fec_alta%TYPE;
   v_ind_procequi       ga_equipaboser.ind_procequi%TYPE;
   v_fila_equipaboser   ROWID;
   v_fila_modabocel     ROWID;
   v_serie_ant          ga_abocel.num_serie%TYPE;
   v_terminal_ant       ga_abocel.tip_terminal%TYPE;
   v_venta              ga_ventas.num_venta%TYPE;
   v_fila_venta         ROWID;
   v_transaccion        ga_transacabo.num_transaccion%TYPE;
   vp_tabla             VARCHAR2 (30);
   vp_proc              VARCHAR2 (30);
   vp_act               VARCHAR2 (2);
   v_abonado            ga_abocel.num_abonado%TYPE;
   vp_estado            icc_movimiento.cod_estado%TYPE;
   v_movimiento         icc_movimiento.num_movimiento%TYPE;
   v_celular            ga_abocel.num_celular%TYPE;
   filas_equipos        NUMBER (5);
   v_serie              ga_abocel.num_serie%TYPE;
   v_tip_terminal       ga_abocel.tip_terminal%TYPE;
   v_cod_central        ga_abocel.cod_central%TYPE;
   v_serie_hex_ant      ga_abocel.num_seriehex%TYPE;
   v_serie_hex_nue      ga_abocel.num_seriehex%TYPE;
   v_sql_errm           VARCHAR2 (60);
   v_sqlcode            VARCHAR2 (60);
   v_fec_alta           ga_abocel.fec_alta%TYPE;
   v_eqprestado         ga_abocel.ind_eqprestado%TYPE;
   error_proceso        EXCEPTION;

   v_imei_nue           ga_abocel.num_imei%TYPE;
   v_imei_ant           ga_abocel.num_imei%TYPE;
   v_filas_ant_equ      NUMBER(1);
   v_filas_nue_equ      NUMBER(1);
   v_tecnologia_tdma    ged_parametros.val_parametro%TYPE;
   v_tecnologia_gsm     ged_parametros.val_parametro%TYPE;
   v_actcen             ga_actabo.cod_actcen%TYPE;
   v_imsi_nue           icc_movimiento.imsi_nue%TYPE;
   v_imsi_ant           icc_movimiento.IMSI%TYPE;
   v_tecnologia_nue     ged_parametros.val_parametro%TYPE;
   v_tecnologia_ant     ged_parametros.val_parametro%TYPE;
   v_tecnologia_ori     ged_parametros.val_parametro%TYPE;
   v_tecnologia         ged_parametros.val_parametro%TYPE;
   v_codcentral_ori     ga_celnum_uso.cod_central%TYPE;
   v_actabo             ga_actabo.cod_actabo%TYPE;
   v_icc_nue            icc_movimiento.icc_nue%TYPE;
   v_icc_ant            icc_movimiento.icc%TYPE;
   v_serie_icc          icc_movimiento.num_serie%TYPE;
   v_serie_nue_icc      icc_movimiento.num_serie_nue%TYPE;

   --PAGC
   /*v_fec_ultmod_abo   ga_abocel.fec_ultmod%TYPE;
   v_serie_modabocel    ga_modabocel.num_serie%TYPE;
   v_imei_modabocel     ga_modabocel.num_imei%TYPE;
   v_tec_modabocel      ga_modabocel.cod_tecnologia%TYPE;*/
   v_numtransacabo              ga_transacabo.NUM_TRANSACCION%TYPE;
--   gMovResVenta         varchar2(1):= '4';
   gMovRetResVenta              varchar2(1):= '5';
   gMovRetSalTemArr     varchar2(1) := '7';
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
   v_uso                                al_series.cod_uso%type;
   v_num_simcard                ga_abocel.NUM_SERIE%type;
   v_CodEstRevision             varchar2(3);
   v_CodBodComodato             varchar2(20);
   error                                varchar2(2);
   v_indprocequi_aboser ga_equipaboser.IND_PROCEQUI%type;
   ind_eqprestado_modabo ga_modabocel.IND_EQPRESTADO%type;
   fec_prorroga_modabo   ga_modabocel.FEC_PRORROGA%type;
   cod_central_modabo    ga_modabocel.COD_CENTRAL%type;
   cod_planserv_modabo   ga_modabocel.COD_PLANSERV%type;
   v_fec_mod_modabo              ga_modabocel.FEC_MODIFICA%type;
   v_contrato_contcta    ga_CONTCTA.NUM_CONTRATO%type;
   v_tipcontrato_contcta ga_CONTCTA.cod_tipcontrato%type;
   v_anexo_contcta               ga_CONTCTA.num_anexo%type;
   v_fec_contcta                 ga_CONTCTA.fec_contrato%type;
   v_cuenta                              ga_abocel.cod_cuenta%type;
   v_tipcontrato                 ga_abocel.cod_tipcontrato%type;
   v_contrato                    ga_abocel.num_contrato%type;
   v_anexo                               ga_abocel.num_anexo%type;
   v_fila_contcta                rowid;
   v_fec_fincont_modabocel ga_modabocel.FEC_FINCONTRATO%type;
   v_clase_servicio              ga_abocel.clase_servicio%type;
   v_cadenaact                     ga_abocel.clase_servicio%type;
   v_cadenades                     ga_abocel.clase_servicio%type;
   v_error                                 varchar(10);
   v_cod_retorno					ga_transacabo.COD_RETORNO%type;
   v_des_cadena						ga_transacabo.DES_CADENA%type;
      bHayCargos						boolean;
	  v_fec_cargos						ge_cargos.FEC_ALTA%type;
BEGIN
      v_imei_nue:=vp_imei;
          v_serie_nue:=vp_numserie;
          v_num_simcard:=vp_numserie;
          v_abonado:=vp_numabonado;
          v_tecnologia_gsm:=ge_fn_devvalparam('GA', 1, 'TECNOLOGIA_GSM');
          v_tecnologia_tdma:=ge_fn_devvalparam('GA', 1, 'TECNOLOGIA_TDMA');

            BEGIN
               vp_tabla := 'GA_ABOCEL';
               vp_act := 'S';
               SELECT num_serie, tip_terminal, cod_cliente, cod_central, num_imei, cod_cuenta,cod_tipcontrato,num_contrato,num_anexo,clase_servicio,cod_producto
                 INTO v_serie_nue, v_terminal_nue, v_cliente, v_central, v_imei_nue,v_cuenta,v_tipcontrato,v_contrato,v_anexo,v_clase_servicio,v_producto
                 FROM ga_abocel
                WHERE num_abonado = v_abonado;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  vp_tabla := 'GA_ABOAMIST';
                  vp_act := 'S';
                  SELECT num_serie, tip_terminal, cod_cliente, cod_central, num_imei,cod_cuenta,cod_tipcontrato,num_contrato,num_anexo,clase_servicio,cod_producto
                    INTO v_serie_nue, v_terminal_nue, v_cliente, v_central, v_imei_nue,v_cuenta,v_tipcontrato,v_contrato,v_anexo,v_clase_servicio,v_producto
                    FROM ga_aboamist
                   WHERE num_abonado = v_abonado;
            END;
                  vp_tabla := 'AL_SERIES';
                  vp_act := 'S';
                                        BEGIN
                          SELECT cod_estado
                            INTO v_estado
                            FROM al_series
                           WHERE num_serie = v_imei_nue
                             AND cod_estado != 8;
                                                 v_serie_nue:=v_imei_nue;
                                        exception
                                                when NO_DATA_FOUND      then
                                                BEGIN
                                  SELECT cod_estado
                                    INTO v_estado
                                    FROM al_series
                                   WHERE num_serie = v_serie_nue
                                     AND cod_estado != 8;
                                                exception
                                                --Equipo con salida definitiva o externo
                                                        when no_data_found then
                                                        v_estado:=1;
                                                END;
                                        END;

                  IF    v_estado = 7
                     OR v_estado = 1
                  THEN
                     BEGIN
                        vp_tabla := 'GA_RESERVART 1';
                        vp_act := 'S';
                        IF v_estado = 7
                        THEN
                           SELECT ROWID
                             INTO v_fila_reserva
                             FROM ga_reservart
                            WHERE num_serie = v_serie_nue
                              AND ROWNUM = 1;
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
                                    SELECT num_serie,    tip_terminal,  num_imei
                                      INTO v_serie_ant,  v_terminal_ant,v_imei_ant
                                      FROM ga_equipaboser
                                     WHERE num_abonado = v_abonado
                                       AND fec_alta    IN (SELECT MAX (fec_alta)
                                                             FROM ga_equipaboser
                                                            WHERE num_abonado = v_abonado
                                                              AND fec_alta < v_fec_cambio);

                              ELSIF v_filas_ant_equ = 2 THEN
                                    SELECT num_serie,    tip_terminal,  num_imei
                                      INTO v_serie_ant,  v_terminal_ant,v_imei_ant
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
                                  v_tecnologia := v_tecnologia_gsm;
                                                                  v_serie_hex_ant := '0';
                              ELSE
                                  -- TECNOLOGMA ANTIGUA ES TDMA
                                  v_tecnologia := v_tecnologia_tdma;
                                                                  --p_transforma_hexa (v_serie_nue, v_serie_hex_ant);
                                  p_transforma_hexa (v_serie_ant, v_serie_hex_ant); -- ahott CH-190620030922 23-06-2003
                              END IF;

                              vp_tabla := 'GA_MODABOCEL';
                              vp_act := 'S';
                              SELECT MAX (ROWID)
                                INTO v_fila_modabocel
                                FROM ga_modabocel
                               WHERE num_abonado = v_abonado
                                 AND cod_tipmodi in ('CE', 'TG', 'GT', 'ET', 'EG','SA')
                                 AND nvl(num_serie,NVL(v_serie_ant,'0')) = NVL(v_serie_ant,'0')
                                                                 AND nvl(num_imei, NVL(v_imei_ant,'0' )) = NVL(v_imei_ant, '0')
                                 AND TRUNC (fec_modifica) = TRUNC (v_fec_cambio)
                                                                 AND ROWNUM=1 --Evitar que seleccione mas de un registro en el caso que exista
                                                                 Order by fec_modifica desc;--mas de un cambio de serie en un dia

                              vp_tabla := 'GE_CARGOS';
                              vp_act := 'S';

                              BEGIN
							  	 bHayCargos:=FALSE;
                                 SELECT num_venta,fec_alta
                                   INTO v_venta,v_fec_cargos
                                   FROM ge_cargos
                                  WHERE cod_cliente = v_cliente
                                    AND num_abonado = v_abonado
                                    AND num_serie = v_serie_nue
                                    AND TRUNC (fec_alta) = TRUNC(v_fec_cambio);
							  	 bHayCargos:=TRUE;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    v_venta := 0;
                              END;

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

                                                                         delete ga_reservart
                                                                         where rowid = v_fila_reserva;

                                                                  EXCEPTION
                                                                                   WHEN OTHERS THEN
                                                                                                RAISE error_proceso;
                                                                  END;
                                                          End if;

                                                          -- Se debe revisar la Simcard para el caso de cambio de tecnologia
                                                          -- TDMA -> GSM  --Existen 2 entradas en la tabla GA_EQUIPABOSER
                                                          if v_imei_nue Is Not Null and
                                                                                        v_imei_ant is Null and
                                                                                                           vp_numserie != v_serie_ant --!CE
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

                              vp_tabla := 'GA_EQUIPABOSER';
                              vp_act := 'D';

                              DELETE  ga_equipaboser
                               WHERE  num_abonado = v_abonado
                                 AND  fec_alta = (SELECT MAX(fec_alta)
                                                    FROM ga_equipaboser
                                                   WHERE num_abonado = v_abonado
                                                     AND num_serie   = v_serie_nue);

                              vp_tabla := 'GA_EQUIPABOSER';
                              vp_act := 'U';

                              UPDATE  ga_equipaboser
                                                           SET num_imei = v_imei_ant
                               WHERE num_abonado = v_abonado
                               AND  num_serie = v_serie_ant
                                                           AND  fec_alta    IN (SELECT MAX (fec_alta)
                                                             FROM ga_equipaboser
                                                            WHERE num_abonado = v_abonado AND
                                                                  fec_alta < v_fec_cambio);

                              vp_tabla := 'GE_CARGOS';
                              vp_act := 'E';

							   --Si existe venta
							   if v_venta > 0 then
							   	  Delete ge_cargos where num_venta=v_venta;

	                              vp_tabla := 'GA_VENTAS';
	                              vp_act := 'D';

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
                                 'P_DEL_CAMSERIE',
                                 vp_error
                              );

                              IF vp_error <> '0'
                              THEN
                                 RAISE error_proceso;
                              END IF;

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
                                     cod_situacion    = 'AAA',
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
                                     cod_situacion      = 'AAA',
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

                                                           -- Solo si existio un cambio de tecnologia
                              IF v_terminal_ant <> v_terminal_nue THEN
                                 vp_tabla := 'PV_RESTAURA_CAMBTEC_SS_PR';
                                 vp_act := 'E';
                                                                 PV_RESTAURA_CAMBTEC_SS_PR(v_abonado,v_fec_cambio,'D',v_cadenaact,v_cadenades,v_error,v_sqlcode);
                                                                 if v_error!='0' then
                                                                        vp_error:=v_error;
                                                                        RAISE error_proceso;
                                                                 end if;
                                 /*SELECT ga_seq_transacabo.NEXTVAL
                                   INTO v_transaccion
                                   FROM DUAL;
                                 p_openserv_terminal (
                                    v_transaccion,
                                    1,
                                    v_abonado,
                                    v_terminal_ant,
                                    v_central,
                                    0
                                 );*/
                              END IF;

                              vp_error := '0';
                              vp_tabla := 'FA_HISTDOCU';
                              vp_act := 'U';
                              p_upd_histdocu (v_cliente, v_venta, vp_error);

                              IF vp_error <> '0'
                              THEN
                                 RAISE error_proceso;
                              END IF;

                              --COMMIT;

                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                                             vp_error:='5';
                                 ROLLBACK;
                              WHEN error_proceso
                              THEN

															 vp_error:='6';
                                 ROLLBACK;
                              WHEN OTHERS
                              THEN
                                                                 vp_error:='7';
                                 ROLLBACK;
                           END;
                        END IF;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                                                   vp_error:='8';
                           ROLLBACK;
                     END;
                  END IF;
        exception
                         when OTHERs then
                                  rollback;
                                  vp_error:='9';
END;
/
SHOW ERRORS
