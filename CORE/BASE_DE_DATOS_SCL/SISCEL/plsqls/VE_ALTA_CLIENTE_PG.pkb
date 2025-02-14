CREATE OR REPLACE PACKAGE BODY VE_ALTA_CLIENTE_PG IS

    --------------------
    -- PROCEDIMIENTOS --
    --------------------
    -- RECOMPILACION

    PROCEDURE VE_getFecha_PR(EV_fecha          VARCHAR2,
                             EV_formatofecha   VARCHAR2,
                             EV_formatohora    VARCHAR2,
                             SD_fecha          OUT NOCOPY DATE,
                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_getFecha_PR
        Lenguaje="PL/SQL"
        Fecha="06-06-2007"
        Versión="1.0.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
    <Retorno> NUMBER </Retorno>
    <Descripción>
        Retorna una fecha formateada segun parametros
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_fecha"        Tipo="VARCHAR2">fecha a formatear</param>
        <param nom="EV_formatofecha" Tipo="VARCHAR2">formato fecha</param>
        <param nom="EV_formatohora"  Tipo="VARCHAR2">formato hora</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
        LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

    LV_fechaMaxima  VARCHAR2(20);
    LV_formatofecha VARCHAR2(20);
    LV_formatohora  VARCHAR2(20);
    LD_fecha        DATE;
    BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL2
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(EV_formatofecha,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_formatofecha,
                                                            LV_CodeSql,
                                                            LV_ErrmSql,
                                                            LN_NumEvento);

        --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL7
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(EV_formatohora,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_formatohora,
                                                            LV_CodeSql,
                                                            LV_ErrmSql,
                                                            LN_NumEvento);

        LV_Sql := 'TO_DATE('||EV_fecha||','||LV_formatofecha||' '||LV_formatohora||')';

        SD_fecha := TO_DATE(EV_fecha,LV_formatofecha||' '||LV_formatohora);

    EXCEPTION
        WHEN OTHERS THEN
             LV_FormatoFecha := 'YYYYMMDD HH24MISS';
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno:=CV_ERRORNOCLASIF;
             END IF;
             LV_des_error:='OTHERS:VE_alta_cliente_PG.VE_getFecha_PR;- ' || SQLERRM;
             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
             'VE_alta_cliente_PG.VE_getFecha_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_getFecha_PR;

--     PROCEDURE VE_getValorParametro_PR(EV_nomParametro IN ged_parametros.nom_parametro%TYPE,
--                                         EV_codModulo      IN ged_parametros.cod_modulo%TYPE,
--                                       EV_codProducto  IN ged_parametros.cod_producto%TYPE,
--                                       SV_valParametro OUT NOCOPY ged_parametros.val_parametro%TYPE,
--                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
--                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
--                                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
--         /*
--         <Documentación TipoDoc = "Procedimiento">
--             Elemento Nombre = "VE_getValorParametro_PR"
--             Lenguaje="PL/SQL"
--             Fecha="17-05-2007"
--             Versión="1.0.0"
--             Diseñador="wjrc"
--             Programador="wjrc"
--             Ambiente="BD"
--         <Retorno>
--                   Retorna el valor del parametro
--         </Retorno>
--         <Descripción>
--                   Retorna el valor del parametro
--         </Descripción>
--         <Parámetros>
--              <Entrada>
--                <param nom="EV_nomParametro" Tipo="STRING"> Nombre del parametro </param>
--                <param nom="EV_codModulo"    Tipo="STRING"> codigo de modulo </param>
--                <param nom="EV_codProducto"  Tipo="STRING"> codigo de producto </param>
--              </Entrada>
--              <Salida>
--                <param nom="SV_valParametro" Tipo="STRING"> valor de parametro buscado </param>
--                <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
--                <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
--                <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
--              </Salida>
--         </Parámetros>
--         </Elemento>
--         </Documentación>
--         */
--         LV_desError ge_errores_pg.desevent;
--         LV_sql        ge_errores_pg.vquery;
--     BEGIN
--         SN_codRetorno := 0;
--         SV_menRetorno := NULL;
--         SN_numEvento  := 0;
--
--         LV_Sql:='SELECT a.val_parametro '
--             || 'FROM ged_parametros a '
--             || 'WHERE a.nom_parametro = ' || EV_nomParametro
--             || ' AND a.cod_modulo = ' || EV_codModulo
--             || ' AND a.cod_producto = ' || EV_codProducto;
--
--         SELECT a.val_parametro
--         INTO   SV_valParametro
--         FROM   ged_parametros a
--         WHERE  a.nom_parametro  = EV_nomParametro
--           AND    a.cod_modulo   = EV_codModulo
--           AND    a.cod_producto = EV_codProducto;
--
--
--     EXCEPTION
--              WHEN NO_DATA_FOUND THEN
--                 SN_codRetorno := 1;
--                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
--                    SV_menRetorno := CV_ERRORNOCLASIF;
--                 END IF;
--                 LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getValorParametro_PR;- ' || SQLERRM;
--                 SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
--                 'VE_alta_cliente_PG.VE_getValorParametro_PR', LV_Sql, SQLCODE, LV_desError );
--              WHEN OTHERS THEN
--                 SN_codRetorno := 156;
--                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
--                    SV_menRetorno := CV_ERRORNOCLASIF;
--                 END IF;
--                 LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getValorParametro_PR;- ' || SQLERRM;
--                 SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
--                 'VE_alta_cliente_PG.VE_getValorParametro_PR', LV_Sql, SQLCODE, LV_desError );
--     END VE_getValorParametro_PR;

    PROCEDURE VE_getPlanComercial_PR(EV_codCalifCte  IN  ve_plan_calcli.cod_calclien%TYPE,
                                     SN_codPlanCom   OUT NOCOPY ve_cabplancom.cod_plancom%TYPE,
                                     SV_desPlanCom   OUT NOCOPY ve_cabplancom.des_plancom%TYPE,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getPlanComercial_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna codigo y descripcion plan comercial, segun calificacion del cliente
        </Retorno>
        <Descripción>
                  Retorna codigo y descripcion plan comercial, segun calificacion del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EV_codCalifCte" Tipo="STRING"> codigo calificacion cliente </param>
             </Entrada>
             <Salida>
               <param nom="SV_codPlanCom"  Tipo="STRING"> codigo plan comercial </param>
               <param nom="SV_desPlanCom"  Tipo="STRING"> descripcion plan comercial </param>
               <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT b.cod_plancom,b.des_plancom '
            || 'FROM ve_plan_calcli a, ve_cabplancom b'
            || 'WHERE a.cod_plancom = b.cod_plancom '
            || '  AND a.cod_calclien = ' || EV_codCalifCte
            || '  AND SYSDATE BETWEEN a.fec_asignacion AND NVL(a.fec_desasignac,SYSDATE) '
            || '  AND b.cod_plancom = a.cod_plancom '
            || '  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)';

        SELECT b.cod_plancom,b.des_plancom
        INTO SN_codPlanCom,SV_desPlanCom
        FROM ve_plan_calcli a, ve_cabplancom b
        WHERE a.cod_plancom = b.cod_plancom
          AND a.cod_calclien = EV_codCalifCte
          AND SYSDATE BETWEEN a.fec_asignacion AND NVL(a.fec_desasignac,SYSDATE)
          AND b.cod_plancom = a.cod_plancom
          AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE);

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getPlanComercial_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getPlanComercial_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getPlanComercial_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getPlanComercial_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getPlanComercial_PR;

    PROCEDURE VE_getCodigoNuevoCliente_PR(SN_codCliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                          SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento  OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getCodigoNuevoCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="23-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna codigo nuevo cliente
        </Retorno>
        <Descripción>
                  Retorna codigo nuevo cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="SN_codCliente" Tipo="STRING"> codigo nuevo cliente </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:= 'GE_SEG_CLIENTES_FN()';

        --SN_codCliente := GE_SEG_CLIENTES_FN();

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getCodigoNuevoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getCodigoNuevoCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getCodigoNuevoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getCodigoNuevoCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getCodigoNuevoCliente_PR;

    PROCEDURE VE_getProspectoCliente_PR(EV_codTipIdent   IN  ve_prospectos.cod_tipident%TYPE,
                                        EV_numIdent      IN  ve_prospectos.num_ident%TYPE,
                                         SV_nomNombre     OUT NOCOPY ve_prospectos.nom_nombre%TYPE,
                                          SV_nomApellido1  OUT NOCOPY ve_prospectos.nom_apellido1%TYPE,
                                          SV_nomApellido2  OUT NOCOPY ve_prospectos.nom_apellido2%TYPE,
                                          SV_numTelef1     OUT NOCOPY ve_prospectos.num_telef1%TYPE,
                                          SV_numTelef2     OUT NOCOPY ve_prospectos.num_telef2%TYPE,
                                          SV_numFax        OUT NOCOPY ve_prospectos.num_fax%TYPE,
                                          SV_nomReprlegal  OUT NOCOPY ve_prospectos.nom_reprlegal%TYPE,
                                          SV_codTipidrepr  OUT NOCOPY ve_prospectos.cod_tipidrepr%TYPE,
                                             SV_numIdrepr     OUT NOCOPY ve_prospectos.num_idrepr%TYPE,
                                          SN_codRubro      OUT NOCOPY ve_prospectos.cod_rubro%TYPE,
                                          SV_codBanco      OUT NOCOPY ve_prospectos.cod_banco%TYPE,
                                          SV_numCuenta     OUT NOCOPY ve_prospectos.num_cuentA%TYPE,
                                         SV_codTiptarjeta OUT NOCOPY ve_prospectos.cod_tiptarjeta%TYPE,
                                          SV_numTarjeta    OUT NOCOPY ve_prospectos.num_tarjeta%TYPE,
                                         SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getProspecto_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
        </Retorno>
        <Descripción>
                  Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EV_codTipIdent" Tipo="STRING"> codigo tipo identificador </param>
               <param nom="EV_numIdent"    Tipo="STRING"> numero de identificacion </param>
             </Entrada>
             <Salida>
               <param nom="SV_nomNombre"     Tipo="STRING"> nombre </param>
               <param nom="SV_nomApellido1"  Tipo="STRING"> apellido 1 </param>
               <param nom="SV_nomApellido2"  Tipo="STRING"> apellido 2 </param>
               <param nom="SV_numTelef1"     Tipo="STRING"> numero telefono 1</param>
               <param nom="SV_numTelef2"     Tipo="STRING"> numero telefono 2</param>
               <param nom="SV_numFax"        Tipo="STRING"> numero fax </param>
               <param nom="SV_nomReprlegal"  Tipo="STRING"> nombre representante legal </param>
               <param nom="SV_codTipidrepr"  Tipo="STRING"> codigo tipo representante legal</param>
               <param nom="SV_numIdrepr"     Tipo="STRING"> numero identificador representante </param>
               <param nom="SN_codRubro"      Tipo="NUMBER"> codigo rubro </param>
               <param nom="SV_codBanco"      Tipo="STRING"> codigo banco </param>
               <param nom="SV_numCuenta"     Tipo="STRING"> numero cuenta </param>
               <param nom="SV_codTiptarjeta" Tipo="STRING"> codigo tipo tarjeta </param>
               <param nom="SV_numTarjeta"    Tipo="STRING"> numero tarjeta </param>
               <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.nombre_cliente,a.des_nombre,a.primer_apellido,a.segundo_apellido,a.cod_tipident '
            || 'FROM ert_solicitud_campos a '
            || 'WHERE a.num_ident = ' || EV_numIdent;

        SELECT a.nom_nombre,
               a.nom_apellido1,
               a.nom_apellido2,
               a.num_telef1,
               a.num_telef2,
               a.num_fax,
               a.nom_reprlegal,
               a.cod_tipidrepr,
                  a.num_idrepr,
               a.cod_rubro,
               a.cod_banco,
               a.num_cuenta,
               a.cod_tiptarjeta,
               a.num_tarjeta
        INTO SV_nomNombre,
             SV_nomApellido1,
             SV_nomApellido2,
             SV_numTelef1,
             SV_numTelef2,
             SV_numFax,
             SV_nomReprlegal,
             SV_codTipidrepr,
                SV_numIdrepr,
             SN_codRubro,
             SV_codBanco,
             SV_numCuenta,
             SV_codTiptarjeta,
             SV_numTarjeta
        FROM ve_prospectos a
        WHERE a.cod_tipident = EV_codTipIdent
          AND a.num_ident = EV_numIdent;

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getProspectoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getProspectoCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getProspectoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getProspectoCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getProspectoCliente_PR;

    PROCEDURE VE_getProspectoDireccion_PR(EN_codProspecto IN  ve_prodireccion.cod_prospecto%TYPE,
                                            EV_tipDireccion IN  ve_prodireccion.cod_tipdireccion%TYPE,
                                          SN_codDireccion OUT NOCOPY ve_prodireccion.cod_direccion%TYPE,
                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getProspectoDireccion_PR"
            Lenguaje="PL/SQL"
            Fecha="17-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna plan tarifario autorizado
        </Retorno>
        <Descripción>
                  Retorna plan tarifario autorizado para la evaluacion de riesgo
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_numSolicitud" Tipo="NUMBER"> numero de solicitud </param>
               <param nom="EV_tipDireccion" Tipo="STRING"> tipo direccion </param>
             </Entrada>
             <Salida>
               <param nom="SV_codPlanTarif" Tipo="STRING"> codigo plan tarifario </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_direccion '
            || 'FROM ve_prodireccion a '
            || 'WHERE a.cod_prospecto <=' || EN_codProspecto
            || '  AND a.cod_tipdireccion = ' || EV_tipDireccion;

        SELECT a.cod_direccion
        INTO SN_codDireccion
        FROM ve_prodireccion a
        WHERE a.cod_prospecto <= EN_codProspecto
            AND a.cod_tipdireccion = EV_tipDireccion; -- 2 !!!

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getProspectoDireccion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getProspectoDireccion_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getProspectoDireccion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getProspectoDireccion_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getProspectoDireccion_PR;

    PROCEDURE VE_getClienteVendedor_PR(EV_codTipIdent   IN  ge_clientes.cod_tipident%TYPE,
                                       EV_numIdent      IN  ge_clientes.num_ident%TYPE,
                                        SN_codCategoria  OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                         SN_codSector     OUT NOCOPY ge_clientes.cod_sector%TYPE,
                                         SN_codSupervisor OUT NOCOPY ge_clientes.cod_supervisor%TYPE,
                                         SN_codVendedor   OUT NOCOPY ve_vendcliente.cod_vendedor%TYPE,
                                        SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getClienteVendedor_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  datos cliente y vendedor
        </Retorno>
        <Descripción>
                  Saber si otro cliente con igual identificacion ya esta creado
        <Parámetros>
        </Descripción>
             <Entrada>
               <param nom="EV_codTipIdent" Tipo="STRING"> codigo tipo identificador </param>
               <param nom="EV_numIdent"    Tipo="STRING"> numero de identificacion </param>
             </Entrada>
             <Salida>
               <param nom="SN_codCategoria"  Tipo="NUMBER"> codigo categoria </param>
               <param nom="SN_codSector"     Tipo="NUMBER"> codigo sector </param>
               <param nom="SN_codSupervisor" Tipo="NUMBER"> codigo supervisor </param>
               <param nom="SN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
               <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_categoria, '
            || '        a.cod_sector, '
            || '        a.cod_supervisor, '
            || '        b.cod_vendedor '
            || 'FROM ge_clientes a,ve_vendcliente b '
            || 'WHERE a.num_ident = ' || EV_numIdent
            || '  AND a.num_ident = ' || EV_numIdent
            || '  AND a.cod_categoria IS NOT NULL '
            || '  AND a.cod_cliente = b.cod_cliente(+)';

        SELECT a.cod_categoria,
               a.cod_sector,
               a.cod_supervisor,
               b.cod_vendedor
        INTO SN_codCategoria,
             SN_codSector,
             SN_codSupervisor,
             SN_codVendedor
        FROM ge_clientes a,ve_vendcliente b
        WHERE a.cod_tipident = EV_codTipIdent
          AND a.num_ident = EV_numIdent
          AND a.cod_categoria IS NOT NULL
          AND a.cod_cliente = b.cod_cliente(+);

    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'NO_DATA_FOUND:VE_alta_cliente_PG.VE_getClienteVendedor_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getClienteVendedor_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getClienteVendedor_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getClienteVendedor_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getClienteVendedor_PR;

    PROCEDURE VE_getCodigoNuevaEmpresa_PR(SN_codempresa OUT ga_empresa.cod_empresa%TYPE,
                                           SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento  OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getCodigoNuevaEmpresa_PR"
            Lenguaje="PL/SQL"
            Fecha="17-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna codigo nueva empresa
        </Retorno>
        <Descripción>
                  Retorna codigo nueva empresa
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SN_codempresa" Tipo="NUMBER"> codigo nueva empresa </param>
               <param nom="SN_codRetorno" Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"  Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT ga_seq_empresa.NEXTVAL into ' || SN_codempresa || ' FROM DUAL';

        SELECT ga_seq_empresa.NEXTVAL INTO SN_codempresa FROM DUAL;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getCodigoNuevaEmpresa_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getCodigoNuevaEmpresa_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getCodigoNuevaEmpresa_PR;

    --------------------------------------------------------------------------------------------
    --* CURSORES - LISTAS
    --------------------------------------------------------------------------------------------

    PROCEDURE VE_getListGedCodigos_PR(EV_modulo       IN VARCHAR2,
                                      EV_tabla        IN VARCHAR2,
                                      EV_columna      IN VARCHAR2,
                                      SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListGedCodigos_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de codigos
        </Descripción>
        <Parámetros>
             <Entrada>
             </Entrada>
               <param nom="EV_modulo"  Tipo="STRING"> modulo </param>
               <param nom="EV_tabla"   Tipo="STRING"> tabla </param>
               <param nom="EV_columna" Tipo="STRING"> columna </param>
             <Salida>
               <param nom="SV_cursorDatos" Tipo="CURSOR"> cursor codigos </param>
               <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_valor,a.des_valor '
            || 'FROM ged_codigos a '
            || 'WHERE a.cod_modulo = ' || EV_modulo
            || 'AND a.nom_tabla = '    || EV_tabla
            || 'AND a.nom_columna = ' || EV_columna;

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ged_codigos a
        WHERE a.cod_modulo = EV_modulo
          AND a.nom_tabla = EV_tabla
          AND a.nom_columna = EV_columna;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_valor,a.des_valor
        FROM ged_codigos a
        WHERE a.cod_modulo = EV_modulo
          AND a.nom_tabla = EV_tabla
          AND a.nom_columna = EV_columna;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListGedCodigos_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListGedCodigos_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListGedCodigos_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListGedCodigos_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListGedCodigos_PR;

    PROCEDURE VE_getListTiposIdentif_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListTiposIdentif_PR"
            Lenguaje="PL/SQL"
            Fecha="17-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de tipos de identificacion
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tipos de identificacion </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_tipident,a.des_tipident,a.ind_pertrib,a.ind_salefact '
            || 'FROM ge_tipident a ORDER BY a.ORDEN_DISPLAY ';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_tipident;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_tipident,a.des_tipident,a.ind_pertrib,a.ind_salefact
        FROM ge_tipident a
        ORDER BY a.ORDEN_DISPLAY;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListTiposIdentif_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListTiposIdentif_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListTiposIdentif_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListTiposIdentif_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListTiposIdentif_PR;

    PROCEDURE VE_getListCategorias_PR(SC_cursorDatos OUT NOCOPY REFCURSOR,
                                      SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListCategorias_PR"
            Lenguaje="PL/SQL"
            Fecha="17-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de categorias
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor categorias </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_SQL:='SELECT a.COD_CATEGORIA as valor, a.DES_CATEGORIA as categoria, 1 AS DEFAUL'
        ||      ' FROM GE_CATEGORIAS a , GE_INDDEFAULT_TD b'
        ||      ' WHERE'
        ||      ' b.NOM_TABLA = GE_CATEGORIAS'
        ||      ' AND A.COD_CATEGORIA  = B.COD_DEFAULT'
        ||      ' UNION'
        ||      ' SELECT a.COD_CATEGORIA as valor, a.DES_CATEGORIA as categoria, 0 AS DEFAUL'
        ||      ' FROM GE_CATEGORIAS a , GE_INDDEFAULT_TD b'
        ||      ' WHERE '
        ||      ' b.NOM_TABLA = GE_CATEGORIAS'
        ||      ' AND A.COD_CATEGORIA <> B.COD_DEFAULT'
        ||      ' ORDER BY Categoria';

        OPEN SC_cursorDatos FOR
        SELECT a.COD_CATEGORIA as valor, a.DES_CATEGORIA as categoria, 1 AS DEFAUL
        FROM GE_CATEGORIAS a , GE_INDDEFAULT_TD b
        WHERE
        b.NOM_TABLA = 'GE_CATEGORIAS'
        AND A.COD_CATEGORIA  = B.COD_DEFAULT
        UNION
        SELECT a.COD_CATEGORIA as valor, a.DES_CATEGORIA as categoria, 0 AS DEFAUL
        FROM GE_CATEGORIAS a , GE_INDDEFAULT_TD b
        WHERE
        b.NOM_TABLA = 'GE_CATEGORIAS'
        AND A.COD_CATEGORIA <> B.COD_DEFAULT
        ORDER BY CATEGORIA;



    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListCategorias_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListCategorias_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCategorias_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCategorias_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCategorias_PR;

    PROCEDURE VE_getListCategImpositivas_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListCategImpositivas_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de categorias impositivas
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor categorias impositivas </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_catimpos,a.des_catimpos '
            || 'FROM ge_catimpositiva a '
            || 'ORDER BY a.des_catimpos';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_catimpositiva;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_catimpos,a.des_catimpos
        FROM ge_catimpositiva a
        ORDER BY a.des_catimpos;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListCategImpositivas_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListCategImpositivas_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCategImpositivas_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCategImpositivas_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCategImpositivas_PR;

    PROCEDURE VE_getListTipComisionistas_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListTipComisionistas_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de tipos de comisionistas
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tipos de comisionistas </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_tipcomis,a.des_tipcomis,a.ind_vta_externa '
            || 'FROM ve_tipcomis a '
            || 'ORDER BY a.des_tipcomis';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ve_tipcomis;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_tipcomis,a.des_tipcomis,ind_vta_externa
        FROM ve_tipcomis a
        ORDER BY a.des_tipcomis;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListTipComisionistas_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListTipComisionistas_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListTipComisionistas_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListTipComisionistas_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListTipComisionistas_PR;

    PROCEDURE VE_getListModalidadPago_PR(EN_indManual    IN ge_sispago.ind_manual%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListModalidadPago_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de modalidad de pago
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_indManual"    Tipo="NUMBER"> indicador tipo de pago </param>
             </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor modalidad de pago </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_sispago,a.des_sispago '
            || 'FROM ge_sispago a '
            || 'WHERE a.ind_manual = ' || EN_indManual
            || 'ORDER BY a.des_sispago';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_sispago a
        WHERE a.ind_manual = EN_indManual;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_sispago,a.des_sispago
        FROM ge_sispago a
        WHERE a.ind_manual = EN_indManual
        ORDER BY a.des_sispago;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListModalidadPago_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListModalidadPago_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListModalidadPago_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListModalidadPago_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListModalidadPago_PR;

    PROCEDURE VE_getListBancosPAC_PR(EN_indPAC       IN ge_bancos.ind_pac%TYPE,
                                     SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                     SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListBancosPAC_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de bancos segun indicador PAC
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_indPAC"    Tipo="NUMBER"> indicador pago automatico de cuenta </param>
             </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor bancos </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_banco,a.des_banco '
            || 'FROM ge_bancos a '
            --|| 'WHERE a.ind_PAC = ' || EN_indPAC
            || 'ORDER BY a.des_banco';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_bancos a;
        --WHERE a.ind_PAC = EN_indPAC;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_banco,a.des_banco
        FROM ge_bancos a
        ORDER BY a.des_banco;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListBancosPAC_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListBancos_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListBancosPAC_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListBancosPAC_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListBancosPAC_PR;

    PROCEDURE VE_getListSucursalesBanco_PR(EV_codBanco     IN ge_sucursales.cod_banco%TYPE,
                                           SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListSucursalesBanco_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de sucursales del banco
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codBanco"    Tipo="STRING"> codigo del banco </param>
             </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_sucursal,a.des_sucursal '
            || 'FROM ge_sucursales a '
            || 'WHERE a.cod_banco = ' || EV_codBanco
            || 'ORDER BY a.des_sucursal';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_sucursales a
        WHERE a.cod_banco = EV_codBanco;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_sucursal,a.des_sucursal
        FROM ge_sucursales a
        WHERE a.cod_banco = EV_codBanco
        ORDER BY a.des_sucursal;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListSucursalesBanco_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListSucursalesBanco_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListSucursalesBanco_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListSucursalesBanco_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListSucursalesBanco_PR;

    PROCEDURE VE_getListTarjetas_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                    SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListTarjetas_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de tarjetas
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tarjetas SCL </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_tiptarjeta,a.des_tiptarjeta '
            || 'FROM ge_tiptarjetas a '
            || 'ORDER BY a.des_tiptarjeta';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_tiptarjetas;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_tiptarjeta,a.des_tiptarjeta
        FROM ge_tiptarjetas a
        ORDER BY a.des_tiptarjeta;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListTarjetas_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListTarjetasSCL_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListTarjetas_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListTarjetas_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListTarjetas_PR;

    PROCEDURE VE_getListOficinasSCL_PR(EV_nom_usuario  IN ge_seg_usuario.NOM_USUARIO%TYPE,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListOficinasSCL_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista de oficinas en SCL
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor oficinas </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
        LN_contOfic  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_oficina,a.des_oficina '
            || 'FROM ge_oficinas a '
            || 'ORDER BY a.des_oficina';

        LN_contador := 0;

        SELECT COUNT(0)
        INTO   LN_contOfic
        FROM   ge_seg_usuario
        WHERE  nom_usuario = EV_nom_usuario
        AND    cod_oficina IS NOT NULL;

        IF LN_contOfic = 0 THEN
            --Usuario no tiene oficina Asociada

            SELECT COUNT(1)
            INTO LN_contador
            FROM ge_oficinas;

            OPEN SC_cursorDatos FOR
            SELECT a.cod_oficina,a.des_oficina
            FROM ge_oficinas a
            ORDER BY a.des_oficina;

            IF (LN_contador = 0) THEN
                RAISE NO_DATA_FOUND_CURSOR;
            END IF;

        ELSE

            SELECT COUNT(1)
            INTO LN_contador
            FROM   ge_oficinas a, ge_seg_usuario b
            WHERE  a.cod_oficina = b.cod_oficina
            AND    b.nom_usuario = trim(EV_nom_usuario)
            ORDER BY a.des_oficina;

            OPEN SC_cursorDatos FOR
            SELECT a.cod_oficina,a.des_oficina
            FROM   ge_oficinas a, ge_seg_usuario b
            WHERE  a.cod_oficina = b.cod_oficina
            AND    b.nom_usuario = trim(EV_nom_usuario)
            ORDER BY a.des_oficina;

            IF (LN_contador = 0) THEN
                RAISE NO_DATA_FOUND_CURSOR;
            END IF;

        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListOficinasSCL_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListOficinasSCL_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListOficinasSCL_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListOficinasSCL_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListOficinasSCL_PR;

    PROCEDURE VE_getListPlanComCalCte_PR(EV_codCalifCte  IN ve_plan_calcli.cod_calclien%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListPlanComCalCte_PR"
            Lenguaje="PL/SQL"
            Fecha="05-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna lista planes comerciales por calidad del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EV_codCalifCte"  Tipo="STRING"> codigo calificacion cliente </param>
             </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor planes comerciales </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT b.cod_plancom,b.des_plancom '
            || 'FROM ve_plan_calcli a, ve_cabplancom b '
            || 'WHERE a.cod_calclien = ' || EV_codCalifCte
            || ' AND a.cod_plancom = b.cod_plancom '
            || ' AND SYSDATE BETWEEN a.fec_asignacion AND NVL(a.fec_desasignac,SYSDATE) '
            || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE)';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ve_plan_calcli a, ve_cabplancom b
        WHERE a.cod_calclien = EV_codCalifCte
        AND a.cod_plancom = b.cod_plancom
        AND SYSDATE BETWEEN a.fec_asignacion AND NVL(a.fec_desasignac,SYSDATE)
        AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE);

        OPEN SC_cursorDatos FOR
        SELECT b.cod_plancom,b.des_plancom
        FROM ve_plan_calcli a, ve_cabplancom b
        WHERE a.cod_calclien = EV_codCalifCte
        AND a.cod_plancom = b.cod_plancom
        AND SYSDATE BETWEEN a.fec_asignacion AND NVL(a.fec_desasignac,SYSDATE)
        AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta,SYSDATE);

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListPlanComCalCte_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListPlanComCalCte_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListPlanComCalCte_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListPlanComCalCte_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListPlanComCalCte_PR;

    PROCEDURE VE_getListSubCategImpos_PR(EV_codCategImp  IN  al_tipo_codigo.tip_codigo%TYPE,
                                         SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                          SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListSubCategImpos_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Retorna codigo y descripcion subcategoria impositiva
        </Retorno>
        <Descripción>
                  Retorna codigo y descripcion subcategoria impositiva
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EV_codCategImp" Tipo="STRING"> codigo categoria impositiva </param>
             </Entrada>
             <Salida>
               <param nom="SV_codSubCateg"  Tipo="STRING"> codigo subcategoria impositiva </param>
               <param nom="SV_desSubCateg"  Tipo="STRING"> descripcion subcategoria impositiva </param>
               <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LN_contador  NUMBER;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT b.cod_valor,b.des_valor '
            || 'FROM al_tipo_codigo a, ged_codigos b'
            || 'WHERE b.cod_modulo = ' || CV_MODULO_GA
            || '  AND b.nom_tabla = a.nom_tabla '
            || '  AND b.nom_columna = a.campo_codigo '
            || '  AND LENGTH(b.cod_valor) <= 3 '
            || '  AND a.tip_codigo = ' || CV_SUBCATIMPOS || EV_codCategImp;

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM al_tipo_codigo a, ged_codigos b
        WHERE b.cod_modulo = CV_MODULO_GA
          AND b.nom_tabla = a.nom_tabla
          AND b.nom_columna = a.campo_codigo
          AND LENGTH(b.cod_valor) <= 3
          AND a.tip_codigo = CV_SUBCATIMPOS || EV_codCategImp;

        OPEN SC_cursorDatos FOR
        SELECT b.cod_valor,b.des_valor
        FROM al_tipo_codigo a, ged_codigos b
        WHERE b.cod_modulo = CV_MODULO_GA
          AND b.nom_tabla = a.nom_tabla
          AND b.nom_columna = a.campo_codigo
          AND LENGTH(b.cod_valor) <= 3
          AND a.tip_codigo = CV_SUBCATIMPOS || EV_codCategImp;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListSubCategImpos_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListSubCategImpos_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListSubCategImpos_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListSubCategImpos_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListSubCategImpos_PR;

    PROCEDURE VE_getListActividades_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListActividades_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna listado de actividades
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor actividades </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_actividad,a.des_actividad '
            || 'FROM ge_actividades a ORDER BY a.des_actividad';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_actividades;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_actividad,a.des_actividad
        FROM ge_actividades a
        ORDER BY a.des_actividad; --MODIFICACION GT.15.06.10

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListActividades_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListActividades_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListActividades_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListActividades_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListActividades_PR;

    PROCEDURE VE_getListPaises_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getListPaises_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno>
                  Cursor
        </Retorno>
        <Descripción>
                  Retorna listado de paises
        </Descripción>
        <Parámetros>
             <Entrada> N/A </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor paises </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_pais, a.des_pais '
            || 'FROM ge_paises a ORDER BY a.des_pais';

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_paises;

        OPEN SC_cursorDatos FOR
        SELECT a.cod_pais,a.des_pais
        FROM ge_paises a ORDER BY a.des_pais;

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListPaises_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListPaises_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListPaises_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListPaises_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListPaises_PR;

    PROCEDURE VE_esCicloFreedom_PR(EV_codCiclo     IN  VARCHAR2,
                                      SB_resultado    OUT NOCOPY BOOLEAN,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "VE_esCicloFreedom_PR"
    Lenguaje="PL/SQL"
    Fecha="19-06-2007"
    Versión="1.0.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD">
    <Retorno>
              BOOLEAN (True : ciclo es freedom)
    </Retorno>
    <Descripción>
                  Verifica si el ciclo es de un plan freedom
    </Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_codCiclo"   Tipo="STRING"> codigo ciclo </param>
        </Entrada>
        <Salida>
            <param nom="SB_resultado"     Tipo="BOOLEAN"> resultado boolean </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
        LV_resultado  VARCHAR2(1);
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        SB_resultado := FALSE;
        LV_resultado:= '0';

        LV_Sql:= 'SELECT 1'
            || ' FROM ta_planciclo_freedom a'
            || ' WHERE a.cod_ciclo  = ' || EV_codCiclo;

        SELECT '1'
        INTO   LV_resultado
        FROM   ta_planciclo_freedom a
        WHERE  a.cod_ciclo = EV_codCiclo;

        SB_resultado := TRUE;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
               SN_cod_retorno:=1;
              SB_resultado := FALSE;
         WHEN OTHERS THEN
               SN_cod_retorno:=156;
              SB_resultado := FALSE;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERRORNOCLASIF;
              END IF;
              LV_des_error:='OTHERS:VE_alta_cliente_PG.VE_esCicloFreedom_PR(' || EV_codCiclo || ');- ' || SQLERRM;
              SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
              'VE_alta_cliente_PG.VE_esCicloFreedom_PR(' || EV_codCiclo || ')', LV_Sql, SQLCODE, LV_des_error );
              SB_resultado := FALSE;
    END VE_esCicloFreedom_PR;

    PROCEDURE VE_esCicloFreedom_PR(EV_codCiclo     IN  VARCHAR2,
                                     SN_resultado    OUT NOCOPY PLS_INTEGER,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "VE_esCicloFreedom_PR"
    Lenguaje="PL/SQL"
    Fecha="19-06-2007"
    Versión="1.0.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD">
    <Retorno>
              Valor entero equivatente al booleano
    </Retorno>
    <Descripción>
                  Realiza transformacion de valor booleano a entero
    </Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_codCiclo"   Tipo="STRING"> codigo ciclo </param>
        </Entrada>
        <Salida>
            <param nom="SB_resultado"     Tipo="BOOLEAN"> resultado boolean </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
        LB_aux BOOLEAN;
    BEGIN
            VE_esCicloFreedom_PR(EV_codCiclo,LB_aux,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            SN_resultado := Ve_Validacion_Linea_Pg.VE_convertir_FN(LB_aux);
    END VE_esCicloFreedom_PR;

    --------------------------------------------------------------------------------------------
    --* INSERTS y UPDATES
    --------------------------------------------------------------------------------------------

    PROCEDURE VE_insSecDespachoCliente_PR(EN_codcliente     IN ga_secdespclie.cod_cliente%TYPE,
                                          EV_usuario        IN VARCHAR2,
                                           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insSecDespachoCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="06-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta secuencia de despacho para el cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente </param>
               <param nom="EV_coddespacho" Tipo="STRING"> codigo solicitud despacho </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        ERROR_SQL EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;

        LV_codigoDespacho VARCHAR2(10);
        LV_fechaMaxima    VARCHAR2(20);
        LD_fecha          DATE;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --  OBTENEMOS EL VALOR PARA FORMATO FECHA MAXIMA
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FECHAMAXIMA,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_fechaMaxima,
                                                            SN_codRetorno,
                                                            SV_menRetorno,
                                                            SN_numEvento);
        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;

        VE_getFecha_PR(LV_fechaMaxima,
                       CV_NOMPAR_FORMATOSEL2,
                       CV_NOMPAR_FORMATOSEL7,
                       LD_fecha,
                       SN_codRetorno,
                       SV_menRetorno,
                       SN_numEvento);

        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;

        FA_Servicios_Facturacion_PG.FA_getCodigoDespacho_PR(LV_codigoDespacho,
                                                            SN_codRetorno,
                                                               SV_menRetorno,
                                                               SN_numEvento);
        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;

        LV_Sql:='INSERT INTO ga_secdespclie(cod_cliente, '
             || 'cod_despacho, '
             || 'fec_desde, '
             || 'fec_hasta, '
             || 'nom_usuario, '
             || 'fec_ultmod) '
             || 'VALUES ('||EN_codcliente||', '
             || LV_codigoDespacho||','
             || 'SYSDATE, '
             || LD_fecha ||','
             || EV_usuario ||','
             || 'SYSDATE)';

        INSERT INTO ga_secdespclie(cod_cliente,
                                   cod_despacho,
                                   fec_desde,
                                   fec_hasta,
                                   nom_usuario,
                                   fec_ultmod)
        VALUES (EN_codcliente,
                LV_codigoDespacho,
                SYSDATE,
                LD_fecha,
                EV_usuario,
                SYSDATE);

    EXCEPTION
            WHEN ERROR_SQL THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insSecDespachoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insSecDespachoCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insSecDespachoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insSecDespachoCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insSecDespachoCliente_PR;

    PROCEDURE VE_insCategoriaTributaria_PR(EN_codcliente   IN  ga_catributclie.cod_cliente%TYPE,
                                              EV_codcattrib   IN  ga_catributclie.cod_catribut%TYPE,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insCategoriaTributaria_PR"
            Lenguaje="PL/SQL"
            Fecha="06-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta categoria tributaria para el cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente </param>
               <param nom="EV_codcattrib"  Tipo="STRING"> codigo categoria tributaria </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        ERROR_SQL EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;

        LV_fechaMaxima VARCHAR2(20);
        LD_fecha       DATE;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --  OBTENEMOS EL VALOR PARA FORMATO FECHA MAXIMA
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FECHAMAXIMA,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_fechaMaxima,
                                                            SN_codRetorno,
                                                            SV_menRetorno,
                                                            SN_numEvento);

        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;

        --  OBTENEMOS FECHA MAXIMA
        VE_getFecha_PR(LV_fechaMaxima,
                       CV_NOMPAR_FORMATOSEL2,
                       CV_NOMPAR_FORMATOSEL7,
                        LD_fecha,
                       SN_codRetorno,
                       SV_menRetorno,
                       SN_numEvento);

        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;

        LV_Sql:='INSERT INTO ga_catributclie(cod_cliente, '
             || 'fec_desde, '
             || 'fec_hasta, '
             || 'cod_catribut) '
             || 'VALUES ('||EN_codcliente||', '
             || 'SYSDATE, '
             || LD_fecha||','
             || EV_codcattrib||')';

        INSERT INTO ga_catributclie(cod_cliente,
                                    fec_desde,
                                    fec_hasta,
                                    cod_catribut)
        VALUES (EN_codcliente,
                SYSDATE,
                LD_fecha,
                EV_codcattrib);

    EXCEPTION
            WHEN ERROR_SQL THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCategoriaTributaria_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCategoriaTributaria_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCategoriaTributaria_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCategoriaTributaria_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insCategoriaTributaria_PR;

    PROCEDURE VE_insEmpresa_PR(EV_desempresa   IN  ga_empresa.des_empresa%TYPE,
                                 EN_codproducto  IN  ga_empresa.cod_producto%TYPE,
                                 EV_codplantarif IN  ga_empresa.cod_plantarif%TYPE,
                               EN_codciclo     IN  ga_empresa.cod_ciclo%TYPE,
                                 EN_codcliente   IN  ga_empresa.cod_cliente%TYPE,
                               EN_numabonados  IN  ga_empresa.num_abonados%TYPE,
                               EV_usuario      IN  VARCHAR2,
                               EV_razon_social IN  GA_EMPRESA.RAZON_SOCIAL%TYPE,
                               EV_num_patente  IN  GA_EMPRESA.NUM_PATENTE%TYPE,
                               SN_codempresa   OUT NOCOPY ga_empresa.COD_EMPRESA%TYPE,
                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insEmpresa_PR"
            Lenguaje="PL/SQL"
            Fecha="06-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta empresa asociada al cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
               <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
               <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
               <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
               <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
               <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
               <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        ERROR_SQL EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LN_codempresa NUMBER;
        LV_Tiplan     ta_plantarif.cod_tiplan%TYPE;
        LV_TipPlantarif ta_plantarif.TIP_PLANTARIF%TYPE;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

--        LV_sql:='SELECT COD_TIPLAN, TIP_PLANTARIF'
--        ||' FROM TA_PLANTARIF '
--        ||' WHERE COD_PLANTARIF= '|| EV_codplantarif;
--
--
--        SELECT COD_TIPLAN,TIP_PLANTARIF
--        INTO LV_Tiplan,LV_TipPlantarif
--        FROM TA_PLANTARIF
--        WHERE COD_PLANTARIF=EV_codplantarif;
--
--
--        IF LV_TipPlantarif<>'E' THEN
--           RAISE ERROR_SQL;
--        END IF;
--
--        IF LV_Tiplan=1 THEN
--           RAISE ERROR_SQL;
--        END IF;

        -- OBTIENE CODIGO EMPRESA
        LV_sql:='VE_alta_cliente_PG.VE_getCodigoNuevaEmpresa_PR()';
        Ve_Alta_Cliente_Pg.VE_getCodigoNuevaEmpresa_PR(LN_codempresa,
                                                         SN_codRetorno,
                                                         SV_menRetorno,
                                                         SN_numEvento);

        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;


        SN_codempresa := LN_codempresa;

        LV_Sql:='INSERT INTO ga_empresa(cod_empresa, '
             || 'des_empresa, '
             || 'cod_producto, '
             || 'cod_plantari, '
             || 'fec_alta, '
             || 'nom_usuarora, '
             || 'cod_ciclo, '
             || 'cod_cliente, '
             || 'num_abonados, '
             || 'razon_social, '
             || 'num_patente) '
             || 'VALUES (' || LN_codempresa || ', '
             || EV_desempresa || ','
             || EN_codproducto || ','
             || EV_codplantarif || ','
             || 'SYSDATE' || ','
             || EV_usuario || ','
             || EN_codciclo || ','
             || EN_codcliente || ','
             || EN_numabonados
             || EV_razon_social || ','
             || EV_num_patente
             || ')';

        INSERT INTO ga_empresa(cod_empresa,
                               des_empresa,
                               cod_producto,
                               cod_plantarif,
                               fec_alta,
                               nom_usuarora,
                               cod_ciclo,
                               cod_cliente,
                               num_abonados,
                               razon_social,
                               num_patente)
        VALUES (LN_codempresa,
                EV_desempresa,
                EN_codproducto,
                EV_codplantarif,
                SYSDATE,
                EV_usuario,
                EN_codciclo,
                EN_codcliente,
                EN_numabonados,
                EV_razon_social,
                EV_num_patente);

    EXCEPTION
            WHEN ERROR_SQL THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insEmpresa_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insEmpresa_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insEmpresa_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insEmpresa_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insEmpresa_PR;


    PROCEDURE VE_insCliente_PR(EV_cod_cliente        IN VARCHAR2,
                               EV_nom_cliente          IN VARCHAR2,
                               EV_cod_tipident          IN VARCHAR2,
                               EV_num_ident          IN VARCHAR2,
                               EV_cod_calclien          IN VARCHAR2,
                               EV_ind_situacion      IN VARCHAR2,
                               EV_ind_factur          IN VARCHAR2,
                               EV_ind_traspaso          IN VARCHAR2,
                               EV_ind_agente          IN VARCHAR2,
                               EV_num_fax              IN VARCHAR2,
                               EV_ind_mandato          IN VARCHAR2,
                               EV_nom_usuarora          IN VARCHAR2,
                               EV_ind_alta              IN VARCHAR2,
                               EV_cod_cuenta          IN VARCHAR2,
                               EV_ind_acepvent          IN VARCHAR2,
                               EV_cod_abc              IN VARCHAR2,
                               EV_cod_123              IN VARCHAR2,
                               EV_cod_actividad      IN VARCHAR2,
                               EV_cod_pais              IN VARCHAR2,
                               EV_tef_cliente1          IN VARCHAR2,
                               EV_num_abocel          IN VARCHAR2,
                               EV_tef_cliente2          IN VARCHAR2,
                               EV_num_abobeep          IN VARCHAR2,
                               EV_ind_debito          IN VARCHAR2,
                               EV_num_abotrunk          IN VARCHAR2,
                               EV_cod_prospecto      IN VARCHAR2,
                               EV_num_abotrek          IN VARCHAR2,
                               EV_cod_sispago          IN VARCHAR2,
                               EV_nom_apeclien1      IN VARCHAR2,
                               EV_nom_email          IN VARCHAR2,
                               EV_num_aborent          IN VARCHAR2,
                               EV_nom_apeclien2      IN VARCHAR2,
                               EV_num_aboroaming      IN VARCHAR2,
                               EV_fec_acepvent          IN VARCHAR2,
                               EV_imp_stopdebit      IN VARCHAR2,
                               EV_cod_banco          IN VARCHAR2,
                               EV_cod_sucursal          IN VARCHAR2,
                               EV_ind_tipcuenta      IN VARCHAR2,
                               EV_cod_tiptarjeta      IN VARCHAR2,
                               EV_num_ctacorr          IN VARCHAR2,
                               EV_num_tarjeta          IN VARCHAR2,
                               EV_fec_vencitarj      IN VARCHAR2,
                               EV_cod_bancotarj      IN VARCHAR2,
                               EV_cod_tipidtrib      IN VARCHAR2,
                               EV_num_identtrib      IN VARCHAR2,
                               EV_cod_tipidentapor      IN VARCHAR2,
                               EV_num_identapor         IN VARCHAR2,
                               EV_nom_apoderado        IN VARCHAR2,
                               EV_cod_oficina           IN VARCHAR2,
                               EV_fec_baja              IN VARCHAR2,
                               EV_cod_cobrador          IN VARCHAR2,
                               EV_cod_pincli            IN VARCHAR2,
                               EV_cod_ciclo             IN VARCHAR2,
                               EV_num_celular           IN VARCHAR2,
                               EV_ind_tippersona        IN VARCHAR2,
                               EV_cod_ciclonue          IN VARCHAR2,
                               EV_cod_categoria         IN VARCHAR2,
                               EV_cod_sector            IN VARCHAR2,
                               EV_cod_supervisor        IN VARCHAR2,
                               EV_ind_estcivil          IN VARCHAR2,
                               EV_fec_nacimien          IN VARCHAR2,
                               EV_ind_sexo              IN VARCHAR2,
                               EV_num_int_grup_fam      IN VARCHAR2,
                               EV_cod_npi               IN VARCHAR2,
                               EV_cod_subcategoria      IN VARCHAR2,
                               EV_cod_uso               IN VARCHAR2,
                               EV_cod_idioma             IN VARCHAR2,
                               EV_cod_tipident2         IN VARCHAR2,
                               EV_num_ident2          IN VARCHAR2,
                               EV_nom_usuario_asesor IN VARCHAR2,
                               EV_cod_operadora      IN VARCHAR2,
                               EV_id_segmento          IN VARCHAR2,
                               EV_nom_conyuge        IN GE_CLIENTES.NOM_CONYUGE%TYPE,
                               EV_cod_operador       IN GE_CLIENTES.COD_OPERADOR%TYPE,
                               EV_mens_promo         IN GE_CLIENTES.MENS_PROMO%TYPE,
                               EN_cod_profesion      IN GE_CLIENTES.COD_ACTIVIDAD%TYPE,
                               EV_nom_empresa        IN GE_CLIENTES.NOM_EMPRESA%TYPE,
                               EV_tef_oficina        IN GE_CLIENTES.TEF_OFICINA%TYPE,
                               EN_cod_ocupacion      IN GE_CLIENTES.COD_OCUPACION%TYPE,
                               EN_imp_ingresos       IN GE_CLIENTES.IMP_INGRESOS%TYPE,
                               EV_nom_jefe           IN GE_CLIENTES.NOM_JEFE%TYPE,
                               EV_cant_antlabor      IN GE_CLIENTES.CANT_ANLABOR%TYPE,
                               EV_nom_refer1         IN GE_CLIENTES.NOM_REFER1%TYPE,
                               EV_tef_refer1         IN GE_CLIENTES.TEF_REFER1%TYPE,
                               EV_nom_refer2         IN GE_CLIENTES.NOM_REFER2%TYPE,
                               EV_tef_refer2         IN GE_CLIENTES.TEF_REFER2%TYPE,
                               EV_tip_cliente        IN GE_CLIENTES.COD_TIPO%TYPE,
                               EV_cod_color          IN GE_CLIENTES.COD_COLOR%TYPE,
                               EV_cod_crediticia     IN GE_CLIENTES.COD_CREDITICIA%TYPE,
                               EV_cod_segmento       IN GE_CLIENTES.COD_SEGMENTO%TYPE,
                               EV_cod_calificacion   IN GE_CLIENTES.COD_CALIFICACION%TYPE,
                               EV_nom_tit_tarjeta    IN GE_CLIENTES.NOM_TITULARTARJETA%TYPE,
                               EV_obs_pac            IN GE_CLIENTES.OBS_PAC%TYPE,
                               EN_FACTURA_ELECTR     IN GE_CLIENTES.IND_FACTURAELECTRONICA%TYPE,
                               SN_codRetorno            OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno            OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento             OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta nuevo cliente
        </Descripción>
        <Parámetros>
             <Entrada>
                <param nom="EV_cod_cliente"          Tipo="STRING"> codigo cliente </param>
                <param nom="EV_nom_cliente"            Tipo="STRING"> </param>
                <param nom="EV_cod_tipident"            Tipo="STRING"> </param>
                <param nom="EV_num_ident"            Tipo="STRING"> </param>
                <param nom="EV_cod_calclien"            Tipo="STRING"> </param>
                <param nom="EV_ind_situacion"        Tipo="STRING"> </param>
                <param nom="EV_ind_factur"            Tipo="STRING"> </param>
                <param nom="EV_ind_traspaso"            Tipo="STRING"> </param>
                <param nom="EV_ind_agente"            Tipo="STRING"> </param>
                <param nom="EV_num_fax"                Tipo="STRING"> </param>
                <param nom="EV_ind_mandato"            Tipo="STRING"> </param>
                <param nom="EV_nom_usuarora"            Tipo="STRING"> </param>
                <param nom="EV_ind_alta"                Tipo="STRING"> </param>
                <param nom="EV_cod_cuenta"            Tipo="STRING"> </param>
                <param nom="EV_ind_acepvent"            Tipo="STRING"> </param>
                <param nom="EV_cod_abc"                Tipo="STRING"> </param>
                <param nom="EV_cod_123"                Tipo="STRING"> </param>
                <param nom="EV_cod_actividad"        Tipo="STRING"> </param>
                <param nom="EV_cod_pais"                Tipo="STRING"> </param>
                <param nom="EV_tef_cliente1"           Tipo="STRING"> </param>
                <param nom="EV_num_abocel"            Tipo="STRING"> </param>
                <param nom="EV_tef_cliente2"            Tipo="STRING"> </param>
                <param nom="EV_num_abobeep"            Tipo="STRING"> </param>
                <param nom="EV_ind_debito"            Tipo="STRING"> </param>
                <param nom="EV_num_abotrunk"            Tipo="STRING"> </param>
                <param nom="EV_cod_prospecto"           Tipo="STRING"> </param>
                <param nom="EV_num_abotrek"            Tipo="STRING"> </param>
                <param nom="EV_cod_sispago"            Tipo="STRING"> </param>
                <param nom="EV_nom_apeclien1"           Tipo="STRING"> </param>
                <param nom="EV_nom_email"            Tipo="STRING"> </param>
                <param nom="EV_num_aborent"            Tipo="STRING"> </param>
                <param nom="EV_nom_apeclien2"        Tipo="STRING"> </param>
                <param nom="EV_num_aboroaming"        Tipo="STRING"> </param>
                <param nom="EV_fec_acepvent"            Tipo="STRING"> </param>
                <param nom="EV_imp_stopdebit"        Tipo="STRING"> </param>
                <param nom="EV_cod_banco"            Tipo="STRING"> </param>
                <param nom="EV_cod_sucursal"            Tipo="STRING"> </param>
                <param nom="EV_ind_tipcuenta"        Tipo="STRING"> </param>
                <param nom="EV_cod_tiptarjeta"        Tipo="STRING"> </param>
                <param nom="EV_num_ctacorr"            Tipo="STRING"> </param>
                <param nom="EV_num_tarjeta"            Tipo="STRING"> </param>
                <param nom="EV_fec_vencitarj"        Tipo="STRING"> </param>
                <param nom="EV_cod_bancotarj"        Tipo="STRING"> </param>
                <param nom="EV_cod_tipidtrib"        Tipo="STRING"> </param>
                <param nom="EV_num_identtrib"        Tipo="STRING"> </param>
                <param nom="EV_cod_tipidentapor"        Tipo="STRING"> </param>
                <param nom="EV_num_identapor"        Tipo="STRING"> </param>
                <param nom="EV_nom_apoderado"        Tipo="STRING"> </param>
                <param nom="EV_cod_oficina"            Tipo="STRING"> </param>
                <param nom="EV_fec_baja"                Tipo="STRING"> </param>
                <param nom="EV_cod_cobrador"            Tipo="STRING"> </param>
                <param nom="EV_cod_pincli"            Tipo="STRING"> </param>
                <param nom="EV_cod_ciclo"            Tipo="STRING"> </param>
                <param nom="EV_num_celular"            Tipo="STRING"> </param>
                <param nom="EV_ind_tippersona"        Tipo="STRING"> </param>
                <param nom="EV_cod_ciclonue"            Tipo="STRING"> </param>
                <param nom="EV_cod_categoria"        Tipo="STRING"> </param>
                <param nom="EV_cod_sector"            Tipo="STRING"> </param>
                <param nom="EV_cod_supervisor"        Tipo="STRING"> </param>
                <param nom="EV_ind_estcivil"            Tipo="STRING"> </param>
                <param nom="EV_fec_nacimien"            Tipo="STRING"> </param>
                <param nom="EV_ind_sexo"                   Tipo="STRING"> </param>
                <param nom="EV_num_int_grup_fam"        Tipo="STRING"> </param>
                <param nom="EV_cod_npi"                Tipo="STRING"> </param>
                <param nom="EV_cod_subcategoria"        Tipo="STRING"> </param>
                <param nom="EV_cod_uso"                Tipo="STRING"> </param>
                <param nom="EV_cod_idioma"            Tipo="STRING"> </param>
                <param nom="EV_cod_tipident2"        Tipo="STRING"> </param>
                <param nom="EV_num_ident2"            Tipo="STRING"> </param>
                <param nom="EV_nom_usuario_asesor"   Tipo="STRING"> </param>
                <param nom="EV_cod_operadora"        Tipo="STRING"> </param>
                <param nom="EV_id_segmento"            Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_codciclo_ami ged_parametros.val_parametro%TYPE;
        LV_indalta_ami ged_parametros.val_parametro%TYPE;
        LE_FINAL_CICLO EXCEPTION;
        LE_FINAL_ALTA EXCEPTION;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;
        LV_codciclo_ami:= NULL;
        LV_indalta_ami:= NULL;


        --inc. 87304 24-04-2009
        ve_intermediario_pg.ve_obtiene_valor_parametro_pr('COD_AMI_CICLO', 'GA', 1, LV_codciclo_ami,
                                                           SN_codRetorno, SV_menRetorno, SN_numEvento);
        if SN_codRetorno<>0 then
           raise LE_FINAL_CICLO;
        end if;

        if trim(LV_codciclo_ami)=trim(EV_cod_ciclo) then
           ve_intermediario_pg.ve_obtiene_valor_parametro_pr('IND_ALTA', 'GA', 1, LV_indalta_ami,
                                                             SN_codRetorno, SV_menRetorno, SN_numEvento);
           if SN_codRetorno<>0 then
              raise LE_FINAL_ALTA;
           end if;
        end if;
        --fin inc. 87304 24-04-2009


        if SN_codRetorno=0 then

            LV_Sql:='INSERT INTO ge_clientes ('
                    || ' cod_cliente '
                    || ',nom_cliente '
                    || ',cod_tipident '
                    || ',num_ident '
                    || ',cod_calclien '
                    || ',ind_situacion '
                    || ',fec_alta '
                    || ',ind_factur '
                    || ',ind_traspaso '
                    || ',ind_agente '
                    || ',fec_ultmod '
                    || ',num_fax '
                    || ',ind_mandato '
                    || ',nom_usuarora '
                    || ',ind_alta '
                    || ',cod_cuenta '
                    || ',ind_acepvent '
                    || ',cod_abc '
                    || ',cod_123 '
                    || ',cod_actividad '
                    || ',cod_pais '
                    || ',tef_cliente1 '
                    || ',num_abocel '
                    || ',tef_cliente2 '
                    || ',num_abobeep '
                    || ',ind_debito '
                    || ',num_abotrunk '
                    || ',cod_prospecto '
                    || ',num_abotrek '
                    || ',cod_sispago '
                    || ',nom_apeclien1 '
                    || ',nom_email '
                    || ',num_aborent '
                    || ',nom_apeclien2 '
                    || ',num_aboroaming '
                    || ',fec_acepvent '
                    || ',imp_stopdebit '
                    || ',cod_banco '
                    || ',cod_sucursal '
                    || ',ind_tipcuenta '
                    || ',cod_tiptarjeta '
                    || ',num_ctacorr '
                    || ',num_tarjeta '
                    || ',fec_vencitarj '
                    || ',cod_bancotarj '
                    || ',cod_tipidtrib '
                    || ',num_identtrib '
                    || ',cod_tipidentapor '
                    || ',num_identapor '
                    || ',nom_apoderado '
                    || ',cod_oficina '
                    || ',fec_baja '
                    || ',cod_cobrador '
                    || ',cod_pincli '
                    || ',cod_ciclo '
                    || ',num_celular '
                    || ',ind_tippersona '
                    || ',cod_ciclonue '
                    || ',cod_categoria '
                    || ',cod_sector '
                    || ',cod_supervisor '
                    || ',ind_estcivil '
                    || ',fec_nacimien '
                    || ',ind_sexo '
                    || ',num_int_grup_fam '
                    || ',cod_npi '
                    || ',cod_subcategoria '
                    || ',cod_uso '
                    || ',cod_idioma '
                    || ',cod_tipident2 '
                    || ',num_ident2 '
                    || ',nom_usuario_asesor '
                    || ',cod_operadora '
                    || ',nom_conyuge '
                    || ',cod_operador '
                    || ',mens_promo '
                    || ',cod_profesion '
                    || ',nom_empresa '
                    || ',tef_oficina '
                    || ',cod_ocupacion '
                    || ',imp_ingresos '
                    || ',nom_jefe '
                    || ',cant_anlabor '
                    || ',nom_refer1 '
                    || ',tef_refer1 '
                    || ',nom_refer2 '
                    || ',tef_refer2 '
                    || ',cod_tipo '
                    || ',cod_color '
                    || ',cod_crediticia '
                    || ',cod_segmento '
                    || ',cod_calificacion '
                    || ',nom_titulartarjeta '
                    || ',obs_pac, '
                    || 'ind_facturaelectronica'
                    || ')'
                     || 'VALUES ( ';

             IF (EV_cod_cliente IS NOT NULL) AND (LENGTH(EV_cod_cliente) > 0) THEN
                LV_Sql:= LV_Sql || EV_cod_cliente;
            ELSE
                LV_Sql:= LV_Sql || 'NULL';
            END IF;
             IF (EV_nom_cliente IS NOT NULL) AND (LENGTH(EV_nom_cliente) > 0) THEN
                 LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_cliente,1,50) || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_tipident IS NOT NULL) AND (LENGTH(EV_cod_tipident) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tipident || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_ident IS NOT NULL) AND (LENGTH(EV_num_ident) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_ident || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_calclien IS NOT NULL) AND (LENGTH(EV_cod_calclien) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_calclien || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_situacion IS NOT NULL) AND (LENGTH(EV_ind_situacion) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_situacion || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            LV_Sql:= LV_Sql || ',SYSDATE';

             IF (EV_ind_factur IS NOT NULL) AND (LENGTH(EV_ind_factur) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_ind_factur;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_traspaso IS NOT NULL) AND (LENGTH(EV_ind_traspaso) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_traspaso || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_agente IS NOT NULL) AND (LENGTH(EV_ind_agente) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_agente || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            LV_Sql:= LV_Sql || ',SYSDATE';

             IF (EV_num_fax IS NOT NULL) AND (LENGTH(EV_num_fax) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_fax || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_mandato IS NOT NULL) AND (LENGTH(EV_ind_mandato) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_ind_mandato;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_usuarora IS NOT NULL) AND (LENGTH(EV_nom_usuarora) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_usuarora || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_alta IS NOT NULL) AND (LENGTH(EV_ind_alta) > 0) THEN
               if trim(LV_codciclo_ami)=trim(EV_cod_ciclo) then
                     LV_Sql:= LV_Sql || ',''' || LV_indalta_ami || '''';
               else
                     LV_Sql:= LV_Sql || ',''' || EV_ind_alta || '''';
               end if;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_cuenta IS NOT NULL) AND (LENGTH(EV_cod_cuenta) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_cuenta;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_acepvent IS NOT NULL) AND (LENGTH(EV_ind_acepvent) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_acepvent || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_abc IS NOT NULL) AND (LENGTH(EV_cod_abc) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_abc || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_123 IS NOT NULL) AND (LENGTH(EV_cod_123) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_123;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_actividad IS NOT NULL) AND (LENGTH(EV_cod_actividad) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_actividad;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_pais IS NOT NULL) AND (LENGTH(EV_cod_pais) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_pais || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_tef_cliente1 IS NOT NULL) AND (LENGTH(EV_tef_cliente1) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tef_cliente1 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_abocel IS NOT NULL) AND (LENGTH(EV_num_abocel) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_abocel;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_tef_cliente2 IS NOT NULL) AND (LENGTH(EV_tef_cliente2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tef_cliente2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_abobeep IS NOT NULL) AND (LENGTH(EV_num_abobeep) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_abobeep;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_debito IS NOT NULL) AND (LENGTH(EV_ind_debito) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_debito || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_abotrunk IS NOT NULL) AND (LENGTH(EV_num_abotrunk) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_abotrunk;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_prospecto IS NOT NULL) AND (LENGTH(EV_cod_prospecto) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_prospecto;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_abotrek IS NOT NULL) AND (LENGTH(EV_num_abotrek) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_abotrek;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_sispago IS NOT NULL) AND (LENGTH(EV_cod_sispago) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_sispago;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_apeclien1 IS NOT NULL) AND (LENGTH(EV_nom_apeclien1) > 0) THEN
                    LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apeclien1,1,20) || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_email IS NOT NULL) AND (LENGTH(EV_nom_email) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_email || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_aborent IS NOT NULL) AND (LENGTH(EV_num_aborent) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_aborent;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_apeclien2 IS NOT NULL) AND (LENGTH(EV_nom_apeclien2) > 0) THEN
                    LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apeclien2,1,20) || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_aboroaming IS NOT NULL) AND (LENGTH(EV_num_aboroaming) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_aboroaming;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_fec_acepvent IS NOT NULL) AND (LENGTH(EV_fec_acepvent) > 0) THEN
                LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fec_acepvent || ''',''' || CV_FORMATOFECHA || ''')';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_imp_stopdebit IS NOT NULL) AND (LENGTH(EV_imp_stopdebit) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_imp_stopdebit;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_banco IS NOT NULL) AND (LENGTH(EV_cod_banco) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_banco || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_sucursal IS NOT NULL) AND (LENGTH(EV_cod_sucursal) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_sucursal || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_tipcuenta IS NOT NULL) AND (LENGTH(EV_ind_tipcuenta) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_tipcuenta || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_tiptarjeta IS NOT NULL) AND (LENGTH(EV_cod_tiptarjeta) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tiptarjeta || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_ctacorr IS NOT NULL) AND (LENGTH(EV_num_ctacorr) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_ctacorr || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_tarjeta IS NOT NULL) AND (LENGTH(EV_num_tarjeta) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_tarjeta || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_fec_vencitarj IS NOT NULL) AND (LENGTH(EV_fec_vencitarj) > 0) THEN
                LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fec_vencitarj || ''',''' || CV_FORMATOFECHA || ''')';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_bancotarj IS NOT NULL) AND (LENGTH(EV_cod_bancotarj) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_bancotarj || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_tipidtrib IS NOT NULL) AND (LENGTH(EV_cod_tipidtrib) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tipidtrib || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_identtrib IS NOT NULL) AND (LENGTH(EV_num_identtrib) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_identtrib || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_tipidentapor IS NOT NULL) AND (LENGTH(EV_cod_tipidentapor) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tipidentapor || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_identapor IS NOT NULL) AND (LENGTH(EV_num_identapor) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_identapor || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_apoderado IS NOT NULL) AND (LENGTH(EV_nom_apoderado) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apoderado,1,40) || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_oficina IS NOT NULL) AND (LENGTH(EV_cod_oficina) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_oficina || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_fec_baja IS NOT NULL) AND (LENGTH(EV_fec_baja) > 0) THEN
                LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fec_baja || ''',''' || CV_FORMATOFECHA || ''')';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_cobrador IS NOT NULL) AND (LENGTH(EV_cod_cobrador) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_cobrador;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_pincli IS NOT NULL) AND (LENGTH(EV_cod_pincli) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_pincli || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_ciclo IS NOT NULL) AND (LENGTH(EV_cod_ciclo) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_ciclo;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_celular IS NOT NULL) AND (LENGTH(EV_num_celular) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_celular;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_tippersona IS NOT NULL) AND (LENGTH(EV_ind_tippersona) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_tippersona || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_ciclonue IS NOT NULL) AND (LENGTH(EV_cod_ciclonue) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_ciclonue;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_categoria IS NOT NULL) AND (LENGTH(EV_cod_categoria) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_categoria;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_sector IS NOT NULL) AND (LENGTH(EV_cod_sector) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_sector;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
            IF (EV_cod_supervisor IS NOT NULL) AND (LENGTH(EV_cod_supervisor) > 0) AND TRIM(EV_cod_supervisor)<>'0' THEN
                 LV_Sql:= LV_Sql || ',' || EV_cod_supervisor;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_estcivil IS NOT NULL) AND (LENGTH(EV_ind_estcivil) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_estcivil || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_fec_nacimien IS NOT NULL) AND (LENGTH(EV_fec_nacimien) > 0) THEN
                LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fec_nacimien || ''',''' || CV_FORMATOFECHA || ''')';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_ind_sexo IS NOT NULL) AND (LENGTH(EV_ind_sexo) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_ind_sexo || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_int_grup_fam IS NOT NULL) AND (LENGTH(EV_num_int_grup_fam) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_num_int_grup_fam;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_npi IS NOT NULL) AND (LENGTH(EV_cod_npi) > 0) THEN
                LV_Sql:= LV_Sql || ',' || EV_cod_npi;
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_subcategoria IS NOT NULL) AND (LENGTH(EV_cod_subcategoria) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_subcategoria || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_uso IS NOT NULL) AND (LENGTH(EV_cod_uso) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_uso || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_idioma IS NOT NULL) AND (LENGTH(EV_cod_idioma) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_idioma || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_tipident2 IS NOT NULL) AND (LENGTH(EV_cod_tipident2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tipident2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_num_ident2 IS NOT NULL) AND (LENGTH(EV_num_ident2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_ident2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_nom_usuario_asesor IS NOT NULL) AND (LENGTH(EV_nom_usuario_asesor) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_usuario_asesor || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;
             IF (EV_cod_operadora IS NOT NULL) AND (LENGTH(EV_cod_operadora) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_operadora || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_conyuge IS NOT NULL) AND (LENGTH(EV_nom_conyuge) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_conyuge || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_cod_operador IS NOT NULL) AND (LENGTH(EV_cod_operador) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_operador || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_mens_promo IS NOT NULL) AND (LENGTH(EV_mens_promo) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_mens_promo || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EN_cod_profesion IS NOT NULL) AND (LENGTH(EN_cod_profesion) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EN_cod_profesion || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_empresa IS NOT NULL) AND (LENGTH(EV_nom_empresa) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_empresa || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_tef_oficina IS NOT NULL) AND (LENGTH(EV_tef_oficina) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tef_oficina || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EN_cod_ocupacion IS NOT NULL) AND (LENGTH(EN_cod_ocupacion) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EN_cod_ocupacion || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EN_imp_ingresos IS NOT NULL) AND (LENGTH(EN_imp_ingresos) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EN_imp_ingresos || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_jefe IS NOT NULL) AND (LENGTH(EV_nom_jefe) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_jefe || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_cant_antlabor IS NOT NULL) AND (LENGTH(EV_cant_antlabor) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cant_antlabor || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_refer1 IS NOT NULL) AND (LENGTH(EV_nom_refer1) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_refer1 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_tef_refer1 IS NOT NULL) AND (LENGTH(EV_tef_refer1) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tef_refer1 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_refer2 IS NOT NULL) AND (LENGTH(EV_nom_refer2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_refer2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EV_tef_refer2 IS NOT NULL) AND (LENGTH(EV_tef_refer2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tef_refer2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EV_tip_cliente IS NOT NULL) AND (LENGTH(EV_tip_cliente) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_tip_cliente || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_cod_color IS NOT NULL) AND (LENGTH(EV_cod_color) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_color || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EV_cod_crediticia IS NOT NULL) AND (LENGTH(EV_cod_crediticia) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_crediticia || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_cod_segmento IS NOT NULL) AND (LENGTH(EV_cod_segmento) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_segmento || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EV_cod_calificacion IS NOT NULL) AND (LENGTH(EV_cod_calificacion) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_calificacion || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nom_tit_tarjeta IS NOT NULL) AND (LENGTH(EV_nom_tit_tarjeta) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nom_tit_tarjeta || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_obs_pac IS NOT NULL) AND (LENGTH(EV_obs_pac) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_obs_pac || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            IF (EN_FACTURA_ELECTR IS NOT NULL) AND (LENGTH(EN_FACTURA_ELECTR) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EN_FACTURA_ELECTR || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;


            LV_Sql:= LV_Sql || ')';

            EXECUTE IMMEDIATE LV_Sql;
        end if;

    EXCEPTION
             WHEN LE_FINAL_ALTA THEN
                 SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'LE_FINAL_ALTA:VE_alta_cliente_PG.VE_insCliente_PR;- NO es posible obtener ind_alta';
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN LE_FINAL_CICLO THEN
                 SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'LE_FINAL_CICLO:VE_alta_cliente_PG.VE_insCliente_PR;- NO es posible obtener ciclo prepago';
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insCliente_PR;

    -- Ini. MA 72269 3-11-2008
    PROCEDURE VE_insSegmentacion_PR(EV_cod_cliente    IN VARCHAR2,
                    EV_TipPlanDes    IN VARCHAR2,
                    SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                    SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                    SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insSegmentacion_PR"
            Lenguaje="PL/SQL"
            Fecha="03-11-2008"
            Versión="1.0.0"
            Diseñador="rab"
            Programador="rab"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta segmentacion del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
            <param nom="EV_cod_cliente"    Tipo="STRING"> codigo cliente </param>
            <param nom="EV_TipPlanDes"    Tipo="STRING"> tipo de plan destino</param>
             </Entrada>
             <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError     ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_cod_valor     ga_valor_cli.cod_valor%TYPE;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        IF (trim(EV_TipPlanDes) = '1') THEN --El Plan Destino es Prepago
            SELECT VAL_PARAMETRO
              INTO LV_cod_valor
              FROM GED_PARAMETROS
             WHERE NOM_PARAMETRO = 'SEG_DEFAULT_PREPAGO';
        ELSE -- El Plan Destino es Pospago
            SELECT VAL_PARAMETRO
              INTO LV_cod_valor
              FROM GED_PARAMETROS
             WHERE NOM_PARAMETRO = 'SEG_DEFAULT_POSPAGO';
        END IF;

        LV_Sql:='INSERT INTO ga_valor_cli ('
                || ' cod_cliente '
                || ',cod_valor '
                || ')'
                 || 'VALUES ( ';

         IF (EV_cod_cliente IS NOT NULL) AND (LENGTH(EV_cod_cliente) > 0) THEN
            LV_Sql:= LV_Sql || EV_cod_cliente;
        ELSE
            LV_Sql:= LV_Sql || 'NULL';
        END IF;
         IF (LV_cod_valor IS NOT NULL) AND (LENGTH(LV_cod_valor) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || LV_cod_valor || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;

        LV_Sql:= LV_Sql || ')';

        EXECUTE IMMEDIATE LV_Sql;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insSegmentacion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insSegmentacion_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insSegmentacion_PR;
    -- Fin MA 72269 3-11-2008

    PROCEDURE VE_insModCliente_PR(EV_cod_cliente       IN VARCHAR2,
                                  EV_cod_tipmodi        IN VARCHAR2,
                                    EV_fec_modifica        IN VARCHAR2,
                                    EV_nom_usuarora        IN VARCHAR2,
                                    EV_nom_cliente        IN VARCHAR2,
                                    EV_cod_tipident        IN VARCHAR2,
                                    EV_num_ident            IN VARCHAR2,
                                    EV_cod_calclien        IN VARCHAR2,
                                    EV_cod_plancom        IN VARCHAR2,
                                    EV_ind_factur        IN VARCHAR2,
                                    EV_ind_traspaso        IN VARCHAR2,
                                    EV_cod_actividad        IN VARCHAR2,
                                    EV_cod_pais            IN VARCHAR2,
                                    EV_tef_cliente1        IN VARCHAR2,
                                    EV_tef_cliente2        IN VARCHAR2,
                                    EV_num_fax            IN VARCHAR2,
                                    EV_ind_debito        IN VARCHAR2,
                                    EV_cod_sispago        IN VARCHAR2,
                                    EV_nom_apeclien1        IN VARCHAR2,
                                    EV_nom_apeclien2        IN VARCHAR2,
                                    EV_imp_stopdebit        IN VARCHAR2,
                                    EV_cod_banco            IN VARCHAR2,
                                    EV_cod_sucursal        IN VARCHAR2,
                                    EV_ind_tipcuenta        IN VARCHAR2,
                                    EV_cod_tiptarjeta    IN VARCHAR2,
                                    EV_num_ctacorr        IN VARCHAR2,
                                    EV_num_tarjeta        IN VARCHAR2,
                                    EV_fec_vencitarj        IN VARCHAR2,
                                    EV_cod_bancotarj        IN VARCHAR2,
                                    EV_cod_tipidtrib        IN VARCHAR2,
                                    EV_num_identtrib        IN VARCHAR2,
                                    EV_cod_tipidentapor  IN VARCHAR2,
                                    EV_num_identapor        IN VARCHAR2,
                                    EV_nom_apoderado        IN VARCHAR2,
                                    EV_cod_oficina        IN VARCHAR2,
                                    EV_cod_pincli        IN VARCHAR2,
                                    EV_nom_email            IN VARCHAR2,
                                    EV_cod_ciclo            IN VARCHAR2,
                                    EV_cod_categoria        IN VARCHAR2,
                                    EV_cod_sector        IN VARCHAR2,
                                    EV_cod_supervisor    IN VARCHAR2,
                                    EV_cod_npi            IN VARCHAR2,
                                    EV_cod_empresa        IN VARCHAR2,
                                    EV_tip_plantarif        IN VARCHAR2,
                                    EV_cod_plantarif        IN VARCHAR2,
                                    EV_cod_cargobasico   IN VARCHAR2,
                                    EV_num_os            IN VARCHAR2,
                                    EV_num_ciclos        IN VARCHAR2,
                                    EV_num_minutos        IN VARCHAR2,
                                    EV_cod_idioma        IN VARCHAR2,
                                    EV_cod_tipident2        IN VARCHAR2,
                                    EV_num_ident2        IN VARCHAR2,
                                    EV_cod_plaza            IN VARCHAR2,
                                    EV_des_refdoc        IN VARCHAR2,
                                    EV_cod_limconsumo    IN VARCHAR2,
                                    EV_cod_subcategoria  IN VARCHAR2,
                                  SN_codRetorno          OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno          OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_numEvento           OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insModCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="14-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta modificaciones al cliente
        </Descripción>
        <Parámetros>
             <Entrada>
                <param nom="EV_cod_cliente"        Tipo="STRING"> codigo cliente </param>
                <param nom="EV_cod_tipmodi"          Tipo="STRING"> </param>
                <param nom="EV_fec_modifica"          Tipo="STRING"> </param>
                <param nom="EV_nom_usuarora"          Tipo="STRING"> </param>
                <param nom="EV_nom_cliente"          Tipo="STRING"> </param>
                <param nom="EV_cod_tipident"          Tipo="STRING"> </param>
                <param nom="EV_num_ident"          Tipo="STRING"> </param>
                <param nom="EV_cod_calclien"          Tipo="STRING"> </param>
                <param nom="EV_cod_plancom"          Tipo="STRING"> </param>
                <param nom="EV_ind_factur"          Tipo="STRING"> </param>
                <param nom="EV_ind_traspaso"          Tipo="STRING"> </param>
                <param nom="EV_cod_actividad"         Tipo="STRING"> </param>
                <param nom="EV_cod_pais"              Tipo="STRING"> </param>
                <param nom="EV_tef_cliente1"          Tipo="STRING"> </param>
                <param nom="EV_tef_cliente2"          Tipo="STRING"> </param>
                <param nom="EV_num_fax"              Tipo="STRING"> </param>
                <param nom="EV_ind_debito"          Tipo="STRING"> </param>
                <param nom="EV_cod_sispago"          Tipo="STRING"> </param>
                <param nom="EV_nom_apeclien1"      Tipo="STRING"> </param>
                <param nom="EV_nom_apeclien2"      Tipo="STRING"> </param>
                <param nom="EV_imp_stopdebit"      Tipo="STRING"> </param>
                <param nom="EV_cod_banco"          Tipo="STRING"> </param>
                <param nom="EV_cod_sucursal"          Tipo="STRING"> </param>
                <param nom="EV_ind_tipcuenta"      Tipo="STRING"> </param>
                <param nom="EV_cod_tiptarjeta"     Tipo="STRING"> </param>
                <param nom="EV_num_ctacorr"          Tipo="STRING"> </param>
                <param nom="EV_num_tarjeta"          Tipo="STRING"> </param>
                <param nom="EV_fec_vencitarj"      Tipo="STRING"> </param>
                <param nom="EV_cod_bancotarj"      Tipo="STRING"> </param>
                <param nom="EV_cod_tipidtrib"      Tipo="STRING"> </param>
                <param nom="EV_num_identtrib"      Tipo="STRING"> </param>
                <param nom="EV_cod_tipidentapor"   Tipo="STRING"> </param>
                <param nom="EV_num_identapor"      Tipo="STRING"> </param>
                <param nom="EV_nom_apoderado"      Tipo="STRING"> </param>
                <param nom="EV_cod_oficina"          Tipo="STRING"> </param>
                <param nom="EV_cod_pincli"          Tipo="STRING"> </param>
                <param nom="EV_nom_email"          Tipo="STRING"> </param>
                <param nom="EV_cod_ciclo"          Tipo="STRING"> </param>
                <param nom="EV_cod_categoria"      Tipo="STRING"> </param>
                <param nom="EV_cod_sector"          Tipo="STRING"> </param>
                <param nom="EV_cod_supervisor"     Tipo="STRING"> </param>
                <param nom="EV_cod_npi"              Tipo="STRING"> </param>
                <param nom="EV_cod_empresa"          Tipo="STRING"> </param>
                <param nom="EV_tip_plantarif"      Tipo="STRING"> </param>
                <param nom="EV_cod_plantarif"      Tipo="STRING"> </param>
                <param nom="EV_cod_cargobasico"    Tipo="STRING"> </param>
                <param nom="EV_num_os"              Tipo="STRING"> </param>
                <param nom="EV_num_ciclos"          Tipo="STRING"> </param>
                <param nom="EV_num_minutos"          Tipo="STRING"> </param>
                <param nom="EV_cod_idioma"          Tipo="STRING"> </param>
                <param nom="EV_cod_tipident2"      Tipo="STRING"> </param>
                <param nom="EV_num_ident2"          Tipo="STRING"> </param>
                <param nom="EV_cod_plaza"          Tipo="STRING"> </param>
                <param nom="EV_des_refdoc"          Tipo="STRING"> </param>
                <param nom="EV_cod_limconsumo"     Tipo="STRING"> </param>
                <param nom="EV_cod_subcategoria"   Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO ga_modcli(cod_cliente '
                 || ',cod_tipmodi '
                 || ',fec_modifica '
                 || ',nom_usuarora '
                 || ',nom_cliente '
                 || ',cod_tipident '
                 || ',num_ident '
                 || ',cod_calclien '
                 || ',cod_plancom '
                 || ',ind_factur '
                 || ',ind_traspaso '
                 || ',cod_actividad '
                 || ',cod_pais '
                 || ',tef_cliente1 '
                 || ',tef_cliente2 '
                 || ',num_fax '
                 || ',ind_debito '
                 || ',cod_sispago '
                 || ',nom_apeclien1 '
                 || ',nom_apeclien2 '
                 || ',imp_stopdebit '
                 || ',cod_banco '
                 || ',cod_sucursal '
                 || ',ind_tipcuenta '
                 || ',cod_tiptarjeta '
                 || ',num_ctacorr '
                 || ',num_tarjeta '
                 || ',fec_vencitarj '
                 || ',cod_bancotarj '
                 || ',cod_tipidtrib '
                 || ',num_identtrib '
                 || ',cod_tipidentapor '
                 || ',num_identapor '
                 || ',nom_apoderado '
                 || ',cod_oficina '
                 || ',cod_pincli '
                 || ',nom_email '
                 || ',cod_ciclo '
                 || ',cod_categoria '
                 || ',cod_sector '
                 || ',cod_supervisor '
                 || ',cod_npi '
                 || ',cod_empresa '
                 || ',tip_plantarif '
                 || ',cod_plantarif '
                 || ',cod_cargobasico '
                 || ',num_os '
                 || ',num_ciclos '
                 || ',num_minutos '
                 || ',cod_idioma '
                 || ',cod_tipident2 '
                 || ',num_ident2 '
                 || ',cod_plaza '
                 || ',des_refdoc '
                 || ',cod_limconsumo '
                 || ',cod_subcategoria '
                 || ') '
                 || 'VALUES (';

         IF (EV_cod_cliente IS NOT NULL) AND (LENGTH(EV_cod_cliente) > 0) THEN
            LV_Sql:= LV_Sql || EV_cod_cliente;
        ELSE
            LV_Sql:= LV_Sql || 'NULL';
        END IF;
         IF (EV_cod_tipmodi IS NOT NULL) AND (LENGTH(EV_cod_tipmodi) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tipmodi || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;

        LV_Sql:= LV_Sql || ',SYSDATE';

         IF (EV_nom_usuarora IS NOT NULL) AND (LENGTH(EV_nom_usuarora) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_nom_usuarora || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_nom_cliente IS NOT NULL) AND (LENGTH(EV_nom_cliente) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_cliente,1,50) || '''';  -- 72181 24/11/2008 JMC
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_tipident IS NOT NULL) AND (LENGTH(EV_cod_tipident) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tipident || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_ident IS NOT NULL) AND (LENGTH(EV_num_ident) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_ident || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_calclien IS NOT NULL) AND (LENGTH(EV_cod_calclien) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_calclien || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_plancom IS NOT NULL) AND (LENGTH(EV_cod_plancom) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_plancom;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_ind_factur IS NOT NULL) AND (LENGTH(EV_ind_factur) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_ind_factur;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_ind_traspaso IS NOT NULL) AND (LENGTH(EV_ind_traspaso) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_ind_traspaso || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_actividad IS NOT NULL) AND (LENGTH(EV_cod_actividad) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_actividad;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_pais IS NOT NULL) AND (LENGTH(EV_cod_pais) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_pais || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_tef_cliente1 IS NOT NULL) AND (LENGTH(EV_tef_cliente1) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_tef_cliente1 || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_tef_cliente2 IS NOT NULL) AND (LENGTH(EV_tef_cliente2) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_tef_cliente2 || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_fax IS NOT NULL) AND (LENGTH(EV_num_fax) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_fax || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_ind_debito IS NOT NULL) AND (LENGTH(EV_ind_debito) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_ind_debito || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_sispago IS NOT NULL) AND (LENGTH(EV_cod_sispago) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_sispago;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_nom_apeclien1 IS NOT NULL) AND (LENGTH(EV_nom_apeclien1) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apeclien1,1,20) || ''''; -- 72181 24/11/2008 JMC
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_nom_apeclien2 IS NOT NULL) AND (LENGTH(EV_nom_apeclien2) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apeclien2,1,20) || ''''; -- 72181 24/11/2008 JMC
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_imp_stopdebit IS NOT NULL) AND (LENGTH(EV_imp_stopdebit) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_imp_stopdebit;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_banco IS NOT NULL) AND (LENGTH(EV_cod_banco) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_banco || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_sucursal IS NOT NULL) AND (LENGTH(EV_cod_sucursal) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_sucursal || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_ind_tipcuenta IS NOT NULL) AND (LENGTH(EV_ind_tipcuenta) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_ind_tipcuenta || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_tiptarjeta IS NOT NULL) AND (LENGTH(EV_cod_tiptarjeta) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tiptarjeta || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_ctacorr IS NOT NULL) AND (LENGTH(EV_num_ctacorr) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_ctacorr || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_tarjeta IS NOT NULL) AND (LENGTH(EV_num_tarjeta) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_tarjeta || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_fec_vencitarj IS NOT NULL) AND (LENGTH(EV_fec_vencitarj) > 0) THEN
            LV_Sql:= LV_Sql || ',TO_DATE(''' || EV_fec_vencitarj || ''',''' || CV_FORMATOFECHA || ''')';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_bancotarj IS NOT NULL) AND (LENGTH(EV_cod_bancotarj) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_bancotarj || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_tipidtrib IS NOT NULL) AND (LENGTH(EV_cod_tipidtrib) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tipidtrib || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_identtrib IS NOT NULL) AND (LENGTH(EV_num_identtrib) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_identtrib || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_tipidentapor IS NOT NULL) AND (LENGTH(EV_cod_tipidentapor) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tipidentapor || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_identapor IS NOT NULL) AND (LENGTH(EV_num_identapor) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_identapor || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_nom_apoderado IS NOT NULL) AND (LENGTH(EV_nom_apoderado) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || SUBSTR(EV_nom_apoderado,1,40) || ''''; -- 72181 24/11/2008 JMC
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_oficina IS NOT NULL) AND (LENGTH(EV_cod_oficina) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_oficina || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_pincli IS NOT NULL) AND (LENGTH(EV_cod_pincli) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_pincli || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_nom_email IS NOT NULL) AND (LENGTH(EV_nom_email) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_nom_email || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_ciclo IS NOT NULL) AND (LENGTH(EV_cod_ciclo) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_ciclo;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_categoria IS NOT NULL) AND (LENGTH(EV_cod_categoria) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_categoria;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_sector IS NOT NULL) AND (LENGTH(EV_cod_sector) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_sector;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_supervisor IS NOT NULL) AND (LENGTH(EV_cod_supervisor) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_supervisor;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_npi IS NOT NULL) AND (LENGTH(EV_cod_npi) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_npi;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_empresa IS NOT NULL) AND (LENGTH(EV_cod_empresa) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_cod_empresa;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_tip_plantarif IS NOT NULL) AND (LENGTH(EV_tip_plantarif) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_tip_plantarif || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_plantarif IS NOT NULL) AND (LENGTH(EV_cod_plantarif) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_plantarif || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_cargobasico IS NOT NULL) AND (LENGTH(EV_cod_cargobasico) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_cargobasico || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_os IS NOT NULL) AND (LENGTH(EV_num_os) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_num_os;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_ciclos IS NOT NULL) AND (LENGTH(EV_num_ciclos) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_num_ciclos;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_minutos IS NOT NULL) AND (LENGTH(EV_num_minutos) > 0) THEN
            LV_Sql:= LV_Sql || ',' || EV_num_minutos;
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_idioma IS NOT NULL) AND (LENGTH(EV_cod_idioma) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_idioma || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_tipident2 IS NOT NULL) AND (LENGTH(EV_cod_tipident2) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_tipident2 || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_num_ident2 IS NOT NULL) AND (LENGTH(EV_num_ident2) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_num_ident2 || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_plaza IS NOT NULL) AND (LENGTH(EV_cod_plaza) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_plaza || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_des_refdoc IS NOT NULL) AND (LENGTH(EV_des_refdoc) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_des_refdoc || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_limconsumo IS NOT NULL) AND (LENGTH(EV_cod_limconsumo) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_limconsumo || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
         IF (EV_cod_subcategoria IS NOT NULL) AND (LENGTH(EV_cod_subcategoria) > 0) THEN
            LV_Sql:= LV_Sql || ',''' || EV_cod_subcategoria || '''';
        ELSE
            LV_Sql:= LV_Sql || ',NULL';
        END IF;
        LV_Sql:= LV_Sql || ')';

        EXECUTE IMMEDIATE LV_Sql;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insModCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insModCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insModCliente_PR;

    PROCEDURE VE_insPlanComCliente_PR(EV_cod_cliente  IN  VARCHAR2,
                                      EV_cod_plancom  IN  VARCHAR2,
                                        EV_nom_usuarora IN  VARCHAR2,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insPlanComCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta el plan comercial del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_cod_cliente"  Tipo="NUMBER"> codigo empresa </param>
               <param nom="EV_cod_plancom"  Tipo="STRING"> </param>
               <param nom="EV_nom_usuarora" Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima VARCHAR2(20);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --  OBTENEMOS EL VALOR PARA FECHA MAXIMA
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FECHAMAXIMA,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_fechaMaxima,
                                                            SN_codRetorno,
                                                            SV_menRetorno,
                                                            SN_numEvento);
        IF (SN_codRetorno = 0) THEN
            LV_Sql:='ga_cliente_pcom(cod_cliente, '
                 || 'cod_plancom, '
                 || 'fec_desde, '
                 || 'nom_usuarora, '
                 || 'fec_hasta) '
                 || 'VALUES ('||EV_cod_cliente||', '
                 || EV_cod_plancom||','
                 || 'SYSDATE'||','
                 || EV_nom_usuarora||','
                 || 'TO_DATE(' || LV_fechaMaxima || ',' || CV_FORMATOFECMAX ||'))';

            INSERT INTO ga_cliente_pcom(cod_cliente,
                                        cod_plancom,
                                          fec_desde,
                                          nom_usuarora,
                                          fec_hasta)
            VALUES (EV_cod_cliente,
                    EV_cod_plancom,
                      SYSDATE,
                      EV_nom_usuarora,
                      TO_DATE(LV_fechaMaxima,CV_FORMATOFECMAX));
        END IF;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insPlanComCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insPlanComCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insPlanComCliente_PR;

    PROCEDURE VE_insRespCliente_PR(EV_cod_cliente      IN  VARCHAR2,
                                   EV_num_orden        IN  VARCHAR2,
                                     EV_cod_tipident     IN  VARCHAR2,
                                     EV_num_ident        IN  VARCHAR2,
                                     EV_nom_responsable  IN  VARCHAR2,
                                   EV_apellido1        IN  GA_RESPCLIENTES.APELLIDO1%TYPE,
                                   EV_apellido2        IN  GA_RESPCLIENTES.APELLIDO2%TYPE,
                                   EV_tipo_responsable IN  GA_RESPCLIENTES.TIPO_RESPONSABLE%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insRespCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta responsables del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_cod_cliente"     Tipo="NUMBER"> codigo empresa </param>
               <param nom="EV_num_orden"       Tipo="STRING"> </param>
               <param nom="EV_cod_tipident"    Tipo="STRING"> </param>
               <param nom="EV_num_ident"       Tipo="STRING"> </param>
               <param nom="EV_nom_responsable" Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima VARCHAR2(20);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='ga_respclientes(cod_cliente, '
             || 'num_orden, '
             || 'cod_tipident, '
             || 'num_ident, '
             || 'nom_responsable,apellido1,apellido2,tipo_responsable) '
             || 'VALUES (' || EV_cod_cliente || ', '
             || EV_num_orden || ','
             || EV_cod_tipident || ','
             || EV_num_ident ||','
             || SUBSTR(EV_nom_responsable,1,50) || ','
             || EV_apellido1 || ','
             || EV_apellido2 || ','
             || EV_tipo_responsable
             ||')';

        INSERT INTO ga_respclientes(cod_cliente,
                                    num_orden,
                                     cod_tipident,
                                     num_ident,
                                     nom_responsable,apellido1,apellido2,tipo_responsable)
        VALUES (EV_cod_cliente,
                EV_num_orden,
                  EV_cod_tipident,
                  EV_num_ident,
                  SUBSTR(EV_nom_responsable,1,50),EV_apellido1,EV_apellido2,EV_tipo_responsable);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insRespCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insRespCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insRespCliente_PR;

    PROCEDURE VE_insDireccionCliente_PR(EV_cod_cliente      IN  VARCHAR2,
                                        EV_cod_tipdireccion IN  VARCHAR2,
                                          EV_cod_direccion    IN  VARCHAR2,
                                        SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insDireccionCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta direccion del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_cod_cliente"      Tipo="NUMBER"> codigo empresa </param>
               <param nom="EV_cod_tipdireccion" Tipo="STRING"> </param>
               <param nom="EV_cod_direccion"    Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --inc. 63316 13-03-2008 se inserta campo fecha_consulta
        LV_Sql:='ga_direccli (cod_cliente, '
             || 'cod_tipdireccion, '
             || 'cod_direccion, '
             || 'fecha_consulta)'
             || 'VALUES (' || EV_cod_cliente || ', '
             || EV_cod_tipdireccion || ','
             || EV_cod_direccion || ','
             || 'SYSDATE)';

        INSERT INTO ga_direccli(cod_cliente,
                                cod_tipdireccion,
                      cod_direccion,
                      fecha_consulta
                         )
        VALUES (EV_cod_cliente,
                EV_cod_tipdireccion,
                      EV_cod_direccion,
                      SYSDATE
                         );
        --fin inc. 63316 13-03-2008 se inserta campo fecha_consulta

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insDireccionCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insDireccionCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insDireccionCliente_PR;

    PROCEDURE VE_insCatImposCliente_PR(EV_cod_cliente  IN  VARCHAR2,
                                       EV_cod_catimpos IN  VARCHAR2,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insCatImposCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta el categoria impositiva del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EV_cod_cliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EV_cod_catimpos" Tipo="STRING"> </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        ERROR_SQL EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima VARCHAR2(20);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --  OBTENEMOS EL VALOR PARA FECHA MAXIMA
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FECHAMAXIMA,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_fechaMaxima,
                                                            SN_codRetorno,
                                                            SV_menRetorno,
                                                            SN_numEvento);
        IF (SN_codRetorno <> 0) THEN
            RAISE ERROR_SQL;
        END IF;


        LV_Sql:='ga_catimpclientes(cod_cliente, '
             || 'cod_catimpos, '
             || 'fec_desde, '
             || 'fec_hasta) '
             || 'VALUES (' || EV_cod_cliente || ', '
             || EV_cod_catimpos ||','
             || 'SYSDATE' || ','
             || 'TO_DATE(' || LV_fechaMaxima || ',' || CV_FORMATOFECMAX ||'))';

        INSERT INTO ge_catimpclientes(cod_cliente,
                                      cod_catimpos,
                                        fec_desde,
                                        fec_hasta)
        VALUES (EV_cod_cliente,
                EV_cod_catimpos,
                  SYSDATE,
                  TO_DATE(LV_fechaMaxima,CV_FORMATOFECMAX));

    EXCEPTION
            WHEN ERROR_SQL THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCatImposCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCatImposCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCatImposCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCatImposCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insCatImposCliente_PR;

    PROCEDURE VE_insVendCliente_PR(EV_cod_vendedor IN  VARCHAR2,
                                   EV_cod_cliente  IN  VARCHAR2,
                                     EV_nom_usuario  IN  VARCHAR2,
                                   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insVendCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="13-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta relacion vendedor cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_cod_vendedor" Tipo="NUMBER"> codigo vendedor </param>
               <param nom="EN_cod_cliente"  Tipo="NUMBER"> codigo cliente </param>
               <param nom="EV_nom_usuario"  Tipo="STRING"> nombre usuario </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima VARCHAR2(20);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO ve_vendcliente(cod_vendedor, '
             || 'cod_cliente, '
             || 'fec_asignacion, '
             || 'nom_usuario) '
             || 'VALUES (' || EV_cod_vendedor || ', '
             || EV_cod_cliente || ', '
             || 'SYSDATE, '
             || EV_nom_usuario ||')';

--         INSERT INTO ve_vendcliente(cod_vendedor,
--                                    cod_cliente,
--                                     fec_asignacion,
--                                     nom_usuario)
--         VALUES (EV_cod_vendedor,
--                 EV_cod_cliente,
--                   SYSDATE,
--                   EV_nom_usuario);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insVendCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insVendCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insVendCliente_PR;

    --inc. 80030 18-03-2009
    PROCEDURE VE_analisis_categoria_PR(EV_cod_cliente   IN  VARCHAR2,
                                         SV_cod_categoria OUT NOCOPY ga_cuentas.cod_categoria%TYPE,
                                       SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError   ge_errores_pg.desevent;
    LV_Error      VARCHAR2(256);
    LV_sql          ge_errores_pg.vquery;
    LV_seq          ga_transacabo.num_transaccion%TYPE;
    LV_cod_categoria ga_cuentas.cod_categoria%TYPE;
    LV_cod_catribut ga_cuentas.cod_catribut%TYPE;
    LV_num_ident    ga_cuentas.num_ident%TYPE;
    LV_cod_retorno  ga_transacabo.cod_retorno%TYPE;
    LV_des_cadena     ga_transacabo.des_cadena%TYPE;
    LE_param_null EXCEPTION;
    LE_fin           EXCEPTION;

    BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        BEGIN
            IF trim(EV_cod_cliente) IS NULL OR trim(EV_cod_cliente)='' THEN
               LV_Sql:=NULL;
               LV_Error:='Parametro entrada cod_cliente NULL en VE_analisis_categoria_PR';
               RAISE LE_param_null;
            END IF;

            EXCEPTION
                WHEN LE_param_null THEN
                     LV_desError:='Parametro Cod_cliente Null';
                     RAISE LE_fin;

        END;

        LV_Sql:='SELECT cod_categoria FROM ga_cuentas WHERE cod_cuenta = (SELECT cod_cuenta';
        LV_Sql:= LV_Sql || ' FROM ge_clientes WHERE    cod_cliente = ' || EV_cod_cliente || ')';

        BEGIN

            SELECT cod_categoria, cod_catribut, num_ident
            INTO   LV_cod_categoria, LV_cod_catribut, LV_num_ident
            FROM   ga_cuentas
            WHERE  cod_cuenta = (SELECT cod_cuenta
                                      FROM     ge_clientes
                                 WHERE    cod_cliente = trim(EV_cod_cliente)
                                     );

            SV_cod_categoria:=LV_cod_categoria;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    LV_Error:='No se encuentra cuenta de cliente ' || trim(EV_cod_cliente) || ' En ga_cuentas';
                       RAISE LE_fin;

        END;

        BEGIN
             IF trim(SV_cod_categoria) IS NULL OR trim(SV_cod_categoria)='0' THEN

                BEGIN

                     LV_Sql:='SELECT val_parametro FROM ged_parametros WHERE  nom_parametro = COD_CATEMP_DEFAULT ';
                     LV_Sql:= LV_Sql || 'and cod_modulo=GA and cod_producto=1';

                     SELECT val_parametro
                     INTO    SV_cod_categoria
                     FROM   ged_parametros
                     WHERE  nom_parametro = 'COD_CATEMP_DEFAULT'
                            and cod_modulo='GA'
                            and cod_producto=1;

                     EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                            LV_Error:='No se pudo obtener parametro COD_CATEMP_DEFAULT desde ged_parametros';
                            RAISE LE_fin;

                END;


             END IF;
        END;

        EXCEPTION
             WHEN LE_fin THEN
                   SN_codRetorno:=156;
                  LV_desError  := 'LE_fin:VE_alta_cliente_PG.VE_analisis_categoria_PR;- ' || LV_Error;
                  SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                  'VE_alta_cliente_PG.VE_analisis_categoria_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                 SN_codRetorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_analisis_categoria_PR;- ' || SQLERRM;
                 SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                 'VE_alta_cliente_PG.VE_analisis_categoria_PR', LV_Sql, SQLCODE, LV_desError );

    END VE_analisis_categoria_PR;
    --fin inc. 80030 18-03-2009

    PROCEDURE VE_updCategCliente_PR(EV_cod_cliente   IN  VARCHAR2,
                                    EV_cod_categoria IN  VARCHAR2,
                                    SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updCategCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Actualiza categoria del cliente
        </Descripción>
        <Parámetros>
            <Entrada>
           <param nom="EN_cod_cliente"   Tipo="NUMBER"> codigo cliente </param>
           <param nom="EN_cod_categoria" Tipo="NUMBER"> codigo categoria </param>
        </Entrada>
            <Salida>
           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        SV_cod_categoria varchar2(5);
        LV_cod_categoria varchar2(5);
        LV_error          VARCHAR(256);
        LE_fin EXCEPTION;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        --inc. 80030 18-03-2009
        IF trim(EV_cod_categoria) IS NULL OR trim(EV_cod_categoria)='' or trim(upper(EV_cod_categoria))='NULL' THEN
            VE_analisis_categoria_PR(EV_cod_cliente, SV_cod_categoria, SN_codRetorno, SV_menRetorno, SN_numEvento);
            IF SN_codRetorno=0 THEN
               LV_cod_categoria:=SV_cod_categoria;
            ELSE
               LV_error:='Problema al obtener categoria para cliente ' || EV_cod_cliente;
               RAISE LE_fin;
            END IF;
        else
            LV_cod_categoria:=EV_cod_categoria;
        END IF;
        --fin inc. 80030 18-03-2009

        LV_Sql:='UPDATE ge_clientes '
             || 'SET cod_categoria = ' || LV_cod_categoria
             || 'WHERE cod_cliente = ' || EV_cod_cliente;

        UPDATE ge_clientes
        SET cod_categoria = LV_cod_categoria
        WHERE cod_cliente = EV_cod_cliente;

    EXCEPTION
             WHEN LE_fin THEN
                 SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updCategCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updCategCliente_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updCategCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updCategCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_updCategCliente_PR;

    PROCEDURE VE_updCodigoUsoCliente_PR(EV_codCuenta  IN  VARCHAR2,
                                        EV_codUso     IN  VARCHAR2,
                                        SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento  OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updCodigoUsoCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Actualiza codigo uso del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCuenta" Tipo="STRING"> codigo cuenta </param>
               <param nom="EN_codUso"    Tipo="STRING"> codigo uso </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='UPDATE ge_clientes a'
             || 'SET a.cod_uso  = ' ||  EV_codUso
             || 'WHERE a.cod_cuenta = ' || EV_codCuenta;

        UPDATE ge_clientes a
        SET a.cod_uso = EV_codUso
        WHERE a.cod_cuenta = EV_codCuenta;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updCodigoUsoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updCodigoUsoCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_updCodigoUsoCliente_PR;

    PROCEDURE VE_updCategClienteCta_PR(EV_codCuenta    IN  VARCHAR2,
                                       EV_codCategoria IN  VARCHAR2,
                                       SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updCategClienteCta_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Actualiza codigo categoria del cliente,segun codigo cuenta
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCuenta" Tipo="STRING"> codigo cuenta </param>
               <param nom="EN_codUso"    Tipo="STRING"> codigo uso </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        LV_Sql:='UPDATE ge_clientes a'
             || 'SET a.cod_categoria  = ' || EV_codCategoria
             || 'WHERE a.cod_cuenta = ' || EV_codCuenta
             || 'AND (a.cod_categoria IS NULL or a.cod_categoria = 0)';

        UPDATE ge_clientes a
        SET a.cod_categoria = EV_codCategoria
        WHERE a.cod_cuenta = EV_codCuenta
        AND (a.cod_categoria IS NULL OR a.cod_categoria = 0);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updCategClienteCta_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updCategClienteCta_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_updCategClienteCta_PR;

    PROCEDURE VE_updSubCategCliente_PR(EV_codCliente  IN  VARCHAR2,
                                       EV_codSubCateg IN  VARCHAR2,
                                       SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_updSubCategCliente_PR"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="wjrc"
            Programador="wjrc"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Actualiza codigo subcategoria del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
             </Entrada>
             <Salida>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='UPDATE ge_clientes a'
             || ' SET a.cod_subcategoria  = ' ||  EV_codSubCateg
             || ' WHERE a.cod_cliente = ' || EV_codCliente;

        UPDATE ge_clientes a
        SET a.cod_subcategoria = EV_codSubCateg
        WHERE a.cod_cliente = EV_codCliente;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updSubCategCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updSubCategCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_updSubCategCliente_PR;


    PROCEDURE Ve_getOperadoraCliente_pr(SV_codOperadora OUT NOCOPY VARCHAR2,
                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "Ve_getOperadoraCliente_pr"
            Lenguaje="PL/SQL"
            Fecha="15-06-2007"
            Versión="1.0.0"
            Diseñador="igo"
            Programador="igo"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Actualiza codigo subcategoria del cliente
        </Descripción>
        <Parámetros>
             <Entrada>
             </Entrada>
             <Salida>
               <param nom="SV_codOperadora" Tipo="STRING"> código de operadora</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT A.COD_OPERADORA_SCL'
             || ' FROM GE_ALMS A, GE_CELDAS B, GE_CIUDADES C, GE_SUBALMS D'
             || ' WHERE A.COD_ALM = D.COD_ALM'
             || ' AND D.COD_SUBALM = B.COD_SUBALM'
             || ' AND B.COD_CELDA = C.COD_CELDA'
             || ' AND C.COD_CIUDAD =  1'
             || ' AND C.COD_PROVINCIA =  1'
             || ' AND C.COD_REGION = 1'
             || ' and rownum=1';

        SELECT A.COD_OPERADORA_SCL
          INTO SV_codOperadora
          FROM GE_ALMS A, GE_CELDAS B, GE_CIUDADES C, GE_SUBALMS D
         WHERE A.COD_ALM = D.COD_ALM
           AND D.COD_SUBALM = B.COD_SUBALM
           AND B.COD_CELDA = C.COD_CELDA
           -- Incidencia 61234 se comentan filtros de busqueda, no aplican para Colombia [PAAA 21-01-2008, soporte]
           --AND C.COD_CIUDAD =  1
           --AND C.COD_PROVINCIA =  1
           --AND C.COD_REGION = 1
           --Fin 61234
           AND ROWNUM=1;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.Ve_getOperadoraCliente_pr;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.Ve_getOperadoraCliente_pr', LV_Sql, SQLCODE, LV_desError );
    END Ve_getOperadoraCliente_pr;

    PROCEDURE VE_getStrComputec_PR( SV_StrComputec OUT NOCOPY VARCHAR2,
                                    SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_getStrComputec_PR"
            Lenguaje="PL/SQL"
            Fecha="02-11-2007"
            Versión="1.0.0"
            Diseñador="Maricel Avalos L"
            Programador="Maricel Avalos L"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                 Obtiene el string utilizado para enviar a Computec (Direcciones)
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
             </Entrada>
             <Salida>
               <param nom="SV_StrComputec"   Tipo="STRING"> String para enviar a Computec</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := '';
        SN_numEvento  := 0;

        LV_sql:='SELECT uno.VAL_PARAMETRO||.||dos.VAL_PARAMETRO';
        LV_sql:=LV_sql||'||.||tres.VAL_PARAMETRO||.||cuatro.VAL_PARAMETRO||.||';
        LV_sql:=LV_sql||' From';
        LV_sql:=LV_sql||' (SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
        LV_sql:=LV_sql||' Where  NOM_PARAMETRO = ''CODSUSCRIPTOR''';
        LV_sql:=LV_sql||'  And COD_MODULO = ''GA'' And COD_PRODUCTO = 1) uno,';
        LV_sql:=LV_sql||' (SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
        LV_sql:=LV_sql||' Where  NOM_PARAMETRO = ''CODROMPIMIENTO''';
        LV_sql:=LV_sql||' And COD_MODULO = ''GA'' And COD_PRODUCTO = 1) dos,';
        LV_sql:=LV_sql||' (SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
        LV_sql:=LV_sql||' Where  NOM_PARAMETRO = ''CLAVEASIGNADA''';
        LV_sql:=LV_sql||' And COD_MODULO = ''GA'' And COD_PRODUCTO = 1) tres,';
        LV_sql:=LV_sql||' (SELECT VAL_PARAMETRO FROM GED_PARAMETROS';
        LV_sql:=LV_sql||' Where  NOM_PARAMETRO = ''TIPIDENTIF''';
        LV_sql:=LV_sql||' And COD_MODULO = ''GA'' And COD_PRODUCTO = 1) cuatro';

         SELECT uno.VAL_PARAMETRO||'.'||dos.VAL_PARAMETRO
              ||'.'||tres.VAL_PARAMETRO||'.'||cuatro.VAL_PARAMETRO ||'.'
         INTO SV_StrComputec
         FROM
             (SELECT VAL_PARAMETRO FROM GED_PARAMETROS
             WHERE  NOM_PARAMETRO = 'CODSUSCRIPTOR'
             AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1) uno,
             (SELECT VAL_PARAMETRO FROM GED_PARAMETROS
             WHERE  NOM_PARAMETRO = 'CODROMPIMIENTO'
             AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1) dos,
             (SELECT VAL_PARAMETRO FROM GED_PARAMETROS
             WHERE  NOM_PARAMETRO = 'CLAVEASIGNADA'
             AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1) tres,
             (SELECT VAL_PARAMETRO FROM GED_PARAMETROS
             WHERE  NOM_PARAMETRO = 'TIPIDENTIF'
             AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1) cuatro;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'VE_alta_cliente_PG.VE_getStrComputec_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getStrComputec_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getStrComputec_PR;

    PROCEDURE VE_obtieneIPPuerto_PR(SV_IP             OUT NOCOPY VARCHAR2,
                                      SV_Puerto       OUT NOCOPY VARCHAR2,
                                    LN_CodRetorno  OUT NOCOPY NUMBER,
                                    SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtieneIPPuerto_PR"
            Lenguaje="PL/SQL"
            Fecha="02-11-2007"
            Versión="1.0.0"
            Diseñador="Maricel Avalos L"
            Programador="Maricel Avalos L"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                 Obtiene IP y Puerto de conexion para DataCredit
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
             </Entrada>
             <Salida>
               <param nom="SV_StrComputec"   Tipo="STRING"> String para enviar a Computec</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := '';
        SN_numEvento  := 0;

        LV_sql:='SELECT valor_texto';
        LV_sql:=LV_sql||' FROM GA_PARAMETROS_SIMPLES_VW';
        LV_sql:=LV_sql||' WHERE nom_parametro IN (''IP_CONEXION_SERV'')';

        SELECT valor_texto
        INTO SV_IP
         FROM GA_PARAMETROS_SIMPLES_VW
          WHERE nom_parametro IN ('IP_CONEXION_SERV');

        LV_sql:='SELECT valor_texto';
        LV_sql:=LV_sql||' FROM GA_PARAMETROS_SIMPLES_VW';
        LV_sql:=LV_sql||' WHERE nom_parametro IN (''PUERTO_CONEX_SERV'')';

        SELECT valor_texto
        INTO SV_Puerto
         FROM GA_PARAMETROS_SIMPLES_VW
          WHERE nom_parametro IN ('PUERTO_CONEX_SERV');

        LV_sql:='SELECT valor_numerico From GA_PARAMETROS_SIMPLES_VW';
        LV_sql:=LV_sql|| ' WHERE NOM_PARAMETRO = ''COD_RETORNO_EXTERNO''';

        SELECT valor_numerico
        INTO LN_CodRetorno
         FROM GA_PARAMETROS_SIMPLES_VW
          WHERE NOM_PARAMETRO  = 'COD_RETORNO_EXTERNO';

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'VE_alta_cliente_PG.VE_obtieneIPPuerto_PR; ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_obtieneIPPuerto_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_obtieneIPPuerto_PR;

    PROCEDURE VE_FechaVigencia_PR( EV_codCliente       IN  ge_clientes.cod_cliente%TYPE,
                                     EV_tipDireccion        IN  ga_direccli.cod_tipdireccion%TYPE,
                                     SV_RetornoVigencia  OUT NOCOPY VARCHAR2,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento          OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_FechaVigencia_PR"
            Lenguaje="PL/SQL"
            Fecha="02-11-2007"
            Versión="1.0.0"
            Diseñador="Maricel Avalos L"
            Programador="Maricel Avalos L"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                 Consulta la cantidad de dias maximo para ejecutar la llamada a DataCredit y
                 la compara con la ultima modificacion de direccion para el cliente
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
             </Entrada>
             <Salida>
               <param nom="SV_StrComputec"   Tipo="STRING"> String para enviar a Computec</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := '';
        SN_numEvento  := 0;

        LV_sql:='SELECT PV_VIGENCIA_DIRECCION_PG.PV_CONSULTAVIGENCIA_FN (';
        LV_sql:=LV_sql|| EV_codCliente||','||EV_tipDireccion;
        LV_sql:=LV_sql||' FROM DUAL';

        SELECT PV_VIGENCIA_DIRECCION_PG.PV_CONSULTAVIGENCIA_FN ( EV_codCliente, EV_tipDireccion)
        INTO SV_RetornoVigencia
        FROM DUAL;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'VE_alta_cliente_PG.VE_FechaVigencia_PR('||EV_codCliente||','||EV_tipDireccion||');' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_FechaVigencia_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_FechaVigencia_PR;

    PROCEDURE VE_ActualizaConsultaDirec_PR( EV_codCliente  IN  ge_clientes.cod_cliente%TYPE,
                                     EV_tipDireccion            IN  ga_direccli.cod_tipdireccion%TYPE,
                                     SV_RetornoActConsDirec  OUT NOCOPY VARCHAR2,
                                   SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento              OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_FechaVigencia_PR"
            Lenguaje="PL/SQL"
            Fecha="02-11-2007"
            Versión="1.0.0"
            Diseñador="Maricel Avalos L"
            Programador="Maricel Avalos L"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                 Actualiza la fecha de consulta en la tabla de direcciones
        </Descripción>
        <Parámetros>
             <Entrada>
               <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
               <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
             </Entrada>
             <Salida>
               <param nom="SV_StrComputec"   Tipo="STRING"> String para enviar a Computec</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := '';
        SN_numEvento  := 0;

        LV_sql:='SELECT PV_VIGENCIA_DIRECCION_PG.pv_UpdateUltimaConsulta_fn (';
        LV_sql:=LV_sql|| EV_codCliente||','||EV_tipDireccion;
        LV_sql:=LV_sql||' FROM DUAL';

        SELECT PV_VIGENCIA_DIRECCION_PG.pv_UpdateUltimaConsulta_fn ( EV_codCliente, EV_tipDireccion)
        INTO SV_RetornoActConsDirec
        FROM DUAL;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'VE_alta_cliente_PG.VE_ActualizaConsultaDirec_PR('||EV_codCliente||','||EV_tipDireccion||');' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_ActualizaConsultaDirec_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_ActualizaConsultaDirec_PR;

-- Inc. : 72637
-- Fecha: 14/11/2008
-- Prog : JMC
    PROCEDURE VE_getCicloPorDefecto_PR(SV_CodCiclo             OUT NOCOPY VARCHAR2,
                       SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento              OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_CicloPorDefecto_PR"
            Lenguaje="PL/SQL"
            Fecha="14-11-2008"
            Versión="1.0.0"
            Diseñador="JMC"
            Programador="JMC"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                 retorna el ciclo por defecto
        </Descripción>
        <Parámetros>
             <Entrada>
         </Entrada>
             <Salida>
               <param nom="SV_CodCiclo"   Tipo="STRING"> codigo del ciclo por defecto</param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                       <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                       <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := '';
        SN_numEvento  := 0;
        SV_CodCiclo   := 0;

        LV_sql:='SELECT cod_ciclo FROM fa_ciclfact WHERE fec_hastallam = (SELECT max(fec_hastallam) ';
        LV_sql:=LV_sql|| ' FROM fa_ciclfact WHERE fec_hastallam < sysdate and cod_ciclo <> 25)';


        SELECT cod_ciclo
        INTO SV_CodCiclo
                FROM fa_ciclfact
                WHERE fec_hastallam = (SELECT MAX(fec_hastallam)
                                       FROM fa_ciclfact
                                       WHERE fec_hastallam < SYSDATE AND cod_ciclo <> 25);


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'VE_alta_cliente_PG.VE_ActualizaConsultaDirec_PR();' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_ActualizaConsultaDirec_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getCicloPorDefecto_PR;

PROCEDURE VE_insdatclifactura_PR(
                    EV_cod_cliente      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                    EV_cod_tipident     IN GE_DATCLIFACTURA_TO.COD_TIPIDENT%TYPE,
                    EV_num_ident        IN GE_DATCLIFACTURA_TO.NUM_IDENT%TYPE,
                    EV_nombre_cliente   IN GE_DATCLIFACTURA_TO.NOMBRE%TYPE,
                    EV_Apellido1        IN GE_DATCLIFACTURA_TO.NOM_APELLIDO1%TYPE,
                    EV_Apellido2        IN GE_DATCLIFACTURA_TO.NOM_APELLIDO2%TYPE,
                    EV_Tipo_Factura     IN GE_DATCLIFACTURA_TO.TIPO_FACTURA%TYPE,
                    EV_Cod_tipdocum     IN GE_DATCLIFACTURA_TO.COD_TIPDOCUM%TYPE,
                    EV_num_venta        IN GE_DATCLIFACTURA_TO.NUM_VENTA%TYPE,
                    EV_Nom_usuarora     IN GE_DATCLIFACTURA_TO.NOM_USUARORA%TYPE,
                    SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                       SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                    SN_numEvento              OUT NOCOPY ge_errores_pg.Evento
                    )IS
        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_insdatclifactura_PR"
            Lenguaje="PL/SQL"
            Fecha="25-05-2009"
            Versión="1.0.0"
            Diseñador="NRCA"
            Programador="NRCA"
            Ambiente="BD"
        <Retorno> N/A </Retorno>
        <Descripción>
                  Inserta Cliente imprimible
        </Descripción>
        </Documentación>
        */
        ERROR_SQL EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima  VARCHAR2(20);

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;




        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FECHAMAXIMA,
                                                            CV_MODULO_GE,
                                                            CV_PRODUCTO,
                                                            LV_fechaMaxima,
                                                            SN_codRetorno,
                                                            SV_menRetorno,
                                                            SN_numEvento);


        LV_Sql:='INSERT INTO GE_DATCLIFACTURA_TO ('
                    || ' cod_cliente '
                    || ',cod_tipident '
                    || ',num_ident '
                    || ',nombre '
                    || ',nom_apellido1 '
                    || ',nom_apellido2 '
                    || ',tipo_factura '
                    || ',cod_tipdocum '
                    || ',num_venta '
                    || ',fec_desde '
                    || ',fec_hasta '
                    || ',nom_usuarora '
                    || ',fec_modificacion '
                    || ')'
                     || 'VALUES ( ';



            IF (EV_cod_cliente IS NOT NULL) AND (LENGTH(EV_cod_cliente) > 0) THEN
                LV_Sql:= LV_Sql || '''' || EV_cod_cliente || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_cod_tipident IS NOT NULL) AND (LENGTH(EV_cod_tipident) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_cod_tipident || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_num_ident IS NOT NULL) AND (LENGTH(EV_num_ident) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_ident || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_nombre_cliente IS NOT NULL) AND (LENGTH(EV_nombre_cliente) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_nombre_cliente || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_Apellido1 IS NOT NULL) AND (LENGTH(EV_Apellido1) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_Apellido1 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_Apellido2 IS NOT NULL) AND (LENGTH(EV_Apellido2) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_Apellido2 || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_Tipo_Factura IS NOT NULL) AND (LENGTH(EV_Tipo_Factura) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_Tipo_Factura || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_Cod_tipdocum IS NOT NULL) AND (LENGTH(EV_Cod_tipdocum) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_Cod_tipdocum || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            IF (EV_num_venta IS NOT NULL) AND (LENGTH(EV_num_venta) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_num_venta || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

               LV_Sql:= LV_Sql || ',SYSDATE,';
            LV_Sql:= LV_Sql || 'TO_DATE(''' || LV_fechaMaxima || ''',''' || CV_FORMATOFECMAX ||''')';

            IF (EV_Nom_usuarora IS NOT NULL) AND (LENGTH(EV_Nom_usuarora) > 0) THEN
                LV_Sql:= LV_Sql || ',''' || EV_Nom_usuarora || '''';
            ELSE
                LV_Sql:= LV_Sql || ',NULL';
            END IF;

            LV_Sql:= LV_Sql || ',SYSDATE';

            LV_Sql:= LV_Sql || ')';

            EXECUTE IMMEDIATE LV_Sql;





    EXCEPTION
            WHEN ERROR_SQL THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insdatclifactura_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insdatclifactura_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insdatclifactura_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insdatclifactura_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insdatclifactura_PR;

PROCEDURE VE_insMontoPreautorizado_PR(EN_cod_cliente   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                   EN_mto_preaut       IN  GE_MTOPREAUTOCLI_TO.MTO_PREAUTO%TYPE,
                                   EV_nom_usuarora     IN  GE_MTOPREAUTOCLI_TO.NOM_USUARORA%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) IS

        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_count    number(1);
        LV_Crediticia Varchar2(5);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        SELECT COUNT(1)
        INTO LV_COUNT
        FROM GE_MTOPREAUTOCLI_TO
        WHERE COD_CLIENTE=EN_cod_cliente;

        IF LV_COUNT=0 THEN


          LV_Sql:='SELECT COD_CREDITICIA'
                ||' FROM GE_CLIENTES'
                ||' WHERE COD_CLIENTE='|| EN_COD_CLIENTE;

          SELECT COD_CREDITICIA
          INTO  LV_Crediticia
          FROM GE_CLIENTES
          WHERE COD_CLIENTE=EN_COD_CLIENTE;


           LV_Sql:='GE_MTOPREAUTOCLI_TO(cod_cliente, '
                    || 'mto_preauto, '
                  || 'fec_modificacion, '
                  || 'nom_usuarora,cod_crediticia)'
                  || 'VALUES (' || EN_cod_cliente || ', '
                  || EN_mto_preaut || ','
                  || 'SYSDATE,'
                  || EV_nom_usuarora || ',' || LV_Crediticia
                  ||')';

          INSERT INTO GE_MTOPREAUTOCLI_TO(cod_cliente,
                                      mto_preauto,
                                         fec_modificacion,
                                       nom_usuarora,cod_crediticia)
          VALUES (EN_cod_cliente,
                  EN_mto_preaut,
                      SYSDATE,
                    EV_nom_usuarora,LV_Crediticia);


        ELSE
           LV_Sql:=' INSERT INTO GE_MTOPREAUTOCLI_TH(cod_cliente, '
                    || 'mto_preauto, '
                  || 'fec_modificacion, '
                  || 'nom_usuarora,cod_crediticia)'
                  || 'VALUES ( SELECT COD_CLIENTE,MTO_PREAUTO,FEC_MODIFICACION,NOM_USUARORA,COD_CREDITICIA'
                  || 'WHERE COD_CLIENTE = ' || EN_COD_CLIENTE
                  ||')';

          INSERT INTO GE_MTOPREAUTOCLI_TH(cod_cliente,
                    mto_preauto,
                  fec_modificacion,
                  nom_usuarora,cod_crediticia)
                  SELECT COD_CLIENTE,MTO_PREAUTO,FEC_MODIFICACION,NOM_USUARORA,COD_CREDITICIA
                  FROM GE_MTOPREAUTOCLI_TO WHERE COD_CLIENTE = EN_COD_CLIENTE;


          --Delete de la tabla GE_MTO_PREAUTOCLI_TO

          DELETE FROM GE_MTOPREAUTOCLI_TO
          WHERE COD_CLIENTE = EN_COD_CLIENTE;

          --INSERT del Nuevo Registro

          LV_Sql:='GE_MTOPREAUTOCLI_TO(cod_cliente, '
                    || 'mto_preauto, '
                  || 'fec_modificacion, '
                  || 'nom_usuarora)'
                  || 'VALUES (' || EN_cod_cliente || ', '
                  || EN_mto_preaut || ','
                  || 'SYSDATE,'
                  || EV_nom_usuarora
                  ||')';

          LV_Sql:='SELECT COD_CREDITICIA'
                ||' FROM GE_CLIENTES'
                ||' WHERE COD_CLIENTE='|| EN_COD_CLIENTE;

          SELECT COD_CREDITICIA
          INTO  LV_Crediticia
          FROM GE_CLIENTES
          WHERE COD_CLIENTE=EN_COD_CLIENTE;


          INSERT INTO GE_MTOPREAUTOCLI_TO(cod_cliente,
                                      mto_preauto,
                                         fec_modificacion,
                                       nom_usuarora,cod_crediticia)
          VALUES (EN_cod_cliente,
                  EN_mto_preaut,
                      SYSDATE,
                    EV_nom_usuarora, LV_Crediticia);
        END IF;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insMontoPreautorizado_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insMontoPreautorizado_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insMontoPreautorizado_PR;


    PROCEDURE VE_getListTipoCliente_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select cod_valor,des_valor
        from ged_codigos
        where nom_tabla='GE_CLIENTES'
        and nom_columna='COD_TIPO';

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListTipoCliente_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListTipoCliente_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListTipoCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListTipoCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListTipoCliente_PR;

     PROCEDURE VE_getListCodigos_PR(
                                  EV_nom_columna   IN  GED_CODIGOS.NOM_COLUMNA%TYPE,
                                  SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select cod_valor,des_valor
        from ged_codigos
        where nom_tabla='GE_CLIENTES'
        and nom_columna=EV_nom_columna;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListCrediticias_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListTipoCliente_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCrediticias_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCrediticias_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCodigos_PR;

        PROCEDURE VE_getListCalificacion_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select cod_valor,des_valor
        from ged_codigos
        where nom_tabla='GE_CLIENTES'
        and nom_columna='COD_CALIFICACION';

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListCalificacion_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListCalificacion_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCalificacion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCalificacion_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCalificacion_PR;
    PROCEDURE VE_getListoperadoras_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select COD_OPERADOR,UPPER(DES_OPERADOR)
        from TA_OPERADORES
        ORDER BY DES_OPERADOR;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListoperadoras_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListoperadoras_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListoperadoras_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListoperadoras_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListoperadoras_PR;

    PROCEDURE VE_getListProfesiones_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select COD_ACTIVIDAD,DES_ACTIVIDAD
        from GE_ACTIVIDADES;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListProfesiones_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListProfesiones_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListProfesiones_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListProfesiones_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListProfesiones_PR;
    PROCEDURE VE_getListCargosLaborales_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        OPEN SC_cursorDatos FOR
        select cod_ocupacion,des_ocupacion
            from GE_OCUPACIONES
            ORDER BY des_ocupacion; --MODIFICACIÓN GT.15.06.10

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListCargosLaborales_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListCargosLaborales_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCargosLaborales_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCargosLaborales_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCargosLaborales_PR;
    PROCEDURE VE_getListsegmentos_PR(
                                  EV_tipo_cliente IN  GE_CLIENTES.COD_TIPO%TYPE,
                                  SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        LV_SQL:='SELECT a.COD_SEGMENTO as valor, a.DES_SEGMENTO as SEGMENTO, 1 AS DEFAUL'
             || ' FROM GE_SEGMENTACION_CLIENTES_TD a , GE_INDDEFAULT_TD b'
             || ' WHERE'
             || ' b.NOM_TABLA = ''GE_SEGMENTACION_CLIENTES_TD'''
             || ' AND A.COD_SEGMENTO  = B.COD_DEFAULT'
             || ' AND A.COD_TIPO=' || EV_tipo_cliente
             || ' AND B.COD_WHERE='''|| 'COD_TIPO = ' || EV_tipo_cliente || ''''
             || ' UNION'
             || ' SELECT a.COD_SEGMENTO as valor, a.DES_SEGMENTO as SEGMENTO, 0 AS DEFAUL'
             || ' FROM GE_SEGMENTACION_CLIENTES_TD a , GE_INDDEFAULT_TD b'
             || ' WHERE'
             || ' b.NOM_TABLA = ''GE_SEGMENTACION_CLIENTES_TD'''
             || ' AND A.COD_TIPO=' || EV_tipo_cliente
             || ' AND B.COD_WHERE='''|| 'COD_TIPO = ' || EV_tipo_cliente || ''''
             || ' AND A.COD_SEGMENTO <> B.COD_DEFAULT';


        OPEN SC_cursorDatos FOR LV_SQL;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListsegmentos_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListsegmentos_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListsegmentos_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListsegmentos_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListsegmentos_PR;

        PROCEDURE VE_insRefCliente_PR
                                  (EV_cod_cliente      IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                   EV_num_referencia   IN  GA_REFERCLI_TO.NUM_REFERENCIA%TYPE,
                                     EV_nomCliente       IN  GA_REFERCLI_TO.NOMBRE%TYPE,
                                     EV_Apellido1        IN  GA_REFERCLI_TO.APELLIDO1%TYPE,
                                     EV_Apellido2        IN  GA_REFERCLI_TO.APELLIDO2%TYPE,
                                   EV_TelefonoMovil    IN  GA_REFERCLI_TO.NUM_TELMOVIL%TYPE,
                                   EV_TelefonoFijo     IN  GA_REFERCLI_TO.NUM_TELFIJO%TYPE,
                                   EV_NomUsuarora      IN  GA_REFERCLI_TO.NOM_USUARORA%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) IS

        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_fechaMaxima VARCHAR2(20);
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='ga_refercli_to(cod_cliente, '
             || 'num_referencia, '
             || 'nombre, '
             || 'apellido1, '
             || 'apellido2,num_telMovil,num_telfijo,fec_desde,fec_hasta,fec_ultmod,nom_usuarora) '
             || 'VALUES (' || EV_cod_cliente || ', '
             || EV_num_referencia || ','
             || EV_nomCliente || ','
             || EV_Apellido1 ||','
             || EV_Apellido2 || ','
             || EV_TelefonoMovil || ',' || ',' || EV_TelefonoFijo  || ',SYSDATE,31-12-3000,SYSDATE,'
             || EV_NomUsuarora
             ||')';

        INSERT INTO ga_refercli_to(cod_cliente,
                 num_referencia,
                 nombre,
                 apellido1,
                 apellido2,num_telmovil,num_telfijo,fec_desde,fec_hasta,fec_ultmod,nom_usuarora)
        VALUES (EV_cod_cliente,
                EV_num_referencia,
                  EV_nomCliente,
                  EV_Apellido1,
                  EV_Apellido2,EV_TelefonoMovil,EV_TelefonoFijo,SYSDATE,TO_DATE('31-12-3000','DD-MM-YYYY'),SYSDATE,EV_NomUsuarora);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insRefCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insRefCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insRefCliente_PR;

    PROCEDURE VE_getListColores_PR         (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        LV_SQL:='SELECT A.COD_COLOR AS VALOR, A.DES_COLOR AS COLOR, 1 AS DEFAUL'
        || ' FROM GE_COLOR_TD A , GE_INDDEFAULT_TD B'
        || ' WHERE A.IND_VIGENCIA = S'
        || ' AND B.NOM_TABLA = GE_COLOR_TD'
        || ' AND A.COD_COLOR  = B.COD_DEFAULT'
        || ' UNION'
        || ' SELECT A.COD_COLOR AS VALOR, A.DES_COLOR AS COLOR, 0 AS DEFAUL'
        || ' FROM GE_COLOR_TD A , GE_INDDEFAULT_TD B'
        || ' WHERE A.IND_VIGENCIA = S'
        || ' AND B.NOM_TABLA = GE_COLOR_TD'
        || ' AND A.COD_COLOR  <> B.COD_DEFAULT';

        OPEN SC_CURSORDATOS FOR
        SELECT A.COD_COLOR AS VALOR, A.DES_COLOR AS COLOR, 1 AS DEFAUL
        FROM GE_COLOR_TD A , GE_INDDEFAULT_TD B
        WHERE A.IND_VIGENCIA = 'S'
        AND B.NOM_TABLA = 'GE_COLOR_TD'
        AND A.COD_COLOR  = B.COD_DEFAULT
        UNION
        SELECT A.COD_COLOR AS VALOR, A.DES_COLOR AS COLOR, 0 AS DEFAUL
        FROM GE_COLOR_TD A , GE_INDDEFAULT_TD B
        WHERE A.IND_VIGENCIA = 'S'
        AND B.NOM_TABLA = 'GE_COLOR_TD'
        AND A.COD_COLOR  <> B.COD_DEFAULT;


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListColores_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListColores_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListColores_PR;
        PROCEDURE VE_getListCrediticia_PR  (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_SQL:='SELECT a.COD_CREDITICIA as valor, a.DES_CREDITICIA as CREDITICIA, 1 AS DEFAUL'
        ||      ' FROM GE_CREDITICIA_TD a , GE_INDDEFAULT_TD b'
        ||      ' WHERE a.IND_VIGENCIA = S'
        ||      ' and b.NOM_TABLA = GE_CREDITICIA_TD'
        ||      ' AND A.COD_CREDITICIA  = B.COD_DEFAULT'
        ||      ' UNION'
        ||      ' SELECT a.COD_CREDITICIA as valor, a.DES_CREDITICIA as CREDITICIA, 0 AS DEFAUL'
        ||      ' FROM GE_CREDITICIA_TD a , GE_INDDEFAULT_TD b'
        ||      ' WHERE a.IND_VIGENCIA = S'
        ||      ' and b.NOM_TABLA = GE_CREDITICIA_TD'
        ||      ' AND A.COD_CREDITICIA  <> B.COD_DEFAULT';



        OPEN SC_CURSORDATOS FOR
        SELECT a.COD_CREDITICIA as valor, a.DES_CREDITICIA as CREDITICIA, 1 AS DEFAUL
        FROM GE_CREDITICIA_TD a , GE_INDDEFAULT_TD b
        WHERE a.IND_VIGENCIA = 'S'
        and b.NOM_TABLA = 'GE_CREDITICIA_TD'
        AND A.COD_CREDITICIA  = B.COD_DEFAULT
        UNION
        SELECT a.COD_CREDITICIA as valor, a.DES_CREDITICIA as CREDITICIA, 0 AS DEFAUL
        FROM GE_CREDITICIA_TD a , GE_INDDEFAULT_TD b
        WHERE a.IND_VIGENCIA = 'S'
        and b.NOM_TABLA = 'GE_CREDITICIA_TD'
        AND A.COD_CREDITICIA  <> B.COD_DEFAULT;


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCrediticia_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCrediticia_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCrediticia_PR;
            PROCEDURE VE_getListCalificacion1_PR
                                           (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;


        LV_SQL:='SELECT a.COD_CALIFICACION as valor, a.DES_CALIFICACION as CALIFICACION, 1 AS DEFAUL'
        ||      ' FROM GE_CALIFICACION_TD a , GE_INDDEFAULT_TD b'
        ||      ' WHERE a.IND_VIGENCIA = S'
        ||      ' and b.NOM_TABLA = GE_CALIFICACION_TD'
        ||      ' AND A.COD_CALIFICACION  = B.COD_DEFAULT'
        ||      ' UNION'
        ||      ' SELECT a.COD_CALIFICACION as valor, a.DES_CALIFICACION as CALIFICACION, 0 AS DEFAUL'
        ||      ' FROM GE_CALIFICACION_TD a , GE_INDDEFAULT_TD b'
        ||      ' WHERE a.IND_VIGENCIA = S'
        ||      ' and b.NOM_TABLA = GE_CALIFICACION_TD'
        ||      ' AND A.COD_CALIFICACION  <> B.COD_DEFAULT';



        OPEN SC_CURSORDATOS FOR
        SELECT a.COD_CALIFICACION as valor, a.DES_CALIFICACION as CALIFICACION , 1 AS DEFAUL
        FROM GE_CALIFICACION_TD a , GE_INDDEFAULT_TD b
        WHERE a.IND_VIGENCIA = 'S'
        and b.NOM_TABLA = 'GE_CALIFICACION_TD'
        AND A.COD_CALIFICACION  = B.COD_DEFAULT
        UNION
        SELECT a.COD_CALIFICACION as valor, a.DES_CALIFICACION as color, 0 AS DEFAUL
        FROM GE_CALIFICACION_TD a , GE_INDDEFAULT_TD b
        WHERE a.IND_VIGENCIA = 'S'
        and b.NOM_TABLA = 'GE_CALIFICACION_TD'
        AND A.COD_CALIFICACION  <> B.COD_DEFAULT;


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListCalificacion1_PR ;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListCalificacion1_PR ', LV_Sql, SQLCODE, LV_desError );
    END VE_getListCalificacion1_PR ;


    PROCEDURE VE_getListClasificaciones_PR (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                               SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_SQL:='SELECT COD_ELEMENTO, DES_ELEMENTO, IND_ACTIVO, IND_VISIBLE'
        ||      ' FROM VE_ELEMENTOS_ACTIVOS_TD';

        OPEN SC_CURSORDATOS FOR
        SELECT COD_ELEMENTO, DES_ELEMENTO, IND_ACTIVO, IND_VISIBLE
        FROM VE_ELEMENTOS_ACTIVOS_TD;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListClasificaciones_PR ;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListClasificaciones_PR ', LV_Sql, SQLCODE, LV_desError );
    END VE_getListClasificaciones_PR ;
    PROCEDURE VE_getListCategoriaCambio_PR (SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                        SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

        NO_DATA_FOUND_CURSOR EXCEPTION;
        LV_desError  ge_errores_pg.desevent;
        LV_sql         ge_errores_pg.vquery;
        LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_SQL:='SELECT COD_CATEGORIA_CAMBIO, DES_CATEGORIA_CAMBIO FROM FA_TASA_CAMBIO_TD';

        OPEN SC_CURSORDATOS FOR
        SELECT COD_CATEGORIA_CAMBIO, DES_CATEGORIA_CAMBIO FROM FA_TASA_CAMBIO_TD
        WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

      EXCEPTION
                   WHEN OTHERS THEN
                        SN_codRetorno := 156;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                           SV_menRetorno := CV_ERRORNOCLASIF;
                        END IF;
                        LV_desError  := 'OTHERS:VE_getListCategoriaCambio_PR ;- ' || SQLERRM;
                        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                        'VE_getListCategoriaCambio_PR ', LV_Sql, SQLCODE, LV_desError );
      END VE_getListCategoriaCambio_PR ;

PROCEDURE VE_insCategCambioCliente_PR
                                  (EN_cod_cliente     IN  GE_CLIENTE_TASA_TO.COD_CLIENTE%TYPE,
                                   EN_cod_categoria   IN  GE_CLIENTE_TASA_TO.COD_CATEGORIA_CAMBIO%TYPE,
                                   EV_NomUsuario      IN  GE_CLIENTE_TASA_TO.NOM_USUARIO%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CodError,
                                   SV_menRetorno       OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.Evento) IS

        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO GE_CLIENTE_TASA_TO(cod_cliente, '
             || 'cod_categoria_cambio, '
             || 'fec_modific, '
             || 'nom_usuario) '
             || 'VALUES (' || EN_cod_cliente || ', '
             || EN_cod_categoria || ','
             || ',SYSDATE,'
             || EV_NomUsuario
             ||')';

        INSERT INTO GE_CLIENTE_TASA_TO(COD_CLIENTE,
                                       COD_CATEGORIA_CAMBIO,
                                       FEC_MODIFIC,
                                       NOM_USUARIO)
        VALUES (EN_cod_cliente,
                EN_cod_categoria,
                SYSDATE,
                EV_NomUsuario);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insCategCambioCliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insCategCambioCliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insCategCambioCliente_PR;

PROCEDURE VE_updIngresosMensuales_PR(EN_codCliente  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                     EN_impIngresos IN  GE_CLIENTES.IMP_INGRESOS%TYPE,
                                     SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento   OUT NOCOPY ge_errores_pg.Evento) IS

        LV_desError ge_errores_pg.desevent;
        LV_sql        ge_errores_pg.vquery;
        LV_error          VARCHAR(256);
        LE_fin EXCEPTION;
    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='UPDATE ge_clientes '
             || 'SET imp_ingresos = ' || EN_impIngresos
             || 'WHERE cod_cliente = ' || EN_codCliente;

        UPDATE ge_clientes
        SET imp_ingresos = EN_impIngresos
        WHERE cod_cliente = EN_codCliente;

    EXCEPTION
             WHEN LE_fin THEN
                 SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updIngresosMensuales_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updIngresosMensuales_PR', LV_Sql, SQLCODE, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_updIngresosMensuales_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_updIngresosMensuales_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_updIngresosMensuales_PR;

--Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
PROCEDURE VE_insRedSocial_PR(EN_cod_cliente     IN  VE_RED_SOCIAL_TO.COD_CLIENTE%TYPE,
                             EV_des_facebook    IN  VE_RED_SOCIAL_TO.DES_CUENTA_FACEBOOK%TYPE,
                             EV_des_twitter     IN  VE_RED_SOCIAL_TO.DES_CUENTA_TWITTER%TYPE,
                             SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                             SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                             SN_numEvento       OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO VE_RED_SOCIAL_TO(COD_CLIENTE,'
             || ' DES_CUENTA_FACEBOOK,'
             || ' DES_CUENTA_TWITTER) '
             || ' VALUES ('||EN_cod_cliente||','
             || ''||EV_des_facebook||','
             || ''||EV_des_twitter||')';


        INSERT INTO VE_RED_SOCIAL_TO(COD_CLIENTE,
                                     DES_CUENTA_FACEBOOK,
                                     DES_CUENTA_TWITTER)
        VALUES (EN_cod_cliente,
                EV_des_facebook,
                EV_des_twitter);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insRedSocial_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insRedSocial_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insRedSocial_PR;

PROCEDURE VE_insEnvFacturFisi_PR(EN_cod_cliente     IN  GA_VALOR_CLI.COD_CLIENTE%TYPE,
                                 SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                 SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_numEvento       OUT NOCOPY ge_errores_pg.Evento,
                    --INICIO INC 185493
                                    EN_Cod_valor       IN  GA_VALOR_CLI.COD_VALOR%TYPE DEFAULT NULL) IS
                    --FIN INC 185493  ) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;
    LV_codValor VARCHAR(2000);

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;
        
        IF    EN_Cod_valor IS NOT NULL THEN
            IF    EN_Cod_valor = '0' THEN
            
                LV_codValor :='NO';
                
            ELSIF EN_Cod_valor = '1' THEN
                LV_codValor :='SI';
            END IF;

        ELSE
             LV_codValor :='SI';
        END IF;
        
        
        
        LV_Sql:='INSERT INTO GA_VALOR_CLI(COD_CLIENTE,'
             || ' COD_VALOR) '
             || ' VALUES ('||EN_cod_cliente||','||LV_codValor||')';

        INSERT INTO GA_VALOR_CLI(COD_CLIENTE,
                                 COD_VALOR)
        VALUES (EN_cod_cliente,
                LV_codValor);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insEnvFacturFisi_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insEnvFacturFisi_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insEnvFacturFisi_PR;

PROCEDURE VE_getListDirecPre_PR(EN_codDireccion IN GE_DIRECCIONES.COD_DIRECCION%TYPE,
                                SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

    NO_DATA_FOUND_CURSOR EXCEPTION;
    LV_desError  ge_errores_pg.desevent;
    LV_sql         ge_errores_pg.vquery;
    LN_contador  NUMBER;
     BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_comuna, a.cod_tipocalle, a.nom_calle, a.num_calle,'
                 || '   a.obs_direccion, a.zip, a.des_direc1, a.des_direc2, b.des_region, c.des_provincia, d.des_ciudad,'
                 || '   e.des_comuna, f.descripcion_valor '
             || 'FROM   ge_direcciones a, ge_regiones b, ge_provincias c, ge_ciudades d, ge_comunas e, ge_tipos_calles_vw f '
             || 'WHERE  a.cod_direccion = '||EN_codDireccion||' '
             || 'AND    a.cod_region = b.cod_region '
             || 'AND    a.cod_region = c.cod_region '
             || 'AND    b.cod_region = c.cod_region '
             || 'AND    a.cod_provincia = c.cod_provincia '
             || 'AND    a.cod_region = d.cod_region '
             || 'AND    b.cod_region = d.cod_region '
             || 'AND    c.cod_region = d.cod_region '
             || 'AND    a.cod_provincia = d.cod_provincia '
             || 'AND    c.cod_provincia = d.cod_provincia '
             || 'AND    a.cod_ciudad = d.cod_ciudad '
             || 'AND    a.cod_region = e.cod_region '
             || 'AND    b.cod_region = e.cod_region '
             || 'AND    c.cod_region = e.cod_region '
             || 'AND    a.cod_provincia = e.cod_provincia '
             || 'AND    c.cod_provincia = e.cod_provincia '
             || 'AND    a.cod_comuna = e.cod_comuna '
             || 'AND    a.cod_tipocalle = f.valor(+)';

        LN_contador := 0;

        SELECT COUNT(1)
        INTO   LN_contador
        FROM   ge_direcciones a, ge_regiones b, ge_provincias c, ge_ciudades d, ge_comunas e, ge_tipos_calles_vw f
        WHERE  a.cod_direccion = EN_codDireccion
        AND    a.cod_region = b.cod_region
        AND    a.cod_region = c.cod_region
        AND    b.cod_region = c.cod_region
        AND    a.cod_provincia = c.cod_provincia
        AND    a.cod_region = d.cod_region
        AND    b.cod_region = d.cod_region
        AND    c.cod_region = d.cod_region
        AND    a.cod_provincia = d.cod_provincia
        AND    c.cod_provincia = d.cod_provincia
        AND    a.cod_ciudad = d.cod_ciudad
        AND    a.cod_region = e.cod_region
        AND    b.cod_region = e.cod_region
        AND    c.cod_region = e.cod_region
        AND    a.cod_provincia = e.cod_provincia
        AND    c.cod_provincia = e.cod_provincia
        AND    a.cod_comuna = e.cod_comuna
        AND    a.cod_tipocalle = f.valor(+);

        OPEN SC_cursorDatos FOR
        SELECT a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_comuna, a.cod_tipocalle, a.nom_calle, a.num_calle,
               a.obs_direccion, a.zip, a.des_direc1, a.des_direc2, b.des_region, c.des_provincia, d.des_ciudad,
               e.des_comuna, f.descripcion_valor
        FROM   ge_direcciones a, ge_regiones b, ge_provincias c, ge_ciudades d, ge_comunas e, ge_tipos_calles_vw f
        WHERE  a.cod_direccion = EN_codDireccion
        AND    a.cod_region = b.cod_region
        AND    a.cod_region = c.cod_region
        AND    b.cod_region = c.cod_region
        AND    a.cod_provincia = c.cod_provincia
        AND    a.cod_region = d.cod_region
        AND    b.cod_region = d.cod_region
        AND    c.cod_region = d.cod_region
        AND    a.cod_provincia = d.cod_provincia
        AND    c.cod_provincia = d.cod_provincia
        AND    a.cod_ciudad = d.cod_ciudad
        AND    a.cod_region = e.cod_region
        AND    b.cod_region = e.cod_region
        AND    c.cod_region = e.cod_region
        AND    a.cod_provincia = e.cod_provincia
        AND    c.cod_provincia = e.cod_provincia
        AND    a.cod_comuna = e.cod_comuna
        AND    a.cod_tipocalle = f.valor(+);

        IF (LN_contador = 0) THEN
            RAISE NO_DATA_FOUND_CURSOR;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND_CURSOR THEN
                 SN_codRetorno:=1;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                 END IF;
                 LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_alta_cliente_PG.VE_getListDirecPre_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                 SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_alta_cliente_PG.VE_getListDirecPre_PR', LV_Sql, SN_codRetorno, LV_desError );
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_getListDirecPre_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_getListDirecPre_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_getListDirecPre_PR;
--Fin P-CSR-11002 JLGN 26-04-2011
--Inicio P-CSR-11002 JLGN 05-05-2011
PROCEDURE VE_insClienteBuro_PR( EV_keyRef                  IN VE_CLIENTE_BURO_TO.COD_REFERENCIA%TYPE,
                                EV_nombre                  IN VE_CLIENTE_BURO_TO.NOMBRE_CLIENTE%TYPE,
                                EV_apellido1               IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CLIENTE%TYPE,
                                EV_apellido2               IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CLIENTE%TYPE,
                                EV_numeroCedula            IN VE_CLIENTE_BURO_TO.NUM_CEDULA_CLIENTE%TYPE,
                                EV_fallecido               IN VE_CLIENTE_BURO_TO.FALLECIDO%TYPE,
                                EV_codFallecido            IN VE_CLIENTE_BURO_TO.COD_FALLECIDO%TYPE,
                                EV_esPEP                   IN VE_CLIENTE_BURO_TO.COD_PEP%TYPE,
                                EV_institucionPEP          IN VE_CLIENTE_BURO_TO.INSTITUCION_PEP%TYPE,
                                EV_cargoPEP                IN VE_CLIENTE_BURO_TO.CARGO_PEP%TYPE,
                                EV_periodoPEP              IN VE_CLIENTE_BURO_TO.PERIODO_PEP%TYPE,
                                EV_fechaVencimientoCedula  IN VE_CLIENTE_BURO_TO.FEC_VENCIMIENTO_CEDULA%TYPE,
                                EV_sexo                    IN VE_CLIENTE_BURO_TO.SEXO%TYPE,
                                EV_fechaNacimiento         IN VE_CLIENTE_BURO_TO.FEC_NACIMIENTO%TYPE,
                                EV_paisNacimiento          IN VE_CLIENTE_BURO_TO.PAIS_NACIMIENTO%TYPE,
                                EV_codPaisNacimiento       IN VE_CLIENTE_BURO_TO.COD_PAIS_NACIMIENTO%TYPE,
                                EV_ciudadNacimiento        IN VE_CLIENTE_BURO_TO.CIUDAD_NACIMIENTO%TYPE,
                                EV_codCiudadNacimiento     IN VE_CLIENTE_BURO_TO.COD_CIUDAD_NACIMIENTO%TYPE,
                                EV_edad                    IN VE_CLIENTE_BURO_TO.EDAD%TYPE,
                                EV_estadoCivil             IN VE_CLIENTE_BURO_TO.ESTADO_CIVIL%TYPE,
                                EV_codEstadoCivil          IN VE_CLIENTE_BURO_TO.COD_ESTADO_CIVIL%TYPE,
                                EV_cantidadEventos         IN VE_CLIENTE_BURO_TO.CANTIDAD_EVENTOS%TYPE,
                                EV_codProvincia            IN VE_CLIENTE_BURO_TO.COD_PROVINCIA%TYPE,
                                EV_codCanton               IN VE_CLIENTE_BURO_TO.COD_CANTON%TYPE,
                                EV_codDistrito             IN VE_CLIENTE_BURO_TO.COD_DISTRITO%TYPE,
                                EV_bloqueo                 IN VE_CLIENTE_BURO_TO.BLOQUEO%TYPE,
                                EV_codigoBloqueo           IN VE_CLIENTE_BURO_TO.COD_BLOQUEO%TYPE,
                                EV_desDireccion            IN VE_CLIENTE_BURO_TO.DES_DIRECCION%TYPE,
                                EV_fechaVencimiento        IN VE_CLIENTE_BURO_TO.FEC_VENCIMIENTO_EMPRESA%TYPE,
                                EV_tomo                    IN VE_CLIENTE_BURO_TO.TOMO%TYPE,
                                EV_folio                   IN VE_CLIENTE_BURO_TO.FOLIO%TYPE,
                                EV_asiento                 IN VE_CLIENTE_BURO_TO.ASIENTO%TYPE,
                                EV_clasificacion           IN VE_CLIENTE_BURO_TO.CLASIFICACION_EMPRESA%TYPE,
                                EV_actividad               IN VE_CLIENTE_BURO_TO.ACTIVIDAD_EMPRESA%TYPE,
                                EV_telefono                IN VE_CLIENTE_BURO_TO.NUM_TELEFONO%TYPE,
                                EV_personeriaSociedad      IN VE_CLIENTE_BURO_TO.PERSONERIA_SOCIEDAD%TYPE,
                                EV_domicilio               IN VE_CLIENTE_BURO_TO.DOMICILIO%TYPE,
                                EV_representacion          IN VE_CLIENTE_BURO_TO.REPRESENTACION%TYPE,
                                EV_celular                   IN VE_CLIENTE_BURO_TO.NUM_CELULAR%TYPE,
                                EV_tipProducto             IN VE_CLIENTE_BURO_TO.TIP_PRODUCTO%TYPE,
                                EV_tipSegmento             IN VE_CLIENTE_BURO_TO.TIP_SEGMENTO%TYPE,
                                EV_datosGenerales          IN VE_CLIENTE_BURO_TO.DATOS_GENERALES%TYPE,
                                EV_laboral                 IN VE_CLIENTE_BURO_TO.LABORAL%TYPE,
                                EV_histConsulta            IN VE_CLIENTE_BURO_TO.HIST_CONSULTA%TYPE,
                                EV_RefCredito              IN VE_CLIENTE_BURO_TO.REF_CREDITO%TYPE,
                                EV_libEntradaHistorico     IN VE_CLIENTE_BURO_TO.LIB_ENTRADA_HIST%TYPE,
                                EV_libEntradaActivo        IN VE_CLIENTE_BURO_TO.LIB_ENTRADA_ACT%TYPE,
                                EV_resulCalificacion       IN VE_CLIENTE_BURO_TO.RESUL_CALIFICACION%TYPE,
                                EV_codInterno              IN VE_CLIENTE_BURO_TO.COD_INTERNO%TYPE,
                                EV_nombreTrabajo           IN VE_CLIENTE_BURO_TO.NOMBRE_TRABAJO%TYPE,
                                EV_nombreComercial         IN VE_CLIENTE_BURO_TO.NOMBRE_COMERCIAL%TYPE,
                                EV_provinciaPatrono        IN VE_CLIENTE_BURO_TO.PROVINCIA_PATRONO%TYPE,
                                EV_cantonPatrono           IN VE_CLIENTE_BURO_TO.CANTON_PATRONO%TYPE,
                                EV_distritoPatrono         IN VE_CLIENTE_BURO_TO.DISTRITO_PATRONO%TYPE,
                                EV_codTipPatrono           IN VE_CLIENTE_BURO_TO.COD_TIP_PATRONO%TYPE,
                                EV_cedulaTrabajo           IN VE_CLIENTE_BURO_TO.CEDULA_TRABAJO%TYPE,
                                EV_finesTrabajo            IN VE_CLIENTE_BURO_TO.FINES_TRABAJO%TYPE,
                                EV_ocupacion               IN VE_CLIENTE_BURO_TO.OCUPACION%TYPE,
                                EV_codOcupacion            IN VE_CLIENTE_BURO_TO.COD_OCUPACION%TYPE,
                                EV_salario                 IN VE_CLIENTE_BURO_TO.SALARIO%TYPE,
                                EV_prom3Meses              IN VE_CLIENTE_BURO_TO.SALAR_PROM_TRES_MESES%TYPE,
                                EV_prom6Meses              IN VE_CLIENTE_BURO_TO.SALAR_PROM_SEIS_MESES%TYPE,
                                EV_prom12Meses             IN VE_CLIENTE_BURO_TO.SALAR_PROM_DOCE_MESES%TYPE,
                                EV_fechaRegistro           IN VE_CLIENTE_BURO_TO.FEC_REGISTRO%TYPE,
                                EV_tiempoLaboral           IN VE_CLIENTE_BURO_TO.TIEMPO_LABORAL%TYPE,
                                EV_mesesLaboral            IN VE_CLIENTE_BURO_TO.MESES_LABORAL%TYPE,
                                EV_montoDeuda              IN VE_CLIENTE_BURO_TO.MONTO_DEUDA%TYPE,
                                EV_numCuotas               IN VE_CLIENTE_BURO_TO.NUM_CUOTAS%TYPE,
                                EV_desDirecTrabajo         IN VE_CLIENTE_BURO_TO.DES_DIREC_TRABAJO%TYPE,
                                EV_centralTelefonica       IN VE_CLIENTE_BURO_TO.CENTRAL_TELEFONICA%TYPE,
                                EV_nombreConyuge           IN VE_CLIENTE_BURO_TO.NOMBRE_CONYUGE%TYPE,
                                EV_apellido1Conyuge        IN VE_CLIENTE_BURO_TO.APELLIDO_PATERNO_CONYUGE%TYPE,
                                EV_apellido2Conyuge        IN VE_CLIENTE_BURO_TO.APELLIDO_MATERNO_CONYUGE%TYPE,
                                EV_nombreCompletoConyuge   IN VE_CLIENTE_BURO_TO.NOMBRE_COMPLETO_CONYUGE%TYPE,
                                EV_fallecidoConyuge        IN VE_CLIENTE_BURO_TO.FALLECIDO_CONYUGE%TYPE,
                                EV_codFallecidoConyuge     IN VE_CLIENTE_BURO_TO.COD_FALLECIDO_CONYUGE%TYPE,
                                EV_cedulaConyuge           IN VE_CLIENTE_BURO_TO.NUM_CEDULA_CONYUGE%TYPE,
                                EV_nomRelacion             IN VE_CLIENTE_BURO_TO.NOM_RELACION%TYPE,
                                EV_codRelacion             IN VE_CLIENTE_BURO_TO.COD_RELACION%TYPE,
                                EV_laboraConyuge           IN VE_CLIENTE_BURO_TO.LABORA_CONYUGE%TYPE,
                                EV_nombreMadre             IN VE_CLIENTE_BURO_TO.NOMBRE_MADRE%TYPE,
                                EV_codParentescoMadre      IN VE_CLIENTE_BURO_TO.COD_PARENTESCO_MADRE%TYPE,
                                EV_fallecidaMadre          IN VE_CLIENTE_BURO_TO.FALLECIDA_MADRE%TYPE,
                                EV_codFallecidaMadre       IN VE_CLIENTE_BURO_TO.COD_FALLECIDA_MADRE%TYPE,
                                EV_cedulaMadre             IN VE_CLIENTE_BURO_TO.NUM_CEDULA_MADRE%TYPE,
                                EV_nombrePadre             IN VE_CLIENTE_BURO_TO.NOMBRE_PADRE%TYPE,
                                EV_codParentescoPadre      IN VE_CLIENTE_BURO_TO.COD_PARENTESCO_PADRE%TYPE,
                                EV_fallecidaPadre          IN VE_CLIENTE_BURO_TO.FALLECIDO_PADRE%TYPE,
                                EV_codFallecidaPadre       IN VE_CLIENTE_BURO_TO.COD_FALLECIDO_PADRE%TYPE,
                                EV_cedulaPadre               IN VE_CLIENTE_BURO_TO.NUM_CEDULA_PADRE%TYPE,
                                EV_nombreSociedad          IN VE_CLIENTE_BURO_TO.NOMBRE_SOCIEDAD%TYPE,
                                EV_cedulaSociedad          IN VE_CLIENTE_BURO_TO.NUM_CEDULA_SOCIEDAD%TYPE,
                                EV_puestoSociedad          IN VE_CLIENTE_BURO_TO.PUESTO_SOCIEDAD%TYPE,
                                EV_fechaConsultadaSociedad IN VE_CLIENTE_BURO_TO.FECHA_CONSULTADA_SOCIEDAD%TYPE,
                                EV_limiteConsumo           IN VE_CLIENTE_BURO_TO.LIMITE_CONSUMO%TYPE,
                                EV_razonSocial             IN VE_CLIENTE_BURO_TO.RAZON_SOCIAL%TYPE,
                                EV_usuario                 IN VE_CLIENTE_BURO_TO.NOM_USUARIO%TYPE,
                                SN_codRetorno              OUT NOCOPY ge_errores_pg.CodError,
                                SV_menRetorno              OUT NOCOPY ge_errores_pg.MsgError,
                                SN_numEvento               OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO '
             || 'VE_CLIENTE_BURO_TO(COD_REFERENCIA, NOMBRE_CLIENTE, APELLIDO_PATERNO_CLIENTE, APELLIDO_MATERNO_CLIENTE, NUM_CEDULA_CLIENTE, FALLECIDO,'
                                || 'COD_FALLECIDO, COD_PEP, INSTITUCION_PEP, CARGO_PEP, PERIODO_PEP, FEC_VENCIMIENTO_CEDULA, SEXO, FEC_NACIMIENTO, PAIS_NACIMIENTO,'
                                || 'COD_PAIS_NACIMIENTO, CIUDAD_NACIMIENTO, COD_CIUDAD_NACIMIENTO, EDAD, ESTADO_CIVIL, COD_ESTADO_CIVIL, CANTIDAD_EVENTOS, '
                                || 'COD_PROVINCIA, COD_CANTON, COD_DISTRITO, BLOQUEO, COD_BLOQUEO, DES_DIRECCION, NUM_CELULAR, FEC_VENCIMIENTO_EMPRESA, TOMO, FOLIO,'
                                || 'ASIENTO, CLASIFICACION_EMPRESA, ACTIVIDAD_EMPRESA, NUM_TELEFONO, PERSONERIA_SOCIEDAD, DOMICILIO, REPRESENTACION, TIP_PRODUCTO, '
                                || 'TIP_SEGMENTO, DATOS_GENERALES, LABORAL, HIST_CONSULTA, REF_CREDITO, LIB_ENTRADA_HIST, LIB_ENTRADA_ACT, RESUL_CALIFICACION, '
                                || 'COD_INTERNO, NOMBRE_TRABAJO, NOMBRE_COMERCIAL, PROVINCIA_PATRONO, CANTON_PATRONO, DISTRITO_PATRONO, COD_TIP_PATRONO, '
                                || 'CEDULA_TRABAJO, FINES_TRABAJO, OCUPACION, COD_OCUPACION, SALARIO, SALAR_PROM_TRES_MESES, SALAR_PROM_SEIS_MESES, '
                                || 'SALAR_PROM_DOCE_MESES, FEC_REGISTRO, TIEMPO_LABORAL, MESES_LABORAL, MONTO_DEUDA, NUM_CUOTAS, DES_DIREC_TRABAJO, CENTRAL_TELEFONICA,'
                                || 'NOMBRE_CONYUGE, APELLIDO_PATERNO_CONYUGE, APELLIDO_MATERNO_CONYUGE, NOMBRE_COMPLETO_CONYUGE, FALLECIDO_CONYUGE, '
                                || 'COD_FALLECIDO_CONYUGE, NUM_CEDULA_CONYUGE, NOM_RELACION, COD_RELACION, LABORA_CONYUGE, NOMBRE_MADRE, COD_PARENTESCO_MADRE,'
                                || 'FALLECIDA_MADRE, COD_FALLECIDA_MADRE, NUM_CEDULA_MADRE, NOMBRE_PADRE, COD_PARENTESCO_PADRE, FALLECIDO_PADRE, COD_FALLECIDO_PADRE,'
                                --Inicio Incidencia 179734 JLGN 13-02-2012
                                --|| 'NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL)'
                                --Fin Incidencia 179734 JLGN 13-02-2012
                                --Inicio MA 184592 JLGN 15-05-2012
                                --|| 'NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL, FECHA_CONSULTA_BURO)'
                                --Fin MA 184592 JLGN 15-05-2012
                                || 'NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL, FECHA_CONSULTA_BURO, NOM_USUARIO, FEC_INGRESO)'
             || 'VALUES('||EV_keyRef||','|| EV_nombre||','|| EV_apellido1||','|| EV_apellido2||','|| EV_numeroCedula||','|| EV_fallecido||','
                    || EV_codFallecido||','|| EV_esPEP||','|| EV_institucionPEP||','|| EV_cargoPEP||','|| EV_periodoPEP||','|| EV_fechaVencimientoCedula||','|| EV_sexo||','|| EV_fechaNacimiento||','|| EV_paisNacimiento||','
                    || EV_codPaisNacimiento||','|| EV_ciudadNacimiento||','|| EV_codCiudadNacimiento||','|| EV_edad||','|| EV_estadoCivil||','|| EV_codEstadoCivil||','|| EV_cantidadEventos||','
                    || EV_codProvincia||','|| EV_codCanton||','|| EV_codDistrito||','|| EV_bloqueo||','|| EV_codigoBloqueo||','|| EV_desDireccion||','|| EV_celular||','|| EV_fechaVencimiento||','|| EV_tomo||','|| EV_folio||','
                    || EV_asiento||','|| EV_clasificacion||','|| EV_actividad||','|| EV_telefono||','|| EV_personeriaSociedad||','|| EV_domicilio||','|| EV_representacion||','|| EV_tipProducto||','
                    || EV_tipSegmento||','|| EV_datosGenerales||','|| EV_laboral||','|| EV_histConsulta||','|| EV_RefCredito||','|| EV_libEntradaHistorico||','|| EV_libEntradaActivo||','|| EV_resulCalificacion||','
                    || EV_codInterno||','|| EV_nombreTrabajo||','|| EV_nombreComercial||','|| EV_provinciaPatrono||','|| EV_cantonPatrono||','|| EV_distritoPatrono||','|| EV_codTipPatrono||','
                    || EV_cedulaTrabajo||','|| EV_finesTrabajo||','|| EV_ocupacion||','|| EV_codOcupacion||','|| EV_salario||','|| EV_prom3Meses||','|| EV_prom6Meses||','
                    || EV_prom12Meses||','|| EV_fechaRegistro||','|| EV_tiempoLaboral||','|| EV_mesesLaboral||','|| EV_montoDeuda||','|| EV_numCuotas||','|| EV_desDirecTrabajo||','|| EV_centralTelefonica||','
                    || EV_nombreConyuge||','|| EV_apellido1Conyuge||','|| EV_apellido2Conyuge||','|| EV_nombreCompletoConyuge||','|| EV_fallecidoConyuge||','
                    || EV_codFallecidoConyuge||','|| EV_cedulaConyuge||','|| EV_nomRelacion||','|| EV_codRelacion||','|| EV_laboraConyuge||','|| EV_nombreMadre||','|| EV_codParentescoMadre||','
                    || EV_fallecidaMadre||','|| EV_codFallecidaMadre||','|| EV_cedulaMadre||','|| EV_nombrePadre||','|| EV_codParentescoPadre||','|| EV_fallecidaPadre||','|| EV_codFallecidaPadre||','
                    --Inicio Incidencia 179734 JLGN 13-02-2012
                    --|| EV_cedulaPadre||','|| EV_nombreSociedad||','|| EV_cedulaSociedad||','|| EV_puestoSociedad||','|| EV_fechaConsultadaSociedad||','||EV_limiteConsumo||','||EV_razonSocial||')';
                    --Fin Incidencia 179734 JLGN 13-02-2012
                    --Inicio MA 184592 JLGN 15-05-2012
                    --|| EV_cedulaPadre||','|| EV_nombreSociedad||','|| EV_cedulaSociedad||','|| EV_puestoSociedad||','|| EV_fechaConsultadaSociedad||','||EV_limiteConsumo||','||EV_razonSocial||','||SYSDATE||')';
                    || EV_cedulaPadre||','|| EV_nombreSociedad||','|| EV_cedulaSociedad||','|| EV_puestoSociedad||','|| EV_fechaConsultadaSociedad||','||EV_limiteConsumo||','||EV_razonSocial||','||SYSDATE||','||EV_usuario||','||SYSDATE||')';
                    --Fin MA 184592 JLGN 15-05-2012

        INSERT INTO
        VE_CLIENTE_BURO_TO(COD_REFERENCIA, NOMBRE_CLIENTE, APELLIDO_PATERNO_CLIENTE, APELLIDO_MATERNO_CLIENTE, NUM_CEDULA_CLIENTE, FALLECIDO,
                           COD_FALLECIDO, COD_PEP, INSTITUCION_PEP, CARGO_PEP, PERIODO_PEP, FEC_VENCIMIENTO_CEDULA, SEXO, FEC_NACIMIENTO, PAIS_NACIMIENTO,
                           COD_PAIS_NACIMIENTO, CIUDAD_NACIMIENTO, COD_CIUDAD_NACIMIENTO, EDAD, ESTADO_CIVIL, COD_ESTADO_CIVIL, CANTIDAD_EVENTOS,
                           COD_PROVINCIA, COD_CANTON, COD_DISTRITO, BLOQUEO, COD_BLOQUEO, DES_DIRECCION, NUM_CELULAR, FEC_VENCIMIENTO_EMPRESA, TOMO, FOLIO,
                           ASIENTO, CLASIFICACION_EMPRESA, ACTIVIDAD_EMPRESA, NUM_TELEFONO, PERSONERIA_SOCIEDAD, DOMICILIO, REPRESENTACION, TIP_PRODUCTO,
                           TIP_SEGMENTO, DATOS_GENERALES, LABORAL, HIST_CONSULTA, REF_CREDITO, LIB_ENTRADA_HIST, LIB_ENTRADA_ACT, RESUL_CALIFICACION,
                           COD_INTERNO, NOMBRE_TRABAJO, NOMBRE_COMERCIAL, PROVINCIA_PATRONO, CANTON_PATRONO, DISTRITO_PATRONO, COD_TIP_PATRONO,
                           CEDULA_TRABAJO, FINES_TRABAJO, OCUPACION, COD_OCUPACION, SALARIO, SALAR_PROM_TRES_MESES, SALAR_PROM_SEIS_MESES,
                           SALAR_PROM_DOCE_MESES, FEC_REGISTRO, TIEMPO_LABORAL, MESES_LABORAL, MONTO_DEUDA, NUM_CUOTAS, DES_DIREC_TRABAJO, CENTRAL_TELEFONICA,
                           NOMBRE_CONYUGE, APELLIDO_PATERNO_CONYUGE, APELLIDO_MATERNO_CONYUGE, NOMBRE_COMPLETO_CONYUGE, FALLECIDO_CONYUGE,
                           COD_FALLECIDO_CONYUGE, NUM_CEDULA_CONYUGE, NOM_RELACION, COD_RELACION, LABORA_CONYUGE, NOMBRE_MADRE, COD_PARENTESCO_MADRE,
                           FALLECIDA_MADRE, COD_FALLECIDA_MADRE, NUM_CEDULA_MADRE, NOMBRE_PADRE, COD_PARENTESCO_PADRE, FALLECIDO_PADRE, COD_FALLECIDO_PADRE,
                           --Inicio Incidencia 179734 JLGN 13-02-2012
                           --NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL)
                           --Fin Incidencia 179734 JLGN 13-02-2012
                           --Inicio MA 184592 JLGN 15-05-2012
                           --NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL, FECHA_CONSULTA_BURO)
                           --Fin MA 184592 JLGN 15-05-2012
                           NUM_CEDULA_PADRE, NOMBRE_SOCIEDAD, NUM_CEDULA_SOCIEDAD, PUESTO_SOCIEDAD, FECHA_CONSULTADA_SOCIEDAD, LIMITE_CONSUMO, RAZON_SOCIAL, FECHA_CONSULTA_BURO, NOM_USUARIO, FEC_INGRESO)
        VALUES(EV_keyRef, EV_nombre, EV_apellido1, EV_apellido2, EV_numeroCedula, EV_fallecido,
               EV_codFallecido, EV_esPEP, EV_institucionPEP, EV_cargoPEP, EV_periodoPEP, EV_fechaVencimientoCedula, EV_sexo, EV_fechaNacimiento, EV_paisNacimiento,
               EV_codPaisNacimiento, EV_ciudadNacimiento, EV_codCiudadNacimiento, EV_edad, EV_estadoCivil, EV_codEstadoCivil, EV_cantidadEventos,
               EV_codProvincia, EV_codCanton, EV_codDistrito, EV_bloqueo, EV_codigoBloqueo, EV_desDireccion, EV_celular, EV_fechaVencimiento, EV_tomo, EV_folio,
               EV_asiento, EV_clasificacion, EV_actividad, EV_telefono, EV_personeriaSociedad, EV_domicilio, EV_representacion, EV_tipProducto,
               EV_tipSegmento, EV_datosGenerales, EV_laboral, EV_histConsulta, EV_RefCredito, EV_libEntradaHistorico, EV_libEntradaActivo, EV_resulCalificacion,
               EV_codInterno, EV_nombreTrabajo, EV_nombreComercial, EV_provinciaPatrono, EV_cantonPatrono, EV_distritoPatrono, EV_codTipPatrono,
               EV_cedulaTrabajo, EV_finesTrabajo, EV_ocupacion, EV_codOcupacion, EV_salario, EV_prom3Meses, EV_prom6Meses,
               EV_prom12Meses, EV_fechaRegistro, EV_tiempoLaboral, EV_mesesLaboral, EV_montoDeuda, EV_numCuotas, EV_desDirecTrabajo, EV_centralTelefonica,
               EV_nombreConyuge, EV_apellido1Conyuge, EV_apellido2Conyuge, EV_nombreCompletoConyuge, EV_fallecidoConyuge,
               EV_codFallecidoConyuge, EV_cedulaConyuge, EV_nomRelacion, EV_codRelacion, EV_laboraConyuge, EV_nombreMadre, EV_codParentescoMadre,
               EV_fallecidaMadre, EV_codFallecidaMadre, EV_cedulaMadre, EV_nombrePadre, EV_codParentescoPadre, EV_fallecidaPadre, EV_codFallecidaPadre,
               --Inicio Incidencia 179734 JLGN 13-02-2012
               --EV_cedulaPadre, EV_nombreSociedad, EV_cedulaSociedad, EV_puestoSociedad, EV_fechaConsultadaSociedad, EV_limiteConsumo, EV_razonSocial);
               --Fin Incidencia 179734 JLGN 13-02-2012
               --Inicio MA 184592 JLGN 15-05-2012
               --EV_cedulaPadre, EV_nombreSociedad, EV_cedulaSociedad, EV_puestoSociedad, EV_fechaConsultadaSociedad, EV_limiteConsumo, EV_razonSocial, SYSDATE);
               --Fin MA 184592 JLGN 15-05-2012
               EV_cedulaPadre, EV_nombreSociedad, EV_cedulaSociedad, EV_puestoSociedad, EV_fechaConsultadaSociedad, EV_limiteConsumo, EV_razonSocial, SYSDATE, EV_usuario , SYSDATE);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insClienteBuro_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insClienteBuro_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insClienteBuro_PR;

    PROCEDURE VE_insNombramientoBuro_PR(EV_keyRef                   IN VE_NOMBRAMIENTO_BURO_TO.COD_REFERENCIA%TYPE,
                                        EV_tipNombramiento          IN VE_NOMBRAMIENTO_BURO_TO.TIP_NOMBRAMIENTO%TYPE,
                                        EV_nombreNombramiento       IN VE_NOMBRAMIENTO_BURO_TO.NOMBRE_NOMBRAMIENTO%TYPE,
                                        EV_apellido1Nombramiento    IN VE_NOMBRAMIENTO_BURO_TO.APELLIDO_PATERNO_NOMBRAMIENTO%TYPE,
                                        EV_apellido2Nombramiento    IN VE_NOMBRAMIENTO_BURO_TO.APELLIDO_MATERNO_NOMBRAMIENTO%TYPE,
                                        EV_tipIdentNombramiento     IN VE_NOMBRAMIENTO_BURO_TO.TIP_IDENT%TYPE,
                                        EV_numidentNombramiento     IN VE_NOMBRAMIENTO_BURO_TO.NUM_IDENT%TYPE,
                                        EV_nacionalidadNombramiento IN VE_NOMBRAMIENTO_BURO_TO.NACIONALIDAD%TYPE,
                                        EV_estadoCivilNombramiento  IN VE_NOMBRAMIENTO_BURO_TO.ESTADO_CIVIL%TYPE,
                                        EV_ocupacionNombramiento    IN VE_NOMBRAMIENTO_BURO_TO.OCUPACION%TYPE,
                                        EV_domicilioNombramiento    IN VE_NOMBRAMIENTO_BURO_TO.DOMICILIO%TYPE,
                                        EV_direccionOficina         IN VE_NOMBRAMIENTO_BURO_TO.DIRECCION_OFICINA%TYPE,
                                        SN_codRetorno               OUT NOCOPY ge_errores_pg.CodError,
                                        SV_menRetorno               OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_numEvento                OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO'
             || 'VE_NOMBRAMIENTO_BURO_TO(COD_REFERENCIA, TIP_NOMBRAMIENTO, NOMBRE_NOMBRAMIENTO, APELLIDO_PATERNO_NOMBRAMIENTO, APELLIDO_MATERNO_NOMBRAMIENTO,'
                                     || 'TIP_IDENT, NUM_IDENT, NACIONALIDAD, ESTADO_CIVIL, OCUPACION, DOMICILIO, DIRECCION_OFICINA)'
             || 'VALUES('||EV_keyRef||','|| EV_tipNombramiento||','|| EV_nombreNombramiento||','|| EV_apellido1Nombramiento||','|| EV_apellido2Nombramiento||','
                    || EV_tipIdentNombramiento||','|| EV_numidentNombramiento||','|| EV_nacionalidadNombramiento||','|| EV_estadoCivilNombramiento||','|| EV_ocupacionNombramiento||','
                    || EV_domicilioNombramiento||','|| EV_direccionOficina||')';


        INSERT INTO
        VE_NOMBRAMIENTO_BURO_TO(COD_REFERENCIA, TIP_NOMBRAMIENTO, NOMBRE_NOMBRAMIENTO, APELLIDO_PATERNO_NOMBRAMIENTO, APELLIDO_MATERNO_NOMBRAMIENTO,
                                TIP_IDENT, NUM_IDENT, NACIONALIDAD, ESTADO_CIVIL, OCUPACION, DOMICILIO, DIRECCION_OFICINA)
        VALUES(EV_keyRef, EV_tipNombramiento, EV_nombreNombramiento, EV_apellido1Nombramiento, EV_apellido2Nombramiento,
               EV_tipIdentNombramiento, EV_numidentNombramiento, EV_nacionalidadNombramiento, EV_estadoCivilNombramiento, EV_ocupacionNombramiento,
               EV_domicilioNombramiento, EV_direccionOficina);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_insNombramientoBuro_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_insNombramientoBuro_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_insNombramientoBuro_PR;

    PROCEDURE VE_histLabBuro_PR(EV_keyRef             IN VE_HISTORICO_LABORAL_BURO_TO.COD_REFERENCIA%TYPE,
                                EV_cedulaHist         IN VE_HISTORICO_LABORAL_BURO_TO.CEDULA%TYPE,
                                EV_codTipPatronoHist  IN VE_HISTORICO_LABORAL_BURO_TO.COD_TIP_PATRONO%TYPE,
                                EV_nombreHist         IN VE_HISTORICO_LABORAL_BURO_TO.NOMBRE_PATRONO%TYPE,
                                EV_fecInicioHist      IN VE_HISTORICO_LABORAL_BURO_TO.FEC_INICIO%TYPE,
                                EV_fecCompInicioHist  IN VE_HISTORICO_LABORAL_BURO_TO.FEC_COMPLETA_INICIO%TYPE,
                                EV_fecFinHist         IN VE_HISTORICO_LABORAL_BURO_TO.FEC_FIN%TYPE,
                                EV_fecCompFinHist     IN VE_HISTORICO_LABORAL_BURO_TO.FEC_COMPLETA_FIN%TYPE,
                                EV_mesesLaboradosHist IN VE_HISTORICO_LABORAL_BURO_TO.MESES_LABORADOS%TYPE,
                                SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                                SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                                SN_numEvento          OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO '
             || 'VE_HISTORICO_LABORAL_BURO_TO (COD_REFERENCIA, COD_TIP_PATRONO, NOMBRE_PATRONO, FEC_INICIO, FEC_COMPLETA_INICIO,'
                                           || 'FEC_FIN, FEC_COMPLETA_FIN, MESES_LABORADOS, CEDULA)'
             || 'VALUES('||EV_keyRef||','|| EV_codTipPatronoHist||','|| EV_nombreHist||','|| EV_fecInicioHist||','|| EV_fecCompInicioHist||','
                         ||EV_fecFinHist||','|| EV_fecCompFinHist||','|| EV_mesesLaboradosHist||','|| EV_cedulaHist||')';

        INSERT INTO
        VE_HISTORICO_LABORAL_BURO_TO (COD_REFERENCIA, COD_TIP_PATRONO, NOMBRE_PATRONO, FEC_INICIO, FEC_COMPLETA_INICIO,
                                      FEC_FIN, FEC_COMPLETA_FIN, MESES_LABORADOS, CEDULA)
        VALUES(EV_keyRef, EV_codTipPatronoHist, EV_nombreHist, EV_fecInicioHist, EV_fecCompInicioHist,
               EV_fecFinHist, EV_fecCompFinHist, EV_mesesLaboradosHist, EV_cedulaHist);

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_histLabBuro_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_histLabBuro_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_histLabBuro_PR;

    PROCEDURE VE_hijosClienteBuro_PR(EV_keyRef             IN VE_HIJOS_CLIENTE_BURO_TO.COD_REFERENCIA%TYPE,
                                     EV_nombreHijo         IN VE_HIJOS_CLIENTE_BURO_TO.NOMBRE_HIJO%TYPE,
                                     EV_nombreCompletoHijo IN VE_HIJOS_CLIENTE_BURO_TO.NOMBRE_COMPLETO_HIJO%TYPE,
                                     EV_apellido1Hijo      IN VE_HIJOS_CLIENTE_BURO_TO.APELLIDO_PATERNO%TYPE,
                                     EV_apellido2Hijo      IN VE_HIJOS_CLIENTE_BURO_TO.APELLIDO_MATERNO%TYPE,
                                     EV_codParentesco      IN VE_HIJOS_CLIENTE_BURO_TO.COD_PARENTESCO%TYPE,
                                     EV_cedulaHijo         IN VE_HIJOS_CLIENTE_BURO_TO.NUM_CEDULA_HIJO%TYPE,
                                     EV_fallecidoHijo      IN VE_HIJOS_CLIENTE_BURO_TO.FALLECIDO%TYPE,
                                     EV_codFallecidoHijo   IN VE_HIJOS_CLIENTE_BURO_TO.COD_FALLECIDO%TYPE,
                                     EV_edadHijo           IN VE_HIJOS_CLIENTE_BURO_TO.EDAD_HIJO%TYPE,
                                     EV_fecNacimientoHijo  IN VE_HIJOS_CLIENTE_BURO_TO.FECHA_NACIMIENTO%TYPE,
                                     EV_sexoHijo           IN VE_HIJOS_CLIENTE_BURO_TO.SEXO_HIJO%TYPE,
                                     SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento          OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO '
             || 'VE_HIJOS_CLIENTE_BURO_TO (COD_REFERENCIA, NOMBRE_HIJO, NOMBRE_COMPLETO_HIJO, APELLIDO_PATERNO, APELLIDO_MATERNO, COD_PARENTESCO,'
                                      || ' NUM_CEDULA_HIJO, FALLECIDO, COD_FALLECIDO, EDAD_HIJO, FECHA_NACIMIENTO, SEXO_HIJO)'
             || 'VALUES('||EV_keyRef||','|| EV_nombreHijo||','|| EV_nombreCompletoHijo||','|| EV_apellido1Hijo||','|| EV_apellido2Hijo||','|| EV_codParentesco||','
                    ||EV_cedulaHijo||','|| EV_fallecidoHijo||','|| EV_codFallecidoHijo||','|| EV_edadHijo||','|| EV_fecNacimientoHijo||','|| EV_sexoHijo||')';

        INSERT INTO
        VE_HIJOS_CLIENTE_BURO_TO (COD_REFERENCIA, NOMBRE_HIJO, NOMBRE_COMPLETO_HIJO, APELLIDO_PATERNO, APELLIDO_MATERNO, COD_PARENTESCO,
                                  NUM_CEDULA_HIJO, FALLECIDO, COD_FALLECIDO, EDAD_HIJO, FECHA_NACIMIENTO, SEXO_HIJO)
        VALUES(EV_keyRef, EV_nombreHijo, EV_nombreCompletoHijo, EV_apellido1Hijo, EV_apellido2Hijo, EV_codParentesco,
               EV_cedulaHijo, EV_fallecidoHijo, EV_codFallecidoHijo, EV_edadHijo, EV_fecNacimientoHijo, EV_sexoHijo);


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_hijosClienteBuro_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_hijosClienteBuro_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_hijosClienteBuro_PR;
--Fin P-CSR-11002 JLGN 05-05-2011
--Inicio P-CSR-11002 JLGN 17-05-2011
 PROCEDURE VE_excepcionCalificacion_PR(EN_codCliente         IN ve_excepcion_calificacion_td.COD_CLIENTE%TYPE,
                                       EV_codplantarif       IN ve_excepcion_calificacion_td.COD_PLANTARIF%TYPE,
                                       EV_nomuser            IN ve_excepcion_calificacion_td.NOM_USUARIO%TYPE,
                                       EV_codPass            IN ve_excepcion_calificacion_td.COD_PASSWORD%TYPE,
                                       EV_limiteCredito      IN ve_excepcion_calificacion_td.LIMITE_CREDITO%TYPE,
                                       SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                                       SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_numEvento          OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='INSERT INTO '
             || 'VE_EXCEPCION_CALIFICACION_TD (COD_CLIENTE, COD_PLANTARIF, NOM_USUARIO, COD_PASSWORD, LIMITE_CREDITO, FEC_CREACION) '
             || 'VALUES('||EN_codCliente||','||EV_codplantarif||','||EV_nomuser||','||EV_codPass||','||EV_limiteCredito||','||SYSDATE||')';

        INSERT INTO
            VE_EXCEPCION_CALIFICACION_TD (COD_CLIENTE, COD_PLANTARIF, NOM_USUARIO, COD_PASSWORD, LIMITE_CREDITO, FEC_CREACION)
        VALUES(EN_codCliente,EV_codplantarif,EV_nomuser,EV_codPass,EV_limiteCredito,SYSDATE);


    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_excepcionCalificacion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_excepcionCalificacion_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_excepcionCalificacion_PR;
--Fin P-CSR-11002 JLGN 17-05-2011

--Inicio P-CSR-11002 JLGN 26-05-2011
 PROCEDURE VE_datos_cliente_PR(EN_num_venta     IN ga_ventas.NUM_VENTA%TYPE,
                               SV_num_ident     OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                               SV_categoria     OUT NOCOPY ge_clientes.COD_CATEGORIA%TYPE,
                               SV_nom_cliente   OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                               SV_ape_cliente   OUT NOCOPY VARCHAR2,
                               SV_domicilio     OUT NOCOPY VARCHAR2,
                               SV_des_provincia OUT NOCOPY ge_provincias.DES_PROVINCIA%TYPE,
                               SV_des_canton    OUT NOCOPY ge_ciudades.DES_CIUDAD%TYPE,
                               SV_mail          OUT NOCOPY ge_clientes.NOM_EMAIL%TYPE,
                               SV_nom_represen  OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                               SV_num_ident_re  OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                               SV_mens_promo    OUT NOCOPY ge_clientes.MENS_PROMO%TYPE,
                               SV_des_tipident  OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                               SV_num_ctacorr   OUT NOCOPY ge_clientes.NUM_CTACORR%TYPE,
                               SV_banco         OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               SV_banco_tarj    OUT NOCOPY ge_bancos.DES_BANCO%TYPE,
                               SV_num_tarjeta   OUT NOCOPY ge_clientes.NUM_TARJETA%TYPE,
                               SV_des_tarjeta   OUT NOCOPY ge_tiptarjetas.DES_TIPTARJETA%TYPE,
                               SV_limiteconsumo OUT NOCOPY VARCHAR2,
                               SV_tipo_cliente  OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                               SV_des_tipide_re OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                               SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                               SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError       ge_errores_pg.desevent;
    LV_sql            ge_errores_pg.vquery;
    ln_cod_cliente    ge_clientes.cod_cliente%TYPE;
    ln_cod_direccion  ge_direcciones.cod_direccion%TYPE;
    ln_cod_region     ge_direcciones.cod_region%TYPE;
    ln_cod_provincia  ge_direcciones.cod_provincia%TYPE;
    ln_cod_ciudad     ge_direcciones.cod_ciudad%TYPE;
    lv_cod_tipident   ge_clientes.cod_tipident%TYPE;
    lv_cod_banco      ge_clientes.cod_banco%TYPE;
    lv_num_ctacorr    ge_clientes.num_ctacorr%TYPE;
    lv_cod_bancotarj  ge_clientes.cod_banco%TYPE;
    lv_cod_tarjeta    ge_clientes.cod_tiptarjeta%TYPE;
    ln_num_tarjeta    ge_clientes.num_tarjeta%TYPE;
    ln_cuenta         NUMBER;
    LV_limite         ve_cliente_buro_to.LIMITE_CONSUMO%TYPE;
    lv_cod_tipiden_re ge_clientes.cod_tipident%TYPE;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;
        ln_cuenta     := 0;

        LV_Sql:='SELECT cod_cliente '
             || 'FROM   ga_ventas '
             || 'WHERE  num_venta = '||EN_num_venta;

        SELECT cod_cliente
        INTO   ln_cod_cliente
        FROM   ga_ventas
        WHERE  num_venta = EN_num_venta;

        LV_Sql:='SELECT a.num_ident, a.cod_categoria, a.nom_cliente, a.nom_apeclien1 ||''''|| a.nom_apeclien2, a.nom_email,'
             || 'a.nom_apoderado, a.num_identapor, a.mens_promo, a.cod_tipident, a.cod_banco, a.num_ctacorr, '
             || 'a.cod_bancotarj, a.cod_tiptarjeta, a.num_tarjeta '
             || 'FROM   ge_clientes a '
             || 'WHERE  a.cod_cliente = '||ln_cod_cliente;

        SELECT a.num_ident, a.cod_categoria, a.nom_cliente, a.nom_apeclien1 ||' '|| a.nom_apeclien2, a.nom_email,
               a.nom_apoderado, a.num_identapor, a.mens_promo, a.cod_tipident, a.cod_banco, a.num_ctacorr,
               a.cod_bancotarj, a.cod_tiptarjeta, a.num_tarjeta, a.cod_tipo, a.cod_tipidentapor
        INTO   SV_num_ident, SV_categoria, SV_nom_cliente, SV_ape_cliente, SV_mail,
               SV_nom_represen, SV_num_ident_re, SV_mens_promo, lv_cod_tipident, lv_cod_banco, lv_num_ctacorr,
               lv_cod_bancotarj, lv_cod_tarjeta, ln_num_tarjeta, SV_tipo_cliente, lv_cod_tipiden_re
        FROM   ge_clientes a
        WHERE  a.cod_cliente = ln_cod_cliente;

        LV_Sql:='SELECT cod_direccion '
             || 'FROM   ga_direccli '
             || 'WHERE  cod_cliente = '||ln_cod_cliente||' '
             || 'AND    cod_tipdireccion = 1';

        SELECT cod_direccion
        INTO   ln_cod_direccion
        FROM   ga_direccli
        WHERE  cod_cliente = ln_cod_cliente
        AND    cod_tipdireccion = 1; --Se obtiene direccion de facturacion

        LV_Sql:='SELECT TRIM(nom_calle ||'' ''|| num_calle||'' ''||obs_direccion ||'' ''|| des_direc1), cod_region, cod_provincia, cod_ciudad '
             || 'FROM   ge_direcciones '
             || 'WHERE  cod_direccion = '||ln_cod_direccion;

        SELECT TRIM(nom_calle ||' '|| num_calle||' '||obs_direccion ||' '|| des_direc1), cod_region, cod_provincia, cod_ciudad
        INTO   SV_domicilio, ln_cod_region, ln_cod_provincia, ln_cod_ciudad
        FROM   ge_direcciones
        WHERE  cod_direccion = ln_cod_direccion;

        --La Provincia es la Region
        LV_Sql:='SELECT des_region '
             || 'FROM   ge_regiones '
             || 'WHERE  cod_region = '||ln_cod_region;

        SELECT des_region
        INTO   SV_des_provincia
        FROM   ge_regiones
        WHERE  cod_region = ln_cod_region;

        --El Canton es la Provincia
        LV_Sql:='SELECT des_provincia '
             || 'FROM   ge_provincias '
             || 'WHERE  cod_provincia = '||ln_cod_provincia
             || 'AND    cod_region = '||ln_cod_region;

        SELECT des_provincia
        INTO   SV_des_canton
        FROM   ge_provincias
        WHERE  cod_provincia = ln_cod_provincia
        AND    cod_region = ln_cod_region;

        LV_Sql:='SELECT des_tipident '
             || 'FROM   ge_tipident '
             || 'WHERE  cod_tipident = '||lv_cod_tipident;

        SELECT des_tipident
        INTO   SV_des_tipident
        FROM   ge_tipident
        WHERE  cod_tipident = lv_cod_tipident;

        --Se valida si parametro de tipo de identificacion de representante es nulo o vacio
        IF (lv_cod_tipiden_re IS NOT NULL) AND (LENGTH(TRIM(lv_cod_tipiden_re)) > 0) THEN

            LV_Sql:='SELECT des_tipident '
                 || 'FROM   ge_tipident '
                 || 'WHERE  cod_tipident = '||lv_cod_tipiden_re;

            SELECT des_tipident
            INTO   SV_des_tipide_re
            FROM   ge_tipident
            WHERE  cod_tipident = lv_cod_tipiden_re;

        END IF;

        --Se valida si el numero de cuenta corriente es nulo
        IF lv_num_ctacorr IS NULL OR lv_num_ctacorr = '' THEN
            --Numero de cuenta corriente es nulo
            SV_num_ctacorr := '';
            SV_banco       := '';
        ELSE
            --Numero de cuenta corriente no es nulo
            SV_num_ctacorr := lv_num_ctacorr;
            --Se obtiene descripcion del Banco
            LV_Sql:=' SELECT des_banco'
                 || ' FROM   ge_bancos'
                 || ' WHERE  cod_banco = '||lv_cod_banco;

            SELECT des_banco
            INTO   SV_banco
            FROM   ge_bancos
            WHERE  cod_banco = lv_cod_banco;
        END IF;

        --Se valida si el numero de tarjeta es nulo
        IF ln_num_tarjeta IS NULL OR ln_num_tarjeta = '' THEN
            --Numero de tarjeta es nulo
            SV_banco_tarj  := '';
            SV_num_tarjeta := '';
            SV_des_tarjeta := '';
        ELSE
            --Numero de tarjeta no es nulo
            SV_num_tarjeta := ln_num_tarjeta;
            --Se obtiene descripcion del Banco de la tarjeta
            LV_Sql:=' SELECT des_banco'
                 || ' FROM   ge_bancos'
                 || ' WHERE  cod_banco = '||lv_cod_bancotarj;

            SELECT des_banco
            INTO   SV_banco_tarj
            FROM   ge_bancos
            WHERE  cod_banco = lv_cod_bancotarj;

            --Se obtiene descripcion de la tarjeta
            LV_Sql:=' SELECT des_tiptarjeta'
                 || ' FROM   ge_tiptarjetas '
                 || ' WHERE  cod_tiptarjeta = '||lv_cod_tarjeta;

            SELECT des_tiptarjeta
            INTO   SV_des_tarjeta
            FROM   ge_tiptarjetas
            WHERE  cod_tiptarjeta = lv_cod_tarjeta;
        END IF;

        --P-CSR-11002 JLGN 22-07-2011
        SELECT COUNT(0)
        INTO   ln_cuenta
        FROM   ve_cliente_buro_to
        WHERE  num_cedula_cliente = SV_num_ident
        AND    nombre_cliente = SV_nom_cliente;

        IF ln_cuenta > 0 THEN
            LV_Sql:=' SELECT limite_consumo'
                 || ' FROM   ve_cliente_buro_to'
                 || ' WHERE  cod_referencia IN (SELECT MAX(cod_referencia)'
                 || '                           FROM   ve_cliente_buro_to '
                 || '                           WHERE  num_cedula_cliente = '||SV_num_ident
                 || '                           AND    nombre_cliente = '||SV_nom_cliente||')';

            SELECT limite_consumo
            INTO   LV_limite
            FROM   ve_cliente_buro_to
            WHERE  cod_referencia IN (SELECT MAX(cod_referencia)
                                      FROM   ve_cliente_buro_to
                                      WHERE  num_cedula_cliente = SV_num_ident
                                      AND    nombre_cliente = SV_nom_cliente);

            SELECT TRIM(TO_CHAR(LV_limite, '99,999,999,999,999,999,999' ))
            INTO   SV_limiteconsumo
            FROM   dual;

        ELSE
            SV_limiteconsumo := '';
        END IF;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_datos_cliente_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_datos_cliente_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_datos_cliente_PR;
--Fin P-CSR-11002 JLGN 26-05-2011

--Inicio P-CSR-11002 JLGN 14-06-2011
 PROCEDURE VE_direcPerso_PR(EN_codCliente         IN ga_direccli.COD_CLIENTE%TYPE,
                            EV_direcPerso         OUT NOCOPY ga_direccli.COD_DIRECCION%TYPE,
                            SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                            SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                            SN_numEvento          OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT SELECT cod_direccion '
         || 'FROM   ga_direccli '
         || 'WHERE  cod_tipdireccion = 2 '--Direccion Personal
         || 'AND    cod_cliente = '||EN_codCliente;

        SELECT cod_direccion
        INTO   EV_direcPerso
        FROM   ga_direccli
        WHERE  cod_tipdireccion = 2 --Direccion Personal
        AND    cod_cliente = EN_codCliente;

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_excepcionCalificacion_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_direcPerso_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_direcPerso_PR;
--Fin P-CSR-11002 JLGN 14-06-2011

--Inicio P-CSR-11002 JLGN 05-08-2011
 PROCEDURE VE_mens_promo_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                            SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                            SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                            SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS

    LV_desError ge_errores_pg.desevent;
    LV_sql        ge_errores_pg.vquery;

    BEGIN
        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT cod_valor, des_valor'
             ||' FROM   ged_codigos'
             ||' WHERE  cod_modulo = VE'
             ||' AND    nom_tabla = PORTAL_VENTAS'
             ||' AND    nom_columna = MENS_PROMO';

        OPEN SC_CURSORDATOS FOR
            SELECT cod_valor, des_valor
            FROM   ged_codigos
            WHERE  cod_modulo = 'VE'
            AND    nom_tabla = 'PORTAL_VENTAS'
            AND    nom_columna = 'MENS_PROMO';

    EXCEPTION
             WHEN OTHERS THEN
                SN_codRetorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                   SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError  := 'OTHERS:VE_alta_cliente_PG.VE_mens_promo_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                'VE_alta_cliente_PG.VE_mens_promo_PR', LV_Sql, SQLCODE, LV_desError );
    END VE_mens_promo_PR;

--Fin P-CSR-11002 JLGN 05-08-2011

END Ve_Alta_Cliente_Pg;
/
SHOW ERRORS