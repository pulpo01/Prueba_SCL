CREATE OR REPLACE PACKAGE BODY PV_SERVICIOS_POSVENTA_PG IS

    PROCEDURE VE_obtiene_abonados_venta_PR(EN_numventa        IN NUMBER,
                                           SC_cursordatos      OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_obtiene_abonados_venta_PR"
        Lenguaje="PL/SQL"
        Fecha="26-03-2007"
        Version="1.0.0"
        Dise?ador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Recupera abonados para el numero de venta ingresado
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql := 'SELECT a.num_abonado'
                   ||',a.cod_plantarif'
                   ||',a.cod_cargobasico'
                   ||',a.cod_planserv'
                   ||',a.num_serie'
                   ||',a.num_imei'
                   ||',a.cod_cliente'
                   ||',a.cod_vendedor'
                   ||',a.cod_tipcontrato'
                   ||',a.cod_causa_venta'
                   ||',a.cod_modventa'
                   ||',a.tip_plantarif'
                   ||',a.num_contrato'
                   ||',a.cod_uso'
                   ||',a.cod_cuenta'
                   ||',a.cod_tecnologia'
                   ||' FROM  ga_abocel a'
                   ||'  WHERE a.num_venta ='||EN_numventa;

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ga_abocel a
        WHERE a.num_venta = EN_numventa AND ROWNUM <= 1;

        OPEN SC_cursordatos FOR

        SELECT a.num_abonado
              ,a.cod_plantarif
              ,a.cod_cargobasico
              ,a.cod_planserv
              ,a.num_serie
              ,a.num_imei
              ,a.cod_cliente
              ,a.cod_vendedor
              ,a.cod_tipcontrato
              ,a.cod_causa_venta
              ,a.cod_modventa
              ,a.tip_plantarif
              ,a.num_contrato
              ,a.cod_uso
              ,a.num_min
              ,a.cod_central
              ,a.num_celular
              ,a.cod_cuenta
              ,a.cod_tecnologia
        FROM  ga_abocel a
        WHERE a.num_venta = EN_numventa;

        IF (LN_contador = 0) THEN
            RAISE no_data_found_cursor;
        END IF;

    EXCEPTION
        WHEN no_data_found_cursor THEN
             SN_cod_retorno:=99;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_abonados_venta_PR('|| EN_numventa ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_abonados_venta_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_abonados_venta_PR('|| EN_numventa ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_abonados_venta_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_abonados_venta_PR;

    PROCEDURE VE_inserta_cargo_PR( EV_num_cargo         IN VARCHAR2
                                   ,EV_cod_cliente         IN VARCHAR2
                                  ,EV_cod_producto         IN VARCHAR2
                                   ,EV_cod_concepto         IN VARCHAR2
                                   ,EV_imp_cargo             IN VARCHAR2
                                   ,EV_cod_moneda             IN VARCHAR2
                                   ,EV_cod_plancom         IN VARCHAR2
                                   ,EV_num_unidades         IN VARCHAR2
                                   ,EV_ind_factur             IN VARCHAR2
                                   ,EV_num_transaccion    IN VARCHAR2
                                   ,EV_num_venta            IN VARCHAR2
                                   ,EV_num_paquete        IN VARCHAR2        -- NULL
                                   ,EV_num_abonado        IN VARCHAR2
                                   ,EV_num_terminal        IN VARCHAR2
                                   ,EV_cod_ciclfact        IN VARCHAR2
                                   ,EV_num_serie            IN VARCHAR2
                                   ,EV_num_seriemec        IN VARCHAR2        -- NULL
                                   ,EV_cap_code            IN VARCHAR2        -- NULL
                                   ,EV_mes_garantia        IN VARCHAR2
                                   ,EV_num_preguia        IN VARCHAR2        -- NULL
                                   ,EV_num_guia            IN VARCHAR2        -- NULL
                                   ,EV_num_factura        IN VARCHAR2
                                   ,EV_cod_concepto_dto    IN VARCHAR2
                                   ,EV_val_dto            IN VARCHAR2
                                   ,EV_tip_dto            IN VARCHAR2
                                   ,EV_ind_cuota            IN VARCHAR2        -- NULL
                                   ,EV_ind_supertel        IN VARCHAR2
                                   ,EV_ind_manual            IN VARCHAR2        -- NULL
                                   ,EV_pref_plaza            IN VARCHAR2        -- NULL
                                   ,EV_cod_tecnologia        IN VARCHAR2        -- GSM
                                   ,EV_usuario              IN VARCHAR2
                                   ,SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError
                                   ,SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError
                                  ,SN_num_evento          OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_inserta_cargo_PR"
        Lenguaje="PL/SQL"
        Fecha="26-03-2007"
        Version="1.0.0"
        Dise?ador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Inserta los cargos del abonado
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
        ...
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
         LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:= 'INSERT INTO ge_cargos ('
                     ||'NUM_CARGO'
                  ||',COD_CLIENTE'
                  ||',COD_PRODUCTO'
                  ||',COD_CONCEPTO'
                  ||',FEC_ALTA'
                  ||',IMP_CARGO'
                  ||',COD_MONEDA'
                  ||',COD_PLANCOM'
                  ||',NUM_UNIDADES'
                  ||',IND_FACTUR'
                  ||',NUM_TRANSACCION'
                  ||',NUM_VENTA'
                  ||',NUM_PAQUETE'
                  ||',NUM_ABONADO'
                  ||',NUM_TERMINAL'
                  ||',COD_CICLFACT'
                  ||',NUM_SERIE'
                  ||',NUM_SERIEMEC'
                  ||',CAP_CODE'
                  ||',MES_GARANTIA'
                  ||',NUM_PREGUIA'
                  ||',NUM_GUIA'
                  ||',NUM_FACTURA'
                  ||',COD_CONCEPTO_DTO'
                  ||',VAL_DTO'
                  ||',TIP_DTO'
                  ||',IND_CUOTA'
                  ||',IND_SUPERTEL'
                  ||',IND_MANUAL'
                  ||',NOM_USUARORA'
                  ||',PREF_PLAZA'
                  ||',COD_TECNOLOGIA)'
                ||'VALUES ('
                  ||EV_num_cargo
                  ||','||EV_cod_cliente
                  ||','||EV_cod_producto
                  ||','||EV_cod_concepto
                  ||',SYSDATE'
                  ||','||EV_imp_cargo
                  ||','||EV_cod_moneda
                  ||','||EV_cod_plancom
                  ||','||EV_num_unidades
                  ||','||EV_ind_factur
                  ||','||EV_num_transaccion
                  ||','||EV_num_venta
                  ||','||EV_num_paquete
                  ||','||EV_num_abonado
                  ||','||EV_num_terminal
                  ||','||EV_cod_ciclfact
                  ||','||EV_num_serie
                  ||','||EV_num_seriemec
                  ||','||EV_cap_code
                  ||','||EV_mes_garantia
                  ||','||EV_num_preguia
                  ||','||EV_num_guia
                  ||','||EV_num_factura
                  ||','||EV_cod_concepto_dto
                  ||','||EV_val_dto
                  ||','||EV_tip_dto
                  ||','||EV_ind_cuota
                  ||','||EV_ind_supertel
                  ||','||EV_ind_manual
                  ||','||EV_usuario
                  ||','||EV_pref_plaza
                  ||','||EV_cod_tecnologia||')';

        INSERT INTO ge_cargos (
                                  NUM_CARGO
                              ,COD_CLIENTE
                              ,COD_PRODUCTO
                              ,COD_CONCEPTO
                              ,FEC_ALTA
                              ,IMP_CARGO
                              ,COD_MONEDA
                              ,COD_PLANCOM
                              ,NUM_UNIDADES
                              ,IND_FACTUR
                              ,NUM_TRANSACCION
                              ,NUM_VENTA
                              ,NUM_PAQUETE
                              ,NUM_ABONADO
                              ,NUM_TERMINAL
                              ,COD_CICLFACT
                              ,NUM_SERIE
                              ,NUM_SERIEMEC
                              ,CAP_CODE
                              ,MES_GARANTIA
                              ,NUM_PREGUIA
                              ,NUM_GUIA
                              ,NUM_FACTURA
                              ,COD_CONCEPTO_DTO
                              ,VAL_DTO
                              ,TIP_DTO
                              ,IND_CUOTA
                              ,IND_SUPERTEL
                              ,IND_MANUAL
                              ,NOM_USUARORA
                              ,PREF_PLAZA
                              ,COD_TECNOLOGIA
                              )
        VALUES (
               EV_num_cargo
              ,EV_cod_cliente
              ,EV_cod_producto
              ,EV_cod_concepto
              ,SYSDATE
              ,EV_imp_cargo
              ,EV_cod_moneda
              ,EV_cod_plancom
              ,EV_num_unidades
              ,EV_ind_factur
              ,EV_num_transaccion
              ,EV_num_venta
              ,EV_num_paquete
              ,EV_num_abonado
              ,EV_num_terminal
              ,EV_cod_ciclfact
              ,EV_num_serie
              ,EV_num_seriemec
              ,EV_cap_code
              ,EV_mes_garantia
              ,EV_num_preguia
              ,EV_num_guia
              ,EV_num_factura
              ,EV_cod_concepto_dto
              ,EV_val_dto
              ,EV_tip_dto
              ,EV_ind_cuota
              ,EV_ind_supertel
              ,EV_ind_manual
              ,EV_usuario
              ,EV_pref_plaza
              ,EV_cod_tecnologia
              );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error:=SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_inserta_cargo_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_inserta_cargo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_inserta_cargo_PR;

    PROCEDURE VE_consulta_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                       SV_numident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                     SV_tipident      OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                     SV_nomcliente      OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                     SN_codcuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                     SV_nomapellido1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                     SV_nomapellido2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                     SV_fecnaciomien  OUT NOCOPY ge_clientes.fec_nacimien%TYPE,
                                     SV_indestcivil   OUT NOCOPY ge_clientes.ind_estcivil%TYPE,
                                     SV_indsexo          OUT NOCOPY ge_clientes.ind_sexo%TYPE,
                                     SN_codactividad  OUT NOCOPY ge_clientes.cod_actividad%TYPE,
                                     SV_codregion      OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                     SV_codciudad      OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                     SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                     SV_codcelda      OUT NOCOPY ge_ciudades.cod_celda%TYPE,
                                     SV_codcalclien   OUT NOCOPY ge_clientes.cod_calclien%TYPE,
                                     SN_indfactur      OUT NOCOPY ge_clientes.ind_factur%TYPE,
                                     SN_codciclo      OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
                                     SN_codempresa    OUT NOCOPY ga_empresa.cod_empresa%TYPE,
                                     SV_coddireccion  OUT NOCOPY VARCHAR2,
                                     SV_codplantarif  OUT NOCOPY VARCHAR2,
                                     SV_CodOperadora  OUT NOCOPY VARCHAR2,
                                     SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_consulta_cliente_PR"
        Lenguaje="PL/SQL"
        Fecha="29-03-2007"
        Version="1.0.0"
        Dise?ador="Hector Hermosilla"
        Programador="Hector Hermosilla
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Consulta datos del cliente
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EV_codcliente"     Tipo="NUMBER> codigo cliente</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
             LV_Sql       ge_errores_pg.vQuery;
             LV_des_error ge_errores_pg.DesEvent;
             LV_IND_ALTA  GE_CLIENTES.IND_ALTA%TYPE;
             ERROR_ESPREPAGO exception;

        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:= 'SELECT IND_ALTA FROM GE_CLIENTES WHERE COD_CLIENTE= ' || EV_codcliente;

             SELECT IND_ALTA
               INTO LV_IND_ALTA
               FROM GE_CLIENTES
              WHERE COD_CLIENTE=EV_codcliente;

             IF LV_IND_ALTA = CV_INDALTA THEN

                 RAISE ERROR_ESPREPAGO;

             END IF;


             LV_Sql:= 'SELECT a.num_ident, a.cod_tipident, a.nom_cliente, '
                       || 'a.cod_cuenta,'
                      || 'a.nom_apeclien1,'
                      || 'a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,'
                      || 'a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,'
                      || 'c.cod_provincia, e.cod_celda, a.cod_calclien,'
                      || 'a.ind_factur, a.cod_ciclo,NVL(b.cod_empresa,0),'
                      || 'd.cod_direccion, b.cod_plantarif, cod_operadora '
                      || 'FROM     ge_clientes a, ga_empresa b,'
                      || 'ge_direcciones c, ga_direccli d,'
                      || 'ge_ciudades e'
                      || 'WHERE    a.cod_cliente = ' || EV_codcliente
                      || 'AND a.cod_cliente = b.cod_cliente(+)'
                      || 'AND d.cod_cliente = a.cod_cliente'
                      || 'AND d.cod_tipdireccion = ' || CV_tipodireccion
                      || 'AND c.cod_direccion = d.cod_direccion'
                      || 'AND e.cod_ciudad = c.cod_ciudad'
                      || 'AND e.cod_provincia = c.cod_provincia'
                      || 'AND e.cod_region = c.cod_region';

             SELECT a.num_ident, a.cod_tipident, a.nom_cliente,
                    a.cod_cuenta,
                     a.nom_apeclien1,
                    a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,
                    a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,
                    c.cod_provincia, e.cod_celda, a.cod_calclien,
                    a.ind_factur, a.cod_ciclo, NVL(b.cod_empresa,0),
                    d.cod_direccion, b.cod_plantarif,a.cod_operadora
             INTO    SV_numident, SV_tipident, SV_nomcliente,SN_codcuenta,
                    SV_nomapellido1,
                    SV_nomapellido2, SV_fecnaciomien, SV_indestcivil,
                    SV_indsexo, SN_codactividad, SV_codregion,
                    SV_codciudad, SV_codprovincia, SV_codcelda,
                    SV_codcalclien, SN_indfactur, SN_codciclo, SN_codempresa,
                    SV_coddireccion, SV_codplantarif,SV_CodOperadora
             FROM     ge_clientes a, ga_empresa b,
                     ge_direcciones c, ga_direccli d,
                    ge_ciudades e
             WHERE    a.cod_cliente = EV_codcliente
                     AND a.cod_cliente = b.cod_cliente(+)
                    AND d.cod_cliente = a.cod_cliente
                    AND d.cod_tipdireccion = CV_tipodireccion
                       AND c.cod_direccion = d.cod_direccion
                    AND e.cod_ciudad = c.cod_ciudad
                    AND e.cod_provincia = c.cod_provincia
                    AND e.cod_region = c.cod_region;

             EXCEPTION
                   WHEN ERROR_ESPREPAGO THEN
                       SN_cod_retorno:=314;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN NO_DATA_FOUND THEN
                       SN_cod_retorno:=1;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_consulta_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );
        END VE_consulta_cliente_PR;

    /*
        PROCEDURE VE_busca_evaluacion_riesgo_PR(EV_numident        IN ge_clientes.num_ident%TYPE,
                                                 EV_tipident           IN ge_clientes.cod_tipident%TYPE,
                                                EN_tipo_solicitud  IN ert_solicitud.ind_tipo_solicitud%TYPE,
                                                EN_ind_evento       IN ert_solicitud.ind_evento%TYPE,
                                                EV_cod_estado       IN VARCHAR2,
                                                EV_tipocliente     IN VARCHAR2,
                                                SN_lim_credito     OUT NOCOPY ert_datos_consulta_to.lim_credito%TYPE,
                                                SN_monto_garantia  OUT NOCOPY ert_solicitud.mto_garantia%TYPE,
                                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_busca_evaluacion_riesgo_PR
            Lenguaje="PL/SQL"
            Fecha="29-03-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Busca evaluacion de riego de un cliente
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_numident"       Tipo="VARCHAR> numero identificacion cliente</param>
            <param nom="EV_tipident"       Tipo="VARCHAR> tipo identificacion cliente</param>
            <param nom="EN_tipo_solicitud" Tipo="NUMBER> tipo solicitud</param>
            <param nom="EN_ind_evento"     Tipo="NUMBER> indicador de evento</param>
            <param nom="EV_cod_estado"     Tipo="VARCHAR2> estados vigentes de evaluacion de riesgo</param>
             <param nom="EV_tipocliente"    Tipo="VARCHAR2> tipo cliente I individual E empresa</param>
        </Entrada>
        <Salida>
            <param nom="SN_lim_credito"    Tipo="NUMBER"> limite credito </param>
             <param nom="SN_monto_garantia" Tipo="NUMBER"> monto garantia </param>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            /*
            LV_Parametros   ARRAY_PARAMETROS_;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_esta         VARCHAR2(1);
            LV_valparametro ged_parametros.val_parametro%TYPE;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SN_lim_credito:=0;

               IF (VE_CONSULTA_EXTERNA_PG.VE_VIGENCIA_FN(EV_numident,EV_tipident,SN_cod_retorno,SV_mens_retorno)) THEN
                    LV_Sql:='SELECT datos_evaluacion.lim_credito, sol_eval_riesgo.mto_garantia'
                            || ' FROM ert_solicitud sol_eval_riesgo, ert_datos_consulta_to datos_evaluacion'
                            || ' WHERE     sol_eval_riesgo.num_ident_cliente = :EV_numident '
                            || ' AND sol_eval_riesgo.cod_tipident = :EV_tipident '
                            || ' AND sol_eval_riesgo.ind_tipo_solicitud = :EV_tipo_solicitud'
                            || ' AND sol_eval_riesgo.ind_evento = :EV_ind_evento'
                            || ' AND sol_eval_riesgo.cod_estado IN(:par1,:par2)'
                            || ' AND sol_eval_riesgo.num_ident_cliente =  datos_evaluacion.num_ident'
                            || ' AND sol_eval_riesgo.cod_tipident = datos_evaluacion.cod_tipident'
                            || ' AND datos_evaluacion.num_linea = 1';

                    LV_Parametros(1):= SUBSTR(EV_cod_estado,2,1);
                    LV_Parametros(2):= SUBSTR(EV_cod_estado,6,1);

                    EXECUTE IMMEDIATE LV_Sql INTO SN_lim_credito, SN_monto_garantia USING IN EV_numident, EV_tipident, EN_tipo_solicitud, EN_ind_evento,LV_Parametros(1),LV_Parametros(2);

                ELSE
                    RAISE NO_DATA_FOUND;
                END IF;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_busca_evaluacion_riesgo_PR('|| EV_numident||','||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','||EV_cod_estado||','||EV_tipocliente||');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_busca_evaluacion_riesgo_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_busca_evaluacion_riesgo_PR('|| EV_numident||','||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','||EV_cod_estado||','||EV_tipocliente||');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_busca_evaluacion_riesgo_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );
        END VE_busca_evaluacion_riesgo_PR;*/


        PROCEDURE VE_busca_eriesgo_ptarif_PR(EV_numident         IN ge_clientes.num_ident%TYPE,
                                              EV_tipident        IN ge_clientes.cod_tipident%TYPE,
                                             EN_tipo_solicitud    IN ERT_SOLICITUD.ind_tipo_solicitud%TYPE,
                                             EN_ind_evento        IN ERT_SOLICITUD.ind_evento%TYPE,
                                             EV_cod_estado        IN VARCHAR2,
                                             EV_plantarif        IN ert_solicitud_planes.cod_plantarif%TYPE,
                                             SN_num_solicitud   OUT NOCOPY ert_solicitud_planes.num_solicitud%TYPE,
                                             SN_cant_terminales    OUT NOCOPY ert_solicitud_planes.val_cant_terminales%TYPE,
                                             SN_cant_vendidos     OUT NOCOPY ert_solicitud_planes.val_cant_vendidos%TYPE,
                                             SN_cod_estado        OUT NOCOPY ERT_SOLICITUD.cod_estado%TYPE,
                                             SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_busca_eriesgo_ptarif_PR
            Lenguaje="PL/SQL"
            Fecha="29-03-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Busca evaluacion de riego asociada a un plan tarifario de un cliente especifico
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_numident"       Tipo="VARCHAR2"> numero identificacion cliente</param>
            <param nom="EV_tipident"       Tipo="VARCHAR2"> tipo identificacion cliente</param>
            <param nom="EN_tipo_solicitud" Tipo="NUMBER"> tipo solicitud</param>
            <param nom="EN_ind_evento"     Tipo="NUMBER"> indicador de evento</param>
            <param nom="EV_cod_estado"     Tipo="VARCHAR2"> estados vigentes de evaluacion de riesgo</param>
            <param nom="EV_plantarif       Tipo="VARCHAR2"> codigo plan tarifario/param>

        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_Parametros ARRAY_PARAMETROS_;
            LV_Sql      ge_errores_pg.vQuery;
            LV_SqlEjecutar      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_Sql:='SELECT  a.num_solicitud,b.val_cant_terminales, b.val_cant_vendidos,'
                    || ' a.cod_estado'
                    || ' FROM      ert_solicitud_planes b,ert_solicitud a'
                    || ' WHERE     a.num_ident_cliente = :EV_numident'
                    || ' AND a.cod_tipident = :EV_tipident'
                    || ' AND a.num_solicitud = b.num_solicitud'
                    || ' AND a.ind_tipo_solicitud = :EN_tipo_solicitud'
                    || ' AND a.ind_evento = :EN_ind_evento'
                    || ' AND a.cod_estado IN(:par1,:par2)'
                    || ' AND b.cod_plantarif = :EV_plantarif';


            LV_Parametros(1):= SUBSTR(EV_cod_estado,2,1);
            LV_Parametros(2):= SUBSTR(EV_cod_estado,6,1);

            EXECUTE IMMEDIATE LV_Sql INTO SN_num_solicitud,SN_cant_terminales,SN_cant_vendidos,SN_cod_estado
            USING IN EV_numident, EV_tipident, EN_tipo_solicitud, EN_ind_evento,LV_Parametros(1),LV_Parametros(2),EV_plantarif;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_busca_eriesgo_ptarif_PR('||EV_numident||','||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','||EV_cod_estado||','||EV_plantarif||')- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_busca_eriesgo_ptarif_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_busca_eriesgo_ptarif_PR('||EV_numident||','||EV_tipident||','||EN_tipo_solicitud||','||EN_ind_evento||','||EV_cod_estado||','||EV_plantarif||')- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_busca_eriesgo_ptarif_PR(' || EV_numident || ',' || EN_tipo_solicitud || ',' || EV_cod_estado || ')', LV_Sql, SQLCODE, LV_des_error );

        END VE_busca_eriesgo_ptarif_PR;

        PROCEDURE VE_consulta_serie_PR(EV_serie           IN  al_series.num_serie%TYPE,
                                        SV_codbodega       OUT NOCOPY al_series.cod_bodega%TYPE,
                                       SV_estadoserie  OUT NOCOPY al_series.cod_estado%TYPE,
                                       SV_indtelefono  OUT NOCOPY al_series.ind_telefono%TYPE,
                                       SV_numcelular   OUT NOCOPY al_series.num_telefono%TYPE,
                                       SV_uso           OUT NOCOPY al_series.cod_uso%TYPE,
                                       SV_tipostock       OUT NOCOPY al_series.tip_stock%TYPE,
                                       SV_codcentral   OUT NOCOPY al_series.cod_central%TYPE,
                                       SN_codarticulo  OUT NOCOPY al_series.cod_articulo%TYPE,
                                       SN_capcode      OUT NOCOPY al_series.cap_code%TYPE,
                                       SN_tiparticulo  OUT NOCOPY al_articulos.tip_articulo%TYPE,
                                       SV_desarticulo  OUT NOCOPY al_articulos.des_articulo%TYPE,
                                          SV_codsubalm    OUT NOCOPY al_series.cod_subalm%TYPE,
                                          SN_indvalorar   OUT NOCOPY al_tipos_stock.ind_valorar%TYPE,
                                       SV_carga        OUT NOCOPY VARCHAR2,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_consulta_serie_PR
                Lenguaje="PL/SQL"
                Fecha="30-03-2007"
                Version="1.0.0"
                Dise?ador="Hector Hermosilla"
                Programador="Hector Hermosilla
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Consulta datos de una serie especifica
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
            </Entrada>
            <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
                LV_Sql      ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.DesEvent;
            BEGIN
                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';

                LV_Sql:= 'SELECT s.cod_bodega, s.cod_estado, s.ind_telefono,'
                         || ' s.num_telefono, s.cod_uso, s.tip_stock,'
                         || ' s.cod_central, s.cap_code, s.cod_articulo,'
                         || ' a.tip_articulo, a.des_articulo, s.cod_subalm,'
                         || ' t.ind_valorar '
                         || ' ,s.carga '
                         || ' FROM   al_series s, al_articulos a'
                         || ' WHERE s.num_serie =' || EV_serie
                         || ' AND s.cod_articulo = a.cod_articulo, al_tipos_stock t'
                         || ' AND s.tip_stock = t.tip_stock';

                SELECT s.cod_bodega, s.cod_estado, s.ind_telefono,
                       s.num_telefono, s.cod_uso, s.tip_stock,
                       s.cod_central, s.cap_code, s.cod_articulo,
                       a.tip_articulo, a.des_articulo, s.cod_subalm,
                       t.ind_valorar
                       ,s.carga
                INTO   SV_codbodega, SV_estadoserie, SV_indtelefono,
                       SV_numcelular, SV_uso, SV_tipostock,
                       SV_codcentral, SN_capcode, SN_codarticulo,
                       SN_tiparticulo, SV_desarticulo, SV_codsubalm,
                       SN_indvalorar
                       ,SV_carga
                FROM   al_series s, al_articulos a, al_tipos_stock t
                WHERE  s.num_serie = EV_serie
                  AND A.COD_ARTICULO=S.COD_ARTICULO
                  AND S.TIP_STOCK=T.TIP_STOCK
                  AND  s.cod_articulo = a.cod_articulo
                  AND  s.tip_stock = t.tip_stock;


                EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                           SN_cod_retorno:=1;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_serie_PR(' || EV_serie || ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_consulta_serie_PR(' || EV_serie || ')', LV_Sql, SQLCODE, LV_des_error );
                     WHEN OTHERS THEN
                           SN_cod_retorno:=156;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_serie_PR(' || EV_serie || ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_consulta_serie_PR(' || EV_serie || ')', LV_Sql, SQLCODE, LV_des_error );

        END VE_consulta_serie_PR;


        PROCEDURE VE_consulta_plan_tarifario_PR(EV_plantarif           IN ta_plantarif.cod_plantarif%TYPE,
                                                EN_codproducto           IN ga_modvent_aplic.cod_producto%TYPE,
                                                EV_tecnologia          IN al_tecnologia.cod_tecnologia%TYPE,
                                                 SV_desplantarif        OUT NOCOPY ta_plantarif.des_plantarif%TYPE,
                                                 SV_tipplantarif        OUT NOCOPY ta_plantarif.tip_plantarif%TYPE,
                                                 SV_codlimconsumo       OUT NOCOPY tol_limite_td.cod_limcons%TYPE,
                                                  SN_numdias             OUT NOCOPY ta_plantarif.num_dias%TYPE,
                                                SV_codplanserv         OUT NOCOPY ga_planserv.cod_planserv%TYPE,
                                                  SN_ind_cargo_habil      OUT NOCOPY ta_plantarif.ind_cargo_habil%TYPE,
                                                 SV_codcargobasico      OUT NOCOPY ta_plantarif.cod_cargobasico%TYPE,
                                                 SV_descargobasico      OUT NOCOPY ta_cargosbasico.des_cargobasico%TYPE,
                                                 SN_importecargo        OUT NOCOPY ta_cargosbasico.imp_cargobasico%TYPE,
                                                 SV_monedacargobasico OUT NOCOPY ta_cargosbasico.cod_moneda%TYPE,
                                                SV_codtiplan            OUT NOCOPY ta_plantarif.cod_tiplan%TYPE,
                                                SN_ind_familiar      OUT NOCOPY ta_plantarif.ind_familiar%TYPE,
                                                SN_num_abonados      OUT NOCOPY ta_plantarif.num_abonados%TYPE,
                                                SV_cod_plan_comverse OUT NOCOPY VARCHAR2,
                                                 SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS

        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_consulta_plan_tarifario_PR
            Lenguaje="PL/SQL"
            Fecha="30-03-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Consulta datos de una serie especifica
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_plantarif"          Tipo="STRING"> codigo plan tarifario a consultar</param>
            <param nom="EN_codproducto"        Tipo="NUMBER"> codigo producto</param>
            <param nom="EV_tecnologia"         Tipo="STRING"> codigo tecnologia</param>

        </Entrada>
        <Salida>
               <param nom="SV_desplantarif"      Tipo="STRING"> descripcion plan tarifario </param>
               <param nom="SV_tipplantarif"      Tipo="STRING"> codigo limite de consumo</param>
               <param nom="SV_codlimconsumo"     Tipo="STRING"> codigo limite de consumo</param>
               <param nom="SN_numdias"           Tipo="NUMBER"> numero de dias</param>
               <param nom="SV_codplanserv"       Tipo="STRING"> codigo plan de servicio</param>
            <param nom="SN_ind_cargo_habil"   Tipo="NUMBER"> indicador de cobro de habilitaci�n</param>
               <param nom="SV_codcargobasico"    Tipo="STRING"> codigo cargo basico</param>
               <param nom="SV_descargobasico"    Tipo="STRING"> desccripci�n cargo basico</param>
               <param nom="SN_importecargo"      Tipo="NUMBER"> importe cargo basico</param>
               <param nom="SV_monedacargobasico" Tipo="STRING"> c�digo moneda utilizada en cargo basico</param>
            <param nom="SV_codtiplan"         Tipo="STRING"> c�digo tipo plan en GED_CODIGOS</param>
            <param nom="SN_ind_familiar"      Tipo="NUMBER"> indica si es plan familiar</param>
            <param nom="SN_numAbonados"       Tipo="NUMBER"> numero de abonados </param>
            <param nom="SV_cod_plan_comverse" Tipo="STRING"> codigo de plan converse </param>
            <param nom="SN_cod_retorno"       Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"      Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"        Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
        BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_sql:= 'SELECT plantarifario.tip_plantarif, d.cod_limcons,'
                      || ' plantarifario.num_dias, plantarifario.ind_cargo_habil,'
                      || ' relserviciotecnoplantarif.cod_planserv,'
                      || ' plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico,'
                      || ' cargosbasicos.imp_cargobasico, cargosbasicos.cod_moneda,'
                      || ' plantarifario.cod_tiplan, plantarifario.ind_familiar,'
                      || ' plantarifario.des_plantarif, plantarifario.num_abonados,'
                      || ' plantarifario.cod_plan_comverse'
                      || ' FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,'                       || ' ,tol_limite_td d,'
                      || ' ,tol_limite_plan_td e'
                      || ' WHERE plantarifario.cod_plantarif= ' || EV_plantarif
--                       || ' AND SYSDATE BETWEEN plantarifario.fec_desde   ' INCIDENCIA 68053 MIX COLOMBIA -JBS
--                      || ' AND NVL(plantarifario.fec_hasta, SYSDATE)'    ' INCIDENCIA 68053 MIX COLOMBIA -JBS
                      || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico '
                      || ' AND plantarifario.cod_producto =' || EN_codproducto
                      || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde '
                      || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)'
                      || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)'
                      || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)'
                      || ' AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde'
                      || ' AND SYSDATE BETWEEN e.FEC_DESDE AND NVL(e.FEC_HASTA, SYSDATE)'
                      || ' AND e.COD_PLANTARIF = plantarifario.cod_plantarif'
                      || ' AND d.cod_limcons = e.cod_limcons'
                      || ' and e.ind_default=S'
                      || ' AND ROWNUM<=1';


--              SELECT plantarifario.tip_plantarif, d.cod_limcons,
--                     plantarifario.num_dias, plantarifario.ind_cargo_habil,
--                     relserviciotecnoplantarif.cod_planserv,
--                     plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico,
--                     cargosbasicos.imp_cargobasico, cargosbasicos.cod_moneda,
--                     plantarifario.cod_tiplan, plantarifario.ind_familiar,
--                     plantarifario.des_plantarif, plantarifario.num_abonados,
--                     plantarifario.cod_plan_comverse
--              INTO     SV_tipplantarif, SV_codlimconsumo,
--                      SN_numdias, SN_ind_cargo_habil,
--                     SV_codplanserv,
--                     SV_codcargobasico, SV_descargobasico,
--                     SN_importecargo, SV_monedacargobasico,
--                     SV_codtiplan, SN_ind_familiar,
--                     SV_desplantarif, SN_num_abonados,
--                     SV_cod_plan_comverse
--              FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,
--                     ga_plantecplserv relserviciotecnoplantarif,tol_limite_td d,
--                     tol_limite_plan_td e
--              WHERE    plantarifario.cod_plantarif= EV_plantarif
--                      AND SYSDATE BETWEEN plantarifario.fec_desde
--                     AND NVL(plantarifario.fec_hasta, SYSDATE)
--                     AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico
--                     AND plantarifario.cod_producto = EN_codproducto
--                     AND SYSDATE BETWEEN cargosbasicos.fec_desde
--                     AND NVL(cargosbasicos.fec_hasta, SYSDATE)
--                     AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
--                     AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
--                     AND relserviciotecnoplantarif.cod_tecnologia = EV_tecnologia
--                     AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde
--                     AND NVL(relserviciotecnoplantarif.fec_hasta, SYSDATE)
--                     AND SYSDATE BETWEEN e.FEC_DESDE AND NVL(e.FEC_HASTA, SYSDATE)
--                     AND e.COD_PLANTARIF = plantarifario.cod_plantarif
--                     AND d.cod_limcons = e.cod_limcons
--                     AND e.ind_default = 'S'
--                     AND ROWNUM<=1;

              SELECT a.tip_plantarif, nvl(d.cod_limcons,-1),a.num_dias,a.ind_cargo_habil,'0',a.cod_cargobasico
              ,b.des_cargobasico,b.imp_cargobasico, b.cod_moneda,a.cod_tiplan, a.ind_familiar,a.des_plantarif
              ,a.num_abonados,a.cod_plan_comverse
              INTO     SV_tipplantarif, SV_codlimconsumo,
                     SN_numdias, SN_ind_cargo_habil,
                    SV_codplanserv,
                    SV_codcargobasico, SV_descargobasico,
                    SN_importecargo, SV_monedacargobasico,
                    SV_codtiplan, SN_ind_familiar,
                    SV_desplantarif, SN_num_abonados,
                    SV_cod_plan_comverse
              FROM   ta_plantarif a, ta_cargosbasico b,tol_limite_td d,    tol_limite_plan_td e
              WHERE    a.cod_plantarif= EV_plantarif
              AND a.cod_producto = EN_codproducto
--              AND SYSDATE BETWEEN a.fec_desde     AND NVL(a.fec_hasta, SYSDATE) ' INCIDENCIA 68053 MIX COLOMBIA -JBS
              and a.cod_producto=b.cod_producto
              AND a.cod_cargobasico= b.cod_cargobasico
              AND SYSDATE BETWEEN b.fec_desde    AND NVL(b.fec_hasta, SYSDATE)
              AND a.COD_PLANTARIF = e.cod_plantarif(+)
              AND e.ind_default(+) = 'S'
              AND SYSDATE BETWEEN e.FEC_DESDE(+) AND NVL(e.FEC_HASTA(+), SYSDATE)
              AND d.cod_limcons(+) = e.cod_limcons
              AND SYSDATE BETWEEN d.FEC_DESDE(+) AND NVL(d.FEC_HASTA(+), SYSDATE)
              AND ROWNUM<=1;


             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                       SN_cod_retorno:=1;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_plan_tarifario_PR('||EV_plantarif||','||EN_codproducto||','||EV_tecnologia||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_consulta_plan_tarifario_PR('||EV_plantarif||')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_plan_tarifario_PR('||EV_plantarif||','||EN_codproducto||','||EV_tecnologia||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_consulta_plan_tarifario_PR('||EV_plantarif||')', LV_Sql, SQLCODE, LV_des_error );

        END VE_consulta_plan_tarifario_PR;

        PROCEDURE VE_precio_cargo_basico_PR(EV_codproducto     IN VARCHAR2,
                                            EV_codcargo        IN VARCHAR2,
                                            SC_cursordatos       OUT NOCOPY REFCURSOR,
                                             SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_busca_precio_cargo_basico_PR"
            Lenguaje="PL/SQL"
            Fecha="09-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Consulta datos de una serie especifica
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
            <param nom="EV_codcargo"    Tipo="VARCHAR2"> codigo del cargo</param>
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            no_data_found_cursor               EXCEPTION;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_concepto   VARCHAR2(4);
            LN_contador NUMBER;
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SELECT a.cod_abonocel
            INTO LV_concepto
            FROM fa_datosgener a;

             LV_sql:= 'SELECT '
                       || ' a.cod_concepto '
                       || ',a.des_concepto '
                       || ',b.imp_cargobasico '
                       || ',a.cod_moneda '
                       || ',c.des_moneda '
                      || ',''A'' '
                      || ',''1'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ' FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c'
                      || ' WHERE a.cod_concepto = ' || LV_concepto
                      || ' AND a.cod_producto = = ' || EV_codproducto
                      || ' AND b.cod_producto = a.cod_producto '
                      || ' AND b.cod_cargobasico = ' || EV_codcargo
                      || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)'
                      || ' AND a.cod_moneda = c.cod_moneda';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c
            WHERE a.cod_concepto = LV_concepto
              AND a.cod_producto = EV_codproducto
              AND b.cod_producto = a.cod_producto
                 AND b.cod_cargobasico = EV_codcargo
              AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
              AND a.cod_moneda = c.cod_moneda AND ROWNUM <= 1;

            OPEN SC_cursordatos FOR
                SELECT
                     a.cod_concepto
                    ,a.des_concepto
                    ,b.imp_cargobasico
                    ,a.cod_moneda
                    ,c.des_moneda
                    ,'A'-- tipo cargo [ Automatico o Manual ]
                    ,'1'-- numero unidades
                    ,'0'-- ind. equipo
                    ,'0'-- ind. paquete
                    ,'0'-- mes garantia
                    ,'0'-- ind. accesorio
                    ,'0'-- cod. articulo
                    ,'0'-- cod. stock
                    ,'0'-- cod. estado
                FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c
                WHERE a.cod_concepto = LV_concepto
                  AND a.cod_producto = EV_codproducto
                  AND b.cod_producto = a.cod_producto
                     AND b.cod_cargobasico = EV_codcargo
                  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
                  AND a.cod_moneda = c.cod_moneda;
            IF (LN_contador = 0) THEN
                RAISE no_data_found_cursor;
            END IF;

         EXCEPTION
                 WHEN no_data_found_cursor THEN
                       SN_cod_retorno:=99;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_basico_PR('||EV_codproducto ||','||EV_codcargo||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_basico_PR('||EV_codcargo||')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_basico_PR('||EV_codproducto ||','||EV_codcargo||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_basico_PR('||EV_codcargo||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_precio_cargo_basico_PR;

        PROCEDURE VE_PrecCargoSimcard_PreLis_PR(EN_codarticulo  IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock     IN al_precios_venta.tip_stock%TYPE,
                                                EN_codusoventa  IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado    IN al_precios_venta.cod_estado%TYPE,
                                                EN_indrecambio  IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria IN al_precios_venta.cod_categoria%TYPE,
                                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_PrecCargoSimcard_PreLis_PR"
            Lenguaje="PL/SQL"
            Fecha="17-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Obtiene precio cargo de una simcard. Precio de Lista.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
           no_data_found_cursor               EXCEPTION;
           LV_des_error ge_errores_pg.DesEvent;
           LV_sSql      ge_errores_pg.vQuery;
           LN_contador NUMBER;

        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

             LV_sSql:= 'SELECT  a.cod_conceptoart'
                    ||',a.des_articulo'
                    ||',t.prc_venta'
                    ||',t.cod_moneda'
                    ||',m.des_moneda'
                    ||',NVL(t.val_minimo,0)'
                    ||',NVL(t.val_maximo,0)'
                    ||',''A'' '
                    ||',''1'' '
                    ||',''1'' '
                    ||',''0'' '
                    ||',a.MES_GARANTIA'
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||' FROM al_precios_venta t, al_articulos a, ge_monedas m'
                    ||' WHERE t.tip_stock = '||EN_tipstock
                    ||' AND t.cod_articulo ='|| EN_codarticulo
                    ||' AND t.cod_categoria = '||EV_codcategoria
                    ||' AND t.cod_uso = '||EN_codusoventa
                    ||' AND t.cod_estado = '||EN_codestado
                    ||' AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)'
                    ||' AND a.cod_articulo = t.cod_articulo'
                    ||' AND m.cod_moneda = t.cod_moneda'
                    ||' AND t.ind_recambio = '|| EN_indrecambio
                    ||' AND t.ind_renova = 0 ';



             LN_contador := 0;
             SELECT COUNT(1)
             INTO LN_contador
             FROM al_precios_venta t, al_articulos a, ge_monedas m
             WHERE t.tip_stock = EN_tipstock
               AND t.cod_articulo = EN_codarticulo
               AND t.cod_categoria = EV_codcategoria-- constante (ZZZ)
               AND t.cod_uso = EN_codusoventa
               AND t.cod_estado =  EN_codestado
               AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)
               AND a.cod_articulo = t.cod_articulo
               AND m.cod_moneda = t.cod_moneda
               AND t.ind_recambio = EN_indrecambio-- constante (9)
               AND t.ind_renova=0
               AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
              SELECT  a.cod_conceptoart
                    ,a.des_articulo
                    ,t.prc_venta
                    ,t.cod_moneda
                    ,m.des_moneda
                    ,NVL(t.val_minimo,0)
                    ,NVL(t.val_maximo,0)
                    ,'A'-- tipo cargo [ Automatico o Manual ]
                    ,'1'-- numero unidades
                    ,'1'-- ind. equipo
                    ,'0'-- ind. paquete
                    ,a.MES_GARANTIA
                    ,'0'-- ind. accesorio
                    ,'0'-- cod. articulo
                    ,'0'-- cod. stock
                    ,'0'-- cod. estado
             FROM al_precios_venta t, al_articulos a, ge_monedas m
             WHERE t.tip_stock = EN_tipstock
               AND t.cod_articulo = EN_codarticulo
               AND t.cod_categoria = EV_codcategoria-- constante (ZZZ)
               AND t.cod_uso = EN_codusoventa
               AND t.cod_estado =  EN_codestado
               AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)
               AND a.cod_articulo = t.cod_articulo
               AND m.cod_moneda = t.cod_moneda
               AND t.ind_recambio = EN_indrecambio -- constante (9)
               AND t.ind_renova=0;

             IF (LN_contador = 0) THEN
                RAISE no_data_found_cursor;
             END IF;

             EXCEPTION
                     WHEN no_data_found_cursor THEN
                           SN_cod_retorno:=99;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoSimcard_PreLis_PR('||EN_codarticulo||','
                                        ||EN_tipstock||','||EN_codusoventa||','||EN_codestado||','||EN_indrecambio||','||EV_codcategoria||');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoSimcard_PreLis_PR('||EN_codarticulo||')', LV_sSql, SQLCODE, LV_des_error );
                     WHEN OTHERS THEN
                           SN_cod_retorno:=156;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoSimcard_PreLis_PR('||EN_codarticulo||','
                                        ||EN_tipstock||','||EN_codusoventa||','||EN_codestado||','||EN_indrecambio||','||EV_codcategoria||');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoSimcard_PreLis_PR('||EN_codarticulo||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_PrecCargoSimcard_PreLis_PR;

        PROCEDURE VE_PrecCargoTerminal_PreLis_PR(EN_codarticulo  IN al_precios_venta.cod_articulo%TYPE,
                                                 EN_tipstock     IN al_precios_venta.tip_stock%TYPE,
                                                 EN_codusoventa  IN al_precios_venta.cod_uso%TYPE,
                                                 EN_codestado    IN al_precios_venta.cod_estado%TYPE,
                                                 EN_indrecambio  IN al_precios_venta.ind_recambio%TYPE,
                                                 EV_codcategoria IN al_precios_venta.cod_categoria%TYPE,
                                                 SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_PrecCargoTerminal_PreLis_PR"
            Lenguaje="PL/SQL"
            Fecha="17-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Obtiene precio cargo de un terminal o equipo. Precio de Lista.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
            ...
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            no_data_found_cursor      EXCEPTION;
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
            LN_contador NUMBER;
        BEGIN

               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_sSql:= 'SELECT  a.cod_conceptoart'
                    ||',a.des_articulo'
                    ||',t.prc_venta'
                    ||',t.cod_moneda'
                    ||',m.des_moneda'
                    ||',NVL(t.val_minimo,0)'
                    ||',NVL(t.val_maximo,0)'
                    ||',''A'' '
                    ||',''1'' '
                    ||',''1'' '
                    ||',''0'' '
                    ||',a.MES_GARANTIA'
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||' FROM al_precios_venta t, al_articulos a, ge_monedas m'
                    ||' WHERE t.tip_stock = '||EN_tipstock
                    ||' AND t.cod_articulo ='|| EN_codarticulo
                    ||' AND t.cod_categoria = '||EV_codcategoria
                    ||' AND t.cod_uso = '||EN_codusoventa
                    ||' AND t.cod_estado = '||EN_codestado
                    ||' AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)'
                    ||' AND a.cod_articulo = t.cod_articulo'
                    ||' AND m.cod_moneda = t.cod_moneda'
                    ||' AND t.ind_recambio = '|| EN_indrecambio
                    ||' AND t.ind_renova = 0 ';
             LN_contador := 0;
             SELECT COUNT(1)
             INTO LN_contador
             FROM al_precios_venta t, al_articulos a, ge_monedas m
             WHERE t.tip_stock = EN_tipstock
               AND t.cod_articulo = EN_codarticulo
--               AND t.cod_categoria = EV_codcategoria-- constante (ZZZ)
               AND t.cod_uso = EN_codusoventa
               AND t.cod_estado =  EN_codestado
               AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)
               AND a.cod_articulo = t.cod_articulo
               AND m.cod_moneda = t.cod_moneda
               AND t.ind_recambio = EN_indrecambio -- constante (9)
               AND t.ind_renova=0
               AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
              SELECT  a.cod_conceptoart
                    ,a.des_articulo
                    ,t.prc_venta
                    ,t.cod_moneda
                    ,m.des_moneda
                    ,NVL(t.val_minimo,0)
                    ,NVL(t.val_maximo,0)
                    ,'A'-- tipo cargo [ Automatico o Manual ]
                    ,'1'-- numero unidades
                    ,'1'-- ind. equipo
                    ,'0'-- ind. paquete
                    ,a.mes_garantia
                    ,'0'-- ind. accesorio
                    ,'0'-- cod. articulo
                    ,'0'-- cod. stock
                    ,'0'-- cod. estado
             FROM al_precios_venta t, al_articulos a, ge_monedas m
             WHERE t.tip_stock = EN_tipstock
               AND t.cod_articulo = EN_codarticulo
               AND t.cod_categoria = EV_codcategoria-- constante (ZZZ)
               AND t.cod_uso = EN_codusoventa
               AND t.cod_estado =  EN_codestado
               AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)
               AND a.cod_articulo = t.cod_articulo
               AND m.cod_moneda = t.cod_moneda
               AND t.ind_recambio = EN_indrecambio -- constante (9)
               AND t.ind_renova=0;-- constante (9)

             IF (LN_contador = 0) THEN
                RAISE no_data_found_cursor;
             END IF;

             EXCEPTION
                 WHEN no_data_found_cursor THEN
                       SN_cod_retorno:=99;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoTerminal_PreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                    ||EN_codusoventa||','||EN_codestado||','||EN_indrecambio||','||EV_codcategoria||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoTerminal_PreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoTerminal_PreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                    ||EN_codusoventa||','||EN_codestado||','||EN_indrecambio||','||EV_codcategoria||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_PrecCargoTerminal_PreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
        END VE_PrecCargoTerminal_PreLis_PR;

PROCEDURE VE_PRECARSIMCARD_NOPRELIS_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                                  EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                                EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                                EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                                EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                                EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                                  EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                                EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_PreCarSimcard_NoPreLis_PR"
            Lenguaje="PL/SQL"
            Fecha="05-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Obtiene precio cargo de simcard. No Precio de Lista.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
            ...
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
             no_data_found_cursor      EXCEPTION;
             LV_des_error ge_errores_pg.DesEvent;
             LV_sSql      ge_errores_pg.vQuery;
             LN_contador NUMBER;
        BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_sSql:= 'SELECT  b.cod_conceptoart'
                    ||',b.des_articulo'
                    ||',a.prc_venta'
                    ||',a.cod_moneda'
                    ||',c.des_moneda'
                    ||',NVL(a.val_minimo,0)'
                    ||',NVL(a.val_maximo,0)'
                    ||',''A'' '
                    ||',''1'' '
                    ||',''1'' '
                    ||',''0'' '
                    ||',a.mes_garantia'
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||'FROM al_precios_venta a'
                    ||    ',al_articulos b'
                    ||    ',ge_monedas c'
                    ||    ',(SELECT w.cod_categoria categoria'
                    ||      'FROM ve_catplantarif v, ve_categorias w'
                    ||      'WHERE v.cod_plantarif ='|| EV_plantarif
                    ||        'AND v.cod_categoria = w.cod_categoria) z'
                    ||    ',(SELECT p.num_meses meses '
                    ||      'FROM ga_percontrato p'
                    ||      'WHERE p.cod_producto > 0'
                    ||        'AND p.cod_tipcontrato = '||EV_tipocontrato||') xy'
                    ||'WHERE A.tip_stock = '||EN_tipstock
                    ||'AND a.cod_articulo = '||EN_codarticulo
                    ||'AND a.cod_uso = '||EN_codusoventa
                    ||'AND a.cod_estado = '||EN_codestado
                    ||'AND a.cod_modventa = '||EN_modventa
                    ||'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)'
                    ||'AND b.cod_articulo = a.cod_articulo'
                    ||'AND c.cod_moneda = a.cod_moneda'
                    ||'AND a.ind_recambio = '||EN_indrecambio
                    ||'AND a.num_meses = xy.meses'
                    ||'AND a.cod_categoria = z.categoria'
                    ||'AND a.cod_uso <> '||EN_codusoprepago
                    ||'AND b.ind_equiacc = '||EV_indequipo
                    ||'AND a.IND_RENOVA='|| CN_CERO;

             LN_contador := 0;
             SELECT COUNT(1)
             INTO LN_contador
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT w.cod_categoria categoria
                      FROM ve_catplantarif v, ve_categorias w
                      WHERE v.cod_plantarif = EV_plantarif
                        AND v.cod_categoria = w.cod_categoria) z
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND a.cod_modventa = EN_modventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = EN_indrecambio -- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = z.categoria
                  AND a.cod_uso <> EN_codusoprepago -- constante (3)
                  AND b.ind_equiacc = EV_indequipo -- cisntante (E)
                  AND a.IND_RENOVA=CN_CERO
                  AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
                SELECT b.cod_conceptoart
                      ,b.des_articulo
                      ,a.prc_venta
                      ,a.cod_moneda
                      ,c.des_moneda
                      ,NVL(a.val_minimo,0)
                      ,NVL(a.val_maximo,0)
                       ,'A'-- tipo cargo [ Automatico o Manual ]
                      ,'1'-- numero unidades
                        ,'1'-- ind. equipo
                      ,'0'-- ind. paquete
                      ,b.mes_garantia
                      ,'0'-- ind. accesorio
                      ,'0'-- cod. articulo
                      ,'0'-- cod. stock
                      ,'0'-- cod. estado
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT w.cod_categoria categoria
                      FROM ve_catplantarif v, ve_categorias w
                      WHERE v.cod_plantarif = EV_plantarif
                        AND v.cod_categoria = w.cod_categoria) z
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND a.cod_modventa = EN_modventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = EN_indrecambio-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = z.categoria
                  AND a.cod_uso <> EN_codusoprepago-- constante (3)
                  AND b.ind_equiacc = EV_indequipo
                  AND a.IND_RENOVA=CN_CERO;

             IF (LN_contador = 0) THEN
                RAISE no_data_found_cursor;
             END IF;

             EXCEPTION
                 WHEN no_data_found_cursor THEN
                       SN_cod_retorno:= 99;--SQLCODE;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_PreCarSimcard_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                                    ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                    ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_PreCarSimcard_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=SQLCODE;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_PreCarSimcard_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                                    ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                    ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_PreCarSimcard_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
        END VE_PreCarSimcard_NoPreLis_PR;

        PROCEDURE VE_PreCarTerminal_NoPreLis_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                                  EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                                EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                                EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                                EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                                EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                                  EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                                EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_PreCarTerminal_NoPreLis_PR"
            Lenguaje="PL/SQL"
            Fecha="05-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Obtiene precio cargo de terminal. No Precio de Lista.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
            ...
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
             no_data_found_cursor      EXCEPTION;
             LV_des_error ge_errores_pg.DesEvent;
             LV_sSql      ge_errores_pg.vQuery;
             LN_contador NUMBER;
        BEGIN

               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';


             LV_sSql:= 'SELECT  b.cod_conceptoart'
                    ||',b.des_articulo'
                    ||',a.prc_venta'
                    ||',a.cod_moneda'
                    ||',c.des_moneda'
                    ||',NVL(a.val_minimo,0)'
                    ||',NVL(a.val_maximo,0)'
                    ||',''A'' '
                    ||',''1'' '
                    ||',''1'' '
                    ||',''0'' '
                    ||',b.mes_garantia'
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||',''0'' '
                    ||'FROM al_precios_venta a'
                    ||    ',al_articulos b'
                    ||    ',ge_monedas c'
                    ||    ',(SELECT w.cod_categoria categoria'
                    ||      'FROM ve_catplantarif v, ve_categorias w'
                    ||      'WHERE v.cod_plantarif ='|| EV_plantarif
                    ||        'AND v.cod_categoria = w.cod_categoria) z'
                    ||    ',(SELECT p.num_meses meses '
                    ||      'FROM ga_percontrato p'
                    ||      'WHERE p.cod_producto > 0'
                    ||        'AND p.cod_tipcontrato = '||EV_tipocontrato||') xy'
                    ||'WHERE A.tip_stock = '||EN_tipstock
                    ||'AND a.cod_articulo = '||EN_codarticulo
                    ||'AND a.cod_uso = '||EN_codusoventa
                    ||'AND a.cod_estado = '||EN_codestado
                    ||'AND a.cod_modventa = '||EN_modventa
                    ||'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)'
                    ||'AND b.cod_articulo = a.cod_articulo'
                    ||'AND c.cod_moneda = a.cod_moneda'
                    ||'AND a.ind_recambio = '||EN_indrecambio
                    ||'AND a.num_meses = xy.meses'
                    ||'AND a.cod_categoria = z.categoria'
                    ||'AND a.cod_uso <> '||EN_codusoprepago
                    ||'AND b.ind_equiacc = '||EV_indequipo;



             LN_contador := 0;
             SELECT COUNT(1)
             INTO LN_contador
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT w.cod_categoria categoria
                      FROM ve_catplantarif v, ve_categorias w
                      WHERE v.cod_plantarif = EV_plantarif
                        AND v.cod_categoria = w.cod_categoria) z
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND a.cod_modventa = EN_modventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = EN_indrecambio-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = z.categoria
                  AND a.cod_uso <> EN_codusoprepago-- constante (3)
                  AND b.ind_equiacc = EV_indequipo -- cisntante (E)
                  AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
                SELECT b.cod_conceptoart
                      ,b.des_articulo
                      ,a.prc_venta
                      ,a.cod_moneda
                      ,c.des_moneda
                      ,NVL(a.val_minimo,0)
                      ,NVL(a.val_maximo,0)
                       ,'A'-- tipo cargo [ Automatico o Manual ]
                      ,'1'-- numero unidades
                        ,'1'-- ind. equipo
                      ,'0'-- ind. paquete
                      ,b.mes_garantia
                      ,'0'-- ind. accesorio
                      ,'0'-- cod. articulo
                      ,'0'-- cod. stock
                      ,'0'-- cod. estado
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT w.cod_categoria categoria
                      FROM ve_catplantarif v, ve_categorias w
                      WHERE v.cod_plantarif = EV_plantarif
                        AND v.cod_categoria = w.cod_categoria) z
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND a.cod_modventa = EN_modventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = EN_indrecambio-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = z.categoria
                  AND a.cod_uso <> EN_codusoprepago-- constante (3)
                  AND b.ind_equiacc = EV_indequipo;

             IF (LN_contador = 0) THEN
                RAISE no_data_found_cursor;
             END IF;

             EXCEPTION
                     WHEN no_data_found_cursor THEN
                           SN_cod_retorno:=99;--SQLCODE;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_PreCarTerminal_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                        ||EN_codusoventa||','||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                        ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo|| ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_PreCarTerminal_NoPreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
                     WHEN OTHERS THEN
                           SN_cod_retorno:=SQLCODE;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_PreCarTerminal_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                        ||EN_codusoventa||','||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                        ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo|| ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.VE_PreCarTerminal_NoPreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
        END VE_PreCarTerminal_NoPreLis_PR;

        PROCEDURE VE_precio_cargo_servsupl_PR(EV_codproducto     IN VARCHAR2,
                                              EV_codservicio     IN VARCHAR2,
                                              EV_codplanserv     IN VARCHAR2,
                                              EV_codactuacion     IN VARCHAR2,
                                              SC_cursordatos     OUT NOCOPY REFCURSOR,
                                               SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_busca_precio_cargo_servsupl_PR"
            Lenguaje="PL/SQL"
            Fecha="09-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Consulta datos de una serie especifica
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
            <param nom="EV_codcargo"    Tipo="VARCHAR2"> codigo del cargo</param>
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            no_data_found_cursor      EXCEPTION;
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
            LN_contador NUMBER;
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

             LV_sSql:= 'SELECT '
                      || ' a.cod_concepto'
                      || ' ,c.des_servicio'
                      || ' ,b.imp_tarifa'
                      || ' ,b.cod_moneda'
                      || ' ,d.des_moneda'
                      || ' ,c.ind_autman'
                      || ',''1'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ',''0'' '
                      || ' FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d'
                      || ' WHERE a.cod_producto = '||EV_codproducto
                      || ' AND a.cod_actabo = '||EV_codactuacion
                      || ' AND a.cod_tipserv = '||CV_SERVSUPLEMENTARIO        -- 2
                      || ' AND a.cod_servicio = '||EV_codservicio
                      || ' AND b.cod_producto = a.cod_producto'
                      || ' AND b.cod_actabo = a.cod_actabo'
                      || ' AND b.cod_tipserv = a.cod_tipserv'
                      || ' AND b.cod_servicio = a.cod_servicio'
                      || ' AND b.cod_planserv = '||EV_codplanserv
                      || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)'
                      || ' AND d.cod_moneda = b.cod_moneda'
                      || ' AND c.cod_producto = a.cod_producto'
                      || ' AND c.cod_servicio = a.cod_servicio';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d
            WHERE a.cod_producto = EV_codproducto
              AND a.cod_actabo = EV_codactuacion
              AND a.cod_tipserv = CV_SERVSUPLEMENTARIO
              AND a.cod_servicio = EV_codservicio
              AND b.cod_producto = a.cod_producto
              AND b.cod_actabo = a.cod_actabo
              AND b.cod_tipserv = a.cod_tipserv
              AND b.cod_servicio = a.cod_servicio
              AND b.cod_planserv = EV_codplanserv
              AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
              AND d.cod_moneda = b.cod_moneda
              AND c.cod_producto = a.cod_producto
              AND c.cod_servicio = a.cod_servicio
              AND ROWNUM <= 1;

              OPEN SC_cursordatos FOR
            SELECT
                 a.cod_concepto
                ,c.des_servicio
                ,b.imp_tarifa
                ,b.cod_moneda
                ,d.des_moneda
                ,c.ind_autman-- tipo cargo [ Automatico o Manual ]
                ,'1'-- numero unidades
                ,'0'-- ind. equipo
                ,'0'-- ind. paquete
                ,'0'-- mes garantia
                ,'0'-- ind. accesorio
                ,'0'-- cod. articulo
                ,'0'-- cod. stock
                ,'0'-- cod. estado
            FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d
            WHERE a.cod_producto = EV_codproducto
              AND a.cod_actabo = EV_codactuacion
              AND a.cod_tipserv = CV_SERVSUPLEMENTARIO        -- 2
              AND a.cod_servicio = EV_codservicio
              AND b.cod_producto = a.cod_producto
              AND b.cod_actabo = a.cod_actabo
              AND b.cod_tipserv = a.cod_tipserv
              AND b.cod_servicio = a.cod_servicio
              AND b.cod_planserv = EV_codplanserv
              AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
              AND d.cod_moneda = b.cod_moneda
              AND c.cod_producto = a.cod_producto
              AND c.cod_servicio = a.cod_servicio;

            IF (LN_contador = 0) THEN
               RAISE no_data_found_cursor;
            END IF;

         EXCEPTION
             WHEN no_data_found_cursor THEN
                   SN_cod_retorno:=99;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servsupl_PR(' || EV_codservicio || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servsupl_PR('||EV_codservicio||')', LV_sSql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servsupl_PR(' || EV_codservicio || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servsupl_PR('||EV_codservicio||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_precio_cargo_servsupl_PR;

        PROCEDURE VE_consulta_categ_ptarif_PR(EV_plantarif       IN ta_plantarif.cod_plantarif%TYPE,
                                              SV_codcategoria    OUT NOCOPY ve_catplantarif.cod_categoria%TYPE,
                                              SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VVE_consulta_categ_ptarif_PR
            Lenguaje="PL/SQL"
            Fecha="30-03-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Consulta categoria de un plan tarifario.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_plantarif"          Tipo="VARCHAR2"> codigo plan tarifario a consultar</param>
        </Entrada>
        <Salida>
            <param nom="SV_codcategoria" Tipo="VARCHAR2"> codigo categoria plan tarifario </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
             LV_Sql      ge_errores_pg.vQuery;
             LV_des_error ge_errores_pg.DesEvent;
        BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_sql:= 'SELECT catplan.cod_categoria'
                      || ' FROM   ve_catplantarif catplan'
                      || ' WHERE    catplan.cod_plantarif=' || EV_plantarif;

             SELECT catplan.cod_categoria
             INTO     SV_codcategoria
             FROM   ve_catplantarif catplan
             WHERE    catplan.cod_plantarif= EV_plantarif;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                       SN_cod_retorno:=1;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG. VE_consulta_categ_ptarif_PR(' || EV_plantarif || ');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG. VE_consulta_categ_ptarif_PR('||EV_plantarif||')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG. VE_consulta_categ_ptarif_PR(' || EV_plantarif || ');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG. VE_consulta_categ_ptarif_PR('||EV_plantarif||')', LV_Sql, SQLCODE, LV_des_error );
        END  VE_consulta_categ_ptarif_PR;

         PROCEDURE VE_obtiene_parametro_fact_PR(EV_nomparametro   IN ged_parametros.nom_parametro%TYPE,
                                               SV_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_parametro_fact_PR"
            Lenguaje="PL/SQL"
            Fecha="11-04-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna el valor del parametro
        </Descripcion>
        <Parametros>
        <Entrada> NA </Entrada>
        <Salida> NA </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:='SELECT parametros.' || EV_nomparametro
                 || ' FROM    fa_datosgener parametros';

                 EXECUTE IMMEDIATE LV_Sql INTO SV_valparametro;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                     SN_cod_retorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                 END IF;
                 LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_parametro_fact_PR('||EV_nomparametro||');- ' || SQLERRM;
                 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_parametro_fact_PR(' || EV_nomparametro || ')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                     SN_cod_retorno:=156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                 END IF;
                 LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_parametro_fact_PR('||EV_nomparametro||');- ' || SQLERRM;
                 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_parametro_fact_PR(' || EV_nomparametro || ')', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_parametro_fact_PR;

        PROCEDURE VE_obtiene_codpromedio_fact_PR(EN_valpromfact   IN al_promfact.fact_desde%TYPE,
                                                 SN_codpromedio   OUT NOCOPY al_promfact.cod_promedio%TYPE,
                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_codpromedio_fact_PR"
            Lenguaje="PL/SQL"
            Fecha="11-04-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna el valor del parametro
        </Descripcion>
        <Parametros>
        <Entrada> NA </Entrada>
        <Salida> NA </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:='SELECT promfact.cod_promedio'
                 || ' FROM al_promfact promfact'
                 || ' WHERE ' || EN_valpromfact || ' BETWEEN promfact.fact_desde AND promfact.fact_hasta';

             SELECT promfact.cod_promedio
             INTO  SN_codpromedio
             FROM al_promfact promfact
             WHERE  EN_valpromfact BETWEEN promfact.fact_desde AND promfact.fact_hasta;

             EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                     SN_cod_retorno:=1;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno:=CV_error_no_clasif;
                     END IF;
                     LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codpromedio_fact_PR('||EN_valpromfact||');- ' || SQLERRM;
                     SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codpromedio_fact_PR('||EN_valpromfact||')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                     SN_cod_retorno:=156;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno:=CV_error_no_clasif;
                     END IF;
                     LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codpromedio_fact_PR('||EN_valpromfact||');- ' || SQLERRM;
                     SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codpromedio_fact_PR('||EN_valpromfact||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_codpromedio_fact_PR;

        PROCEDURE VE_promfacturadocliente_PR(EN_indciclo       IN fa_tipdocumen.ind_ciclo%TYPE,
                                             EN_numeromeses    IN NUMBER,
                                             EN_codcliente     IN fa_histdocu.cod_cliente%TYPE,
                                             SN_totalfacturado OUT NOCOPY NUMBER,
                                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
         /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_promfacturadocliente_PR
            Lenguaje="PL/SQL"
            Fecha="11-04-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna promedio de lo facturado por cliente
        </Descripcion>
        <Parametros>
        <Entrada> NA </Entrada>
        <Salida> NA </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:='SELECT ROUND(SUM(tot_factura)/DECODE(COUNT(*),0,1,COUNT(*)))'
                || ' FROM fa_histdocu'
                || ' WHERE cod_tipdocum IN'
                || ' (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo =' || EN_indciclo || ') AND'
                || ' fec_emision BETWEEN SYSDATE - (' || EN_numeromeses || ' * 30) AND SYSDATE AND'
                || ' cod_cliente = ' || EN_codcliente;

            SELECT ROUND(SUM(tot_factura)/DECODE(COUNT(*),0,1,COUNT(*)))
            INTO SN_totalfacturado
            FROM fa_histdocu
            WHERE cod_tipdocum IN
            (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = EN_indciclo) AND
            fec_emision BETWEEN SYSDATE - (EN_numeromeses * 30) AND SYSDATE AND
            cod_cliente = EN_codcliente;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_promfacturadocliente_PR(' || EN_indciclo || ');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                   'PV_SERVICIOS_POSVENTA_PG.VE_promfacturadocliente_PR(' || EN_indciclo || ')', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_promfacturadocliente_PR(' || EN_indciclo || ');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                   'PV_SERVICIOS_POSVENTA_PG.VE_promfacturadocliente_PR(' || EN_indciclo || ')', LV_Sql, SQLCODE, LV_des_error );
        END VE_promfacturadocliente_PR;

        PROCEDURE VE_valida_codigo_vendedor_PR ( EN_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE,
                                                     SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

         /*
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_valida_codigo_vendedor_PR"
            Lenguaje="PL/SQL"
            Fecha="10-04-2007"
            Version="1.0.0"
            Dise?ador="Mario Tigua"
            Programador="Mario Tigua"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna 1 si el vendedor asociado al codigo de vendedor existe en el sistema, 0 de lo contrario
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_vendedor" Tipo="NUMBER"> codigo vendedor/param>
        </Entrada>
        <Salida>
                   <param nom="SB_RESULTADO" Tipo="PLS_INTEGER">resultado de la consulta</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>

         */
            LV_resultado  VARCHAR2(1);
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
            LN_contador NUMBER;
        BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

            LV_sSql:= 'SELECT 1'--'SELECT ''' || '1' || ''''
                     || 'FROM   VE_VENDEDORES'
                     || 'WHERE COD_VENDEDOR = '||EN_cod_vendedor
                     || 'AND VE_INDBLOQUEO !='|| CN_INDBLOQUEO
                     || 'AND COD_ESTADO ='|| CN_ESTADO;

            SELECT '1'
            INTO LV_resultado
            FROM VE_VENDEDORES
            WHERE COD_VENDEDOR = EN_cod_vendedor
            AND VE_INDBLOQUEO != CN_INDBLOQUEO
            AND COD_ESTADO = CN_ESTADO;
            --SN_resultado:= 1;
            SN_resultado:= LV_resultado;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_resultado:= 0;
                SN_cod_retorno:=4;
                --SV_mens_retorno:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR ;- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR(' || EN_cod_vendedor || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR('||EN_cod_vendedor||')', LV_sSql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_resultado:= 0;
                SN_cod_retorno:=4;
                --SV_mens_retorno:='OTHERS:PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR ;- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR(' || EN_cod_vendedor || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.SE_valida_codigo_vendedor_PR('||EN_cod_vendedor||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_valida_codigo_vendedor_PR;

        PROCEDURE VE_consulta_ciclo_fact_PR(EN_cod_ciclo    IN  ge_clientes.cod_ciclo%TYPE,
                                             SN_cod_ciclfact OUT NOCOPY fa_ciclfact.cod_ciclfact%TYPE,
                                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

         /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_consulta_ciclo_fact_PR
            Lenguaje="PL/SQL"
            Fecha="19-04-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna ciclo facturacion, segun ciclo asociado al cliente
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_ciclo"    Tipo="NUMBER"> codigo ciclo asociado a cliente/param>
        </Entrada>
        <Salida>
                   <param nom="SN_cod_ciclfact" Tipo="NUMBER"> codigo ciclo facturacion encontrado </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:='SELECT ciclofact.cod_ciclfact'
                || ' FROM fa_ciclfact ciclofact'
                || ' WHERE ciclofact.cod_ciclo =' ||  EN_cod_ciclo
                || ' AND SYSDATE BETWEEN ciclofact.fec_desdeocargos AND NVL(ciclofact.fec_hastaocargos, SYSDATE)';

            SELECT ciclofact.cod_ciclfact
            INTO SN_cod_ciclfact
            FROM fa_ciclfact ciclofact
            WHERE ciclofact.cod_ciclo = EN_cod_ciclo
            AND SYSDATE BETWEEN ciclofact.fec_desdeocargos AND NVL(ciclofact.fec_hastaocargos, SYSDATE);

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_ciclo_fact_PR(' || EN_cod_ciclo || ');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                   'PV_SERVICIOS_POSVENTA_PG.VE_consulta_ciclo_fact_PR('||EN_cod_ciclo||')', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_ciclo_fact_PR(' || EN_cod_ciclo || ');- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                   'PV_SERVICIOS_POSVENTA_PG.VE_consulta_ciclo_fact_PR('||EN_cod_ciclo||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_consulta_ciclo_fact_PR;

        PROCEDURE VE_obtiene_formas_pago_PR ( EV_cod_orden    IN  ged_parametros.cod_producto%TYPE,
                                                EV_planfreedom      IN VARCHAR,
                                              EV_cattribcliente      IN VARCHAR,
                                                SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_formas_pago_PR"
            Lenguaje="PL/SQL"
            Fecha="25-04-2007"
            Version="1.0.0"
            Dise?ador="Mario Tigua"
            Programador="Mario Tigua"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Recupera formas de pago para la venta
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_cod_orden"    Tipo="NUMBER"> codigo ciclo asociado a cliente/param>
            <param nom="EV_planfreedom"    Tipo="VARCHAR">valor que indica si la venta tiene planes freedom /param>
            <param nom="EV_cattribcliente"    Tipo="VARCHAR">categoria tributaria del cliente/param>
        </Entrada>
        <Salida>
            <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con formas de pago seleccionados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            no_data_found_cursor               EXCEPTION;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_Modulo VARCHAR (20);
            LV_NomTabla VARCHAR (20);
            LV_NomColumna VARCHAR (20);
            LN_contador NUMBER;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_Modulo := 'GA';
            LV_NomTabla := 'CO_TIPVALOR_FREED';
            LV_NomColumna := 'TIP_VALOR';
            LN_contador := 0;
            LV_Sql := 'SELECT a.tip_valor, a.des_tipvalor ';

            IF (EV_planfreedom = 'TRUE') THEN
                LV_Sql := LV_Sql || ' FROM co_tipvalor a, ged_codigos b ';
                LV_Sql := LV_Sql || ' WHERE b.cod_modulo = ''' || LV_Modulo || '''';
                LV_Sql := LV_Sql || ' AND b.nom_tabla = '''  || LV_NomTabla || '''';
                LV_Sql := LV_Sql || ' AND b.nom_columna = '''  || LV_NomColumna || '''';

                IF (EV_cattribcliente = 'BOLETA' AND  EV_cod_orden IS NOT NULL ) THEN
                   LV_Sql := LV_Sql || ' AND a.tip_valor = '|| EV_cod_orden;
                    SELECT COUNT(1)
                     INTO LN_contador
                     FROM co_tipvalor a, ged_codigos b
                       WHERE b.cod_modulo = LV_Modulo
                         AND b.nom_tabla = LV_NomTabla
                         AND b.nom_columna = LV_NomColumna
                         AND a.tip_valor = EV_cod_orden
                         AND ROWNUM <= 1; --reduce costo de la consulta
                ELSE
                    SELECT COUNT(1)
                     INTO LN_contador
                     FROM co_tipvalor a, ged_codigos b
                       WHERE b.cod_modulo = LV_Modulo
                         AND b.nom_tabla = LV_NomTabla
                         AND b.nom_columna = LV_NomColumna
                         AND ROWNUM <= 1; --reduce costo de la consulta
                END IF;
            ELSE
                LV_Sql := LV_Sql || ' FROM co_tipvalor a ';

                IF (EV_cattribcliente = 'BOLETA' AND EV_cod_orden IS NOT NULL) THEN
                      LV_Sql := LV_Sql || ' WHERE a.tip_valor = '|| EV_cod_orden;
                     SELECT COUNT(1)
                     INTO LN_contador
                     FROM co_tipvalor a
                       WHERE a.tip_valor = EV_cod_orden
                         AND ROWNUM <= 1;
                ELSE
                     SELECT COUNT(1)
                     INTO LN_contador
                     FROM co_tipvalor a
                       WHERE ROWNUM <= 1;

                END IF;
            END IF;

            OPEN SC_cursordatos FOR LV_Sql;

            IF (LN_contador = 0) THEN
               RAISE no_data_found_cursor;
            END IF;

        EXCEPTION
            WHEN no_data_found_cursor THEN
                SN_cod_retorno:=99;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_formas_pago_PR(' || EV_cod_orden || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_formas_pago_PR('||EV_cod_orden||')', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_formas_pago_PR(' || EV_cod_orden || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_formas_pago_PR('||EV_cod_orden||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_formas_pago_PR;

        PROCEDURE VE_obtiene_descuento_art_PR(EV_cod_operacion     IN  gad_descuentos.cod_operacion%TYPE,
                                                 EV_tip_contactual    IN  gad_descuentos.tip_contrato_actual%TYPE,
                                              EN_num_mesesactual   IN  gad_descuentos.num_meses_actual%TYPE,
                                              EV_cod_antiguedad       IN  gad_descuentos.cod_antiguedad%TYPE,
                                              EN_cod_promediofact  IN  gad_descuentos.cod_promfact%TYPE,
                                              EV_cod_estadodev       IN  gad_descuentos.cod_estado_dev%TYPE,
                                              EV_cod_tipcontnuevo  IN  gad_descuentos.cod_tipcontrato_nuevo%TYPE,
                                              EN_num_mesesnuevo       IN  gad_descuentos.num_meses_nuevo%TYPE,
                                              EN_cod_articulo      IN  gad_descuentos.cod_articulo%TYPE,
                                              EV_clase_descuento   IN  gad_descuentos.clase_descuento%TYPE,
                                              SC_cursordatos       OUT NOCOPY REFCURSOR,
                                               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_descuento_art_PR
                Lenguaje="PL/SQL"
                Fecha="24-04-2007"
                Version="1.0.0"
                Dise?ador="Hector Hermosilla"
                Programador="Hector Hermosilla"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Consulta descuentos tipo articulo asociado a los cargos de la venta
                de tipo Articulo (ART segun VB)
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_cod_operacion" Tipo="VARCHAR2"> codigo operacion, cambio serie, restitucion, anulacion.</param>
                <param nom="EV_tip_contactual"    Tipo="VARCHAR2"> tipo de contrato</param>
                <param nom="EN_num_mesesactual"    Tipo="NUMBER"> numero de meses actuales</param>
                <param nom="EV_cod_antiguedad    Tipo="VARCHAR2"> codigo de antiguedad/param>
                <param nom="EN_cod_promediofact"    Tipo="NUMBER"> promedio de facturacion</param>
                <param nom="EV_cod_estadodev"    Tipo="VARCHAR2"> estado de devolucion</param>
                <param nom="EV_cod_tipcontnuevo"    Tipo="VARCHAR2"> contrato nuevo</param>
                <param nom="EN_num_mesesnuevo"    Tipo="NUMBER"> numero de meses nuevos</param>
                <param nom="EN_cod_articulo"    Tipo="NUMBER"> codigo articulo</param>
                <param nom="EV_clase_descuento"    Tipo="VARCHAR2"> Clasificacion del registro: Dscto por articulo o dscto por concepto facturable</param>

            </Entrada>
            <Salida>
                   <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con descuentos de cargos basicos encontrados </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
            no_data_found_cursor               EXCEPTION;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_concepto   VARCHAR2(4);
            LN_contador NUMBER;
        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_Sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
                      || ' descuentos.val_descuento, descuentos.cod_concepto_dscto'
                      || ' FROM   gad_descuentos descuentos'
                      || ' WHERE  descuentos.cod_operacion = ''' || EV_cod_operacion || ''''
                      || ' AND    descuentos.tip_contrato_actual = ''' || EV_tip_contactual || ''''
                      || ' AND    descuentos.num_meses_actual = ' || EN_num_mesesactual
                      || ' AND    NVL(descuentos.cod_antiguedad,'' '') = ''' || EV_cod_antiguedad || ''''
                      || ' AND    descuentos.cod_promfact = ' || EN_cod_promediofact
                      || ' AND    NVL(descuentos.cod_estado_dev,'' '') = ''' || EV_cod_estadodev || ''''
                      || ' AND    descuentos.cod_tipcontrato_nuevo = '''|| EV_cod_tipcontnuevo || ''''
                      || ' AND    descuentos.num_meses_nuevo = '|| EN_num_mesesnuevo;

            IF (EN_cod_articulo IS NULL) THEN
               LV_Sql := LV_Sql || ' AND descuentos.cod_articulo IS NULL';
                    SELECT COUNT(1)
                 INTO LN_contador
                 FROM   gad_descuentos descuentos
                 WHERE  descuentos.cod_operacion = EV_cod_operacion
                  AND    descuentos.tip_contrato_actual = EV_tip_contactual
                  AND    descuentos.num_meses_actual = EN_num_mesesactual
                  AND    NVL(descuentos.cod_antiguedad,' ') = EV_cod_antiguedad
                  AND    descuentos.cod_promfact = EN_cod_promediofact
                  AND    NVL(descuentos.cod_estado_dev,' ') = EV_cod_estadodev
                  AND    descuentos.cod_tipcontrato_nuevo = EV_cod_tipcontnuevo
                  AND    descuentos.num_meses_nuevo = EN_num_mesesnuevo
                  AND descuentos.cod_articulo IS NULL
                  AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)
                  AND descuentos.clase_descuento = EV_clase_descuento
                  AND ROWNUM <= 1;
               ELSE
               LV_Sql := LV_Sql || ' AND descuentos.cod_articulo = ' || EN_cod_articulo;
                   SELECT COUNT(1)
                 INTO LN_contador
                 FROM   gad_descuentos descuentos
                 WHERE  descuentos.cod_operacion = EV_cod_operacion
                  AND    descuentos.tip_contrato_actual = EV_tip_contactual
                  AND    descuentos.num_meses_actual = EN_num_mesesactual
                  AND    NVL(descuentos.cod_antiguedad,' ') = EV_cod_antiguedad
                  AND    descuentos.cod_promfact = EN_cod_promediofact
                  AND    NVL(descuentos.cod_estado_dev,' ') = EV_cod_estadodev
                  AND    descuentos.cod_tipcontrato_nuevo = EV_cod_tipcontnuevo
                  AND    descuentos.num_meses_nuevo = EN_num_mesesnuevo
                  AND descuentos.cod_articulo = EN_cod_articulo
                  AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)
                  AND descuentos.clase_descuento = EV_clase_descuento
                  AND ROWNUM <= 1;
            END IF;
            LV_Sql := LV_Sql || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)'
                      || ' AND descuentos.clase_descuento = ''' || EV_clase_descuento || '''';

            OPEN SC_cursordatos FOR LV_Sql;

            IF (LN_contador = 0) THEN
               RAISE no_data_found_cursor;
            END IF;

         EXCEPTION
                 WHEN no_data_found_cursor THEN
                       SN_cod_retorno:=99;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_art_PR('||EV_cod_operacion||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_art_PR('||EV_cod_operacion||')', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                       SN_cod_retorno:=156;
                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                           SV_mens_retorno:=CV_error_no_clasif;
                      END IF;
                      LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_art_PR('||EV_cod_operacion||');- ' || SQLERRM;
                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                      'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_art_PR('||EV_cod_operacion||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_descuento_art_PR;

PROCEDURE VE_obtiene_descuento_con_PR(EV_cod_operacion     IN  gad_descuentos.cod_operacion%TYPE,
                                                    EV_cod_antiguedad      IN  gad_descuentos.cod_antiguedad%TYPE,
                                                 EV_cod_tipcontnuevo  IN  gad_descuentos.cod_tipcontrato_nuevo%TYPE,
                                                 EN_num_mesesnuevo      IN  gad_descuentos.num_meses_nuevo%TYPE,
                                                 EN_ind_vtaexterna      IN  gad_descuentos.ind_vta_externa%TYPE,
                                                 EN_cod_vendealer      IN  gad_descuentos.cod_vendealer%TYPE,
                                                 EV_cod_causadscto      IN  gad_descuentos.cod_causa_dscto%TYPE,
                                                 EV_cod_categoria      IN  gad_descuentos.cod_categoria%TYPE,
                                                 EN_cod_modventa      IN  gad_descuentos.cod_modventa%TYPE,
                                                 EN_tip_producto      IN  gad_descuentos.tip_producto%TYPE,
                                                 EN_cod_concepto      IN  gad_descuentos.cod_concepto%TYPE,
                                                 EV_clase_descuento   IN  gad_descuentos.clase_descuento%TYPE,
                                                 EN_IND_RENOVA        IN  gad_descuentos.IND_RENOVA%TYPE,
                                                 EV_NUMABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                 SC_cursordatos          OUT NOCOPY REFCURSOR,
                                                  SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_descuento_con_PR"
                Lenguaje="PL/SQL"
                Fecha="24-04-2007"
                Version="1.0.0"
                Dise?ador="Hector Hermosilla"
                Programador="Hector Hermosilla"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Consulta descuentos tipo concepto
                de tipo Concepto
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_cod_operacion"     Tipo="VARCHAR2"> codigo operacion, cambio serie, restitucion, anulacion.</param>
                <param nom="EV_cod_antiguedad"    Tipo="VARCHAR2"> codigo de antiguedad/param>
                <param nom="EV_cod_tipcontnuevo"  Tipo="VARCHAR2"> tipo de contrato</param>
                <param nom="EN_num_mesesnuevo"    Tipo="NUMBER"> numero de meses nuevo</param>
                <param nom="EN_ind_vtaexterna"    Tipo="NUMBER"> indicador de vendedor interno o externo/param>
                <param nom="EN_cod_vendealer"     Tipo="NUMBER"> digo de vendedor externo</param>
                <param nom="EV_cod_causadscto"    Tipo="VARCHAR2"> otivo de descuento</param>
                <param nom="EV_cod_categoria      Tipo="VARCHAR2"> categoria del plan</param>
                <param nom="EN_cod_modventa"      Tipo="NUMBER"> Codigo de modalidad de venta</param>
                <param nom="EN_tip_producto"      Tipo="NUMBER"> Tipo de producto asociado al concepto de descuento: Prepago, Pospago, Hibrido/param>
                <param nom="EN_cod_concepto"      Tipo="NUMBER"> Codigo de concepto facturable de tipo cargos</param>
                <param nom="EV_clase_descuento"   Tipo="VARCHAR2"> Clasificacion del registro: Dscto por articulo o dscto por concepto facturable</param>

            </Entrada>
            <Salida>
                   <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con descuentos de cargos basicos encontrados </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
            no_data_found_cursor               EXCEPTION;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_concepto     VARCHAR2(4);
            LV_tipdescuento gad_descuentos.tip_descuento%TYPE;
            LV_codmoneda    gad_descuentos.cod_moneda%TYPE;
            LN_valdescuento gad_descuentos.val_descuento%TYPE;
            LN_codconcepto  gad_descuentos.cod_concepto_dscto%TYPE;
            LN_contador NUMBER;
            LV_COUNT NUMBER;
            LN_PRISEG gad_descuentos.IND_PRISEG_LIN%TYPE;
            LV_FECHA_MAX GA_ABOCEL.FEC_ALTA%TYPE;
            LV_COD_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
            LV_FEC_ALTA_ABO GA_ABOCEL.FEC_ALTA%TYPE;
            LV_COD_CALIFICACION GE_CLIENTES.COD_CALIFICACION%TYPE;
			lv_sAPLICA_CAL_ABO  GED_PARAMETROS.val_parametro%type;
			lv_sCAL_DEFAULT_PRC GED_PARAMETROS.val_parametro%type;
			
			
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_COUNT:=0;

        --OPEN SC_cursordatos FOR
        --SELECT NULL tip_descuento, NULL cod_moneda, NULL val_descuento, NULL cod_concepto_dscto
        --FROM DUAL
        --WHERE ROWNUM = 0;

             SELECT  COD_CLIENTE,FEC_ALTA
             INTO LV_COD_CLIENTE,LV_FEC_ALTA_ABO
             FROM  GA_ABOCEL
             WHERE NUM_ABONADO =  EV_NUMABONADO
             UNION
             SELECT  COD_CLIENTE,FEC_ALTA
             FROM  GA_ABOAMIST
             WHERE NUM_ABONADO =  EV_NUMABONADO;

             SELECT COD_CALIFICACION
             INTO LV_COD_CALIFICACION
             FROM GE_CLIENTES
             WHERE COD_CLIENTE=LV_COD_CLIENTE;
			 
			 SELECT trim(VAL_PARAMETRO) 
			 into lv_sAPLICA_CAL_ABO
			 FROM GED_PARAMETROS  
			 WHERE  NOM_PARAMETRO = 'APLICA_CAL_ABO' AND COD_MODULO = 'GA';
			 --ocb ini 145193
	  	     If trim(lv_sAPLICA_CAL_ABO) = 'TRUE' Then
						 
					 SELECT trim(VAL_PARAMETRO) 
					 into lv_sCAL_DEFAULT_PRC
					 FROM GED_PARAMETROS 
					 WHERE  NOM_PARAMETRO = 'CAL_DEFAULT_PRC' AND COD_MODULO = 'GA';

					 begin
					 
					 SELECT NVL(COD_CALIFICACION,lv_sCAL_DEFAULT_PRC)
					 into LV_COD_CALIFICACION
					 FROM GA_DATABONADO_TO
					 WHERE NUM_ABONADO =EV_NUMABONADO;
					 
					exception
							when no_data_found then
							   LV_COD_CALIFICACION :=lv_sCAL_DEFAULT_PRC;
					end;
					  
			 Else
					 SELECT COD_CALIFICACION 
					 into LV_COD_CALIFICACION
					 FROM GE_CLIENTES 
					 WHERE COD_CLIENTE = LV_COD_CLIENTE;
				
			 End If;

			 --ocb fin 145193

              IF EN_IND_RENOVA=1 THEN
                     BEGIN

                     SELECT  MAX(FEC_ALTA)
                     INTO LV_FECHA_MAX
                     FROM GA_ABOCEL
                     WHERE COD_CLIENTE=  LV_COD_CLIENTE
                     AND COD_SITUACION ='AAA';

                     EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                    BEGIN

                                    SELECT  MAX(FEC_ALTA)
                                    INTO LV_FECHA_MAX
                                    FROM GA_ABOAMIST
                                    WHERE COD_CLIENTE=  LV_COD_CLIENTE
                                    AND COD_SITUACION ='AAA';

                                    EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                              LV_FECHA_MAX:= NULL;


                                    END;
                     END;

                     IF LV_FECHA_MAX IS NULL THEN
                             LN_PRISEG:=1;
                     ELSE
                        IF  (LV_FEC_ALTA_ABO >= LV_FECHA_MAX) THEN
                             --PRIMERA LINEA
                             LN_PRISEG:=1;
                        ELSE
                             --SEGUNDA LINEA
                             LN_PRISEG:=2;
                        END IF;
                     END IF;
              ELSE
                  LN_PRISEG:=0;
              END IF;





        LV_Sql := 'SELECT COUNT(1)'
                      || ' FROM   gad_descuentos descuentos'
                      || ' WHERE  descuentos.cod_operacion = ''' || EV_cod_operacion || ''''
                      || ' AND descuentos.cod_antiguedad = ''' || EV_cod_antiguedad  || ''''
                      || ' AND descuentos.cod_tipcontrato_nuevo = ''' || EV_cod_tipcontnuevo || ''''
                      || ' AND descuentos.num_meses_nuevo = ' || EN_num_mesesnuevo
                      || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, sysdate)'
                      || ' AND descuentos.ind_vta_externa       = ' || EN_ind_vtaexterna;
            IF (EN_ind_vtaexterna = 1) THEN
               LV_Sql := LV_Sql || ' AND descuentos.cod_vendealer = ' || EN_cod_vendealer;
            END IF;
            LV_Sql := LV_Sql || ' AND descuentos.cod_causa_dscto = ''' || EV_cod_causadscto || ''''
                      || ' AND descuentos.cod_categoria         = ''' || EV_cod_categoria || ''''
                      || ' AND descuentos.cod_modventa          = ' || EN_cod_modventa
                      || ' AND descuentos.tip_producto          = ' || EN_tip_producto
                      || ' AND descuentos.cod_concepto          = ' || EN_cod_concepto
                      || ' AND descuentos.clase_descuento       = ''' || EV_clase_descuento || ''''
                      || ' AND descuentos.cod_calificacion=''' || LV_COD_CALIFICACION || ''''
                      || ' AND descuentos.ind_renova=' || EN_IND_RENOVA
                      || ' AND descuentos.ind_priseg_lin=' || LN_PRISEG;


            EXECUTE IMMEDIATE LV_Sql INTO LV_COUNT;


           IF LV_COUNT<>0 THEN

               LV_Sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
                      || ' descuentos.val_descuento, descuentos.cod_concepto_dscto'
                      || ' FROM   gad_descuentos descuentos'
                      || ' WHERE  descuentos.cod_operacion = ''' || EV_cod_operacion || ''''
                      || ' AND descuentos.cod_antiguedad = ''' || EV_cod_antiguedad  || ''''
                      || ' AND descuentos.cod_tipcontrato_nuevo = ''' || EV_cod_tipcontnuevo || ''''
                      || ' AND descuentos.num_meses_nuevo = ' || EN_num_mesesnuevo
                      || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, sysdate)'
                      || ' AND descuentos.ind_vta_externa       = ' || EN_ind_vtaexterna;
               IF (EN_ind_vtaexterna = 1) THEN
                   LV_Sql := LV_Sql || ' AND descuentos.cod_vendealer = ' || EN_cod_vendealer;
               END IF;
               LV_Sql := LV_Sql || ' AND descuentos.cod_causa_dscto = ''' || EV_cod_causadscto || ''''
                      || ' AND descuentos.cod_categoria         = ''' || EV_cod_categoria || ''''
                      || ' AND descuentos.cod_modventa          = ' || EN_cod_modventa
                      || ' AND descuentos.tip_producto          = ' || EN_tip_producto
                      || ' AND descuentos.cod_concepto          = ' || EN_cod_concepto
                      || ' AND descuentos.clase_descuento       = ''' || EV_clase_descuento || ''''
                      || ' AND descuentos.cod_calificacion=''' || LV_COD_CALIFICACION || ''''
                      || ' AND descuentos.ind_renova=' || EN_IND_RENOVA
                      || ' AND descuentos.ind_priseg_lin=' || LN_PRISEG;


            OPEN SC_CURSORDATOS FOR LV_SQL ;

            ELSIF LV_COUNT=0 THEN
               LV_Sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
                         || ' descuentos.val_descuento, descuentos.cod_concepto_dscto'
                         || ' FROM   gad_descuentos descuentos'
                         || ' WHERE  descuentos.cod_operacion = ''' || EV_cod_operacion || ''''
                         || ' AND descuentos.cod_antiguedad = ''' || EV_cod_antiguedad || ''''
                         || ' AND descuentos.cod_tipcontrato_nuevo = ''' || EV_cod_tipcontnuevo || ''''
                         || ' AND descuentos.num_meses_nuevo = ' || EN_num_mesesnuevo
                         || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)'
                         || ' AND descuentos.ind_vta_externa       = ' || EN_ind_vtaexterna;


               IF (EN_ind_vtaexterna = 1) THEN
                  LV_Sql := LV_Sql || ' AND    descuentos.cod_vendealer is  null';
               END IF;
               LV_Sql := LV_Sql || ' AND descuentos.cod_causa_dscto = ''' || EV_cod_causadscto || ''''
                         || ' AND descuentos.cod_categoria         = ''' || EV_cod_categoria || ''''
                         || ' AND descuentos.cod_modventa          = ' || EN_cod_modventa
                         || ' AND descuentos.tip_producto          = ' || EN_tip_producto
                         || ' AND descuentos.cod_concepto          = ' || EN_cod_concepto
                         || ' AND descuentos.clase_descuento       = ''' || EV_clase_descuento || ''''
                         || ' AND descuentos.cod_calificacion=''' || LV_COD_CALIFICACION || ''''
                         || ' AND descuentos.ind_renova=' || EN_IND_RENOVA
                         || ' AND descuentos.ind_priseg_lin=' || LN_PRISEG;


               IF (EN_ind_vtaexterna = 1) THEN
                   SELECT COUNT(1)
                   INTO LN_contador
                     FROM   gad_descuentos descuentos
                     WHERE  descuentos.cod_operacion = EV_cod_operacion
                     AND descuentos.cod_antiguedad = EV_cod_antiguedad
                     AND descuentos.cod_tipcontrato_nuevo = EV_cod_tipcontnuevo
                     AND descuentos.num_meses_nuevo = EN_num_mesesnuevo
                     AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)
                     AND descuentos.ind_vta_externa = EN_ind_vtaexterna
                     AND descuentos.cod_vendealer IS  NULL
                     AND descuentos.cod_causa_dscto = EV_cod_causadscto
                     AND descuentos.cod_categoria         = EV_cod_categoria
                     AND descuentos.cod_modventa          = EN_cod_modventa
                     AND descuentos.tip_producto          = EN_tip_producto
                     AND descuentos.cod_concepto          = EN_cod_concepto
                     AND descuentos.clase_descuento       = EV_clase_descuento
                     AND descuentos.cod_calificacion= LV_COD_CALIFICACION
                     AND descuentos.ind_renova= EN_IND_RENOVA
                     AND descuentos.ind_priseg_lin= LN_PRISEG
                     AND ROWNUM <= 1;

                     IF (LN_contador = 0) THEN
                       SELECT COUNT(1)
                       INTO LN_contador
                         FROM   gad_descuentos descuentos
                         WHERE  descuentos.cod_operacion = EV_cod_operacion
                         AND descuentos.cod_antiguedad = EV_cod_antiguedad
                         AND descuentos.cod_tipcontrato_nuevo = EV_cod_tipcontnuevo
                         AND descuentos.num_meses_nuevo = EN_num_mesesnuevo
                         AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)
                         AND descuentos.ind_vta_externa = EN_ind_vtaexterna
                         AND descuentos.cod_vendealer = EN_cod_vendealer
                         AND descuentos.cod_causa_dscto = EV_cod_causadscto
                         AND descuentos.cod_categoria         = EV_cod_categoria
                         AND descuentos.cod_modventa          = EN_cod_modventa
                         AND descuentos.tip_producto          = EN_tip_producto
                         AND descuentos.cod_concepto          = EN_cod_concepto
                         AND descuentos.clase_descuento       = EV_clase_descuento
                         AND descuentos.cod_calificacion= LV_COD_CALIFICACION
                         AND descuentos.ind_renova= EN_IND_RENOVA
                         AND descuentos.ind_priseg_lin= LN_PRISEG
                         AND ROWNUM <= 1;
                       END IF;
               ELSE
                   SELECT COUNT(1)
                   INTO LN_contador
                     FROM   gad_descuentos descuentos
                     WHERE  descuentos.cod_operacion = EV_cod_operacion
                     AND descuentos.cod_antiguedad = EV_cod_antiguedad
                     AND descuentos.cod_tipcontrato_nuevo = EV_cod_tipcontnuevo
                     AND descuentos.num_meses_nuevo = EN_num_mesesnuevo
                     AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)
                     AND descuentos.ind_vta_externa = EN_ind_vtaexterna
                       AND descuentos.cod_causa_dscto = EV_cod_causadscto
                     AND descuentos.cod_categoria         = EV_cod_categoria
                     AND descuentos.cod_modventa          = EN_cod_modventa
                     AND descuentos.tip_producto          = EN_tip_producto
                       AND descuentos.cod_concepto          = EN_cod_concepto
                     AND descuentos.clase_descuento       = EV_clase_descuento
                     AND descuentos.cod_calificacion= LV_COD_CALIFICACION
                     AND descuentos.ind_renova= EN_IND_RENOVA
                     AND descuentos.ind_priseg_lin= LN_PRISEG
                     AND ROWNUM <= 1;
               END IF;

               OPEN SC_cursordatos FOR    LV_Sql;

               IF (LN_contador = 0) THEN
                  RAISE no_data_found_cursor;
               END IF;

            END IF;

         EXCEPTION
             WHEN no_data_found_cursor THEN
                   SN_cod_retorno:=99;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;

                  LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_con_PR('||EV_cod_operacion||','
                                ||EV_cod_antiguedad||','||EV_cod_tipcontnuevo||','||EN_num_mesesnuevo||','
                                ||EN_ind_vtaexterna||','||EN_cod_vendealer||','||EV_cod_causadscto||','
                                ||EV_cod_categoria||','||EN_cod_modventa||','||EN_tip_producto||','
                                ||EN_cod_concepto||','||EV_clase_descuento||');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_con_PR('||EV_cod_operacion||')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_con_PR('||EV_cod_operacion||','
                                ||EV_cod_antiguedad||','||EV_cod_tipcontnuevo||','||EN_num_mesesnuevo||','
                                ||EN_ind_vtaexterna||','||EN_cod_vendealer||','||EV_cod_causadscto||','
                                ||EV_cod_categoria||','||EN_cod_modventa||','||EN_tip_producto||','
                                ||EN_cod_concepto||','||EV_clase_descuento||');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_descuento_con_PR('||EV_cod_operacion||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_descuento_con_PR;


        PROCEDURE VE_precio_cargo_servocac_PR(EV_codproducto     IN VARCHAR2,
                                                EV_codarticulo     IN VARCHAR2,
                                                EV_codplantarif     IN VARCHAR2,
                                                EV_codusolinea     IN VARCHAR2,
                                                EV_codmodventa     IN VARCHAR2,
                                                EV_nummeses         IN VARCHAR2,
                                                EV_tipstock        IN VARCHAR2,
                                              EV_indcomodato     IN VARCHAR2,
                                              EV_codactuacion     IN VARCHAR2,
                                              SC_cursordatos     OUT NOCOPY REFCURSOR,
                                               SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_busca_precio_cargo_servocac_PR"
                Lenguaje="PL/SQL"
                Fecha="09-04-2007"
                Version="1.0.0"
                Dise?ador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Obtiene el precio de los servicios ocacionales
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
            </Entrada>
            <Salida>
                   <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_codMoneda   VARCHAR2(20);
            LV_codServHab  VARCHAR2(20);
            no_data_found_cursor               EXCEPTION;
            LN_contador NUMBER;

        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            --  OBTENEMOS EL VALOR PARA CODIOGO MONEDA PESO
            Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_MONEDAPESO,
                                                                CV_MODULO_GA,
                                                                CV_PRODUCTO,
                                                                LV_codMoneda,
                                                                LV_CodeSql,
                                                                LV_ErrmSql,
                                                                LN_NumEvento);

            --  OBTENEMOS EL VALOR PARA SERVICIO HABILITACION
            Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_SERVHABILI,
                                                                CV_MODULO_GA,
                                                                CV_PRODUCTO,
                                                                LV_codServHab,
                                                                LV_CodeSql,
                                                                LV_ErrmSql,
                                                                LN_NumEvento);

             LV_sql:= 'SELECT '
                    ||'a.cod_concepto'
                    || ',c.des_servicio'
                    || ',b.prc_cargo'
                    || ',d.cod_moneda'
                    || ',d.des_moneda'
                    || ',NVL(b.val_minimo,0)'
                    || ',NVL(b.val_maximo,0)'
                    || ',c.ind_autman'
                    || ',''1'' '
                    || ',''0'' '
                    || ',''0'' '
                    || ',''0'' '
                    || ',''0'' '
                    || ',b.ind_venta'
                    || 'FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d'
                    || 'WHERE a.cod_producto = '||EV_codproducto
                    || ' AND a.cod_actabo = '||EV_codactuacion
                    || ' AND a.cod_tipserv = '||CV_SERVOCASIONAL-- constante (1)
                    || ' AND a.cod_servicio = '||LV_codServHab
                    || ' AND b.cod_producto = a.cod_producto'
                    || ' AND b.cod_modventa = '||EV_codmodventa
                    || ' AND b.cod_uso = '||EV_codusolinea
                    || ' AND b.tip_stock = '||EV_tipstock
                    || ' AND b.cod_articulo = '||EV_codarticulo
                    || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)'
                    || ' AND b.cod_categoria IN (SELECT s.cod_categoria'
                    || '                         FROM ve_catplantarif s'
                    || '                           WHERE s.cod_producto = '||EV_codproducto
                    || '                         AND s.cod_plantarif = '||EV_codplantarif||')'
                    || ' AND b.num_meses = '||EV_nummeses
                    -- If DatVenta.Ind_Comodato = "1" Then
                    --     sSql = sSql & " AND B.IND_VENTA = [1]"
                    -- End If
                    || ' AND c.cod_producto = a.cod_producto'
                    || ' AND c.cod_servicio = a.cod_servicio'
                    || ' AND d.cod_moneda = '||LV_codMoneda;

             LN_contador := 0;
             SELECT COUNT(1)
             INTO LN_contador
                FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d
                WHERE a.cod_producto = EV_codproducto
                  AND a.cod_actabo = EV_codactuacion
                  AND a.cod_tipserv = CV_SERVOCASIONAL-- constante (1)
                  AND a.cod_servicio = LV_codServHab
                  AND b.cod_producto = a.cod_producto
                  AND b.cod_modventa = EV_codmodventa
                  AND b.cod_uso = EV_codusolinea
                  AND b.tip_stock = EV_tipstock
                  AND b.cod_articulo = EV_codarticulo
                  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
                  AND b.cod_categoria IN (SELECT s.cod_categoria
                                          FROM ve_catplantarif s
                                          WHERE s.cod_producto = EV_codproducto
                                            AND s.cod_plantarif = EV_codplantarif)
                  AND b.num_meses = EV_nummeses
                -- If DatVenta.Ind_Comodato = "1" Then
                --     sSql = sSql & " AND B.IND_VENTA = [1]"
                -- End If
                  AND c.cod_producto = a.cod_producto
                  AND c.cod_servicio = a.cod_servicio
                  AND d.cod_moneda = LV_codMoneda
                  AND ROWNUM <= 1;

            OPEN SC_cursordatos FOR
            SELECT
                 a.cod_concepto
                ,c.des_servicio
                ,b.prc_cargo
                ,d.cod_moneda
                ,d.des_moneda
                ,NVL(b.val_minimo,0)
                ,NVL(b.val_maximo,0)
                ,c.ind_autman-- tipo cargo [ Automatico o Manual ]
                ,'1'-- numero unidades
                ,'0'-- ind. equipo
                ,'0'-- ind. paquete
                ,'0'-- mes garantia
                ,'0'-- ind. accesorio
                ,b.ind_venta
            FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d
            WHERE a.cod_producto = EV_codproducto
              AND a.cod_actabo = EV_codactuacion
              AND a.cod_tipserv = CV_SERVOCASIONAL-- constante (1)
              AND a.cod_servicio = LV_codServHab
              AND b.cod_producto = a.cod_producto
              AND b.cod_modventa = EV_codmodventa
              AND b.cod_uso = EV_codusolinea
              AND b.tip_stock = EV_tipstock
              AND b.cod_articulo = EV_codarticulo
              AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
              AND b.cod_categoria IN (SELECT s.cod_categoria
                                      FROM ve_catplantarif s
                                      WHERE s.cod_producto = EV_codproducto
                                        AND s.cod_plantarif = EV_codplantarif)
              AND b.num_meses = EV_nummeses
              AND c.cod_producto = a.cod_producto
              AND c.cod_servicio = a.cod_servicio
              AND d.cod_moneda = LV_codMoneda;

         IF (LN_contador = 0) THEN
            RAISE no_data_found_cursor;
         END IF;

         EXCEPTION
            WHEN no_data_found_cursor THEN
                   SN_cod_retorno:=99;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servocac_PR('||EV_codArticulo||');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servocac_PR('||EV_codArticulo||')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servocac_PR('||EV_codArticulo||');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_precio_cargo_servocac_PR('||EV_codArticulo||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_precio_cargo_servocac_PR;

        PROCEDURE VE_obtiene_cat_trib_cliente_PR ( EN_cod_cliente  IN ga_catributclie.cod_cliente%TYPE,
                                                      SV_cat_trib_cliente OUT NOCOPY VARCHAR,
                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
                                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
         /*
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = VE_obtiene_cat_trib_cliente_PR"
            Lenguaje="PL/SQL"
            Fecha="25-04-2007"
            Version="1.0.0"
            Dise?ador="Mario Tigua"
            Programador="Mario Tigua"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna la categoria tributaria del cliente
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_cliente" Tipo="NUMBER">Codigo del cliente>
        </Entrada>
        <Salida>
                   <param nom="SV_cat_trib_cliente" Tipo="VARCHAR">categoria tributaria del cliente</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
         */
             LV_des_error ge_errores_pg.DesEvent;
             LV_sSql      ge_errores_pg.vQuery;
        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_sSql := 'SELECT a.cod_catribut'
            ||'INTO SV_cat_trib_cliente'
            ||'FROM ga_catributclie a'
            ||'WHERE a.cod_cliente = '||EN_cod_cliente
            ||'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';

            SELECT a.cod_catribut
            INTO SV_cat_trib_cliente
            FROM ga_catributclie a
            WHERE a.cod_cliente = EN_cod_cliente
            AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SV_cat_trib_cliente:= NULL;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_cat_trib_cliente_PR('||EN_cod_cliente||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_cat_trib_cliente_PR('||EN_cod_cliente||')', LV_sSql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SV_cat_trib_cliente:= NULL;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_cat_trib_cliente_PR(' || EN_cod_cliente || ');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_cat_trib_cliente_PR('||EN_cod_cliente||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_obtiene_cat_trib_cliente_PR;

        PROCEDURE VE_hay_pfreedom_en_venta_PR ( EV_ind_proporvta IN VARCHAR,
                                                    EN_num_venta IN  NUMBER,
                                                     EN_ind_proporc1 IN NUMBER,
                                                 EN_ind_proporc2 IN NUMBER,
                                                  SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

         /*
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = VE_hay_pfreedom_en_venta_PR"
            Lenguaje="PL/SQL"
            Fecha="25-04-2007"
            Version="1.0.0"
            Dise?ador="Mario Tigua"
            Programador="Mario Tigua"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna 1 si la venta actual tiene planes freedom, 0 de lo contrario
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EV_ind_proporvta" Tipo="VARCHAR">Indicador de proporcionalidad de venta/param>
                <param nom="EN_num_venta" Tipo="NUMBER">Numero de la ventaparam>
                <param nom="EN_ind_proporc1" Tipo="NUMBER">Indicador 1 de proporcionalidad/param>
                <param nom="EN_ind_proporc2" Tipo="NUMBER">Indicador 2 de proporcionalidad/param>
        </Entrada>
        <Salida>
                   <param nom="SN_resultado  Tipo="PLS_INTEGER"> Resultado de la consulta </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
         */

         LV_des_error ge_errores_pg.DesEvent;
         LV_sSql      ge_errores_pg.vQuery;

        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_sSql := 'SELECT 1'
                ||' FROM ga_abocel a, ta_plantarif b'
                ||' WHERE a.num_venta = '||EN_num_venta
                ||' AND a.cod_plantarif = b.cod_plantarif'
                ||' AND b.ind_proporcs IN ('||EN_ind_proporc1||','||EN_ind_proporc2||')';

            IF (EV_ind_proporvta = 'TRUE') THEN
                SELECT 1
                INTO SN_resultado
                FROM ga_abocel a, ta_plantarif b
                WHERE a.num_venta = EN_num_venta
                AND a.cod_plantarif = b.cod_plantarif
                AND b.ind_proporcs IN (EN_ind_proporc1,EN_ind_proporc2);
            ELSE
                SN_resultado:=0;
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_resultado:=0;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_hay_pfreedom_en_venta_PR('||EV_ind_proporvta||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_hay_pfreedom_en_venta_PR('||EV_ind_proporvta||')', LV_sSql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_resultado:=0;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_hay_pfreedom_en_venta_PR('||EV_ind_proporvta||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_hay_pfreedom_en_venta_PR('||EV_ind_proporvta||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_hay_pfreedom_en_venta_PR;

        PROCEDURE VE_consulta_cod_desc_manual_PR(EN_cod_conceptocargo    IN  fa_conceptos.cod_concorig%TYPE,
                                                 EN_cod_tipconce         IN  fa_conceptos.cod_tipconce%TYPE,
                                                  SN_cod_conceptodcto     OUT NOCOPY fa_conceptos.cod_concepto%TYPE,
                                                     SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS
         /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_consulta_cod_desc_manual_PR
            Lenguaje="PL/SQL"
            Fecha="27-04-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna codigo concepto facturable del descuento manual asociado al cargo
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_conceptocargo"   Tipo="NUMBER"> codigo concepto facturable del cargo</param>
                <param nom="EN_cod_tipconce"   Tipo="NUMBER"> codigo tipo concepto buscado, en este caso el descuento/param>
        </Entrada>
        <Salida>
                   <param nom="SN_cod_conceptodcto" Tipo="NUMBER"> codigo concepto facturable del descuento</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:='SELECT conceptofacturable.cod_concepto'
                || ' FROM fa_conceptos conceptofacturable'
                || ' WHERE conceptofacturable.cod_concorig =' || EN_cod_conceptocargo
                || ' AND conceptofacturable.cod_tipconce' || EN_cod_tipconce
                || ' AND ROWNUM = 1';

             SELECT conceptofacturable.cod_concepto
             INTO SN_cod_conceptodcto
             FROM fa_conceptos conceptofacturable
             WHERE conceptofacturable.cod_concorig = EN_cod_conceptocargo
             AND conceptofacturable.cod_tipconce = EN_cod_tipconce
             AND ROWNUM = 1;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_cod_desc_manual_PR('||EN_cod_conceptocargo||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.VE_consulta_cod_desc_manual_PR('||EN_cod_conceptocargo||')', LV_Sql, SQLCODE, LV_des_error );
        END VE_consulta_cod_desc_manual_PR;

        PROCEDURE VE_es_vendedor_externo_PR (EN_cod_vendedor IN ve_vendedores.cod_vendedor%TYPE,
                                             SN_resultado    OUT NOCOPY PLS_INTEGER,
                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
         /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_es_vendedor_externo_PR"
            Lenguaje="PL/SQL"
            Fecha="01-05-2007"
            Version="1.0.0"
            Dise?ador=" Mario Tigua"
            Programador=" Mario Tigua"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
             Restorna 1 si el vendedor es externo (dealer), 0 de lo contrario
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EN_cod_vendedor" Tipo="NUMBER"> Codigo del vendedor </param>
        </Entrada>
        <Salida>
                   <param nom="SN_resultado Tipo="NUMBER"> Resultado de la validacion </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
             LV_sSql      ge_errores_pg.vQuery;
             LV_des_error ge_errores_pg.DesEvent;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            LV_sSql:='SELECT 1'
                ||' FROM ve_vendedores a,ve_tipcomis b'
                ||' WHERE a.cod_tipcomis = b.cod_tipcomis'
                ||' AND a.cod_vendedor = '||EN_cod_vendedor
                ||' AND b.ind_vta_externa ='|| CV_IND_VENTA_EXTERNA;

            SELECT 1
            INTO SN_resultado
            FROM ve_vendedores a,ve_tipcomis b
            WHERE a.cod_tipcomis = b.cod_tipcomis
            AND a.cod_vendedor = EN_cod_vendedor
            AND b.ind_vta_externa = CV_IND_VENTA_EXTERNA;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_resultado:= 0;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_es_vendedor_externo_PR('||EN_cod_vendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.VE_es_vendedor_externo_PR('||EN_cod_vendedor||')', LV_sSql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_resultado:= 0;
                SN_cod_retorno:=4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_es_vendedor_externo_PR('||EN_cod_vendedor||');- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
               'PV_SERVICIOS_POSVENTA_PG.VE_es_vendedor_externo_PR('||EN_cod_vendedor||')', LV_sSql, SQLCODE, LV_des_error );
        END VE_es_vendedor_externo_PR;

        PROCEDURE VE_obtiene_modo_gener_fact_PR(EV_cod_oficina    IN  al_docum_sucursal.cod_oficina%TYPE,
                                                EV_cod_tip_docum  IN  al_docum_sucursal.cod_tipdocum%TYPE,
                                                EV_factura_global IN  VARCHAR2,
                                                EN_documento_guia IN  ge_tipdocumen.cod_tipdocum%TYPE,
                                                EV_tip_foliacion  IN  ge_tipdocumen.tip_foliacion%TYPE,
                                                EN_cod_tipmovimen IN  fa_gencentremi.cod_tipmovimien%TYPE,
                                                EV_cod_cattribut  IN  fa_gencentremi.cod_catribut%TYPE,
                                                EV_flagcentremi   IN  VARCHAR2,
                                                EN_cod_modventa   IN  fa_gencentremi.cod_modventa%TYPE,
                                                SV_cod_modgener   OUT NOCOPY fa_gencentremi.cod_modgener%TYPE,
                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
            Lenguaje="PL/SQL"
            Fecha="02-05-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
            <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
            <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
            <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
            <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
            <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
            <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
            <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
            <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

        </Entrada>
        <Salida>
            <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_SqlAux      ge_errores_pg.vQuery;
            LV_SqlEjecutarc ge_errores_pg.vQuery;
            LV_tip_fol    ge_tipdocumen.tip_foliacion%TYPE;
            LV_tip_doc    ge_tipdocumen.cod_tipdocum%TYPE;
        BEGIN
             SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

             LV_Sql:= 'SELECT centroemision.cod_modgener FROM fa_gencentremi centroemision'
                       || ' WHERE centroemision.cod_centremi ='
                      || ' (SELECT sucursaldocto.cod_centremi FROM al_docum_sucursal sucursaldocto'
                      || ' WHERE sucursaldocto.cod_oficina =: EV_cod_oficina';

             IF (EV_cod_tip_docum  = EV_factura_global) THEN
                 LV_SqlAux:= 'SELECT tipodocumento.tip_foliacion'
                             || ' FROM  ge_tipdocumen tipodocumento'
                             || ' WHERE tipodocumento.cod_tipdocum =   EN_documento_guia';

                 SELECT tipodocumento.tip_foliacion
                 INTO  LV_tip_fol
                 FROM  ge_tipdocumen tipodocumento
                 WHERE tipodocumento.cod_tipdocum = EN_documento_guia;

                 LV_tip_doc:= EN_documento_guia;
             ELSE
                LV_tip_doc:= EV_cod_tip_docum;
                LV_tip_fol:= EV_tip_foliacion;

             END IF;
             LV_Sql := LV_Sql || ' AND sucursaldocto.cod_tipdocum =:LV_tip_doc)'
                       || ' AND centroemision.tip_foliacion =:  LV_tip_fol'
                       || ' AND centroemision.cod_tipmovimien =: EN_cod_tipmovimen'
                       || ' AND centroemision.cod_catribut =: EV_cod_cattribut';

             LV_SqlEjecutarc:=LV_Sql;
             /*loop
               exit when LV_SqlEjecutarc is null;
               dbms_output.put_line( substr( LV_SqlEjecutarc, 1, 250 ) );
               LV_SqlEjecutarc := substr( LV_SqlEjecutarc, 251 );
             end loop;*/

             IF (EV_flagcentremi = '1') THEN
                 LV_Sql := LV_Sql || ' AND centroemision.cod_modventa =: EN_cod_modventa';
                  EXECUTE IMMEDIATE LV_Sql INTO SV_cod_modgener
                 USING IN EV_cod_oficina, LV_tip_doc, LV_tip_fol, EN_cod_tipmovimen, EV_cod_cattribut,
                 EN_cod_modventa;
             ELSE
                 EXECUTE IMMEDIATE LV_Sql INTO SV_cod_modgener
                 USING IN EV_cod_oficina, LV_tip_doc, LV_tip_fol, EN_cod_tipmovimen, EV_cod_cattribut;

             END IF;

        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                     SN_cod_retorno:=1;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno:=CV_error_no_clasif;
                     END IF;
                     LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_modo_gener_fact_PR();- ' || SQLERRM;
                     SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_modo_gener_fact_PR()', LV_Sql, SQLCODE, LV_des_error );
                 WHEN OTHERS THEN
                     SN_cod_retorno:=156;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                         SV_mens_retorno:=CV_error_no_clasif;
                     END IF;
                     LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_modo_gener_fact_PR();- ' || SQLERRM;
                     SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_modo_gener_fact_PR()', LV_Sql, SQLCODE, LV_des_error );

        END VE_obtiene_modo_gener_fact_PR;


          PROCEDURE VE_in_ga_preliquidacion_PR(EV_numventa       IN ga_preliquidacion.num_venta%TYPE,
                                         EV_codvendealer   IN ga_preliquidacion.cod_dealer%TYPE,
                                         EV_codmaster         IN ga_preliquidacion.cod_master_dealer%TYPE,
                                         EV_codcliente     IN ga_preliquidacion.cod_cliente%TYPE,
                                         EV_codmodvta       IN ga_preliquidacion.cod_modventa%TYPE,
                                         EV_cod_programa   IN ge_programas.cod_programa%TYPE,
                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento ) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
            Lenguaje="PL/SQL"
            Fecha="02-05-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
            <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
            <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
            <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
            <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
            <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
            <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
            <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
            <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

        </Entrada>
        <Salida>
            <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_unidades          ga_preliquidacion.num_unidades%TYPE := 0;
            LV_importe             ga_preliquidacion.imp_venta%TYPE := 0;
            LV_dias_venc_consig  ged_parametros.val_parametro%TYPE;
            LV_so_matrizestados  Ve_Tipos_Pg.tip_ve_matrizestados_td;
            LV_indestvta         ga_preliquidacion.ind_estventa%TYPE := NULL;
            LV_fecha_venta          ga_ventas.fec_venta%TYPE;

            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
        BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql := 'SELECT fec_venta'
                   ||' FROM ga_ventas '
                   ||' WHERE num_venta = '||EV_numventa;

        SELECT fec_venta
        INTO LV_fecha_venta
        FROM ga_ventas
        WHERE num_venta = EV_numventa;

        LV_so_matrizestados(1).cod_programa := EV_cod_programa;
        LV_so_matrizestados(1).ind_ofiter := CV_TIP_VENTA_OFICINA;
        LV_so_matrizestados(1).formulario := CV_FORM_PRESU_VTA;

        Ve_Intermediario_Pg.VE_obtiene_valor_parametro_PR('DIAS_VENC_CONSIG',CV_MODULO_GA,CV_PRODUCTO,LV_dias_venc_consig,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        Ve_Cierreventa_Sb_Pg.VE_codigo_procs_venta_PR (LV_so_matrizestados,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        Ve_Cierreventa_Sb_Pg.VE_codigo_estfinal_venta_PR (LV_so_matrizestados,LV_fecha_venta,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        LV_indestvta := LV_so_matrizestados(1).cod_estadodestino;

        LV_sSql := 'INSERT INTO ga_preliquidacion ( num_venta, cod_dealer,cod_master_dealer,cod_cliente,ind_estventa,'
                      ||'cod_modventa, num_unidades,imp_venta,fec_venta,ind_venta)'
                   ||'VALUES ('||EV_numventa||','||EV_codvendealer||','||EV_codmaster||','||EV_codcliente||','||LV_indestvta||','
                               ||EV_codmodvta||','||LV_unidades||','||LV_importe||','||SYSDATE||'+'||LV_dias_venc_consig||','||CV_IND_TIPO_VENTA||')';

        INSERT INTO ga_preliquidacion ( num_venta, cod_dealer,cod_master_dealer,cod_cliente,ind_estventa,
                                             cod_modventa, num_unidades,imp_venta,fec_venta,ind_venta)
        VALUES                           ( EV_numventa, EV_codvendealer, EV_codmaster, EV_codcliente, LV_indestvta,
                                          EV_codmodvta, LV_unidades, LV_importe,SYSDATE+LV_dias_venc_consig,CV_IND_TIPO_VENTA);
    EXCEPTION
             WHEN OTHERS THEN
                     SN_cod_retorno:=4;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                     END IF;
                     LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_in_ga_preliquidacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
                     SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                     'PV_SERVICIOS_POSVENTA_PG.VE_in_ga_preliquidacion_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_in_ga_preliquidacion_PR;

    PROCEDURE VE_in_ga_det_preliq_PR(EN_numventa             IN ga_preliquidacion.num_venta%TYPE,
                                       EN_numitem              IN ga_det_preliq.num_item%TYPE,
                                       EN_numabonado          IN ga_det_preliq.num_abonado%TYPE,
                                     EN_numcelular          IN ga_det_preliq.num_celular%TYPE,
                                     EV_numserie          IN ga_det_preliq.num_serie_orig%TYPE,
                                     EN_impcargo          IN ga_det_preliq.imp_cargo%TYPE,
                                     EN_impcargofinal      IN ga_det_preliq.imp_cargo_final%TYPE,
                                     EN_codarticulo          IN ga_det_preliq.cod_articulo%TYPE,
                                     EN_tipdcto              IN ga_det_preliq.tip_dto%TYPE,
                                     EN_valdcto              IN ga_det_preliq.val_dto%TYPE,
                                     SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento ) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
            Lenguaje="PL/SQL"
            Fecha="02-05-2007"
            Version="1.0.0"
            Dise?ador="Hector Hermosilla"
            Programador="Hector Hermosilla"
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
            <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
            <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
            <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
            <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
            <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
            <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
            <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
            <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

        </Entrada>
        <Salida>
            <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
    BEGIN
         SN_num_evento:= 0;
         SN_cod_retorno:=0;
         SV_mens_retorno:='';

         LV_sSql := 'INSERT INTO ga_det_preliq  ( num_venta, num_item, num_abonado, num_celular, num_serie_orig,'
                     ||'imp_cargo, imp_cargo_final, cod_articulo,tip_dto,val_dto)'
                     ||' VALUES ('||EN_numventa||','||EN_numitem||','||EN_numabonado||','||EN_numcelular||','||EV_numserie||','
                                 ||EN_impcargo||','||EN_impcargofinal||','||EN_codarticulo||','||EN_tipdcto||','||EN_valdcto||')';

         INSERT INTO ga_det_preliq  ( num_venta, num_item, num_abonado, num_celular, num_serie_orig,
                                        imp_cargo, imp_cargo_final, cod_articulo,tip_dto,val_dto)
         VALUES                        ( EN_numventa, EN_numitem, EN_numabonado, EN_numcelular, EV_numserie,
                                      EN_impcargo, EN_impcargofinal, EN_codarticulo,EN_tipdcto,EN_valdcto);
    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_in_ga_det_preliq_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_in_ga_det_preliq_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_IN_GA_DET_PRELIQ_PR;

    PROCEDURE VE_actualiza_facturacion_PR( EV_cod_estadoc         IN VARCHAR2
                                            ,EV_cod_estproc           IN VARCHAR2
                                          ,EV_cod_catribdoc       IN VARCHAR2
                                           ,EV_num_folio               IN VARCHAR2
                                            ,EV_pref_plaza           IN VARCHAR2
                                            ,EV_fec_vencimiento      IN VARCHAR2
                                            ,EV_nom_usuaelim           IN VARCHAR2
                                            ,EV_cod_causaelim           IN VARCHAR2
                                            ,EV_num_proceso           IN VARCHAR2
                                            ,EV_num_venta               IN VARCHAR2
                                            ,SN_cod_retorno           OUT NOCOPY ge_errores_pg.CodError
                                            ,SV_mens_retorno          OUT NOCOPY ge_errores_pg.MsgError
                                           ,SN_num_evento            OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_actualiza_facturacion_PR"
        Lenguaje="PL/SQL"
        Fecha="05-05-2007"
        Version="1.0.0"
        Dise?ador="Hector Hermosilla"
        Programador="Hector Hermosilla"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Actualiza tabla Facturacion....
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EV_cod_estadoc"     Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_cod_estproc"     Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_cod_catribdoc"   Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_num_folio"       Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_pref_plaza"      Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_fec_vencimiento" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_nom_usuaelim"    Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_cod_causaelim"   Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_num_proceso"     Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="EV_num_venta"       Tipo="VARCHAR2"> glosa mensaje error </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
        LV_SqlEjecutarc ge_errores_pg.vQuery;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_Sql:= 'UPDATE  FA_INTERFACT';
        IF (EV_cod_estadoc IS NULL) THEN
            LV_Sql:= LV_Sql || ' SET FEC_VENCIMIENTO = TO_DATE(''' || EV_fec_vencimiento || ''', ''DD-MM-YYYY HH24:MI:SS'')';
        ELSE
            LV_Sql:= LV_Sql || ' SET COD_ESTADOC =''' ||  EV_cod_estadoc || ''''
                     || ' ,COD_ESTPROC =''' || EV_cod_estproc || '''';

            IF EV_cod_catribdoc = 'B' AND EV_num_folio IS NOT NULL THEN
                LV_Sql:= LV_Sql || ' ,NUM_FOLIO =''' || EV_num_folio || ''''
                         || ' ,PREF_PLAZA =''' || EV_pref_plaza || '''';
            END IF;
            IF EV_fec_vencimiento IS NOT NULL THEN
                LV_Sql:= LV_Sql || ' ,FEC_VENCIMIENTO = TO_DATE(''' || EV_fec_vencimiento|| ''', ''DD-MM-YYYY HH24:MI:SS'')';
            END IF;

            IF EV_cod_causaelim IS NOT NULL THEN
                LV_Sql:= LV_Sql || ' ,NOM_USUAELIM =''' || EV_nom_usuaelim || ''''
                         || ' ,COD_CAUSAELIM =''' || EV_cod_causaelim || '''';

            END IF;
        END IF;
        LV_Sql:= LV_Sql || ' WHERE num_venta = ''' || EV_num_venta || '''';
         LV_SqlEjecutarc:=LV_Sql;
             LOOP
               EXIT WHEN LV_SqlEjecutarc IS NULL;
               LV_SqlEjecutarc := SUBSTR( LV_SqlEjecutarc, 251 );
             END LOOP;

        EXECUTE IMMEDIATE LV_Sql;
    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_actualiza_facturacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_actualiza_facturacion_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_actualiza_facturacion_PR;

    PROCEDURE VE_obtiene_articulos_consig_PR ( EN_num_venta IN  ga_abocel.num_venta%TYPE,
                                                 SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS


         LV_valparametro ged_parametros.val_parametro%TYPE;
        no_data_found_cursor               EXCEPTION;
        LN_contador NUMBER;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';
            Ve_Intermediario_Pg.VE_obtiene_valor_parametro_PR('STOCK_CONSIGNACION',CV_MODULO_AL,CV_PRODUCTO,LV_valparametro,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            LV_sSql := 'SELECT a.num_venta,'
                       ||'a.num_abonado,'
                       ||'a.num_celular,'
                       ||'a.num_serie,'
                       ||'b.cod_articulo,'
                       ||'S'
                       ||' FROM ga_abocel a, al_series b'
                       ||' WHERE a.num_venta = '||EN_num_venta
                       ||' AND a.num_serie = b.num_serie'
                       ||' UNION'
                        ||' SELECT a.num_venta,'
                          ||'a.num_abonado,'
                          ||'a.num_celular,'
                          ||'a.num_imei,'
                          ||'b.cod_articulo,'
                          ||'T'
                       ||' FROM ga_abocel a, al_series b'
                       ||' WHERE a.num_venta = '||EN_num_venta
                       ||' AND a.num_imei = b.num_serie'
                       || ' AND    b.tip_stock = ' || LV_valparametro;

            LN_contador := 0;

            SELECT COUNT(1)
            INTO LN_contador
            FROM ga_abocel a, al_series b
            WHERE a.num_venta = EN_num_venta
            AND a.num_serie = b.num_serie
            AND ROWNUM <= 1;

            IF (LN_contador = 0) THEN
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_abocel a, al_series b
                WHERE a.num_venta = EN_num_venta
                AND a.num_imei = b.num_serie
                AND ROWNUM <= 1;
            END IF;

            OPEN SC_cursordatos FOR

            SELECT a.num_venta,
                   a.num_abonado,
                   a.num_celular,
                   a.num_serie,
                   b.cod_articulo,
                   'S'
            FROM
                   ga_abocel a,
                   al_series b
            WHERE
                    a.num_venta = EN_num_venta
            AND
                      a.num_serie = b.num_serie
            AND    b.tip_stock = LV_valparametro
            UNION

            SELECT a.num_venta,
                   a.num_abonado,
                   a.num_celular,
                   a.num_imei,
                   b.cod_articulo,
                   'T'
            FROM
                   ga_abocel a,
                   al_series b
            WHERE
                   a.num_venta = EN_num_venta
            AND
                      a.num_imei = b.num_serie
            AND    b.tip_stock = LV_valparametro;


            IF (LN_contador = 0) THEN
               RAISE no_data_found_cursor;
            END IF;

        EXCEPTION
            WHEN no_data_found_cursor THEN
                 SN_cod_retorno:=99;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_articulos_consig_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_articulos_consig_PR', LV_sSql, SN_cod_retorno, LV_des_error );
            WHEN OTHERS THEN
                 SN_cod_retorno:=4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_articulos_consig_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_articulos_consig_PR', LV_sSql, SN_cod_retorno, LV_des_error );
       END VE_obtiene_articulos_consig_PR;

     PROCEDURE VE_crea_movimiento_central_PR(EN_num_movimiento    IN icc_movimiento.num_movimiento%TYPE,
                                               EN_num_abonado       IN icc_movimiento.num_abonado%TYPE,
                                             EN_cod_estado        IN icc_movimiento.cod_estado%TYPE,
                                             EV_cod_actabo        IN icc_movimiento.cod_actabo%TYPE,
                                             EV_cod_modulo        IN icc_movimiento.cod_modulo%TYPE,
                                              EN_cod_actuacion     IN icc_movimiento.cod_actuacion%TYPE,
                                             EN_nom_usuarora      IN icc_movimiento.nom_usuarora%TYPE,
                                             ED_fec_ingreso       IN icc_movimiento.fec_ingreso%TYPE,
                                               EV_tip_terminal      IN icc_movimiento.tip_terminal%TYPE,
                                             EN_cod_central       IN icc_movimiento.cod_central%TYPE,
                                             EN_num_celular       IN icc_movimiento.num_celular%TYPE,
                                               EV_num_serie         IN icc_movimiento.num_serie%TYPE,
                                               EV_cod_servicios     IN icc_movimiento.cod_servicios%TYPE,
                                               EV_num_min           IN icc_movimiento.num_min%TYPE,
                                               EV_tip_tecnologia    IN icc_movimiento.tip_tecnologia%TYPE,
                                             EV_imsi              IN icc_movimiento.imsi%TYPE,
                                             EV_imei              IN icc_movimiento.imei%TYPE,
                                             EV_icc               IN icc_movimiento.icc%TYPE,
                                             EN_num_movtoant      IN icc_movimiento.num_movimiento%TYPE,
                                             EV_plan              IN VARCHAR2,
                                             EV_valorPlan         IN VARCHAR2,
                                             EV_carga             IN VARCHAR2,
                                             SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
    BEGIN

          SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:= 'INSERT INTO icc_movimiento (num_movimiento, num_abonado, cod_estado, cod_actabo, '
                 || 'cod_modulo, cod_actuacion, nom_usuarora, fec_ingreso,'
                 || 'tip_terminal, cod_central, num_celular, num_serie,'
                 || ' cod_servicios, num_min, tip_tecnologia, imsi,'
                 || ' imei, icc, num_movant, plan, valor_plan, carga)'
                 || 'VALUES (' || EN_num_movimiento || ',' || EN_num_abonado || ',' || EN_cod_estado || ',''' || EV_cod_actabo || ''','''
                 || EV_cod_modulo || ''',' ||  EN_cod_actuacion || ','  || EN_nom_usuarora || ',' || ED_fec_ingreso || ','''
                 || EV_tip_terminal || ',' || EN_cod_central || ',' || EN_num_celular || ',''' || EV_num_serie || ''','''
                  || EV_cod_servicios || ''',''' || EV_num_min || ''',''' || EV_tip_tecnologia || ''',''' || EV_imsi || ''','''
                 || EV_imei || ''',''' || EV_icc || '''' || EN_num_movtoant || ',''' || EV_plan || ''','
                 || EV_valorPlan || ',' || EV_carga || ')';

        INSERT INTO icc_movimiento (num_movimiento, num_abonado, cod_estado, cod_actabo,
                               cod_modulo, cod_actuacion, nom_usuarora, fec_ingreso,
                               tip_terminal, cod_central, num_celular, num_serie,
                               cod_servicios, num_min, tip_tecnologia, imsi,
                               imei, icc, num_movant, plan, valor_plan, carga)
        VALUES (EN_num_movimiento, EN_num_abonado, EN_cod_estado, EV_cod_actabo,
                EV_cod_modulo, EN_cod_actuacion, EN_nom_usuarora, ED_fec_ingreso,
                EV_tip_terminal, EN_cod_central, EN_num_celular, EV_num_serie,
                EV_cod_servicios, EV_num_min, EV_tip_tecnologia, EV_imsi,
                EV_imei, EV_icc, EN_num_movtoant,EV_plan, EV_valorPlan, EV_carga);

    EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_crea_movimiento_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_crea_movimiento_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );
            WHEN OTHERS THEN
                 SN_cod_retorno:=4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_crea_movimiento_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_crea_movimiento_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );

    END VE_crea_movimiento_central_PR;

    PROCEDURE VE_obtiene_ind_telefono_PR(EV_serie         IN  al_series.num_serie%TYPE,
                                          EV_parametro     OUT NOCOPY VARCHAR2,
                                         SN_indtelefono  OUT NOCOPY al_series.ind_telefono%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_ind_telefono_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene el indicador de telefono para una serie dada.
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_serie"        Tipo="VARCHAR2> numero serie a consultar</param>
            <param nom="EN_parametro"    Tipo="NUMBER> indicador de telefono a descartar</param>
        </Entrada>
        <Salida>
            <param nom="SN_indtelefono"  Tipo="NUMBER"> indicador de telefono</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;

    BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SN_indtelefono:=0;

            LV_sSql := 'SELECT a.ind_telefono'
                       ||' FROM al_series a'
                       ||' WHERE a.num_serie ='|| EV_serie
                       ||' AND a.num_telefono IS NOT NULL'
                       ||' AND a.ind_telefono > 0'
                       ||' AND a.ind_telefono <> '||EV_parametro;

            SELECT a.ind_telefono
              INTO SN_indtelefono
            FROM al_series a
            WHERE a.num_serie = EV_serie
              AND a.num_telefono IS NOT NULL
              AND a.ind_telefono > 0
              AND a.ind_telefono <> EV_parametro;

            EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno := 4;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                     END IF;
                     LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_ind_telefono_PR; - '|| SQLERRM,1,CN_largoerrtec);
                     SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                     'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_ind_telefono_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                 WHEN OTHERS THEN
                     SN_cod_retorno:=156;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasIF;
                     END IF;
                     LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_ind_telefono_PR; - '|| SQLERRM,1,CN_largoerrtec);
                     SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                     'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_ind_telefono_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_ind_telefono_PR;

    PROCEDURE VE_obtiene_actua_central_PR(EV_codactabo     IN ga_actabo.cod_actabo%TYPE,
                                          EN_codproducto   IN ga_actabo.cod_producto%TYPE,
                                          EV_codtecnologia IN ga_actabo.cod_actabo%TYPE,
                                          SV_codactcen     OUT NOCOPY ga_actabo.cod_actcen%TYPE,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_actua_central_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene codigo actuacion central
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_codactabo"     Tipo="VARCHAR2"> codigo actuacion abonado</param>
            <param nom="EN_codproducto"   Tipo="NUMBER"> codigo producto</param>
            <param nom="EV_codtecnologia" Tipo="VARCHAR2"> codigo tecnologia</param>
        </Entrada>
        <Salida>
            <param nom="SV_codactcen"     Tipo="VARCHAR2"> codigo de actuacion central</param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR2"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

            SV_codactcen:='';

            LV_sSql := 'SELECT a.cod_actcen'
                       ||' FROM ga_actabo a'
                       ||' WHERE a.cod_actabo = '||EV_codactabo
                       ||' AND a.cod_producto = '||EN_codproducto
                       ||' AND a.cod_tecnologia = '||EV_codtecnologia;

            SELECT a.cod_actcen
            INTO SV_codactcen
            FROM ga_actabo a
            WHERE a.cod_actabo = EV_codactabo
              AND a.cod_producto = EN_codproducto
              AND a.cod_tecnologia = EV_codtecnologia;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_actua_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_actua_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_actua_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_actua_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_actua_central_PR;

    PROCEDURE VE_obtiene_codigo_sistema_PR(EN_codproducto   IN icg_central.cod_producto%TYPE,
                                           EN_codcentral    IN icg_central.cod_central%TYPE,
                                           SN_codsistema    OUT NOCOPY icg_central.cod_sistema%TYPE,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_codigo_sistema_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene Codigo de sistema, correspondiente al asociado a la central de la linea
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codproducto"   Tipo="NUMBER> codigo producto</param>
            <param nom="EV_codcentral"    Tipo="NUMBER> codigo central</param>
        </Entrada>
        <Salida>
            <param nom="SN_codsistema     Tipo="NUMBER"> codigo sistema</param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR2"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

            SN_codsistema:='';

            LV_sSql := 'SELECT a.cod_sistema'
                       ||' FROM icg_central a'
                       ||' WHERE a.cod_producto ='|| EN_codproducto
                       ||' AND a.cod_central = '||EN_codcentral;

            SELECT a.cod_sistema
            INTO SN_codsistema
            FROM icg_central a
            WHERE a.cod_producto = EN_codproducto
              AND a.cod_central = EN_codcentral;

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := 4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codigo_sistema_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codigo_sistema_PR', LV_sSql, SN_cod_retorno, LV_des_error );
             WHEN OTHERS THEN
                 SN_cod_retorno:=156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codigo_sistema_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_codigo_sistema_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_codigo_sistema_PR;

    PROCEDURE VE_obtiene_central_PR(EN_codproducto   IN icg_central.cod_producto%TYPE,
                                    EN_codcentral    IN icg_central.cod_central%TYPE,
                                    SV_codtecnologia OUT NOCOPY icg_central.cod_tecnologia%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_central_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene dtos de la central
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codproducto"    Tipo="NUMBER> codigo producto</param>
            <param nom="EV_codcentral"     Tipo="NUMBER> codigo central</param>
        </Entrada>
        <Salida>
            <param nom="SV_codtecnologia"  Tipo="NUMBER"> codigo tecnologia</param>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error</param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';

            SV_codtecnologia:='';

            LV_sSql := 'SELECT a.cod_tecnologia'
                       ||' FROM icg_central a'
                       ||' WHERE a.cod_producto = '||EN_codproducto
                       ||' AND a.cod_central = '||EN_codcentral;

            SELECT a.cod_tecnologia
            INTO SV_codtecnologia
            FROM icg_central a
            WHERE a.cod_producto = EN_codproducto
              AND a.cod_central = EN_codcentral;

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := 4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );
             WHEN OTHERS THEN
                 SN_cod_retorno:=156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_central_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_central_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_central_PR;

    PROCEDURE VE_up_ga_preliquidacion_PR(EV_numventa           IN ga_preliquidacion.num_venta%TYPE,
                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

    LV_unidades          ga_preliquidacion.num_unidades%TYPE := 0;
    LV_importe             ga_preliquidacion.imp_venta%TYPE := 0.0;
    LV_des_error ge_errores_pg.DesEvent;
    LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        SELECT COUNT(*),SUM(imp_cargo_final)
        INTO   LV_unidades, LV_importe
        FROM   ga_det_preliq
        WHERE  num_venta = EV_numventa;


        LV_sSql := 'UPDATE ga_preliquidacion '
                       ||' SET num_unidades = '||LV_unidades
                       ||' ,imp_venta = '||LV_importe
                       ||' WHERE  num_venta = '||EV_numventa;

        UPDATE ga_preliquidacion
        SET    num_unidades = LV_unidades ,imp_venta = LV_importe
        WHERE  num_venta = EV_numventa;

    EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_retorno:=4;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_up_ga_preliquidacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_up_ga_preliquidacion_PR', LV_sSql, SN_cod_retorno, LV_des_error );

    END VE_up_ga_preliquidacion_PR;

    PROCEDURE VE_actualiza_equipaboser_PR(EV_NumMovimiento IN VARCHAR2,
                                              EV_TipStock       IN VARCHAR2,
                                              EV_BodegaAct       IN VARCHAR2,
                                              EV_TipStockOrig  IN VARCHAR2,
                                              EV_CodBodega       IN VARCHAR2,
                                              EV_CodArticulo   IN VARCHAR2,
                                              EV_CodUso           IN VARCHAR2,
                                              EV_CodEstado       IN VARCHAR2,
                                              EV_Numserie       IN VARCHAR2,
                                              EV_NumAbonado       IN VARCHAR2,
                                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentaci�n
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "VE_actualiza_equipaboser_PR"
              Lenguaje="PL/SQL"
              Fecha="15-05-2006"
              Versi�n="1.0"
              Dise�ador="wjrc"
              Programador="wjrc
              Ambiente Desarrollo="BD">
              <Retorno>NA</Retorno>
              <Descripci�n>
                             Actualiza tabla GA_EQUIPABOSER
              </Descripci�n>
              <Par�metros>
                 <Entrada>
                    <param nom="EV_NumMovimiento" Tipo="VARCHAR2">Numero de movimeinto</param>
                    <param nom="EV_TipStock"      Tipo="VARCHAR2">Tipo de strock</param>
                    <param nom="EV_BodegaAct"     Tipo="VARCHAR2">Bodega actual</param>
                    <param nom="EV_TipStockOrig"  Tipo="VARCHAR2">Tipo stock origen</param>
                    <param nom="EV_CodBodega"     Tipo="VARCHAR2">Codigo bodega</param>
                    <param nom="EV_CodArticulo"   Tipo="VARCHAR2">Codigo articulo</param>
                    <param nom="EV_CodUso"        Tipo="VARCHAR2">Codigo uso</param>
                    <param nom="EV_CodEstado"     Tipo="VARCHAR2">Codigo estado</param>
                    <param nom="EV_Numserie"      Tipo="VARCHAR2">Numero de serie</param>
                     <param nom="EN_NumAbonado"    Tipo="VARCHAR2">Nro del abonado</param>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
                    <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                 </Salida>
              </Par�metros>
           </Elemento>
        </Documentaci�n>
        */
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
        BEGIN
               SN_cod_retorno := 0;
               SV_mens_retorno := NULL;
               SN_num_evento := 0;

               LV_sSql:='UPDATE ga_equipaboser'
               || ' SET num_movimiento = ' || EV_NumMovimiento
               || '    ,tip_stock = ' || EV_TipStock
               || '    ,cod_bodega = ' || EV_BodegaAct
               || ' WHERE tip_stock = ' || EV_TipStockOrig
               || '   AND cod_bodega = ' || EV_CodBodega
               || '   AND cod_articulo = ' || EV_CodArticulo
               || '   AND cod_uso = ' || EV_CodUso
               || '   AND cod_estado = ' || EV_CodEstado
               || '   AND num_serie = ' || EV_Numserie
               || '   AND num_abonado = ' || EV_NumAbonado;

               UPDATE ga_equipaboser
               SET num_movimiento = EV_NumMovimiento
                  ,tip_stock = EV_TipStock
                  ,cod_bodega = EV_BodegaAct
               WHERE tip_stock = EV_TipStockOrig
                 AND cod_bodega = EV_CodBodega
                 AND cod_articulo = EV_CodArticulo
                 AND cod_uso = EV_CodUso
                 AND cod_estado = EV_CodEstado
                 AND num_serie = EV_Numserie
                 AND num_abonado = EV_NumAbonado;

        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_actualiza_equipaboser_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_actualiza_equipaboser_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_actualiza_equipaboser_PR;

        PROCEDURE VE_obtiene_equipos_seriados_PR(EV_numAbonado     IN  VARCHAR2,
                                                   EV_indProcedencia IN  VARCHAR2,
                                                   SC_cursordatos    OUT NOCOPY REFCURSOR,
                                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_equipos_seriados_PR
                Lenguaje="PL/SQL"
                Fecha="15-05-2007"
                Version="1.0.0"
                Dise?ador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
            <Retorno>NA</Retorno>
            <Descripcion>
                Consulta EQUIPOS SERIADOS
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_numAbonado"      Tipo="VARCHAR2> c�digo articulo</param>
                <param nom="EV_indProcedencia"  Tipo="VARCHAR2> c�digo articulo</param>
            </Entrada>
            <Salida>
                   <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor equipos seriados </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
                LV_Sql          ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.desevent;
                no_data_found_cursor EXCEPTION;
                LN_contador NUMBER;
        BEGIN

                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';

                LV_Sql:= 'SELECT a.tip_stock,a.cod_bodega,a.cod_articulo,a.cod_uso,a.cod_estado,a.num_serie,a.ind_equiacc,a.tip_terminal'
                         || ' FROM ga_equipaboser a'
                         || ' WHERE a.num_abonado = ' || EV_numAbonado
                         || '   AND a.ind_procequi = ' ||  EV_indProcedencia;

                OPEN SC_cursordatos FOR
                SELECT a.tip_stock,
                       a.cod_bodega,
                       a.cod_articulo,
                       a.cod_uso,
                       a.cod_estado,
                       a.num_serie,
                       a.ind_equiacc,
                       a.tip_terminal
                FROM ga_equipaboser a
                WHERE a.num_abonado = EV_numAbonado
                AND a.ind_procequi = EV_indProcedencia; -- I : interna

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_equipaboser a
                WHERE a.num_abonado = EV_numAbonado
                AND a.ind_procequi = EV_indProcedencia;

                IF (LN_contador = 0) THEN
                    RAISE no_data_found_cursor;
                END IF;

    EXCEPTION
         WHEN no_data_found_cursor THEN
              SN_cod_retorno:=4;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_equipos_seriados_PR;- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_equipos_seriados_PR', LV_Sql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
               SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_equipos_seriados_PR;- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_equipos_seriados_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_obtiene_equipos_seriados_PR;

    PROCEDURE VE_ins_abo_garantia_PR(EN_num_venta      IN ga_abonado_garantia.num_venta%TYPE,
                                       EN_cod_cliente       IN ga_abonado_garantia.cod_cliente%TYPE,
                                      EN_num_abonado    IN ga_abonado_garantia.num_abonado%TYPE,
                                     EN_mto_garantia   IN ga_abonado_garantia.mto_garantia%TYPE,
                                       EN_ind_pago       IN ga_abonado_garantia.ind_pago%TYPE,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_ins_abo_garantia_PR"
        Lenguaje="PL/SQL"
        Fecha="15-05-2007"
        Version="1.0.0"
        Dise?ador="H�ctor Hermosilla"
        Programador="H�ctor Hermosilla"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Inserta la garantia del abonado
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
        <param nom="EN_cod_cliente"  Tipo="NUMBER> c�digo del cliente</param>
        <param nom="EN_num_abonado"  Tipo="NUMBER> numero de abonado </param>
        <param nom="EN_mto_garantia" Tipo="NUMBER> monto de garantia </param>
        <param nom="EN_ind_pago"     Tipo="NUMBER> indica pago garantia </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
        LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:= 'INSERT INTO ga_abonado_garantia '
                  || '(num_venta, cod_cliente, num_abonado,'
                  || ' mto_garantia, ind_pago)'
                  ||'VALUES ('
                  || EN_num_venta
                  ||','|| EN_cod_cliente
                  ||','|| EN_num_abonado
                  ||','|| EN_mto_garantia
                  ||','|| EN_ind_pago ||')';

        INSERT INTO ga_abonado_garantia
        (num_venta, cod_cliente, num_abonado,
         mto_garantia, ind_pago)
        VALUES (EN_num_venta, EN_cod_cliente, EN_num_abonado,
                EN_mto_garantia, EN_ind_pago);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ins_abo_garantia_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ins_abo_garantia_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_ins_abo_garantia_PR;

    PROCEDURE VE_consulta_estant_serie_PR(EV_serie          IN  al_series.num_serie%TYPE,
                                             SN_codestado    OUT NOCOPY al_series.cod_estado%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_consulta_estant_serie_PR
            Lenguaje="PL/SQL"
            Fecha="15-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene estado anterior de la serie
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
        </Entrada>
        <Salida>
            <param nom="SN_SN_codestado" Tipo="NUMBER"> codigo estado anterior </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            --  OBTENEMOS EL VALOR PARA INDICADOR TELEFONO OUT
            LV_indTelOut := '';
            Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_INDTELOUT,
                                                                CV_MODULO_GE,
                                                                CV_PRODUCTO,
                                                                LV_indTelOut,
                                                                LV_CodeSql,
                                                                LV_ErrmSql,
                                                                LN_NumEvento);

            LV_Sql:= 'SELECT a.cod_estado'
                     || ' FROM   al_series a'
                     || ' WHERE a.num_serie =' || EV_serie
                     || ' AND a.ind_telefono <>' || LV_indTelOut;

            SN_codestado := 0;
            SELECT a.cod_estado
            INTO SN_codestado
            FROM al_series a
            WHERE a.num_serie = EV_serie
            AND a.ind_telefono <> LV_indTelOut;

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_consulta_estant_serie_PR(' || EV_serie || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_consulta_estant_serie_PR(' || EV_serie || ')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_consulta_estant_serie_PR(' || EV_serie || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_consulta_estant_serie_PR(' || EV_serie || ')', LV_Sql, SQLCODE, LV_des_error );
    END VE_consulta_estant_serie_PR;

    PROCEDURE VE_inserta_contrato_PR(EN_cod_cuenta      IN ga_contcta.cod_cuenta%TYPE,
                                     EN_cod_producto    IN ga_contcta.cod_producto%TYPE,
                                     EV_cod_tipcontrato IN ga_contcta.cod_tipcontrato%TYPE,
                                     EV_num_contrato    IN ga_contcta.num_contrato%TYPE,
                                     EV_num_anexo       IN ga_contcta.num_anexo%TYPE,
                                     EN_num_meses       IN ga_contcta.num_meses%TYPE,
                                     EN_num_venta       IN ga_contcta.num_venta%TYPE,
                                     EN_num_abonados    IN ga_contcta.num_abonados%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_inserta_contrato_PR"
        Lenguaje="PL/SQL"
        Fecha="18-05-2007"
        Version="1.0.0"
        Dise?ador="H�ctor Hermosilla"
        Programador="H�ctor Hermosilla"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Inserta contrato y anexos de la venta
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EN_cod_cuenta"      Tipo="NUMBER> c�digo cuenta cliente </param>
        <param nom="EN_cod_producto"    Tipo="NUMBER> c�digo producto</param>
        <param nom="EV_cod_tipcontrato" Tipo="VARCHAR2"> c�digo tipo contrato </param>
        <param nom="EV_num_contrato"    Tipo="VARCHAR2"> numero contrato de la venta </param>
        <param nom="EV_num_anexo"       Tipo="VARCHAR2"> numero anexo </param>
        <param nom="EN_num_meses"       Tipo="NUMBER"> numero de meses </param>
        <param nom="EN_num_venta"       Tipo="NUMBER"> numero de la venta </param>
        <param nom="EN_num_abonados"    Tipo="NUMBER"> numero de abonados </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
        LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:= 'INSERT INTO ga_contcta'
                 || '(cod_cuenta, cod_producto, cod_tipcontrato, num_contrato,'
                  || ' num_anexo, num_meses, num_venta, fec_contrato,'
                 || ' num_abonados)'
                 ||'VALUES ('
                 || EN_cod_cuenta || ',' || EN_cod_producto || ',' || EV_cod_tipcontrato || ',' || EV_num_contrato || ','
                 || EV_num_anexo || ',' || EN_num_meses || ',' || EN_num_venta || ',' || SYSDATE || ','
                 || EN_num_abonados || ')';

        INSERT INTO ga_contcta
               (cod_cuenta, cod_producto, cod_tipcontrato, num_contrato,
                num_anexo, num_meses, num_venta, fec_contrato,
                num_abonados)
        VALUES (EN_cod_cuenta, EN_cod_producto, EV_cod_tipcontrato, EV_num_contrato,
                EV_num_anexo, EN_num_meses, EN_num_venta, SYSDATE,
                EN_num_abonados);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_inserta_contrato_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_inserta_contrato_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_inserta_contrato_PR;

    PROCEDURE VE_con_max_anexo_contrato_PR(EN_cod_cuenta      IN  ga_contcta.cod_cuenta%TYPE,
                                           EN_cod_producto    IN  ga_contcta.cod_producto%TYPE,
                                           EV_cod_tipcontrato IN  ga_contcta.cod_tipcontrato%TYPE,
                                           EV_num_contrato    IN  ga_contcta.num_contrato%TYPE,
                                           SN_max_anexo       OUT NUMBER,
                                           SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_max_anexo_contrato_PR"
            Lenguaje="PL/SQL"
            Fecha="18-05-2007"
            Version="1.0.0"
            Dise?ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene numero maximo de anexo de contrato de la venta
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cuenta"      Tipo="NUMBER"> c�digo cuenta cliente</param>
            <param nom="EN_cod_producto"    Tipo="NUMBER"> c�digo producto</param>
            <param nom="EV_cod_tipcontrato" Tipo="VARCHAR2"> c�digo tipo contrato</param>
            <param nom="EV_num_contrato"    Tipo="VARCHAR2"> n�mero contrato</param>
        </Entrada>
        <Salida>
            <param nom="SN_max_anexo"    Tipo="NUMBER"> m�ximo numero anexo contrato </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_Sql:= 'SELECT MAX(TO_NUMBER(SUBSTR(contrato.num_anexo, 17, 5)))'
                     || ' FROM ga_contcta contrato'
                     || ' WHERE contrato.cod_cuenta =' || EN_cod_cuenta
                     || ' AND contrato.cod_producto = ' || EN_cod_producto
                     || ' AND contrato.cod_tipcontrato = ' ||  EV_cod_tipcontrato
                     || ' AND contrato.num_contrato = ' || EV_num_contrato;

            SELECT MAX(TO_NUMBER(SUBSTR(contrato.num_anexo, 17, 5)))
            INTO SN_max_anexo
            FROM ga_contcta contrato
            WHERE contrato.cod_cuenta = EN_cod_cuenta
            AND contrato.cod_producto = EN_cod_producto
            AND contrato.cod_tipcontrato =  EV_cod_tipcontrato
            AND contrato.num_contrato = EV_num_contrato;

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_max_anexo_contrato_PR(' || EN_cod_cuenta || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_max_anexo_contrato_PR(' || EN_cod_cuenta || ')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_max_anexo_contrato_PR(' || EN_cod_cuenta || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_max_anexo_contrato_PR(' || EN_cod_cuenta || ')', LV_Sql, SQLCODE, LV_des_error );
    END VE_con_max_anexo_contrato_PR;

    PROCEDURE VE_con_rango_descto_vend_PR(EN_cod_vendedor    IN  ve_vendperfil.cod_vendedor%TYPE,
                                          SN_pnt_dto_inf     OUT NOCOPY ga_perfilcargos.pnt_dto_inf%TYPE,
                                          SN_pnt_dto_sup     OUT NOCOPY ga_perfilcargos.pnt_dto_sup%TYPE,
                                          SN_prc_dto_inf     OUT NOCOPY ga_perfilcargos.prc_dto_inf%TYPE,
                                          SN_prc_dto_sup     OUT NOCOPY ga_perfilcargos.prc_dto_sup%TYPE,
                                          SN_ind_moddtos     OUT NOCOPY ga_perfilcargos.ind_moddtos%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_rango_descto_vend_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Version="1.0.0"
            Dise?ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene rangos e descuentos asociados al vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_vendedor"    Tipo="NUMBER"> c�digo vendedor</param>
        </Entrada>
        <Salida>
            <param nom="SN_pnt_dto_inf"  Tipo="NUMBER"> rango inferior puntos de posibilidad dcto.</param>
            <param nom="SN_pnt_dto_sup"  Tipo="NUMBER"> rango superior puntos de posibilidad dcto.</param>
            <param nom="SN_prc_dto_inf"  Tipo="NUMBER"> rango inferior porcentaje de dcto. </param>
            <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> rango superior porcentaje de dcto. </param>
            <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> indica si vendedor puede o no modificar descuentos </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_Sql:= 'SELECT perfilcargos.pnt_dto_inf, perfilcargos.pnt_dto_sup, perfilcargos.prc_dto_inf,'
                     || ' perfilcargos.prc_dto_sup,perfilcargos.ind_moddtos'
                     || ' FROM ve_vendperfil perfilvendedor, ga_perfilcargos perfilcargos'
                     || ' WHERE perfilvendedor.cod_vendedor = ' || EN_cod_vendedor
                     || ' AND perfilcargos.cod_perfil = perfilvendedor.cod_perfil'
                     || ' AND SYSDATE BETWEEN perfilvendedor.fec_asignacion AND NVL(perfilvendedor.fec_desasignac,' || SYSDATE || ')';



            SELECT perfilcargos.pnt_dto_inf, perfilcargos.pnt_dto_sup, perfilcargos.prc_dto_inf,
                   perfilcargos.prc_dto_sup, perfilcargos.ind_moddtos
            INTO  SN_pnt_dto_inf, SN_pnt_dto_sup, SN_prc_dto_inf,
                  SN_prc_dto_sup, SN_ind_moddtos
            FROM ve_vendperfil perfilvendedor, ga_perfilcargos perfilcargos
            WHERE perfilvendedor.cod_vendedor = EN_cod_vendedor
            AND perfilcargos.cod_perfil = perfilvendedor.cod_perfil
            AND SYSDATE BETWEEN perfilvendedor.fec_asignacion AND NVL(perfilvendedor.fec_desasignac,SYSDATE);

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_rango_descto_vend_PR(' || EN_cod_vendedor || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_rango_descto_vend_PR(' || EN_cod_vendedor || ')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_rango_descto_vend_PR(' || EN_cod_vendedor || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_rango_descto_vend_PR(' || EN_cod_vendedor || ')', LV_Sql, SQLCODE, LV_des_error );
    END VE_con_rango_descto_vend_PR;

    PROCEDURE VE_ins_sol_autorizacion_PR(EN_num_venta        IN  ga_autoriza.num_venta%TYPE,
                                         EN_lin_autoriza     IN  ga_autoriza.lin_autoriza%TYPE,
                                         EV_cod_oficina      IN  ga_autoriza.cod_oficina%TYPE,
                                          EV_cod_estado       IN  ga_autoriza.cod_estado%TYPE,
                                         EN_num_autoriza     IN  ga_autoriza.num_autoriza%TYPE,
                                         EN_cod_vendedor     IN  ga_autoriza.cod_vendedor%TYPE,
                                         EN_num_unidades     IN  ga_autoriza.num_unidades%TYPE,
                                         EN_prc_origin       IN  ga_autoriza.prc_origin%TYPE,
                                         EN_ind_tipventa     IN  ga_autoriza.ind_tipventa%TYPE,
                                         EN_cod_cliente      IN  ga_autoriza.cod_cliente%TYPE,
                                         EN_cod_modventa     IN  ga_autoriza.cod_modventa%TYPE,
                                         EV_nom_usuar_vta    IN  ga_autoriza.nom_usuar_vta%TYPE,
                                         EN_cod_concepto     IN  ga_autoriza.cod_concepto%TYPE,
                                         EN_imp_cargo        IN  ga_autoriza.imp_cargo%TYPE,
                                         EV_cod_moneda       IN  ga_autoriza.cod_moneda%TYPE,
                                         EN_num_abonado      IN  ga_autoriza.num_abonado%TYPE,
                                         EV_num_serie        IN  ga_autoriza.num_serie%TYPE,
                                         EN_cod_concepto_dto IN  ga_autoriza.cod_concepto_dto%TYPE,
                                         EN_val_dto          IN  ga_autoriza.val_dto%TYPE,
                                         EN_tip_dto          IN  ga_autoriza.tip_dto%TYPE,
                                         EN_ind_modifi       IN  ga_autoriza.ind_modifi%TYPE,
                                         EV_origen           IN  ga_autoriza.origen%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_ins_sol_autorizacion_PR"
            Lenguaje="PL/SQL"
            Fecha="31-05-2007"
            Version="1.0.0"
            Dise?ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Ingresa solicitud de aprobaci�n de descuentos
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_venta"         Tipo="NUMBER"> numero de la venta</param>
            <param nom="EN_lin_autorixa"      Tipo="NUMBER"> correlativo que idenitifica a cada cargo</param>
            <param nom="EV_cod_oficina"       Tipo="STRING"> c�digo oficina del vendedor</param>
            <param nom="EV_cod_estado"        Tipo="STRING"> c�digo estado de la autorizaci�n</param>
            <param nom="EN_num_autoriza"      Tipo="NUMBER"> n�mero correlativo de la solicitud de autorizaci�n</param>
            <param nom="EN_cod_vendedor"      Tipo="NUMBER"> c�digo vendedor</param>
            <param nom="EN_num_unidades"      Tipo="NUMBER"> cantidad de cargos</param>
            <param nom="EN_prc_origin"        Tipo="NUMBER"> precio origen</param>
            <param nom="EN_ind_tipventa"      Tipo="NUMBER"> indicador tipo de venta</param>
            <param nom="EN_cod_cliente"       Tipo="NUMBER"> c�digo cliente</param>
            <param nom="EN_cod_modventa"      Tipo="NUMBER"> c�digo modlaidad de la venta</param>
            <param nom="EV_nom_usuar_vta"     Tipo="STRING"> nombre usuario de la venta</param>
            <param nom="EN_cod_concepto"      Tipo="NUMBER"> c�digo concepto del cargo</param>
            <param nom="EN_imp_cargo"         Tipo="NUMBER"> importe del cargo </param>
            <param nom="EV_cod_moneda"        Tipo="STRING"> c�digo moneda</param>
            <param nom="EN_num_abonado"       Tipo="NUMBER"> n�mero de abonado</param>
            <param nom="EV_num_serie"         Tipo="STRING"> n�mero de la serie</param>
            <param nom="EN_cod_concepto_dto"  Tipo="NUMBER"> c�digo concepto de descuento</param>
             <param nom="EN_val_dto"           Tipo="NUMBER"> valor de descuento</param>
            <param nom="EN_tip_dto"           Tipo="NUMBER"> tipo de descuento</param>
            <param nom="EN_ind_modifi"        Tipo="NUMBER"> indicador precio limite perfil</param>
            <param nom="EV_origen"            Tipo="STRING"> origen autorizaci�n</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_Sql:= 'INSERT INTO ga_autoriza (num_venta, lin_autoriza, cod_oficina,'
                     || ' cod_estado, num_autoriza, cod_vendedor,'
                     || ' num_unidades, fec_venta,prc_origin,'
                     || ' ind_tipventa, cod_cliente, cod_modventa,'
                     || ' nom_usuar_vta, cod_concepto, imp_cargo,'
                     || ' cod_moneda, num_abonado, num_serie,'
                     || ' cod_concepto_dto, val_dto, tip_dto,'
                     || ' ind_modifi, origen)'
                     || ' VALUES (' || EN_num_venta || ',' || EN_lin_autoriza || ',''' || EV_cod_oficina || ''','
                     || EV_cod_estado || ''',' ||  EN_num_autoriza || ',' || EN_cod_vendedor || ','
                     || EN_num_unidades || ',' || SYSDATE || ',' || EN_prc_origin || ','
                     || EN_ind_tipventa || ',' || EN_cod_cliente || ',' || EN_cod_modventa || ','''
                     || EV_nom_usuar_vta || ''',' || EN_cod_concepto || ',' || EN_imp_cargo || ','''
                     ||    EV_cod_moneda || ''',' || EN_num_abonado || ',''' || EV_num_serie || ''','
                     || EN_cod_concepto_dto || ',' || EN_val_dto || ',' || EN_tip_dto || ','
                     || EN_ind_modifi || ',''' || EV_origen || '''';

            INSERT INTO ga_autoriza (num_venta, lin_autoriza, cod_oficina, cod_estado,
                                     num_autoriza, cod_vendedor, num_unidades, fec_venta,
                                     prc_origin, ind_tipventa, cod_cliente, cod_modventa,
                                     nom_usuar_vta, cod_concepto, imp_cargo, cod_moneda,
                                     num_abonado, num_serie, cod_concepto_dto, val_dto,
                                     tip_dto, ind_modifi, origen)
            VALUES   (EN_num_venta, EN_lin_autoriza, EV_cod_oficina, EV_cod_estado,
                      EN_num_autoriza, EN_cod_vendedor, EN_num_unidades, SYSDATE,
                      EN_prc_origin, EN_ind_tipventa, EN_cod_cliente, EN_cod_modventa,
                      EV_nom_usuar_vta, EN_cod_concepto, EN_imp_cargo, EV_cod_moneda,
                      EN_num_abonado, EV_num_serie, EN_cod_concepto_dto, EN_val_dto,
                      EN_tip_dto, EN_ind_modifi, EV_origen);

        EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ins_sol_autorizacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ins_sol_autorizacion_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_ins_sol_autorizacion_PR;

    PROCEDURE VE_con_sol_autorizacion_PR(EN_num_autoriza     IN  ga_autoriza.num_autoriza%TYPE,
                                         SV_cod_estado       OUT NOCOPY ga_autoriza.cod_estado%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_sol_autorizacion_PR"
            Lenguaje="PL/SQL"
            Fecha="01-06-2007"
            Version="1.0.0"
            Dise?ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Consulta estado de la solicitud de autorizaci�n de aumentar el rango de descuento asociado al vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_autoriza"      Tipo="NUMBER"> n�mero correlativo de la solicitud de autorizaci�n</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_Sql:= 'SELECT autorizaDescuento.cod_estado'
                     || ' FROM ga_autoriza autorizaDescuento'
                     || ' WHERE autorizaDescuento.num_autoriza = ' || EN_num_autoriza
                     || ' AND ROWNUM <2';

            SELECT autorizaDescuento.cod_estado
            INTO SV_cod_estado
            FROM ga_autoriza autorizaDescuento
            WHERE autorizaDescuento.num_autoriza = EN_num_autoriza
            AND ROWNUM <2;

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_sol_autorizacion_PR(' || EN_num_autoriza || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_sol_autorizacion_PR(' || EN_num_autoriza || ')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_sol_autorizacion_PR(' || EN_num_autoriza || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_con_sol_autorizacion_PR(' || EN_num_autoriza || ')', LV_Sql, SQLCODE, LV_des_error );
        END VE_con_sol_autorizacion_PR;

        PROCEDURE VE_con_modalidadpago_PR (EN_cod_modventa  IN  ge_modventa.cod_modventa%TYPE,
                                             SV_des_modventa  OUT ge_modventa.des_modventa%TYPE,
                                           SN_indcuotas     OUT NOCOPY ge_modventa.ind_cuotas%TYPE,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentaci�n TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_modalidadpago_PR"
            Lenguaje="PL/SQL"
            Fecha="07-06-2007"
            Versi�n="1.0.0"
            Dise�ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>Modalidad de Pago </Retorno>
        <Descripci�n>
            Modalidad de Pago
        </Descripci�n>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_modventa"  Tipo="VARCHAR2">codigo de tipo de contrato</param>
        </Entrada>
        <Salida>
            <param nom="SV_des_modventa"  Tipo="STRING">descripci�n modalidad de pago</param>
            <param nom="SN_indcuotas"    Tipo="NUMBER">indicador cuotas</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci�n>
        */
        IS

               LV_des_error      ge_errores_pg.desevent;
            LV_Sql              ge_errores_pg.vquery;
              LN_cod_retorno    ge_errores_pg.CodError;
            LV_mens_retorno   ge_errores_pg.MsgError;
            LN_num_evento     ge_errores_pg.Evento;
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            LV_Sql:= 'SELECT mod_venta.des_modventa, mod_venta.ind_cuotas'
                    || ' SELECT mod_venta.des_modventa, mod_venta.ind_cuotas'
                    || ' WHERE mod_venta.cod_modventa = ' || EN_cod_modventa;

            SELECT mod_venta.des_modventa, mod_venta.ind_cuotas
            INTO SV_des_modventa, SN_indcuotas
            FROM ge_modventa mod_venta
            WHERE mod_venta.cod_modventa = EN_cod_modventa;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_modalidadpago_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_con_modalidadpago_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_modalidadpago_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_con_modalidadpago_PR()', LV_Sql, SQLCODE, LV_des_error );
        END VE_con_modalidadpago_PR;

        PROCEDURE VE_con_tipocontrato_PR (EN_cod_producto    IN  NUMBER,
                                          EV_cod_tipcontrato IN  ga_tipcontrato.cod_tipcontrato%TYPE,
                                          SV_des_tipcontrato OUT NOCOPY ga_tipcontrato.des_tipcontrato%TYPE,
                                          SN_ind_comodato    OUT NOCOPY ga_tipcontrato.ind_comodato%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentaci�n TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_tipocontrato_PR"
            Lenguaje="PL/SQL"
            Fecha="07-06-2007"
            Versi�n="1.0.0"
            Dise�ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>Tipo Contrato</Retorno>
        <Descripci�n>
            Consulta tipo contrato
        </Descripci�n>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_producto"    Tipo="NUMBER">codigo producto</param>
            <param nom="EV_cod_tipcontrato" Tipo="STRING">codigo tipo contrato</param>
        </Entrada>
        <Salida>
            <param nom="SV_des_tipcontrato" Tipo="STRING">descripci�n tipo contrato</param>
            <param nom="SN_ind_comodato"    Tipo="NUMBER">indicador comodato</param>
            <param nom="SN_cod_retorno"     Tipo="NUMBER">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"    Tipo="STRING">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"      Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci�n>
        */
        IS
            LV_des_error  ge_errores_pg.desevent;
            LV_Sql        ge_errores_pg.vquery;
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            LV_Sql:= 'SELECT tipocontrato.des_tipcontrato, tipocontrato.ind_comodato'
                    || ' INTO SN_indcomodato'
                    || ' FROM ga_tipcontrato tipocontrato'
                    || ' WHERE tipocontrato.cod_producto = ' || EN_cod_producto
                    || ' AND tipocontrato.cod_tipcontrato = ''' || EV_cod_tipcontrato || '''';

            SELECT tipocontrato.des_tipcontrato, tipocontrato.ind_comodato
            INTO   SV_des_tipcontrato, SN_ind_comodato
            FROM   ga_tipcontrato tipocontrato
            WHERE  tipocontrato.cod_producto = EN_cod_producto
            AND    tipocontrato.cod_tipcontrato = EV_cod_tipcontrato;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_tipocontrato_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_con_tipocontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_tipocontrato_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_con_tipocontrato_PR()', LV_Sql, SQLCODE, LV_des_error );
        END VE_con_tipocontrato_PR;

        PROCEDURE VE_con_producto_PR (EN_cod_producto  IN  ge_productos.cod_producto%TYPE,
                                      SV_des_producto  OUT NOCOPY ge_productos.des_producto%TYPE,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentaci�n TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_producto_PR"
            Lenguaje="PL/SQL"
            Fecha="07-06-2007"
            Versi�n="1.0.0"
            Dise�ador="H�ctor Hermosilla"
            Programador="H�ctor Hermosilla"
            Ambiente="BD"
        <Retorno>Producto</Retorno>
        <Descripci�n>
            Consulta producto
        </Descripci�n>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_producto"    Tipo="NUMBER">codigo producto</param>
        </Entrada>
        <Salida>
            <param nom="SV_des_producto" Tipo="STRING">descripci�n producto</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci�n>
        */
        IS
            LV_des_error  ge_errores_pg.desevent;
            LV_Sql        ge_errores_pg.vquery;
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            LV_Sql:= 'SELECT productos.des_producto'
                    || ' FROM   ge_productos productos'
                    || ' FROM ga_tipcontrato tipocontrato'
                    || ' WHERE  productos.cod_producto = ' || EN_cod_producto;

            SELECT productos.des_producto
            INTO   SV_des_producto
            FROM   ge_productos productos
            WHERE  productos.cod_producto = EN_cod_producto;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno:=1;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_con_producto_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_con_producto_PR()', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=156;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno:=CV_error_no_clasif;
                    END IF;
                    LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_con_producto_PR();- ' || SQLERRM;
                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                    'PV_SERVICIOS_POSVENTA_PG.VE_con_producto_PR()', LV_Sql, SQLCODE, LV_des_error );
    END VE_con_producto_PR;

    PROCEDURE VE_updAbocelClaseServ_PR(EN_numAbonado    IN ga_abocel.num_abonado%TYPE,
                                       EV_claseServ     IN ga_abocel.clase_servicio%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updAbocelClaseServ_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Actualiza clase servicio del abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_numAbonado"    Tipo="NUMBER"> numero abonado </param>
            <param nom="EV_claseServ"     Tipo="STRING"> clase servicio </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql := 'UPDATE ga_abocel'
                       ||' SET clase_servicio = ' || EV_claseServ
                       ||' WHERE num_abonado = ' || EN_numAbonado;

            UPDATE ga_abocel
            SET clase_servicio = EV_claseServ
            WHERE num_abonado = EN_numAbonado;

    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_updAbocelClaseServ_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_updAbocelClaseServ_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_updAbocelClaseServ_PR;

    PROCEDURE VE_updEquipAboser_PR(EV_numAbonado    IN VARCHAR2,
                                   EV_numSerie      IN VARCHAR2,
                                   EV_fecAlta       IN VARCHAR2,
                                   EV_numMOvto      IN VARCHAR2,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updEquipAboser_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Actualiza equipaboser : numero de movimiento
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_numAbonado"    Tipo="STRING"> numero abonado </param>
            <param nom="EV_numSerie"      Tipo="STRING"> numero serie </param>
            <param nom="EV_numMovto"      Tipo="STRING"> numero movimiento </param>
            <param nom="EV_fecAlta"       Tipo="STRING"> fecha alta </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        ERROR_SQL       EXCEPTION;
        LV_des_error    ge_errores_pg.DesEvent;
        LV_sSql         ge_errores_pg.vQuery;
        LV_formatofecha VARCHAR2(20);
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL2
            Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_FORMATO_FECHA,
                                                                CV_MODULO_GE,
                                                                CV_PRODUCTO,
                                                                LV_formatofecha,
                                                                SN_cod_retorno,
                                                                SV_mens_retorno,
                                                                SN_num_evento);
            IF (SN_cod_retorno <> 0) THEN
                RAISE ERROR_SQL;
            END IF;

            LV_sSql := 'UPDATE ga_equipaboser'
                       ||' SET num_movimiento = ' || EV_numMovto
                       ||' WHERE num_abonado = ' || EV_numAbonado
                       ||' AND num_serie = ' || EV_numSerie
                       ||' AND fec_alta = TO_DATE(' || EV_fecAlta || ',' || LV_formatofecha || ')';

            UPDATE ga_equipaboser
            SET num_movimiento = EV_numMovto
            WHERE num_abonado = EV_numAbonado
            AND num_serie = EV_numSerie
            AND fec_alta = TO_DATE(EV_fecAlta , LV_formatofecha );

    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_updEquipAboser_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_updEquipAboser_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_updEquipAboser_PR;

    PROCEDURE VE_insReservaArticulo_PR(EV_num_linea     IN VARCHAR2,
                                       EV_num_orden     IN VARCHAR2,
                                       EV_cod_articulo  IN VARCHAR2,
                                       EV_cod_producto  IN VARCHAR2,
                                       EV_cod_bodega    IN VARCHAR2,
                                       EV_tip_stock     IN VARCHAR2,
                                       EV_cod_uso       IN VARCHAR2,
                                       EV_cod_estado    IN VARCHAR2,
                                       EV_nom_usuario   IN VARCHAR2,
                                       EV_num_serie     IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insReservaArticulo_PR
            Lenguaje="PL/SQL"
            Fecha="19-06-2007"
            Version="1.0.0"
            Disenador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Inserta reserva del articulo
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_num_linea"    Tipo="STRING"> numero linea </param>
            <param nom="EV_num_orden"    Tipo="STRING"> numero orden </param>
            <param nom="EV_cod_articulo" Tipo="STRING"> codigo articulo </param>
            <param nom="EV_cod_producto" Tipo="STRING"> codigo producto </param>
            <param nom="EV_cod_bodega"   Tipo="STRING"> codigo bodega </param>
            <param nom="EV_tip_stock"    Tipo="STRING"> tipo stock </param>
            <param nom="EV_cod_uso"      Tipo="STRING"> codigo uso </param>
            <param nom="EV_cod_estado"   Tipo="STRING"> codigo estado </param>
            <param nom="EV_nom_usuario"  Tipo="STRING"> nombre usuario </param>
            <param nom="EV_num_serie"    Tipo="STRING"> numero serie </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
        --PRAGMA AUTONOMOUS_TRANSACTION;
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM ga_reservart a
            WHERE a.NUM_SERIE = EV_num_serie;

            IF (LN_contador > 0) THEN
               RAISE LE_exception_fin;
            END IF;

            -- obtener numero de transaccion
            LV_sSql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
            VE_intermediario_PG.VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            IF SN_cod_retorno <> 0 THEN
                RAISE LE_exception_fin;
            END IF;

            LV_sSql := 'INSERT INTO ga_reservart (num_transaccion,'
                    || 'num_linea, num_orden, cod_articulo, cod_producto, '
                    || 'fec_reserva, cod_bodega, tip_stock, cod_uso, cod_estado, '
                    || 'num_unidades, nom_usuario, num_serie) '
                    || 'VALUES (' || LN_num_transaccion
                    || ',' || EV_num_linea
                    || ',' || EV_num_orden
                    || ',' || EV_cod_articulo
                    || ',' || EV_cod_producto
                    || ',SYSDATE'
                    || ',' || EV_cod_bodega
                    || ',' || EV_tip_stock
                    || ',' || EV_cod_uso
                    || ',' || EV_cod_estado
                    || ',1'
                    || ',' || EV_nom_usuario
                    || ',' || EV_num_serie || ')';

            INSERT INTO ga_reservart(num_transaccion,
                                     num_linea,
                                     num_orden,
                                     cod_articulo,
                                     cod_producto,
                                     fec_reserva,
                                     cod_bodega,
                                     tip_stock,
                                     cod_uso,
                                     cod_estado,
                                     num_unidades,
                                     nom_usuario,
                                     num_serie)
            VALUES ( LN_num_transaccion
                    ,EV_num_linea
                    ,EV_num_orden
                    ,EV_cod_articulo
                    ,EV_cod_producto
                    ,SYSDATE
                    ,EV_cod_bodega
                    ,EV_tip_stock
                    ,EV_cod_uso
                    ,EV_cod_estado
                    ,1
                    ,EV_nom_usuario
                    ,EV_num_serie);
    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.VE_insReservaArticulo_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_insReservaArticulo_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_insReservaArticulo_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_insReservaArticulo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_insReservaArticulo_PR;

    PROCEDURE VE_ActualizaStock_PR (EV_TipMov        IN VARCHAR2,
                                    EV_TipStock         IN VARCHAR2,
                                    EV_CodBodega     IN VARCHAR2,
                                    EV_CodArticulo     IN VARCHAR2,
                                    EV_CodUso         IN VARCHAR2,
                                    EV_CodEstado     IN VARCHAR2,
                                    EV_NumVenta         IN VARCHAR2,
                                    EV_Numserie         IN VARCHAR2,
                                    SV_numMovto      OUT NOCOPY VARCHAR2,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS


    /*
    <Documentaci�n TipoDoc = "Procedimiento">
    <Elemento Nombre = "VE_ActualizaStock_PR"
    Lenguaje="PL/SQL"
    Fecha="19-06-2007"
    Versi�n="1.0.0"
    Dise�ador="wjrc"
    Programador="wjrc"
    Ambiente="BD">
    <Retorno>
              Numero de movimiento
    </Retorno>
    <Descripci�n>
                  Actualiza stock del articulo
    </Descripci�n>
    <Par�metros>
        <Entrada>
            <param nom="EV_TipMov"      Tipo="STRING"> tipo movimiento </param>
            <param nom="EV_TipStock"    Tipo="STRING"> tipo stock </param>
            <param nom="EV_CodBodega"   Tipo="STRING"> codigo bodega </param>
            <param nom="EV_CodArticulo" Tipo="STRING"> codigo articulo </param>
            <param nom="EV_CodUso"      Tipo="STRING"> codigo uso </param>
            <param nom="EV_CodEstado"   Tipo="STRING"> codigo estado </param>
            <param nom="EV_NumVenta"    Tipo="STRING"> numero venta </param>
            <param nom="EV_Numserie"    Tipo="STRING"> numero serie </param>
        </Entrada>
        <Salida>
            <param nom="SV_numMovto"      Tipo="STRING"> numero de movimiento </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Par�metros>
    </Elemento>
    </Documentaci�n>
    */
        PRAGMA AUTONOMOUS_TRANSACTION;
        LE_EXCEPTION_FIN   EXCEPTION;
        LV_des_error        ge_errores_pg.desevent;
        LV_Sql                ge_errores_pg.vquery;

        LA_arreglo VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();
            -- (1) numero movimiento

        LN_num_transaccion NUMBER;
                LV_cadena                  VARCHAR2(400);
    BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        -- obtener numero de transaccion
        LV_Sql := 'VE_intermediario_PG.VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
        VE_intermediario_PG.VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF (SN_cod_retorno <> 0) THEN
            RAISE LE_EXCEPTION_FIN;
        END IF;

        -- llamar procedimiento de p_ga_interal
        LV_Sql := 'P_GA_INTERAL(' || LN_num_transaccion || ','
                                  || EV_TipMov || ','
                                   || EV_TipStock || ','
                                   || EV_CodBodega || ','
                                   || EV_CodArticulo || ','
                                   || EV_CodUso || ','
                                   || EV_CodEstado || ','
                                   || EV_NumVenta || ','
                                   || '1,'
                                   || EV_Numserie || ','
                                   || '1)';

        P_GA_INTERAL(LN_num_transaccion,
                     EV_TipMov,
                     EV_TipStock,
                     EV_CodBodega,
                     EV_CodArticulo,
                     EV_CodUso,
                     EV_CodEstado,
                     EV_NumVenta,
                     '1',
                     EV_Numserie,
                     '1');

        -- verificamos estado del llamado
        LV_Sql := 'VE_intermediario_PG.VE_obtiene_transaccion_PR('||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
        VE_intermediario_PG.VE_obtiene_transaccion_PR(LN_num_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

        LV_cadena := SV_mens_retorno;

        IF (SN_cod_retorno = 0) THEN

            LA_arreglo := VE_intermediario_PG.VE_descompone_cadena_FN(LV_cadena,'/', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

            IF (SN_cod_retorno <> 0) THEN
                RAISE LE_EXCEPTION_FIN;
            END IF;
            SV_numMovto := LA_arreglo(1);

        ELSE
            RAISE LE_EXCEPTION_FIN;
        END IF;

       COMMIT;

    EXCEPTION
        WHEN LE_EXCEPTION_FIN THEN
                LV_des_error:='LE_EXCEPTION_FIN: PV_SERVICIOS_POSVENTA_PG.VE_ActualizaStock_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_ActualizaStock_PR', LV_Sql, SQLCODE, LV_des_error );
                ROLLBACK;
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ActualizaStock_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_ActualizaStock_PR', LV_Sql, SQLCODE, LV_des_error );
                ROLLBACK;
    END VE_ActualizaStock_PR;

    PROCEDURE VE_getListPlanTarifario_PR(EV_indComercial  IN NUMBER,
                                          SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

                /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getListPlanTarifario_PR
                Lenguaje="PL/SQL"
                Fecha="21-06-2007"
                Version="1.0.0"
                Dise?ador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
            <Retorno>
                      cursor
            </Retorno>
            <Descripcion>
                Obtiene planes tarifarios : comercializables y no comercializables
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_indComercial"       Tipo="STRING"> indicador comercializable </param>
                            0 : todos
                            1 : conercializable
                            2 : no comercializable
            </Entrada>
            <Salida>
                <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
            NO_DATA_FOUND_CURSOR EXCEPTION;
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LN_contador  NUMBER;
        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LN_contador := 0;

            IF (EV_indComercial = 0) THEN
            -- Planes vigentes y no vigentes

                SELECT COUNT(1)
                INTO LN_contador
                FROM ta_plantarif a;

                LV_sql:= 'SELECT a.cod_plantarif, a.des_plantarif '
                  || ' FROM ta_plantarif a ';

            ELSIF (EV_indComercial = 1) THEN
            -- Planes comercializable (est�n vigente al d�a de hoy)

                SELECT COUNT(1)
                INTO LN_contador
                FROM ta_plantarif a
                WHERE SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE);

                LV_sql:= 'SELECT a.cod_plantarif, a.des_plantarif '
                  || ' FROM ta_plantarif a '
                  || ' WHERE SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';

            ELSE
            -- Plan no comercializable (no est� vigente)

                SELECT COUNT(1)
                INTO LN_contador
                FROM ta_plantarif a
                WHERE NOT (SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE));

                LV_sql:= 'SELECT a.cod_plantarif, a.des_plantarif '
                  || ' FROM ta_plantarif a '
                  || ' WHERE NOT (SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE))';

            END IF;

            OPEN SC_cursordatos FOR LV_Sql;

            IF (LN_contador = 0) THEN
                RAISE NO_DATA_FOUND_CURSOR;
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_cod_retorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                 END IF;
                 LV_desError     := SUBSTR('NO_DATA_FOUND_CURSOR:PV_SERVICIOS_POSVENTA_PG.VE_getListPlanTarifario_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER, 'PV_SERVICIOS_POSVENTA_PG.VE_getListPlanTarifario_PR', LV_Sql, SN_cod_retorno, LV_desError );
            WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_desError:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_getListPlanTarifario_PR(' || EV_indComercial || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_getListPlanTarifario_PR(' || EV_indComercial || ')', LV_Sql, SQLCODE, LV_desError );
    END VE_getListPlanTarifario_PR;

    PROCEDURE VE_getEmpresaCte_PR(EV_codCliente    IN VARCHAR2,
                                  SV_numAbonados   OUT NOCOPY VARCHAR2,
                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getEmpresaCte_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Recupera datos de la empresa para el cliente
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_codCliente"    Tipo="STRING"> codigo cliente</param>
        </Entrada>
        <Salida>
            <param nom="SV_numAbonados"   Tipo="STRING"> numero de abonados</param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql := 'SELECT a.num_abonados'
                       ||' FROM ga_empresa a '
                       ||' WHERE a.cod_cliente = ' || EV_codCliente;

            SELECT a.num_abonados
            INTO SV_numAbonados
            FROM ga_empresa a
            WHERE a.cod_cliente = EV_codCliente;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_getEmpresaCte_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_getEmpresaCte_PR', LV_sSql, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_getEmpresaCte_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_getEmpresaCte_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_getEmpresaCte_PR;

    PROCEDURE VE_updEmpresaAbonados_PR(EV_codCliente    IN VARCHAR2,
                                       EV_cantidad      IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updEmpresaAbonados_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Actualiza cantidad de abonados de la empresa para el cliente
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_codCliente"    Tipo="STRING"> codigo cliente</param>
            <param nom="EV_cantidad"      Tipo="STRING"> cantidad clientes </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql := 'UPDATE ga_empresa a'
                       ||' SET a.num_abonados = a.num_abonados + ' || EV_cantidad
                       ||' WHERE a.cod_cliente = ' || EV_codCliente;

            UPDATE ga_empresa a
            SET a.num_abonados = a.num_abonados + EV_cantidad
            WHERE a.cod_cliente = EV_codCliente;

    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_updEmpresaAbonados_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_updEmpresaAbonados_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_updEmpresaAbonados_PR;

    PROCEDURE VE_updAbocelCodSituac_PR(EN_numVenta      IN VARCHAR2,
                                       EV_codSituacion  IN VARCHAR2,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updAbocelCodSituac_PR
            Lenguaje="PL/SQL"
            Fecha="07-05-2007"
            Version="1.0.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Actualiza codigo situacion del abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_numVenta"       Tipo="NUMBER"> numero venta </param>
            <param nom="EV_codSituacion"   Tipo="STRING"> codigo situacion </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql := 'UPDATE ga_abocel'
                       ||' SET cod_situacion = ' || EV_codSituacion
                       ||' WHERE num_venta = ' || EN_numVenta;

            UPDATE ga_abocel
            SET cod_situacion = EV_codSituacion
            WHERE num_venta = EN_numVenta;

    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_updAbocelCodSituac_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_updAbocelCodSituac_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_updAbocelCodSituac_PR;

    PROCEDURE VE_validaHomeVendCel_PR(EN_codVendedor  IN  VARCHAR2,
                                      EV_numCelular   IN  VARCHAR2,
                                      SN_resultado    OUT NOCOPY NUMBER,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_validaHomeVendCel_PR"
        Lenguaje="PL/SQL"
        Fecha="10-04-2007"
        Version="1.0.0"
        Dise?ador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
    <Retorno>
        Retorna 0 si no encuentra datos
    </Retorno>
    <Descripcion>
        Verifica si el home del celular corresponde al home del vendedor
    </Descripcion>
    <Parametros>
    <Entrada>
            <param nom="EV_codVendedor" Tipo="STRING"> codigo vendedor/param>
            <param nom="EV_numCelular"  Tipo="STRING"> codigo vendedor/param>
    </Entrada>
    <Salida>
            <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    */
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno :='';
        SN_resultado    := 0;

        LV_sSql:= 'SELECT COUNT(1)'
        || ' FROM ga_celnum_uso a,'
        || ' ta_subcentral b,'
        || ' ge_celdas c,'
        || ' ge_ciudades d,'
        || ' ge_oficinas e,'
        || ' ve_vendedores f'
        || ' WHERE ' || EV_numCelular || ' BETWEEN a.num_desde AND a.num_hasta'
        || ' AND a.cod_central = b.cod_central'
        || ' AND a.cod_subalm = b.cod_subalm'
        || ' AND b.cod_subalm = c.cod_subalm'
        || ' AND c.cod_celda = d.cod_celda'
        || ' AND d.cod_region = e.cod_region'
        || ' AND d.cod_provincia = e.cod_provincia'
        || ' AND e.cod_oficina = f.cod_oficina'
        || ' AND f.cod_vendedor = ' || EN_codVendedor;

        SELECT COUNT(1)
        INTO SN_resultado
        FROM ga_celnum_uso a,
             ta_subcentral b,
             ge_celdas c,
             ge_ciudades d,
             ge_oficinas e,
             ve_vendedores f
        WHERE EV_numCelular BETWEEN a.num_desde AND a.num_hasta
          AND a.cod_central = b.cod_central
          AND a.cod_subalm = b.cod_subalm
          AND b.cod_subalm = c.cod_subalm
          AND c.cod_celda = d.cod_celda
          AND d.cod_region = e.cod_region
          AND d.cod_provincia = e.cod_provincia
          AND e.cod_oficina = f.cod_oficina
          AND f.cod_vendedor = EN_codVendedor;

        IF (SN_resultado < 1) THEN

            LV_sSql:= 'SELECT COUNT(1)'
            || ' FROM ga_celnum_reutil a,'
            || ' ta_subcentral b,'
            || ' ge_celdas c,'
            || ' ge_ciudades d,'
            || ' ge_oficinas e,'
            || ' ve_vendedores f'
            || ' WHERE a.NUM_CELULAR = ' || EV_numCelular
            || ' AND a.cod_central = b.cod_central'
            || ' AND a.cod_subalm = b.cod_subalm'
            || ' AND b.cod_subalm = c.cod_subalm'
            || ' AND c.cod_celda = d.cod_celda'
            || ' AND d.cod_region = e.cod_region'
            || ' AND d.cod_provincia = e.cod_provincia'
            || ' AND e.cod_oficina = f.cod_oficina'
            || ' AND f.cod_vendedor = ' || EN_codVendedor;

            SELECT COUNT(1)
            INTO SN_resultado
            FROM ga_celnum_reutil a,
                 ta_subcentral b,
                 ge_celdas c,
                 ge_ciudades d,
                 ge_oficinas e,
                 ve_vendedores f
            WHERE a.NUM_CELULAR = EV_numCelular
              AND a.cod_central = b.cod_central
              AND a.cod_subalm = b.cod_subalm
              AND b.cod_subalm = c.cod_subalm
              AND c.cod_celda = d.cod_celda
              AND d.cod_region = e.cod_region
              AND d.cod_provincia = e.cod_provincia
              AND e.cod_oficina = f.cod_oficina
              AND f.cod_vendedor = EN_codVendedor;
        END IF;

    EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_validaHomeVendCel_PR('|| EN_codVendedor ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_validaHomeVendCel_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_validaHomeVendCel_PR;

    PROCEDURE VE_num_abonados_cliente_PR(EV_cod_cliente   IN  VARCHAR2,
                                           EV_cod_plantarif IN  VARCHAR2,
                                         SN_resultado     OUT NOCOPY NUMBER,
                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_num_abonados_cliente_PR"
        Lenguaje="PL/SQL"
        Fecha="31-07-2007"
        Version="1.0.0"
        Dise?ador="H�ctor Hermosilla"
        Programador="H�ctor Hermosilla"
        Ambiente="BD"
    <Retorno>
        cantidad de abonados asociados al cliente
    </Retorno>
    <Descripcion>
         Devuelve cantidad de abonados asociados al cliente
    </Descripcion>
    <Parametros>
    <Entrada>
            <param nom="EV_cod_cliente"  Tipo="STRING"> codigo cliente</param>
            <param nom="EV_cod_plantarif" Tipo="STRING"> codigo plan tarifario</param>
    </Entrada>
    <Salida>
            <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    */
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno :='';
        SN_resultado    := 0;

        LV_sSql:= 'SELECT COUNT(1)'
        || ' FROM ga_abocel a,'
        || ' WHERE cod_cliente =' || EV_cod_cliente
        || ' AND cod_plantarif =' || EV_cod_plantarif
        || ' AND cod_situacion NOT IN (' || CV_BAJA_ABONADO || ',' || CV_BAJA_ABONADOPDTE || ')';


        SELECT COUNT(1)
        INTO SN_resultado
        FROM ga_abocel
        WHERE cod_cliente = EV_cod_cliente
        AND cod_plantarif = EV_cod_plantarif
        AND cod_situacion NOT IN (CV_BAJA_ABONADO,CV_BAJA_ABONADOPDTE);


    EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_num_abonados_cliente_PR('|| EV_cod_cliente ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_num_abonados_cliente_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_num_abonados_cliente_PR;

    PROCEDURE VE_Cambia_modalidad_PR(EN_NUM_SERIE            IN  AL_SERIES.NUM_SERIE%TYPE,
                                       EN_CANAL                IN  VARCHAR2,
                                     EN_COD_MODVENTA_ORIGEN  IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                     SN_MODVENTA             OUT GE_MODVENTA.COD_MODVENTA%TYPE,
                                     SN_DESMODVENTA          OUT GE_MODVENTA.DES_MODVENTA%TYPE,
                                     SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_Cambia_modalidad_PR""
        Lenguaje="PL/SQL"
        Fecha="23-08-2007"
        Version="1.0.0"
        Dise?ador="NRCA"
        Programador="NRCA"
        Ambiente="BD"
    <Retorno>

    </Retorno>
    <Descripcion>
         Devuelve cantidad de abonados asociados al cliente
    </Descripcion>
    <Parametros>
    <Entrada>
            <param nom="EN_NUM_SERIE"  Tipo="STRING"> N�MERO DE SERIE </param>
            <param nom="EN_CANAL" Tipo="STRING"> CODIGO CANAL DEL VENDEDOR </param>
            <param nom="EN_COD_MODVENTA_ORIGEN" Tipo="STRING"> CODIGO DE MODALIDAD DE VENTA ORIGEN </param>
    </Entrada>
    <Salida>
            <param nom="SN_MODVENTA"    Tipo="NUMBER"> CODIGO DE MODALIDAD DE VENTA NUEVA</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    */
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        EV_tipstock  AL_SERIES.TIP_STOCK%TYPE;
    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno :='';


        LV_sSql:= 'SELECT TIP_STOCK'
            || ' FROM AL_SERIES'
            || ' WHERE NUM_SERIE = '|| EN_NUM_SERIE;


        SELECT TIP_STOCK
        INTO EV_tipstock
        FROM AL_SERIES
        WHERE NUM_SERIE=EN_NUM_SERIE;


         BEGIN
             LV_sSql:= 'SELECT COD_MODVENTA_NUE'
            || ' FROM GA_MODVENT_APLIC'
            || ' WHERE COD_PRODUCTO =1'
            || ' AND COD_CANAL =' || EN_CANAL
            || ' AND TIP_STOCK =' || EV_tipstock
            || ' AND (COD_APLIC LIKE %GAC% OR COD_APLIC LIKE %GVD%)';

            -- 0 INTERNO 1 EXTERNO
            SELECT COD_MODVENTA_NUE
            INTO SN_MODVENTA
            FROM GA_MODVENT_APLIC
            WHERE COD_PRODUCTO =1
            AND COD_CANAL = DECODE(UPPER(EN_CANAL),'D',0,1)
            AND TIP_STOCK = EV_tipstock
            AND COD_MODVENTA= EN_COD_MODVENTA_ORIGEN
            AND (COD_APLIC IS NULL)
            AND COD_MODVENTA_NUE IS NOT NULL;


            IF SN_MODVENTA IS NULL THEN
               SN_MODVENTA:=    EN_COD_MODVENTA_ORIGEN;
               SN_cod_retorno  := 0;
            END IF;

            LV_sSql:= 'SELECT DES_MODVENTA'
            || ' FROM GE_MODVENTA'
            || ' WHERE COD_MODVENTA = ' || SN_MODVENTA;


            SELECT DES_MODVENTA
            INTO SN_DESMODVENTA
            FROM GE_MODVENTA
            WHERE COD_MODVENTA=SN_MODVENTA;


         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  SN_MODVENTA:=    EN_COD_MODVENTA_ORIGEN;
                  SN_cod_retorno  := 0;
         END;

     EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_Cambia_modalidad_PR('|| EN_NUM_SERIE ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER ,'PV_SERVICIOS_POSVENTA_PG.VE_Cambia_modalidad_PR', LV_sSql, SN_cod_retorno, LV_des_error);

    END VE_Cambia_modalidad_PR;
---------------------------------------------------------------------------------------------------
    PROCEDURE VE_ObtieneComisPorCodVendedor(SO_TipComis IN OUT VE_TIPOS_PG.TIP_VE_TIPCOMIS,
                                         EN_cod_vendedor IN  ve_vendedores.cod_vendedor%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
/*--
  <Documentacion TipoDoc = "Procedimiento">
    Elemento Nombre = "VE_ObtieneComisPorCodVendedor
    Lenguaje="PL/SQL"
        Fecha="03-08-2007"
            Version="1.0.0"
            Dise�ador="Ra�l Lozano"
            Programador="Ra�l Lozano"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Actualiza Retorna registro de la tabla VE_TIPCOMIS en base al codigo vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_Cod_vendedor"   Tipo="ve_vendedor.cod_vendedor"> Estructura campo tabla ve_vendedor</param>
        </Entrada>
        <Salida>
            <param nom="SO_TipComis"      Tipo="SO_TipComis" Estructura de la Tabla ve_TipComis </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';


            LV_sSql := ' SELECT fec_ultmod,ind_cliente,ind_bodega,ind_vta_externa,ind_riesgo,ind_privilegio,cod_tipcomis,des_tipcomis,nom_usuario,'
                    || ' INTO SO_TipComis(1).fec_ultmod,SO_TipComis(1).ind_cliente,SO_TipComis(1).ind_bodega,SO_TipComis(1).ind_vta_externa,'
                       || '       SO_TipComis(1).ind_riesgo,SO_TipComis(1).ind_privilegio,SO_TipComis(1).cod_tipcomis,SO_TipComis(1).des_tipcomis,'
                    || '       SO_TipComis(1).nom_usuario'
                    || ' FROM   ve_tipcomis a, ve_vendedores b '
                    || ' WHERE  a.cod_tipcomis = b.cod_tipcomis '
                    || ' AND    b.cod_vendedor = '||EN_cod_vendedor;


            SELECT a.fec_ultmod,a.ind_cliente,a.ind_bodega,a.ind_vta_externa,a.ind_riesgo,a.ind_privilegio,a.cod_tipcomis,a.des_tipcomis,a.nom_usuario

            INTO SO_TipComis(1).fec_ultmod,SO_TipComis(1).ind_cliente,SO_TipComis(1).ind_bodega,SO_TipComis(1).ind_vta_externa,
                 SO_TipComis(1).ind_riesgo,SO_TipComis(1).ind_privilegio,SO_TipComis(1).cod_tipcomis,SO_TipComis(1).des_tipcomis,
                 SO_TipComis(1).nom_usuario

            FROM   ve_tipcomis a, ve_vendedores b

            WHERE  a.cod_tipcomis = b.cod_tipcomis

            AND    b.cod_vendedor = EN_cod_vendedor ;



    EXCEPTION
         WHEN OTHERS THEN
              SO_TipComis(1).fec_ultmod := null;
             SO_TipComis(1).ind_cliente := null;
             SO_TipComis(1).ind_bodega := null;
             SO_TipComis(1).ind_vta_externa := null;
             SO_TipComis(1).ind_riesgo := null;
             SO_TipComis(1).ind_privilegio := null;
             SO_TipComis(1).cod_tipcomis := null;
             SO_TipComis(1).des_tipcomis := null;
             SO_TipComis(1).nom_usuario := null;
             SN_cod_retorno:=1984;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ObtieneComisPorCodVendedor; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ObtieneComisPorCodVendedor', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_ObtieneComisPorCodVendedor;


    PROCEDURE VE_datosvendedor_PR (EN_codvendedor   IN  ve_vendedores.cod_vendedor%TYPE,
                                   EN_coddealer     IN  ve_vendealer.cod_vendealer%TYPE,
                                   SV_nomvendedor   OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
                                   SV_nomvendealer  OUT NOCOPY ve_vendealer.nom_vendealer%TYPE,
                                   SN_codcliente    OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
                                   SN_codvende_raiz OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                   SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                   SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                   SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                   SV_codoficina    OUT NOCOPY ve_vendedores.cod_oficina%TYPE,
                                   SV_codtipcomis   OUT NOCOPY ve_tipcomis.cod_tipcomis%TYPE,
                                   SV_destipcomis   OUT NOCOPY ve_tipcomis.des_tipcomis%TYPE,
                                   SN_indtipventa   OUT NOCOPY ve_vendedores.ind_tipventa%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
    /*--
    <Documentaci�n TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_datosvendedor_PR"
        Lenguaje="PL/SQL"
        Fecha="21-09-2007"
        Versi�n="1.0.0"
        Dise�ador="H�ctor Hermosilla"
        Programador="H�ctor Hermosilla"
        Ambiente="BD"
    <Retorno>Datos del vendedor</Retorno>
    <Descripci�n>
        Datos del vendedor externo
    </Descripci�n>
    <Parametros>
    <Entrada>
        <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
        <param nom="EN_coddealer"  Tipo="NUMBER">codigo de dealer</param>
    </Entrada>
    <Salida>
        <param nom="SV_nomvendedor"   Tipo="VARCHAR2">Nombre del vendedor</param>
        <param nom="SV_nomvendealer"  Tipo="VARCHAR2">Nombre del vendedor externo</param>
        <param nom="SN_codcliente"    Tipo="NUMBER">Codigo del cliente</param>
        <param nom="SN_codvende_raiz" Tipo="NUMBER">Codigo vendedor raiz</param>
        <param nom="SV_codregion"     Tipo="VARCHAR2">Codigo de region</param>
        <param nom="SV_codprovincia"  Tipo="VARCHAR2">Codigo de Provincia</param>
        <param nom="SV_codciudad"     Tipo="VARCHAR2">Codigo de ciudad</param>
        <param nom="SV_codoficina"    Tipo="VARCHAR2">Codigo oficina del vendedor</param>
        <param nom="SV_codtipcomis"   Tipo="VARCHAR2">Codigo tipo comisionista/param>
        <param nom="SV_destipcomis"   Tipo="VARCHAR2">descripcion tipo comisionista</param>
        <param nom="SN_indtipventa"   Tipo="NUMBER">Indicador tipo de venta</param>
        <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentaci�n>
    */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        IF (EN_coddealer = 0) THEN
            LV_sSql:= 'SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,'
                 || ' direccion.cod_region, direccion.cod_provincia,'
                 || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
                 || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa'
                 || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
                 || ' ve_tipcomis tipo_comisionista'
                 || ' WHERE  vend.cod_vendedor = ' || EN_codvendedor
                 || ' AND    vend.ind_interno = 1'
                 || ' AND    direccion.cod_direccion = vend.cod_direccion'
                 || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
                 || ' AND    tipo_comisionista.ind_vta_externa = 0';

            SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,
                   direccion.cod_region, direccion.cod_provincia,
                   direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,
                   tipo_comisionista.des_tipcomis, vend.ind_tipventa
            INTO   SV_nomvendedor, SN_codcliente, SN_codvende_raiz,
                   SV_codregion, SV_codprovincia,
                   SV_codciudad, SV_codoficina, SV_codtipcomis,
                   SV_destipcomis, SN_indtipventa
            FROM   ve_vendedores vend, ge_direcciones direccion,
                   ve_tipcomis tipo_comisionista
            WHERE  vend.cod_vendedor = EN_codvendedor
            AND    vend.ind_interno = 1
            AND    direccion.cod_direccion = vend.cod_direccion
            AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis
            AND    tipo_comisionista.ind_vta_externa = 0;

        ELSE

             LV_sSql:= 'SELECT vend.nom_vendedor,dealer.nom_vendealer, vend.cod_cliente,'
                 || ' vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia,'
                 || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
                 || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa'
                 || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
                 || ' ve_tipcomis tipo_comisionista,ve_vendealer dealer'
                 || ' WHERE  vend.cod_vendedor = ' || EN_codvendedor
                 || ' AND    vend.ind_interno = 0'
                 || ' AND    direccion.cod_direccion = vend.cod_direccion'
                 || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
                 || ' AND    tipo_comisionista.ind_vta_externa = 1'
                 || ' AND    vend.cod_vendedor = dealer.cod_vendedor'
                 || ' AND    dealer.cod_vendealer = ' || EN_coddealer;


            SELECT vend.nom_vendedor,dealer.nom_vendealer, vend.cod_cliente,
                   vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia,
                   direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,
                   tipo_comisionista.des_tipcomis, vend.ind_tipventa
            INTO   SV_nomvendedor, SV_nomvendealer, SN_codcliente, SN_codvende_raiz,
                   SV_codregion, SV_codprovincia,
                   SV_codciudad, SV_codoficina, SV_codtipcomis,
                   SV_destipcomis, SN_indtipventa
            FROM   ve_vendedores vend, ge_direcciones direccion,
                   ve_tipcomis tipo_comisionista,ve_vendealer dealer
            WHERE  vend.cod_vendedor = EN_codvendedor
            AND    vend.ind_interno = 0
            AND    direccion.cod_direccion = vend.cod_direccion
            AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis
            AND    tipo_comisionista.ind_vta_externa = 1
            AND    vend.cod_vendedor = dealer.cod_vendedor
            AND    dealer.cod_vendealer = EN_coddealer;
        END IF;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.VE_datosvendedor_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_datosvendedor_PR', LV_sSql, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_datosvendedor_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_datosvendedor_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_datosvendedor_PR;

    PROCEDURE VE_inserta_ga_docventa_PR(EN_NUM_VENTA    IN GA_DOCVENTA.NUM_VENTA%TYPE,
                                        EN_COD_TIPDOCUM IN GA_DOCVENTA.COD_TIPDOCUM%TYPE,
                                        EV_NUM_FOLIO    IN GA_DOCVENTA.NUM_FOLIO%TYPE,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

    /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_inserta_ga_docventa_PR
            Lenguaje="PL/SQL"
            Fecha="18-05-2007"
            Version="1.0.0"
            Dise?ador="Ra�l Lozano"
            Programador="Ra�l Lozano"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Inserta en ga_docventa
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_NUM_VENTA"     Tipo="NUMBER"> numero de venta </param>
            <param nom="EN_COD_TIPDOCUM"  Tipo="NUMBER"> c�digo tipo de docto </param>
            <param nom="EV_NUM_FOLIO"     Tipo="VARCHAR2"> numero folio</param>
        <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
           LV_sSql      ge_errores_pg.vQuery;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql:= 'INSERT INTO ga_docventa'
                     || '(num_venta, cod_tipdocum, num_folio)'
                     ||'VALUES ('
                     || EN_NUM_VENTA ||','|| EN_COD_TIPDOCUM ||','|| EV_NUM_FOLIO ||')';
                     --|| SO_gaDocVenta(1).num_venta||','||SO_gaDocVenta(1).cod_tipdocum||','||SO_gaDocVenta(1).num_folio||')';

            INSERT INTO ga_docventa (num_venta, cod_tipdocum, num_folio)
            VALUES (EN_NUM_VENTA, EN_COD_TIPDOCUM, EV_NUM_FOLIO);
            --VALUES (SO_gaDocVenta(1).num_venta,SO_gaDocVenta(1).cod_tipdocum,SO_gaDocVenta(1).num_folio);


        EXCEPTION
            WHEN OTHERS THEN
--                  SN_cod_retorno:= 1305; --No es posible registrar documento de venta
--                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
--                     SV_mens_retorno := CV_error_no_clasIF;
--                  END IF;
--                  --LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_inserta_contrato_PR; - '|| SQLERRM,1,CN_largoerrtec);
--                  --SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
--                 -- SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
--                  --'PV_SERVICIOS_POSVENTA_PG.VE_inserta_contrato_PR', LV_sSql, SN_cod_retorno, LV_des_error );

             SN_cod_retorno:=1305;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_inserta_ga_docventa_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_inserta_ga_docventa_PR', LV_sSql, SN_cod_retorno, LV_des_error );


    END VE_inserta_ga_docventa_PR;


    PROCEDURE VE_inserta_al_PetiGiasAbo_PR( EN_cod_articulo IN al_petiguias_abo.cod_articulo%TYPE,
                                            EN_cod_bodega   IN al_petiguias_abo.cod_bodega%TYPE,
                                            EN_cod_cliente  IN al_petiguias_abo.cod_cliente%TYPE,
                                            EN_cod_concepto IN al_petiguias_abo.cod_concepto%TYPE,
                                            EV_cod_moneda   IN al_petiguias_abo.cod_moneda%TYPE,
                                            EV_cod_oficina  IN al_petiguias_abo.cod_oficina%TYPE,
                                            EN_num_abonado  IN al_petiguias_abo.num_abonado%TYPE,
                                            EN_num_cantidad IN al_petiguias_abo.num_cantidad%TYPE,
                                            EN_num_cargo    IN al_petiguias_abo.num_cargo%TYPE,
                                            EN_num_orden    IN al_petiguias_abo.num_orden%TYPE,
                                            EN_num_peticion IN al_petiguias_abo.num_peticion%TYPE,
                                            EV_num_serie    IN al_petiguias_abo.num_serie%TYPE,
                                            EN_num_telefono IN al_petiguias_abo.num_telefono%TYPE,
                                            EN_num_venta    IN al_petiguias_abo.num_venta%TYPE,
                                            EN_val_linea    IN al_petiguias_abo.val_linea%TYPE,
                                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

    /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_inserta_al_PetiGiasAbo_PR
            Lenguaje="PL/SQL"
            Fecha="18-05-2007"
            Version="1.0.0"
            Dise?ador="Ra�l Lozano"
            Programador="Ra�l Lozano"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Inserta al_petiguias_abo
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="SO_AlPetiguiasAbo     Tipo="TIP_AL_PETIGUIAS_ABO> Estructura de AL_PETIGUIAS_ABO</param>
        <Salida>
            <param nom="SO_AlPetiguiasAbo"  Tipo="SO_AlPetiguiasAbo"> Estructura de AL_PETIGUIAS_ABO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_error ge_errores_pg.DesEvent;
           LV_sSql      ge_errores_pg.vQuery;
        BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

          LV_sSql:= 'INSERT INTO al_petiguias_abo (cod_articulo, cod_bodega, cod_cliente, cod_concepto, cod_moneda, ';
          LV_sSql:= LV_sSql || 'cod_oficina, num_abonado, num_cantidad, num_cargo, num_orden, ';
          LV_sSql:= LV_sSql || ' num_peticion, num_serie, num_telefono, num_venta, val_linea) ';
          LV_sSql:= LV_sSql || ' VALUES( '|| EN_cod_articulo || ',' || EN_cod_bodega || ',' || EN_cod_cliente;
          LV_sSql:= LV_sSql || ' ' || EN_cod_concepto || ',' || EV_cod_moneda || ',' || EV_cod_oficina;
          LV_sSql:= LV_sSql || ' ' || EN_num_abonado || ',' || EN_num_cantidad || ',' || EN_num_cargo;
          LV_sSql:= LV_sSql || ' ' || EN_num_orden || ',' || EN_num_peticion || ',' || EV_num_serie;
          LV_sSql:= LV_sSql || ' ' || EN_num_telefono || ',' || EN_num_venta || ',' || EN_val_linea;

--           LV_sSql:= LV_sSql||' VALUES( '||SO_AlPetiGuiasAbo(1).cod_articulo||','||SO_AlPetiGuiasAbo(1).cod_bodega||','||SO_AlPetiGuiasAbo(1).cod_cliente;
--           LV_sSql:= LV_sSql||' '||SO_AlPetiGuiasAbo(1).cod_concepto||','||SO_AlPetiGuiasAbo(1).cod_moneda||','||SO_AlPetiGuiasAbo(1).cod_oficina;
--           LV_sSql:= LV_sSql||' '||SO_AlPetiGuiasAbo(1).num_abonado||','||SO_AlPetiGuiasAbo(1).num_cantidad||','||SO_AlPetiGuiasAbo(1).num_cargo;
--           LV_sSql:= LV_sSql||' '||SO_AlPetiGuiasAbo(1).num_orden||','||  SO_AlPetiGuiasAbo(1).num_peticion||','||SO_AlPetiGuiasAbo(1).num_serie;
--           LV_sSql:= LV_sSql||' '||SO_AlPetiGuiasAbo(1).num_telefono||','|| SO_AlPetiGuiasAbo(1).num_venta||','|| SO_AlPetiGuiasAbo(1).val_linea||')';

          INSERT INTO al_petiguias_abo (cod_articulo, cod_bodega, cod_cliente, cod_concepto, cod_moneda,
                                      cod_oficina, num_abonado, num_cantidad, num_cargo, num_orden,
                                   num_peticion, num_serie, num_telefono, num_venta, val_linea)
           VALUES(EN_cod_articulo, EN_cod_bodega, EN_cod_cliente,
                  EN_cod_concepto, EV_cod_moneda, EV_cod_oficina,
                  EN_num_abonado, EN_num_cantidad, EN_num_cargo,
                  EN_num_orden, EN_num_peticion,EV_num_serie,
                  EN_num_telefono, EN_num_venta, EN_val_linea);


--            VALUES(SO_AlPetiGuiasAbo(1).cod_articulo,SO_AlPetiGuiasAbo(1).cod_bodega,SO_AlPetiGuiasAbo(1).cod_cliente,
--                      SO_AlPetiGuiasAbo(1).cod_concepto,SO_AlPetiGuiasAbo(1).cod_moneda,SO_AlPetiGuiasAbo(1).cod_oficina,
--                   SO_AlPetiGuiasAbo(1).num_abonado,SO_AlPetiGuiasAbo(1).num_cantidad,SO_AlPetiGuiasAbo(1).num_cargo,
--                   SO_AlPetiGuiasAbo(1).num_orden,  SO_AlPetiGuiasAbo(1).num_peticion,SO_AlPetiGuiasAbo(1).num_serie,
--                   SO_AlPetiGuiasAbo(1).num_telefono,SO_AlPetiGuiasAbo(1).num_venta,SO_AlPetiGuiasAbo(1).val_linea);

        EXCEPTION
            WHEN OTHERS THEN
--                 SO_AlPetiGuiasAbo(1):=NULL;
--                 SN_cod_retorno := 1324; --No es posible registrar peticiones de gu�as de despacho
--                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
--                    SV_mens_retorno := CV_error_no_clasif;
--                 END IF;
--                 LV_des_error   := '  VE_inserta_Al_PetiGuiasAbo_PR ('||'); - ' || SQLERRM;
--                 SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_SERVICIOS_POSVENTA_PG.VE_inserta_Al_PetiGuiasAbo_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

             SN_cod_retorno:=1324; --No es posible registrar peticiones de gu�as de despacho
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_inserta_al_PetiGiasAbo_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_inserta_al_PetiGiasAbo_PR', LV_sSql, SN_cod_retorno, LV_des_error );

    END VE_inserta_al_PetiGiasAbo_PR;

    /*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    PROCEDURE VE_eliminarescel_PR (EN_num_venta     IN  ga_ventas.num_venta%TYPE,
                                   EN_num_transac   IN  ga_resnumcel.num_transaccion%TYPE,
                                     SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_eliminarescel_PR"
                Lenguaje="PL/SQL"
                Fecha="09-11-2007"
                Version="1.0.0"
                Dise?ador="H�ctor Hermosilla"
                Programador="H�ctor Hermosilla"
                Ambiente="BD"
            <Retorno>
                cursor
            </Retorno>
            <Descripcion>
                Elimina reserva temporal de numero celular
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EN_num_venta"     Tipo="NUMBER"> numero de la venta </param>
                <param nom="EN_num_procfact"  Tipo="NUMBER"> numero transaccion</param>
            </Entrada>
            <Salida>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
        IS
            PRAGMA AUTONOMOUS_TRANSACTION;
            NO_DATA_FOUND_CURSOR EXCEPTION;
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LN_contador  NUMBER;
            LN_num_celular ga_abocel.num_celular%TYPE;

            CURSOR cursorVentas IS
            SELECT a.num_celular
            FROM ga_abocel a
            WHERE a.num_venta = EN_num_venta
            ORDER BY a.num_abonado;

        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            OPEN cursorVentas;
            LOOP
                FETCH cursorVentas
                INTO LN_num_celular;
                EXIT WHEN cursorVentas%NOTFOUND;

                --Elimina reserva de numero celular
                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_resnumcel
                WHERE num_celular = LN_num_celular;

                IF (LN_contador > 0) THEN
                   DELETE
                   FROM ga_resnumcel
                   WHERE num_transaccion = EN_num_transac
                   AND num_celular = LN_num_celular;

                END IF;

            END LOOP;


            COMMIT;

        EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_cod_retorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                 END IF;
                 LV_desError     := SUBSTR('NO_DATA_FOUND_CURSOR:PV_SERVICIOS_POSVENTA_PG.VE_eliminarescel_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER, 'PV_SERVICIOS_POSVENTA_PG.VE_eliminarescel_PR', LV_Sql, SN_cod_retorno, LV_desError );
                            ROLLBACK;
            WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_desError:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_eliminarescel_PR(' || EN_num_venta || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_eliminarescel_PR(' || EN_num_venta || ')', LV_Sql, SQLCODE, LV_desError );
                            ROLLBACK;

    END VE_eliminarescel_PR;
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE PV_DatosAbonado_PR(EO_abonado IN OUT NOCOPY GA_ABONADO2_QT,
                               SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

   /*--
<Documentacion TipoDoc = "Procedimiento">
    Elemento Nombre = "PV_DatosAbonado_PR"
    Lenguaje="PL/SQL"
    Fecha="26/05/2008"
    Version="1.0.0"
    Dise�ador="JZ"
    Programador="JZ"
    Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
              Obtiene datos abonado para posventa
</Descripcion>
<Parametros>
<Entrada>
    <param nom="EO_abonado" Tipo="Object">Objeto abonado</param>
</Entrada>
<Salida>
    <param nom="EO_abonado" Tipo="Object">Objeto abonado</param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

BEGIN
     SN_num_evento:= 0;
     SN_cod_retorno:=0;
     SV_mens_retorno:='';

     LV_sSql:= 'SELECT a.cod_cliente,'
     || '        a.fec_alta'
     || ' FROM ga_abocel a'
     || ' WHERE a.num_abonado = ' || EO_abonado.num_abonado
     || ' UNION'
     || ' SELECT a.cod_cliente,'
     || '         a.fec_alta'
     || ' FROM ga_aboamist a'
     || ' WHERE a.num_abonado = ' || EO_abonado.num_abonado;

     SELECT a.cod_cliente,
             a.fec_alta
     INTO EO_abonado.cod_cliente, EO_abonado.fecha_alta
     FROM ga_abocel a
     WHERE a.num_abonado = EO_abonado.num_abonado
     UNION
     SELECT a.cod_cliente,
             a.fec_alta
     FROM ga_aboamist a
     WHERE a.num_abonado = EO_abonado.num_abonado;

     EXCEPTION
         WHEN NO_DATA_FOUND THEN
               SN_cod_retorno:= 218;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='no_data_found:PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR();- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR()', LV_SSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
               SN_cod_retorno:=203;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR();- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR()', LV_SSql, SQLCODE, LV_des_error );
END PV_DatosAbonado_PR;
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE PV_PreCarSimcard_NoPreLis_PR(EN_numabonado    IN ga_abocel.num_abonado%TYPE,
                                         EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                       EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                       EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                       EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                       EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                       EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                       EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                       EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                       EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                       EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                       EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                       EN_IND_RENOVA    IN al_precios_venta.IND_RENOVA%TYPE,
                                       SC_cursordatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
   /*--
<Documentacion TipoDoc = "Procedimiento">
    Elemento Nombre = "PV_PreCarSimcard_NoPreLis_PR"
    Lenguaje="PL/SQL"
    Fecha="05-04-2007"
    Version="1.0.0"
    Dise?ador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
              Obtiene precio cargo de simcard. No Precio de Lista.
</Descripcion>
<Parametros>
<Entrada>
    <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
    ...
</Entrada>
<Salida>
                <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
    <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
     no_data_found_cursor      EXCEPTION;
     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_contador NUMBER;
     nPromFact NUMBER;
     vCodCategoria ve_catplantarif.cod_categoria%TYPE;
     nIndrecambio NUMBER;
     nCodCliente NUMBER;
     dFechaAltaAbo Date;
      EO_abonado GA_ABONADO2_QT := NEW GA_ABONADO2_QT;
      LV_COUNT NUMBER;
      LN_PRISEG gad_descuentos.IND_PRISEG_LIN%TYPE;
      LV_FECHA_MAX GA_ABOCEL.FEC_ALTA%TYPE;
      LV_COD_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
      LV_FEC_ALTA_ABO GA_ABOCEL.FEC_ALTA%TYPE;
      LV_COD_CALIFICACION GE_CLIENTES.COD_CALIFICACION%TYPE;

      --CALIFICACION A NIVEL DE ABONADO
      LV_APLICA_CAL_ABONADO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
      LV_CALIFICACION_DEFAULT GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN
     SN_num_evento:= 0;
     SN_cod_retorno:=0;
     SV_mens_retorno:='';

     EO_abonado.num_abonado := EN_numabonado;

     PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR(EO_abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     nCodCliente:= EO_abonado.cod_cliente;
     dFechaAltaAbo:= EO_abonado.fecha_alta;

     nIndrecambio:= EN_indrecambio;

     IF EN_codusoventa = EN_codusoprepago THEN
         nIndrecambio := 9;
     END IF;


     SELECT  COD_CLIENTE,FEC_ALTA
     INTO LV_COD_CLIENTE,LV_FEC_ALTA_ABO
     FROM  GA_ABOCEL
     WHERE NUM_ABONADO =  EN_numabonado
     UNION
     SELECT  COD_CLIENTE,FEC_ALTA
     FROM  GA_ABOAMIST
     WHERE NUM_ABONADO =  EN_numabonado;



     --CALIFICACION A NIVEL DE ABONADO
     SELECT VAL_PARAMETRO
     INTO LV_APLICA_CAL_ABONADO
     FROM GED_PARAMETROS
     WHERE NOM_PARAMETRO='APLICA_CAL_ABO'
     AND COD_MODULO=CV_MODULO_GA
     AND COD_PRODUCTO=CV_PRODUCTO;


     IF LV_APLICA_CAL_ABONADO='TRUE' THEN

        SELECT VAL_PARAMETRO
        INTO LV_CALIFICACION_DEFAULT
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO='CAL_DEFAULT_PRC'
        AND COD_MODULO=CV_MODULO_GA
        AND COD_PRODUCTO=CV_PRODUCTO;

        BEGIN
            SELECT COD_CALIFICACION
            INTO LV_COD_CALIFICACION
            FROM GA_DATABONADO_TO
            WHERE NUM_ABONADO=EN_numabonado;

            IF LV_COD_CALIFICACION IS NULL THEN
               LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
        END;

     ELSE

        SELECT COD_CALIFICACION
        INTO LV_COD_CALIFICACION
        FROM GE_CLIENTES
        WHERE COD_CLIENTE=LV_COD_CLIENTE;
     END IF;

     BEGIN

       SELECT  MAX(FEC_ALTA)
       INTO LV_FECHA_MAX
       FROM GA_ABOCEL
       WHERE COD_CLIENTE=  nCodCliente
       AND COD_SITUACION ='AAA';

     EXCEPTION
       WHEN NO_DATA_FOUND THEN
            BEGIN
                  SELECT  MAX(FEC_ALTA)
                  INTO LV_FECHA_MAX
                  FROM GA_ABOAMIST
                  WHERE COD_CLIENTE=  nCodCliente
                  AND COD_SITUACION ='AAA';

                  EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                       LV_FECHA_MAX:= NULL;


            END;
     END;
     IF EN_IND_RENOVA = '0' THEN
         LN_PRISEG:=0;
     ELSE
         IF LV_FECHA_MAX IS NULL THEN
            LN_PRISEG:=1;
         ELSE
             IF  (LV_FEC_ALTA_ABO >= LV_FECHA_MAX) THEN
                  --PRIMERA LINEA
                   LN_PRISEG:=1;
             ELSE
                  --SEGUNDA LINEA
                  LN_PRISEG:=2;
             END IF;
         END IF;
     END IF;


     LV_sSql:= 'SELECT A.COD_PROMEDIO '
     ||',FROM AL_PROMFACT A, (SELECT ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL '
         ||',              FROM FA_HISTDOCU U, (SELECT COUNT (DISTINCT TO_CHAR(FEC_EMISION, ''MM'')) CUENTA '
                       ||',                              FROM FA_HISTDOCU '
     ||',                           WHERE COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
                       ||',                            AND FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
                       ||',                             AND COD_CLIENTE = ' || nCodCliente ||') V '
     ||',             WHERE U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
          ||',               AND U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
          ||',               AND U.COD_CLIENTE = ' || nCodCliente ||') B '
     ||',WHERE B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA ';
    --INICIO INC 188315 ECU BMR 24-09-2012
    BEGIN
     SELECT A.COD_PROMEDIO
     INTO nPromFact
     FROM AL_PROMFACT A, (SELECT ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL
                      FROM FA_HISTDOCU U, (SELECT COUNT (DISTINCT TO_CHAR(FEC_EMISION,'MM')) CUENTA
                                                     FROM FA_HISTDOCU
                               WHERE COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                                                    AND FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                                    AND COD_CLIENTE = nCodCliente) V
                 WHERE U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1)
                        AND U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                        AND U.COD_CLIENTE = nCodCliente) B
     WHERE B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        nPromFact := 1;
    END;
    --FIN INC 188315 ECU BMR 24-09-2012
     LV_sSql:= 'SELECT COD_CATEGORIA FROM VE_CATPLANTARIF WHERE COD_PRODUCTO = 1 AND COD_PLANTARIF = ' || EV_plantarif;

     SELECT cod_categoria
     INTO vCodCategoria
     FROM ve_catplantarif
     WHERE cod_producto = 1 AND
            cod_plantarif = EV_plantarif;

     IF EN_codusoventa<>3 THEN


         LV_sSql:= 'SELECT  b.cod_conceptoart'
                ||',b.des_articulo'
                ||',a.prc_venta'
                ||',a.cod_moneda'
                ||',c.des_moneda'
                ||',NVL(a.val_minimo,0)'
                ||',NVL(a.val_maximo,0)'
                ||',''A'' '
                ||',''1'' '
                ||',''1'' '
                ||',''0'' '
                ||',b.mes_garantia'
                ||',''0'' '
                ||',''0'' '
                ||',''0'' '
                ||',''0'' '
                ||'FROM al_precios_venta a'
                ||    ',al_articulos b'
                ||    ',ge_monedas c'
                ||    ',(SELECT w.cod_categoria categoria'
                ||      'FROM ve_catplantarif v, ve_categorias w'
                ||      'WHERE v.cod_plantarif ='|| EV_plantarif
                ||        'AND v.cod_categoria = w.cod_categoria) z'
                ||    ',(SELECT p.num_meses meses '
                ||      'FROM ga_percontrato p'
                ||      'WHERE p.cod_producto > 0'
                ||        'AND p.cod_tipcontrato = '||EV_tipocontrato||') xy'
                ||'WHERE A.tip_stock = '||EN_tipstock
                ||'AND a.cod_articulo = '||EN_codarticulo
                ||'AND a.cod_uso = '||EN_codusoventa
                ||'AND a.cod_estado = '||EN_codestado
                ||'AND a.cod_modventa = '||EN_modventa
                ||'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)'
                ||'AND b.cod_articulo = a.cod_articulo'
                ||'AND c.cod_moneda = a.cod_moneda'
                ||'AND a.ind_recambio = '|| nIndrecambio
                ||'AND a.num_meses = xy.meses'
                ||'AND a.cod_categoria = z.categoria'
                ||'AND b.ind_equiacc = '||EV_indequipo
                ||'AND a.cod_promedio = '|| nPromFact
                ||'AND a.cod_categoria = '|| vCodCategoria
                ||'AND a.ind_renova = '|| EN_IND_RENOVA
                ||'AND a.ind_priseg_lin = '|| LN_PRISEG
                ||'AND a.cod_calificacion = '|| LV_COD_CALIFICACION
                ||'AND ROWNUM <= 1';

         LN_contador := 0;
         SELECT COUNT(1)
         INTO LN_contador
            FROM al_precios_venta a
                ,al_articulos b
                ,ge_monedas c
                ,(SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                    AND v.cod_categoria = w.cod_categoria) z
                ,(SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                    AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE A.tip_stock = EN_tipstock
              AND a.cod_articulo = EN_codarticulo
              AND a.cod_uso = EN_codusoventa
              AND a.cod_estado = EN_codestado
              AND a.cod_modventa = EN_modventa
              AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
              AND b.cod_articulo = a.cod_articulo
              AND c.cod_moneda = a.cod_moneda
              AND a.ind_recambio = nIndrecambio -- constante (0)
              AND a.num_meses = xy.meses
              AND a.cod_categoria = z.categoria
              AND b.ind_equiacc = EV_indequipo -- cisntante (E)
              AND a.cod_promedio = nPromFact
              AND a.cod_categoria = vCodCategoria
              AND a.ind_renova=EN_IND_RENOVA
              AND a.ind_priseg_lin=LN_PRISEG
              AND a.cod_calificacion=LV_COD_CALIFICACION
              AND ROWNUM <= 1;


         OPEN SC_cursordatos FOR
            SELECT b.cod_conceptoart
                  ,b.des_articulo
                  ,a.prc_venta
                  ,a.cod_moneda
                  ,c.des_moneda
                  ,NVL(a.val_minimo,0)
                  ,NVL(a.val_maximo,0)
                   ,'A'-- tipo cargo [ Automatico o Manual ]
                  ,'1'-- numero unidades
                    ,'1'-- ind. equipo
                  ,'0'-- ind. paquete
                  ,b.mes_garantia
                  ,'0'-- ind. accesorio
                  ,'0'-- cod. articulo
                  ,'0'-- cod. stock
                  ,'0'-- cod. estado
            FROM al_precios_venta a
                ,al_articulos b
                ,ge_monedas c
                ,(SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                    AND v.cod_categoria = w.cod_categoria) z
                ,(SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                    AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE A.tip_stock = EN_tipstock
              AND a.cod_articulo = EN_codarticulo
              AND a.cod_uso = EN_codusoventa
              AND a.cod_estado = EN_codestado
              AND a.cod_modventa = EN_modventa
              AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
              AND b.cod_articulo = a.cod_articulo
              AND c.cod_moneda = a.cod_moneda
              AND a.ind_recambio = nIndrecambio-- constante (0)
              AND a.num_meses = xy.meses
              AND a.cod_categoria = z.categoria
              AND b.ind_equiacc = EV_indequipo-- cisntante (E)
              AND a.cod_promedio = nPromFact
              AND a.cod_categoria = vCodCategoria
              AND a.ind_renova=EN_IND_RENOVA
              AND a.ind_priseg_lin=LN_PRISEG
              AND a.cod_calificacion=LV_COD_CALIFICACION
              AND ROWNUM <= 1;
     ELSE
     SELECT COUNT(1)
                 INTO LN_contador
                 FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  AND a.cod_calificacion=LV_COD_CALIFICACION
                  AND a.IND_PRISEG_LIN=LN_PRISEG
                  AND a.ind_renova=EN_IND_RENOVA
                  AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
                SELECT b.cod_conceptoart
                      ,b.des_articulo
                      ,a.prc_venta
                      ,a.cod_moneda
                      ,c.des_moneda
                      ,NVL(a.val_minimo,0)
                      ,NVL(a.val_maximo,0)
                       ,'A'-- tipo cargo [ Automatico o Manual ]
                      ,'1'-- numero unidades
                        ,'1'-- ind. equipo
                      ,'0'-- ind. paquete
                      ,b.mes_garantia
                      ,'0'-- ind. accesorio
                      ,'0'-- cod. articulo
                      ,'0'-- cod. stock
                      ,'0'-- cod. estado
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  and a.cod_calificacion=LV_COD_CALIFICACION-- cisntante (E)
                  AND a.IND_PRISEG_LIN=LN_PRISEG
                  and a.ind_renova=EN_IND_RENOVA;

     END IF;


     IF (LN_contador = 0) THEN
        RAISE no_data_found_cursor;
     END IF;

     EXCEPTION
         WHEN no_data_found_cursor THEN
               SN_cod_retorno:= 99;--SQLCODE;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.PV_PreCarSimcard_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                            ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                            ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_PreCarSimcard_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
               SN_cod_retorno:=SQLCODE;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_PreCarSimcard_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                            ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                            ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_PreCarSimcard_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
END PV_PreCarSimcard_NoPreLis_PR;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE PV_PreCarTerminal_NoPreLis_PR(EN_numabonado    IN ga_abocel.num_abonado%TYPE,
                                          EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                        EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                        EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                        EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                        EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                        EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                        EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
   /*--
<Documentacion TipoDoc = "Procedimiento">
    Elemento Nombre = "PV_PreCarTerminal_NoPreLis_PR"
    Lenguaje="PL/SQL"
    Fecha="05-04-2007"
    Version="1.0.0"
    Dise?ador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
              Obtiene precio cargo de terminal No Precio de Lista para Cambio de serie.
</Descripcion>
<Parametros>
<Entrada>
    <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
    ...
</Entrada>
<Salida>
                <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos terminal encontrados </param>
    <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
     no_data_found_cursor      EXCEPTION;
     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_contador NUMBER;
     nPromFact NUMBER;
     vCodCategoria ve_catplantarif.cod_categoria%TYPE;
     nIndrecambio NUMBER;
     nCodCliente NUMBER;
     dFechaAltaAbo Date;
     nMesesMinimo NUMBER;
     nCodAntiguedad al_antiguedad.cod_antiguedad%TYPE;
     EO_abonado GA_ABONADO2_QT := NEW GA_ABONADO2_QT;

     LV_COD_CALIFICACION GE_CLIENTES.COD_CALIFICACION%TYPE;

      --CALIFICACION A NIVEL DE ABONADO
      LV_APLICA_CAL_ABONADO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
      LV_CALIFICACION_DEFAULT GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
     SN_num_evento:= 0;
     SN_cod_retorno:=0;
     SV_mens_retorno:='';

     EO_abonado.num_abonado := EN_numabonado;

     PV_SERVICIOS_POSVENTA_PG.PV_DatosAbonado_PR(EO_abonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

     nCodCliente:= EO_abonado.cod_cliente;
     dFechaAltaAbo:= EO_abonado.fecha_alta;

     --CALIFICACION A NIVEL DE ABONADO
     SELECT VAL_PARAMETRO
     INTO LV_APLICA_CAL_ABONADO
     FROM GED_PARAMETROS
     WHERE NOM_PARAMETRO='APLICA_CAL_ABO'
     AND COD_MODULO=CV_MODULO_GA
     AND COD_PRODUCTO=CV_PRODUCTO;


     IF LV_APLICA_CAL_ABONADO='TRUE' THEN

        SELECT VAL_PARAMETRO
        INTO LV_CALIFICACION_DEFAULT
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO='CAL_DEFAULT_PRC'
        AND COD_MODULO=CV_MODULO_GA
        AND COD_PRODUCTO=CV_PRODUCTO;

        BEGIN
            SELECT COD_CALIFICACION
            INTO LV_COD_CALIFICACION
            FROM GA_DATABONADO_TO
            WHERE NUM_ABONADO=EN_numabonado;


            IF LV_COD_CALIFICACION IS NULL THEN
               LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
        END;

     ELSE

        SELECT COD_CALIFICACION
        INTO LV_COD_CALIFICACION
        FROM GE_CLIENTES
        WHERE COD_CLIENTE=nCodCliente;
     END IF;


     LV_sSql:= 'SELECT A.COD_PROMEDIO '
     ||',FROM AL_PROMFACT A, (SELECT ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL '
         ||',              FROM FA_HISTDOCU U, (SELECT COUNT (DISTINCT TO_CHAR(FEC_EMISION, ''MM'')) CUENTA '
                       ||',                              FROM FA_HISTDOCU '
     ||',                           WHERE COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
                       ||',                            AND FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
                       ||',                             AND COD_CLIENTE = ' || nCodCliente || ') V '
     ||',             WHERE U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
          ||',               AND U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
          ||',               AND U.COD_CLIENTE = '|| nCodCliente ||') B '
     ||',WHERE B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA ';

     SELECT a.cod_promedio
     INTO nPromFact
     FROM al_promfact a,
           (SELECT ROUND(NVL(SUM(u.tot_factura)/MAX(v.cuenta),0)) total
           FROM fa_histdocu u,
                 (SELECT COUNT(DISTINCT TO_CHAR(fec_emision,'MM')) cuenta
                  FROM fa_histdocu
                  WHERE cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                        fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                        cod_cliente = nCodCliente) v
           WHERE u.cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                  u.fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                u.cod_cliente = nCodCliente) b
     WHERE b.total BETWEEN a.fact_desde AND a.fact_hasta;

     LV_sSql:= 'SELECT NVL(meses_minimo,0) FROM ga_tipcontrato WHERE cod_tipcontrato = ' || EV_plantarif || ' AND cod_producto = 1';

     SELECT NVL(meses_minimo,0)
     INTO nMesesMinimo
     FROM ga_tipcontrato
     WHERE cod_tipcontrato = EV_tipocontrato AND
            cod_producto = 1;

/*     LV_sSql:= 'SELECT a.cod_antiguedad'
                ||' FROM al_antiguedad a,'
                ||'       (SELECT TRUNC(MONTHS_BETWEEN (SYSDATE,NVL(fec_alta,SYSDATE))) meses'
                ||'       FROM ga_abocel'
                   ||'       WHERE num_abonado = ' || EN_numabonado || ') b'
                ||' WHERE a.num_meses = ' || nMesesMinimo || ' AND'
                ||'        b.meses BETWEEN a.ant_desde AND a.ant_hasta';


     SELECT a.cod_antiguedad
     INTO nCodAntiguedad
     FROM al_antiguedad a,
           (SELECT TRUNC(MONTHS_BETWEEN (SYSDATE,NVL(fec_alta,SYSDATE))) meses
           FROM ga_abocel
           WHERE num_abonado = EN_numabonado) b
     WHERE b.meses BETWEEN a.ant_desde AND a.ant_hasta;*/

     LV_sSql:= 'SELECT cod_categoria FROM ve_catplantarif WHERE cod_producto = 1 AND cod_plantarif = ' || EV_plantarif;

     SELECT cod_categoria
     INTO vCodCategoria
     FROM ve_catplantarif
     WHERE cod_producto = 1 AND
            cod_plantarif = EV_plantarif;



     IF EN_codusoventa <>3 THEN

         LV_sSql:= 'SELECT b.cod_conceptoart'
                   || ' ,b.des_articulo'
                   || ' ,a.prc_venta'
                   || ' ,a.cod_moneda'
                   || ' ,c.des_moneda'
                   || ' ,NVL(a.val_minimo,0)'
                   || ' ,NVL(a.val_maximo,0)'
                   || ' ,''A''-- tipo cargo [ Automatico o Manual ]'
                   || ' ,''1''-- numero unidades'
                   || ' ,''1''-- ind. equipo'
                   || ' ,''0''-- ind. paquete'
                   || ' , b.mes_garantia'
                   || ' ,''0''-- ind. accesorio'
                   || ' ,''0''-- cod. articulo'
                   || ' ,''0''-- cod. stock'
                   || ' ,''0''-- cod. estado'
            || ' FROM al_precios_venta a, '
                 || ' al_articulos b, '
                 || ' ge_monedas c,'
                 || ' (SELECT w.cod_categoria categoria'
                 || '  FROM ve_catplantarif v, ve_categorias w'
                  || ' WHERE v.cod_plantarif = ' || EV_plantarif
                  || ' AND v.cod_categoria = w.cod_categoria) z,'
                 || ' (SELECT p.num_meses meses'
                  || ' FROM ga_percontrato p'
                  || ' WHERE p.cod_producto > 0'
                  || ' AND p.cod_tipcontrato = ' || EV_tipocontrato || ') xy'
            || ' WHERE a.tip_stock =  ' || EN_tipstock || ' AND'
                  || ' a.cod_articulo = ' || EN_codarticulo || ' AND'
                  || ' a.cod_uso = ' || EN_codusoventa || ' AND'
                  || ' a.cod_estado = ' || EN_codestado || ' AND'
                  || ' a.cod_modventa = ' || EN_modventa || ' AND'
                  || ' a.IND_RENOVA = 0  AND '
                  || ' a.ind_priseg_lin= 0 AND '
                  || ' a.cod_calificacion= ' || LV_COD_CALIFICACION || ' AND'
                  || ' SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND'
                  || ' b.cod_articulo = a.cod_articulo AND'
                  || ' c.cod_moneda = a.cod_moneda AND'
                  || ' a.ind_recambio = 1  AND'
                  || ' a.cod_promedio = ' || nPromFact || ' AND'
                  || ' a.cod_antiguedad = 0 AND'
                  || ' a.num_meses = xy.meses AND'
                  || ' a.cod_categoria = z.categoria AND'
                    || ' TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros '
                                                || ' WHERE nom_parametro LIKE ''USO_PREPAGO%'' AND'
                                            || ' cod_modulo = ''GA'' AND    cod_producto = 1) AND'
                  || ' a.cod_categoria = ' || vCodCategoria
                  || ' b.ind_equiacc = ''E'''
            || ' UNION'
            || ' SELECT b.cod_conceptoart'
                   || ' ,b.des_articulo'
                   || ' ,a.prc_venta'
                   || ' ,a.cod_moneda'
                   || ' ,c.des_moneda'
                   || ' ,NVL(a.val_minimo,0)'
                   || ' ,NVL(a.val_maximo,0)'
                   || ' ,''A''-- tipo cargo [ Automatico o Manual ]'
                   || ' ,''1''-- numero unidades'
                   || ' ,''1''-- ind. equipo'
                   || ' ,''0''-- ind. paquete'
                   || ' , b.mes_garantia'
                   || ' ,''0''-- ind. accesorio'
                   || ' ,''0''-- cod. articulo'
                   || ' ,''0''-- cod. stock'
                   || ' ,''0''-- cod. estado'
            || ' FROM al_precios_venta a, '
                 || ' al_articulos b, '
                 || ' ge_monedas c,'
                 || ' (SELECT w.cod_categoria categoria'
                  || ' FROM ve_catplantarif v, ve_categorias w'
                  || ' WHERE v.cod_plantarif = ' || EV_plantarif
                  || ' AND v.cod_categoria = w.cod_categoria) z,'
                 || ' (SELECT p.num_meses meses'
                  || ' FROM ga_percontrato p'
                  || ' WHERE p.cod_producto > 0'
                  || ' AND p.cod_tipcontrato = ' || EV_tipocontrato || ') xy'
            || ' WHERE a.tip_stock = ' || EN_tipstock || ' AND'
                  || ' a.cod_articulo = ' || EN_codarticulo || ' AND'
                  || ' a.cod_uso = ' || EN_codusoventa || ' AND'
                  || ' a.cod_estado = ' || EN_modventa || ' AND'
                  || ' a.IND_RENOVA = 0  AND '
                  || ' a.ind_priseg_lin= 0 AND '
                  || ' a.cod_calificacion= ' || LV_COD_CALIFICACION || ' AND'
                  || ' SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND'
                  || ' b.cod_articulo = a.cod_articulo AND'
                  || ' c.cod_moneda = a.cod_moneda AND'
                  || ' a.ind_recambio = 9  AND'
                  || ' a.cod_antiguedad = 0 AND'
                  || ' a.num_meses = xy.meses AND'
                  || ' a.cod_modventa = 1 AND'
                  || ' (b.ind_equiacc = ''A'' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS '
                                                                           || ' WHERE nom_parametro LIKE ''USO_PREPAGO%'' AND'
                                                                 || ' cod_modulo = ''GA'' AND'
                                                                 || ' cod_producto = 1) AND'
                  || ' a.cod_categoria = z.categoria)'
                  || ' a.cod_categoria = ' || vCodCategoria;

         LN_contador := 0;
         SELECT COUNT(1)
         INTO LN_contador
         FROM
             (SELECT a.cod_articulo
             FROM al_precios_venta a,
                  al_articulos b,
                  ge_monedas c,
                  (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                  (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
             WHERE a.tip_stock = EN_tipstock AND
                   a.cod_articulo = EN_codarticulo AND
                   a.cod_uso = EN_codusoventa AND
                   a.cod_estado = EN_codestado AND
                   a.cod_modventa = EN_modventa AND
                   a.IND_RENOVA = 0 AND
                   a.ind_priseg_lin= 0 AND
                   a.cod_calificacion=LV_COD_CALIFICACION AND
                   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                   b.cod_articulo = a.cod_articulo AND
                   c.cod_moneda = a.cod_moneda AND
                   a.ind_recambio = 1  AND
                   a.cod_promedio = nPromFact  AND
                   a.cod_antiguedad = 0 AND
                   a.num_meses = xy.meses AND
                   a.cod_categoria = z.categoria AND
                   TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros
                                                WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                             cod_modulo = 'GA' AND    cod_producto = 1) AND
                   a.cod_categoria = vCodCategoria AND
                   b.ind_equiacc = 'E'
             UNION
             SELECT a.cod_articulo
             FROM al_precios_venta a,
                  al_articulos b,
                  ge_monedas c,
                  (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                  (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
             WHERE a.tip_stock = EN_tipstock AND
                   a.cod_articulo = EN_codarticulo AND
                   a.cod_uso = EN_codusoventa AND
                   a.cod_estado = EN_modventa AND
                   a.IND_RENOVA = 0 AND
                   a.ind_priseg_lin= 0 AND
                   a.cod_calificacion=LV_COD_CALIFICACION AND
                   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                   b.cod_articulo = a.cod_articulo AND
                   c.cod_moneda = a.cod_moneda AND
                   a.ind_recambio = 9  AND
                   a.cod_antiguedad = 0 AND
                   a.num_meses = xy.meses AND
                   a.cod_modventa = 1 AND
                   (b.ind_equiacc = 'A' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS
                                                                           WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                                                  cod_modulo = 'GA' AND
                                                                  cod_producto = 1) AND
                   a.cod_categoria = z.categoria) AND
                   a.cod_categoria = vCodCategoria);

         OPEN SC_cursordatos FOR
            SELECT b.cod_conceptoart
                   ,b.des_articulo
                   ,a.prc_venta
                   ,a.cod_moneda
                   ,c.des_moneda
                   ,NVL(a.val_minimo,0)
                   ,NVL(a.val_maximo,0)
                   ,'A'-- tipo cargo [ Automatico o Manual ]
                   ,'1'-- numero unidades
                   ,'1'-- ind. equipo
                   ,'0'-- ind. paquete
                   , b.mes_garantia
                   ,'0'-- ind. accesorio
                   ,'0'-- cod. articulo
                   ,'0'-- cod. stock
                   ,'0'-- cod. estado
            FROM al_precios_venta a,
                 al_articulos b,
                 ge_monedas c,
                 (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                 (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE a.tip_stock = EN_tipstock AND
                  a.cod_articulo = EN_codarticulo AND
                  a.cod_uso = EN_codusoventa AND
                  a.cod_estado = EN_codestado AND
                  a.cod_modventa = EN_modventa AND
                  a.IND_RENOVA = 0 AND
                  a.ind_priseg_lin= 0 AND
                  a.cod_calificacion=LV_COD_CALIFICACION AND
                  SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                  b.cod_articulo = a.cod_articulo AND
                  c.cod_moneda = a.cod_moneda AND
                  a.ind_recambio = 1  AND
                  a.cod_promedio = nPromFact  AND
                  a.cod_antiguedad = 0 AND
                  a.num_meses = xy.meses AND
                  a.cod_categoria = z.categoria AND
                    TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros
                                                WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                            cod_modulo = 'GA' AND    cod_producto = 1) AND
                  a.cod_categoria = vCodCategoria AND
                  b.ind_equiacc = 'E'
            UNION
            SELECT b.cod_conceptoart
                   ,b.des_articulo
                   ,a.prc_venta
                   ,a.cod_moneda
                   ,c.des_moneda
                   ,NVL(a.val_minimo,0)
                   ,NVL(a.val_maximo,0)
                   ,'A'-- tipo cargo [ Automatico o Manual ]
                   ,'1'-- numero unidades
                   ,'1'-- ind. equipo
                   ,'0'-- ind. paquete
                   , b.mes_garantia
                   ,'0'-- ind. accesorio
                   ,'0'-- cod. articulo
                   ,'0'-- cod. stock
                   ,'0'-- cod. estado
            FROM al_precios_venta a,
                 al_articulos b,
                 ge_monedas c,
                 (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                 (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE a.tip_stock = EN_tipstock AND
                  a.cod_articulo = EN_codarticulo AND
                  a.cod_uso = EN_codusoventa AND
                  a.cod_estado = EN_modventa AND
                  a.IND_RENOVA = 0 AND
                  a.ind_priseg_lin= 0 AND
                  a.cod_calificacion=LV_COD_CALIFICACION AND
                  SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                  b.cod_articulo = a.cod_articulo AND
                  c.cod_moneda = a.cod_moneda AND
                  a.ind_recambio = 9  AND
                  a.cod_antiguedad = 0 AND
                  a.num_meses = xy.meses AND
                  a.cod_modventa = 1 AND
                  (b.ind_equiacc = 'A' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS
                                                                           WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                                                 cod_modulo = 'GA' AND
                                                                 cod_producto = 1) AND
                  a.cod_categoria = z.categoria) AND
                  a.cod_categoria = vCodCategoria;
     ELSE
                 SELECT COUNT(1)
                 INTO LN_contador
                 FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  AND a.cod_calificacion=LV_COD_CALIFICACION
                  AND a.IND_PRISEG_LIN=0
                  AND a.ind_renova=0
                  AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
                SELECT b.cod_conceptoart
                      ,b.des_articulo
                      ,a.prc_venta
                      ,a.cod_moneda
                      ,c.des_moneda
                      ,NVL(a.val_minimo,0)
                      ,NVL(a.val_maximo,0)
                       ,'A'-- tipo cargo [ Automatico o Manual ]
                      ,'1'-- numero unidades
                        ,'1'-- ind. equipo
                      ,'0'-- ind. paquete
                      ,b.mes_garantia
                      ,'0'-- ind. accesorio
                      ,'0'-- cod. articulo
                      ,'0'-- cod. stock
                      ,'0'-- cod. estado
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  and a.cod_calificacion=LV_COD_CALIFICACION-- cisntante (E)
                  AND a.IND_PRISEG_LIN=0
                  and a.ind_renova=0;

     END IF;



     IF (LN_contador = 0) THEN
        RAISE no_data_found_cursor;
     END IF;

     EXCEPTION
         WHEN no_data_found_cursor THEN
               SN_cod_retorno:= 99;--SQLCODE;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.PV_PreCarTerminal_NoPreLis_PR('|| EN_numabonado ||','|| EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                            ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                            ||');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_PreCarTerminal_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
               SN_cod_retorno:=SQLCODE;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno:=CV_error_no_clasif;
              END IF;
              LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_PreCarTerminal_NoPreLis_PR('|| EN_numabonado ||','||EN_codarticulo||','||EN_tipstock||','||EN_codusoventa||','
                            ||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                            ||');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
              'PV_SERVICIOS_POSVENTA_PG.PV_PreCarTerminal_NoPreLis_PR(' || EN_codarticulo || ')', LV_SSql, SQLCODE, LV_des_error );
END PV_PreCarTerminal_NoPreLis_PR;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

PROCEDURE PV_PrecCargTermren_NoPreLis_PR(EN_codarticulo   IN al_precios_venta.cod_articulo%TYPE,
                                                EN_tipstock      IN al_precios_venta.tip_stock%TYPE,
                                                  EN_codusoventa   IN al_precios_venta.cod_uso%TYPE,
                                                EN_codestado     IN al_precios_venta.cod_estado%TYPE,
                                                EN_modventa      IN al_precios_venta.cod_modventa%TYPE,
                                                EV_tipocontrato  IN ga_percontrato.cod_tipcontrato%TYPE,
                                                EV_plantarif     IN ve_catplantarif.cod_plantarif%TYPE,
                                                EN_indrecambio   IN al_precios_venta.ind_recambio%TYPE,
                                                EV_codcategoria  IN al_precios_venta.cod_categoria%TYPE,
                                                  EN_codusoprepago IN al_precios_venta.cod_uso%TYPE,
                                                EV_indequipo     IN al_articulos.ind_equiacc%TYPE,
                                                EV_numabonado    IN ga_Abocel.num_abonado%TYPE,
                                                SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                 SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "PV_PrecCargTermren_NoPreLis_PR"
            Lenguaje="PL/SQL"
            Fecha="27-05-2009"
            Version="1.0.0"
            Dise?ador="ocb"
            Programador="ocb"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                      Obtiene precio cargo de terminal. No Precio de Lista por renovaci�n
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
            ...
        </Entrada>
        <Salida>
                  <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
             no_data_found_cursor      EXCEPTION;
             LV_des_error ge_errores_pg.DesEvent;
             LV_sSql      ge_errores_pg.vQuery;
             LN_contador     NUMBER;
             LV_COD_CLIENTE  GA_ABOCEL.COD_CLIENTE%TYPE;
             LV_FEC_ALTA_ABO GA_ABOCEL.FEC_ALTA%TYPE;
             LV_FECHA_MAX    GA_ABOCEL.FEC_ALTA%TYPE;
             LN_PRISEG       NUMBER;
             nPromFact NUMBER;
     vCodCategoria ve_catplantarif.cod_categoria%TYPE;
     nIndrecambio NUMBER;
     nCodCliente NUMBER;
     dFechaAltaAbo Date;
     nMesesMinimo NUMBER;
     nCodAntiguedad al_antiguedad.cod_antiguedad%TYPE;
     LV_COD_CALIFICACION GE_CLIENTES.COD_CALIFICACION%TYPE;
     --CALIFICACION A NIVEL DE ABONADO
     LV_APLICA_CAL_ABONADO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
     LV_CALIFICACION_DEFAULT GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN

               SN_num_evento:= 0;
             SN_cod_retorno:=0;
             SV_mens_retorno:='';
             LN_PRISEG      :=0;


             SELECT  COD_CLIENTE,FEC_ALTA
             INTO LV_COD_CLIENTE,LV_FEC_ALTA_ABO
             FROM  GA_ABOCEL
             WHERE NUM_ABONADO =  EV_numabonado
             UNION
             SELECT  COD_CLIENTE,FEC_ALTA
             FROM  GA_ABOAMIST
             WHERE NUM_ABONADO =  EV_numabonado;

             begin

             SELECT  MAX(FEC_ALTA)
             INTO LV_FECHA_MAX
             FROM GA_ABOCEL
             WHERE COD_CLIENTE=  LV_COD_CLIENTE
             AND COD_SITUACION ='AAA';

             exception
                      when no_data_found then
                            begin

                            SELECT  MAX(FEC_ALTA)
                            INTO LV_FECHA_MAX
                            FROM GA_ABOAMIST
                            WHERE COD_CLIENTE=  LV_COD_CLIENTE
                            AND COD_SITUACION ='AAA';

                            exception
                                 when no_data_found then
                                      LV_FECHA_MAX:= null;


                            end;
             end;

             if LV_FECHA_MAX is null then
                     LN_PRISEG:=1;
             else

                     IF  (LV_FEC_ALTA_ABO >= LV_FECHA_MAX) THEN
                         --PRIMERA LINEA
                         LN_PRISEG:=1;
                     ELSE
                         --SEGUNDA LINEA
                         LN_PRISEG:=2;
                     END IF;
             end if;


     nCodCliente:=LV_COD_CLIENTE;
     dFechaAltaAbo:= LV_FEC_ALTA_ABO;

     LV_sSql:= 'SELECT A.COD_PROMEDIO '
     ||',FROM AL_PROMFACT A, (SELECT ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL '
     ||',              FROM FA_HISTDOCU U, (SELECT COUNT (DISTINCT TO_CHAR(FEC_EMISION, ''MM'')) CUENTA '
        ||',                              FROM FA_HISTDOCU '
     ||',                           WHERE COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
        ||',                            AND FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
        ||',                             AND COD_CLIENTE = ' || nCodCliente || ') V '
     ||',             WHERE U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) '
     ||',               AND U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6) '
      ||',               AND U.COD_CLIENTE = '|| nCodCliente ||') B '
     ||',WHERE B.TOTAL BETWEEN FACT_DESDE AND FACT_HASTA ';

     SELECT a.cod_promedio
     INTO nPromFact
     FROM al_promfact a,
           (SELECT ROUND(NVL(SUM(u.tot_factura)/MAX(v.cuenta),0)) total
           FROM fa_histdocu u,
                 (SELECT COUNT(DISTINCT TO_CHAR(fec_emision,'MM')) cuenta
                  FROM fa_histdocu
                  WHERE cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                        fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                        cod_cliente = nCodCliente) v
           WHERE u.cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                  u.fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                u.cod_cliente = nCodCliente) b
     WHERE b.total BETWEEN a.fact_desde AND a.fact_hasta;

     LV_sSql:= 'SELECT NVL(meses_minimo,0) FROM ga_tipcontrato WHERE cod_tipcontrato = ' || EV_plantarif || ' AND cod_producto = 1';

     SELECT NVL(meses_minimo,0)
     INTO nMesesMinimo
     FROM ga_tipcontrato
     WHERE cod_tipcontrato = EV_tipocontrato AND
            cod_producto = 1;

     LV_sSql:= 'SELECT cod_categoria FROM ve_catplantarif WHERE cod_producto = 1 AND cod_plantarif = ' || EV_plantarif;

     SELECT cod_categoria
     INTO vCodCategoria
     FROM ve_catplantarif
     WHERE cod_producto = 1 AND
            cod_plantarif = EV_plantarif;

         --CALIFICACION A NIVEL DE ABONADO
     SELECT VAL_PARAMETRO
     INTO LV_APLICA_CAL_ABONADO
     FROM GED_PARAMETROS
     WHERE NOM_PARAMETRO='APLICA_CAL_ABO'
     AND COD_MODULO=CV_MODULO_GA
     AND COD_PRODUCTO=CV_PRODUCTO;


     IF LV_APLICA_CAL_ABONADO='TRUE' THEN

        SELECT VAL_PARAMETRO
        INTO LV_CALIFICACION_DEFAULT
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO='CAL_DEFAULT_PRC'
        AND COD_MODULO=CV_MODULO_GA
        AND COD_PRODUCTO=CV_PRODUCTO;

        BEGIN
            SELECT COD_CALIFICACION
            INTO LV_COD_CALIFICACION
            FROM GA_DATABONADO_TO
            WHERE NUM_ABONADO=EV_numabonado;

            IF LV_COD_CALIFICACION IS NULL THEN
               LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
            END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 LV_COD_CALIFICACION:=LV_CALIFICACION_DEFAULT;
        END;

     ELSE

        SELECT COD_CALIFICACION
        INTO LV_COD_CALIFICACION
        FROM GE_CLIENTES
        WHERE COD_CLIENTE=LV_COD_CLIENTE;
     END IF;




     IF EN_codusoventa<>3 THEN

         LV_sSql:= 'SELECT b.cod_conceptoart'
                   || ' ,b.des_articulo'
                   || ' ,a.prc_venta'
                   || ' ,a.cod_moneda'
                   || ' ,c.des_moneda'
                   || ' ,NVL(a.val_minimo,0)'
                   || ' ,NVL(a.val_maximo,0)'
                   || ' ,''A''-- tipo cargo [ Automatico o Manual ]'
                   || ' ,''1''-- numero unidades'
                   || ' ,''1''-- ind. equipo'
                   || ' ,''0''-- ind. paquete'
                   || ' , b.mes_garantia'
                   || ' ,''0''-- ind. accesorio'
                   || ' ,''0''-- cod. articulo'
                   || ' ,''0''-- cod. stock'
                   || ' ,''0''-- cod. estado'
                   || ' FROM al_precios_venta a, '
                 || ' al_articulos b, '
                 || ' ge_monedas c,'
                 || ' (SELECT w.cod_categoria categoria'
                 || '  FROM ve_catplantarif v, ve_categorias w'
                  || ' WHERE v.cod_plantarif = ' || EV_plantarif
                  || ' AND v.cod_categoria = w.cod_categoria) z,'
                 || ' (SELECT p.num_meses meses'
                  || ' FROM ga_percontrato p'
                  || ' WHERE p.cod_producto > 0'
                  || ' AND p.cod_tipcontrato = ' || EV_tipocontrato || ') xy'
            || ' WHERE a.tip_stock =  ' || EN_tipstock || ' AND'
                  || ' a.cod_articulo = ' || EN_codarticulo || ' AND'
                  || ' a.cod_uso = ' || EN_codusoventa || ' AND'
                  || ' a.cod_estado = ' || EN_codestado || ' AND'
                  || ' a.cod_modventa = ' || EN_modventa || ' AND'
                  || ' SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND'
                  || ' b.cod_articulo = a.cod_articulo AND'
                  || ' c.cod_moneda = a.cod_moneda AND'
                  || ' a.ind_recambio = 1  AND'
                  || ' a.cod_promedio = ' || nPromFact || ' AND'
                  || ' a.cod_antiguedad = 0 AND'
                  || ' a.num_meses = xy.meses AND'
                  || ' a.cod_categoria = z.categoria AND'
                  || ' TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros '
                                            || ' WHERE nom_parametro LIKE ''USO_PREPAGO%'' AND'
                                            || ' cod_modulo = ''GA'' AND    cod_producto = 1) AND'
                  || ' a.cod_categoria = ' || vCodCategoria
                  || ' b.ind_equiacc = ''E'''
                  || 'AND A.IND_RENOVA= 1          AND'
                  || 'A.IND_PRISEG_LIN= '||LN_PRISEG
            || ' UNION'
            || ' SELECT b.cod_conceptoart'
                   || ' ,b.des_articulo'
                   || ' ,a.prc_venta'
                   || ' ,a.cod_moneda'
                   || ' ,c.des_moneda'
                   || ' ,NVL(a.val_minimo,0)'
                   || ' ,NVL(a.val_maximo,0)'
                   || ' ,''A''-- tipo cargo [ Automatico o Manual ]'
                   || ' ,''1''-- numero unidades'
                   || ' ,''1''-- ind. equipo'
                   || ' ,''0''-- ind. paquete'
                   || ' , b.mes_garantia'
                   || ' ,''0''-- ind. accesorio'
                   || ' ,''0''-- cod. articulo'
                   || ' ,''0''-- cod. stock'
                   || ' ,''0''-- cod. estado'
            || ' FROM al_precios_venta a, '
                 || ' al_articulos b, '
                 || ' ge_monedas c,'
                 || ' (SELECT w.cod_categoria categoria'
                  || ' FROM ve_catplantarif v, ve_categorias w'
                  || ' WHERE v.cod_plantarif = ' || EV_plantarif
                  || ' AND v.cod_categoria = w.cod_categoria) z,'
                 || ' (SELECT p.num_meses meses'
                  || ' FROM ga_percontrato p'
                  || ' WHERE p.cod_producto > 0'
                  || ' AND p.cod_tipcontrato = ' || EV_tipocontrato || ') xy'
            || ' WHERE a.tip_stock = ' || EN_tipstock || ' AND'
                  || ' a.cod_articulo = ' || EN_codarticulo || ' AND'
                  || ' a.cod_uso = ' || EN_codusoventa || ' AND'
                  || ' a.cod_estado = ' || EN_modventa || ' AND'
                  || ' SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND'
                  || ' b.cod_articulo = a.cod_articulo AND'
                  || ' c.cod_moneda = a.cod_moneda AND'
                  || ' a.ind_recambio = 9  AND'
                  || ' a.cod_antiguedad = 0 AND'
                  || ' a.num_meses = xy.meses AND'
                  || ' a.cod_modventa = 1 AND'
                  || ' (b.ind_equiacc = ''A'' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS '
                                                                || ' WHERE nom_parametro LIKE ''USO_PREPAGO%'' AND'
                                                                || ' cod_modulo = ''GA'' AND'
                                                                || ' cod_producto = 1) AND'
                  || ' a.cod_categoria = z.categoria)'
                  || ' a.cod_categoria = ' || vCodCategoria
                  || 'AND A.IND_RENOVA= 1          AND'
                  || 'A.IND_PRISEG_LIN= '||LN_PRISEG;


         LN_contador := 0;
         SELECT COUNT(1)
         INTO LN_contador
         FROM
             (SELECT a.cod_articulo
             FROM al_precios_venta a,
                  al_articulos b,
                  ge_monedas c,
                  (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                  (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
             WHERE a.tip_stock = EN_tipstock AND
                   a.cod_articulo = EN_codarticulo AND
                   a.cod_uso = EN_codusoventa AND
                   a.cod_estado = EN_codestado AND
                   a.cod_modventa = EN_modventa AND
                   a.COD_CALIFICACION= TRIM(LV_COD_CALIFICACION) AND
                   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                   b.cod_articulo = a.cod_articulo AND
                   c.cod_moneda = a.cod_moneda AND
                   a.ind_recambio = 1  AND
                   a.cod_promedio = nPromFact  AND
                   a.cod_antiguedad = 0 AND
                   a.num_meses = xy.meses AND
                   a.cod_categoria = z.categoria AND
                   TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros
                                                WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                             cod_modulo = 'GA' AND    cod_producto = 1) AND
                   a.cod_categoria = vCodCategoria AND
                   b.ind_equiacc = 'E'      AND
                   A.IND_RENOVA= 1          AND
                   A.IND_PRISEG_LIN= LN_PRISEG
             UNION
             SELECT a.cod_articulo
             FROM al_precios_venta a,
                  al_articulos b,
                  ge_monedas c,
                  (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                  (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
             WHERE a.tip_stock = EN_tipstock AND
                   a.cod_articulo = EN_codarticulo AND
                   a.cod_uso = EN_codusoventa AND
                   a.cod_estado = EN_modventa AND
                   A.COD_CALIFICACION=TRIM(LV_COD_CALIFICACION) AND
                   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                   b.cod_articulo = a.cod_articulo AND
                   c.cod_moneda = a.cod_moneda AND
                   a.ind_recambio = 9  AND
                   a.cod_antiguedad = 0 AND
                   a.num_meses = xy.meses AND
                   a.cod_modventa = 1 AND
                   (b.ind_equiacc = 'A' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS
                                                                           WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                                                  cod_modulo = 'GA' AND
                                                                  cod_producto = 1) AND
                   a.cod_categoria = z.categoria)  AND
                   a.cod_categoria = vCodCategoria AND
                   A.IND_RENOVA= 1                 AND
                   A.IND_PRISEG_LIN= LN_PRISEG);

         OPEN SC_cursordatos FOR
            SELECT b.cod_conceptoart
                   ,b.des_articulo
                   ,a.prc_venta
                   ,a.cod_moneda
                   ,c.des_moneda
                   ,NVL(a.val_minimo,0)
                   ,NVL(a.val_maximo,0)
                   ,'A'-- tipo cargo [ Automatico o Manual ]
                   ,'1'-- numero unidades
                   ,'1'-- ind. equipo
                   ,'0'-- ind. paquete
                   , b.mes_garantia
                   ,'0'-- ind. accesorio
                   ,'0'-- cod. articulo
                   ,'0'-- cod. stock
                   ,'0'-- cod. estado
            FROM al_precios_venta a,
                 al_articulos b,
                 ge_monedas c,
                 (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                 (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE a.tip_stock = EN_tipstock AND
                  a.cod_articulo = EN_codarticulo AND
                  a.cod_uso = EN_codusoventa AND
                  a.cod_estado = EN_codestado AND
                  a.cod_modventa = EN_modventa AND
                  A.COD_CALIFICACION=TRIM(LV_COD_CALIFICACION) AND
                  SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                  b.cod_articulo = a.cod_articulo AND
                  c.cod_moneda = a.cod_moneda AND
                  a.ind_recambio = 1  AND
                  a.cod_promedio = nPromFact  AND
                  a.cod_antiguedad = 0 AND
                  a.num_meses = xy.meses AND
                  a.cod_categoria = z.categoria AND
                    TO_CHAR(a.cod_uso) NOT IN (SELECT val_parametro FROM ged_parametros
                                                WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                            cod_modulo = 'GA' AND    cod_producto = 1) AND
                  a.cod_categoria = vCodCategoria AND
                  b.ind_equiacc = 'E'       AND
                  A.IND_RENOVA= 1          AND
                  A.IND_PRISEG_LIN= LN_PRISEG
            UNION
            SELECT b.cod_conceptoart
                   ,b.des_articulo
                   ,a.prc_venta
                   ,a.cod_moneda
                   ,c.des_moneda
                   ,NVL(a.val_minimo,0)
                   ,NVL(a.val_maximo,0)
                   ,'A'-- tipo cargo [ Automatico o Manual ]
                   ,'1'-- numero unidades
                   ,'1'-- ind. equipo
                   ,'0'-- ind. paquete
                   , b.mes_garantia
                   ,'0'-- ind. accesorio
                   ,'0'-- cod. articulo
                   ,'0'-- cod. stock
                   ,'0'-- cod. estado
            FROM al_precios_venta a,
                 al_articulos b,
                 ge_monedas c,
                 (SELECT w.cod_categoria categoria
                  FROM ve_catplantarif v, ve_categorias w
                  WHERE v.cod_plantarif = EV_plantarif
                  AND v.cod_categoria = w.cod_categoria) z,
                 (SELECT p.num_meses meses
                  FROM ga_percontrato p
                  WHERE p.cod_producto > 0
                  AND p.cod_tipcontrato = EV_tipocontrato) xy
            WHERE a.tip_stock = EN_tipstock AND
                  a.cod_articulo = EN_codarticulo AND
                  a.cod_uso = EN_codusoventa AND
                  a.cod_estado = EN_modventa AND
                   A.COD_CALIFICACION=TRIM(LV_COD_CALIFICACION) AND
                  SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                  b.cod_articulo = a.cod_articulo AND
                  c.cod_moneda = a.cod_moneda AND
                  a.ind_recambio = 9  AND
                  a.cod_antiguedad = 0 AND
                  a.num_meses = xy.meses AND
                  a.cod_modventa = 1 AND
                  (b.ind_equiacc = 'A' OR TO_CHAR(a.cod_uso) IN (SELECT val_parametro FROM GED_PARAMETROS
                                                                           WHERE nom_parametro LIKE 'USO_PREPAGO%' AND
                                                                 cod_modulo = 'GA' AND
                                                                 cod_producto = 1) AND
                  a.cod_categoria = z.categoria)    AND
                  a.cod_categoria = vCodCategoria   AND
                  A.IND_RENOVA= 1                   AND
                  A.IND_PRISEG_LIN= LN_PRISEG;
     ELSE

                 SELECT COUNT(1)
                 INTO LN_contador
                 FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND a.cod_estado = EN_codestado
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  AND b.ind_equiacc = EV_indequipo -- cisntante (E)
                  AND a.cod_calificacion=LV_COD_CALIFICACION
                  AND a.IND_PRISEG_LIN=LN_PRISEG
                  AND a.ind_renova=1
                  AND ROWNUM <= 1;

             OPEN SC_cursordatos FOR
                SELECT b.cod_conceptoart
                      ,b.des_articulo
                      ,a.prc_venta
                      ,a.cod_moneda
                      ,c.des_moneda
                      ,NVL(a.val_minimo,0)
                      ,NVL(a.val_maximo,0)
                       ,'A'-- tipo cargo [ Automatico o Manual ]
                      ,'1'-- numero unidades
                        ,'1'-- ind. equipo
                      ,'0'-- ind. paquete
                      ,b.mes_garantia
                      ,'0'-- ind. accesorio
                      ,'0'-- cod. articulo
                      ,'0'-- cod. stock
                      ,'0'-- cod. estado
                FROM al_precios_venta a
                    ,al_articulos b
                    ,ge_monedas c
                    ,(SELECT p.num_meses meses
                      FROM ga_percontrato p
                      WHERE p.cod_producto > 0
                        AND p.cod_tipcontrato = EV_tipocontrato) xy
                WHERE A.tip_stock = EN_tipstock
                  AND a.cod_articulo = EN_codarticulo
                  AND a.cod_uso = EN_codusoventa
                  AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)
                  AND b.cod_articulo = a.cod_articulo
                  AND c.cod_moneda = a.cod_moneda
                  AND a.ind_recambio = 9-- constante (0)
                  AND a.num_meses = xy.meses
                  AND a.cod_categoria = 'ZZZ'
                  AND b.ind_equiacc = EV_indequipo
                  and a.cod_calificacion=LV_COD_CALIFICACION-- cisntante (E)
                  AND a.IND_PRISEG_LIN=LN_PRISEG
                  and a.ind_renova=1;

     END IF;

     IF (LN_contador = 0) THEN
        RAISE no_data_found_cursor;
     END IF;




EXCEPTION
                     WHEN no_data_found_cursor THEN
                           SN_cod_retorno:=99;--SQLCODE;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='no_data_found_cursor:PV_SERVICIOS_POSVENTA_PG.PV_PrecCargTermren_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                        ||EN_codusoventa||','||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                        ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||','||EV_numabonado || ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.PV_PrecCargTermren_NoPreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
                     WHEN OTHERS THEN
                           SN_cod_retorno:=SQLCODE;
                          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                               SV_mens_retorno:=CV_error_no_clasif;
                          END IF;
                          LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_PrecCargTermren_NoPreLis_PR('||EN_codarticulo||','||EN_tipstock||','
                                        ||EN_codusoventa||','||EN_codestado||','||EN_modventa||','||EV_tipocontrato||','||EV_plantarif||','
                                        ||EN_indrecambio||','||EV_codcategoria||','||EN_codusoprepago||','||EV_indequipo||','||EV_numabonado || ');- ' || SQLERRM;
                          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                          'PV_SERVICIOS_POSVENTA_PG.PV_PrecCargTermren_NoPreLis_PR(' || EN_codarticulo || ')', LV_sSql, SQLCODE, LV_des_error );
END PV_PrecCargTermren_NoPreLis_PR;
PROCEDURE VE_obtiene_VtasVendedor_PR (EN_codVendedor  IN GA_VENTAS.COD_VENDEDOR%TYPE,
                                          EN_numVenta     IN GA_VENTAS.NUM_VENTA%TYPE,
                                          EV_codOficina   IN GA_VENTAS.COD_OFICINA%TYPE,
                                          EV_fecDesde     IN VARCHAR2,
                                          EV_fecHasta     IN VARCHAR2,
                                          SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_VtasVendedor_PR"
            Lenguaje="PL/SQL"
            Fecha="07-08-2008"
            Version="1.0.0"
            Dise�ador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
            cursor
        </Retorno>
        <Descripcion>
            Obtiene Listado ventas para el vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
            <param nom="EN_numVenta"      Tipo="NUMBER"> numero de venta </param>
            <param nom="EV_codOficina"    Tipo="NUMBER"> codigo oficina </param>
            <param nom="EV_fecDesde"      Tipo="STRING"> fecha desde</param>
            <param nom="EV_fecHasta"      Tipo="STRING"> fecha hasta </param>
        </Entrada>
        <Salida>
            <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_Error ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LV_sql1         ge_errores_pg.vquery;
            LV_sql2         ge_errores_pg.vquery;
            LV_sql3         ge_errores_pg.vquery;
            LV_sql4         ge_errores_pg.vquery;
            LV_sql5         ge_errores_pg.vquery;
             LN_contador  NUMBER;
            LB_and       BOOLEAN;
        BEGIN
              SN_num_evento   := 0;
            SN_cod_retorno  := 0;
            SV_mens_retorno := '';

            LB_and  := FALSE;

            LV_sql1 := 'SELECT';

            LV_sql2 := ' a.num_venta,TO_CHAR(a.fec_venta,''DD-MM-YYYY''),'
                    || ' a.cod_oficina,d.des_oficina,'
                    || ' a.cod_vendedor,c.nom_vendedor,'
                    || ' a.num_unidades,a.imp_venta';

            LV_sql3 := ' FROM ga_ventas a, ga_abocel b, ve_vendedores c, ge_oficinas d'
                    || ' WHERE ';

            IF (EN_numVenta <> 0) THEN
                LV_sql3 := LV_sql3 || ' a.num_venta = ' || EN_numVenta;
                LB_and  := TRUE;
            END IF;

            IF (EN_codVendedor <> 0) THEN
               IF (LB_and = FALSE) THEN
                      LV_sql3 := LV_sql3 || ' a.cod_vendedor = ' || EN_codVendedor;
                    LB_and  := TRUE;
               ELSE
                      LV_sql3 := LV_sql3 || ' AND a.cod_vendedor = ' || EN_codVendedor;
               END IF;
            END IF;

            IF (EV_codOficina <> '0') THEN
               IF (LB_and = FALSE) THEN
                   LV_sql3 := LV_sql3 || ' a.cod_oficina = ''' || EV_codOficina || '''';
                    LB_and  := TRUE;
               ELSE
                   LV_sql3 := LV_sql3 || ' AND a.cod_oficina = ''' || EV_codOficina || '''';
               END IF;
            END IF;

            IF (LB_and = FALSE) THEN
                LV_sql3 := LV_sql3 || ' b.fec_alta between TO_DATE(''' || EV_fecDesde || ''',''DD-MM-YYYY'')'
                                   || ' AND TO_DATE(''' || EV_fecHasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
            ELSE
                LV_sql3 := LV_sql3 || ' AND a.fec_venta between TO_DATE(''' || EV_fecDesde || ''',''DD-MM-YYYY'')'
                                   || ' AND TO_DATE(''' || EV_fecHasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
            END IF;

            LV_sql3 := LV_sql3 || ' AND a.num_venta = b.num_venta'
                               || ' AND a.cod_vendedor = c.cod_vendedor'
                               || ' AND a.cod_oficina = d.cod_oficina';

            LV_sql5 := ' GROUP BY'
                    || ' a.num_venta,TO_CHAR(a.fec_venta,''DD-MM-YYYY''),'
                    || ' a.cod_oficina,d.des_oficina,'
                    || ' a.cod_vendedor,c.nom_vendedor,'
                    || ' a.num_unidades,a.imp_venta'
                    || ' ORDER BY a.num_venta desc';

            LV_sql := LV_sql1 || LV_sql2 || LV_sql3 || LV_sql5;
            OPEN SC_cursordatos FOR LV_Sql;

        EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error    := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_obtiene_VtasVendedor_PR('|| EN_codVendedor ||'); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'PV_SERVICIOS_POSVENTA_PG.VE_obtiene_VtasVendedor_PR',LV_Sql,SN_cod_retorno,LV_des_error);
    END VE_obtiene_VtasVendedor_PR;
    PROCEDURE VE_getListVendedores_PR (EV_cod_oficina   IN  VARCHAR2,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getListVendedores_PR"
                Lenguaje="PL/SQL"
                Fecha="11-08-2008"
                Version="1.0.0"
                Dise?ador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
            <Retorno>
                cursor
            </Retorno>
            <Descripcion>
                Obtiene Listado vendedores por oficina
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_cod_oficina"       Tipo="STRING"> c�digo oficina </param>
            </Entrada>
            <Salida>
                <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor vendedores </param>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
        IS
            NO_DATA_FOUND_CURSOR EXCEPTION;
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LN_contador  NUMBER;
        BEGIN
              SN_num_evento   := 0;
            SN_cod_retorno  := 0;
            SV_mens_retorno := '';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM ve_vendedores a
            WHERE a.cod_oficina = EV_cod_oficina
            AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE);

            LV_sql:= 'SELECT a.cod_vendedor, a.nom_vendedor '
                  || ' FROM ve_vendedores a '
                  || ' WHERE a.cod_oficina = ''' || EV_cod_oficina || ''''
                  || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)'
                  || ' ORDER BY a.nom_vendedor';

            --IF (LN_contador = 0) THEN
            --    RAISE NO_DATA_FOUND_CURSOR;
            --END IF;

            OPEN SC_cursordatos FOR LV_Sql;

        EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_cod_retorno  := 1;
                     SV_mens_retorno := 'NO_DATA_FOUND';
            WHEN OTHERS THEN
                   SN_cod_retorno := 156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_error_no_clasif;
                  END IF;
                  LV_desError   := 'OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR(' || EV_cod_oficina || ');- ' || SQLERRM;
                  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR(' || EV_cod_oficina|| ')', LV_Sql, SQLCODE, LV_desError );
    END VE_getListVendedores_PR;
    PROCEDURE VE_getListVendedores_PR (EV_cod_oficina   IN  VARCHAR2,
                                       EV_cod_tipcomis  IN  VARCHAR2,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getListVendedores_PR"
                Lenguaje="PL/SQL"
                Fecha="01-10-2007"
                Version="1.0.0"
                Dise?ador="H�ctor Hermosilla"
                Programador="H�ctor Hermosilla"
                Ambiente="BD"
            <Retorno>
                cursor
            </Retorno>
            <Descripcion>
                Obtiene Listado vendedores
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_cod_oficina"       Tipo="STRING"> c�digo oficina </param>
                <param nom="EV_cod_tipcomis"      Tipo="STRING"> c�digo tipo comisionista </param>
            </Entrada>
            <Salida>
                <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor vendedores </param>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
        IS
            NO_DATA_FOUND_CURSOR EXCEPTION;
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LN_contador  NUMBER;
        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM ve_vendedores a
            WHERE a.cod_oficina = EV_cod_oficina
            AND a.cod_tipcomis = EV_cod_tipcomis
            AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE);

            LV_sql:= 'SELECT a.cod_vendedor, a.nom_vendedor '
                  || ' FROM ve_vendedores a '
                  || ' WHERE a.cod_oficina = ''' || EV_cod_oficina || ''''
                  || ' AND a.cod_tipcomis = ''' || EV_cod_tipcomis || ''''
                  || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)'
                  || ' ORDER BY a.nom_vendedor';


            --IF (LN_contador = 0) THEN
            --    RAISE NO_DATA_FOUND_CURSOR;
            --END IF;

             OPEN SC_cursordatos
             FOR LV_Sql;
             /*LOOP
                    FETCH SC_cursordatos INTO LV_codigo, LV_nombre;
                    EXIT WHEN SC_cursordatos%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE ('LV_nombre !!!' || LV_nombre);
             end loop;*/

        EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_cod_retorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                 END IF;
                 LV_desError     := SUBSTR('NO_DATA_FOUND_CURSOR:PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER, 'PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR', LV_Sql, SN_cod_retorno, LV_desError );
            WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_desError:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR(' || EV_cod_oficina || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_getListVendedores_PR(' || EV_cod_oficina|| ')', LV_Sql, SQLCODE, LV_desError );
    END VE_getListVendedores_PR;


    PROCEDURE VE_getListVendDealer_PR (EV_cod_vendedor  IN  VARCHAR2,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getListVendDealer_PR"
                Lenguaje="PL/SQL"
                Fecha="01-10-2007"
                Version="1.0.0"
                Dise?ador="H�ctor Hermosilla"
                Programador="H�ctor Hermosilla"
                Ambiente="BD"
            <Retorno>
                cursor
            </Retorno>
            <Descripcion>
                Obtiene Listado vendedores
            </Descripcion>
            <Parametros>
            <Entrada>
                <param nom="EV_cod_vendedor"       Tipo="STRING"> c�digo vendedor </param>
            </Entrada>
            <Salida>
                <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor dealers </param>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
        IS
            NO_DATA_FOUND_CURSOR EXCEPTION;
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LN_contador  NUMBER;
        BEGIN
              SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LN_contador := 0;
            SELECT COUNT(1)
            INTO LN_contador
            FROM ve_vendealer a
            WHERE a.cod_vendedor = EV_cod_vendedor
            AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE);

            LV_sql:= 'SELECT a.cod_vendealer, a.nom_vendealer '
                  || ' FROM ve_vendealer a '
                  || ' WHERE a.cod_vendedor = ''' || EV_cod_vendedor || ''''
                  || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)'
                  || ' ORDER BY a.nom_vendealer';

            --IF (LN_contador = 0) THEN
            --    RAISE NO_DATA_FOUND_CURSOR;
            --END IF;

            OPEN SC_cursordatos
            FOR LV_Sql;

        EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_cod_retorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                 END IF;
                 LV_desError     := SUBSTR('NO_DATA_FOUND_CURSOR:PV_SERVICIOS_POSVENTA_PG.VE_getListVendDealer_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER, 'PV_SERVICIOS_POSVENTA_PG.VE_getListVendDealer_PR', LV_Sql, SN_cod_retorno, LV_desError );
            WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_desError:='OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_getListVendDealer_PR(' || EV_cod_vendedor || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.VE_getListVendDealer_PR(' || EV_cod_vendedor || ')', LV_Sql, SQLCODE, LV_desError );
    END VE_getListVendDealer_PR;
    PROCEDURE VE_insSeguroAbonado_PR  (EN_NUM_ABONADO   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_COD_SEGURO    IN GA_TIPOSEGURO_TD.COD_SEGURO%TYPE,
                                       EV_NUM_EVENTOS   IN GA_SEGUROABONADO_TO.NUM_EVENTOS%TYPE,
                                       EN_IMPORTE_EQUPO IN GA_SEGUROABONADO_TO.IMPORTE_EQUIPO%TYPE,
                                       EV_NOM_USUARORA  IN GA_SEGUROABONADO_TO.NOM_USUARORA%TYPE,
                                       ED_FEC_FINCONTRATO  IN GA_SEGUROABONADO_TO.FEC_FINCONTRATO%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_ssql:='INSERT INTO GA_SEGUROABONADO_TO (NUM_ABONADO,COD_SEGURO,NUM_EVENTOS,'
            || 'IMPORTE_EQUIPO,FEC_ALTA,FEC_FINCONTRATO,FEC_MODIFICACION,NOM_USUARORA)'
            || 'VALUES('||EN_NUM_ABONADO ||','|| EV_COD_SEGURO ||','|| EV_NUM_EVENTOS || ','
            ||  EN_IMPORTE_EQUPO || ',' || 'SYSDATE,' || ED_FEC_FINCONTRATO || ',SYSDATE)';

            INSERT INTO GA_SEGUROABONADO_TO (NUM_ABONADO,COD_SEGURO,NUM_EVENTOS,
            IMPORTE_EQUIPO,FEC_ALTA,FEC_FINCONTRATO,FEC_MODIFICACION,NOM_USUARORA)
            VALUES(EN_NUM_ABONADO,EV_COD_SEGURO,EV_NUM_EVENTOS,EN_IMPORTE_EQUPO,
            SYSDATE,ED_FEC_FINCONTRATO,SYSDATE,EV_NOM_USUARORA);


    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.VE_insSeguroAbonado_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_insSeguroAbonado_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_insSeguroAbonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_insSeguroAbonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_insSeguroAbonado_PR;

        PROCEDURE VE_ValidaPlanCompartido_PR (EN_COD_CLIENTE   IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                              EV_COD_PLANTARIF IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SELECT COUNT (1)
            INTO LN_contador
            FROM ga_abocel
            WHERE cod_plantarif IN (
                  SELECT cod_plantarif
                  FROM ta_plantarif
                  WHERE ind_compartido = 1
                  AND cod_situacion NOT IN ('BAA', 'BAP'))
            AND cod_cliente = EN_COD_CLIENTE
            AND COD_PLANTARIF <> EV_COD_PLANTARIF;

            IF LN_CONTADOR>0 THEN
               SV_mens_retorno:='Cliente No Puede Tener M�s De Un Plan Con Bolsa Compartida';
               RAISE LE_exception_fin;
            END IF;


    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.VE_ValidaPlanCompartido_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_ValidaPlanCompartido_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_TratPlanCompartido_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ValidaPlanCompartido_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_ValidaPlanCompartido_PR;
        PROCEDURE VE_ObtieneDatosPrestacion_PR (EV_COD_PRESTACION   IN         GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                                SV_DES_PRESTACION   OUT NOCOPY GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                                SV_GRP_PRESTACION   OUT NOCOPY GE_PRESTACIONES_TD.GRP_PRESTACION%TYPE,
                                                SN_IND_ACTIVO       OUT NOCOPY GE_PRESTACIONES_TD.IND_ACTIVO%TYPE,
                                                SN_TIP_VENTA        OUT NOCOPY GE_PRESTACIONES_TD.TIP_VENTA%TYPE,
                                                SV_TIP_RED          OUT NOCOPY GE_PRESTACIONES_TD.TIP_RED%TYPE,
                                                SN_IND_NUMERO       OUT NOCOPY GE_PRESTACIONES_TD.IND_NUMERO%TYPE,
                                                SN_DIR_INTALACION   OUT NOCOPY GE_PRESTACIONES_TD.IND_DIR_INSTALACION%TYPE,
                                                SN_IND_INVENTARIO   OUT NOCOPY GE_PRESTACIONES_TD.IND_INVENTARIO_FIJO%TYPE,
                                                SN_IND_SS_INTERNET  OUT NOCOPY GE_PRESTACIONES_TD.IND_SS_INTERNET%TYPE,
                                                SV_COD_PLANTARIF    OUT NOCOPY GE_PRESTACIONES_TD.COD_PLANTARIF_DEFECTO%TYPE,
                                                SN_COD_CENTRAL      OUT NOCOPY GE_PRESTACIONES_TD.COD_CENTRAL_DEFECTO%TYPE,
                                                SN_COD_CELDA        OUT NOCOPY GE_PRESTACIONES_TD.COD_CELDA_DEFECTO%TYPE,
                                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SELECT DES_PRESTACION,GRP_PRESTACION,IND_ACTIVO,TIP_VENTA,TIP_RED,
            IND_NUMERO,IND_DIR_INSTALACION,IND_INVENTARIO_FIJO,IND_SS_INTERNET,
            COD_PLANTARIF_DEFECTO,COD_CENTRAL_DEFECTO,COD_CELDA_DEFECTO
            INTO SV_DES_PRESTACION,SV_GRP_PRESTACION,SN_IND_ACTIVO,SN_TIP_VENTA,SV_TIP_RED,SN_IND_NUMERO,SN_DIR_INTALACION,SN_IND_INVENTARIO,SN_IND_SS_INTERNET,SV_COD_PLANTARIF,
            SN_COD_CENTRAL,SN_COD_CELDA
            FROM GE_PRESTACIONES_TD
            WHERE COD_PRESTACION=EV_COD_PRESTACION;


    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDatosPrestacion_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_ValidaPlanCompartido_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDatosPrestacion_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDatosPrestacion_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_ObtieneDatosPrestacion_PR;

          PROCEDURE VE_ObtieneDirOficina_PR    (EV_COD_OFICINA      IN         GE_OFICINAS.COD_OFICINA%TYPE,
                                                SV_COD_REGION       OUT NOCOPY GE_REGIONES.COD_REGION%TYPE,
                                                SV_COD_PROVINCIA    OUT NOCOPY GE_PROVINCIAS.COD_PROVINCIA%TYPE,
                                                SV_COD_CIUDAD       OUT NOCOPY GE_CIUDADES.COD_CIUDAD%TYPE,
                                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

         SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD
         INTO SV_COD_REGION,SV_COD_PROVINCIA,SV_COD_CIUDAD
         FROM GE_OFICINAS A, GE_DIRECCIONES B
         WHERE A.COD_OFICINA = EV_COD_OFICINA
         AND B.COD_DIRECCION = A.COD_DIRECCION;


         IF SV_COD_CIUDAD IS NULL THEN
            --Obtener ciudad por defecto
           BEGIN
            SELECT VAL_PARAMETRO
            INTO SV_COD_CIUDAD
            FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'CIUDAD_DEFAULT';

           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  NULL;
           END;
         END IF;




    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDirOficina_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDirOficina_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDirOficina_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.VE_ObtieneDirOficina_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_ObtieneDirOficina_PR;




  PROCEDURE PV_DETALLE_DOC_PR(         EN_codVendedor  IN GA_VENTAS.COD_VENDEDOR%TYPE,
                                       EN_numVenta     IN GA_VENTAS.NUM_VENTA%TYPE,
                                       EV_codOficina   IN GA_VENTAS.COD_OFICINA%TYPE,
                                       EV_fecDesde     IN VARCHAR2,
                                       EV_fecHasta     IN VARCHAR2,
                                       EN_COD_CLIENTE  IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                       EV_IND_ESTVENTA IN GA_VENTAS.IND_ESTVENTA%TYPE,
                                       EV_ORIGEN       IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR) IS
    /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "PV_DETALLE_DOC_PR"
        Lenguaje="PL/SQL"
        Fecha="20-01-2010"
        Version="1.0.0"
        Dise?ador="oRLANDO cABEZAS"
        Programador="oRLANDO cABEZAS"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Listado de Ventas por Vendedor
    </Descripcion>
    <Parametros>
     <Entrada>
            <param nom="EN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
            <param nom="EN_numVenta"      Tipo="NUMBER"> numero de venta </param>
            <param nom="EV_codOficina"    Tipo="NUMBER"> codigo oficina </param>
            <param nom="EV_fecDesde"      Tipo="STRING"> fecha desde</param>
            <param nom="EV_fecHasta"      Tipo="STRING"> fecha hasta </param>
        </Entrada>
        <Salida>
            <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/

       no_data_found_cursor      EXCEPTION;
       LV_des_error        ge_errores_pg.DesEvent;
       LV_sSql             ge_errores_pg.vQuery;
       LN_contador         NUMBER;
       SN_cod_retorno      ge_errores_pg.CodError;
       SV_mens_retorno     ge_errores_pg.MsgError;
       SN_num_evento       ge_errores_pg.Evento;
    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';



        LV_sSql:='VE_SERVICIOS_VENTA_PG.VE_obtiene_VtasVendedor_PR(' || EN_codVendedor || ',' || EN_numVenta    || ',' || EV_codOficina  || ',' || EV_fecDesde || ',' || EV_fecHasta || ',' || EN_COD_CLIENTE || ',' || EV_IND_ESTVENTA ||',' || EV_ORIGEN || ')';


        VE_SERVICIOS_VENTA_PG.VE_obtiene_VtasVendedor_PR(EN_codVendedor ,
                                                         EN_numVenta    ,
                                                         EV_codOficina  ,
                                                         EV_fecDesde    ,
                                                         EV_fecHasta    ,
                                                         EN_COD_CLIENTE ,
                                                         EV_IND_ESTVENTA,
                                                         EV_ORIGEN      ,
                                                         SC_cursorDatos ,
                                                         SN_cod_retorno ,
                                                         SV_mens_retorno,
                                                         SN_num_evento
                                                        ) ;




    EXCEPTION

        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_DETALLE_DOC_PR('|| EN_numventa ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.PV_DETALLE_DOC_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END PV_DETALLE_DOC_PR;

    PROCEDURE PV_actualizaLimcons_PR           (EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                                EN_COD_LIMCONS      IN GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE,
                                                ED_FEC_DESDE        IN GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE,
                                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin   EXCEPTION;
        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LN_num_transaccion NUMBER;
        LN_contador        NUMBER;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';


            UPDATE GA_LIMITE_CLIABO_TO
            SET COD_LIMCONS=EN_COD_LIMCONS
            WHERE NUM_ABONADO=EN_NUM_ABONADO
            AND COD_CLIENTE=EN_COD_CLIENTE
            AND TRUNC(FEC_DESDE)=TRUNC(ED_FEC_DESDE)
            AND (FEC_HASTA IS NULL OR FEC_HASTA> SYSDATE);


            IF TRUNC(ED_FEC_DESDE)=TRUNC(SYSDATE) THEN
    	  	   UPDATE GA_ABOCEL
			   SET COD_LIMCONSUMO=EN_COD_LIMCONS
			   WHERE NUM_ABONADO = EN_NUM_ABONADO;
  		    END IF;



    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR', LV_sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.PV_actualizaLimcons_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END PV_actualizaLimcons_PR;


    PROCEDURE PV_obtieneDatosPlanTarif_PR (EV_COD_PLANTARIF    IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                           EN_IND_COMPARTIDO   OUT NOCOPY TA_PLANTARIF.IND_COMPARTIDO%TYPE,
                                           SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin    EXCEPTION;
        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql             ge_errores_pg.vQuery;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            SELECT IND_COMPARTIDO INTO EN_IND_COMPARTIDO
            FROM TA_PLANTARIF WHERE COD_PLANTARIF = EV_COD_PLANTARIF;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.PV_obtieneDatosPlanTarif_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.PV_obtieneDatosPlanTarif_PR', LV_sSql, SN_cod_retorno, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_obtieneDatosPlanTarif_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.PV_obtieneDatosPlanTarif_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END PV_obtieneDatosPlanTarif_PR;

    PROCEDURE PV_insertaDatosCorreo_PR (EN_COD_CLIENTE          IN GA_DATOS_ADICIONALES_CORREO_TO.COD_CLIENTE%TYPE,
                                        EN_NUM_ABONADO          IN GA_DATOS_ADICIONALES_CORREO_TO.NUM_ABONADO%TYPE,
                                        EN_COD_PROD_CONTRATADO  IN GA_DATOS_ADICIONALES_CORREO_TO.COD_PROD_CONTRATADO%TYPE,
                                        EN_NOMBRE_USUARIO       IN GA_DATOS_ADICIONALES_CORREO_TO.NOMBRE_USUARIO_CORREO%TYPE,
                                        EV_EMAIL_PERSONAL       IN GA_DATOS_ADICIONALES_CORREO_TO.EMAIL_PERSONAL%TYPE,
                                        EV_EMAIL_CORPORATIVO    IN GA_DATOS_ADICIONALES_CORREO_TO.EMAIL_CORPORATIVO%TYPE,
                                        EN_COD_DIRECCION        IN GA_DATOS_ADICIONALES_CORREO_TO.COD_DIRECCION%TYPE,
                                        EN_NUM_TELEFONO         IN GA_DATOS_ADICIONALES_CORREO_TO.NUM_TELEFONO%TYPE,
                                        EV_USUARIO              IN GA_DATOS_ADICIONALES_CORREO_TO.NOM_USUARORA%TYPE,
                                        SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS
        LE_exception_fin    EXCEPTION;
        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql             ge_errores_pg.vQuery;
       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            INSERT INTO GA_DATOS_ADICIONALES_CORREO_TO
            (   COD_CLIENTE,
                NUM_ABONADO,
                COD_PROD_CONTRATADO,
                NOMBRE_USUARIO_CORREO,
                EMAIL_PERSONAL,
                EMAIL_CORPORATIVO,
                COD_DIRECCION,
                NUM_TELEFONO,
                FEC_MODIFICACION,
                NOM_USUARORA )
            VALUES
            (
                EN_COD_CLIENTE,
                EN_NUM_ABONADO,
                EN_COD_PROD_CONTRATADO,
                EN_NOMBRE_USUARIO,
                EV_EMAIL_PERSONAL,
                EV_EMAIL_CORPORATIVO,
                EN_COD_DIRECCION,
                EN_NUM_TELEFONO,
                SYSDATE,
                EV_USUARIO
            );


    EXCEPTION

         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_insertaDatosCorreo_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_SERVICIOS_POSVENTA_PG.PV_insertaDatosCorreo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END PV_insertaDatosCorreo_PR;


    PROCEDURE PV_listaTiposComportamiento_PR(  SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)

            /*--
            <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "PV_listaTiposComportamiento"
                Lenguaje="PL/SQL"
                Fecha="22-04-2010"
                Version="1.0.0"
                Disenador="Elizabeth Vera"
                Programador="Elizabeth Vera"
                Ambiente="BD"
            <Retorno>
                cursor
            </Retorno>
            <Descripcion>
                Obtiene Listado tipos comportamiento
            </Descripcion>
            <Parametros>
            <Salida>
                <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor tipos comportamiento </param>
                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
            </Salida>
            </Parametros>
            </Elemento>
            </Documentacion>
            --*/
        IS
            LV_desError  ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;

        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sql:= ' SELECT valor, descripcion_valor '
                  || ' FROM PS_TIPO_COMPORTAMIENTO_VW ';

            OPEN SC_cursorDatos FOR
            SELECT valor, descripcion_valor
            FROM PS_TIPO_COMPORTAMIENTO_VW;


        EXCEPTION
            WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_desError:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_listaTiposComportamiento_PR;- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'PV_SERVICIOS_POSVENTA_PG.PV_listaTiposComportamiento_PR', LV_Sql, SQLCODE, LV_desError );
    END PV_listaTiposComportamiento_PR;


 PROCEDURE PV_getList_Series_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
                                    EN_COD_ARTICULO IN  AL_SERIES.COD_ARTICULO%TYPE,
                                    EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                    EN_COD_MODVENTA IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                    EN_COD_CANAL    IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                    EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                    EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                    EN_COD_USO      IN  AL_USOS.COD_USO%TYPE,
                                    EN_TIP_ARTICULO IN  VARCHAR2, --S Simcard A:Articulo
                                    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
        LN_TipArticuloKit  al_articulos.TIP_ARTICULO%TYPE;
        LN_TIPArticulo AL_ARTICULOS.TIP_ARTICULO%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;
        BEGIN

        SELECT VAL_PARAMETRO
        INTO LN_TipArticuloKit
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_ARTICULO_KIT';
        SELECT TIP_ARTICULO
        INTO LN_TIPArticulo
        FROM AL_ARTICULOS
        WHERE COD_ARTICULO=EN_COD_ARTICULO;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           NULL;
        END;




        LV_Sql:= 'SELECT b.des_stock, a.num_serie, a.num_seriemec, a.num_telefono, '
            ||   ' a.cod_central, a.tip_stock, a.cod_uso, b.ind_valorar,a.fec_entrada '
            ||   ' FROM al_series a, al_tipos_stock b, ve_vendalmac c'
            ||   ' WHERE a.cod_bodega =' || EN_COD_BODEGA
            ||   ' AND a.cod_articulo =' || EN_COD_ARTICULO
            ||   ' AND a.cod_estado = 1';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.cod_hlr =''' || EV_COD_HLR || ''''; --Diferencia entre Simcard y equipo
            END IF;
        LV_Sql:= LV_Sql || ' AND a.cod_producto = 1'
            ||' AND a.tip_stock IN'
            ||' (SELECT c.tip_stock'
            ||' FROM ga_modvent_aplic c'
            ||' WHERE c.cod_producto = 1'
            ||' AND c.cod_modventa =' || EN_COD_MODVENTA
            ||' AND c.cod_modventa IN'
            ||' (SELECT cod_modventa_nue'
            ||'  FROM ga_modvent_aplic d'
            ||'  WHERE c.cod_modventa = d.cod_modventa)'
            ||'  AND c.cod_canal ='|| EN_COD_CANAL
            ||'  AND c.cod_aplic IS NULL)';
            IF EN_COD_USO<>3 THEN
               LV_Sql:= LV_Sql ||  '  AND a.num_telefono IS NULL';
            END IF;
            IF LN_TIPArticulo = LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.ind_telefono=0'; --Diferencia entre Simcard y equipo
            ELSIF EN_COD_USO=3 AND EN_TIP_ARTICULO='S' THEN
               --LV_Sql:= LV_Sql || ' AND a.ind_telefono=6'; --Diferencia entre Simcard y equipo
               LV_Sql:= LV_Sql || ' AND a.ind_telefono=0'; --Inc 149273
            END IF;
            LV_Sql:= LV_Sql ||'  AND b.tip_stock = a.tip_stock'
            || '  AND ((a.num_telefono IS NULL';
            IF EN_COD_USO <> 3 THEN
               LV_Sql:= LV_Sql || '  AND a.cod_uso IN (1, 2, 8, 9, 13, 10, 14, 15, 16, 17, 55, 4))';
            ELSE
               LV_Sql:= LV_Sql ||'  AND a.cod_uso IN (3))';
            END IF;
            LV_Sql:= LV_Sql ||'  OR (a.num_telefono IS NOT NULL';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql ||'  AND a.cod_central =' || EN_COD_CENTRAL;
            END IF;
            LV_Sql:= LV_Sql || '  AND a.cod_uso =' || EN_COD_USO
            ||'  ))'
            ||'  AND b.tip_stock = a.tip_stock'
            ||'  AND a.tip_stock <> 1'
            ||'  AND ind_telefono <>'
            ||' (SELECT val_parametro'
            ||' FROM ged_parametros'
            ||' WHERE cod_modulo = ''GE'''
            ||' AND cod_producto = 1'
            ||' AND nom_parametro = ''IND_TEL_OUT'')'
            ||'  AND c.cod_vendedor=' || EN_COD_VENDEDOR
            ||'  AND c.cod_bodega=a.cod_bodega'
            ||'  AND SYSDATE BETWEEN C.FEC_ASIGNACION AND NVL(C.FEC_DESASIGNAC,SYSDATE)'
            ||'  AND a.cod_uso  =' || EN_COD_USO
            ||'  AND ROWNUM <= 100'
            ||'  ORDER BY FEC_ENTRADA ASC';

            OPEN SC_CURSORDATOS FOR LV_Sql;




    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_parametros_comerciales_PG.VE_Busca_Serie_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'VE_parametros_comerciales_PG.VE_Busca_Serie_PR', LV_Sql, SQLCODE, LV_des_error );
 END PV_getList_Series_PR;
 
--INICIO 177697 PAH 
  PROCEDURE PV_getList_Series_SinUso_PR(    EN_COD_BODEGA   IN  AL_SERIES.COD_BODEGA%TYPE,
                                    EN_COD_ARTICULO IN  AL_SERIES.COD_ARTICULO%TYPE,
                                    EV_COD_HLR      IN  ICG_CENTRAL.COD_HLR%TYPE,
                                    EN_COD_MODVENTA IN  GE_MODVENTA.COD_MODVENTA%TYPE,
                                    EN_COD_CANAL    IN  GA_MODVENT_APLIC.COD_CANAL%TYPE,
                                    EN_COD_VENDEDOR IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                    EN_COD_CENTRAL  IN  ICG_CENTRAL.COD_CENTRAL%TYPE,
                                    EN_TIP_ARTICULO IN  VARCHAR2, --S Simcard A:Articulo
                                    SC_cursordatos  OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count      NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        TipArticulo   AL_ARTICULOS.TIP_TERMINAL%TYPE;
        LN_TipArticuloKit  al_articulos.TIP_ARTICULO%TYPE;
        LN_TIPArticulo AL_ARTICULOS.TIP_ARTICULO%TYPE;
    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;
        BEGIN

        SELECT VAL_PARAMETRO
        INTO LN_TipArticuloKit
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO ='TIP_ARTICULO_KIT';
        SELECT TIP_ARTICULO
        INTO LN_TIPArticulo
        FROM AL_ARTICULOS
        WHERE COD_ARTICULO=EN_COD_ARTICULO;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           NULL;
        END;




        LV_Sql:= 'SELECT b.des_stock, a.num_serie, a.num_seriemec, a.num_telefono, '
            ||   ' a.cod_central, a.tip_stock, a.cod_uso, b.ind_valorar,a.fec_entrada '
            ||   ' FROM al_series a, al_tipos_stock b, ve_vendalmac c'
            ||   ' WHERE a.cod_bodega =' || EN_COD_BODEGA
            ||   ' AND a.cod_articulo =' || EN_COD_ARTICULO
            ||   ' AND a.cod_estado = 1';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.cod_hlr =''' || EV_COD_HLR || ''''; --Diferencia entre Simcard y equipo
            END IF;
        LV_Sql:= LV_Sql || ' AND a.cod_producto = 1'
            ||' AND a.tip_stock IN'
            ||' (SELECT c.tip_stock'
            ||' FROM ga_modvent_aplic c'
            ||' WHERE c.cod_producto = 1'
            ||' AND c.cod_modventa =' || EN_COD_MODVENTA
            ||' AND c.cod_modventa IN'
            ||' (SELECT cod_modventa_nue'
            ||'  FROM ga_modvent_aplic d'
            ||'  WHERE c.cod_modventa = d.cod_modventa)'
            ||'  AND c.cod_canal ='|| EN_COD_CANAL
            ||'  AND c.cod_aplic IS NULL)';
            IF LN_TIPArticulo = LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql || ' AND a.ind_telefono=0'; --Diferencia entre Simcard y equipo
            END IF;
            LV_Sql:= LV_Sql ||'  AND b.tip_stock = a.tip_stock'
            || '  AND ((a.num_telefono IS NULL)';
            LV_Sql:= LV_Sql ||'  OR (a.num_telefono IS NOT NULL';
            IF EN_TIP_ARTICULO='S' AND LN_TIPArticulo <> LN_TipArticuloKit THEN --Si es Simcard y no es KIT
               LV_Sql:= LV_Sql ||'  AND a.cod_central =' || EN_COD_CENTRAL;
            END IF;
            LV_Sql:= LV_Sql ||'  ))'
            ||'  AND b.tip_stock = a.tip_stock'
            ||'  AND a.tip_stock <> 1'
            ||'  AND ind_telefono <>'
            ||' (SELECT val_parametro'
            ||' FROM ged_parametros'
            ||' WHERE cod_modulo = ''GE'''
            ||' AND cod_producto = 1'
            ||' AND nom_parametro = ''IND_TEL_OUT'')'
            ||'  AND c.cod_vendedor=' || EN_COD_VENDEDOR
            ||'  AND c.cod_bodega=a.cod_bodega'
            ||'  AND SYSDATE BETWEEN C.FEC_ASIGNACION AND NVL(C.FEC_DESASIGNAC,SYSDATE)'
            ||'  AND ROWNUM <= 100'
            ||'  ORDER BY FEC_ENTRADA ASC';

            OPEN SC_CURSORDATOS FOR LV_Sql;




    EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                'PV_SERVICIOS_POSVENTA_PG.PV_getList_Series_SinUso_PR()', LV_Sql, SQLCODE, LV_des_error );
 END PV_getList_Series_SinUso_PR;
--FIN 177697 PAH
END PV_SERVICIOS_POSVENTA_PG;
/
SHOW ERRORS
