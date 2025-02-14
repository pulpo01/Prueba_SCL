CREATE OR REPLACE PROCEDURE PV_PASOHIST_OOSS_PR IS

--<Documentación TipoDoc = PV_PASOHIST_OOSS_PR>
--   <Elemento Nombre = "PASO a Historico" Lenguaje="PL/SQL" Fecha="09/09/2005" Versión="1.0" Diseñador=Programador='German Espinoza Z' Ambiente="SOPTMC">
--              <Retorno>NA</Retorno>
--              <Descripción>Busca Ordenes de Servicio para pasar a historico de acuerdo a una fecha de inicio a fin con respecto a la fecha de ingreso de la orden</Descripción>
--              <Parámetros>
--              </Parámetros>
--   </Elemento>
--</Documentación>


LV_FechaIni                     ged_parametros.val_parametro%TYPE;
LV_FechaFin                     ged_parametros.val_parametro%TYPE;

LV_sSql                         VARCHAR2(1000);
LN_TipEstadoOK          pv_erecorrido.tip_estado%TYPE;
LN_TipEstadoER          pv_erecorrido.tip_estado%TYPE;
LN_NumIntento           pv_iorserv.num_intentos%TYPE;
LN_CodEstadofinal       pv_iorserv.cod_estado%TYPE;
LN_CodEstadopadre       pv_iorserv.cod_estado%TYPE;
LV_MaxIntentos          ged_parametros.val_parametro%TYPE;

LV_NomParametro         ged_parametros.nom_parametro%TYPE;
LV_CodModulo            varchar2(4);
LV_CodProducto          ged_parametros.cod_producto%TYPE;
LV_FormatoFecha         ged_parametros.val_parametro%TYPE;

LV_Tabla                        pv_erroreshist_ooss_th.nom_tabla%TYPE;
LV_Accion                       pv_erroreshist_ooss_th.accion%TYPE;
LVProceso                       ga_errores.nom_proc%TYPE;

LN_Error                        NUMBER(1);
LN_Cant                         NUMBER(14);
LN_CantCor                      NUMBER(14);
LN_CantErr                      NUMBER(14);

LI_IdCursor                     INTEGER;
LI_IdResultado          INTEGER;

LN_NumOs                        pv_iorserv.num_os%TYPE;
LN_IorCodEstado         pv_iorserv.cod_estado%TYPE;
LN_EreCodEstado         pv_erecorrido.cod_estado%TYPE;
LN_TipEstado            pv_erecorrido.tip_estado%TYPE;
LN_NumIntentos          pv_iorserv.num_intentos%TYPE;
LN_NumOspadre           pv_iorserv.num_ospadre%TYPE;

LV_Msg                          pvh_erecorrido.descripcion%TYPE;

LV_mensaje         pv_erroreshist_ooss_th.ERROR_SQLERRM%TYPE;

error_proceso           EXCEPTION;

