CREATE OR REPLACE PACKAGE BODY VE_PLANES_ADICIONALES_PG AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDA_PARAMETROS_FN ( EN_CLIENTE_ORIGEN IN ge_clientes.cod_cliente%TYPE,
 EV_PLAN_ORIGEN IN ta_plantarif.cod_plantarif%TYPE,
 EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
 EV_PLAN_DESTINO IN ta_plantarif.cod_plantarif%TYPE,
 ED_FECHA_ALTA IN DATE,
 EN_NUM_PROCESO IN pr_productos_contratados_to.num_proceso%TYPE,
 EV_COD_CANAL IN pr_productos_contratados_to.cod_canal%TYPE,
 SN_COD_RETORNO OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
 SV_MENS_RETORNO OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
 SN_NUM_EVENTO OUT NOCOPY ge_errores_pg.evento
 ) RETURN BOOLEAN IS
/*
 <Documentación
 TipoDoc = "Procedure">>
 <Elemento
 Nombre = "PV_VALIDA_PARAMETROS_FN"
 Lenguaje="PL/SQL"
 Fecha="20-11-2008"
 Versión="La del package"
 Diseñador="Andrés Osorio"
 Programador="Andrés Osorio"
 Ambiente Desarrollo="BD">
 <Retorno>BOOLEAN</Retorno>>
 <Descripción>Valida los Parametros de entrada</Descripción>>
 <Parámetros>
 <Entrada>
 <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
 <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
 <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
 <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
 <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
 <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
 <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
 </Entrada>
 <Salida>
 <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
 <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
 <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
 </Salida>
 </Parámetros>
 </Elemento>
 </Documentación>
*/
LV_des_error ge_errores_pg.DesEvent;
LV_sSql ge_errores_pg.vQuery;
ERROR_CLIENTE EXCEPTION;
ERROR_PLAN EXCEPTION;
ERROR_FECHA EXCEPTION;
ERROR_PROCESO EXCEPTION;
ERROR_CANAL EXCEPTION;

BEGIN

 SN_COD_RETORNO := 0;
 SV_MENS_RETORNO := NULL;
 SN_NUM_EVENTO := 0;

 IF (EN_CLIENTE_ORIGEN IS NULL) OR (EN_CLIENTE_ORIGEN = 0) THEN
 RAISE ERROR_CLIENTE;
 END IF;

 IF (EV_PLAN_ORIGEN IS NULL) OR (EV_PLAN_ORIGEN = '') THEN
 RAISE ERROR_PLAN;
 END IF;

 IF (EN_CLIENTE_DESTINO IS NULL) OR (EN_CLIENTE_DESTINO = 0) THEN
 RAISE ERROR_CLIENTE;
 END IF;

 IF (EV_PLAN_DESTINO IS NULL) OR (EV_PLAN_DESTINO = '') THEN
 RAISE ERROR_PLAN;
 END IF;

 IF (ED_FECHA_ALTA IS NULL) THEN
 RAISE ERROR_FECHA;
 END IF;

 IF (EN_NUM_PROCESO IS NULL) OR (EN_NUM_PROCESO = 0) THEN
 RAISE ERROR_PROCESO;
 END IF;

 IF (EV_COD_CANAL IS NULL) OR (EV_COD_CANAL = '') THEN
 RAISE ERROR_CANAL;
 END IF;

 RETURN TRUE;

