CREATE OR REPLACE PROCEDURE P_AL_TRATAMIENTO_MASIVO_WEB(v_num_traspaso_mas IN CHAR,v_cod_pedido in npt_pedido.cod_pedido%type,
                                                        v_errores out AL_ERRORES_WEB%ROWTYPE,V_ERR_PEDIDO OUT NUMBER)  IS
  v_num_traspaso al_traspasos.num_traspaso%type;
  v_cod_bodega_ori_peti al_traspasos.cod_bodega_ori%type;
  v_cod_bodega_dest_peti al_traspasos.cod_bodega_dest%type;
  v_cod_articulo_peti al_lin_peticion.cod_articulo%type;
  v_can_traspaso_peti al_lin_peticion.can_traspaso%type;
  v_tip_movim_aut al_traspasos.tip_movim_aut%type;
  v_tip_movim_env al_traspasos.tip_movim_env%type;
  v_tip_movim_rec al_traspasos.tip_movim_rec%type;
  v_lin_traspaso al_lin_traspaso.lin_traspaso%type;
  v_tip_stock al_lin_traspaso.tip_stock%type;
  v_cod_articulo al_lin_peticion.cod_articulo%type;
  v_uso al_lin_traspaso.cod_uso%type;
  v_estado al_lin_traspaso.cod_estado%type;
  v_can_traspaso al_lin_traspaso.can_traspaso%type;
  v_num_serie al_ser_traspaso.num_serie%type;
  v_cap_code  al_ser_traspaso.cap_code%type;
  v_num_telefono al_ser_traspaso.num_telefono%type;
  v_cod_central al_ser_traspaso.cod_central%type;
  v_cod_subalm al_ser_traspaso.cod_subalm%type;
  v_cod_cat al_ser_traspaso.cod_cat%type;
  v_num_seriemec al_ser_traspaso.num_seriemec%type;
  v_tip_stock_ori al_lin_traspaso.tip_stock%type;
  v_tip_stock_des al_lin_traspaso.tip_stock%type;
  v_num_peticion al_traspasos.num_peticion%type;
  v_cod_motivo al_cab_peticion.cod_motivo%type;
  v_fecha_traspaso_masivo al_traspasos_masivo.fec_traspaso_masivo%type;
  v_usu_traspaso_masivo al_traspasos_masivo.usu_traspaso_masivo%type;
  v_total_series NUMBER;
  v_total_traspaso NUMBER;
  v_total_series_norep NUMBER;
  v_total_series_rep NUMBER;
  -- variables para select del num_telefono
  v_num_serie_tel al_series.num_serie%type;
  v_cap_code_tel al_series.cap_code%type;
  v_num_telefono_tel al_series.num_telefono%type;
  v_cod_central_tel al_series.cod_central%type;
  v_cod_subalm_tel al_series.cod_subalm%type;
  v_cod_cat_tel al_series.cod_cat%type;
  v_num_seriemec_tel al_series.num_seriemec%type;
  v_cod_proceso_aut al_procesos_tipmovim.cod_proceso%type;
  v_cod_proceso_env al_procesos_tipmovim.cod_proceso%type;
  v_cod_proceso_rec al_procesos_tipmovim.cod_proceso%type;
  v_num_traspaso_masivo al_traspasos_masivo.num_traspaso_masivo%type;
        v_num_cantidad al_traspasos_masivo.num_cantidad%type;
        v_ind_seriado  al_articulos.ind_seriado%type;
        v_can_stock    al_stock.can_stock%type;
  v_nNumero_0             number(2);
  v_nNumero_1             number(2);
  v_nNumero_2             number(2);
  v_vCadenaPD             varchar(2);
  v_vCadenaAB             varchar(2);
  v_vCadenaPA             varchar(2);
  v_vCadenaAU             varchar(2);
  v_vCadenaEN             varchar(2);
  v_vCadenaRM             varchar(2);
  v_vCadenaCE             varchar(2);
  v_vCadenaPW             varchar(2);
  v_vCadenaPR             varchar(2);
  v_vCadenaAP             varchar(2);
  v_cNumero_0             char(1);
  CURSOR c_ser_seriado is
  select cod_articulo,num_cantidad,num_traspaso_masivo,num_serie from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_masivo
    and cod_estado_tras ='PW';
  CURSOR c_ser_telefono is
  select num_serie,cod_articulo from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_masivo
    and cod_estado_tras ='PW';
  CURSOR c_cab_peticion is
  select COD_BODEGA_ORI, COD_BODEGA_DEST, TIP_STOCK, TIP_STOCK_DEST,
    NUM_TRASPASO, USU_TRASPASO_MASIVO, FEC_TRASPASO_MASIVO
  from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_mas
    and cod_estado_tras ='PW'
    group by
    COD_BODEGA_ORI, COD_BODEGA_DEST, TIP_STOCK, TIP_STOCK_DEST,
    NUM_TRASPASO, USU_TRASPASO_MASIVO, FEC_TRASPASO_MASIVO;
  CURSOR c_lin_peticion is
  select COD_ARTICULO, sum(num_cantidad)
  from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_masivo
    and num_traspaso = v_num_traspaso
    group by COD_ARTICULO;
  CURSOR c_lin_traspaso is
        select  TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, sum(num_cantidad)
  from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_masivo
    and num_traspaso = v_num_traspaso
    group by
    TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO;
  CURSOR c_ser_traspaso is
        select  NUM_SERIE, CAP_CODE, NUM_TELEFONO, COD_CENTRAL,
    COD_SUBALM, COD_CAT, NUM_SERIEMEC,COD_ARTICULO
   from al_traspasos_masivo
    where num_traspaso_masivo = v_num_traspaso_masivo
    and num_traspaso = v_num_traspaso
    and cod_articulo = v_cod_articulo
    and tip_stock = v_tip_stock
    and cod_uso = v_uso
    and cod_estado = v_estado;
    ERROR_TRASPASO EXCEPTION;