BEGIN

        LN_Error:=3;

        LVProceso:='PV_PASOHIST_OOSS_PR';

        BEGIN

                --Formato de Fecha
                LV_Tabla                :='FORMATO_SEL11';
                LV_Accion               :='F';

                LV_FormatoFecha:=GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL11');

                --Numero Maximo de Intentos de ejecucion de una OOSS BATCH
                LV_Tabla                :='MAX_INTENTOS';
                LV_Accion               :='F';

                LV_MaxIntentos:=GE_FN_DEVVALPARAM('GA',1,'MAX_INTENTOS');

                --fecha de inicio
                LV_Tabla                :='FEC_INI_HIST_OOSS_PR';
                LV_Accion               :='F';

                LV_FechaIni:=GE_FN_DEVVALPARAM('GA',1,'FEC_INI_HIST_OOSS_PR');

                --fecha de fin
                LV_Tabla                :=SUBSTR('GE_FN_DEVVALPARAM/'||LV_NomParametro,1,30);
                LV_Accion               :='F';

                LV_FechaFin:=GE_FN_DEVVALPARAM('GA',1,'FEC_FIN_HIST_OOSS_PR');

        EXCEPTION
                WHEN OTHERS THEN

                         LN_Error:=4;

                         LV_sSql:=' INSERT INTO pv_erroreshist_ooss_th';
                         LV_sSql:=LV_sSql ||' (num_os,usuario,nom_tabla,accion,error_sqlcode,error_sqlerrm,fec_ejecucion)';
                         LV_sSql:=LV_sSql ||' VALUES (:v1,:v2,:v3,:v4,:v5,:v6,:v7)';

                         EXECUTE IMMEDIATE LV_sSql
                         USING 0,USER,LV_Tabla,LV_Accion,SUBSTR(SQLCODE,1,2000),SUBSTR(SQLERRM,1,2000),SYSDATE;

        END;

        IF LN_Error=3 THEN

                        LN_TipEstadoOK          :=3;
                        LN_TipEstadoER          :=4;
                        LN_CodEstadofinal       :=990;
                        LN_CodEstadopadre       :=110;

                        LV_Tabla                :='PV_IORSERV/PV_ERECORRIDO';
                        LV_Accion               :='C';

                        LV_sSql:=          'SELECT a.num_os       AS num_os ,';
                        LV_sSql:=LV_sSql ||'       a.cod_estado   AS ior_cod_estado ,';
                        LV_sSql:=LV_sSql ||'       b.cod_estado   AS ere_cod_estado ,';
                        LV_sSql:=LV_sSql ||'       b.tip_estado   AS tip_estado     ,';
                        LV_sSql:=LV_sSql ||'       a.num_intentos AS num_intentos   ,';
                        LV_sSql:=LV_sSql ||'       a.num_ospadre  AS num_ospadre   ';
                        LV_sSql:=LV_sSql ||'FROM   pv_iorserv a , pv_erecorrido b ';
                        LV_sSql:=LV_sSql ||'WHERE  (  (      a.cod_estado                 = :v1';
                        LV_sSql:=LV_sSql ||'            AND  NVL( b.tip_estado , 0 )  = :v2';
                        LV_sSql:=LV_sSql ||'            AND  a.cod_estado             = b.cod_estado';
                        LV_sSql:=LV_sSql ||'          )  ';
                        LV_sSql:=LV_sSql ||'              OR ';
                        LV_sSql:=LV_sSql ||'          (      b.tip_estado             = :v3';
                        LV_sSql:=LV_sSql ||'            AND  a.num_intentos           = :v4';
                        LV_sSql:=LV_sSql ||'            AND  a.num_os                 = a.num_ospadre';
                        LV_sSql:=LV_sSql ||'            AND  a.cod_estado             = b.cod_estado';
                        LV_sSql:=LV_sSql ||'          )  ';
                        LV_sSql:=LV_sSql ||'              OR ';
                        LV_sSql:=LV_sSql ||'          (      a.cod_estado             >= :v5';
                        LV_sSql:=LV_sSql ||'            AND  b.tip_estado             =  :v6';
                        LV_sSql:=LV_sSql ||'            AND  a.num_ospadre            IS NULL';
                        LV_sSql:=LV_sSql ||'        ) ) ';
                        LV_sSql:=LV_sSql ||'   AND  a.fecha_ing BETWEEN TO_DATE(:v7,:v9)';
                        LV_sSql:=LV_sSql ||'                        AND TO_DATE(:v8,:v9) ';
                        LV_sSql:=LV_sSql ||'   AND  a.num_os    = b.num_os';
                        LV_sSql:=LV_sSql ||'   AND  a.num_os    > 0';

                        --Ejecucion de Cursor
                        LI_IdCursor:=DBMS_SQL.OPEN_CURSOR;
                        DBMS_SQL.PARSE(LI_IdCursor, LV_sSql, DBMS_SQL.NATIVE);

                        --Entradas del Cursor
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v1', LN_CodEstadofinal);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v2', LN_TipEstadoOK);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v3', LN_TipEstadoER);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v4', LV_MaxIntentos);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v5', LN_CodEstadopadre);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v6', LN_TipEstadoOK);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v7', LV_FechaIni);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v8', LV_FechaFin);
                        DBMS_SQL.BIND_VARIABLE(LI_IdCursor,':v9', LV_FormatoFecha);

                        --Salidas del cursor
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 1, LN_NumOs);
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 2, LN_IorCodEstado);
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 3, LN_EreCodEstado);
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 4, LN_TipEstado);
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 5, LN_NumIntentos);
                        DBMS_SQL.DEFINE_COLUMN(LI_IdCursor, 6, LN_NumOspadre);

                        LI_IdResultado:=DBMS_SQL.EXECUTE(LI_IdCursor);

                        LN_Cant:=1;
                        LN_CantCor:=1;
                        LN_CantErr:=0;

                    LOOP
                       IF DBMS_SQL.FETCH_ROWS(LI_IdCursor) = 0 THEN
                                  EXIT;
                   END IF;

                           --se cargan campos en variables
                   DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 1, LN_NumOs);
                           DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 2, LN_IorCodEstado);
                           DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 3, LN_EreCodEstado);
                           DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 4, LN_TipEstado);
                           DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 5, LN_NumIntentos);
                           DBMS_SQL.COLUMN_VALUE(LI_IdCursor, 6, LN_NumOspadre);

                           BEGIN

                                   LV_Tabla             :='PVH_IORSERV';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_iorserv  ';
                               LV_sSql:=LV_sSql ||' (num_os, cod_os, num_ospadre, descripcion, fecha_ing,';
                               LV_sSql:=LV_sSql ||'  producto, usuario, status, tip_procesa, fh_ejecucion,  ';
                               LV_sSql:=LV_sSql ||'  cod_estado, cod_modgener, num_osf, tip_subsujeto, nfile, ';
                               LV_sSql:=LV_sSql ||'  path_file, tip_sujeto, ind_lock, prioridad, num_osf_err,';
                               LV_sSql:=LV_sSql ||'  comentario, fh_recolector, fh_respaldo,num_intentos,';
                               LV_sSql:=LV_sSql ||'  fh_historico,user_historico,num_osftotal,cod_modulo,id_gestor)';
                               LV_sSql:=LV_sSql ||' SELECT';
                               LV_sSql:=LV_sSql ||'  num_os , cod_os, num_ospadre, descripcion, fecha_ing, ';
                               LV_sSql:=LV_sSql ||'  producto, usuario, status, tip_procesa,fh_ejecucion, ';
                               LV_sSql:=LV_sSql ||'  cod_estado, cod_modgener, num_osf, tip_subsujeto, nfile, ';
                               LV_sSql:=LV_sSql ||'  path_file, tip_sujeto, ind_lock, prioridad, num_osf_err, ';
                               LV_sSql:=LV_sSql ||'  comentario, fh_recolector, fh_respaldo,num_intentos, ';
                               LV_sSql:=LV_sSql ||'  SYSDATE,USER,num_osftotal,cod_modulo,id_gestor ';
                               LV_sSql:=LV_sSql ||' FROM  pv_iorserv ';
                               LV_sSql:=LV_sSql ||' WHERE num_os =:v1 ';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   IF SQL%ROWCOUNT=0 THEN
                                          RAISE error_proceso;
                                   END IF;

                                   LV_Tabla             :='PVH_CAMCOM';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_camcom';
                           LV_sSql:=LV_sSql ||'  (num_os, num_abonado, num_celular,cod_cliente,cod_cuenta,';
                           LV_sSql:=LV_sSql ||' cod_producto,bdatos,num_venta,num_transaccion,num_folio,';
                           LV_sSql:=LV_sSql ||' num_cuotas,num_proceso,cod_actabo,fh_anula,user_anula,';
                           LV_sSql:=LV_sSql ||' cat_tribut,cod_estadoc,cod_causaelim,fec_vencimiento,';
                           LV_sSql:=LV_sSql ||' abonados,tabla,clase_servicio_act,clase_servicio_des,';
                           LV_sSql:=LV_sSql ||' ind_msg,num_cargo_os,imp_cargo_ser,ind_central_ss,';
                           LV_sSql:=LV_sSql ||' tip_terminal, tip_susp_avsinie, ind_portable, pref_plaza)';
                                   LV_sSql:=LV_sSql ||' SELECT ';
                           LV_sSql:=LV_sSql ||' num_os, num_abonado, num_celular,cod_cliente,cod_cuenta,';
                           LV_sSql:=LV_sSql ||' cod_producto,bdatos,num_venta,num_transaccion,num_folio,';
                           LV_sSql:=LV_sSql ||' num_cuotas,num_proceso,cod_actabo,fh_anula,user_anula,';
                           LV_sSql:=LV_sSql ||' cat_tribut,cod_estadoc,cod_causaelim,fec_vencimiento,';
                           LV_sSql:=LV_sSql ||' abonados,tabla,clase_servicio_act,clase_servicio_des,';
                           LV_sSql:=LV_sSql ||' ind_msg,num_cargo_os,imp_cargo_ser,ind_central_ss,';
                           LV_sSql:=LV_sSql ||' tip_terminal, tip_susp_avsinie, ind_portable, pref_plaza';
                           LV_sSql:=LV_sSql ||' FROM   pv_camcom';
                           LV_sSql:=LV_sSql ||' WHERE  num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   IF SQL%ROWCOUNT=0 THEN
                                          RAISE error_proceso;
                                   END IF;

                                   LV_Tabla             :='PVH_ERECORRIDO';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_erecorrido';
                           LV_sSql:=LV_sSql ||'   (num_os,  cod_estado,  descripcion,tip_estado,fec_ingestado,msg_error)';
                           LV_sSql:=LV_sSql ||' SELECT num_os,cod_estado,descripcion,tip_estado,fec_ingestado,msg_error';
                           LV_sSql:=LV_sSql ||' FROM pv_erecorrido';
                           LV_sSql:=LV_sSql ||' WHERE num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   IF SQL%ROWCOUNT=0 THEN
                                          RAISE error_proceso;
                                   END IF;

                                   IF  LN_IorCodEstado=LN_CodEstadofinal AND LN_TipEstado=LN_TipEstadoOK THEN
                                           LV_Msg:='PROCESO HISTORICO PUNTUAL';
                                   ELSIF LN_TipEstado=LN_TipEstadoER AND LN_NumIntentos=LV_MaxIntentos AND LN_NumOs=LN_NumOspadre THEN
                                           LV_Msg:='PROCESO HISTORICO POR INTENTO';
                                   ELSIF LN_IorCodEstado>=LN_CodEstadopadre AND LN_TipEstado=LN_TipEstadoOK AND LN_NumOspadre IS NULL THEN
                                           LV_Msg:='PROCESO HISTORICO POR PADRE';
                                   ELSE
                                           LV_Msg:='PROCESO HISTORICO';
                                   END IF;

                                   LV_Tabla             :='PVH_ERECORRIDO999';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_erecorrido';
                                   LV_sSql:=LV_sSql ||' (num_os,  cod_estado,  descripcion,tip_estado,fec_ingestado,msg_error)';
                                   LV_sSql:=LV_sSql ||' VALUES ( :v1,999,:v2,3,SYSDATE,:v3)';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs,SUBSTR(LV_Msg,1,30),'OK';

                                   IF SQL%ROWCOUNT=0 THEN
                                          RAISE error_proceso;
                                   END IF;

                                   LV_Tabla             :='PVH_PARAM_ABOCEL_TH';
                                   LV_Accion    :='I';

                                   LV_sSql:='          INSERT INTO pvh_param_abocel_th';
                       LV_sSql:=LV_sSql ||' (num_os, num_abonado,cod_tipmodi,fec_modifica,nuom_usuarora,num_celular,cod_uso,tip_plantarif,tip_terminal,';
                       LV_sSql:=LV_sSql ||' cod_plantarif,cod_cargobasico,cod_planserv,cod_limconsumo,num_serie,num_seriehex,cod_empresa,cod_grpserv,';
                       LV_sSql:=LV_sSql ||' cod_carrier,cod_ciclo,ind_factur,cod_causa,num_min,cod_tipcontrato,num_meses,ind_eqprestado,fec_prorroga,';
                       LV_sSql:=LV_sSql ||' num_ciclos, num_minutos, fec_fincontrato, cod_servicio, obs_detalle, cod_tipsegu, num_contrato, num_anexo)';
                           LV_sSql:=LV_sSql ||' SELECT ';
                       LV_sSql:=LV_sSql ||' num_os,num_abonado,cod_tipmodi,fec_modifica,nuom_usuarora,num_celular,cod_uso,tip_plantarif,';
                       LV_sSql:=LV_sSql ||' tip_terminal,cod_plantarif,cod_cargobasico,cod_planserv,cod_limconsumo,num_serie,num_seriehex,';
                       LV_sSql:=LV_sSql ||' cod_empresa,cod_grpserv,cod_carrier,cod_ciclo,ind_factur,cod_causa,num_min,cod_tipcontrato,';
                       LV_sSql:=LV_sSql ||' num_meses,ind_eqprestado,fec_prorroga,num_ciclos,num_minutos,fec_fincontrato,cod_servicio,';
                       LV_sSql:=LV_sSql ||' obs_detalle,cod_tipsegu,num_contrato,num_anexo';
                           LV_sSql:=LV_sSql ||' FROM pv_param_abocel   ';
                           LV_sSql:=LV_sSql ||' WHERE  num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_ERRORES_OOSS_TH';
                                   LV_Accion    :='I';

                                   LV_sSql:='          INSERT INTO pv_errores_ooss_th';
                           LV_sSql:=LV_sSql ||' (num_error, num_os, cod_os, cod_error, gls_error, nom_proc, fec_error, nom_usuario)';
                           LV_sSql:=LV_sSql ||' SELECT num_error, num_os, cod_os, cod_error, gls_error, nom_proc, fec_error, nom_usuario';
                           LV_sSql:=LV_sSql ||' FROM   pv_errores_ooss_to ';
                           LV_sSql:=LV_sSql ||' WHERE  num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PVH_PROG';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_prog';
                           LV_sSql:=LV_sSql ||'  (num_os,f_prorroga,usuario,observacion,fec_prog)';
                           LV_sSql:=LV_sSql ||' SELECT num_os,f_prorroga,usuario,observacion,fec_prog';
                           LV_sSql:=LV_sSql ||' FROM pv_prog';
                                   LV_sSql:=LV_sSql ||' WHERE num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PVH_TRASPASO_CARGOS';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_traspaso_cargos';
                           LV_sSql:=LV_sSql ||'  (num_os, num_cargo, cod_concepto, fec_alta, imp_cargo, cod_moneda, cod_plancom,';
                           LV_sSql:=LV_sSql ||'  num_unidades, ind_factur, num_paquete, num_abonado, cod_ciclfact, mes_garantia, ';
                           LV_sSql:=LV_sSql ||'  num_preguia, num_guia, num_factura, cod_concepto_dto, val_dto, tip_dto, ind_cuota,';
                           LV_sSql:=LV_sSql ||'  ind_supertel, ind_manual, nom_usuarora, cod_cliente, cod_producto, num_transaccion,';
                           LV_sSql:=LV_sSql ||'  num_venta, num_terminal, num_serie, cap_code, num_seriemec)';
                           LV_sSql:=LV_sSql ||' SELECT num_os, num_cargo,cod_concepto, fec_alta, imp_cargo, cod_moneda, cod_plancom,';
                           LV_sSql:=LV_sSql ||'   num_unidades, ind_factur, num_paquete, num_abonado,cod_ciclfact,mes_garantia, ';
                           LV_sSql:=LV_sSql ||'   num_preguia,num_guia,num_factura,cod_concepto_dto,val_dto,tip_dto,nvl(ind_cuota,0),';
                           LV_sSql:=LV_sSql ||'   ind_supertel,ind_manual,nom_usuarora,cod_cliente,cod_producto,num_transaccion,';
                           LV_sSql:=LV_sSql ||'   num_venta,num_terminal,num_serie,cap_code,num_seriemec';
                           LV_sSql:=LV_sSql ||' FROM pv_traspaso_cargos   ';
                           LV_sSql:=LV_sSql ||' WHERE num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PVH_MOVIMIENTOS';
                                   LV_Accion    :='I';

                                   LV_sSql:='           INSERT INTO pvh_movimientos';
                           LV_sSql:=LV_sSql ||'  (num_os,f_ejecucion,ord_comando,cod_actabo,cod_servicio,';
                           LV_sSql:=LV_sSql ||'  ind_estado,fec_expira,resp_central,num_movimiento,carga,cod_estado)';
                           LV_sSql:=LV_sSql ||' SELECT num_os, f_ejecucion,ord_comando,cod_actabo,';
                           LV_sSql:=LV_sSql ||'  cod_servicio,ind_estado,fec_expira,resp_central,num_movimiento,carga,cod_estado';
                           LV_sSql:=LV_sSql ||' FROM   pv_movimientos';
                           LV_sSql:=LV_sSql ||' WHERE  num_os=:v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_PROG';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_prog                WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_TRASPASO_CARGOS';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_traspaso_cargos WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_MOVIMIENTOS';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_movimientos     WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_CAMCOM';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_camcom          WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_ERECORRIDO';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_erecorrido      WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_PARAM_ABOCEL';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_param_Abocel    WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_ERRORES_OOSS_TO';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_errores_ooss_to WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LV_Tabla             :='PV_IORSERV';
                                   LV_Accion    :='D';

                                   LV_sSql:=' DELETE pv_iorserv                 WHERE  num_os= :v1';

                                   EXECUTE IMMEDIATE LV_sSql
                                   USING LN_NumOs;

                                   LN_CantCor:=LN_CantCor+1;

                                EXCEPTION
                                        WHEN error_proceso THEN
                                                 LV_sSql:=' INSERT INTO pv_erroreshist_ooss_th';
                                                 LV_sSql:=LV_sSql ||' (num_os,usuario,fec_ejecucion,nom_tabla,accion,error_sqlcode,error_sqlerrm)';
                                                 LV_sSql:=LV_sSql ||' VALUES (:v1,:v2,:v3,:v4,:v5,:v6,:v7)';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs,USER,SYSDATE,SUBSTR(LV_Tabla,1,30),LV_Accion,SUBSTR(SQLCODE,1,2000),SUBSTR(SQLERRM,1,2000);

                                                 LV_sSql:=' DELETE pvh_prog                WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_traspaso_cargos WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_movimientos     WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_camcom          WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_erecorrido      WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_param_abocel_th WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pv_errores_ooss_th  WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_iorserv             WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LN_CantErr:=LN_CantErr+1;

                                        WHEN OTHERS THEN
                                             LV_sSql:=' INSERT INTO pv_erroreshist_ooss_th';
                                                 LV_sSql:=LV_sSql ||' (num_os,usuario,fec_ejecucion,nom_tabla,accion,error_sqlcode,error_sqlerrm)';
                                                 LV_sSql:=LV_sSql ||' VALUES (:v1,:v2,:v3,:v4,:v5,:v6,:v7)';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs,USER,SYSDATE,SUBSTR(LV_Tabla,1,30),LV_Accion,SUBSTR(SQLCODE,1,2000),SUBSTR(SQLERRM,1,2000);

                                                 LV_sSql:=' DELETE pvh_prog                WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_traspaso_cargos WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_movimientos     WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_camcom          WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_erecorrido      WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_param_abocel_th WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pv_errores_ooss_th  WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LV_sSql:=' DELETE pvh_iorserv             WHERE  num_os= :v1';

                                                 EXECUTE IMMEDIATE LV_sSql
                                                 USING LN_NumOs;

                                                 LN_CantErr:=LN_CantErr+1;

                                END;

                                IF MOD(LN_Cant,10000) =0 THEN
                                        DBMS_OUTPUT.PUT_LINE ('COMMIT');
                                   COMMIT;
                                END IF;

                                LN_Cant:=LN_Cant+1;

                    END LOOP;

                        lv_mensaje := 'Proceso Terminado, Fecha Inicio : '||LV_FechaIni||' y Fecha de Termino: '||LV_FechaFin||' Registros procesado correctamente= '|| LN_CantCor ||',Registros procesado incorrectamente='||LN_CantErr|| ', de un total de '||LN_Cant||' Registros.';

                        DBMS_OUTPUT.PUT_LINE ('lv_mensaje:'||lv_mensaje);

                        LV_sSql:=' INSERT INTO pv_erroreshist_ooss_th';
                        LV_sSql:=LV_sSql ||' (num_os,usuario,fec_ejecucion,nom_tabla,accion,error_sqlcode,error_sqlerrm)';
                        LV_sSql:=LV_sSql ||' VALUES (:v1,:v2,:v3,:v4,:v5,:v6,:v7)';

                         EXECUTE IMMEDIATE LV_sSql
                         USING 0,USER,SYSDATE,'X','R',0,lv_mensaje;

                        COMMIT;

                        LN_CantCor :=0;
                        LN_CantErr :=0;
                        lv_mensaje := '';

                        DBMS_SQL.CLOSE_CURSOR(LI_IdCursor);

        END IF;
END;
/
SHOW ERRORS
