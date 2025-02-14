CREATE OR REPLACE procedure P_PV_DESHACER_STOCK
(
 vp_abonado                     IN ga_Abocel.num_abonado%type,
 vp_serie_nueva         IN al_series.num_serie%type,
 vp_serie_anterior       IN al_series.num_serie%type,
-- vp_imei_nue           IN ga_abocel.NUM_IMEI%type,
 vp_error                        OUT varchar2
)
 IS
  v_abonado              ga_abocel.num_abonado%type;
  v_serie_nue            al_series.num_serie%type;
  v_serie_ant            al_series.num_serie%type;
  --v_imei_nue           ga_Abocel.NUM_IMEI%type;

   gMovRetResVenta              varchar2(1):= '5';
   gMovRetSalTemArr     varchar2(1) := '7';
   gMovRetSalDefCont    varchar2(1):= 9;
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
   v_CodEstRevision             varchar2(3);
   v_CodBodComodato             varchar2(20);
   iSerieOldSalidaDefinitiva    integer;
   iSerieNewSalidaDefinitiva    integer;
   v_indprocedencia             varchar2(1);
   v_venta_interal              al_movimientos.NUM_TRANSACCION%type;
   v_estado                             al_series.COD_ESTADO%type;
   error_proceso                exception;
   error_pgainteral				exception;
   v_numtransacabo              ga_transacabo.NUM_TRANSACCION%type;
   v_cod_retorno					ga_transacabo.COD_RETORNO%type;
   v_des_cadena						ga_transacabo.DES_CADENA%type;

 BEGIN --(2)--

 vp_error:='-1';

 v_abonado:=vp_abonado;
 v_serie_nue:=vp_serie_nueva;
 v_serie_ant:=vp_serie_anterior;
 --v_imei_nue:=vp_imei_nue;
  -----------------------------------------------------------------
  --* Deshacer Operaciones de Stock                                                        *
  --* La serie nueva antes de devolverla almacen no debe existir  *
  --* para otro abonado                                           *
  -----------------------------------------------------------------
  select num_serie into v_serie_nue from ga_abocel
  where num_abonado!=v_abonado
  AND num_serie=v_serie_nue
  AND cod_situacion !='BAA';

   vp_error:='1';

 EXCEPTION
           WHEN NO_DATA_FOUND THEN
  BEGIN --(3)--

           iSerieNewSalidaDefinitiva:=0;

   BEGIN
           select cod_estado,tip_stock     ,cod_bodega   ,cod_articulo,cod_uso
           into   v_estado  ,v_tipstock_ori,v_bodega_ori , v_articulo ,v_uso
           from al_series where num_serie=v_serie_nue;
   Exception
                When no_data_found      then
                         iSerieNewSalidaDefinitiva:=1;
   End;

   if iSerieNewSalidaDefinitiva=0 then
           --   vp_error:='3.1';
                   if v_estado=8 then--Si la serie es Comodato
                   --      vp_error:='3.2';
                           ------------------------------------------------------
                           --                           Devolver serie nueva                       --
                           ------------------------------------------------------
                            sTipStockMercad:=ge_fn_devvalparam('GA', 1, 'COD_TIPSTOCKMERC');
                                sEstadoNuevo:=ge_fn_devvalparam('GA', 1, 'COD_ESTNUEVO');
                                v_estado_ori:=v_estado;
                                v_estado_dest:= to_number(sEstadoNuevo);
                                v_tipstock_dest:=to_number(sTipStockMercad);
                        --       vp_error:='3.3';
                                --Obtener bodega Actual
                                --que deberia ser la bodega comodato
                                select cod_bodega into v_bodega_ori
                                from al_series
                                where num_serie = v_serie_nue;
                                /*select cod_bodega into v_bodega_ori
                                from ga_equipaboser where num_abonado = v_abonado
                                and num_serie=v_serie_nue
                                and     fec_alta = (select max(fec_alta)
                                                                from ga_equipaboser
                                                                where num_abonado = v_abonado
                                                                and num_serie=v_serie_nue);*/

                                -- Obtener bodega anterior desde la tabla al_movimiento
                                select cod_bodega into v_bodega_dest from al_movimientos
                                where num_serie = v_serie_nue
                                and cod_bodega_dest=v_bodega_ori
                                and tip_movimiento=13
                                and fec_movimiento = (select max(fec_movimiento) from al_movimientos
                                                                         where num_serie=v_serie_nue and tip_movimiento=13);
                        --       vp_error:='3.4';
                                -- Devolver a la almacen como equipo nuevo
                                select al_seq_mvto.nextval into v_al_movim from dual;
                                INSERT INTO AL_MOVIMIENTOS ( NUM_MOVIMIENTO, TIP_MOVIMIENTO, FEC_MOVIMIENTO, TIP_STOCK, COD_BODEGA,
                                COD_ARTICULO, COD_USO, COD_ESTADO, NUM_CANTIDAD, COD_ESTADOMOV, NOM_USUARORA, TIP_STOCK_DEST,
                                COD_BODEGA_DEST, COD_USO_DEST, COD_ESTADO_DEST, NUM_SERIE, NUM_DESDE, NUM_HASTA, NUM_GUIA,
                                PRC_UNIDAD, COD_TRANSACCION, NUM_TRANSACCION, NUM_SERIEMEC, NUM_TELEFONO, CAP_CODE, COD_PRODUCTO,
                                COD_CENTRAL, COD_MONEDA, COD_SUBALM, COD_CENTRAL_DEST, COD_SUBALM_DEST, NUM_TELEFONO_DEST, COD_CAT,
                                COD_CAT_DEST, IND_TELEFONO, PLAN, CARGA, NUM_SEC_LOCA, COD_HLR,
                                COD_PLAZA ) VALUES (v_al_movim, 13,  SYSDATE , v_tipstock_ori, v_bodega_ori
                                , v_articulo, v_uso, v_estado_ori, 1, NULL, USER, v_tipstock_dest, v_bodega_dest, NULL,
                                  v_estado_dest, v_serie_nue, 0, NULL, NULL
                                , NULL, 3, 0, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
                                , NULL, NULL, NULL, NULL, NULL, NULL);
                        --       vp_error:='3.5';
                  else
                                raise error_proceso;
                  end if;
        else --Serie con salida definitiva --
                 -- se debe devolver a almacen --

                 --Validemos que esta sea interna --

                 select ind_procequi,tip_stock,cod_bodega,cod_articulo,cod_uso,cod_estado
                 into v_indprocedencia,v_tipstock_dest,v_bodega_dest,v_articulo,v_uso,v_estado_dest
                 from ga_equipaboser
                 where num_abonado=v_abonado
                           and num_serie=v_serie_nue
                           and fec_alta = (select max(fec_alta)
                                                          from ga_equipaboser
                                                          where num_abonado=v_abonado
                                                          and num_serie=v_serie_nue);

                 if v_indprocedencia='I' then

                          select GA_SEQ_TRANSACABO.nextval
                          into v_numtransacabo from dual;

                          SELECT NUM_TRANSACCION into v_venta_interal FROM AL_MOVIMIENTOS
                          WHERE NUM_MOVIMIENTO=(SELECT MAX(NUM_MOVIMIENTO)
                                                                    FROM AL_MOVIMIENTOS
                                                                        WHERE TIP_MOVIMIENTO=3
                                                                        AND COD_TRANSACCION = 3
                                                                        AND NUM_SERIE =v_serie_nue);

                          P_GA_INTERAL ( v_numtransacabo,
                                                         gMovRetSalDefCont,
                                                         v_tipstock_dest,
                                                         v_bodega_dest,
                                                         v_articulo,
                                                         v_uso,
                                                         v_estado_dest,
                                                         v_venta_interal,
                                                         '1',
                                                         v_serie_nue,
                                                         '0' );

						 select cod_retorno,des_cadena into v_cod_retorno,v_des_cadena
						 from ga_transacabo
						 where num_transaccion = v_numtransacabo;

						 if v_cod_retorno = 0 then
						 	if v_des_cadena is null then
						 	   dbms_output.put_line('Error ejecutando actualizacion de stock.');
						 	   raise error_pgainteral;
							end if;
						 else
						 	 dbms_output.put_line('Error ejecutando actualizacion de stock.['||v_numtransacabo||':'||v_des_cadena||']');
						 	 raise error_pgainteral;
						 end if;
                 end if;

        end if;--Fin Devolucion serie Nueva --

        -----------------------------------------------
        -- ** Serie Anterior **************************
        -----------------------------------------------
        BEGIN --(5) --
                   -- Debemos validar el estado de la serie anterior
                   -- * En el caso de un abonado comodato la serie antigua esta
                   --    con estado revison (15), la cual, debe volver a Comodato (8)
                   -- * En el caso que haya tenido salida defintiva no existe procesamiento
                   -- * Checkearemos su consistencia validando que
                   --    no exista para ningun abonado
                   select num_serie into v_serie_ant from ga_abocel
                   where num_abonado>0 and num_serie=v_serie_ant and cod_situacion != 'BAA';
                   vp_error:='6' ;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  BEGIN --(4)--
                                           -- Para asignar nuevamente serie antigua al abonado

                                           iSerieOldSalidaDefinitiva:=0;

                                           BEGIN
                                                   select cod_estado,cod_uso,cod_articulo,tip_stock,cod_bodega
                                                   into   v_estado, v_uso,v_articulo,v_tipstock_ori,v_bodega_ori
                                                   from al_series where num_serie=v_serie_ant;
                                           exception
                                                        --La serie no fue encontrada
                                                        -- Tenia salida definitiva OK!!
                                                        when NO_DATA_FOUND then
                                                                        iSerieOldSalidaDefinitiva:=1;
                                           end;

                                           if iSerieOldSalidaDefinitiva = 0 Then
                                                           v_CodEstRevision := ge_fn_devvalparam('GA', 1, 'COD_ESTREVISION');
                                                           v_CodBodComodato := ge_fn_devvalparam('GA', 1, 'COD_BODEGA_COMODATO');
                                                           v_estado_ori:=to_number(v_CodEstRevision);
                                                           v_bodega_dest:= to_number(v_CodBodComodato);
                                                                -- Devolver a comodato la serie anterior
                                                                --debe estar en revision (15)
                                                                --solo cambiaremos el estado de revision a comodato
                                                            if v_estado=v_estado_ori and v_bodega_ori=v_bodega_dest then
                                                                        --select GA_SEQ_TRANSACABO.nextval into v_numtransacabo from dual;
                                                                        select al_seq_mvto.nextval into v_al_movim from dual;
                                                                        INSERT INTO AL_MOVIMIENTOS ( NUM_MOVIMIENTO, TIP_MOVIMIENTO, FEC_MOVIMIENTO, TIP_STOCK, COD_BODEGA,
                                                                        COD_ARTICULO, COD_USO, COD_ESTADO, NUM_CANTIDAD, COD_ESTADOMOV, NOM_USUARORA, TIP_STOCK_DEST,
                                                                        COD_BODEGA_DEST, COD_USO_DEST, COD_ESTADO_DEST, NUM_SERIE, NUM_DESDE, NUM_HASTA, NUM_GUIA,
                                                                        PRC_UNIDAD, COD_TRANSACCION, NUM_TRANSACCION, NUM_SERIEMEC, NUM_TELEFONO, CAP_CODE, COD_PRODUCTO,
                                                                        COD_CENTRAL, COD_MONEDA, COD_SUBALM, COD_CENTRAL_DEST, COD_SUBALM_DEST, NUM_TELEFONO_DEST, COD_CAT,
                                                                        COD_CAT_DEST, IND_TELEFONO, PLAN, CARGA, NUM_SEC_LOCA, COD_HLR,
                                                                        COD_PLAZA ) VALUES (v_al_movim, 19,  SYSDATE , v_tipstock_ori, v_bodega_ori
                                                                        , v_articulo, v_uso, v_estado, 1, NULL, USER, NULL, NULL, NULL,
                                                                          8, v_serie_ant, 0, NULL, NULL
                                                                        , NULL, 3, 0, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
                                                                        , NULL, NULL, NULL, NULL, NULL, NULL);

                                                                         vp_error:='0';
                                                                        ---------------------------------------
                                                                        -- Deshacer todos los otros cambios --                                                                                                                                          -------------------------------------
                                                                        ---------------------------------------
                                                                else
                                                                        --Si la serie anterior no esta en comodato o revision
                                                                        -- existe una inconsistencia que debe ser checkeada
                                                                        -- por lo tanto esta operacion debe cancelarse
                                                                        if v_estado!=8 then
                                                                           raise error_proceso;
                                                                        else
                                                                                vp_error:='0';
                                                                                -- Deshacer datos de abonado
/*                                                                              P_DESHACER_ABO (v_abonado,
                                                                                  v_imei_nue,
                                                                                  v_serie_nue,
                                                                                  vp_error
                                                                      );
                                                                                  if vp_error!=0 then
                                                                                         raise error_proceso;
                                                                                  end if;*/
                                                                        end if;
                                                                end if;
                                                else --serie anterior con salida definitiva
                                                         vp_error:='0';
                                                end if;
                                  Exception
                                        When error_proceso then
                                                vp_error:='4';
                                        WHEN Others then
                                                vp_error:='5';
                                  END; --(4)--
                WHEN OTHERS THEN
                                 vp_error:='8';
        END; --(5)--
    EXCEPTION
			 	When error_pgainteral then
					 vp_error:='11';
                When error_proceso then
                                 vp_error:='2';
                WHEN OTHERS THEN
                                 --NULL;
                                 vp_error:='3';
        END;--(3) --
                WHEN OTHERS THEN
                                 vp_error:='7';
END; --(2)--
/
SHOW ERRORS