EXCEPTION
 WHEN ERROR_CLIENTE THEN
 SN_cod_retorno := 877;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'VE_PLANES_ADICIONALES_PG('||EN_CLIENTE_ORIGEN||','||EN_CLIENTE_DESTINO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_PLAN THEN
 SN_cod_retorno := 232;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'VE_PLANES_ADICIONALES_PG('||EV_PLAN_ORIGEN||','||EV_PLAN_DESTINO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_FECHA THEN
 SN_cod_retorno := 200302;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'SISCEL.VE_PLANES_ADICIONALES_PG('||ED_FECHA_ALTA||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_PROCESO THEN
 SN_cod_retorno := 1642;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
 END IF;
 LV_des_error := 'VE_PLANES_ADICIONALES_PG('||EN_NUM_PROCESO||'); - ' || SQLERRM;
 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 RETURN FALSE;

 WHEN ERROR_CANAL THEN
 SN_cod_retorno := 98;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
 SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_VALIDA_PARAMETROS_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END PV_VALIDA_PARAMETROS_FN ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_AGREGA_FN( EN_CLIENTE_DESTINO  IN ge_clientes.cod_cliente%TYPE,
                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                        EN_PROD_OFERTADO   IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                        ED_FECHA_ALTA        IN DATE,
                        ED_FECHA_BAJA       IN DATE,
                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                        EN_NUM_VECES       IN pf_paquete_ofertado_to.num_veces_hijo%TYPE,
                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                        EV_IND_CONTRATA       IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_AGREGA_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Realiza la inscripción de un producto en todas las plataformas</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

C_PRO_DEFECTO         refcursor;
C_CARGOS             refcursor;
LO_CARGOS_REC         FA_CARGOS_REC_QT;
LO_ABONADO               GA_ABONADO_QT;
LO_PRODUCTO              PR_PRODUCTOS_CONTS_TO_QT;
LO_LISTA_NUMEROS     SV_PROD_CONTR_LST_QT;
LO_LISTA_CENTRALES     IC_PROVISION_QT;
LO_CLIENTE              PV_CLIENTE_QT;
LO_CARGOS             FA_CARGOS_QT;

LN_MONTO_IMPORTE     pf_cargos_productos_td.monto_importe%TYPE;
LV_COD_MONEDA          pf_cargos_productos_td.cod_moneda%TYPE;
LN_COD_CARGO          pf_cargos_productos_td.cod_cargo%TYPE;
LN_COD_CONCEPTO      pf_catalogo_ofertado_td.cod_concepto%TYPE;
LV_TIP_CARGO         pf_conceptos_prod_td.tipo_cargo%TYPE;
LN_IND_PRORRATEABLE  NUMBER;
LV_IND_NIVEL_APLICA     pf_productos_ofertados_td.ind_nivel_aplica%TYPE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
LD_FECDESDECARGOS fa_ciclfact.fec_desdeocargos%TYPE;
LD_FECHASTACARGOS fa_ciclfact.fec_hastaocargos%TYPE;

lv_cargo_recurrente  BOOLEAN; -- INC 189196  23/10/2012


BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    lv_cargo_recurrente := FALSE; -- INC 189196  23/10/2012
    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','');

    --Se prepara estructura para obtener datos del abonado
    LO_CLIENTE := PV_CLIENTE_QT(EN_CLIENTE_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                                                        '','','','','','','','','','','','');



    IF (EN_ABONADO_DESTINO != 0 AND EN_ABONADO_DESTINO IS NOT NULL) THEN

        LV_IND_NIVEL_APLICA := 'A';


        --Se Obtienen los datos del abonado
        PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        LV_IND_NIVEL_APLICA := 'C';

        PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR(LO_CLIENTE, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

        LO_ABONADO.COD_CICLO := LO_CLIENTE.COD_CICLO;
        LO_ABONADO.COD_CLIENTE := LO_CLIENTE.COD_CLIENTE;
        LO_ABONADO.TIP_TERMINAL := LO_CLIENTE.TIP_TERMINAL;
        LO_ABONADO.COD_TECNOLOGIA := LO_CLIENTE.COD_TECNOLOGIA;

    END IF;

    --Se buscan los datos necesarios para contratar productos
        LV_sSql := 'SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,';
        LV_sSql := LV_sSql || ' servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma';
        LV_sSql := LV_sSql || ' FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio';
        LV_sSql := LV_sSql || ' WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod';
        LV_sSql := LV_sSql || ' AND       ofertado.cod_espec_prod = servicio.cod_espec_prod';
        LV_sSql := LV_sSql || ' AND       ofertado.cod_prod_ofertado = '||EN_PROD_OFERTADO;
        LV_sSql := LV_sSql || ' AND       ofertado.ind_nivel_aplica = '||LV_IND_NIVEL_APLICA;

        SELECT servicio.cod_espec_prod, nvl(servicio.cod_perfil_lista,0), servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = EN_PROD_OFERTADO
        AND       ofertado.ind_nivel_aplica = LV_IND_NIVEL_APLICA;

        IF (LV_ind_tipo_servicio = 'AA') THEN

            LV_sSql := 'SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar';
            LV_sSql := LV_sSql || ' FROM   se_planes_altamira_td altamira';
            LV_sSql := LV_sSql || ' WHERE  altamira.cod_plan_altamira = '||LV_cod_servicio_base;

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;

        END IF;

        FOR LN_COUNT IN 1..EN_NUM_VECES
        LOOP

            --Se obtiene el secuencial de producto contratado
            LV_sSql := 'SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL FROM dual';

            SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL
            INTO   LN_COD_PROD_CONTRATADO
            FROM   dual;

            --Se prepara el arreglo de producto
            LO_PRODUCTO := PR_PRODUCTOS_CONTS_TO_QT( LN_COD_PROD_CONTRATADO,
                                                      EN_CLIENTE_DESTINO,
                                                      EN_ABONADO_DESTINO,
                                                      EN_PROD_OFERTADO,
                                                      ED_FECHA_ALTA,
                                                      EV_COD_CANAL,
                                                      EN_NUM_PROCESO,
                                                      EV_COD_CANAL,
                                                      SYSDATE,
                                                      'OK',
                                                      EV_IND_CONTRATA,
                                                      EN_CLIENTE_DESTINO,
                                                      EN_ABONADO_DESTINO,
                                                      ED_FECHA_BAJA,
                                                      1,
                                                      LN_COD_PROD_CONTRATADO,
                                                      LN_cod_perfil_lista,
                                                      LV_tipo_comportamiento,NULL,NULL);

            --Se contrata el Producto
            LV_sSql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR('||
                               LN_COD_PROD_CONTRATADO||', '||
                            EN_CLIENTE_DESTINO||', '||
                            EN_ABONADO_DESTINO||', '||
                            EN_PROD_OFERTADO||', '||
                            ED_FECHA_ALTA||', '||
                            EV_COD_CANAL||', '||
                            EN_NUM_PROCESO||', '||
                            EV_COD_CANAL||', '||
                            SYSDATE||', '||
                            'OK, '||
                            EV_IND_CONTRATA||
                            EN_CLIENTE_DESTINO||', '||
                            EN_ABONADO_DESTINO||', '||
                            ED_FECHA_BAJA||', '||
                            '1 '||
                            LN_COD_PROD_CONTRATADO||', '||
                            LN_cod_perfil_lista||', '||
                            LV_tipo_comportamiento||')';

            PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(LO_PRODUCTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            IF (LV_ind_tipo_servicio = 'TOL') THEN
            --Se informa el producto contratado a TOL
                LV_sSql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR('||EN_ABONADO_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA||', '||
                           LV_cod_servicio_base||', '||LN_COD_PROD_CONTRATADO||', '||1||', '||EN_CLIENTE_DESTINO||', '||
                           EV_COD_CANAL||', '||LO_ABONADO.COD_CICLO||')';
                --P-CSR-11002 JLGN 07-06-2011
                --TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
                TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR@LNK_PRODUC_SCL_TOL(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
                                                                LN_COD_PROD_CONTRATADO, 1, EN_CLIENTE_DESTINO, EV_COD_CANAL, LO_ABONADO.COD_CICLO,
                                                               SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

                IF (LN_cod_prov_serv IS NOT NULL) THEN

                --Se prepara la estructura para enviar a centrales
                    LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
                    LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
                    LO_LISTA_CENTRALES.TIP_ACCION := '1';
                    LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
                    LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
                    LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
                    LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
                    LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
                    LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
                    LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
                    LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
                    LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
                    LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
                    LO_LISTA_CENTRALES.IMPORTE := '0';
                    LO_LISTA_CENTRALES.COD_MONEDA := '0';
                    LO_LISTA_CENTRALES.USUARIO := 'SCL';
                    LO_LISTA_CENTRALES.COD_CAUSA := '00';
                    LO_LISTA_CENTRALES.MONTO_BONIF := '0';
                    LO_LISTA_CENTRALES.TIPO_BONO := '0';
                    LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
                    LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
                    LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
                    LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
                --Se informa el movimiento a centrales
                    --P-CSR-11002 JLGN 15-11-2011
                    --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                    IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                    IF (SN_COD_RETORNO != 0) THEN
                        RAISE ERROR_SUBFUNCION;
                    END IF;
                END IF;

            ELSIF (LV_ind_tipo_servicio = 'AA') THEN

                --Se prepara la estructura para enviar a centrales
                LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
                LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
                LO_LISTA_CENTRALES.TIP_ACCION := '1';
                LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
                LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
                LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
                LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
                LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
                LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
                LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
                LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
                LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
                LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
                LO_LISTA_CENTRALES.IMPORTE := '0';
                LO_LISTA_CENTRALES.COD_MONEDA := '0';
                LO_LISTA_CENTRALES.USUARIO := 'SCL';
                LO_LISTA_CENTRALES.COD_CAUSA := '00';
                LO_LISTA_CENTRALES.MONTO_BONIF := LN_can_bonificar;
                LO_LISTA_CENTRALES.TIPO_BONO := LV_tipo_unidad_bonificar;
                LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
                LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
                LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
                LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

                --Se informa el movimiento a centrales
                --P-CSR-11002 JLGN 15-11-2011
                --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END IF;
            
            
            --INICIO INC 194913 AFD
            --IF (EV_IND_CONTRATA = 'O') THEN 
            IF (EV_IND_CONTRATA = 'O' OR EV_IND_CONTRATA = 'B') THEN 
            --FIN INC 194913 AFD
                LV_sSql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,';
                LV_sSql := LV_sSql || ' DECODE(concepto.ind_prorrateable,''''S'''',1,0), cargos.cod_cargo';
                LV_sSql := LV_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
                LV_sSql := LV_sSql || ' pf_conceptos_prod_td concepto';
                LV_sSql := LV_sSql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
                LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
                LV_sSql := LV_sSql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
                LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = '||EN_PROD_OFERTADO;
                LV_sSql := LV_sSql || ' AND       catalogo.cod_canal = '||EV_COD_CANAL;
                LV_sSql := LV_sSql || ' AND       catalogo.fec_inicio_vigencia <= '||ED_FECHA_ALTA;
                LV_sSql := LV_sSql || ' AND       catalogo.fec_termino_vigencia >= '||ED_FECHA_BAJA;
--                LV_sSql := LV_sSql || ' AND       concepto.tipo_cargo = ''''R''';
                --Se buscan los cargos recurrentes
                OPEN C_CARGOS FOR
                SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,
                       DECODE(concepto.ind_prorrateable,'S',1,0), cargos.cod_cargo, concepto.tipo_cargo
                FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
                       pf_conceptos_prod_td concepto
                WHERE  catalogo.cod_concepto = concepto.cod_concepto
                AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                AND       catalogo.cod_cargo = cargos.cod_cargo
                AND       catalogo.cod_prod_ofertado = EN_PROD_OFERTADO
                AND       catalogo.cod_canal = EV_COD_CANAL
                AND       catalogo.fec_inicio_vigencia <= ED_FECHA_ALTA
                AND       catalogo.fec_termino_vigencia >= ED_FECHA_BAJA;
--                AND       concepto.tipo_cargo = 'R';

                --Se incializa la estructura de cargos Recurrentes
                LO_CARGOS_REC := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

                --Se incializa la estructura de cargos ocasionales
                LO_CARGOS := FA_CARGOS_QT('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

                LOOP
                    FETCH C_CARGOS INTO LN_MONTO_IMPORTE, LV_COD_MONEDA, LN_COD_CONCEPTO, LN_IND_PRORRATEABLE, LN_COD_CARGO, LV_TIP_CARGO;

                    EXIT WHEN C_CARGOS%NOTFOUND;

                    IF (LV_TIP_CARGO= 'R') THEN

                        --Se prepara la estructura para informar cargos recurrentes
                        LO_CARGOS_REC.COD_CLIENTESERV      := EN_CLIENTE_DESTINO;
                        LO_CARGOS_REC.NUM_ABONADOSERV      := EN_ABONADO_DESTINO;
                        LO_CARGOS_REC.COD_PROD_CONTRATADO  := LN_COD_PROD_CONTRATADO;
                        LO_CARGOS_REC.COD_CARGO_CONTRATADO := LN_COD_CARGO;
                        LO_CARGOS_REC.COD_CLIENTEPAGO      := EN_CLIENTE_DESTINO;
                        LO_CARGOS_REC.NUM_ABONADOPAGO      := EN_ABONADO_DESTINO;
        --                LO_CARGOS_REC.COD_TIPSERV          := ;--VARCHAR2(2)
        --                LO_CARGOS_REC.COD_SERVICIO         := ;--VARCHAR2(5)
                        LO_CARGOS_REC.COD_PLANSERV         := LO_ABONADO.COD_PLANSERV;
                        LO_CARGOS_REC.IND_CARGOPRO         := LN_IND_PRORRATEABLE;
                        LO_CARGOS_REC.COD_CONCEPTO         := LN_COD_CONCEPTO;
                        LO_CARGOS_REC.FEC_ALTA             := ED_FECHA_ALTA;
                        LO_CARGOS_REC.FEC_BAJA             := ED_FECHA_BAJA;
                        LO_CARGOS_REC.FEC_DESDECOBR        := ED_FECHA_ALTA;
                        LO_CARGOS_REC.FEC_HASTACOBR        := ED_FECHA_BAJA;
        --                LO_CARGOS_REC.IND_BLOQUEO          := ;--VARCHAR2(5)
        --                LO_CARGOS_REC.EST_BLOQUEO          := ;--VARCHAR2(5)
                        LO_CARGOS_REC.FEC_DESDEBLOC        := ED_FECHA_ALTA;
                        LO_CARGOS_REC.FEC_HASTABLOC        := ED_FECHA_BAJA;
        --                LO_CARGOS_REC.FEC_ULTFACTURA       := ;--DATE
        --                LO_CARGOS_REC.COD_ULTCICLFACT      := ;--NUMBER(10)
        --                LO_CARGOS_REC.NUM_ULTPROCESO       := ;--NUMBER(10)
        --                LO_CARGOS_REC.FEC_ULTMOD           := ;--DATE
                        LO_CARGOS_REC.NOM_USUARIO          := LV_USUARIO;--VARCHAR2(30)

                        LV_sSql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO||', '
                                            ||LN_COD_CARGO||', '||LO_ABONADO.COD_PLANSERV||', '||LN_IND_PRORRATEABLE||', '||LN_COD_CONCEPTO||')';
                        FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR (LO_CARGOS_REC, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                        IF (SN_COD_RETORNO != 0) THEN
                            RAISE ERROR_SUBFUNCION;
                        END IF;

                    ELSE
                        LV_sSql:= 'SELECT cod_ciclfact';
                        LV_sSql:= LV_sSql ||' FROM fa_ciclfact';
                        LV_sSql:= LV_sSql ||'    WHERE  cod_ciclo  = '||LO_ABONADO.COD_CICLO;
                        LV_sSql:= LV_sSql ||' AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos';

                        BEGIN
                            SELECT cod_ciclfact
                            INTO   LO_CARGOS.COD_CICLFACT
                            FROM   fa_ciclfact
                            WHERE  cod_ciclo  = LO_ABONADO.COD_CICLO -- ciclo de facturación del contratante (cod_ciclo)
                            AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos;
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                  SN_Cod_retorno:=1411;
                                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
                                     SV_mens_retorno := cv_error_no_clasif;
                                  END IF;
                                  LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
                                  SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                                  RETURN FALSE;
                        END;

                        --LO_CARGOS.SEQ_CARGO              := ;--    NUMBER(9),
                        LO_CARGOS.COD_CLIENTE            := EN_CLIENTE_DESTINO;--    NUMBER(10),
                        LO_CARGOS.NUM_ABONADO            := EN_ABONADO_DESTINO;--    NUMBER(10),
                        LO_CARGOS.COD_PROD_CONTRATADO    := LN_COD_PROD_CONTRATADO;--    NUMBER(38),
                        LO_CARGOS.COD_PRODUCTO            := 1;--    NUMBER(1),
                        LO_CARGOS.ID_CARGO                := LN_COD_CARGO;--    NUMBER(9),
                        LO_CARGOS.COD_CONCEPTO            := LN_COD_CONCEPTO;--    NUMBER(9),
                        --LO_CARGOS.COLUMNA                := ;--    NUMBER(6),
                        LO_CARGOS.FEC_ALTA                := ED_FECHA_ALTA;--    DATE,
                        LO_CARGOS.IMP_CARGO                := LN_MONTO_IMPORTE;--    NUMBER(14,4)
                        LO_CARGOS.COD_MONEDA            := LV_COD_MONEDA;--    VARCHAR2(3),
                        LO_CARGOS.COD_PLANCOM            := 1;--    NUMBER(6),
                        LO_CARGOS.NUM_UNIDADES            := 1;--    NUMBER(6),
                        LO_CARGOS.IND_FACTUR            := 9;--    NUMBER(1),
                        --LO_CARGOS.NUM_TRANSACCION        := ;--    NUMBER(9),
                        --LO_CARGOS.NUM_VENTA            := 0;--    NUMBER(8),
                        --LO_CARGOS.NUM_PAQUETE            := ;--    NUMBER(3),
                        LO_CARGOS.NUM_TERMINAL            := LO_ABONADO.NUM_CELULAR;--    VARCHAR2(15)
                        --LO_CARGOS.COD_CICLFACT        := ;--    NUMBER(6),
                        --LO_CARGOS.NUM_SERIE            := ;--    VARCHAR2(25)
                        --LO_CARGOS.NUM_SERIEMEC        := ;--    VARCHAR2(20)
                        --LO_CARGOS.CAP_CODE            := ;--    NUMBER(7),
                        LO_CARGOS.MES_GARANTIA            := 0;--    NUMBER(2),
                        --LO_CARGOS.NUM_PREGUIA            := ;--    VARCHAR2(10)
                        --LO_CARGOS.NUM_GUIA            := ;--    VARCHAR2(10)
                        --LO_CARGOS.COD_CONCEREL        := ;--    NUMBER(8),
                        --LO_CARGOS.COLUMNA_REL            := ;--    NUMBER(4),
                        --LO_CARGOS.COD_CONCEPTO_DTO    := ;--    NUMBER(4),
                        --LO_CARGOS.VAL_DTO                := ;--    NUMBER(14,4)
                        --LO_CARGOS.TIP_DTO                := ;--    NUMBER(1),
                        LO_CARGOS.IND_CUOTA                := 0;--    NUMBER(1),
                        --LO_CARGOS.NUM_CUOTAS            := ;--    NUMBER(3),
                        --LO_CARGOS.ORD_CUOTA            := ;--    NUMBER(3),
                        LO_CARGOS.IND_SUPERTEL            := 0;--    NUMBER(1),
                        --LO_CARGOS.IND_MANUAL            := ;--    NUMBER(1),
                        --LO_CARGOS.PREF_PLAZA            := ;--    VARCHAR2(10)
                        LO_CARGOS.COD_TECNOLOGIA        := LO_ABONADO.COD_TECNOLOGIA;--    VARCHAR2(7),
                        --LO_CARGOS.GLS_DESCRIP            := ;--    VARCHAR2(100
                        --LO_CARGOS.NUM_FACTURA            := ;--    NUMBER(10),
                        LO_CARGOS.FEC_ULTMOD            := SYSDATE;--    DATE,
                        LO_CARGOS.NOM_USUARIO            := LV_USUARIO;--    VARCHAR2(30)

                        -- INICIO INC 189196 23/10/2012
                         IF (lv_cargo_recurrente = TRUE) THEN
                            lo_cargos.ind_factur   := 9;
                        ELSE
                            lo_cargos.ind_factur   := 1;
                        END IF;
                        -- FIN INC 189196 23/10/2012

                        LV_sSql:= 'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO
                        ||', '||LN_COD_CARGO||', '||LN_COD_CONCEPTO||', '||ED_FECHA_ALTA||', '||LN_MONTO_IMPORTE||', '||LV_COD_MONEDA||', '||
                        LO_ABONADO.NUM_CELULAR||', '||LO_ABONADO.COD_TECNOLOGIA||', '||LV_USUARIO||')';

                        FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(LO_CARGOS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                        IF (SN_COD_RETORNO != 0) THEN
                            RAISE ERROR_SUBFUNCION;
                        END IF;

                    END IF;

                END LOOP;
            END IF;

        END LOOP;

    RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN TRUE;
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
END PV_AGREGA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO  IN ge_clientes.cod_cliente%TYPE,
                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                        EN_PROD_OFERTADO   IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                        ED_FECHA_ALTA        IN DATE,
                        ED_FECHA_BAJA       IN DATE,
                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                        EO_LISTA_NUMEROS   IN SV_LISTA_CONTRA_TO_LST_QT,
                        EV_IND_CONTRATA       IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_AGREGA_CON_LISTA_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Realiza la contratación de un producto en todas las plataformas e ingresa una lista de números si se provee</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_i             NUMBER:=0;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;
C_CARGOS             refcursor;
LO_ABONADO               GA_ABONADO_QT;
LO_PRODUCTO              PR_PRODUCTOS_CONTS_TO_QT;
LO_LISTA_NUMEROS     SV_LISTA_CONTRA_TO_LST_QT := SV_LISTA_CONTRA_TO_LST_QT(SV_LISTA_CONTRA_TO_QT('','','','','','','','','',''));
LO_NUMERO              SV_LISTA_CONTRA_TO_QT := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
LO_LISTA_CENTRALES     IC_PROVISION_QT;
LO_CARGOS_REC         FA_CARGOS_REC_QT;
LO_CLIENTE              PV_CLIENTE_QT;
LO_CARGOS             FA_CARGOS_QT;

LV_VAL_ELEMENTO         sv_lista_contratada_to.valor_elemento%TYPE;
LD_FEC_INI_VIG         sv_lista_contratada_to.fec_inicio_vigencia%TYPE;
LD_FEC_TER_VIG         sv_lista_contratada_to.fec_termino_vigencia%TYPE;
LV_CATEGORIA_DESTINO sv_lista_contratada_to.cod_categoria_destino%TYPE;

LN_MONTO_IMPORTE     pf_cargos_productos_td.monto_importe%TYPE;
LV_COD_MONEDA          pf_cargos_productos_td.cod_moneda%TYPE;
LN_COD_CARGO          pf_cargos_productos_td.cod_cargo%TYPE;
LN_COD_CONCEPTO      pf_catalogo_ofertado_td.cod_concepto%TYPE;
LV_TIP_CARGO         pf_conceptos_prod_td.tipo_cargo%TYPE;
LN_IND_PRORRATEABLE  NUMBER;
LV_IND_NIVEL_APLICA     pf_productos_ofertados_td.ind_nivel_aplica%TYPE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
LD_FECDESDECARGOS      fa_ciclfact.fec_desdeocargos%TYPE;
LD_FECHASTACARGOS      fa_ciclfact.fec_hastaocargos%TYPE;

LB_HAYNUMEROS         BOOLEAN;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LB_HAYNUMEROS := FALSE; --Se asume la inexistencia de números en la lista

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                            '','','','','','','','','','');

    --Se prepara estructura para obtener datos del abonado
    LO_CLIENTE := PV_CLIENTE_QT(EN_CLIENTE_DESTINO,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                                                        '','','','','','','','','','','','');
    IF (EN_ABONADO_DESTINO != 0 AND EN_ABONADO_DESTINO IS NOT NULL) THEN

        LV_IND_NIVEL_APLICA := 'A';


        --Se Obtienen los datos del abonado
        PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        LV_IND_NIVEL_APLICA := 'C';

        PV_DATOS_CLIENTES_PG.PV_OBTIENE_DATOS_CLIENTE_PR(LO_CLIENTE, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

        LO_ABONADO.COD_CICLO := LO_CLIENTE.COD_CICLO;
        LO_ABONADO.COD_CLIENTE := LO_CLIENTE.COD_CLIENTE;
        LO_ABONADO.TIP_TERMINAL := LO_CLIENTE.TIP_TERMINAL;
        LO_ABONADO.COD_TECNOLOGIA := LO_CLIENTE.COD_TECNOLOGIA;

    END IF;

    --Se buscan los datos necesarios para contratar productos
    LV_sSql := 'SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,';
    LV_sSql := LV_sSql || ' servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma';
    LV_sSql := LV_sSql || ' FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio';
    LV_sSql := LV_sSql || ' WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND       ofertado.cod_espec_prod = servicio.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND       ofertado.cod_prod_ofertado = '||EN_PROD_OFERTADO;
    LV_sSql := LV_sSql || ' AND       ofertado.ind_nivel_aplica = '||LV_IND_NIVEL_APLICA;

    SELECT servicio.cod_espec_prod, NVL(servicio.cod_perfil_lista,0), servicio.cod_prov_serv, servicio.cod_servicio_base,
           servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
    INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
           LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
    FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
    WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
    AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
    AND       ofertado.cod_prod_ofertado = EN_PROD_OFERTADO
    AND       ofertado.ind_nivel_aplica = LV_IND_NIVEL_APLICA;

    IF (LV_ind_tipo_servicio = 'AA') THEN

        LV_sSql := 'SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar';
        LV_sSql := LV_sSql || ' FROM   se_planes_altamira_td altamira';
        LV_sSql := LV_sSql || ' WHERE  altamira.cod_plan_altamira = '||LV_cod_servicio_base;

        SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
        INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
        FROM   se_planes_altamira_td altamira
        WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;

    END IF;

    --Se obtiene el secuencial de producto contratado
    LV_sSql := 'SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL FROM dual';

    SELECT PF_PRODUCTOS_CONTRATADOS_SQ.NEXTVAL
    INTO   LN_COD_PROD_CONTRATADO
    FROM   dual;

    --Se prepara el arreglo de producto
    LO_PRODUCTO := PR_PRODUCTOS_CONTS_TO_QT( LN_COD_PROD_CONTRATADO,
                                              EN_CLIENTE_DESTINO,
                                              EN_ABONADO_DESTINO,
                                              EN_PROD_OFERTADO,
                                              ED_FECHA_ALTA,
                                              EV_COD_CANAL,
                                              EN_NUM_PROCESO,
                                              EV_COD_CANAL,
                                              SYSDATE,
                                              'OK',
                                              EV_IND_CONTRATA,
                                              EN_CLIENTE_DESTINO,
                                              EN_ABONADO_DESTINO,
                                              ED_FECHA_BAJA,
                                              1,
                                              LN_COD_PROD_CONTRATADO,
                                              LN_cod_perfil_lista,
                                              LV_tipo_comportamiento, NULL, NULL);

    --Se contrata el Producto
    LV_sSql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR('||
                       LN_COD_PROD_CONTRATADO||', '||
                    EN_CLIENTE_DESTINO||', '||
                    EN_ABONADO_DESTINO||', '||
                    EN_PROD_OFERTADO||', '||
                    ED_FECHA_ALTA||', '||
                    EV_COD_CANAL||', '||
                    EN_NUM_PROCESO||', '||
                    EV_COD_CANAL||', '||
                    SYSDATE||', '||
                    'OK, '||
                    EV_IND_CONTRATA||', '||
                    EN_CLIENTE_DESTINO||', '||
                    EN_ABONADO_DESTINO||', '||
                    ED_FECHA_BAJA||', '||
                    '1 '||
                    LN_COD_PROD_CONTRATADO||', '||
                    LN_cod_perfil_lista||', '||
                    LV_tipo_comportamiento||')';

    PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(LO_PRODUCTO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;

    IF (LV_ind_tipo_servicio = 'TOL') THEN
    --Se informa el producto contratado a TOL
        LV_sSql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR('||EN_ABONADO_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA||', '||
           LV_cod_servicio_base||', '||LN_COD_PROD_CONTRATADO||', '||1||', '||EN_CLIENTE_DESTINO||', '||
           EV_COD_CANAL||', '||LO_ABONADO.COD_CICLO||')';
        --P-CSR-11002 JLGN 07-06-2011
        --TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
        TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_FACHADA_PR@LNK_PRODUC_SCL_TOL(EN_ABONADO_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, LV_cod_servicio_base,
                                                        LN_COD_PROD_CONTRATADO, 1, EN_CLIENTE_DESTINO, EV_COD_CANAL, LO_ABONADO.COD_CICLO,
                                                        SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

        --Se prepara la estructura para enviar a centrales
            LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
            LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
            LO_LISTA_CENTRALES.TIP_ACCION := '1';
            LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
            LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
            LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
            LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
            LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
            LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
            LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
            LO_LISTA_CENTRALES.IMPORTE := '0';
            LO_LISTA_CENTRALES.COD_MONEDA := '0';
            LO_LISTA_CENTRALES.USUARIO := 'SCL';
            LO_LISTA_CENTRALES.COD_CAUSA := '00';
            LO_LISTA_CENTRALES.MONTO_BONIF := '0';
            LO_LISTA_CENTRALES.TIPO_BONO := '0';
            LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
            LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
        --Se informa el movimiento a centrales
            --P-CSR-11002 JLGN 15-11-2011
            --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    ELSIF (LV_ind_tipo_servicio = 'AA') THEN

        --Se prepara la estructura para enviar a centrales
        LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
        LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
        LO_LISTA_CENTRALES.TIP_ACCION := '1';
        LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
        LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
        LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
        LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
        LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
        LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
        LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
        LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
        LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
        LO_LISTA_CENTRALES.IMPORTE := '0';
        LO_LISTA_CENTRALES.COD_MONEDA := '0';
        LO_LISTA_CENTRALES.USUARIO := 'SCL';
        LO_LISTA_CENTRALES.COD_CAUSA := '00';
        LO_LISTA_CENTRALES.MONTO_BONIF := LN_can_bonificar;
        LO_LISTA_CENTRALES.TIPO_BONO := LV_tipo_unidad_bonificar;
        LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
        LO_LISTA_CENTRALES.FECHA_EJEC_BONO := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
        LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

        --Se informa el movimiento a centrales
        --P-CSR-11002 JLGN 15-11-2011
        --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END IF;

    IF (EO_LISTA_NUMEROS IS NOT NULL) THEN

        OPEN C_LISTA_NUMEROS FOR
        SELECT
            valor_elemento, fec_inicio_vigencia, fec_termino_vigencia, cod_categoria_destino
        FROM
            TABLE(EO_LISTA_NUMEROS);

        LOOP

            FETCH C_LISTA_NUMEROS INTO LV_VAL_ELEMENTO, LD_FEC_INI_VIG, LD_FEC_TER_VIG, LV_CATEGORIA_DESTINO;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND OR LV_VAL_ELEMENTO IS NULL;

            LB_HAYNUMEROS := TRUE; --Con que pase una vez, ya hay números

            --P-CSR-11002 JLGN 07-06-2011
            --TOL_PRODUCTO_CONTRATADO_PG.SV_FACADE_ALTA_LISTAS_PR(EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_CONTRATADO,
            TOL_PRODUCTO_CONTRATADO_PG.SV_FACADE_ALTA_LISTAS_PR@LNK_PRODUC_SCL_TOL(EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_CONTRATADO,
                                LV_TIPO_COMPORTAMIENTO, LV_VAL_ELEMENTO, LD_FEC_INI_VIG, LD_FEC_TER_VIG, LV_CATEGORIA_DESTINO,
                                SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;

        IF (LB_HAYNUMEROS) THEN --Si existe al menos un número en la lista, se contrata en SCL

            FOR LN_i IN 1..EO_LISTA_NUMEROS.count LOOP

                IF (LN_i>1) THEN
                    LO_LISTA_NUMEROS.extend;
                END IF;

                LO_NUMERO := EO_LISTA_NUMEROS(LN_i);

                LO_NUMERO.COD_PROD_CONTRATADO := LN_COD_PROD_CONTRATADO;

                LO_LISTA_NUMEROS(LO_LISTA_NUMEROS.count) := LO_NUMERO;
            END LOOP;

            LV_sSql := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR([OBJECT])';
            SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(LO_LISTA_NUMEROS,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;


    END IF;

    IF (EV_IND_CONTRATA = 'O') THEN
        LV_sSql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,';
        LV_sSql := LV_sSql || ' DECODE(concepto.ind_prorrateable,''''S'''',1,0), cargos.cod_cargo';
        LV_sSql := LV_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
        LV_sSql := LV_sSql || ' pf_conceptos_prod_td concepto';
        LV_sSql := LV_sSql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = '||EN_PROD_OFERTADO;
        LV_sSql := LV_sSql || ' AND       catalogo.cod_canal = '||EV_COD_CANAL;
        LV_sSql := LV_sSql || ' AND       catalogo.fec_inicio_vigencia <= '||ED_FECHA_ALTA;
        LV_sSql := LV_sSql || ' AND       catalogo.fec_termino_vigencia >= '||ED_FECHA_BAJA;

        --Se buscan los cargos
        OPEN C_CARGOS FOR
        SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto,
               DECODE(concepto.ind_prorrateable,'S',1,0), cargos.cod_cargo, concepto.tipo_cargo
        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
               pf_conceptos_prod_td concepto
        WHERE  catalogo.cod_concepto = concepto.cod_concepto
        AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
        AND       catalogo.cod_cargo = cargos.cod_cargo
        AND       catalogo.cod_prod_ofertado = EN_PROD_OFERTADO
        AND       catalogo.cod_canal = EV_COD_CANAL
        AND       catalogo.fec_inicio_vigencia <= ED_FECHA_ALTA
        AND       catalogo.fec_termino_vigencia >= ED_FECHA_BAJA;

        --Se incializa la estructura de cargos
        LO_CARGOS_REC := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

        --Se incializa la estructura de cargos ocasionales
        LO_CARGOS := FA_CARGOS_QT('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        LOOP
            FETCH C_CARGOS INTO LN_MONTO_IMPORTE, LV_COD_MONEDA, LN_COD_CONCEPTO, LN_IND_PRORRATEABLE, LN_COD_CARGO, LV_TIP_CARGO;

            EXIT WHEN C_CARGOS%NOTFOUND;

            IF (LV_TIP_CARGO= 'R') THEN
                --Se prepara la estructura para informar cargos recurrentes
                LO_CARGOS_REC.COD_CLIENTESERV      := EN_CLIENTE_DESTINO;
                LO_CARGOS_REC.NUM_ABONADOSERV      := EN_ABONADO_DESTINO;
                LO_CARGOS_REC.COD_PROD_CONTRATADO  := LN_COD_PROD_CONTRATADO;
                LO_CARGOS_REC.COD_CARGO_CONTRATADO := LN_COD_CARGO;
                LO_CARGOS_REC.COD_CLIENTEPAGO      := EN_CLIENTE_DESTINO;
                LO_CARGOS_REC.NUM_ABONADOPAGO      := EN_ABONADO_DESTINO;
--                LO_CARGOS_REC.COD_TIPSERV          := ;--VARCHAR2(2)
--                LO_CARGOS_REC.COD_SERVICIO         := ;--VARCHAR2(5)
                LO_CARGOS_REC.COD_PLANSERV         := LO_ABONADO.COD_PLANSERV;
                LO_CARGOS_REC.IND_CARGOPRO         := LN_IND_PRORRATEABLE;
                LO_CARGOS_REC.COD_CONCEPTO         := LN_COD_CONCEPTO;
                LO_CARGOS_REC.FEC_ALTA             := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_BAJA             := ED_FECHA_BAJA;
                LO_CARGOS_REC.FEC_DESDECOBR        := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_HASTACOBR        := ED_FECHA_BAJA;
--                LO_CARGOS_REC.IND_BLOQUEO          := ;--VARCHAR2(5)
--                LO_CARGOS_REC.EST_BLOQUEO          := ;--VARCHAR2(5)
                LO_CARGOS_REC.FEC_DESDEBLOC        := ED_FECHA_ALTA;
                LO_CARGOS_REC.FEC_HASTABLOC        := ED_FECHA_BAJA;
--                LO_CARGOS_REC.FEC_ULTFACTURA       := ;--DATE
--                LO_CARGOS_REC.COD_ULTCICLFACT      := ;--NUMBER(10)
--                LO_CARGOS_REC.NUM_ULTPROCESO       := ;--NUMBER(10)
--                LO_CARGOS_REC.FEC_ULTMOD           := ;--DATE
                LO_CARGOS_REC.NOM_USUARIO          := LV_USUARIO;--VARCHAR2(30)

                LV_sSql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO||', '
                                    ||LN_COD_CARGO||', '||LO_ABONADO.COD_PLANSERV||', '||LN_IND_PRORRATEABLE||', '||LN_COD_CONCEPTO||')';
                FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR (LO_CARGOS_REC, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            ELSE
                LV_sSql:= 'SELECT cod_ciclfact';
                LV_sSql:= LV_sSql ||' FROM fa_ciclfact';
                LV_sSql:= LV_sSql ||'    WHERE  cod_ciclo  = '||LO_ABONADO.COD_CICLO;
                LV_sSql:= LV_sSql ||' AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos';

                BEGIN
                    SELECT cod_ciclfact
                    INTO   LO_CARGOS.COD_CICLFACT
                    FROM   fa_ciclfact
                    WHERE  cod_ciclo  = LO_ABONADO.COD_CICLO -- ciclo de facturación del contratante (cod_ciclo)
                    AND sysdate BETWEEN fec_desdeocargos AND fec_hastaocargos;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                          SN_Cod_retorno:=1411;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
                             SV_mens_retorno := cv_error_no_clasif;
                          END IF;
                          LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
                          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
                          RETURN FALSE;
                END;

                --LO_CARGOS.SEQ_CARGO              := ;--    NUMBER(9),
                LO_CARGOS.COD_CLIENTE            := EN_CLIENTE_DESTINO;--    NUMBER(10),
                LO_CARGOS.NUM_ABONADO            := EN_ABONADO_DESTINO;--    NUMBER(10),
                LO_CARGOS.COD_PROD_CONTRATADO    := LN_COD_PROD_CONTRATADO;--    NUMBER(38),
                LO_CARGOS.COD_PRODUCTO            := 1;--    NUMBER(1),
                LO_CARGOS.ID_CARGO                := LN_COD_CARGO;--    NUMBER(9),
                LO_CARGOS.COD_CONCEPTO            := LN_COD_CONCEPTO;--    NUMBER(9),
                --LO_CARGOS.COLUMNA                := ;--    NUMBER(6),
                LO_CARGOS.FEC_ALTA                := ED_FECHA_ALTA;--    DATE,
                LO_CARGOS.IMP_CARGO                := LN_MONTO_IMPORTE;--    NUMBER(14,4)
                LO_CARGOS.COD_MONEDA            := LV_COD_MONEDA;--    VARCHAR2(3),
                LO_CARGOS.COD_PLANCOM            := 1;--    NUMBER(6),
                LO_CARGOS.NUM_UNIDADES            := 1;--    NUMBER(6),
                LO_CARGOS.IND_FACTUR            := 9;--    NUMBER(1),
                --LO_CARGOS.NUM_TRANSACCION        := ;--    NUMBER(9),
                --LO_CARGOS.NUM_VENTA            := 0;--    NUMBER(8),
                --LO_CARGOS.NUM_PAQUETE            := ;--    NUMBER(3),
                LO_CARGOS.NUM_TERMINAL            := LO_ABONADO.NUM_CELULAR;--    VARCHAR2(15)
                --LO_CARGOS.COD_CICLFACT        := ;--    NUMBER(6),
                --LO_CARGOS.NUM_SERIE            := ;--    VARCHAR2(25)
                --LO_CARGOS.NUM_SERIEMEC        := ;--    VARCHAR2(20)
                --LO_CARGOS.CAP_CODE            := ;--    NUMBER(7),
                LO_CARGOS.MES_GARANTIA            := 0;--    NUMBER(2),
                --LO_CARGOS.NUM_PREGUIA            := ;--    VARCHAR2(10)
                --LO_CARGOS.NUM_GUIA            := ;--    VARCHAR2(10)
                --LO_CARGOS.COD_CONCEREL        := ;--    NUMBER(8),
                --LO_CARGOS.COLUMNA_REL            := ;--    NUMBER(4),
                --LO_CARGOS.COD_CONCEPTO_DTO    := ;--    NUMBER(4),
                --LO_CARGOS.VAL_DTO                := ;--    NUMBER(14,4)
                --LO_CARGOS.TIP_DTO                := ;--    NUMBER(1),
                LO_CARGOS.IND_CUOTA                := 0;--    NUMBER(1),
                --LO_CARGOS.NUM_CUOTAS            := ;--    NUMBER(3),
                --LO_CARGOS.ORD_CUOTA            := ;--    NUMBER(3),
                LO_CARGOS.IND_SUPERTEL            := 0;--    NUMBER(1),
                --LO_CARGOS.IND_MANUAL            := ;--    NUMBER(1),
                --LO_CARGOS.PREF_PLAZA            := ;--    VARCHAR2(10)
                LO_CARGOS.COD_TECNOLOGIA        := LO_ABONADO.COD_TECNOLOGIA;--    VARCHAR2(7),
                --LO_CARGOS.GLS_DESCRIP            := ;--    VARCHAR2(100
                --LO_CARGOS.NUM_FACTURA            := ;--    NUMBER(10),
                LO_CARGOS.FEC_ULTMOD            := SYSDATE;--    DATE,
                LO_CARGOS.NOM_USUARIO            := LV_USUARIO;--    VARCHAR2(30)

                LV_sSql:= 'FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_CONTRATADO
                ||', '||LN_COD_CARGO||', '||LN_COD_CONCEPTO||', '||ED_FECHA_ALTA||', '||LN_MONTO_IMPORTE||', '||LV_COD_MONEDA||', '||
                LO_ABONADO.NUM_CELULAR||', '||LO_ABONADO.COD_TECNOLOGIA||', '||LV_USUARIO||')';

                FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(LO_CARGOS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END IF;

        END LOOP;
    END IF;

    RETURN TRUE;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_CON_LISTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_CON_LISTA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
END PV_AGREGA_CON_LISTA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_QUITA_FN( EN_CLIENTE_DESTINO  IN ge_clientes.cod_cliente%TYPE,
                    EN_ABONADO_DESTINO     IN ga_abocel.num_abonado%TYPE,
                    EN_PROD_CONTRATADO  IN pr_productos_contratados_to.cod_prod_contratado%TYPE,
                    EN_PROD_OFERTADO     IN pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                    ED_FECHA_ALTA        IN DATE,
                    ED_FECHA_BAJA         IN DATE,
                    EN_NUM_MOV_ANT         IN icc_movimiento.num_movant%TYPE,
                    EN_NUM_PROCESO         IN pr_productos_contratados_to.num_proceso%TYPE,
                    EV_COD_CANAL         IN pr_productos_contratados_to.cod_canal%TYPE,
                    EV_IND_CONTRATA        IN pr_productos_contratados_to.ind_condicion_contratacion%TYPE,
                    SN_COD_RETORNO      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                    SV_MENS_RETORNO     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                    SN_NUM_EVENTO       OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>BOOLEAN</Retorno>>
       <Descripción>Elimina un producto pasando a historico el registro, informa a todas las plataformas de la baja</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_COD_PROV_SERV         se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_IND_TIPO_SERVICIO     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_COD_PERFIL_LISTA      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_NUMVECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUMVECES_DESTINO         pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_CONTRATADOS         refcursor;
C_CARGOS                 refcursor;
LO_LISTA_PRODUCTOS         PR_PRODUCTO_DES_LST_QT;
LO_LISTA_NUMEROS         SV_PROD_CONTR_LST_QT;
--LO_LISTA_TOL             TOL_BAJA_PRODUCTO_DET_QT; --Se enmascarara package
LO_LISTA_CENTRALES         IC_PROVISION_QT;
LO_CARGOS_REC         FA_CARGOS_REC_QT;

LN_MONTO_IMPORTE     pf_cargos_productos_td.monto_importe%TYPE;
LV_COD_MONEDA          pf_cargos_productos_td.cod_moneda%TYPE;
LN_COD_CARGO          pf_cargos_productos_td.cod_cargo%TYPE;
LN_COD_CONCEPTO      pf_catalogo_ofertado_td.cod_concepto%TYPE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    LV_sSql := 'SELECT servicio.ind_tipo_servicio, servicio.cod_perfil_lista, servicio.cod_prov_serv';
    LV_sSql := LV_sSql || ' FROM se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado';
    LV_sSql := LV_sSql || ' WHERE servicio.cod_espec_prod = ofertado.cod_espec_prod';
    LV_sSql := LV_sSql || ' AND      ofertado.cod_prod_ofertado = '|| EN_PROD_OFERTADO;

    SELECT servicio.ind_tipo_servicio,
           NVL(servicio.cod_perfil_lista,0),
           NVL(servicio.cod_prov_serv,0)
    INTO   LV_IND_TIPO_SERVICIO, LV_COD_PERFIL_LISTA, LN_COD_PROV_SERV
    FROM   se_detalles_especificacion_to servicio, pf_productos_ofertados_td ofertado
    WHERE  servicio.cod_espec_prod = ofertado.cod_espec_prod
    AND       ofertado.cod_prod_ofertado = EN_PROD_OFERTADO;

    IF (LV_IND_TIPO_SERVICIO = 'TOL') THEN

        --Se descontrata el producto en TOL
        LV_sSql := 'TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_PRODUCTO_PR('||EN_PROD_CONTRATADO||','||ED_FECHA_ALTA||')';
        --P-CSR-11002 JLGN 07-06-2011
        --TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR(EN_PROD_CONTRATADO, ED_FECHA_ALTA,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_FACHADA_PR@LNK_PRODUC_SCL_TOL(EN_PROD_CONTRATADO, ED_FECHA_ALTA,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;


        IF (LN_COD_PROV_SERV != 0) THEN    -- Si el producto es de tipo tol, y tiene impacto en centrales se envia comando
            --Se crea arreglo para invocar a centrales
            LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := EN_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
            LO_LISTA_CENTRALES.USUARIO :=  'SCL';
            LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_DESTINO;
            LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_DESTINO;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

            --Se envia movimiento a centrales
            --P-CSR-11002 JLGN 15-11-2011
            --LV_sSql := 'IC_PROVISION_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
            LV_sSql := 'IC_PROVISION_VENTA_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
                                                        ||LO_LISTA_CENTRALES.COD_PROD_CONTRAT||','
                                                        ||LO_LISTA_CENTRALES.FECHA_EJECUCION||','
                                                        ||LO_LISTA_CENTRALES.USUARIO||','
                                                        ||LO_LISTA_CENTRALES.NUM_MOVANT||')';

            --P-CSR-11002 JLGN 15-11-2011
            --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;
    ELSIF (LV_IND_TIPO_SERVICIO = 'AA') THEN

        --Se crea arreglo para invocar a centrales
        LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
        LO_LISTA_CENTRALES.COD_PROD_CONTRAT := EN_PROD_CONTRATADO;
        LO_LISTA_CENTRALES.FECHA_EJECUCION := ED_FECHA_ALTA;
        LO_LISTA_CENTRALES.USUARIO :=  'SCL';
        LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
        LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_DESTINO;
        LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_DESTINO;
        LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;

        --Se envia movimiento a centrales
        --P-CSR-11002 JLGN 15-11-2011
        --LV_sSql := 'IC_PROVISION_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
        LV_sSql := 'IC_PROVISION_VENTA_PG.IC_INSERTA_PR('||LO_LISTA_CENTRALES.TIP_ACCION||','
                                                    ||LO_LISTA_CENTRALES.COD_PROD_CONTRAT||','
                                                    ||LO_LISTA_CENTRALES.FECHA_EJECUCION||','
                                                    ||LO_LISTA_CENTRALES.USUARIO||','
                                                    ||LO_LISTA_CENTRALES.NUM_MOVANT||')';

        --P-CSR-11002 JLGN 15-11-2011
        --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    IF (EV_IND_CONTRATA = 'O') THEN
        LV_sSql := ' SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto, cargos.cod_cargo';
        LV_sSql := LV_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
        LV_sSql := LV_sSql || ' pf_conceptos_prod_td concepto';
        LV_sSql := LV_sSql || ' WHERE  catalogo.cod_concepto = concepto.cod_concepto';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_cargo = cargos.cod_cargo';
        LV_sSql := LV_sSql || ' AND       catalogo.cod_prod_ofertado = '||EN_PROD_OFERTADO;
--        LV_sSql := LV_sSql || ' AND       catalogo.cod_canal = '||EV_COD_CANAL;
        LV_sSql := LV_sSql || ' AND       concepto.tipo_cargo = ''R''';
        --Se buscan los cargos recurrentes
        OPEN C_CARGOS FOR
        SELECT cargos.monto_importe, cargos.cod_moneda, catalogo.cod_concepto, cargos.cod_cargo
        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
               pf_conceptos_prod_td concepto
        WHERE  catalogo.cod_concepto = concepto.cod_concepto
        AND       catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
        AND       catalogo.cod_cargo = cargos.cod_cargo
        AND       catalogo.cod_prod_ofertado = EN_PROD_OFERTADO
--        AND       catalogo.cod_canal = EV_COD_CANAL
        AND       concepto.tipo_cargo = 'R';

        --Se incializa la estructura de cargos
        LO_CARGOS_REC := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

        LOOP
            FETCH C_CARGOS INTO LN_MONTO_IMPORTE, LV_COD_MONEDA, LN_COD_CONCEPTO, LN_COD_CARGO;

            EXIT WHEN C_CARGOS%NOTFOUND;

            --Se prepara la estructura para informar cargos recurrentes
            LO_CARGOS_REC.COD_CLIENTESERV      := EN_CLIENTE_DESTINO;
            LO_CARGOS_REC.NUM_ABONADOSERV      := EN_ABONADO_DESTINO;
            LO_CARGOS_REC.COD_PROD_CONTRATADO  := EN_PROD_CONTRATADO;
            LO_CARGOS_REC.COD_CARGO_CONTRATADO := LN_COD_CARGO;
            LO_CARGOS_REC.COD_CONCEPTO         := LN_COD_CONCEPTO;
            LO_CARGOS_REC.FEC_ALTA             := ED_FECHA_ALTA;
            LO_CARGOS_REC.FEC_BAJA             := ED_FECHA_ALTA;--Fecha de baja del cargo
            LO_CARGOS_REC.NOM_USUARIO          := LV_USUARIO;

            LV_sSql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EN_PROD_CONTRATADO||', '
                                ||LN_COD_CARGO||', '||LN_COD_CONCEPTO||')';
            FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR (LO_CARGOS_REC, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END LOOP;
    END IF;

    IF (LV_COD_PERFIL_LISTA != 0) THEN
        --Se crea arreglo para descontratar la lista de números
        LO_LISTA_NUMEROS:=SV_PROD_CONTR_LST_QT(SV_PROD_CONTRA_QT(EN_PROD_CONTRATADO,EN_NUM_PROCESO,EV_COD_CANAL,'','',''));

        --Se descontrata la lista de numeros asociado al producto
        LV_sSql := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR('||EN_PROD_CONTRATADO||','||EN_NUM_PROCESO||','||EV_COD_CANAL||')';
        SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(LO_LISTA_NUMEROS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    --Se crea arreglo para descontratar el producto
    LO_LISTA_PRODUCTOS:=PR_PRODUCTO_DES_LST_QT(PR_PRODUCTO_DESCONTRATA_QT(EV_COD_CANAL,EN_NUM_PROCESO,ED_FECHA_ALTA,'','','','',ED_FECHA_ALTA,'','','','','','','','','','','','',EN_PROD_CONTRATADO,NULL, NULL, NULL) );

    --Se descontrata el producto
    LV_sSql := 'PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR('||EV_COD_CANAL||','||EN_NUM_PROCESO||','||ED_FECHA_ALTA||','||EN_PROD_CONTRATADO||')';
    PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR(LO_LISTA_PRODUCTOS, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;


    RETURN TRUE;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
      RETURN FALSE;
END PV_QUITA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_DEFECTO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN     IN ta_plantarif.cod_plantarif%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_DEFECTO_PR
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina los planes por defecto del plan origen que no esten por defecto al plan destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;

C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT paqueteOrigen.cod_prod_hijo, paqueteOrigen.num_veces_hijo, producto.cod_prod_contratado';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planOrigen, ';
    LV_sSql := LV_sSql || ' pf_paquete_ofertado_to paqueteOrigen,';
    LV_sSql := LV_sSql || ' pr_productos_contratados_to producto  ';
    LV_sSql := LV_sSql || ' WHERE paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND paqueteOrigen.cod_prod_hijo = producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND producto.ind_condicion_contratacion = ''D''';
    LV_sSql := LV_sSql || ' AND planOrigen.cod_plantarif = '||EV_PLAN_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.COD_CLIENTE_CONTRATANTE = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.NUM_ABONADO_CONTRATANTE = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND paqueteOrigen.cod_prod_hijo NOT IN ';
    LV_sSql := LV_sSql || ' (SELECT paqueteDestino.COD_PROD_HIJO';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino';
    LV_sSql := LV_sSql || ' WHERE paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND planDestino.cod_plantarif = '||EV_PLAN_DESTINO;
    LV_sSql := LV_sSql || ' )';

    -- Se obtienen los planes contratados por defecto que no esten en el plan destino
    OPEN C_PRO_CONTRATADOS FOR
    SELECT paqueteOrigen.cod_prod_hijo, producto.cod_prod_contratado
    FROM   ta_plantarif planOrigen,
           pf_paquete_ofertado_to paqueteOrigen,
           pr_productos_contratados_to producto
    WHERE  paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre
    AND       paqueteOrigen.cod_prod_hijo = producto.cod_prod_ofertado
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'D'
    AND       planOrigen.cod_plantarif = EV_PLAN_ORIGEN
    AND       producto.COD_CLIENTE_CONTRATANTE = EN_CLIENTE_ORIGEN
    AND       producto.NUM_ABONADO_CONTRATANTE = EN_ABONADO_ORIGEN
    AND    paqueteOrigen.cod_prod_hijo NOT IN
        (SELECT paqueteDestino.COD_PROD_HIJO
         FROM   ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino
         WHERE  paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre
         AND     planDestino.cod_plantarif = EV_PLAN_DESTINO
        );


    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO  LN_COD_PROD_OFERTADO, LN_COD_PROD_CONTRATADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                       EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_AGREGA_PLANES_DEFECTO_PR (EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_AGREGA_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Contrata los productos por defecto del plan destino, que no sean por defecto al plan origen</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT paqueteDestino.cod_prod_hijo, paqueteDestino.num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino';
    LV_sSql := LV_sSql || ' WHERE paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND planDestino.cod_plantarif = '||EV_PLAN_DESTINO;
    LV_sSql := LV_sSql || ' AND paqueteDestino.COD_PROD_HIJO NOT IN';
    LV_sSql := LV_sSql || ' (SELECT paqueteOrigen.cod_prod_hijo';
    LV_sSql := LV_sSql || ' FROM ta_plantarif planOrigen, pf_paquete_ofertado_to paqueteOrigen';
    LV_sSql := LV_sSql || ' WHERE paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND planOrigen.cod_plantarif = '||EV_PLAN_ORIGEN||')';

    --Se obtienen los planes adicionales por defecto del destino, que no esten en el origen
    OPEN C_PRO_DEFECTO FOR
    SELECT paqueteDestino.cod_prod_hijo, paqueteDestino.num_veces_hijo
    FROM   ta_plantarif planDestino, pf_paquete_ofertado_to paqueteDestino
    WHERE  paqueteDestino.cod_prod_padre = planDestino.cod_prod_padre
    AND    planDestino.cod_plantarif = EV_PLAN_DESTINO
    AND    paqueteDestino.COD_PROD_HIJO NOT IN
           (SELECT paqueteorigen.cod_prod_hijo
            FROM   ta_plantarif planOrigen, pf_paquete_ofertado_to paqueteOrigen
            WHERE  paqueteOrigen.cod_prod_padre = planOrigen.cod_prod_padre
            AND    planOrigen.cod_plantarif = EV_PLAN_ORIGEN
           );

    LOOP

        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO,LN_NUM_VECES;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
        IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                    LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'D',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_AGREGA_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_OPCIONALES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                    ED_FECHA_ALTA        IN DATE,
                                    ED_FECHA_BAJA        IN DATE,
                                    EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                    EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                    EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                    SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_OPCIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos contratados opcionalmente por el abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''''O''';

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O';

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                   EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_OPCIONALES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_PLANES_DEFECTO_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y de alta los productos contratados que esten por defecto en el origen y destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;

C_PRO_DEFECTO         refcursor;
C_PRO_CONTRATADO     refcursor;
C_LISTA_NUMEROS         refcursor;
BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(LO_NUMERO);

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan';
    LV_sSql := LV_sSql || ' WHERE  paquete.cod_prod_padre = plan.cod_prod_padre';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_DESTINO;

    --Se obtienen los planes por defecto del destino
    OPEN C_PRO_DEFECTO FOR
    SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo
    FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan
    WHERE  paquete.cod_prod_padre = plan.cod_prod_padre
    AND       plan.cod_plantarif = EV_PLAN_DESTINO;

    LOOP

        <<SIGUIENTE>>
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO, LN_NUM_VECES_DESTINO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene el numero de veces que el plan destino está en el origen
        LV_sSql := 'SELECT paquete.num_veces_hijo';
        LV_sSql := LV_sSql || ' FROM pf_paquete_ofertado_to paquete, ta_plantarif plan';
        LV_sSql := LV_sSql || ' WHERE paquete.cod_prod_padre = plan.cod_prod_padre';
        LV_sSql := LV_sSql || ' AND    plan.cod_plantarif = '||EV_PLAN_ORIGEN;
        LV_sSql := LV_sSql || ' AND    paquete.cod_prod_hijo = '||LN_COD_PROD_OFERTADO;

        BEGIN
            SELECT paquete.num_veces_hijo
            INTO   LN_NUM_VECES_ORIGEN
            FROM   pf_paquete_ofertado_to paquete, ta_plantarif plan
            WHERE  paquete.cod_prod_padre = plan.cod_prod_padre
            AND       plan.cod_plantarif = EV_PLAN_ORIGEN
            AND       paquete.cod_prod_hijo = LN_COD_PROD_OFERTADO;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                GOTO SIGUIENTE;--CONTINUE;
        END;

         LV_sSql := 'SELECT producto.cod_prod_contratado';
        LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
        LV_sSql := LV_sSql || ' WHERE  producto.ind_condicion_contratacion = ''''D''''';
        LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       producto.cod_cliente_contratante = producto.cod_cliente_beneficiario';
        LV_sSql := LV_sSql || ' AND       producto.num_abonado_contratante = producto.num_abonado_beneficiario';
        LV_sSql := LV_sSql || ' AND       producto.cod_prod_ofertado = '||LN_COD_PROD_OFERTADO;
        -- Se obtienen los productos contratados
        OPEN C_PRO_CONTRATADO FOR
        SELECT producto.cod_prod_contratado
        FROM   pr_productos_contratados_to producto
        WHERE  producto.ind_condicion_contratacion = 'D'
        AND       producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
        AND       producto.cod_cliente_contratante = producto.cod_cliente_beneficiario
        AND       producto.num_abonado_contratante = producto.num_abonado_beneficiario
        AND       producto.cod_prod_ofertado = LN_COD_PROD_OFERTADO
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

        IF (LN_NUM_VECES_ORIGEN = LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_ORIGEN
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;

                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

        END IF;

        IF (LN_NUM_VECES_ORIGEN > LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_DESTINO
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;
                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

            LN_NUM_VECES := LN_NUM_VECES_ORIGEN - LN_NUM_VECES_DESTINO;

            FOR LN_COUNT IN 1..LN_NUM_VECES
            LOOP

                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END LOOP;

        END IF;

        IF (LN_NUM_VECES_ORIGEN < LN_NUM_VECES_DESTINO) THEN

            FOR LN_COUNT IN 1..LN_NUM_VECES_ORIGEN
            LOOP
                FETCH C_PRO_CONTRATADO INTO LN_COD_PROD_CONTRATADO;

                EXIT WHEN C_PRO_CONTRATADO%NOTFOUND;

                LV_sSql := 'SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,';
                LV_sSql := LV_sSql ||  EN_NUM_PROCESO||', '||EV_COD_CANAL||', '||SYSDATE;
                LV_sSql := LV_sSql || 'FROM   sv_lista_contratada_to lista';
                LV_sSql := LV_sSql || 'WHERE  lista.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
                --Se obtiene la lista
                OPEN C_LISTA_NUMEROS FOR
                SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
                       EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
                FROM   sv_lista_contratada_to lista
                WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

                LOOP

                    FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

                    EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

                    IF (LN_NUMEROS>1) THEN
                        --Se expande la lista
                        LO_LISTA_NUMEROS.extend;
                    END IF;
                    --Se agrega el registro
                    LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

                    LN_NUMEROS := LN_NUMEROS + 1;

                END LOOP;

                --Se da de baja el producto
                LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                    ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                        EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
                --Se da de alta los productos para el abonado destino con la lista de numeros anterior
                LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                                    ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
                IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;

            END LOOP;

            LN_NUM_VECES := LN_NUM_VECES_DESTINO - LN_NUM_VECES_ORIGEN;

            LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
            IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                            LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL, 'D',SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_OPCIONALES_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_OPCIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y alta los productos contratados opcionalmente por un abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER :=1;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;

LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;


BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(SV_LISTA_CONTRA_TO_QT('','','','','','','','','',''));


    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''''O''';

    --Se obtienen los planes adicionales opcionales
    OPEN C_PRO_DEFECTO FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O'
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

    LOOP
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene la lista de numeros
        OPEN C_LISTA_NUMEROS FOR
        SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
               EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
        FROM   sv_lista_contratada_to lista
        WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

        LOOP

            FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                           LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

            IF (LN_NUMEROS>1) THEN
                --Se expande la lista
                LO_LISTA_NUMEROS.extend;
            END IF;
            --Se agrega el registro
            LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

            LN_NUMEROS := LN_NUMEROS + 1;

        END LOOP;
        --Se da de baja el producto
        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                                EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
        --Se da de alta los productos para el abonado destino con la lista de numeros anterior
        LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''O'''')';
        IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_OPCIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_OPCIONALES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Descontrata todos los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PLANES_DEFECTO_PR (EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PLANES_DEFECTO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Contrata todos los productos por defecto al plan destino</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    IF (EV_FECHA_BAJA IS NULL) THEN
        LD_FECHA_BAJA:= TO_DATE('31-12-3000','DD-MM-YYYY');
    ELSE
        LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        --Se quita la hora de la fecha de termino para los productos de duracion infinita.
        IF (TO_CHAR(LD_FECHA_BAJA,'DD-MM-YYYY') = '31-12-3000') THEN
           LD_FECHA_BAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
        END IF;
    END IF;

    LV_sSql := 'SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo';
    LV_sSql := LV_sSql || ' FROM   ta_plantarif plan, pf_paquete_ofertado_to paquete';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_prod_padre = paquete.cod_prod_padre ';
    LV_sSql := LV_sSql || ' AND    plan.cod_plantarif = '||EV_PLAN_DESTINO;
    --Se obtienen los planes adicionales por defecto
    OPEN C_PRO_DEFECTO FOR
    SELECT paquete.cod_prod_hijo, paquete.num_veces_hijo
    FROM   ta_plantarif plan,
           pf_paquete_ofertado_to paquete
    WHERE  plan.cod_prod_padre = paquete.cod_prod_padre
    AND    plan.cod_plantarif = EV_PLAN_DESTINO;

    LOOP

        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_OFERTADO,LN_NUM_VECES;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        LV_sSql := 'PV_AGREGA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||LD_FECHA_ALTA||', '||LD_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''D'''')';
        IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, LD_FECHA_ALTA, LD_FECHA_BAJA, EN_NUM_MOV_ANT,
                    LN_NUM_VECES, EN_NUM_PROCESO, EV_COD_CANAL,'D', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_DEFECTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PLANES_DEFECTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_CONTRA_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_CONTRA_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos para los cuales el abonado es solo contratante</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, para aquellos de los que es solo contratante

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_contratante = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_contratante = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario != producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_CONTRA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_CONTRA_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_QUITA_PLANES_BENEF_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                ED_FECHA_BAJA        IN DATE,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_QUITA_PLANES_BENEF_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina todos los productos para los cuales el abonado es solo beneficiario</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, para aquellos de los que es solo beneficiario

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante';


    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario != producto.num_abonado_contratante;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_QUITA_PLANES_BENEF_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_MANTIENE_PLANES_BENEF_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                        EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                        EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                        EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        ED_FECHA_BAJA        IN DATE,
                                        EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                        EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                        EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_MANTIENE_PLANES_BENEF_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja y alta los productos para los cuales el abonado es solo beneficiario</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_COUNT         NUMBER;
LN_NUMEROS         NUMBER :=1;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES_ORIGEN         pf_paquete_ofertado_to.num_veces_hijo%TYPE;
LN_NUM_VECES_DESTINO     pf_paquete_ofertado_to.num_veces_hijo%TYPE;

C_PRO_DEFECTO         refcursor;
C_LISTA_NUMEROS         refcursor;

LO_LISTA_NUMEROS SV_LISTA_CONTRA_TO_LST_QT;
LO_NUMERO          SV_LISTA_CONTRA_TO_QT;


BEGIN

    LO_NUMERO := SV_LISTA_CONTRA_TO_QT('','','','','','','','','','');
    LO_LISTA_NUMEROS := SV_LISTA_CONTRA_TO_LST_QT(LO_NUMERO);

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    LD_FEC_ALTA := ED_FECHA_ALTA - (1/(24*60*60));

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND       producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND       producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND       producto.ind_condicion_contratacion = ''O''';

    --Se obtienen los planes adicionales opcionales de los que solo se es beneficiario
    OPEN C_PRO_DEFECTO FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND       producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND       producto.cod_cliente_beneficiario != producto.cod_cliente_contratante
    AND       producto.num_abonado_beneficiario != producto.num_abonado_contratante
    AND       producto.ind_condicion_contratacion = 'O'
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'));

    LOOP
        FETCH C_PRO_DEFECTO INTO LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_DEFECTO%NOTFOUND;

        --Se obtiene la lista de numeros
        OPEN C_LISTA_NUMEROS FOR
        SELECT lista.valor_elemento, lista.fec_inicio_vigencia, lista.fec_termino_vigencia, lista.cod_categoria_destino,
               EN_NUM_PROCESO, EV_COD_CANAL, SYSDATE
        FROM   sv_lista_contratada_to lista
        WHERE  lista.cod_prod_contratado = LN_COD_PROD_CONTRATADO;

        LOOP

            FETCH C_LISTA_NUMEROS INTO LO_NUMERO.valor_elemento, LO_NUMERO.fec_inicio_vigencia, LO_NUMERO.fec_termino_vigencia,
                                           LO_NUMERO.cod_categoria_destino, LO_NUMERO.num_proceso, LO_NUMERO.origen_proceso, LO_NUMERO.fec_proceso;

            EXIT WHEN C_LISTA_NUMEROS%NOTFOUND;

            IF (LN_NUMEROS>1) THEN
                --Se expande la lista
                LO_LISTA_NUMEROS.extend;
            END IF;
            --Se agrega el registro
            LO_LISTA_NUMEROS (LO_LISTA_NUMEROS.count) := LO_NUMERO;

            LN_NUMEROS := LN_NUMEROS + 1;

        END LOOP;
        --Se da de baja el producto
        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, ED_FECHA_BAJA,
                   EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
        --Se da de alta los productos para el abonado destino con la lista de numeros anterior
        LV_sSql := 'PV_AGREGA_CON_LISTA_FN('||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||LN_COD_PROD_OFERTADO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||LN_NUM_VECES_DESTINO||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||', ''''O'''')';
        IF (NOT PV_AGREGA_CON_LISTA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, LN_COD_PROD_OFERTADO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL, LO_LISTA_NUMEROS, 'O', SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_MANTIENE_PLANES_BENEF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_MANTIENE_PLANES_BENEF_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PLANES_ADICIONALES_PR (EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                    EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                    EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                    EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                    EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                    EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                    ED_FECHA_ALTA        IN DATE,
                                    ED_FECHA_BAJA        IN DATE,
                                    EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                    EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                    EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                    SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PLANES_ADICIONALES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Reliza la mantencion de productos para integrar con los cambios de plan</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LV_TIPOPLAN_ORIGEN  ta_plantarif.cod_tiplan%TYPE;
LV_IMPORTE_ORIGEN   ta_cargosbasico.imp_cargobasico%TYPE;
LV_TIPOPLAN_DESTINO ta_plantarif.cod_tiplan%TYPE;
LV_IMPORTE_DESTINO   ta_cargosbasico.imp_cargobasico%TYPE;
LV_FECHAINI VARCHAR2(20);
LV_FECHATER VARCHAR2(20);

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    LV_sSql := LV_sSql || ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    LV_sSql := LV_sSql || ' AND       cargo.cod_producto = 1';
    LV_sSql := LV_sSql || ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_ORIGEN;


    SELECT plan.cod_tiplan, cargo.imp_cargobasico
    INTO   LV_TIPOPLAN_ORIGEN, LV_IMPORTE_ORIGEN
    FROM   TA_PLANTARIF plan, ta_cargosbasico cargo
    WHERE  plan.cod_cargobasico = cargo.cod_cargobasico
    AND       cargo.cod_producto = 1
    AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
    AND       plan.cod_plantarif = EV_PLAN_ORIGEN;

    LV_sSql := 'SELECT plan.cod_tiplan, cargo.imp_cargobasico';
    LV_sSql := LV_sSql || ' FROM   TA_PLANTARIF plan, ta_cargosbasico cargo';
    LV_sSql := LV_sSql || ' WHERE  plan.cod_cargobasico = cargo.cod_cargobasico';
    LV_sSql := LV_sSql || ' AND       cargo.cod_producto = 1';
    LV_sSql := LV_sSql || ' AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta';
    LV_sSql := LV_sSql || ' AND       plan.cod_plantarif = '||EV_PLAN_DESTINO;

    SELECT plan.cod_tiplan, cargo.imp_cargobasico
    INTO   LV_TIPOPLAN_DESTINO, LV_IMPORTE_DESTINO
    FROM   TA_PLANTARIF plan, ta_cargosbasico cargo
    WHERE  plan.cod_cargobasico = cargo.cod_cargobasico
    AND       cargo.cod_producto = 1
    AND       SYSDATE BETWEEN cargo.fec_desde AND cargo.fec_hasta
    AND       plan.cod_plantarif = EV_PLAN_DESTINO;

    IF (LV_TIPOPLAN_ORIGEN = LV_TIPOPLAN_DESTINO) THEN
    --REGLA 1

        LV_sSql := 'PV_QUITA_PLANES_DEFECTO_PR ('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EV_PLAN_DESTINO
                                                ||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_DEFECTO_PR (  EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA,
                                    EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        LV_sSql := 'PV_AGREGA_PLANES_DEFECTO_PR ('||EV_PLAN_ORIGEN||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO
                            ||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_AGREGA_PLANES_DEFECTO_PR (EV_PLAN_ORIGEN, EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, EV_PLAN_DESTINO,
                                    ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;


        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN

            --Se provisiona la baja de servicios de cliente para el abonado
            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA
                                    ||', '||EN_NUM_MOV_ANT||')';
            VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, EN_NUM_MOV_ANT, EN_NUM_PROCESO, SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        --Si existe cambio de cliente, se MANTIENEN los productos contratados por defecto
            LV_sSql := 'PV_MANTIENE_PLANES_DEFECTO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                    ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                    ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_MANTIENE_PLANES_DEFECTO_PR (EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        END IF;

        --Se comparan los importes para determinar la categoria de los planes origen y destino
        IF (LV_IMPORTE_ORIGEN > LV_IMPORTE_DESTINO) THEN

            LV_sSql := 'PV_QUITA_OPCIONALES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                            ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_QUITA_OPCIONALES_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        ELSE
            IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
            --Si existe cambio de cliente, se MANTIENEN los productos contratados opcionales
                LV_sSql := 'PV_MANTIENE_OPCIONALES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                            ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
                PV_MANTIENE_OPCIONALES_PR (EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                        EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
                IF (SN_COD_RETORNO != 0) THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END IF;
        END IF;

    ELSE
    --REGLA 2


        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN

            --Se provisiona la baja de servicios de cliente para el abonado
            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA
                                    ||', '||EN_NUM_MOV_ANT||')';
            VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, EN_NUM_MOV_ANT,  EN_NUM_PROCESO, SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

        LV_sSql := 'PV_QUITA_PLANES_PR ('||EN_CLIENTE_ORIGEN
                                               ||', '||EN_ABONADO_ORIGEN
                                         ||', '||ED_FECHA_ALTA
                                         ||', '||EN_NUM_MOV_ANT
                                         ||', '||EN_NUM_PROCESO
                                           ||', '||EV_COD_CANAL||')';
        --Descontratar TODOS los Planes
        PV_QUITA_PLANES_PR (  EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                 EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        LV_sSql := 'PV_PLANES_DEFECTO_PR ('||
                                        EN_CLIENTE_DESTINO||', '||
                                        EN_ABONADO_DESTINO||', '||
                                        EV_PLAN_DESTINO||', '||
                                        ED_FECHA_ALTA||', '||
                                        ED_FECHA_BAJA||', '||
                                        EN_NUM_MOV_ANT||', '||
                                        EN_NUM_PROCESO||', '||
                                        EV_COD_CANAL||')';
        --Contratar Planes x Defecto Plan Destino
        LV_FECHAINI := TO_CHAR(ED_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
        LV_FECHATER := TO_CHAR(ED_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        PV_PLANES_DEFECTO_PR (EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, EV_PLAN_DESTINO, LV_FECHAINI, LV_FECHATER, EN_NUM_MOV_ANT,
                                EN_NUM_PROCESO, EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END IF;

    IF (LV_TIPOPLAN_ORIGEN != LV_TIPOPLAN_DESTINO) OR (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) OR (LV_IMPORTE_ORIGEN > LV_IMPORTE_DESTINO) THEN
    --REGLA 3
        LV_sSql := 'PV_QUITA_PLANES_CONTRA_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_CONTRA_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    END IF;

    IF (LV_TIPOPLAN_ORIGEN != LV_TIPOPLAN_DESTINO) THEN
    --REGLA 4
        LV_sSql := 'PV_QUITA_PLANES_BENEF_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||', '||EN_NUM_MOV_ANT
                                        ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_QUITA_PLANES_BENEF_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
        --REGLA 5
            LV_sSql := 'PV_MANTIENE_PLANES_BENEF_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                            ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||ED_FECHA_ALTA||', '||ED_FECHA_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_MANTIENE_PLANES_BENEF_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        EN_ABONADO_DESTINO, EV_PLAN_DESTINO, ED_FECHA_ALTA, ED_FECHA_BAJA, EN_NUM_MOV_ANT,
                                        EN_NUM_PROCESO, EV_COD_CANAL,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        END IF;
    END IF;



EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=282;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PLANES_ADICIONALES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PLANES_ADICIONALES_PR ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CADUCA_BENEFICIARIOS_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BENEFICIARIOS_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina la lista de beneficiarios del abonado</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'UPDATE cu_benef_prod_to';
    LV_sSql := LV_sSql || ' SET    fec_termino_vigencia    = '|| ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE  cod_cliente_contratante = '|| EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    num_abonado_contratante = '|| EN_ABONADO_ORIGEN;

    UPDATE cu_benef_prod_to
    SET    fec_termino_vigencia    = ED_FECHA_ALTA
    WHERE  cod_cliente_contratante = EN_CLIENTE_ORIGEN
    AND    num_abonado_contratante = EN_ABONADO_ORIGEN;

EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_CADUCA_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_CADUCA_BENEFICIARIOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                        ED_FECHA_ALTA        IN DATE,
                                        SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                                        ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CADUCA_BENEF_LISTA_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina al abonado de cualquier lista de beneficiarios en la que este</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

LV_des_error       ge_errores_pg.DesEvent;
LV_sSql               ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno     := 0;
    SV_mens_retorno := ' ';
    SN_num_evento     := 0;

    LV_sSql := ' UPDATE CU_BENEF_PROD_TO';
    LV_sSql := LV_sSql || ' SET       FEC_TERMINO_VIGENCIA = '||ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE NUM_ABONADO_BENEFICIARIO = ' || EN_ABONADO_ORIGEN;

    UPDATE CU_BENEF_PROD_TO
    SET       FEC_TERMINO_VIGENCIA = ED_FECHA_ALTA
    WHERE  NUM_ABONADO_BENEFICIARIO = EN_ABONADO_ORIGEN;

EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CADUCA_BENEF_LISTA_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_BENEFICIARIOS_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BENEFICIARIOS_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Realiza la mantencion de las listas de beneficiarios</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

LV_TIPOPLAN_ORIGEN  ta_plantarif.cod_tiplan%TYPE;
LV_TIPOPLAN_DESTINO  ta_plantarif.cod_tiplan%TYPE;

ERROR_SUBFUNCION EXCEPTION;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'SELECT plan.cod_tiplan FROM TA_PLANTARIF plan WHERE  plan.cod_plantarif = '||EV_PLAN_ORIGEN;

    SELECT plan.cod_tiplan INTO LV_TIPOPLAN_ORIGEN FROM TA_PLANTARIF plan WHERE plan.cod_plantarif = EV_PLAN_ORIGEN;

    LV_sSql := 'SELECT plan.cod_tiplan FROM TA_PLANTARIF plan WHERE  plan.cod_plantarif = '||EV_PLAN_DESTINO;

    SELECT plan.cod_tiplan INTO LV_TIPOPLAN_DESTINO FROM TA_PLANTARIF plan WHERE plan.cod_plantarif = EV_PLAN_DESTINO;

    IF (LV_TIPOPLAN_ORIGEN = 2 OR LV_TIPOPLAN_ORIGEN = 3) AND (LV_TIPOPLAN_DESTINO = 1) THEN
        --Se eliminan los beneficiarios del abonado origen
        LV_sSql := 'PV_CADUCA_BENEFICIARIOS_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
        PV_CADUCA_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

        --Se eliminan al abonado origen de todas las listas de beneficiarios
        LV_sSql := 'PV_CADUCA_BENEF_LISTA_PR('||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
        PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;
    ELSE
        IF (LV_TIPOPLAN_ORIGEN = 1) AND (LV_TIPOPLAN_DESTINO = 2 OR LV_TIPOPLAN_DESTINO = 3)   THEN
                --Se eliminan al abonado origen de todas las listas de beneficiarios
            LV_sSql := 'PV_CADUCA_BENEF_LISTA_PR('||EN_ABONADO_ORIGEN||', '||ED_FECHA_ALTA||')';
            PV_CADUCA_BENEF_LISTA_PR(EN_ABONADO_ORIGEN, ED_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;
    END IF;

EXCEPTION
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_AGREGA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_BENEFICIARIOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_BENEFICIARIOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ELIMINA_VETADO_PR( EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                ED_FECHA_ALTA        IN DATE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ELIMINA_VETADO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Elimina al abonado de la lista de vetados del cliente</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LV_sSql := 'UPDATE cu_vetados_prod_to';
    LV_sSql := LV_sSql || ' SET    fec_termino_vigencia    = '|| ED_FECHA_ALTA;
    LV_sSql := LV_sSql || ' WHERE  cod_cliente_contratante = '|| EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    num_abonado_contratante = '|| EN_ABONADO_ORIGEN;

    UPDATE cu_vetados_prod_to
    SET    fec_termino_vigencia = ED_FECHA_ALTA
    WHERE  cod_cliente = EN_CLIENTE_ORIGEN
    AND    num_abonado = EN_ABONADO_ORIGEN;


EXCEPTION
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_ELIMINA_VETADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ELIMINA_VETADO_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_INTEGRACION_PR (   EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_ORIGEN        IN ta_plantarif.cod_plantarif%TYPE,
                                EN_NUM_OS_ANULAR   IN ci_orserv.num_os%TYPE,
                                EN_CLIENTE_DESTINO IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_DESTINO IN ga_abocel.num_abonado%TYPE,
                                EV_PLAN_DESTINO    IN ta_plantarif.cod_plantarif%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_INTEGRACION_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Realiza la integración entre los cambio de plan y los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LD_FEC_BAJA     DATE;

C_abonados      refcursor;
LN_ABONADO     ga_abocel.num_abonado%TYPE;

ERROR_PARAMETROS  EXCEPTION;
ERROR_INTEGRACION EXCEPTION;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;

BEGIN
    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    IF NOT (PV_VALIDA_PARAMETROS_FN(EN_CLIENTE_ORIGEN, EV_PLAN_ORIGEN, EN_CLIENTE_DESTINO,
                                    EV_PLAN_DESTINO, LD_FECHA_ALTA, EN_NUM_PROCESO, EV_COD_CANAL,
                                    SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO) )
    THEN
        RAISE ERROR_PARAMETROS;
    END IF;



    IF (LD_FECHA_BAJA IS NULL) THEN
        LD_FEC_BAJA:= TO_DATE('31-12-3000','DD-MM-YYYY');
    ELSE
        LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');
        --Se quita la hora de la fecha de termino para los productos de duracion infinita.
        IF (TO_CHAR(LD_FECHA_BAJA,'DD-MM-YYYY') = '31-12-3000') THEN
           LD_FEC_BAJA := TO_DATE('31-12-3000','DD-MM-YYYY');
        ELSE
            LD_FEC_BAJA:=LD_FECHA_BAJA;
        END IF;

    END IF;


    IF (EN_NUM_OS_ANULAR != 0) AND (EN_NUM_OS_ANULAR IS NOT NULL) THEN
        SN_Cod_retorno     := 0; -- INVOCAR LA REVERSA
        --PV_REVERSA_PLANES_PR();
    END IF;

    IF (EN_ABONADO_ORIGEN != 0) AND (EN_ABONADO_ORIGEN IS NOT NULL) THEN


        LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                           ||', '||EN_CLIENTE_DESTINO||', '||EN_ABONADO_DESTINO||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    EN_ABONADO_DESTINO, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;


    ELSE

        LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', 0, '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                           ||', '||EN_CLIENTE_DESTINO||', 0, '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                        ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, 0, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                    0, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                    EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;

        OPEN C_abonados FOR
        SELECT abo.num_abonado
        FROM   ga_abocel abo
        WHERE  abo.cod_cliente = EN_CLIENTE_ORIGEN
        AND    abo.cod_situacion NOT IN ('BAA','BAP')
        UNION
        SELECT pre.num_abonado
        FROM   ga_aboamist pre
        WHERE  pre.cod_cliente = EN_CLIENTE_ORIGEN
        AND    pre.cod_situacion NOT IN ('BAA','BAP');

        LOOP

            FETCH C_abonados INTO LN_ABONADO;

            EXIT WHEN C_abonados%NOTFOUND;

            LV_sSql := 'PV_PLANES_ADICIONALES_PR ( '||EN_CLIENTE_ORIGEN||', '||LN_ABONADO||', '||EV_PLAN_ORIGEN||', '||EN_NUM_OS_ANULAR
                               ||', '||EN_CLIENTE_DESTINO||', '||LN_ABONADO||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||', '||LD_FEC_BAJA
                            ||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
            PV_PLANES_ADICIONALES_PR ( EN_CLIENTE_ORIGEN, LN_ABONADO, EV_PLAN_ORIGEN, EN_NUM_OS_ANULAR, EN_CLIENTE_DESTINO,
                                        LN_ABONADO, EV_PLAN_DESTINO, LD_FECHA_ALTA, LD_FEC_BAJA, EN_NUM_MOV_ANT, EN_NUM_PROCESO,
                                        EV_COD_CANAL, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_INTEGRACION;
            END IF;

        END LOOP;

    END IF;

    --Se gestiona la permanencia de lista de beneficiarios
    LV_sSql := 'PV_BENEFICIARIOS_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_PLAN_ORIGEN||', '||EV_PLAN_DESTINO||', '||LD_FECHA_ALTA||')';
    PV_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, EV_PLAN_ORIGEN, EV_PLAN_DESTINO, LD_FECHA_ALTA,
                        SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_INTEGRACION;
    END IF;

    --Se gestiona la permanencia de la lista de vetados
    IF (EN_CLIENTE_ORIGEN != EN_CLIENTE_DESTINO) THEN
        LV_sSql := 'PV_ELIMINA_VETADO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||LD_FECHA_ALTA||')';
        PV_ELIMINA_VETADO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FECHA_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
        IF (SN_COD_RETORNO != 0) THEN
            RAISE ERROR_INTEGRACION;
        END IF;
    END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG(ERROR EN PARAMETROS DE ENTRADA); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_INTEGRACION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG(ERROR EN INTEGRACION); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_INTEGRACION_PR ;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PROVISION_ABONADO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_ABONADO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Para los productos del cliente, que tengan acción en centrales, aprovisiona el comando al abonado informado</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LO_ABONADO                   GA_ABONADO_QT;
LO_LISTA_CENTRALES          IC_PROVISION_QT;
LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

LD_FECHA_ALTA DATE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;
    LD_FECHA_ALTA := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    LO_LISTA_CENTRALES := IC_PROVISION_QT();

    --Se prepara estructura para obtener datos del abonado
    LO_ABONADO:= GA_ABONADO_QT(EN_ABONADO_ORIGEN,'','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
                        '','','','','','','','','','');
    --Se Obtienen los datos del abonado
    PV_DATOS_ABONADO_PG.PV_OBTIENE_DATOS_ABONADO_PR(LO_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;
    --Se obtienen los planes contratados para el cliente, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
    LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = ' || EN_ABONADO_ORIGEN;
    LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
    LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 2, ''3'', 10) = '||LO_ABONADO.COD_USO;

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
    FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
    AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
    AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
    AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
    AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
    AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 2, '3', 10) = LO_ABONADO.COD_USO;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        --Se buscan los datos necesarios para contratar productos

        SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = LN_COD_PROD_OFERTADO;

        IF (LV_ind_tipo_servicio = 'AA') THEN

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;
        ELSE
            LV_tipo_unidad_bonificar := '0';
            LN_can_bonificar := '0';
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

            --Se prepara la estructura para enviar a centrales
            LO_LISTA_CENTRALES.COD_CLIENTE := LO_ABONADO.COD_CLIENTE;
            LO_LISTA_CENTRALES.COD_PROV_SERV := LN_cod_prov_serv;
            LO_LISTA_CENTRALES.TIP_ACCION := '1';
            LO_LISTA_CENTRALES.TIP_SER := LV_ind_tipo_servicio;
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_CELULAR := LO_ABONADO.NUM_CELULAR;
            LO_LISTA_CENTRALES.NUM_ABONADO := LO_ABONADO.NUM_ABONADO;
            LO_LISTA_CENTRALES.TIP_TERMINAL := LO_ABONADO.TIP_TERMINAL;
            LO_LISTA_CENTRALES.COD_CENTRAL := LO_ABONADO.COD_CENTRAL;
            LO_LISTA_CENTRALES.NUM_SERIE := LO_ABONADO.NUM_SERIE;
            LO_LISTA_CENTRALES.COD_TECNOLOGIA := LO_ABONADO.COD_TECNOLOGIA;
            LO_LISTA_CENTRALES.ID_PLAN := LV_cod_servicio_base;
            LO_LISTA_CENTRALES.IMPORTE := '0';
            LO_LISTA_CENTRALES.COD_MONEDA := '0';
            LO_LISTA_CENTRALES.USUARIO := 'SCL';
            LO_LISTA_CENTRALES.COD_CAUSA := '00';
            LO_LISTA_CENTRALES.MONTO_BONIF := LN_can_bonificar;
            LO_LISTA_CENTRALES.TIPO_BONO := LV_tipo_unidad_bonificar;
            LO_LISTA_CENTRALES.COD_PERIODIF := NULL;
            LO_LISTA_CENTRALES.FECHA_EJEC_BONO := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.NUM_MOVANT := EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
            --Se informa el movimiento a centrales
            --P-CSR-11002 JLGN 15-11-2011
            --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_QUITA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PROVISION_ABONADO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




PROCEDURE PV_LLAMADA_ODBC_APROVI_PR(EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                    EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                    EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE,
                                    EN_NUMERO_MOVANT   IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE
                                   ) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LLAMADA_ODBC_APROVI_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones ODBC</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_SECUENCIAL" tipo="NUMERICO">SECUENCIAL</param>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">CODIGO CLIENTE</param>
                <param nom ="EN_NUMERO_VENTA  " tipo="NUMERICO">NUMERO VENTA</param>
          </Entrada>
          <Salida>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

C_PRO_ABOCEL          refcursor;
LN_NUM_ABONADO        GA_aBOCEL.NUM_ABONADO%TYPE;
LN_NUMERO_MOVANT      ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
LD_FEC_ALTA           GA_aBOCEL.FEC_ALTA%TYPE;
SSN_COD_RETORNO       ge_errores_td.cod_msgerror%TYPE;
SSV_MENS_RETORNO      ge_errores_td.det_msgerror%TYPE;
LN_CANTIDAD              integer;
SSN_NUM_EVENTO        integer;

BEGIN

    SSN_Cod_retorno     := 0;
    SSV_Mens_retorno := NULL;
    SSN_Num_evento     := 0;
    LN_CANTIDAD        :=0;

    LV_sSql := 'SELECT count(1)';
    LV_sSql := LV_sSql || ' FROM   GA_ABOCEL';
    LV_sSql := LV_sSql || ' WHERE  NUM_VENTA = '||EN_NUMERO_VENTA;


    SELECT COUNT(1)
    INTO LN_CANTIDAD
    FROM   GA_ABOCEL
    WHERE  COD_CLIENTE = EN_CLIENTE_ORIGEN AND
           NUM_VENTA  <> EN_NUMERO_VENTA;

    if LN_CANTIDAD > 0 then


            LV_sSql := 'SELECT NUM_ABONADO';
            LV_sSql := LV_sSql || ' FROM   GA_ABOCEL';
            LV_sSql := LV_sSql || ' WHERE  NUM_VENTA = '||EN_NUMERO_VENTA;


            OPEN C_PRO_ABOCEL FOR
                SELECT NUM_ABONADO,FEC_ALTA
                FROM   GA_ABOCEL
                WHERE  NUM_VENTA =EN_NUMERO_VENTA;

                IF EN_NUMERO_MOVANT = 0 THEN
                   BEGIN

                   SELECT  NUM_MOVIMIENTO
                   INTO LN_NUMERO_MOVANT
                   FROM ICC_MOVIMIENTO
                   WHERE
                   NUM_ABONADO =  LN_NUM_ABONADO
                   AND COD_ACTABO IN('VO','VT');

                   EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                           LN_NUMERO_MOVANT:=0;
                   END;


                ELSE
                  LN_NUMERO_MOVANT:=EN_NUMERO_MOVANT;

                END IF;

            LOOP

                FETCH C_PRO_ABOCEL
                INTO   LN_NUM_ABONADO,LD_FEC_ALTA;

                EXIT WHEN C_PRO_ABOCEL%NOTFOUND;
                  VE_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR(EN_CLIENTE_ORIGEN,LN_NUM_ABONADO,LD_FEC_ALTA,LN_NUMERO_MOVANT,EN_NUMERO_VENTA,SSN_COD_RETORNO, SSV_MENS_RETORNO, SSN_NUM_EVENTO);
                    IF (SSN_COD_RETORNO != 0) THEN
                        RAISE ERROR_SUBFUNCION;
                    END IF;

            END LOOP;
   END IF;

   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,0,'OK');


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'NO HAY REGISTROS');
      SSN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN ERROR_SUBFUNCION THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'VE_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR');
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'VE_PLANES_ADICIONALES_PG.PV_PROVISION_ABONADO_PR');
      SSN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_LLAMADA_ODBC_APROVI_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

END PV_LLAMADA_ODBC_APROVI_PR;

PROCEDURE PV_FACHADA_UNIX_PR(  EN_NUM_OS  IN PV_IORSERV.NUM_OS%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                               ) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_FACHADA_UNIX_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones UNIX</Descripción>
       <Parámetros>
          <Entrada>
        <param nom ="EN_NUM_OS" tipo="NUMERICO">NUMERO OS</param>
          </Entrada>
          <Salida>
          <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
LV_COD_OS        PV_IORSERV.COD_OS%TYPE;
ln_cod_cliente   GA_ABOCEL.COD_CLIENTE%TYPE;
ln_num_abonado   GA_ABOCEL.NUM_ABONADO%TYPE;
lv_tip_plantarif ga_abocel.tip_plantarif%type;
ln_cantidad      integer;
lv_plan             PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE;
lv_plan_nue         PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE;
lv_num_os         varchar2(10);
ld_fec_vigencia     DATE;
ERROR_SUBFUNCION EXCEPTION;
LN_OSEJECUTADAS     NUMBER := 0;
ln_cantidad_activos NUMBER := 0;

BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;
    lv_num_os       :=EN_NUM_OS;


    LV_sSql := 'SELECT COD_OS FROM PV_IORSERV WHERE NUM_OS = '||EN_NUM_OS;

    SELECT COD_OS
    INTO   LV_COD_OS
    FROM   pv_iorserv
    WHERE  num_os = EN_NUM_OS;


    LV_sSql := 'SELECT num_abonado ,cod_plantarif,cod_plantarif_nue FROM PV_PARAM_ABOCEL WHERE NUM_OS = '||EN_NUM_OS;

    SELECT num_abonado ,cod_plantarif,cod_plantarif_nue
    INTO   ln_num_abonado ,lv_plan,lv_plan_nue
    FROM   pv_param_abocel
    WHERE  num_os = EN_NUM_OS;

    LV_sSql := 'SELECT cod_cliente,tip_plantarif FROM GA_ABOCEL    WHERE  NUM_ABONADO = '||ln_num_abonado;

  ---Incidencia 130512 proyecto P-MIX-09003
    SELECT cod_cliente,tip_plantarif
    INTO   ln_cod_cliente, lv_tip_plantarif
    FROM   ga_abocel
    WHERE  num_abonado = ln_num_abonado
    UNION
    SELECT cod_cliente,tip_plantarif
    FROM   ga_aboamist
    WHERE  num_abonado = ln_num_abonado;


    CASE LV_COD_OS


        WHEN  '10233' THEN -- baja abonado(pos-pre,hib-pre)

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10233''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       a.num_os = b.num_os';
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10233'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;



        WHEN  '10222' THEN -- baja abonado

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10222''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10222'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;


        WHEN  '10020' THEN --plan tarifario(pos-pos,hib-hib)

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||')';

            VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0||', '||
                ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||
                0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        WHEN  '10022' THEN --plan tarifario empresa(pos-pos)

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''10022''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado = 3';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       a.num_os = b.num_os';
            LV_sSql := LV_sSql ||' AND    a.num_os != '||en_num_os;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';


            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '10022'
            AND       a.tip_estado = 3
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND    a.num_os != en_num_os
            AND       trunc(c.fh_ejecucion) = trunc(sysdate);

            IF LN_OSEJECUTADAS = 0 THEN

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||0||', '||lv_plan_nue||', )';

                VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,0,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

                IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                    RAISE error_subfuncion;
                END IF;

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||0||', '||lv_plan||', '||0||', '||ln_cod_cliente
                    ||', '||0||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')||', '||null
                    ||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,0,lv_plan,0,ln_cod_cliente,0,lv_plan_nue,
                    TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

                IF SN_COD_RETORNO>0 THEN
                    RAISE ERROR_SUBFUNCION;
                END IF;
            END IF;

        WHEN  '10530' THEN --plan tarifario (pos-hib)

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', )';

            VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0
                ||', '||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF sn_cod_retorno>0 THEN
                RAISE error_subfuncion;
            END IF;

        WHEN  '10539' THEN --plan tarifario (hib-pos)

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||')';

            VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR(ln_cod_cliente,ln_num_abonado,lv_plan_nue,ld_fec_vigencia,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno>0 OR ld_fec_vigencia IS NULL) THEN
                RAISE error_subfuncion;
            END IF;

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan||', '||0
                ||', '||ln_cod_cliente||', '||ln_num_abonado||', '||lv_plan_nue||', '||TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS')
                ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_INTEGRACION_PR(ln_cod_cliente,ln_num_abonado,lv_plan,0,ln_cod_cliente,ln_num_abonado,lv_plan_nue,
                TO_CHAR(ld_fec_vigencia,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF sn_cod_retorno>0 THEN
                RAISE error_subfuncion;
            END IF;

        WHEN  '50011' THEN -- baja abonado masiva por archivo

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50011''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50011'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

        WHEN  '50013' THEN -- baja abonado por fraude

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50013''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50013'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

    WHEN  '50002' THEN -- baja abonado por fraude masiva

            LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||ln_num_abonado||', '||
                TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||null||', '||0||', '||en_num_os||', ''PV'')';

            VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,ln_num_abonado,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,
                en_num_os,'PV',sn_cod_retorno,sv_mens_retorno,sn_num_evento );

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;

            LN_CANTIDAD:=0;

            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql ||' FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c';
            LV_sSql := LV_sSql ||' WHERE  a.cod_estado = 310';
            LV_sSql := LV_sSql ||' AND       c.cod_os = ''50002''';
            LV_sSql := LV_sSql ||' AND       a.tip_estado != 4';
            LV_sSql := LV_sSql ||' AND       a.num_os = c.num_os';
            LV_sSql := LV_sSql ||' AND       b.cod_cliente = '||ln_cod_cliente;
            LV_sSql := LV_sSql ||' AND       trunc(c.fh_ejecucion) = trunc(sysdate)';

            SELECT count(0)
            INTO   LN_OSEJECUTADAS
            FROM   pv_erecorrido a, pv_camcom b, pv_iorserv c
            WHERE  a.cod_estado = 310
            AND       c.cod_os = '50002'
            AND       a.tip_estado != 4
            AND       a.num_os = c.num_os
            AND       b.cod_cliente = ln_cod_cliente
            AND       a.num_os = b.num_os
            AND       trunc(NVL(c.fh_ejecucion,sysdate)) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
                ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  IN ('BAP','BAA')
            AND       trunc(FEC_BAJA) = trunc(sysdate);

            LV_sSql := 'SELECT COUNT(1) FROM GA_ABOCEL WHERE  COD_CLIENTE  = '||ln_cod_cliente
            ||'AND COD_SITUACION  <> ''BAA'' AND NUM_ABONADO <> '||ln_num_abonado;

            SELECT COUNT(1)
            INTO   LN_CANTIDAD_ACTIVOS
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = ln_cod_cliente
            AND    COD_SITUACION  NOT IN ('BAA','BAP');


            IF (LN_CANTIDAD <= LN_OSEJECUTADAS AND LN_CANTIDAD_ACTIVOS = 0) THEN
                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);


                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||ln_cod_cliente||', '||0||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')
                    ||', '||null||', '||0||', '||en_num_os||', ''PV'')';

                VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR(ln_cod_cliente,0,TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),null,0,en_num_os,'PV',
                    sn_cod_retorno,sv_mens_retorno,sn_num_evento);

            ELSE

                LV_sSql := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||ln_cod_cliente||', '||ln_num_abonado
                    ||', '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS')||', '||0||')';

                VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(ln_cod_cliente, ln_num_abonado, TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
                    0, en_num_os, sn_cod_retorno,sv_mens_retorno,sn_num_evento);
            END IF;

            IF SN_COD_RETORNO>0 THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        ELSE
            SN_Cod_retorno     := 0;
            SV_Mens_retorno := 'OK';
            SN_Num_evento     := 0;

    END CASE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;

      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_FACHADA_UNIX_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_FACHADA_UNIX_PR;

procedure PV_FEC_VIGENCIA_PLAN_PR (      en_cliente         in ge_clientes.cod_cliente%type,
                                en_abonado         in ga_abocel.num_abonado%type,
                                ev_plan_destino       in ta_plantarif.cod_plantarif%type,
                                sd_fecha           out nocopy ga_intarcel.fec_desde%type,
                                sn_cod_retorno     out nocopy ge_errores_td.cod_msgerror%type,
                                sv_mens_retorno    out nocopy ge_errores_td.det_msgerror%type,
                                sn_num_evento      out nocopy ge_errores_pg.evento
                             )         is

/*
 <documentación
   tipodoc = "Procedure">>
    <elemento
       nombre = "PV_FEC_VIGENCIA_PLAN_PR"
           lenguaje="PL/SQL"
       fecha="5-12-2008"
       versión="La del package"
       diseñador="oRLANDO cABEZAS"
       programador="oRLANDO cABEZAS"
       ambiente desarrollo="BD">
       <retorno>n/a</retorno>>
       <descripción>llamada para aplicaciones unix</descripción>
       <parámetros>
          <entrada>
                <param nom ="EN_CLIENTE" tipo="NUMERICO">cliente origen</param>
                <param nom ="EN_ABONADO" tipo="NUMERICO">abonado origen</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">plan tarifario destino</param>
          </entrada>
          <salida>
             <param nom="SD_FECHA" tipo="DATE">fecha vigencia plan</param>
             <param nom="SN_COD_RETORNO" tipo="NUMERICO">codigo de retorno</param>
             <param nom="SV_MENS_RETORNO" tipo="CARACTER">mensaje de retorno</param>
             <param nom="SN_NUM_EVENTO" tipo="NUMERICO">numero de evento</param>
          </salida>
       </parámetros>
    </elemento>
 </documentación>
*/
lv_des_error     ge_errores_pg.desevent;
lv_ssql          ge_errores_pg.vquery;
error_subfuncion exception;


begin

    sn_cod_retorno     := 0;
    sv_mens_retorno := null;
    sn_num_evento     := 0;
    sd_fecha        :=null;

    lv_ssql:='SELECT MAX(FEC_DESDE) INTO  SD_FECHA';
    lv_ssql:=lv_ssql || ' FROM GA_INTARCEL';
    lv_ssql:=lv_ssql || ' WHERE   COD_CLIENTE   = ' || en_cliente || ' AND';
    lv_ssql:=lv_ssql || ' NUM_ABONADO           = ' || en_abonado || ' AND';
    lv_ssql:=lv_ssql || ' COD_PLANTARIF         = ' || ev_plan_destino;

    select max(fec_desde) into  sd_fecha
    from ga_intarcel
    where   cod_cliente   = en_cliente and
             num_abonado   = en_abonado and
            cod_plantarif = ev_plan_destino;


exception
   WHEN no_data_found THEN
      sn_cod_retorno:=1540;

      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, ' VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

   WHEN error_subfuncion THEN
      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, 'VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

   WHEN others THEN
      sn_cod_retorno:=156;
      IF not ge_errores_pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
         sv_mens_retorno := cv_error_no_clasif;
      END IF;

      lv_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || sqlerrm;
      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, 'PV', sv_mens_retorno, cv_version, user, ' VE_PLANES_ADICIONALES_PG.PV_FEC_VIGENCIA_PLAN_PR', lv_ssql, sn_cod_retorno, lv_des_error );

END PV_FEC_VIGENCIA_PLAN_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_BAJA_PLANES_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EV_FECHA_BAJA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO        IN pr_productos_contratados_to.num_proceso%TYPE,
                                EV_COD_CANAL        IN pr_productos_contratados_to.cod_canal%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_BAJA_PLANES_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Descontrata todos los productos contratados</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LD_FEC_ALTA     DATE;

LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_IND_CONTRATACION        pr_productos_contratados_to.ind_condicion_contratacion%TYPE;
C_PRO_CONTRATADOS         refcursor;

LD_FECHA_ALTA        DATE;
LD_FECHA_BAJA        DATE;


BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    LD_FECHA_ALTA     := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');
    LD_FECHA_BAJA     := TO_DATE(EV_FECHA_BAJA,'DD-MM-YYYY HH24:MI:SS');

    LD_FEC_ALTA := LD_FECHA_ALTA - (1/(24*60*60));
    --Se obtienen los planes contratados por el abonado, excepto aquellos de los que es solo contratante
    --o solo beneficiario pues se analizan en forma posterior

    LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to producto';
    LV_sSql := LV_sSql || ' WHERE  producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
    LV_sSql := LV_sSql || ' AND    producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;

    OPEN C_PRO_CONTRATADOS FOR
    SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado, producto.ind_condicion_contratacion
    FROM   pr_productos_contratados_to producto
    WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
    AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LV_IND_CONTRATACION;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        LV_sSql := 'PV_QUITA_FN('||LN_COD_PROD_CONTRATADO||', '||LN_COD_PROD_OFERTADO||', '||LD_FEC_ALTA||', '||EN_NUM_MOV_ANT
                                ||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||')';
        IF (NOT PV_QUITA_FN( EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO, LD_FEC_ALTA, LD_FECHA_BAJA,
           EN_NUM_MOV_ANT, EN_NUM_PROCESO, EV_COD_CANAL, LV_IND_CONTRATACION, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
            RAISE ERROR_SUBFUNCION;
        END IF;

    END LOOP;

    --Se eliminan los beneficiarios del abonado origen
    PV_CADUCA_BENEFICIARIOS_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FEC_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;

    --Se gestiona la permanencia de la lista de vetados
    LV_sSql := 'PV_ELIMINA_VETADO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||LD_FEC_ALTA||')';
    PV_ELIMINA_VETADO_PR(EN_CLIENTE_ORIGEN, EN_ABONADO_ORIGEN, LD_FEC_ALTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
    IF (SN_COD_RETORNO != 0) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||
                            EV_FECHA_BAJA||', '||EN_NUM_MOV_ANT||', '||EN_NUM_PROCESO||', '||EV_COD_CANAL||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_BAJA_PLANES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_BAJA_PLANES_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_PROVISION_BAJA_ABO_PR (  EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                EN_ABONADO_ORIGEN  IN ga_abocel.num_abonado%TYPE,
                                EV_FECHA_ALTA        IN VARCHAR2,
                                EN_NUM_MOV_ANT        IN icc_movimiento.num_movant%TYPE,
                                EN_NUM_PROCESO       IN pr_productos_contratados_to.num_proceso%TYPE,
                                SN_COD_RETORNO     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_MENS_RETORNO    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO      OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_BAJA_ABO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Para los productos del cliente, que tengan acción en centrales, aprovisiona el comando al abonado informado</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">Cliente origen</param>
                <param nom ="EN_ABONADO_ORIGEN" tipo="NUMERICO">Abonado origen</param>
                <param nom ="EV_PLAN_ORIGEN" tipo="CARACTER">Plan tarifario origen</param>
                <param nom ="EN_NUM_OS_ANULAR" tipo="NUMERICO">Número de orden de servicio anulada</param>
                <param nom ="EN_CLIENTE_DESTINO" tipo="NUMERICO">Cliente destino</param>
                <param nom ="EN_ABONADO_DESTINO" tipo="NUMERICO">Abonado destino</param>
                <param nom ="EV_PLAN_DESTINO" tipo="CARACTER">Plan tarifario destino</param>
                <param nom ="ED_FECHA_ALTA" tipo="FECHA">Fecha activación planes adicionales</param>
                <param nom ="ED_FECHA_BAJA" tipo="FECHA">Fecha desactivación planes adicionales</param>
                <param nom ="EN_NUM_MOV_ANT" tipo="NUMERICO">NÝ de movimiento de central</param>
                <param nom ="EN_NUM_PROCESO" tipo="NUMERICO">NÝ Proceso</param>
                <param nom ="EV_COD_CANAL" tipo="CARACTER">Canal</param>
          </Entrada>
          <Salida>
             <param nom="SN_COD_RETORNO" Tipo="NUMERICO">Codigo de Retorno</param>
             <param nom="SV_MENS_RETORNO" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SN_NUM_EVENTO" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

LO_ABONADO                   GA_ABONADO_QT;
LO_LISTA_CENTRALES          IC_PROVISION_QT;
LN_COD_PROD_CONTRATADO   pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_COD_PROD_OFERTADO        pr_productos_contratados_to.cod_prod_ofertado%TYPE;
C_PRO_CONTRATADOS         refcursor;

LN_COD_USO                 ga_abocel.cod_uso%TYPE;
LN_COD_USO_ORI             ga_abocel.cod_uso%TYPE;
LN_CLIENTE_DES             ga_abocel.cod_cliente%TYPE;
LV_PLANTARIF_DES         ga_abocel.cod_plantarif%TYPE;

LN_cod_espec_prod        se_detalles_especificacion_to.cod_espec_prod%TYPE;
LN_cod_perfil_lista      se_detalles_especificacion_to.cod_perfil_lista%TYPE;
LN_cod_prov_serv          se_detalles_especificacion_to.cod_prov_serv%TYPE;
LV_cod_servicio_base     se_detalles_especificacion_to.cod_servicio_base%TYPE;
LV_ind_tipo_servicio     se_detalles_especificacion_to.ind_tipo_servicio%TYPE;
LV_tipo_comportamiento   ps_especificaciones_prod_td.tipo_comportamiento%TYPE;
LV_tipo_plataforma          ps_especificaciones_prod_td.tipo_plataforma%TYPE;
LV_tipo_unidad_bonificar se_planes_altamira_td.tipo_unidad_bonificar%TYPE;
LN_can_bonificar         se_planes_altamira_td.can_bonificar%TYPE;

LD_FECHA_ALTA DATE;
LV_USUARIO             ga_abocel.nom_usuarora%TYPE;
BEGIN

    SN_Cod_retorno     := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento     := 0;

    --Se obtiene el usuario de la OOSS
    BEGIN
        SELECT usuario
        INTO   LV_USUARIO
        FROM   pv_iorserv
        WHERE  num_os = EN_NUM_PROCESO
        UNION
        SELECT usuario
        FROM   ci_orserv
        WHERE  num_os = EN_NUM_PROCESO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            LV_USUARIO := USER;
    END;

    LD_FECHA_ALTA := TO_DATE(EV_FECHA_ALTA,'DD-MM-YYYY HH24:MI:SS');

    LO_LISTA_CENTRALES := IC_PROVISION_QT();


    LV_sSql := ' SELECT a.num_celular, a.tip_terminal,';
    LV_sSql := LV_sSql || '        a.cod_central, a.num_serie, a.cod_tecnologia';
    LV_sSql := LV_sSql || ' FROM   ga_abocel a';
    LV_sSql := LV_sSql || ' WHERE  a.num_abonado = '||EN_ABONADO_ORIGEN;
    /* Se obtienen los datos del abonado */
    SELECT a.num_celular, a.tip_terminal,
           a.cod_central, a.num_serie, a.cod_tecnologia, a.cod_uso, a.cod_cliente, a.cod_plantarif
    INTO   LO_LISTA_CENTRALES.NUM_CELULAR,
           LO_LISTA_CENTRALES.TIP_TERMINAL,
           LO_LISTA_CENTRALES.COD_CENTRAL,
           LO_LISTA_CENTRALES.NUM_SERIE,
           LO_LISTA_CENTRALES.COD_TECNOLOGIA,
           LN_COD_USO,
           LN_CLIENTE_DES,
           LV_PLANTARIF_DES
    FROM   ga_abocel a
    WHERE  a.num_abonado = EN_ABONADO_ORIGEN;

    /* Se verifica si existió cambio de producto de pos a hib o de hib a pos */
    IF (EN_CLIENTE_ORIGEN != LN_CLIENTE_DES) THEN
        LV_sSql := 'SELECT cod_uso';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND    fec_hasta   = (  SELECT MAX(fec_hasta)';
        LV_sSql := LV_sSql || '    FROM   ga_intarcel';
        LV_sSql := LV_sSql || '    WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || '    AND       cod_cliente = '||EN_CLIENTE_ORIGEN||')';

        -- Se obtiene el ultimo registro par el abonado origen
        BEGIN
            SELECT cod_uso
            INTO   LN_COD_USO_ORI
            FROM   ga_intarcel
            WHERE  num_abonado = EN_ABONADO_ORIGEN
            AND       cod_cliente = EN_CLIENTE_ORIGEN
            AND    fec_hasta = (SELECT MAX(fec_hasta)
                                FROM   ga_intarcel
                                WHERE  num_abonado = EN_ABONADO_ORIGEN
                                AND       cod_cliente = EN_CLIENTE_ORIGEN);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_COD_USO_ORI := LN_COD_USO;
        END;
    ELSE
        LV_sSql := 'SELECT cod_uso';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       fec_desde = (SELECT MAX(fec_desde)';
        LV_sSql := LV_sSql || ' FROM   ga_intarcel';
        LV_sSql := LV_sSql || ' WHERE  num_abonado = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_cliente = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND       cod_plantarif != '||LV_PLANTARIF_DES||')';
        -- Se obtiene el penultimo registro para verificar cambio de producto
        BEGIN
            SELECT cod_uso
            INTO   LN_COD_USO_ORI
            FROM   ga_intarcel
            WHERE  num_abonado = EN_ABONADO_ORIGEN
            AND       cod_cliente = EN_CLIENTE_ORIGEN
            AND       fec_desde = (SELECT MAX(fec_desde)
                                FROM   ga_intarcel
                                WHERE  num_abonado = EN_ABONADO_ORIGEN
                                AND       cod_cliente = EN_CLIENTE_ORIGEN
                                AND       cod_plantarif != LV_PLANTARIF_DES);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_COD_USO_ORI := LN_COD_USO; --2
        END;
    END IF;


    IF (LN_COD_USO_ORI = LN_COD_USO) THEN

        LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
        LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario =  '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
        LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
        LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 2, ''3'', 10) = '||LN_COD_USO;

        OPEN C_PRO_CONTRATADOS FOR
        SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
        WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
        AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
        AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
        AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
        AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 2, '3', 10) = LN_COD_USO;

    ELSE
        LV_sSql := 'SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' FROM pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado';
        LV_sSql := LV_sSql || ' WHERE producto.cod_cliente_beneficiario = '||EN_CLIENTE_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = '||EN_ABONADO_ORIGEN;
        LV_sSql := LV_sSql || ' AND producto.cod_cliente_beneficiario = producto.cod_cliente_contratante';
        LV_sSql := LV_sSql || ' AND producto.num_abonado_beneficiario = producto.num_abonado_contratante';
        LV_sSql := LV_sSql || ' AND sysdate BETWEEN producto.fec_inicio_vigencia AND producto.fec_termino_vigencia';
        LV_sSql := LV_sSql || ' AND producto.cod_prod_ofertado = ofertado.cod_prod_ofertado';
        LV_sSql := LV_sSql || ' AND DECODE (ofertado.tipo_plataforma, ''1'', 3, ''2'', 10, ''3'', 2) = '||LN_COD_USO;

        OPEN C_PRO_CONTRATADOS FOR
        SELECT producto.cod_prod_contratado, producto.cod_prod_ofertado
        FROM   pr_productos_contratados_to producto, pf_productos_ofertados_td ofertado
        WHERE  producto.cod_cliente_beneficiario = EN_CLIENTE_ORIGEN
        AND    producto.num_abonado_beneficiario = EN_ABONADO_ORIGEN
        AND    producto.cod_cliente_beneficiario = producto.cod_cliente_contratante
        AND    producto.num_abonado_beneficiario = producto.num_abonado_contratante
        AND       sysdate BETWEEN producto.fec_inicio_vigencia AND NVL(producto.fec_termino_vigencia,TO_DATE('31-12-3000','DD-MM-YYYY'))
        AND       producto.cod_prod_ofertado = ofertado.cod_prod_ofertado
        AND       DECODE (ofertado.tipo_plataforma, '1', 3, '2', 10, '3', 2) = LN_COD_USO; --se invierten los usos para que aprovisione
                                                                                                          --las bajas de los planes que tenia antes.
    END IF;

    LOOP

        FETCH C_PRO_CONTRATADOS
        INTO   LN_COD_PROD_CONTRATADO, LN_COD_PROD_OFERTADO;

        EXIT WHEN C_PRO_CONTRATADOS%NOTFOUND;

        --Se buscan los datos necesarios para contratar productos

        SELECT servicio.cod_espec_prod, servicio.cod_perfil_lista, servicio.cod_prov_serv, servicio.cod_servicio_base,
               servicio.ind_tipo_servicio, espec.tipo_comportamiento, espec.tipo_plataforma
        INTO   LN_cod_espec_prod, LN_cod_perfil_lista, LN_cod_prov_serv, LV_cod_servicio_base,
               LV_ind_tipo_servicio, LV_tipo_comportamiento, LV_tipo_plataforma
        FROM   pf_productos_ofertados_td ofertado, ps_especificaciones_prod_td espec, se_detalles_especificacion_to servicio
        WHERE  ofertado.cod_espec_prod = espec.cod_espec_prod
        AND       ofertado.cod_espec_prod = servicio.cod_espec_prod
        AND       ofertado.cod_prod_ofertado = LN_COD_PROD_OFERTADO;

        IF (LV_ind_tipo_servicio = 'AA') THEN

            SELECT altamira.tipo_unidad_bonificar, altamira.can_bonificar
            INTO   LV_tipo_unidad_bonificar, LN_can_bonificar
            FROM   se_planes_altamira_td altamira
            WHERE  altamira.cod_plan_altamira = LV_cod_servicio_base;
        ELSE
            LV_tipo_unidad_bonificar := '0';
            LN_can_bonificar := '0';
        END IF;

        IF (LN_cod_prov_serv IS NOT NULL) THEN

            --Se crea arreglo para invocar a centrales
            LO_LISTA_CENTRALES.TIP_ACCION :=   '2';
            LO_LISTA_CENTRALES.COD_PROD_CONTRAT := LN_COD_PROD_CONTRATADO;
            LO_LISTA_CENTRALES.FECHA_EJECUCION := LD_FECHA_ALTA;
            LO_LISTA_CENTRALES.USUARIO :=  'SCL';
            LO_LISTA_CENTRALES.NUM_MOVANT :=  EN_NUM_MOV_ANT;
            LO_LISTA_CENTRALES.COD_CLIENTE := EN_CLIENTE_ORIGEN;
            LO_LISTA_CENTRALES.NUM_ABONADO := EN_ABONADO_ORIGEN;
            LO_LISTA_CENTRALES.NOM_USUARORA := LV_USUARIO;
            --Se informa el movimiento a centrales
            --P-CSR-11002 JLGN 15-11-2011
            --IC_PROVISION_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IC_PROVISION_VENTA_PG.IC_INSERTA_PR(LO_LISTA_CENTRALES,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);
            IF (SN_COD_RETORNO != 0) THEN
                RAISE ERROR_SUBFUNCION;
            END IF;
        END IF;

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_Cod_retorno:=1540;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_SUBFUNCION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR('||EN_CLIENTE_ORIGEN||', '||EN_ABONADO_ORIGEN||', '||EV_FECHA_ALTA||', '||EN_NUM_MOV_ANT||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_PROVISION_BAJA_ABO_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION IC_MANTIENE_PLAN_FN(EN_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE)
RETURN VARCHAR2 IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "IC_MANTIENE_PLAN_FN"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>CARACTER</Retorno>>
       <Descripción>Verifica si un movimiento corresponde a la mantencion de planes adicionales</Descripción>>
       <Parámetros>
          <Entrada>
                <param nom ="EN_MOVIMIENTO" tipo="NUMERICO">Numero de Movimiento</param>
          </Entrada>
          <Salida>
              N/A
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

LN_ABONADO    icc_movimiento.num_abonado%TYPE;
LV_ACTABO      icc_movimiento.cod_actabo%TYPE;
LN_CLIENTE      ga_traspabo.cod_clienant%TYPE;
LN_PRODCONTRATADO pr_productos_contratados_to.cod_prod_contratado%TYPE;
LN_PRODOFERTADO   pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_COUNT NUMBER;

SN_COD_RETORNO  ge_errores_pg.coderror;
SV_MENS_RETORNO ge_errores_pg.msgerror;
SN_NUM_EVENTO   ge_errores_pg.evento;
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

ERROR_PROCESO    EXCEPTION;

BEGIN
    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := '';
    SN_NUM_EVENTO   := 0;

    LV_sSql := 'SELECT NUM_ABONADO FROM icc_movimiento WHERE num_movimiento = '||EN_MOVIMIENTO;
    BEGIN
        SELECT NUM_ABONADO, COD_ACTABO, COD_PROD_CONTRATADO
        INTO   LN_ABONADO, LV_ACTABO, LN_PRODCONTRATADO
        FROM   icc_movimiento
        WHERE  num_movimiento = EN_MOVIMIENTO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'FALSE';
    END;

    IF (LV_ACTABO = 'U1') THEN

        BEGIN
            LV_sSql := 'SELECT cod_cliente_beneficiario, cod_prod_ofertado FROM pr_productos_contratados_to WHERE  cod_prod_contratado = '||LN_PRODCONTRATADO;

            SELECT cod_cliente_beneficiario, cod_prod_ofertado
            INTO   LN_CLIENTE, LN_PRODOFERTADO
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_contratado = LN_PRODCONTRATADO;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN '1';
        END;

        IF (LN_CLIENTE = 0) THEN
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_th';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U2'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario = LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U2');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_th';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U2'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario != LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U2');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;

        END IF;

    END IF;

    IF (LV_ACTABO = 'U2') THEN

        BEGIN
            LV_sSql := 'SELECT cod_cliente_beneficiario, cod_prod_ofertado FROM pr_productos_contratados_to WHERE  cod_prod_contratado = '||LN_PRODCONTRATADO;

            SELECT cod_cliente_beneficiario, cod_prod_ofertado
            INTO   LN_CLIENTE, LN_PRODOFERTADO
            FROM   pr_productos_contratados_th
            WHERE  cod_prod_contratado = LN_PRODCONTRATADO;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN '1';
        END;

        IF (LN_CLIENTE = 0) THEN
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U1'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario = LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U1');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;
        ELSE
            LV_sSql := 'SELECT count(0)';
            LV_sSql := LV_sSql || ' FROM   pr_productos_contratados_to';
            LV_sSql := LV_sSql || ' WHERE  cod_prod_ofertado = '||LN_PRODOFERTADO;
            LV_sSql := LV_sSql || ' AND       cod_cliente_beneficiario = '||LN_CLIENTE;
            LV_sSql := LV_sSql || ' AND       num_abonado_beneficiario = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND       cod_prod_contratado IN (SELECT cod_prod_contratado';
            LV_sSql := LV_sSql || ' FROM icc_movimiento';
            LV_sSql := LV_sSql || ' WHERE num_abonado = '||LN_ABONADO;
            LV_sSql := LV_sSql || ' AND cod_actabo = ''U1'')';

            SELECT count(0)
            INTO   LN_COUNT
            FROM   pr_productos_contratados_to
            WHERE  cod_prod_ofertado = LN_PRODOFERTADO
            AND       cod_cliente_beneficiario != LN_CLIENTE
            AND       num_abonado_beneficiario = LN_ABONADO
            AND       cod_prod_contratado IN (SELECT cod_prod_contratado
                                                 FROM icc_movimiento
                                           WHERE num_abonado = LN_ABONADO
                                           AND cod_actabo = 'U1');

            IF LN_COUNT > 0 THEN
                RAISE ERROR_PROCESO;
            END IF;

        END IF;

    END IF;

    RETURN '1';

EXCEPTION
    WHEN ERROR_PROCESO THEN
        SN_cod_retorno := 295;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
    WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 295;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := cv_error_no_clasif;
        END IF;
        LV_des_error   := 'IC_MANTIENE_PLAN_FN('||EN_MOVIMIENTO||'); - ' || SQLERRM;
        SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, CV_version, USER, 'IC_MANTIENE_PLAN_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
        RETURN 'FALSE';
END IC_MANTIENE_PLAN_FN;
-------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_PROVISION_ODBC_BAJA_ABO_PR( EN_SECUENCIAL      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                        EN_CLIENTE_ORIGEN  IN ge_clientes.cod_cliente%TYPE,
                                        EN_NUMERO_VENTA    IN ga_abocel.NUM_VENTA%TYPE
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_PROVISION_ODBC_BAJA_ABO_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="oRLANDO cABEZAS"
       Programador="oRLANDO cABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Llamada para aplicaciones ODBC</Descripción>
       <Parámetros>
          <Entrada>
                <param nom ="EN_SECUENCIAL" tipo="NUMERICO">SECUENCIAL</param>
                <param nom ="EN_CLIENTE_ORIGEN" tipo="NUMERICO">CODIGO CLIENTE</param>
                <param nom ="EN_NUMERO_VENTA  " tipo="NUMERICO">NUMERO VENTA</param>
          </Entrada>
          <Salida>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;

C_PRO_ABOCEL          refcursor;
LN_NUM_ABONADO        GA_aBOCEL.NUM_ABONADO%TYPE;
LD_FEC_ALTA           GA_aBOCEL.FEC_ALTA%TYPE;
SSN_COD_RETORNO       ge_errores_td.cod_msgerror%TYPE;
SSV_MENS_RETORNO      ge_errores_td.det_msgerror%TYPE;
SSN_NUM_EVENTO        integer;

BEGIN

    SSN_Cod_retorno     := 0;
    SSV_Mens_retorno := NULL;
    SSN_Num_evento     := 0;

    OPEN C_PRO_ABOCEL FOR
    SELECT NUM_ABONADO,FEC_ALTA
    FROM   GA_ABOCEL
    WHERE  NUM_VENTA =EN_NUMERO_VENTA;


    LOOP

    FETCH C_PRO_ABOCEL
    INTO   LN_NUM_ABONADO,LD_FEC_ALTA;

    EXIT WHEN C_PRO_ABOCEL%NOTFOUND;

           VE_PLANES_ADICIONALES_PG.PV_PROVISION_BAJA_ABO_PR(EN_CLIENTE_ORIGEN,LN_NUM_ABONADO,LD_FEC_ALTA,0,EN_NUMERO_VENTA,SSN_COD_RETORNO, SSV_MENS_RETORNO, SSN_NUM_EVENTO);

    IF (SSN_COD_RETORNO != 0) THEN
            RAISE ERROR_SUBFUNCION;
    END IF;

   END LOOP;

   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,0,'OK');


EXCEPTION
     WHEN ERROR_SUBFUNCION THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'VE_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR');
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, 'VE_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)VALUES (EN_SECUENCIAL ,4,'VE_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR');
      SSN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SSN_Cod_retorno,SSV_mens_retorno) THEN
         SSV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG('||'); - ' || SQLERRM;
      SSN_num_evento  := Ge_Errores_Pg.Grabarpl( SSN_num_evento, 'PV', SSV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.PV_PROVISION_ODBC_BAJA_ABO_PR', LV_sSQL, SSN_cod_retorno, LV_des_error );

END PV_PROVISION_ODBC_BAJA_ABO_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_PA_VENTA_NORMAL_PR( EN_CLIENTE_DESTINO   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                 EN_ABONADO_DESTINO   IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                 EN_COD_PROD_OFERTADO IN  PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE,
                                 EN_NUM_VECES         IN  PF_PAQUETE_OFERTADO_TO.NUM_VECES_HIJO%TYPE,
                                 EN_NUM_PROCESO       IN  PR_PRODUCTOS_CONTRATADOS_TO.NUM_PROCESO%TYPE,
                                 EN_NUM_MOV_ANT       IN  ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                 SN_COD_RETORNO       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_MENS_RETORNO      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_NUM_EVENTO        OUT NOCOPY ge_errores_pg.evento
                            ) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "VE_PA_VENTA_NORMAL_PR"
           Lenguaje="PL/SQL"
       Fecha="5-12-2008"
       Versión="La del package"
       Diseñador="JLGN"
       Programador="JLGN"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Inserta PA venta normal</Descripción>
       <Parámetros>
          <Entrada>

          </Entrada>
          <Salida>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error     ge_errores_pg.DesEvent;
LV_sSql          ge_errores_pg.vQuery;
ERROR_SUBFUNCION EXCEPTION;
LN_NUM_MOV_ANT   icc_movimiento.NUM_MOVANT%type;
SV_TIPO          VARCHAR2(1);
LV_COD_PLANTARIF  ga_abocel.cod_plantarif%type; -- gdo 22-02-2013 INC 192647
--INICIO INC 194427
LN_CONT          NUMBER;
LN_COD_PROD_OFERTADO     pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LN_NUM_VECES             pf_paquete_ofertado_to.num_veces_hijo%TYPE;
C_PRO_DEFECTO_CLIENTE   REFCURSOR;
--FIN INC 194427 

BEGIN 
    
    --INICIO gdo 22-02-2013 INC 192647
    LV_sSql := 'SELECT COD_PLANTARIF FROM GA_ABOCEL WHERE NUM_ABONADO = '||EN_ABONADO_DESTINO;
    LV_sSql := LV_sSql || ' UNION';
    LV_sSql := 'SELECT COD_PLANTARIF FROM GA_ABOCEL WHERE NUM_ABONADO = '||EN_ABONADO_DESTINO;
    

    SELECT COD_PLANTARIF 
    INTO LV_COD_PLANTARIF 
    FROM GA_ABOCEL 
    WHERE NUM_ABONADO = EN_ABONADO_DESTINO
    UNION
    SELECT COD_PLANTARIF 
    FROM GA_ABOAMIST 
    WHERE NUM_ABONADO = EN_ABONADO_DESTINO; 
    
    LV_sSql := 'Select distinct DECODE(TIPO_RELACION_PA,3,''O'',2,''D'')';
    LV_sSql := LV_sSql || ' from PS_PLANTARIF_PLANADIC_TD A, PF_PRODUCTOS_OFERTADOS_TD B';
    LV_sSql := LV_sSql || ' WHERE  A.COD_PROD_OFERTADO = B.COD_PROD_OFERTADO';
    LV_sSql := LV_sSql || ' AND A.COD_PROD_OFERTADO = '||EN_COD_PROD_OFERTADO;
    LV_sSql := LV_sSql || ' AND A.COD_PLANTARIF = '||LV_COD_PLANTARIF;
    -- FIN gdo 22-02-2013 INC 192647   

    Select distinct DECODE(TIPO_RELACION_PA,3,'O',2,'D')
    INTO SV_TIPO
    from PS_PLANTARIF_PLANADIC_TD A, PF_PRODUCTOS_OFERTADOS_TD B
    WHERE  A.COD_PROD_OFERTADO = B.COD_PROD_OFERTADO
    AND A.COD_PROD_OFERTADO = EN_COD_PROD_OFERTADO
    AND A.COD_PLANTARIF = LV_COD_PLANTARIF;--  gdo 22-02-2013 INC 192647  
    
    --INICIO INC 194427 AFD
    SELECT COUNT(1)
    INTO LN_CONT 
    FROM PR_PRODUCTOS_CONTRATADOS_TO
    WHERE COD_CLIENTE_BENEFICIARIO = EN_CLIENTE_DESTINO
    AND NUM_ABONADO_BENEFICIARIO = 0;
    
    
    
    IF (LN_CONT = 0) THEN
    
        OPEN C_PRO_DEFECTO_CLIENTE FOR
            SELECT planAdicional.COD_PROD_OFERTADO,1 num_veces_hijo
            FROM ta_plantarif planTarifario, ps_plantarif_planadic_td planAdicional, pf_productos_ofertados_td ofertado
            WHERE planTarifario.COD_PLANTARIF = planAdicional.COD_PLANTARIF
            AND planAdicional.COD_PROD_OFERTADO = ofertado.COD_PROD_OFERTADO
            AND ofertado.ind_nivel_aplica = 'C'
            AND planAdicional.COD_PLANTARIF = LV_COD_PLANTARIF
            AND planAdicional.TIPO_RELACION_PA = 2;           


        LOOP

            FETCH C_PRO_DEFECTO_CLIENTE INTO LN_COD_PROD_OFERTADO, LN_NUM_VECES;

            EXIT WHEN C_PRO_DEFECTO_CLIENTE%NOTFOUND;

               IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, 0, LN_COD_PROD_OFERTADO, sysdate, to_date('31-12-3000','DD-MM-YYYY'), /*ED_FECHA_ALTA, ED_FECHA_BAJA,*/ EN_NUM_MOV_ANT,
                            --INICIO INC 194913 AFD
                            --LN_NUM_VECES, EN_NUM_PROCESO, 'VT', SV_TIPO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                            LN_NUM_VECES, EN_NUM_PROCESO, 'VT', 'B' ,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
                            --FIN INC 194913 AFD        
                    RAISE ERROR_SUBFUNCION;
                END IF;

        END LOOP;
    
    END IF;   
--FIN INC 194427 AFD

    IF (NOT PV_AGREGA_FN( EN_CLIENTE_DESTINO, EN_ABONADO_DESTINO, EN_COD_PROD_OFERTADO, sysdate, to_date('31-12-3000','DD-MM-YYYY'), /*ED_FECHA_ALTA, ED_FECHA_BAJA,*/ EN_NUM_MOV_ANT,
                    EN_NUM_VECES, EN_NUM_PROCESO, 'VT', SV_TIPO ,SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)) THEN
        RAISE ERROR_SUBFUNCION;
    END IF;


EXCEPTION
     WHEN ERROR_SUBFUNCION THEN
      SN_Cod_retorno:=156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.VE_PA_VENTA_NORMAL_PR(''); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'VT', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.VE_PA_VENTA_NORMAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
      SN_Cod_retorno:=156;
      SV_mens_retorno := cv_error_no_clasif||' ORA' || SQLCODE;
      LV_des_error   := 'VE_PLANES_ADICIONALES_PG.VE_PA_VENTA_NORMAL_PR(''); - ' || SQLERRM;
      SN_NUM_EVENTO  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'VT', SV_mens_retorno, CV_version, USER, ' VE_PLANES_ADICIONALES_PG.VE_PA_VENTA_NORMAL_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END VE_PA_VENTA_NORMAL_PR;

END VE_PLANES_ADICIONALES_PG;
/
SHOW ERRORS