BEGIN
    v_nNumero_0 := 0;
    v_nNumero_1 := 1;
    v_nNumero_2 := 2;
    v_vCadenaPD := 'PD';
    v_vCadenaAB := 'AB';
    v_vCadenaPA := 'PA';
    v_vCadenaAU := 'AU';
    v_vCadenaEN := 'EN';
    v_vCadenaRM := 'RM';
    v_vCadenaCE := 'CE';
    v_vCadenaPW := 'PW';
    v_vCadenaPR := 'PR';
    v_vCadenaAP := 'AP';
    v_cNumero_0 := '0';
    v_cod_motivo := 1;
    v_cod_proceso_aut := 'ALARTRA';
    v_cod_proceso_env := 'ALDMTRA';
    v_cod_proceso_rec := 'ALRMTRA';
    v_num_traspaso_masivo := to_number(v_num_traspaso_mas);
    -- Cod_Motivo , No distinguido, mete el primero que aparezca, no importa
    -- Usa los mismos tipos de movimientos tres procesos, cada uno con un tipo de stock distinguido
    -- que tiene que estar en al_procesos_tipmovim
    --Verificacion previa de series no repetidas y series en almacen
    select count(distinct num_serie) into v_total_series_norep
    from al_traspasos_masivo
    where num_traspaso_masivo > v_nNumero_0
    and num_traspaso_masivo=v_num_traspaso_mas
    and cod_estado_tras = v_vCadenaPW;
    select count(num_serie) into v_total_series_rep
    from al_traspasos_masivo
    where num_traspaso_masivo > v_nNumero_0
    and num_traspaso_masivo=v_num_traspaso_mas
    and cod_estado_tras =v_vCadenaPW;
    if v_total_series_norep <> v_total_series_rep then
       SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
       V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
       V_ERRORES.FEC_ERROR:=SYSDATE;
       V_ERRORES.GLOSA_ERROR_TRASPASO:= 'SERIES REPETIDAS PARA TRASPASO';
       V_ERRORES.COD_ESTADO_ERROR:= 'PR';
       v_errores.glosa_error_venta := SQLERRM;
       V_ERR_PEDIDO:= 1;
       raise ERROR_TRASPASO;
    end if;

    select count(v_nNumero_1)
    into v_total_series
    from al_series a,al_traspasos_masivo b, al_articulos c
    where c.ind_seriado = v_nNumero_1
    and b.num_traspaso_masivo >  v_nNumero_0
    and b.cod_estado_tras = v_vCadenaPW
    and b.num_traspaso_masivo = v_num_traspaso_masivo
    and b.cod_articulo = c.cod_articulo
    and a.num_serie = b.num_serie
    and a.tip_stock = b.tip_stock
    and a.cod_uso = b.cod_uso
    and a.cod_bodega = b.cod_bodega_ori
    and a.cod_estado = b.cod_estado
    and a.cod_articulo = b.cod_articulo ;

    select count(v_nnumero_1) into v_total_traspaso
    from al_traspasos_masivo a, al_articulos b
    where b.ind_seriado = v_nNumero_1
    and a.num_traspaso_masivo > v_nNumero_0
    and a.cod_estado_tras = v_vCadenaPW
    and a.num_traspaso_masivo = v_num_traspaso_masivo
    and a.cod_articulo = b.cod_articulo;

    if v_total_traspaso <> v_total_series then
       SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
       V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
       V_ERRORES.FEC_ERROR:=SYSDATE;
       V_ERRORES.GLOSA_ERROR_TRASPASO:= 'INFORM.AL_SERIES<>AL_TRASPASOS_MASIVO';
       V_ERRORES.COD_ESTADO_ERROR:= v_vCadenaPR;
       v_errores.glosa_error_venta := SQLERRM;
       V_ERR_PEDIDO:= 1;
       raise ERROR_TRASPASO;
    end if;
    select sum(a.num_cantidad) into v_num_cantidad
    from al_traspasos_masivo a, al_articulos b
    where a.num_traspaso_masivo > v_nNumero_0
    and a.num_traspaso_masivo = v_num_traspaso_masivo
    and a.cod_estado_tras = v_vCadenaPW
    and a.cod_articulo = b.cod_articulo
    and b.ind_seriado <> v_nNumero_1;
    select sum(a.can_stock) into v_can_stock
    from al_stock a,al_traspasos_masivo b, al_articulos c
    where b.num_traspaso_masivo > v_nNumero_0
    and b.cod_estado_tras = v_vCadenaPW
    and b.num_traspaso_masivo = v_num_traspaso_masivo
    and a.tip_stock = b.tip_stock
    and a.cod_uso = b.cod_uso
    and a.cod_bodega = b.cod_bodega_ori
    and a.cod_estado = b.cod_estado
    and a.cod_articulo = b.cod_articulo
    and b.cod_articulo = c.cod_articulo
    and c.ind_seriado <> v_nNumero_1;
    if v_num_cantidad > v_can_stock then
       SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
       V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
       V_ERRORES.FEC_ERROR:=SYSDATE;
       V_ERRORES.GLOSA_ERROR_TRASPASO:= 'SERIES FUERA DE STOCK';
       V_ERRORES.COD_ESTADO_ERROR:= v_vCadenaPR;
       v_errores.glosa_error_venta := SQLERRM;
       V_ERR_PEDIDO:= 1;
       raise ERROR_TRASPASO;
    end if;
    --Fin verificaciones previas
    --Tenemos que obtener los telefonos de las series de traspaso
    v_num_cantidad:=0;
    open c_ser_seriado;
         loop
             fetch c_ser_seriado into v_cod_articulo,v_num_cantidad,v_num_traspaso_masivo,v_num_serie;
                   exit when c_ser_seriado%NOTFOUND;
                       select ind_seriado into v_ind_seriado
                       from al_articulos where cod_articulo = v_cod_articulo;
                       if v_ind_seriado <> 1 then
                          select SUM(a.can_stock) into v_can_stock
                          from al_stock a,al_traspasos_masivo b
                          where b.num_traspaso_masivo > v_nNumero_0
                          and b.cod_estado_tras = v_vCadenaPW
                          and b.num_traspaso_masivo = v_num_traspaso_masivo
                          and a.cod_articulo = v_cod_articulo
                          and a.tip_stock = b.tip_stock
                          and a.cod_uso = b.cod_uso
                          and a.cod_bodega = b.cod_bodega_ori
                          and a.cod_estado = b.cod_estado
                          -- el valor de v_num_serie corresponde a un valor asignado para el ajuste de la tabla al_traspasos_masivos
                          -- esta tabla en el campo num_serie lo tiene como not null por lo cual para articulos no seriados le creamos
                          -- una serie ('NS<correlativo>') por esto que podemos realizar el join b.num_serie = v_num_serie
                          and b.num_serie = v_num_serie;
                          if v_can_stock = 0 then
                             -- rollback;
                             SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                             V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                             V_ERRORES.FEC_ERROR:=SYSDATE;
                             V_ERRORES.GLOSA_ERROR_TRASPASO:= 'SERIES SIN STOCK';
                             V_ERRORES.COD_ESTADO_ERROR:= v_vCadenaPR;
                             v_errores.glosa_error_venta := SQLERRM;
                             V_ERR_PEDIDO:= 1;
                             raise ERROR_TRASPASO;
                          end if;
                          if v_can_stock < v_num_cantidad then
                             -- rollback;
                             SELECT AL_SEQ_ERRORES_WEB.NEXTVAL  INTO V_ERRORES.NUM_ERROR FROM DUAL;
                             V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                             V_ERRORES.FEC_ERROR:=SYSDATE;
                             V_ERRORES.GLOSA_ERROR_TRASPASO:= 'STOCK MENOR AL SOLICITADO';
                             V_ERRORES.COD_ESTADO_ERROR:= v_vCadenaPR;
                             v_errores.glosa_error_venta := SQLERRM;
                             V_ERR_PEDIDO:= 1;
                             raise ERROR_TRASPASO;
                          end if;
                       end if;
         end loop;
    close c_ser_seriado;
    open c_ser_telefono;
         loop
            fetch c_ser_telefono into v_num_serie_tel,v_cod_articulo;
                  exit when c_ser_telefono%NOTFOUND;
                       select ind_seriado into v_ind_seriado
                       from al_articulos
                       where cod_articulo = v_cod_articulo;
                       if v_ind_seriado = 1 then
                          select CAP_CODE ,NUM_TELEFONO ,COD_CENTRAL ,
                                 COD_SUBALM ,COD_CAT, NUM_SERIEMEC
                                 into v_cap_code_tel, v_num_telefono_tel, v_cod_central_tel,
                                      v_cod_subalm_tel, v_cod_cat_tel, v_num_seriemec_tel
                          from al_series
                          where num_serie = v_num_serie_tel;
                          if v_num_telefono_tel is not null then
                          begin
                             update al_traspasos_masivo set cap_code = v_cap_code_tel,
                                    num_telefono = v_num_telefono_tel ,cod_central = v_cod_central_tel,
                                    cod_subalm = v_cod_subalm_tel ,cod_cat = v_cod_cat_tel ,
                                    num_seriemec = v_num_seriemec_tel
                             where num_traspaso_masivo = v_num_traspaso_masivo
                             and num_serie = v_num_serie_tel
                             and cod_estado_tras = v_vCadenaPW;
                             exception when others then

                             SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                             V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                             V_ERRORES.FEC_ERROR:=SYSDATE;
                             V_ERRORES.GLOSA_ERROR_TRASPASO:= 'UPDATE AL_TRASPASOS_MASIVO ';
                             V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                             v_errores.glosa_error_venta := SQLERRM;
                             V_ERR_PEDIDO:= 1;
                             raise ERROR_TRASPASO;

                          end;
                          end if;
                       end if;
         end loop;
    close c_ser_telefono;
    SELECT TIP_MOVIMIENTO into v_tip_movim_aut
    FROM AL_PROCESOS_TIPMOVIM
    WHERE COD_PROCESO = v_cod_proceso_aut and rownum < v_nNumero_2;
    SELECT TIP_MOVIMIENTO into v_tip_movim_env
    FROM AL_PROCESOS_TIPMOVIM
    WHERE COD_PROCESO = v_cod_proceso_env and rownum < v_nNumero_2;
    open c_cab_peticion;
           loop
              fetch c_cab_peticion into v_cod_bodega_ori_peti,
                    v_cod_bodega_dest_peti ,v_tip_stock_ori, v_tip_stock_des,
                    v_num_traspaso, v_usu_traspaso_masivo, v_fecha_traspaso_masivo;
                    exit when c_cab_peticion%NOTFOUND;
                    select AL_SEQ_PETICION_TRAS.NEXTVAL into v_num_peticion from dual;
                    begin
                         INSERT INTO AL_CAB_PETICION (NUM_PETICION, COD_BODEGA_ORI,
                                COD_BODEGA_DEST, FEC_PETICION,USU_PETICION, COD_MOTIVO,
                                COD_ESTADO, DES_OBSERVACION)
                         VALUES
                                (v_num_peticion, v_cod_bodega_ori_peti, v_cod_bodega_dest_peti,
                                 v_fecha_traspaso_masivo, v_usu_traspaso_masivo,
                                 v_cod_motivo, v_vCadenaAB, NULL);
                    exception when others then

                    SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                    V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                    V_ERRORES.FEC_ERROR:=SYSDATE;
                    V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN INSERT AL_CAB_PETICION';
                    V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                    v_errores.glosa_error_venta := SQLERRM;
                    V_ERR_PEDIDO:= 1;
                    raise ERROR_TRASPASO;

                    end;
                    open c_lin_peticion;
                             loop
                                 fetch c_lin_peticion into v_cod_articulo_peti, v_can_traspaso_peti;
                                       exit when c_lin_peticion%NOTFOUND;
                                          begin
                                          INSERT INTO AL_LIN_PETICION (NUM_PETICION, COD_ARTICULO, CAN_TRASPASO)
                                          VALUES
                                               (v_num_peticion, v_cod_articulo_peti, v_can_traspaso_peti);
                                          exception when others then

                                          SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                                          V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                                          V_ERRORES.FEC_ERROR:=SYSDATE;
                                          V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN INSERT AL_LIN_PETICION';
                                          V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                                          v_errores.glosa_error_venta := SQLERRM;
                                          V_ERR_PEDIDO:= 1;
                                          raise ERROR_TRASPASO;

                                          end;
                             end loop;
                    close c_lin_peticion;
                         begin
                         UPDATE AL_CAB_PETICION SET COD_ESTADO = v_vCadenaPA
                         WHERE NUM_PETICION = v_num_peticion;
                         exception when others then

                         SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                         V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                         V_ERRORES.FEC_ERROR:=SYSDATE;
                         V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_CAB_PETICION 1';
                         V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                         v_errores.glosa_error_venta := SQLERRM;
                         V_ERR_PEDIDO:= 1;
                         raise ERROR_TRASPASO;

                         end;
                         begin
                         UPDATE AL_CAB_PETICION SET COD_ESTADO = v_vCadenaAP
                         WHERE NUM_PETICION = v_num_peticion;
                         exception when others then

                         SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                         V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                         V_ERRORES.FEC_ERROR:=SYSDATE;
                         V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_CAB_PETICION 2';
                         V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                         v_errores.glosa_error_venta := SQLERRM;
                         V_ERR_PEDIDO:= 1;
                         raise ERROR_TRASPASO;

                         end;
                         begin
                         INSERT INTO AL_TRASPASOS (NUM_TRASPASO, NUM_PETICION, COD_BODEGA_ORI,
                                    COD_BODEGA_DEST, FEC_AUTORIZA, USU_AUTORIZA, COD_ESTADO,
                                    FEC_DESPACHO, USU_DESPACHO, FEC_RECEPCION, USU_RECEPCION,
                                    DES_OBSERVACION, TIP_MOVIM_AUT, TIP_MOVIM_ENV, TIP_MOVIM_REC)
                         VALUES
                                   (v_num_traspaso, v_num_peticion, v_cod_bodega_ori_peti,
                                   v_cod_bodega_dest_peti, v_fecha_traspaso_masivo,
                                   v_usu_traspaso_masivo, v_vCadenaAP,NULL,
                                   NULL, NULL, NULL, NULL, v_tip_movim_aut, NULL, NULL);
                         exception when others then

                         SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                         V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                         V_ERRORES.FEC_ERROR:=SYSDATE;
                         V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN INSERT AL_TRASPASOS';
                         V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                         v_errores.glosa_error_venta := SQLERRM;
                         V_ERR_PEDIDO:= 1;
                         raise ERROR_TRASPASO;

                         end;
                    v_lin_traspaso := 0;
                    open c_lin_traspaso;
                           loop
                               fetch c_lin_traspaso into v_tip_stock, v_cod_articulo,
                                     v_uso, v_estado, v_can_traspaso;
                                     exit when c_lin_traspaso%NOTFOUND;
                                     v_lin_traspaso := v_lin_traspaso + 1;
                                         begin
                                         INSERT INTO AL_LIN_TRASPASO (NUM_TRASPASO, LIN_TRASPASO,
                                                     TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, CAN_TRASPASO)
                                         VALUES
                                                     (v_num_traspaso, v_lin_traspaso, v_tip_stock,
                                                     v_cod_articulo, v_uso, v_estado, v_can_traspaso);
                                         exception when others then

                                         SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                                         V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                                         V_ERRORES.FEC_ERROR:=SYSDATE;
                                         V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN INSERT AL_LIN_TRASPASO';
                                         V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                                         v_errores.glosa_error_venta := SQLERRM;
                                         V_ERR_PEDIDO:= 1;
                                         raise ERROR_TRASPASO;

                                         end;
                                     open c_ser_traspaso;
                                          loop
                                              fetch c_ser_traspaso into v_num_serie, v_cap_code,
                                                    v_num_telefono, v_cod_central,v_cod_subalm,
                                                    v_cod_cat, v_num_seriemec,v_cod_articulo;
                                                    exit when c_ser_traspaso%NOTFOUND;
                                                         select ind_seriado into v_ind_seriado
                                                         from al_articulos
                                                         where cod_articulo = v_cod_articulo;
                                                         if v_ind_seriado = 1 then
                                                            begin
                                                            INSERT INTO AL_SER_TRASPASO (NUM_TRASPASO, LIN_TRASPASO,
                                                                   NUM_SERIE, CAP_CODE,NUM_TELEFONO, NUM_SERIEMEC,
                                                                   COD_CENTRAL, COD_SUBALM, COD_CAT)
                                                            VALUES
                                                                  (v_num_traspaso, v_lin_traspaso, v_num_serie,
                                                                  v_cap_code, v_num_telefono, v_num_seriemec,
                                                                  v_cod_central, v_cod_subalm, v_cod_cat);
                                                            exception when others then
                                                            SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                                                            V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                                                            V_ERRORES.FEC_ERROR:=SYSDATE;
                                                            V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN INSERT EN AL_SER_TRASPASO';
                                                            V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                                                            v_errores.glosa_error_venta := SQLERRM;
                                                            V_ERR_PEDIDO:= 1;
                                                            raise ERROR_TRASPASO;

                                                            end;
                                                         end if;
                                          end loop;
                                     close c_ser_traspaso;
                           end loop;
                    close c_lin_traspaso;
                        begin
                        UPDATE AL_CAB_PETICION SET COD_ESTADO = v_vCadenaAU
                        WHERE NUM_PETICION = v_num_peticion;
                        exception when others then

                        SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                        V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                        V_ERRORES.FEC_ERROR:=SYSDATE;
                        V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_CAB_PETICION 3';
                        V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                        v_errores.glosa_error_venta := SQLERRM;
                        V_ERR_PEDIDO:= 1;
                        raise ERROR_TRASPASO;

                        end;
                        begin
                        UPDATE AL_TRASPASOS SET COD_ESTADO = v_vCadenaAU
                        WHERE NUM_TRASPASO = v_num_traspaso;
                        UPDATE AL_TRASPASOS SET NUM_PETICION = v_num_peticion,
                               FEC_AUTORIZA = v_fecha_traspaso_masivo,
                               USU_AUTORIZA = v_usu_traspaso_masivo,
                               COD_ESTADO = v_vCadenaEN, TIP_MOVIM_AUT = v_tip_movim_aut,
                               TIP_MOVIM_ENV = v_tip_movim_env, TIP_MOVIM_REC = NULL,
                               FEC_DESPACHO = v_fecha_traspaso_masivo,
                               USU_DESPACHO = v_usu_traspaso_masivo,
                               FEC_RECEPCION = NULL, USU_RECEPCION = NULL,
                               DES_OBSERVACION = NULL, COD_BODEGA_ORI = v_cod_bodega_ori_peti,
                               COD_BODEGA_DEST = v_cod_bodega_dest_peti
                        WHERE NUM_TRASPASO = v_num_traspaso;
                        exception when others then

                        SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                        V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                        V_ERRORES.FEC_ERROR:=SYSDATE;
                        V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_TRASPASOS 1';
                        V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                        v_errores.glosa_error_venta := SQLERRM;
                        V_ERR_PEDIDO:= 1;
                        raise ERROR_TRASPASO;

                        end;

                        SELECT a.TIP_MOVIMIENTO into v_tip_movim_rec
                        FROM AL_PROCESOS_TIPMOVIM a, AL_TIPOS_MOVIMIENTOS b
                        WHERE a.TIP_MOVIMIENTO = b.TIP_MOVIMIENTO
                        AND a.COD_PROCESO = v_cod_proceso_rec AND b.TIP_STOCK = v_tip_stock_des
                        AND rownum < v_nNumero_2;
                        begin
                        UPDATE AL_TRASPASOS SET NUM_PETICION = v_num_peticion,
                               FEC_AUTORIZA = v_fecha_traspaso_masivo,
                               USU_AUTORIZA = v_usu_traspaso_masivo,
                               COD_ESTADO = v_vCadenaRM, TIP_MOVIM_AUT = v_tip_movim_aut,
                               TIP_MOVIM_ENV = v_tip_movim_env, TIP_MOVIM_REC = v_tip_movim_rec,
                               FEC_DESPACHO = v_fecha_traspaso_masivo,
                               USU_DESPACHO = v_usu_traspaso_masivo,
                               FEC_RECEPCION = v_fecha_traspaso_masivo,
                               USU_RECEPCION = v_usu_traspaso_masivo,
                               COD_BODEGA_ORI = v_cod_bodega_ori_peti,
                               COD_BODEGA_DEST = v_cod_bodega_dest_peti,
                               DES_OBSERVACION = ' MASIVO '|| to_char(v_num_traspaso_masivo) || ' ' ||
                               v_usu_traspaso_masivo || ' ' ||
                               to_char(v_fecha_traspaso_masivo,'DD-MM-YYYY HH24:MI:SS')
                        WHERE NUM_TRASPASO = v_num_traspaso;
                        exception when others then

                        SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
                        V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
                        V_ERRORES.FEC_ERROR:=SYSDATE;
                        V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_TRASPASOS 2';
                        V_ERRORES.COD_ESTADO_ERROR:= 'PR';
                        v_errores.glosa_error_venta := SQLERRM;
                        V_ERR_PEDIDO:= 1;
                        raise ERROR_TRASPASO;

                        end;
           end loop;
    close c_cab_peticion;
    begin
    UPDATE AL_TRASPASOS_MASIVO SET COD_ESTADO_TRAS = v_vCadenaCE,
           NOM_USUAPROC = USER, FEC_PROCESO = SYSDATE
    WHERE NUM_TRASPASO_MASIVO = v_num_traspaso_mas;
    --P_AL_HIST_TRASPASOS(v_num_traspaso_mas);
        exception when others then

       SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
       V_ERRORES.COD_PEDIDO:=V_COD_PEDIDO;
       V_ERRORES.FEC_ERROR:=SYSDATE;
       V_ERRORES.GLOSA_ERROR_TRASPASO:= 'ERROR EN UPDATE AL_TRASPASOS_MASIVO';
       V_ERRORES.COD_ESTADO_ERROR:= 'PR';
       v_errores.glosa_error_venta := SQLERRM;
       V_ERR_PEDIDO:= 1;
       raise ERROR_TRASPASO;

    end;
EXCEPTION
  when ERROR_TRASPASO then
          ROLLBACK;
          al_pac_trasven_web.insertar_al_errores_web(v_errores);
          if c_ser_seriado%ISOPEN  then close c_ser_seriado;end if;
          if c_ser_telefono%ISOPEN then close c_ser_telefono;end if;
          if c_lin_peticion%ISOPEN then close c_lin_peticion;end if;
          if c_ser_traspaso%ISOPEN then close c_ser_traspaso;end if;
          if c_lin_traspaso%ISOPEN then close c_lin_traspaso;end if;
          if c_cab_peticion%ISOPEN then close c_cab_peticion;end if;
  when OTHERS then
          ROLLBACK;
          SELECT AL_SEQ_ERRORES_WEB.NEXTVAL INTO V_ERRORES.NUM_ERROR FROM DUAL;
          v_errores.cod_pedido:=v_cod_pedido;
          v_errores.fec_error:=sysdate;
          v_errores.num_traspaso_masivo:=v_num_traspaso_masivo;
          v_errores.glosa_error_traspaso:= 'ERROR FATAL TRASPASOS'|| TO_CHAR(sqlcode);
          v_errores.glosa_error_venta := SQLERRM;
          v_errores.cod_estado_error:= 'PR';
          al_pac_trasven_web.insertar_al_errores_web(v_errores);
          if c_ser_seriado%ISOPEN  then close c_ser_seriado;end if;
          if c_ser_telefono%ISOPEN then close c_ser_telefono;end if;
          if c_lin_peticion%ISOPEN then close c_lin_peticion;end if;
          if c_ser_traspaso%ISOPEN then close c_ser_traspaso;end if;
          if c_lin_traspaso%ISOPEN then close c_lin_traspaso;end if;
          if c_cab_peticion%ISOPEN then close c_cab_peticion;end if;
end;
/
SHOW ERRORS
