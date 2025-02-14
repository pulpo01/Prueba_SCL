CREATE OR REPLACE PACKAGE BODY IC_Param_Atlantida_PG AS

/*
<NOMBRE>       : IC_Param_Atlantida_PG</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : Juan Gonzalez C.</AUTOR >
<VERSION >     : 1.1</VERSION >
<DESCRIPCION>  : Parametros Interfaz con Centrales</DESCRIPCION>
<FECHAMOD >    : 06/10/2006 </FECHAMOD >
<DESCMOD >     : Se modifica función IC_FecReseteo_FN Incidencia 34655
                 Realizado por Pablo Hernández G./DESCMOD>
*/


FUNCTION IC_NumAbonado_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN NUMBER
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NumAbonado_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Numero del Abonado asociado a un Movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'SELECT NVL(num_abonado, 0)';
        sSql := sSql||' INTO LN_num_abo';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT
                NVL(num_abonado, 0)
        INTO
                LN_num_abo
        FROM
                icc_movimiento
        WHERE
                num_movimiento = EN_num_mov;

        RETURN LN_num_abo;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 0;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_NumAbonado_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_NumAbonado_FN.IC_NumAbonado_FN',sSql,SQLCODE,LV_des_error);
                RETURN 0;
END;

FUNCTION IC_IdEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_IdEmpresa_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Identificador de Empresa del abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_id_empresa  NUMBER(15);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_RecuperaIdEmp_PR(LN_num_abo, LN_id_empresa, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_RecuperaIdEmp_PR(LN_num_abo, LN_id_empresa, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LN_id_empresa IS NOT NULL THEN
                    RETURN TO_CHAR(LN_id_empresa);
                ELSE
                    RETURN 'FALSE';
                END IF;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_IdEmpresa_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_IdEmpresa_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;





FUNCTION IC_IdEmpresa_Icc_Mov_FN(
       EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING

/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_IdEmpresa_Icc_Mov_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2007"
                Creado por="Elias Calderón A."
                                Fecha modificacion="03/2007"
                                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Identificador de Empresa, extrayendo el Codigo del cliente desde el campo NUM_CELULAR_NUE registrado en la ICC_MOVIMIENTO</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/


AS
        LN_id_empresa ga_abocel.cod_cliente%TYPE;
                LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        BEGIN
            sSql := 'SELECT NVL(num_celular_nue,0)';
            sSql := sSql||' INTO LN_id_empresa';
            sSql := sSql||' FROM icc_movimiento';
            sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

            SELECT
                    NVL(num_celular_nue,0)
            INTO
                    LN_id_empresa
            FROM
                    icc_movimiento
            WHERE
                    num_movimiento = EN_num_mov;

         EXCEPTION
            WHEN OTHERS THEN
                    LN_cod_retorno := CN_Err_Cli;
                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                         LV_mens_retorno := CV_Err_NoClasif;
                    END IF;
                         LV_des_error := 'IC_Param_Atlantida_PG.IC_IdEmpresa_Icc_Mov_FN('||EN_num_mov||'); - ' || SQLERRM;
                         LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_IdEmpresa_Icc_Mov_FN',sSql,SQLCODE,LV_des_error);
                         RETURN 'FALSE';
         END;

                      IF LN_id_empresa <> 0 THEN
                               RETURN TO_CHAR(LN_id_empresa);
                          ELSE
                               RETURN 'FALSE: NO SE ENCONTRO CÓDIGO DE CLIENTE';
                      END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_IdEmpresa_Icc_Movimiento_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_IdEmpresa_Icc_Movimiento_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;







FUNCTION IC_LimiteEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteEmpresa_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Empresa del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LV_limite_usuario  VARCHAR2(10);
        LV_factor VARCHAR2(6);
        LN_factor NUMBER(6);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_limite_empresa IS NOT NULL THEN

                     BEGIN
                             -- Este flag indica el factor a aplicar sobre el limite.
                             sSql := 'SELECT TRIM(par.val_parametro)';
                             sSql := sSql||' INTO LV_factor';
                             sSql := sSql||' FROM ged_parametros par';
                             sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagFactor||'''';
                             sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                             sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                             SELECT
                                     TRIM(par.val_parametro)
                             INTO
                                     LV_factor
                             FROM
                                     ged_parametros par
                             WHERE
                                     par.nom_parametro = CV_ParFlagFactor
                                     AND par.cod_modulo = CV_Modulo_Fac
                                     AND par.cod_producto = CN_Producto;
                     EXCEPTION
                            WHEN OTHERS THEN  -- Se Ccnsidera factor=1.
                                RETURN LV_limite_empresa;
                     END;

                     LN_factor := TO_NUMBER(LV_factor);

                     RETURN TO_CHAR(TO_NUMBER(LV_limite_empresa) * LN_factor);

                ELSE
                     RETURN CV_NoData;
                END IF;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
               RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteEmpresa_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteEmpresa_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_LimiteConsumo_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Consumo del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LV_limite_usuario  VARCHAR2(10);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_limite_maximo IS NOT NULL THEN
                    RETURN LV_limite_maximo;
                ELSE
                    RETURN CV_NoData;
                END IF;
        ELSE
                RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_LimiteConsumo2_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo2_FN"
                Lenguaje="PL/SQL"
                Fecha creación="04-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Consumo del cliente/abonado asociado a un movimiento, podria aplicar porcentaje</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LV_limite_usuario  VARCHAR2(10);
        LN_limite_maximo  NUMBER(10);
        LN_flag_porc   NUMBER(2);
        LV_flag_porc   ged_parametros.val_parametro%TYPE;
        LN_porcent   NUMBER(2);
        LV_porcent   ged_parametros.val_parametro%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_limite_maximo IS NOT NULL THEN

                    -- Este flag indica si se aplica o no porcentaje sobre el limite maximo.
                    sSql := 'SELECT TRIM(par.val_parametro)';
                    sSql := sSql||' INTO LV_flag_porc';
                    sSql := sSql||' FROM ged_parametros par';
                    sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagPorc||'''';
                    sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                    sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                    SELECT
                            TRIM(par.val_parametro)
                    INTO
                            LV_flag_porc
                    FROM
                            ged_parametros par
                    WHERE
                            par.nom_parametro = CV_ParFlagPorc
                            AND par.cod_modulo = CV_Modulo_Fac
                            AND par.cod_producto = CN_Producto;

                    LN_flag_porc := TO_NUMBER(LV_flag_porc);


                    IF LN_flag_porc = 1 THEN

                        -- Busca el plan tarifario del abonado.-

                        BEGIN
                                sSql := 'SELECT abo.cod_plantarif';
                                sSql := sSql||' INTO LV_cod_plantarif';
                                sSql := sSql||' FROM ga_abocel abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                                SELECT
                                        abo.cod_plantarif
                                INTO
                                        LV_cod_plantarif
                                FROM
                                        ga_abocel abo
                                WHERE
                                        abo.num_abonado = LN_num_abo;

                        EXCEPTION
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_TipPlan;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo2_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo2_FN',sSql,SQLCODE,LV_des_error);
                                        RETURN 'FALSE';
                        END;

                        -- Busca el porcentaje a aplicar sobre el limite maximo de acuerdo al plan.-

                        BEGIN
                                sSql := 'SELECT al.codigo_interno';
                                sSql := sSql||' INTO LV_porcent';
                                sSql := sSql||' FROM al_codigo_externo al';
                                sSql := sSql||' WHERE al.cod_plataforma = '|| CV_Plataforma;
                                sSql := sSql||' AND al.tip_codigo = '|| CV_TipCodPorc;
                                sSql := sSql||' AND al.codigo_externo = '|| LV_cod_plantarif;

                                SELECT
                                       al.codigo_interno
                                INTO
                                       LV_porcent
                                FROM
                                       al_codigo_externo al
                                WHERE
                                       al.cod_plataforma = CV_Plataforma
                                AND
                                       al.tip_codigo  =  CV_TipCodPorc
                                AND
                                       al.codigo_externo = LV_cod_plantarif;


                        EXCEPTION
                                WHEN OTHERS THEN
                                        -- No tendrá efecto en el Limite. Se considera porcentaje de valor 0.
                                                                                RETURN LV_limite_maximo;
                        END;

                        LN_porcent := TO_NUMBER(LV_porcent);
                        LN_limite_maximo := TO_NUMBER(LV_limite_maximo);

                        LN_limite_maximo := LN_limite_maximo + ((LN_limite_maximo*LN_porcent)/100);

                        RETURN(TO_CHAR(LN_limite_maximo));

                    ELSE
                        RETURN LV_limite_maximo;
                    END IF;

                ELSE
                    RETURN CV_NoData;
                END IF;
        ELSE
                RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo2_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo2_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_LimiteConsumo3_FN(EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo3_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Consumo del cliente/abonado asociado a un movimiento + el Cargo Basico</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LN_limite_maximo  NUMBER;
        LV_defecto  VARCHAR2(10);
        --LN_Cargo_Basico FA_DCTOS_SERV_REC_TD.COD_CARGOBASICO%TYPE;
        total1 Number;
        total2 VARCHAR2(30);
        LN_Cargo_Basico FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE;
        LV_limite_usuario  VARCHAR2(10);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);
        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

                IF LV_limite_maximo IS NOT NULL THEN
                   LN_limite_maximo := TO_NUMBER(LV_limite_maximo);

                ELSE
                  -- Debe  buscar un valor por defecto en ged_parametros. Si no encuentra, retorna FALSE.

                   BEGIN
                            -- Este flag indica el valor de limite maximo por defecto a aplicar.
                            sSql := 'SELECT TRIM(par.val_parametro)';
                            sSql := sSql||' INTO LV_defecto';
                            sSql := sSql||' FROM ged_parametros par';
                            sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParLimDefecto||'''';
                            sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                            sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                            SELECT
                                    TRIM(par.val_parametro)
                            INTO
                                    LV_defecto
                            FROM
                                    ged_parametros par
                            WHERE
                                    par.nom_parametro = CV_ParLimDefecto
                                    AND par.cod_modulo = CV_Modulo_Fac
                                    AND par.cod_producto = CN_Producto;

                    EXCEPTION
                           WHEN OTHERS THEN  -- No encontro el registro.
                             RETURN 'FALSE';

                    END;

                            LN_limite_maximo := TO_NUMBER(LV_defecto);
                END IF;

                IF LV_limite_empresa IS NOT NULL THEN
                   LN_Cargo_Basico := TO_NUMBER(LV_limite_empresa);


                ELSE

                   LN_Cargo_Basico := 0;

                END IF;
                 total1:=LN_limite_maximo + LN_Cargo_Basico;
                 total2:=to_char(total1);
                 RETURN TO_CHAR(total2);
        ELSE

                RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             RETURN 'FALSE';

        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo3_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo3_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_LimiteConsumo4_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo4_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2007"
                Creado por="Elias Calderón A."
                Fecha modificacion="15-06-2007"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el string compuesto de la suma del cargo básico y el límite de consumo, concatenado con cargo básico</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_limite_maximo  icc_movimiento.carga%type;
                LN_cod_cliente  ga_abocel.cod_cliente%type;
                SN_cod_retorno NUMBER;
                SV_mens_retorno VARCHAR2(10);
                SN_num_evento NUMBER;
                LN_Imp_CargoBasico FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;


BEGIN
        BEGIN
                        sSql := 'SELECT carga, num_celular_nue';
                                sSql := sSql||' INTO LV_limite_maximo, LN_cod_cliente';
                        sSql := sSql||' FROM icc_movimiento';
                        sSql := sSql||' WHERE num_movimiento = '''||EN_num_mov||'''';

                                SELECT
                          NVL(carga,0),
                                          num_celular_nue
                        INTO
                                  LN_limite_maximo,
                                          LN_cod_cliente
                                FROM
                          icc_movimiento
                        WHERE
                          num_movimiento = EN_num_mov;

                EXCEPTION
                          WHEN OTHERS THEN  -- No encontro el registro.

                             LN_cod_retorno := CN_Err_Abo;
                             IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                             END IF;
                             LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo4_FN('||EN_num_mov||'); - ' || SQLERRM;
                             LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo4_FN',sSql,SQLCODE,LV_des_error);
                             RETURN 'FALSE: ERROR AL LEER MOVIMIENTO';
        END;



                FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE(LN_cod_cliente, SYSDATE, LN_Imp_CargoBasico, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                IF NOT SN_cod_retorno=0 THEN
                RETURN  'FALSE: PROBLEMAS AL BUSCAR CARGO BASICO';
        END IF;


                IF LN_Imp_CargoBasico IS NOT NULL THEN
                        RETURN('limax='||TO_CHAR(LN_Imp_CargoBasico + LN_limite_maximo)||',limcom='||TO_CHAR(LN_Imp_CargoBasico));
                ELSE
                                RETURN 'FALSE:EL CARGO BÁSICO ES NULO';
                END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE:';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo4_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo4_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE:';
END;


FUNCTION IC_LimiteConsumo5_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo5_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2007"
                Creado por="Elias Calderon A."
                Fecha modificacion="15-06-2007"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Consumo del cliente/abonado asociado a un movimiento + el Cargo Basico</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LN_limite_maximo  NUMBER;
        SN_cod_retorno NUMBER;
        SN_num_evento NUMBER;
        SV_mens_retorno VARCHAR2(10);
        LV_defecto  VARCHAR2(10);
        LN_Imp_CargoBasico FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE;
        LN_cod_cliente NUMBER(8);
        LV_limite_usuario  VARCHAR2(10);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN

 --- query para buscar el cod_cliente en ga_Abocel.-

            BEGIN
                    sSql := 'SELECT abo.cod_cliente';
                    sSql := sSql||' INTO LN_cod_cliente';
                    sSql := sSql||' FROM ga_abocel abo';
                    sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                    SELECT
                            abo.cod_cliente
                    INTO
                            LN_cod_cliente
                    FROM
                            ga_abocel abo
                    WHERE
                            abo.num_abonado = LN_num_abo;

            EXCEPTION
                    WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo5_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo5_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'FALSE: when otyhers ';
            END;


                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_limite_maximo IS NOT NULL THEN
                   LN_limite_maximo := TO_NUMBER(LV_limite_maximo);
                ELSE
                  -- Debe  buscar un valor por defecto en ged_parametros. Si no encuentra, retorna FALSE.

                   BEGIN
                            -- Este flag indica el valor de limite maximo por defecto a aplicar.
                            sSql := 'SELECT TRIM(par.val_parametro)';
                            sSql := sSql||' INTO LV_defecto';
                            sSql := sSql||' FROM ged_parametros par';
                            sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParLimDefecto||'''';
                            sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                            sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                            SELECT
                                    TRIM(par.val_parametro)
                            INTO
                                    LV_defecto
                            FROM
                                    ged_parametros par
                            WHERE
                                    par.nom_parametro = CV_ParLimDefecto
                                    AND par.cod_modulo = CV_Modulo_Fac
                                    AND par.cod_producto = CN_Producto;
                    EXCEPTION
                           WHEN OTHERS THEN  -- No encontro el registro.
                               RETURN 'FALSE: NO SE ENCONTRÓ EL REGISTRO';
                    END;

                                        LN_limite_maximo := TO_NUMBER(LV_defecto);


                END IF;
                        FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE(LN_cod_cliente, SYSDATE, LN_Imp_CargoBasico, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                        IF NOT SN_cod_retorno=0 THEN
                        RETURN  'FALSE: PROBLEMAS AL BUSCAR CARGO BASICO';
                END IF;
                                IF LN_Imp_CargoBasico IS NOT NULL THEN
                                RETURN('limax='||TO_CHAR(LN_Imp_CargoBasico + LN_limite_maximo)||',limcom='||TO_CHAR(LN_Imp_CargoBasico));
                        ELSE
                                        RETURN 'FALSE:EL CARGO BÁSICO ES NULO';
                        END IF;


        END IF;


EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo5_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo5_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE:';
END;


FUNCTION IC_LimiteConsumo6_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteConsumo6_FN"
                Lenguaje="PL/SQL"
                Fecha creación="27-07-2007"
                Creado por="MMORENO"
                Fecha modificacion="27-07-2007"
                Modificado por="MMORENO"
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el string compuesto de la suma del cargo básico y el límite de consumo</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_limite_maximo  icc_movimiento.carga%type;
                LN_cod_cliente  ga_abocel.cod_cliente%type;
                SN_cod_retorno NUMBER;
                SV_mens_retorno VARCHAR2(10);
                SN_num_evento NUMBER;
                LN_Imp_CargoBasico FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;


BEGIN
        BEGIN
                        sSql := 'SELECT carga, num_celular_nue';
                                sSql := sSql||' INTO LV_limite_maximo, LN_cod_cliente';
                        sSql := sSql||' FROM icc_movimiento';
                        sSql := sSql||' WHERE num_movimiento = '''||EN_num_mov||'''';

                                SELECT
                          NVL(carga,0),
                                          num_celular_nue
                        INTO
                                  LN_limite_maximo,
                                          LN_cod_cliente
                                FROM
                          icc_movimiento
                        WHERE
                          num_movimiento = EN_num_mov;

                EXCEPTION
                          WHEN OTHERS THEN  -- No encontro el registro.

                             LN_cod_retorno := CN_Err_Abo;
                             IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                             END IF;
                             LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo6_FN('||EN_num_mov||'); - ' || SQLERRM;
                             LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo6_FN',sSql,SQLCODE,LV_des_error);
                             RETURN 'FALSE: ERROR AL LEER MOVIMIENTO';
        END;



                FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE(LN_cod_cliente, SYSDATE, LN_Imp_CargoBasico, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                IF NOT SN_cod_retorno=0 THEN
                RETURN  'FALSE: PROBLEMAS AL BUSCAR CARGO BASICO';
        END IF;


                IF LN_Imp_CargoBasico IS NOT NULL THEN
                        RETURN('limax='||TO_CHAR(LN_Imp_CargoBasico + LN_limite_maximo)||',limcom='||TO_CHAR(LN_Imp_CargoBasico + LN_limite_maximo));
                ELSE
                                RETURN 'FALSE:EL CARGO BÁSICO ES NULO';
                END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE:';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteConsumo6_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteConsumo6_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE:';
END;


FUNCTION IC_CargoBasPorcen_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CargoBasPorcen_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Cargo Basico del plan del cliente/abonado asociado a un movimiento, podria aplicar porcentaje</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LV_limite_usuario  VARCHAR2(10);
        LN_lim_CargoBas  NUMBER(10);
        LN_limite  NUMBER(10);
        LV_factor VARCHAR2(6);
        LN_factor NUMBER(6);
        LN_flag_porc   NUMBER(2);
        LV_flag_porc   ged_parametros.val_parametro%TYPE;
        LN_porcent   NUMBER(2);
        LV_porcent   ged_parametros.val_parametro%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                -- El Limite de Empresa equivale al Cargo Basico.
                IF LV_limite_empresa IS NOT NULL THEN

                    -- Este flag indica si se aplica o no porcentaje sobre el limite empresa o Cargo Basico.
                    sSql := 'SELECT TRIM(par.val_parametro)';
                    sSql := sSql||' INTO LV_flag_porc';
                    sSql := sSql||' FROM ged_parametros par';
                    sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagPorc||'''';
                    sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                    sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                    SELECT
                            TRIM(par.val_parametro)
                    INTO
                            LV_flag_porc
                    FROM
                            ged_parametros par
                    WHERE
                            par.nom_parametro = CV_ParFlagPorc
                            AND par.cod_modulo = CV_Modulo_Fac
                            AND par.cod_producto = CN_Producto;

                    LN_flag_porc := TO_NUMBER(LV_flag_porc);


                    IF LN_flag_porc = 1 THEN

                        -- Busca el plan tarifario del abonado.-

                        BEGIN
                                sSql := 'SELECT abo.cod_plantarif';
                                sSql := sSql||' INTO LV_cod_plantarif';
                                sSql := sSql||' FROM ga_abocel abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                                SELECT
                                        abo.cod_plantarif
                                INTO
                                        LV_cod_plantarif
                                FROM
                                        ga_abocel abo
                                WHERE
                                        abo.num_abonado = LN_num_abo;

                        EXCEPTION
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_TipPlan;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_Param_Atlantida_PG.IC_CargoBasPorcen_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CargoBasPorcen_FN',sSql,SQLCODE,LV_des_error);
                                        RETURN 'FALSE';
                        END;

                        -- Busca el porcentaje a aplicar sobre el Cargo Basico de acuerdo al plan.-

                        BEGIN
                                sSql := 'SELECT al.codigo_interno';
                                sSql := sSql||' INTO LV_porcent';
                                sSql := sSql||' FROM al_codigo_externo al';
                                sSql := sSql||' WHERE al.cod_plataforma = '|| CV_Plataforma;
                                sSql := sSql||' AND al.tip_codigo = '|| CV_TipCodPorc;
                                sSql := sSql||' AND al.codigo_externo = '|| LV_cod_plantarif;

                         SELECT
                                       al.codigo_interno
                                INTO
                                       LV_porcent
                                FROM
                                       al_codigo_externo al
                                WHERE
                                       al.cod_plataforma = CV_Plataforma
                                AND
                                       al.tip_codigo  =  CV_TipCodPorc
                                AND
                                       al.codigo_externo = LV_cod_plantarif;

                        EXCEPTION
                                WHEN OTHERS THEN
                                        -- No tendrá efecto en el Limite. Se considera porcentaje de valor 0.
                                        LN_porcent:= 0;
                        END;

                        IF LN_porcent = 0 THEN
                            LN_lim_CargoBas:= TO_NUMBER(LV_limite_empresa); -- Es el Cargo basico.
                        ELSE
                            LN_porcent := TO_NUMBER(LV_porcent);
                            LN_lim_CargoBas := TO_NUMBER(LV_limite_empresa);

                            LN_lim_CargoBas := LN_lim_CargoBas + ((LN_lim_CargoBas*LN_porcent)/100);

                        END IF;
                    ELSE
                        LN_lim_CargoBas:= TO_NUMBER(LV_limite_empresa); -- Es el Cargo basico.
                    END IF;


                    BEGIN
                            -- Este flag indica el factor a aplicar sobre el limite (Cargo Basico).
                            sSql := 'SELECT TRIM(par.val_parametro)';
                            sSql := sSql||' INTO LV_factor';
                            sSql := sSql||' FROM ged_parametros par';
                            sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagFactor||'''';
                            sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                            sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                            SELECT
                                    TRIM(par.val_parametro)
                            INTO
                                    LV_factor
                            FROM
                                    ged_parametros par
                            WHERE
                                    par.nom_parametro = CV_ParFlagFactor
                                    AND par.cod_modulo = CV_Modulo_Fac
                                    AND par.cod_producto = CN_Producto;
                    EXCEPTION
                           WHEN OTHERS THEN  -- Se Ccnsidera factor=1.
                               RETURN TO_CHAR(LN_lim_CargoBas);
                    END;

                    LN_factor := TO_NUMBER(LV_factor);

                    RETURN TO_CHAR(LN_lim_CargoBas * LN_factor);

                ELSE
                    RETURN CV_NoData;
                END IF;
        ELSE
                RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_CargoBasPorcen_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CargoBasPorcen_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_LimiteUsuario_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_LimiteUsuario_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Limite de Usuario del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_limite_maximo  VARCHAR2(10);
        LV_limite_empresa  VARCHAR2(10);
        LV_limite_usuario  VARCHAR2(10);
        LV_limite          VARCHAR2(10);
        LN_flag_calc   NUMBER(2);
        LV_flag_calc   ged_parametros.val_parametro%TYPE;
        LV_factor VARCHAR2(6);
        LN_factor NUMBER(6);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT TRIM(par.val_parametro)';
        sSql := sSql||' INTO LV_flag_calc';
        sSql := sSql||' FROM ged_parametros par';
        sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagCalculo||'''';
        sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
        sSql := sSql||' AND par.cod_producto = '||CN_Producto;

        SELECT
                TRIM(par.val_parametro)
        INTO
                LV_flag_calc
        FROM
                ged_parametros par
        WHERE
                par.nom_parametro = CV_ParFlagCalculo
                AND par.cod_modulo = CV_Modulo_Fac
                AND par.cod_producto = CN_Producto;

        LN_flag_calc := TO_NUMBER(LV_flag_calc);

        -- Indica si aplica o no el calculo de Limite.(1:aplica, 0 u otro:es constante.)
        IF LN_flag_calc = 1 THEN

            sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
            LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

            IF LN_num_abo <> 0 THEN
                    sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                    -- Funcion construida por CRM.-
                    PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Limites_PR(LN_num_abo, EN_num_mov, LV_limite_maximo, LV_limite_empresa, LV_limite_usuario, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                    IF LV_limite_usuario IS NOT NULL THEN
                        LV_limite := LV_limite_usuario;
                    ELSE
                        LV_Limite := CV_NoData;
                    END IF;
            ELSE
                    RETURN 'FALSE';
            END IF;
        ELSE
            LV_limite:= CV_LimiteCte;
        END IF;

        BEGIN
                -- Este flag indica el factor a aplicar sobre el limite.
                sSql := 'SELECT TRIM(par.val_parametro)';
                sSql := sSql||' INTO LV_factor';
                sSql := sSql||' FROM ged_parametros par';
                sSql := sSql||' WHERE par.nom_parametro = '''||CV_ParFlagFactor||'''';
                sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Fac||'''';
                sSql := sSql||' AND par.cod_producto = '||CN_Producto;

                SELECT
                        TRIM(par.val_parametro)
                INTO
                        LV_factor
                FROM
                        ged_parametros par
                WHERE
                        par.nom_parametro = CV_ParFlagFactor
                        AND par.cod_modulo = CV_Modulo_Fac
                        AND par.cod_producto = CN_Producto;
         EXCEPTION
             WHEN OTHERS THEN  -- Se Ccnsidera factor=1.
                 RETURN LV_limite;
         END;

         LN_factor := TO_NUMBER(LV_factor);

         RETURN TO_CHAR(TO_NUMBER(LV_limite) * LN_factor);


EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_LimiteUsuario_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_LimiteUsuario_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_FecReseteo_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_FecReseteo_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener Fecha de Reseteo del Limite de Consumo del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
                LV_dig VARCHAR2(1);
        LN_fecha_res NUMBER(6);
        LV_fecha_res VARCHAR2(6);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_ObtieneFechaRes_PR(LN_num_abo, LN_fecha_res, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                --Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_ObtieneFechaRes_PR(LN_num_abo, LN_fecha_res, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

                                IF LN_fecha_res IS NOT NULL THEN
                    LV_fecha_res := TO_CHAR(LN_fecha_res);
                                        LV_dig := SUBSTR(LV_fecha_res,1,1);
                    IF LENGTH(LV_fecha_res) = 5 AND LV_dig <> '9' THEN
-- Inicio 34655 06/10/2006 Pablo Hernández G.
                            RETURN '000'||TO_CHAR(SUBSTR(LV_fecha_res,1,1) + 1 );
                    ELSIF LENGTH(LV_fecha_res) = 5 AND LV_dig = '9' THEN
                            RETURN '00'||TO_CHAR(SUBSTR(LV_fecha_res,1,1) + 1);
                                        ELSE
                            RETURN '00'||TO_CHAR(SUBSTR(LV_fecha_res,1,2) + 1);
-- Fin 34655
                    END IF;
                ELSE
                    RETURN 'FALSE';
                END IF;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Fec;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_FecReseteo_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_FecReseteo_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_NomRepEmp_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NomRepEmp_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Nombre del Representante del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_nom_rep  VARCHAR2(120);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_ObtieneRepres_PR(LN_num_abo, LV_nom_rep, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_ObtieneRepres_PR(LN_num_abo, LV_nom_rep, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_nom_rep IS NOT NULL THEN
                    RETURN LV_nom_rep;
                ELSE
                    RETURN CV_MensajeNoRep;
                END IF;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Emp;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_NomRepEmp_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_NomRepEmp_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_EMail_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_EMail_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el e-Mail del cliente/abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_email  VARCHAR2(120);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                sSql := 'PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Email_PR(LN_num_abo, LV_email, LN_cod_retorno, LV_mens_retorno, LN_num_evento)';
                -- Funcion construida por CRM.-
                PV_ObtieneInfo_Atlantida_PG.PV_Recupera_Email_PR(LN_num_abo, LV_email, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
                IF LV_email IS NOT NULL THEN
                    RETURN LV_email;
                ELSE
                    RETURN CV_NoData;
                END IF;
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_EMail_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_EMail_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_NumCorto_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NumCorto_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener cuatro ultimos digitos del numero de celular del Abonado asociado a un Movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LV_num_cel VARCHAR2(16);
        LV_num_corto  VARCHAR2(16);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'SELECT TO_CHAR(num_celular)';
        sSql := sSql||' INTO LV_num_cel';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT
                TO_CHAR(num_celular)
        INTO
                LV_num_cel
        FROM
                icc_movimiento
        WHERE
                num_movimiento = EN_num_mov;

        LV_num_corto := SUBSTR(LV_num_cel, LENGTH(LV_num_cel)-3,4);

        RETURN LV_num_corto;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cel;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_NumCorto_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_NumAbonado_FN.IC_NumCorto_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_TipoPlan_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_TipoPlan_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Tipo de Plan (Atlantida) del abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_tipo_plan  VARCHAR2(120);
                LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN

            BEGIN
                    sSql := 'SELECT abo.cod_plantarif';
                    sSql := sSql||' INTO LV_cod_plantarif';
                    sSql := sSql||' FROM ga_abocel abo';
                    sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                    SELECT
                            abo.cod_plantarif
                    INTO
                            LV_cod_plantarif
                    FROM
                            ga_abocel abo
                    WHERE
                            abo.num_abonado = LN_num_abo;

            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                            BEGIN
                                    sSql := 'SELECT abo.cod_plantarif';
                                    sSql := sSql||' INTO LV_cod_plantarif';
                                    sSql := sSql||' FROM ga_aboamist abo';
                                    sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                                    SELECT
                                            abo.cod_plantarif
                                    INTO
                                            LV_cod_plantarif
                                    FROM
                                            ga_aboamist abo
                                    WHERE
                                            abo.num_abonado = LN_num_abo;

                            EXCEPTION
                                    WHEN NO_DATA_FOUND THEN
                                            RETURN 'FALSE';
                                    WHEN OTHERS THEN
                                            LN_cod_retorno := CN_Err_TipPlan;
                                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                    LV_mens_retorno := CV_Err_NoClasif;
                                            END IF;
                                            LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan_FN('||EN_num_mov||'); - ' || SQLERRM;
                                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan_FN',sSql,SQLCODE,LV_des_error);
                                            RETURN 'FALSE';
                            END;

                    WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'FALSE';
            END;

            sSql := 'SELECT al.codigo_externo';
            sSql := sSql||' INTO LV_tipo_plan';
            sSql := sSql||' FROM al_codigo_externo al';
            sSql := sSql||' WHERE al.cod_plataforma = '|| CV_Plataforma;
            sSql := sSql||' AND al.tip_codigo = '|| CV_TipCodigo;
            sSql := sSql||' AND al.codigo_interno = '|| LV_cod_plantarif;

            SELECT
                   al.codigo_externo
            INTO
                   LV_tipo_plan
            FROM
                   al_codigo_externo al
            WHERE
                   al.cod_plataforma = CV_Plataforma
            AND
                   al.tip_codigo  =  CV_TipCodigo
            AND
                   al.codigo_interno = LV_cod_plantarif;

            IF LV_tipo_plan IS NOT NULL THEN
                RETURN LV_tipo_plan;
            ELSE
                RETURN 'FALSE';
            END IF;

        END IF;

        RETURN 'FALSE';

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_TipPlan;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;


FUNCTION IC_TipoPlan2_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_TipoPlan2_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el Tipo de Plan (Atlantida) del abonado. Puede ser segun plan nuevo o actual</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_tipo_plan  VARCHAR2(120);
                LV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
                LV_plantarif_abo ga_abocel.cod_plantarif%TYPE;
        LN_cod_cliente   ga_abocel.cod_cliente%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        -- Busca el plan tarifario del abonado en el movimiento. Si viene plan, utiliza ese valor de plan nuevo.-
        -- Si no hay valor, busca el plan nuevo en la ga_finciclo (cambio de plan).-
        -- Si no hay registro en ga_finciclo (no es cambio de plan), utiliza el plan de la ga_abocel (plan actual).-

        BEGIN
               sSql := 'SELECT icc.plan, icc.num_abonado';
               sSql := sSql||' INTO LV_cod_plantarif, LN_num_abo';
               sSql := sSql||' FROM icc_movimiento icc';
               sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

               SELECT
                       icc.plan, icc.num_abonado
               INTO
                       LV_cod_plantarif, LN_num_abo
               FROM
                       icc_movimiento icc
               WHERE
                       icc.num_movimiento = EN_num_mov;
        EXCEPTION
               WHEN OTHERS THEN
                       LN_cod_retorno := CN_Err_TipPlan;
                       IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                               LV_mens_retorno := CV_Err_NoClasif;
                       END IF;
                       LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan2_FN('||EN_num_mov||'); - ' || SQLERRM;
                       LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan2_FN',sSql,SQLCODE,LV_des_error);
                       RETURN 'FALSE';
        END;


        IF LV_cod_plantarif IS NULL THEN

            -- Busca datos en la GA_ABOCEL. El plan podria ocuparlo o no, dependiendo de la siguiente query.-
            BEGIN
                    sSql := 'SELECT abo.cod_plantarif, abo.cod_cliente';
                    sSql := sSql||' INTO LN_plantarif_abo, LN_cod_cliente';
                    sSql := sSql||' FROM ga_abocel abo';
                    sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                    SELECT
                            abo.cod_plantarif, abo.cod_cliente
                    INTO
                            LV_plantarif_abo, LN_cod_cliente
                    FROM
                            ga_abocel abo
                    WHERE
                            abo.num_abonado = LN_num_abo;

            EXCEPTION
                    WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan2_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan2_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'FALSE';
            END;



            BEGIN
                sSql := 'SELECT fin.cod_plantarif';
                sSql := sSql||' INTO LN_plantarif_fin';
                sSql := sSql||' FROM ga_finciclo fin';
                sSql := sSql||' WHERE fin.cod_cliente = '||LN_cod_cliente;
                sSql := sSql||' AND fin.num_Abonado = '||LN_num_abo;
                sSql := sSql||' AND fin.cod_ciclfact IS NOT NULL';
                sSql := sSql||' AND fin.cod_plantarif IS NOT NULL';

                SELECT
                        fin.cod_plantarif
                INTO
                        LV_cod_plantarif
                FROM
                        ga_finciclo fin
                WHERE
                        fin.cod_cliente = LN_cod_cliente
                        AND fin.num_abonado = LN_num_abo
                        AND fin.cod_ciclfact IS NOT NULL
                        AND fin.cod_plantarif IS NOT NULL;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN     -- Si no encuentra plan en la ga_finciclo, no es Cambio de plan,-
                        LV_cod_plantarif := LV_plantarif_abo; -- usa el plan de GA_ABOCEL.-
                WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan2_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan2_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'FALSE';
            END;


                END IF; -- fin IF LV_cod_plantarif IS NULL.-

        BEGIN
                sSql := 'SELECT al.codigo_externo';
                sSql := sSql||' INTO LV_tipo_plan';
                sSql := sSql||' FROM al_codigo_externo al';
                sSql := sSql||' WHERE al.cod_plataforma = '|| CV_Plataforma;
                sSql := sSql||' AND al.tip_codigo = '|| CV_TipCodigo;
                sSql := sSql||' AND al.codigo_interno = '|| LV_cod_plantarif;

                SELECT
                       al.codigo_externo
                INTO
                       LV_tipo_plan
                FROM
                       al_codigo_externo al
                WHERE
                       al.cod_plataforma = CV_Plataforma
                AND
                       al.tip_codigo  =  CV_TipCodigo
                AND
                       al.codigo_interno = LV_cod_plantarif;

        EXCEPTION
                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_TipPlan;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan2_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan2_FN',sSql,SQLCODE,LV_des_error);
                        RETURN 'FALSE: NO HAY EQUIVALENCIA PARA EL PLAN:' ||LV_cod_plantarif ;
        END;
        RETURN LV_tipo_plan;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_TipPlan;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_TipoPlan2_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TipoPlan2_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_EsTraspaso_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_EsTraspaso_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2007"
                Creado por="Joaquin Figueroa."
                Fecha modificacion="25 julio 2007"
                Modificado por="vladimir maureira"
                Ambiente Desarrollo="BD SQAPRECOL">
                <Retorno>VARCHAR2</Retorno>
                <Descripción></Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_cod_cliente ga_abocel.cod_cliente%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

LV_cli          ga_intarcel.cod_cliente%TYPE;
LV_abo          ga_intarcel.num_abonado%TYPE;
LD_fechasta     ga_intarcel.fec_hasta%TYPE;
LB_retorna      BOOLEAN:=FALSE;
sSql            GE_Errores_PG.vQuery;
TYPE cursorTYPE IS REF CURSOR;  -- define control ref cursor type  --
cursor_cliente  cursorTYPE;     -- declare cursor variable         --
BEGIN
        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN
                BEGIN
                        sSql := 'SELECT abo.cod_cliente';
                        sSql := sSql||' INTO LN_cod_cliente';
                        sSql := sSql||' FROM ga_abocel abo';
                        sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                        SELECT abo.cod_cliente
                        INTO   LN_cod_cliente
                        FROM   ga_abocel abo
                        WHERE  abo.num_abonado = LN_num_abo;

                EXCEPTION
                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_Cli;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_EsTraspaso_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_EsTraspaso_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                END;

        /* Modificacion Incidencia 42391  Access Full por vmb
                        sSql := 'SELECT cod_cliente, num_abonado, max(fec_hasta)';
                        sSql := sSql||' INTO lv_cli,lv_abo,lv_fechasta ';
                        sSql := sSql||' FROM ga_intarcel ';
                        sSql := sSql||' WHERE num_abonado = '||LN_num_abo;
                        sSql := sSql||' AND to_char(fec_hasta,''MM-YYYY'') <> to_char(''12-3000'')';
                        sSql := sSql||' AND fec_hasta < (';
                        sSql := sSql||'     SELECT fec_desde FROM ga_intarcel ';
                        sSql := sSql||'     WHERE num_abonado = '||LN_num_abo;
                        sSql := sSql||'     AND cod_cliente =  '|| LN_cod_cliente;
                        sSql := sSql||'     AND to_char(fec_hasta,''MM-YYYY'') = to_char(''12-3000''))';
                        sSql := sSql||' GROUP BY cod_cliente, num_abonado ' ;

         Incidencia 42391  Access Full por vmb
                        SELECT cod_cliente, num_abonado, max(fec_hasta)
                        INTO lv_cli,lv_abo,lv_fechasta
                        FROM ga_intarcel
                        WHERE num_abonado = LN_num_abo
                        AND to_char(fec_hasta,'MM-YYYY') <> to_char('12-3000')
                        AND fec_hasta <
                                (SELECT fec_desde FROM ga_intarcel
                                 WHERE num_abonado = LN_num_abo
                                 AND cod_cliente = LN_cod_cliente
                                 AND to_char(fec_hasta,'MM-YYYY') = to_char('12-3000'))
                        GROUP BY cod_cliente, num_abonado;
        */

                      BEGIN

                        sSql:= 'SELECT min(gat.fec_desde) FROM ga_intarcel gat ';
                        sSql:=sSql || ' WHERE gat.cod_cliente = ' || LN_cod_cliente;
                        sSql:=sSql || ' AND gat.num_abonado = ' || LN_num_abo;
                        sSql:=sSql || ' AND gat.fec_hasta >= SYSDATE';

                        SELECT min(gat.fec_desde)
                        INTO  LD_fechasta
                        FROM ga_intarcel gat
                        WHERE gat.cod_cliente = LN_cod_cliente
                        AND gat.num_abonado = LN_num_abo
                        AND gat.fec_hasta >= SYSDATE;

                        IF LD_fechasta IS NULL THEN
                           RETURN CV_Ejecuta;
                        END IF;

                        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             RETURN CV_Ejecuta;

                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_Cli;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                   LV_mens_retorno := CV_Err_NoClasif;
                                END IF;

                                LV_des_error := 'IC_Param_Atlantida_PG.IC_EsTraspaso_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_EsTraspaso_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                     END;

                        sSql :='SELECT ga.cod_cliente, ga.num_abonado, max(ga.fec_hasta)';
                        sSql := sSql || ' FROM ga_intarcel ga ';
                        sSql := sSql || ' WHERE ga.cod_cliente > 0 ';
                        sSql := sSql || ' AND ga.num_abonado = :num_abonado ';
                        sSql := sSql || ' AND ga.fec_hasta < :fec_hasta ';
                        sSql := sSql || ' GROUP BY ga.cod_cliente, ga.num_abonado ';

                              OPEN cursor_cliente FOR sSql USING LN_num_abo,LD_fechasta;
                              LOOP
                                BEGIN
                                   FETCH cursor_cliente INTO lv_cli,lv_abo,LD_fechasta;
                                   EXIT WHEN cursor_cliente%NOTFOUND;

                                   IF lv_cli <> LN_cod_cliente THEN
                                      LB_retorna := TRUE;
                                      EXIT;
                                   END IF;

                                  EXCEPTION
                                  WHEN NO_DATA_FOUND THEN
                                    LB_retorna := FALSE;
                                  WHEN OTHERS THEN
                                    LN_cod_retorno := CN_Err_Cli;
                                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                       LV_mens_retorno := CV_Err_NoClasif;
                                    END IF;
                                    LV_des_error := 'IC_Param_Atlantida_PG.IC_EsTraspaso_FN('||EN_num_mov||'); - ' || SQLERRM;
                                    LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_EsTraspaso_FN',sSql,SQLCODE,LV_des_error);
                                    RETURN 'FALSE';
                                END;
                              END LOOP;

                              CLOSE cursor_cliente;

                              IF LB_retorna THEN
                                 RETURN 'FALSE';
                              END IF;
                END IF;

RETURN CV_Ejecuta;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_EsTraspaso_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_EsTraspaso_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;



FUNCTION IC_ExisteAboEmp_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ExisteAboEmp_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2006"
                Creado por="Juan Gonzalez C."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar si hay otros abonados asociados a una empresa. El resultado permite o no permite ejecucion de comando.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_cod_cliente ga_abocel.cod_cliente%TYPE;
        ST_cont  NUMBER := 0;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;
        LV_ServiciosATL   VARCHAR2(50);


BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN

                BEGIN
                        sSql := 'SELECT abo.cod_cliente';
                        sSql := sSql||' INTO LN_cod_cliente';
                        sSql := sSql||' FROM ga_abocel abo';
                        sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                        SELECT
                                abo.cod_cliente
                        INTO
                                LN_cod_cliente
                        FROM
                                ga_abocel abo
                        WHERE
                                abo.num_abonado = LN_num_abo;

                EXCEPTION
                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_Cli;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                END;

                -- busca cadena con servicios Atlantida - Procedure de CRM.
                PV_ObtieneInfo_Atlantida_PG.PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
                IF LV_ServiciosATL IS NULL THEN
                        LN_cod_retorno := CN_Err_Abo;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN',sSql,SQLCODE,LV_des_error);
                        RETURN 'FALSE';
                END IF;

                -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                sSql := 'SELECT COUNT(1) FROM   ga_servsuplabo A ';
                sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
                sSql := sSql || ' FROM ga_abocel B ';
                sSql := sSql || ' WHERE B.cod_cliente = ' ||  LN_cod_cliente ;
                sSql := sSql || ' AND B.num_abonado <> ' ||  LN_num_abo ;
                sSql := sSql || ' AND B.cod_situacion NOT IN (''BAA'', ''BAP''))';
                sSql := sSql || ' AND A.cod_servicio IN (' || LV_ServiciosATL || ')';
                sSql := sSql || ' AND A.ind_estado = 2 ';

                EXECUTE IMMEDIATE sSql INTO ST_cont;

                IF ST_cont > 0 THEN    -- Se interpreta al reves para efectos de Centrales.
                   RETURN 'FALSE';  -- Si hay otros abonados Atlantida, No permite la ejecucion en Centrales.
                ELSE
                   --RETURN CV_Ejecuta; -- Permite ejecucion en Centrales, dado que no hay otros abonados Atlantida.
                                      --RETURN CV_Ejecuta; -- Permite ejecucion en Centrales, dado que no hay otros abonados Atlantida.
                               -- Se Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida en AAA
                        sSql := 'SELECT COUNT(1) FROM   ga_servsuplabo A ';
                        sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
                        sSql := sSql || ' FROM ga_abocel B ';
                        sSql := sSql || ' WHERE B.cod_cliente = ' ||  LN_cod_cliente ;
                        sSql := sSql || ' AND B.num_abonado <> ' ||  LN_num_abo ;
                        sSql := sSql || ' AND B.cod_situacion IN (''AAA''))';
                        sSql := sSql || ' AND A.cod_servicio IN (' || LV_ServiciosATL || ')';
                        sSql := sSql || ' AND A.ind_estado = 1';
                        EXECUTE IMMEDIATE sSql INTO ST_cont;
                                    IF ST_cont > 0 THEN
                                       RETURN 'FALSE';
                                        ELSE
                                           RETURN CV_Ejecuta;
                                        END IF;
                END IF;

        END IF;

        RETURN 'FALSE';

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ExisteAboEmp_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;





FUNCTION IC_ExisteAboEmp_Icc_Mov_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ExisteAboEmp_Icc_Mov__FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2007"
                Creado por="Elias Calderón A."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar si hay otros abonados asociados a una empresa, extrayendo el Codigo del cliente desde el campo NUM_CELULAR_NUE registrado en la ICC_MOVIMIENTO. El resultado permite o no permite ejecucion de comando.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_id_empresa ga_abocel.Cod_Cliente%TYPE;
        ST_cont  NUMBER := 0;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;
        LV_ServiciosATL   VARCHAR2(50);

BEGIN

        BEGIN
            sSql := 'SELECT NVL(num_celular_nue, 0)';
            sSql := sSql||' INTO LN_Cod_Cliente';
            sSql := sSql||' FROM icc_movimiento';
            sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

            SELECT
                NVL(num_celular_nue, 0)
            INTO
                LN_id_empresa
            FROM
                icc_movimiento
            WHERE
                num_movimiento = EN_num_mov;

        END;

                         IF LN_id_empresa <> 0 THEN
                             BEGIN
                                                        -- busca cadena con servicios Atlantida - Procedure de CRM.
                            PV_ObtieneInfo_Atlantida_PG.PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
                            IF LV_ServiciosATL IS NULL THEN
                                LN_cod_retorno := CN_Err_Abo;
                                                   IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                         LV_mens_retorno := CV_Err_NoClasif;
                                    END IF;
                                 LV_des_error := 'IC_Param_Atlantida_PG.IC_ExisteAboEmp_Icc_Mov_FN('||EN_num_mov||'); - ' || SQLERRM;
                                 LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ExisteAboEmp_Icc_Mov_FN',sSql,SQLCODE,LV_des_error);
                                 RETURN 'FALSE: LA CADENA DE SERVICIOS ATLANTIDA ES NULL';
                            END IF;

                            -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
                            sSql := 'SELECT COUNT(1) FROM   ga_servsuplabo A ';
                            sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
                            sSql := sSql || ' FROM ga_abocel B ';
                            sSql := sSql || ' WHERE B.cod_cliente = ' ||  LN_id_empresa ;
                            sSql := sSql || ' AND B.cod_situacion NOT IN (''BAA'', ''BAP''))';
                            sSql := sSql || ' AND A.cod_servicio IN (' || LV_ServiciosATL || ')';
                            sSql := sSql || ' AND A.ind_estado = 2 ';

                            EXECUTE IMMEDIATE sSql INTO ST_cont;

                            IF ST_cont > 0 THEN    -- Se interpreta al reves para efectos de Centrales.
                                RETURN 'FALSE: EXISTEN OTROS ABONADOS ATLANTIDA';  -- Si hay otros abonados Atlantida, No permite la ejecucion en Centrales.
                            ELSE
                                -- RETURN CV_Ejecuta; -- Permite ejecucion en Centrales, dado que no hay otros abonados Atlantida.
                                            -- Se Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida en AAA
                                    sSql := 'SELECT COUNT(1) FROM   ga_servsuplabo A ';
                                    sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
                                    sSql := sSql || ' FROM ga_abocel B ';
                                    sSql := sSql || ' WHERE B.cod_cliente = ' ||  LN_id_empresa ;
                                    sSql := sSql || ' AND B.cod_situacion IN (''AAA''))';
                                    sSql := sSql || ' AND A.cod_servicio IN (' || LV_ServiciosATL || ')';
                                    sSql := sSql || ' AND A.ind_estado = 1';
                                    EXECUTE IMMEDIATE sSql INTO ST_cont;

                                                                        IF ST_cont > 0 THEN
                                                            RETURN 'FALSE: EXISTEN OTROS ABONADOS CON SERVICIOS ATLANTIDA ACTIVOS EN AAA';
                                                                ELSE
                                                            RETURN CV_Ejecuta;
                                                        END IF;
                            END IF;


                       END;


                             ELSE
                             RETURN 'FALSE:NO SE ENCONTRÓ EL CÓDIGO DE CLIENTE';
                                 END IF;



EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_ExisteAboEmp_Icc_Mov_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ExisteAboEmp_Icc_Mov_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;






FUNCTION IC_NoTieneVPN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_TieneVPN_FN"
                Lenguaje="PL/SQL"
                Fecha creación="04-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar si el abonado asociado a un movimiento tiene servicio VPN activo</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LN_vpn  NUMBER(3) := 0;
                LV_serv_vpn   ged_parametros.val_parametro%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        sSql := 'SELECT NVL(par.val_parametro,CHR(0))';
        sSql := sSql||' INTO LV_serv_vpn';
        sSql := sSql||' FROM ged_parametros par';
        sSql := sSql||' WHERE par.nom_parametro = '''||CV_nompar01||'''';
        sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo_Cen||'''';
        sSql := sSql||' AND par.cod_producto = '||CN_Producto;

        SELECT
                NVL(par.val_parametro,CHR(0))
        INTO
                LV_serv_vpn
        FROM
                ged_parametros par
        WHERE
                par.nom_parametro = CV_nompar01
                AND par.cod_modulo = CV_Modulo_Cen
                AND par.cod_producto = CN_Producto;

        sSql := 'SELECT count(1)';
        sSql := sSql||' INTO LN_vpn';
        sSql := sSql||' FROM ga_servsuplabo supl';
        sSql := sSql||' WHERE supl.num_abonado = LN_num_abo';
        sSql := sSql||' AND supl.cod_servsupl = TO_NUMBER(TRIM(LV_serv_vpn))';
        sSql := sSql||' AND supl.fec_altabd IS NOT NULL';
        sSql := sSql||' AND supl.ind_estado = 2;';

        BEGIN
          SELECT count(1)
          INTO LN_vpn
          FROM ga_servsuplabo supl
          WHERE supl.num_abonado = LN_num_abo
            AND supl.cod_servsupl = TO_NUMBER(TRIM(LV_serv_vpn))
                    AND supl.fec_altabd IS NOT NULL
            AND supl.ind_estado = 2;
        EXCEPTION
           WHEN OTHERS THEN
                    LN_vpn := 0;
        END;

        IF LN_vpn = 0 THEN
           RETURN CV_NoTiene;
        ELSE
           RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_TieneVPN_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_TieneVPN_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;

FUNCTION IC_MaxAbreviados_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_MaxAbreviados_FN"
                Lenguaje="PL/SQL"
                Fecha creación="06-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el valor de MaxAbreviados del plan del abonado asociado a un movimiento</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_maxabrev   ged_parametros.val_parametro%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN

                -- Busca el plan tarifario del abonado.-

                BEGIN
                        sSql := 'SELECT abo.cod_plantarif';
                        sSql := sSql||' INTO LV_cod_plantarif';
                        sSql := sSql||' FROM ga_abocel abo';
                        sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abo;

                        SELECT
                                abo.cod_plantarif
                        INTO
                                LV_cod_plantarif
                        FROM
                                ga_abocel abo
                        WHERE
                                abo.num_abonado = LN_num_abo;
                 EXCEPTION
                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_TipPlan;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                 END;

                 -- Busca el MazAbreviados de acuerdo al plan.-

                 BEGIN
                        sSql := 'SELECT al.codigo_externo';
                        sSql := sSql||' INTO LV_maxabrev';
                        sSql := sSql||' FROM al_codigo_externo al';
                        sSql := sSql||' WHERE al.cod_plataforma = '|| CV_Plataforma;
                        sSql := sSql||' AND al.tip_codigo = '|| CV_TipMaxAbrev;
                        sSql := sSql||' AND al.codigo_interno = '|| LV_cod_plantarif;

                        SELECT
                               al.codigo_externo
                        INTO
                               LV_maxabrev
                        FROM
                               al_codigo_externo al
                        WHERE
                               al.cod_plataforma = CV_Plataforma
                        AND
                               al.tip_codigo  =  CV_TipMaxAbrev
                        AND
                               al.codigo_interno = LV_cod_plantarif;

                 EXCEPTION
                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_TipPlan;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                 END;

                 RETURN LV_maxabrev;

        ELSE
                RETURN 'FALSE';
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_MaxAbreviados_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;



FUNCTION IC_NombreEmpresa_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NombreEmpresa_FN"
                Lenguaje="PL/SQL"
                Fecha creación="06-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar el nombre del cliente al que pertenece el abonado.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abo icc_movimiento.num_abonado%TYPE;
        LV_nom_cliente ge_clientes.nom_cliente%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN

        sSql := 'LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov)';
        LN_num_abo := IC_Param_Atlantida_PG.IC_NumAbonado_FN(EN_num_mov);

        IF LN_num_abo <> 0 THEN

                BEGIN
                        sSql := 'SELECT TRIM(clie.nom_cliente)';
                        sSql := sSql||' INTO LV_nom_cliente';
                        sSql := sSql||' FROM ga_abocel abo, ge_clientes clie';
                        sSql := sSql||' WHERE abo.cod_cliente = clie.cod_cliente';
                        sSql := sSql||'   AND abo.num_abonado = '||LN_num_abo;

                        SELECT
                                TRIM(clie.nom_cliente)
                        INTO
                                LV_nom_cliente
                        FROM
                                ga_abocel abo, ge_clientes clie
                        WHERE
                                abo.cod_cliente = clie.cod_cliente
                          AND
                                abo.num_abonado = LN_num_abo;

                EXCEPTION
                        WHEN OTHERS THEN
                                LN_cod_retorno := CN_Err_Cli;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_NombreEmpresa_FN('||EN_num_mov||'); - ' || SQLERRM;
                                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_NombreEmpresa_FN',sSql,SQLCODE,LV_des_error);
                                RETURN 'FALSE';
                END;

                RETURN LV_nom_cliente;

        END IF;

        RETURN 'FALSE';

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_NombreEmpresa_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_NombreEmpresa_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;



FUNCTION IC_NombreEmpresa_Icc_Mov_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NombreEmpresa_Icc_Mov_FN"
                Lenguaje="PL/SQL"
                Fecha creación="03-2007"
                Creado por="Elias Calderón A."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar el nombre del cliente al que pertenece el abonado,  extrayendo el Codigo del cliente desde el campo NUM_CELULAR_NUE registrado en la ICC_MOVIMIENTO</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

AS
        LN_id_empresa ga_abocel.Cod_Cliente%TYPE;
        LV_nom_cliente ge_clientes.nom_cliente%TYPE;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

BEGIN
         BEGIN
            sSql := 'SELECT NVL(num_celular_nue,0)';
            sSql := sSql||' INTO LN_id_empresa';
            sSql := sSql||' FROM icc_movimiento';
            sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

            SELECT
                    NVL(num_celular_nue,0)
            INTO
                    LN_id_empresa
            FROM
                    icc_movimiento
            WHERE
                    num_movimiento = EN_num_mov;

         END;

                 IF LN_id_empresa <> 0 THEN
                        BEGIN
                                 BEGIN
                                                         sSql := 'SELECT TRIM(nom_cliente)';
                             sSql := sSql||' INTO LV_nom_cliente';
                             sSql := sSql||' FROM ge_clientes';
                             sSql := sSql||' WHERE cod_cliente = '||LN_id_empresa;

                             SELECT
                                    TRIM(nom_cliente)
                             INTO
                                    LV_nom_cliente
                             FROM
                                    ge_clientes
                             WHERE
                                    cod_cliente = LN_id_empresa;

                                                  EXCEPTION
                             WHEN OTHERS THEN
                              LN_cod_retorno := CN_Err_Cli;
                              IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                  LV_mens_retorno := CV_Err_NoClasif;
                              END IF;
                                  LV_des_error := 'IC_Param_Atlantida_PG.IC_NombreEmpresa_Icc_Mov_FN('||EN_num_mov||'); - ' || SQLERRM;
                                  LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_NombreEmpresa_Icc_Mov_FN',sSql,SQLCODE,LV_des_error);
                                  RETURN 'FALSE';
                          END;

                          RETURN LV_nom_cliente;
                              END;

          ELSE
                        RETURN 'FALSE:NO SE ENCONTRO EL CÓDIGO DE CLIENTE';
                  END IF;



EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_NombreEmpresa_Icc_Mov_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_NombreEmpresa_Icc_Mov_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;





FUNCTION IC_ValidaCambioPlan_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ValidaCambioPlan_FN"
                Lenguaje="PL/SQL"
                Fecha creación="07-2006"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para determinar si se permite o no la ejecucion de comando de Cambio de Plan.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_existeooss  NUMBER := 0;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;
        LV_ServiciosATL   VARCHAR2(50);

BEGIN

        -- Validacion - Procedure de CRM.
        PV_ObtieneInfo_Atlantida_PG.PV_ESCAMBIOPLAN_ATL_PR(EN_num_mov, LN_existeooss, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
        IF LN_existeooss IS NULL THEN
                LN_cod_retorno := CN_Err_TipPlan;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_ValidaCambioPlan_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ValidaCambioPlan_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
        END IF;

        IF LN_existeooss = 1 THEN    -- Se interpreta al reves para efectos de Centrales.
           RETURN 'FALSE';  -- No permite la ejecucion en Centrales.
        ELSE
           RETURN CV_Ejecuta; -- Permite ejecucion en Centrales.
        END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_TipPlan;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_Param_Atlantida_PG.IC_ValidaCambioPlan_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ValidaCambioPlan_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END;
------------------------------------------------------------------------
FUNCTION IC_ValTipoPlanTarif_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN NUMBER IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ValTipoPlanTarif_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para validar el tipo Hibrido del abonado</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_tiplan ta_plantarif.cod_tiplan%TYPE;
        LV_hibrido VARCHAR2(60);
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida NUMBER;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT
                icc.num_abonado
        INTO
                LN_num_abonado
        FROM
                icc_movimiento icc
        WHERE
                icc.num_movimiento = EN_Num_Mov;

        -- Datos basicos del abonado.-
        BEGIN
                sSql := 'SELECT abo.cod_plantarif';
                sSql := sSql||' INTO LV_cod_plantarif';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                SELECT
                        abo.cod_plantarif
                INTO
                        LV_cod_plantarif
                FROM
                        ga_abocel abo
                WHERE
                        abo.num_abonado = LN_num_abonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_plantarif';
                                sSql := sSql||' INTO LV_cod_plantarif';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                                SELECT
                                        abo.cod_plantarif
                                INTO
                                        LV_cod_plantarif
                                FROM
                                        ga_aboamist abo
                                WHERE
                                        abo.num_abonado = LN_num_abonado;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 0;
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LV_salida := 0;
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LV_salida := 0;
                        RETURN LV_salida;
        END;

        -- Determina el tipo de plan.
        sSql := 'SELECT plant.cod_tiplan';
        sSql := sSql||' INTO LN_cod_tiplan';
        sSql := sSql||' FROM ta_plantarif plant';
        sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
        sSql := sSql||' AND plant.cod_plantarif = '||LV_cod_plantarif;

        SELECT
                plant.cod_tiplan
        INTO
                LN_cod_tiplan
        FROM
                ta_plantarif plant
        WHERE
                plant.cod_producto = CN_Producto
                AND plant.cod_plantarif = LV_cod_plantarif;


        LV_salida := LN_cod_tiplan;

        RETURN LV_salida;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 0;
                RETURN LV_salida;
        WHEN OTHERS THEN

                LV_salida := 0;
                RETURN LV_salida;
END;

------------------------------------------------------------------------
FUNCTION IC_ATLADATOSLINEA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ATLADATOSLINEA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos relacionados con la Línea Atlantida</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Tecno icc_movimiento.tip_tecnologia%TYPE;
        LV_Retorno VARCHAR2(200);
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
BEGIN

       -- Datos basicos desde el movimiento.-
            sSql := 'SELECT icc.num_abonado, NVL(icc.tip_tecnologia,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_Tecno';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

            SELECT icc.num_abonado, NVL(icc.tip_tecnologia,CHR(0))
        INTO LN_num_abonado, LV_Tecno
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
            RAISE error_proceso;
        END IF;

            -- Datos basicos del abonado.-
            BEGIN
            sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min';
            sSql := sSql||' FROM GA_ABOCEL abo';
            sSql := sSql||' WHERE abo.NUM_ABONADO = '||LN_num_abonado;

                SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min
            FROM GA_ABOCEL abo
                WHERE abo.NUM_ABONADO = LN_num_abonado;

                EXCEPTION
            WHEN NO_DATA_FOUND THEN

                BEGIN

                          sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min';
                  sSql := sSql||' FROM GA_ABOAMIST abo';
                  sSql := sSql||' WHERE abo.NUM_ABONADO = '||LN_num_abonado;

                  SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min
                  FROM GA_ABOAMIST abo
                          WHERE abo.NUM_ABONADO = LN_num_abonado;

                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                            LN_cod_retorno := CN_Err_Abo;
                    IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                            LV_mens_retorno := CV_Err_NoClasif;
                    END IF;
                                LV_des_error := 'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN('||EN_num_mov||'); - ' || SQLERRM;
                    LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN',sSql,SQLCODE,LV_des_error);
                    RETURN 'ERROR AL BUSCAR DATOS PARA EL ABONADO';
                END;

        END;

        -- De acuerdo a la tecnologia del abonado, decide los datos a retornar.-
            IF LV_Tecno = CV_TecnoGSM THEN
           LV_imsi := fRecuperSIMCARD_FN(LV_num_serie,'IMSI');
           RETURN 'minimsi='||LV_imsi;
        ELSE
                IF LV_Tecno = CV_TecnoTDMA OR LV_Tecno = CV_TecnoCDMA THEN
                   RETURN 'esnLinea='||LV_num_serie||',minimsi='||LV_num_min;
                END IF;
        END IF;

EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_ATLADATOSLINEA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;

--------------------------------------------------------------------------------------
FUNCTION IC_CTAPERMODIF_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CTAPERMODIF_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion="11-2006"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para ser usada en la actuación de mantención de numero personal</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Tecno icc_movimiento.tip_tecnologia%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LV_Retorno VARCHAR2(200);
        LV_num_cel icc_movimiento.num_celular%TYPE;
        LV_num_cel_nue icc_movimiento.num_celular_nue%TYPE;
        LV_num_atla GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE;
        LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LN_idempre_atla GA_ABOCEL.cod_cliente%TYPE;
        LN_tipo_plan ta_plantarif.COD_TIPLAN%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN

        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue, NVL(icc.tip_tecnologia,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue, LV_Tecno';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

            SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue, NVL(icc.tip_tecnologia,CHR(0))
        INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue, LV_Tecno
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
             RAISE error_proceso;
        END IF;


       -- Busca Número Atlántida del cual es numero personal.-
        BEGIN

                sSql := 'SELECT per.NUM_CEL_CORP, per.COD_ESTADO ';
                sSql := sSql||' INTO LV_num_atla, LN_estado_num';
                sSql := sSql||' FROM GA_NUMCEL_PERSONAL_TO per';
                sSql := sSql||' WHERE per.num_cel_pers = '||LV_num_cel;

                SELECT per.NUM_CEL_CORP, per.COD_ESTADO
                    INTO LV_num_atla, LN_estado_num
            FROM GA_NUMCEL_PERSONAL_TO per
            WHERE per.num_cel_pers = LV_num_cel;

                EXCEPTION
                WHEN OTHERS THEN     -- El Numero de celular no es Cuenta Personal.
                                 RETURN 'FALSE';
            END;

        -- Busca datos para el Número Atlántida.-
        BEGIN
                sSql := 'SELECT abo.cod_cliente';
                sSql := sSql||'INTO LN_idempre_atla';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_atla;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                        SELECT abo.cod_cliente
                INTO LN_idempre_atla
                        FROM ga_abocel abo
                                WHERE abo.NUM_CELULAR = LV_num_atla
                                AND abo.COD_SITUACION = CV_AltaActivAbo;

        EXCEPTION
        WHEN OTHERS THEN
                   LN_cod_retorno := CN_Err_Abo;
               IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_Err_NoClasif;
               END IF;
               LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN('||EN_num_mov||'); - ' || SQLERRM;
               LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN',sSql,SQLCODE,LV_des_error);
               RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR ATLANTIDA';
        END;


        --  Los Estados CN_EstSuspen y CN_EstActivo, indican el estado actual de la relacion de cta personal.-
        -- Implican que se trata de una Rehabilitacion y Suspension respectivamente.- (lo que se debe hacer.).-
        -- Si el numero de Cta Personal esta Suspendido, se debe Asociar. (Es un mov de Rehabilitacion).-
        -- Si el numero de Cta Personal esta Activo, se debe Desasociar (Es un mov de Suspension).-


        -- Según el Estado del número Personal en tabla GA_NUMCEL_PERSONAL_TO,
            --  determina la forma de rescatar los datos para el número personal (actual o nuevo).-

        IF LN_estado_num = CN_EstPendElim OR LN_estado_num = CN_EstPendCrea
                   OR LN_estado_num = CN_EstSuspen OR LN_estado_num = CN_EstActivo THEN

         -- Busca datos para el Número Personal Actual.- (con el abonado)

            BEGIN

                sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min';
                sSql := sSql||' FROM GA_ABOCEL abo';
                sSql := sSql||' WHERE abo.NUM_ABONADO = '||LN_num_abonado;

                    SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min
                        FROM GA_ABOCEL abo
                                WHERE abo.NUM_ABONADO = LN_num_abonado;

                                EXCEPTION
                        WHEN NO_DATA_FOUND THEN

                        BEGIN

                                    sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min';
                    sSql := sSql||' FROM GA_ABOAMIST abo';
                            sSql := sSql||' WHERE abo.NUM_ABONADO = '||LN_num_abonado;

                            SELECT abo.num_serie, abo.NUM_MIN_MDN INTO LV_num_serie, LV_num_min
                            FROM GA_ABOAMIST abo
                            WHERE abo.NUM_ABONADO = LN_num_abonado;

                        EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                           LN_cod_retorno := CN_Err_Abo;
                               IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                       LV_mens_retorno := CV_Err_NoClasif;
                               END IF;
                                           LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN('||EN_num_mov||'); - ' || SQLERRM;
                                   LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN',sSql,SQLCODE,LV_des_error);
                                   RETURN 'ERROR AL BUSCAR DATOS PARA EL ABONADO';
                        END;
                    END;


                -- Según el Tipo de plan, determina el parametro para retornar el numero personal.-

                BEGIN
                LN_tipo_plan := IC_Param_Atlantida_PG.IC_VALTIPOPLANTARIF_FN(EN_num_mov);

                -- Según el Estado del número Personal en tabla GA_NUMCEL_PERSONAL_TO
                    -- y el tipo de plan, determina el parametro de numero personal.-

                -- Si el Estado del numero personal es Pendiente de Creación o esta Suspendido (hay que asociar).-
                    IF LN_estado_num = CN_EstPendCrea OR LN_estado_num = CN_EstSuspen THEN

                                IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                                    LV_Retorno:='perprep='||LV_num_cel;

                            ELSE
                                    IF LN_tipo_plan = CN_PlanPost THEN

                                        LV_Retorno:='percon='||LV_num_cel;

                                    END IF;

                                END IF;
                    END IF;


                -- Si el Estado del numero personal es Pendiente de Eliminación o está Activo ( hay que desasociar).-.
                -- Se retorna parametro para desasociación.-
                        IF LN_estado_num = CN_EstPendElim OR LN_estado_num = CN_EstActivo THEN

                                IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                                LV_Retorno:='perprep=0';

                            ELSE
                                    IF LN_tipo_plan = CN_PlanPost THEN

                                            LV_Retorno:='percon=0';

                                        END IF;

                                END IF;
                        END IF;

                END;


        END IF;

       -- Si el Estado del numero personal es Pendiente de Modificación.-
           -- Se busca datos en base al num_celular_nue del movimiento. (Nuevo numero de Cuenta Personal).-

           IF LN_estado_num = CN_EstPendModi THEN

          -- Busca datos para el Número Personal Nuevo.-

                  BEGIN
                sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN, abo.cod_plantarif, NVL(abo.cod_tecnologia,CHR(0))';
                sSql := 'INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno';
                sSql := sSql||' FROM GA_ABOCEL abo';
                sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_cel_nue;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                        SELECT abo.num_serie, abo.NUM_MIN_MDN, abo.cod_plantarif, NVL(abo.cod_tecnologia,CHR(0))
                INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno
                        FROM GA_ABOCEL abo
                                WHERE abo.NUM_CELULAR = LV_num_cel_nue
                                AND abo.COD_SITUACION = CV_AltaActivAbo;

                                EXCEPTION
                        WHEN NO_DATA_FOUND THEN

                        BEGIN

                                  sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN. NVL(abo.cod_plantarif,CHR(0)), NVL(abo.cod_tecnologia,CHR(0))';
                  sSql := sSql||'INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno';
                          sSql := sSql||' FROM GA_ABOAMIST abo';
                          sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_cel_nue;
                                  sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                          SELECT abo.num_serie, abo.NUM_MIN_MDN, NVL(abo.cod_plantarif,CHR(0)), NVL(abo.cod_tecnologia,CHR(0))
                  INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno
                          FROM GA_ABOAMIST abo
                          WHERE abo.NUM_CELULAR = LV_num_cel_nue
                                  AND abo.COD_SITUACION = CV_AltaActivAbo;

                          EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                           LN_cod_retorno := CN_Err_Abo;
                                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                        LV_mens_retorno := CV_Err_NoClasif;
                                END IF;
                                           LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN('||EN_num_mov||'); - ' || SQLERRM;
                                   LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN',sSql,SQLCODE,LV_des_error);
                                   RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR NUEVO';
                        END;
           END;

           -- Determina el tipo de plan.-
           sSql := 'SELECT plant.cod_tiplan';
           sSql := sSql||' INTO LN_tipo_plan';
           sSql := sSql||' FROM ta_plantarif plant';
           sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
           sSql := sSql||' AND plant.cod_plantarif = '||LV_cod_plantarif;

           SELECT
                   plant.cod_tiplan
           INTO
                   LN_tipo_plan
           FROM
                   ta_plantarif plant
           WHERE
                   plant.cod_producto = CN_Producto
                   AND plant.cod_plantarif = LV_cod_plantarif;


            -- Según el Tipo de plan del celular nuevo, determina el parametro para retornar el Nuevo Número Personal.-

                        IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                           LV_Retorno:='percon=0,perprep='||LV_num_cel_nue;

                        ELSE
                                IF LN_tipo_plan = CN_PlanPost THEN

                                   LV_Retorno:='percon='||LV_num_cel_nue||',perprep=0';

                                END IF;

                        END IF;

       END IF;


       -- Según la Tecnologia del Número Personal (actual o nuevo)
       -- y el Estado del Número Personal actual en tabla GA_NUMCEL_PERSONAL_TO,
       -- determina los parametros a retornar para el Número Personal.-

           IF LV_Tecno = CV_TecnoGSM THEN

           -- Datos para Modificacion o Creación de Numero Personal o Rehabilitacion.-
           IF LN_estado_num = CN_EstPendModi OR LN_estado_num = CN_EstPendCrea OR LN_estado_num = CN_EstSuspen THEN
               LV_imsi := fRecuperSIMCARD_FN(LV_num_serie,'IMSI');
                       RETURN LV_num_atla||','||LV_Retorno||',esnCtaPer=0,'||'minimsiCtaP='||LV_imsi||',idEmpresa='||to_char(LN_idempre_atla);
               END IF;
           -- Datos para eliminación de Número Personal o Suspensión.-
               IF LN_estado_num = CN_EstPendElim OR LN_estado_num = CN_EstActivo THEN
                       RETURN LV_num_atla||','||LV_Retorno||',minimsiCtaP=0'||',idEmpresa='||to_char(LN_idempre_atla);
               END IF;

       ELSE

                   IF LV_Tecno = CV_TecnoTDMA OR LV_Tecno = CV_TecnoCDMA THEN

               -- Datos para Modificacion o Creacion de Numero Personal o Rehabilitación.-
                   IF LN_estado_num = CN_EstPendModi OR LN_estado_num = CN_EstPendCrea OR LN_estado_num = CN_EstSuspen THEN
                                        RETURN LV_num_atla||','||LV_Retorno||',esnCtaPer='||LV_num_serie||',minimsiCtaP='||LV_num_min||',idEmpresa='||to_char(LN_idempre_atla);
                           END IF;
               -- Datos para eliminación de Número Personal o Suspensión.-
                           IF LN_estado_num = CN_EstPendElim OR LN_estado_num = CN_EstActivo THEN
                                        RETURN LV_num_atla||','||LV_Retorno||',esnCtaPer=0,minimsiCtaP=0'||',idEmpresa='||to_char(LN_idempre_atla);
                           END IF;

                   END IF;
           END IF;

EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERMODIF_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;

---------------------------------------------------------------------------------
FUNCTION IC_CTAPERBAJA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CTAPERBAJA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion="11-2006"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para ser usada en las bajas de número cuenta personal</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Tecno icc_movimiento.tip_tecnologia%TYPE;
        LV_Retorno VARCHAR2(200);
        LV_num_cel icc_movimiento.num_celular%TYPE;
        LV_num_atla GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE;
        LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LN_idempre_atla GA_ABOCEL.cod_cliente%TYPE;
        LN_tipo_plan ta_plantarif.COD_TIPLAN%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN

        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado, icc.num_celular, NVL(icc.tip_tecnologia,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_num_cel, LV_Tecno';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

            SELECT icc.num_abonado, icc.num_celular, NVL(icc.tip_tecnologia,CHR(0))
        INTO LN_num_abonado, LV_num_cel, LV_Tecno
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
             RAISE error_proceso;
        END IF;


       -- Busca Número Atlántida del cual es número personal.-
            BEGIN

            sSql := 'SELECT per.NUM_CEL_CORP, per.COD_ESTADO ';
                sSql := sSql||' INTO LV_num_atla, LN_estado_num';
                sSql := sSql||' FROM GA_NUMCEL_PERSONAL_TO per';
            sSql := sSql||' WHERE per.num_cel_pers = '||LV_num_cel;

            SELECT per.NUM_CEL_CORP, per.COD_ESTADO
            INTO LV_num_atla, LN_estado_num
            FROM GA_NUMCEL_PERSONAL_TO per
            WHERE per.num_cel_pers = LV_num_cel;

            EXCEPTION
                   WHEN OTHERS THEN     -- El Numero de celular no es Cuenta Personal.
                                   RETURN 'FALSE';
        END;

        -- Busca datos para el Número Atlántida.-
        BEGIN
                sSql := 'SELECT abo.cod_cliente';
                sSql := sSql||'INTO LN_idempre_atla';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_atla;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                        SELECT abo.cod_cliente
                INTO LN_idempre_atla
                        FROM ga_abocel abo
                                WHERE abo.NUM_CELULAR = LV_num_atla
                                AND abo.COD_SITUACION = CV_AltaActivAbo;

        EXCEPTION
        WHEN OTHERS THEN
                   LN_cod_retorno := CN_Err_Abo;
               IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_Err_NoClasif;
               END IF;
               LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN('||EN_num_mov||'); - ' || SQLERRM;
               LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN',sSql,SQLCODE,LV_des_error);
               RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR ATLANTIDA';
        END;


        -- Según el tipo de plan, determina el parametro para retornar el valor para la baja.-
            BEGIN

                        LN_tipo_plan := IC_Param_Atlantida_PG.IC_VALTIPOPLANTARIF_FN(EN_num_mov);

                        IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                            LV_Retorno:='perprep=0';

                        ELSE
                                IF LN_tipo_plan = CN_PlanPost THEN

                                    LV_Retorno:='percon=0';

                                END IF;

                        END IF;

            END;

        -- De acuerdo a la tecnologia, decide los datos a retornar para la baja.-
            IF LV_Tecno = CV_TecnoGSM THEN
                      RETURN LV_num_atla||','||LV_Retorno||',minimsiCtaP=0'||',idEmpresa='||to_char(LN_idempre_atla);
        ELSE
                    IF LV_Tecno = CV_TecnoTDMA OR LV_Tecno = CV_TecnoCDMA THEN
                            RETURN LV_num_atla||','||LV_Retorno||',esnCtaPer=0,minimsiCtaP=0'||',idEmpresa='||to_char(LN_idempre_atla);
            END IF;
        END IF;

EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERBAJA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;

---------------------------------------------------------------------------------
FUNCTION IC_CTAPERCAMNUM_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CTAPERCAMNUM_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion="11-2006"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para ser usada en las bajas de número cuenta personal</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Tecno icc_movimiento.tip_tecnologia%TYPE;
        LV_cod_plantarif ga_abocel.cod_plantarif%TYPE;
        LV_plantarif_abo ga_abocel.cod_plantarif%TYPE;
        LN_cod_cliente   ga_abocel.cod_cliente%TYPE;
        LV_Retorno VARCHAR2(200);
        LV_num_cel icc_movimiento.num_celular%TYPE;
        LV_num_cel_nue icc_movimiento.num_celular_nue%TYPE;
        LV_num_atla GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE;
        LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LN_idempre_atla GA_ABOCEL.cod_cliente%TYPE;
        LN_tipo_plan ta_plantarif.COD_TIPLAN%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN

        -- Datos basicos desde el movimiento.-
            sSql := 'SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue, NVL(icc.tip_tecnologia,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue, LV_Tecno';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue, NVL(icc.tip_tecnologia,CHR(0))
        INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue, LV_Tecno
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
             RAISE error_proceso;
        END IF;

        -- Busca Número Atlántida del cual es número personal.-
        BEGIN

                    sSql := 'SELECT per.NUM_CEL_CORP, per.COD_ESTADO ';
                sSql := sSql||' INTO LV_num_atla, LN_estado_num';
                sSql := sSql||' FROM GA_NUMCEL_PERSONAL_TO per';
                sSql := sSql||' WHERE per.num_cel_pers = '||LV_num_cel;

                SELECT per.NUM_CEL_CORP, per.COD_ESTADO
                INTO LV_num_atla, LN_estado_num
                FROM GA_NUMCEL_PERSONAL_TO per
                WHERE per.num_cel_pers = LV_num_cel;

                EXCEPTION
                WHEN OTHERS THEN     -- El Numero de celular no es Cuenta Personal.
                                 RETURN 'FALSE';
        END;

        -- Busca datos para el Número Atlántida.-
        BEGIN
                sSql := 'SELECT abo.cod_cliente';
                sSql := sSql||'INTO LN_idempre_atla';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_atla;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                        SELECT abo.cod_cliente
                INTO LN_idempre_atla
                        FROM ga_abocel abo
                                WHERE abo.NUM_CELULAR = LV_num_atla
                                AND abo.COD_SITUACION = CV_AltaActivAbo;

        EXCEPTION
        WHEN OTHERS THEN
                   LN_cod_retorno := CN_Err_Abo;
               IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_Err_NoClasif;
               END IF;
               LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN('||EN_num_mov||'); - ' || SQLERRM;
               LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN',sSql,SQLCODE,LV_des_error);
               RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR ATLANTIDA';
        END;

        -- Busca datos para el Número Personal Nuevo.-

        -- Busca datos en la GA_ABOCEL. El plan podria ocuparlo o no, dependiendo de la siguiente query posterior.-
        BEGIN
                    sSql := 'SELECT abo.cod_plantarif, abo.cod_cliente';
                    sSql := sSql||' INTO LV_plantarif_abo, LN_cod_cliente';
                    sSql := sSql||' FROM ga_abocel abo';
                    sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                    SELECT
                            abo.cod_plantarif, abo.cod_cliente
                    INTO
                            LV_plantarif_abo, LN_cod_cliente
                    FROM
                            ga_abocel abo
                    WHERE
                            abo.num_abonado = LN_num_abonado;

        EXCEPTION
                    WHEN NO_DATA_FOUND THEN

            BEGIN

                  sSql := 'SELECT NVL(abo.cod_plantarif,CHR(0)), abo.cod_cliente';
                  sSql := sSql||' INTO LV_plantarif_abo, LN_cod_cliente';
                  sSql := sSql||' FROM ga_aboamist abo';
                  sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                  SELECT
                          NVL(abo.cod_plantarif,CHR(0)), abo.cod_cliente
                  INTO
                          LV_plantarif_abo, LN_cod_cliente
                  FROM
                          ga_aboamist abo
                  WHERE
                          abo.num_abonado = LN_num_abonado;

            EXCEPTION
                  WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'ERROR AL BUSCAR DATOS PARA EL ABONADO';
                    END;

        END;


        BEGIN
                sSql := 'SELECT fin.cod_plantarif';
                sSql := sSql||' INTO LV_cod_plantarif';
                sSql := sSql||' FROM ga_finciclo fin';
                sSql := sSql||' WHERE fin.cod_cliente = '||LN_cod_cliente;
                sSql := sSql||' AND fin.num_Abonado = '||LN_num_abonado;
                sSql := sSql||' AND fin.cod_ciclfact IS NOT NULL';
                sSql := sSql||' AND fin.cod_plantarif IS NOT NULL';

                SELECT
                        fin.cod_plantarif
                INTO
                        LV_cod_plantarif
                FROM
                        ga_finciclo fin
                WHERE
                        fin.cod_cliente = LN_cod_cliente
                        AND fin.num_abonado = LN_num_abonado
                        AND fin.cod_ciclfact IS NOT NULL
                        AND fin.cod_plantarif IS NOT NULL;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN     -- Si no encuentra plan en la ga_finciclo, no hay Cambio de plan pendiente,-
                        LV_cod_plantarif := LV_plantarif_abo; -- usa el plan de GA_ABOCEL o GA_ABOAMIST.-
                WHEN OTHERS THEN
                            LN_cod_retorno := CN_Err_TipPlan;
                            IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                    LV_mens_retorno := CV_Err_NoClasif;
                            END IF;
                            LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN('||EN_num_mov||'); - ' || SQLERRM;
                            LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN',sSql,SQLCODE,LV_des_error);
                            RETURN 'ERROR AL BUSCAR DATOS DEL PLAN PARA EL ABONADO ';
        END;


        -- Determina el tipo de plan.-
        sSql := 'SELECT plant.cod_tiplan';
        sSql := sSql||' INTO LN_tipo_plan';
        sSql := sSql||' FROM ta_plantarif plant';
        sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
        sSql := sSql||' AND plant.cod_plantarif = '||LV_cod_plantarif;

        SELECT
                plant.cod_tiplan
        INTO
                LN_tipo_plan
        FROM
                ta_plantarif plant
        WHERE
                plant.cod_producto = CN_Producto
                AND plant.cod_plantarif = LV_cod_plantarif;



        -- Según el Tipo de plan, determina el parametro para retornar el Nuevo Número Personal.-

        IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

            LV_Retorno:='percon=0,perprep='||LV_num_cel_nue;

        ELSE
            IF LN_tipo_plan = CN_PlanPost THEN

                LV_Retorno:='percon='||LV_num_cel_nue||',perprep=0';

            END IF;

        END IF;

        -- El formato del retorno es igual para todas las tecnologias.-
        RETURN LV_num_atla||','||LV_Retorno||',idEmpresa='||to_char(LN_idempre_atla);


EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
     IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
             LV_mens_retorno := CV_Err_NoClasif;
     END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERCAMNUM_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;
--------------------------------------------------------------------------------------
FUNCTION IC_CTAPERMASIVO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CTAPERMASIVO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion="11-2006"
                Modificado por="Carlos Sellao H."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para ser usada en la actuación de mantención de numero personal</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Tecno icc_movimiento.tip_tecnologia%TYPE;
        LV_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LV_Retorno VARCHAR2(200);
        LV_num_cel icc_movimiento.num_celular%TYPE;
        LV_num_cel_nue icc_movimiento.num_celular_nue%TYPE;
        LV_num_atla GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE;
        LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LN_idempre_atla GA_ABOCEL.cod_cliente%TYPE;
        LN_tipo_plan ta_plantarif.COD_TIPLAN%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN

        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue';
        sSql := sSql||' INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

            SELECT icc.num_abonado, icc.num_celular, icc.num_celular_nue
        INTO LN_num_abonado, LV_num_cel, LV_num_cel_nue
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

       IF SQLCODE <> 0 THEN
            RAISE error_proceso;
       END IF;


       -- Datos basicos del celular o Cuenta Personal a Asociar.-

            BEGIN

            sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN, abo.cod_plantarif, NVL(abo.cod_tecnologia,CHR(0))';
                sSql := 'INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno';
            sSql := sSql||' FROM GA_ABOCEL abo';
            sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_cel;
            sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                SELECT abo.num_serie, abo.NUM_MIN_MDN, abo.cod_plantarif, NVL(abo.cod_tecnologia,CHR(0))
            INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno
                FROM GA_ABOCEL abo
                        WHERE abo.NUM_CELULAR = LV_num_cel
                        AND abo.COD_SITUACION = CV_AltaActivAbo;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN

                BEGIN

                        sSql := 'SELECT abo.num_serie, abo.NUM_MIN_MDN, NVL(abo.cod_plantarif,CHR(0)), NVL(abo.cod_tecnologia,CHR(0))';
                sSql := 'INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno';
                sSql := sSql||' FROM GA_ABOAMIST abo';
                    sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_cel;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                    SELECT abo.num_serie, abo.NUM_MIN_MDN, NVL(abo.cod_plantarif,CHR(0)), NVL(abo.cod_tecnologia,CHR(0))
                INTO LV_num_serie, LV_num_min, LV_cod_plantarif, LV_Tecno
                FROM GA_ABOAMIST abo
                WHERE abo.NUM_CELULAR = LV_num_cel
                AND abo.COD_SITUACION = CV_AltaActivAbo;

                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                                   LN_cod_retorno := CN_Err_Abo;
                       IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                             LV_mens_retorno := CV_Err_NoClasif;
                       END IF;
                                   LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN('||EN_num_mov||'); - ' || SQLERRM;
                           LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN',sSql,SQLCODE,LV_des_error);
                           RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR NUEVO';
                END;
            END;


        -- Determina el tipo de plan.-
        sSql := 'SELECT plant.cod_tiplan';
        sSql := sSql||' INTO LN_tipo_plan';
        sSql := sSql||' FROM ta_plantarif plant';
        sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
        sSql := sSql||' AND plant.cod_plantarif = '||LV_cod_plantarif;

        SELECT
                plant.cod_tiplan
        INTO
                LN_tipo_plan
        FROM
                ta_plantarif plant
        WHERE
                plant.cod_producto = CN_Producto
                AND plant.cod_plantarif = LV_cod_plantarif;


        -- Según el tipo de plan, determina el parametro para retornar el Número personal.-

                IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                    LV_Retorno:='perprep='||LV_num_cel;

                ELSE
                        IF LN_tipo_plan = CN_PlanPost THEN

                            LV_Retorno:='percon='||LV_num_cel;

                        END IF;

                END IF;

        LV_num_atla := LV_num_cel_nue;  -- El numero de celular nuevo es el Numero Corporativo o Atlantida.-

        -- Busca datos para el Número Atlántida.-
        BEGIN
                sSql := 'SELECT abo.cod_cliente';
                sSql := sSql||'INTO LN_idempre_atla';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.NUM_CELULAR = '||LV_num_atla;
                sSql := sSql||' AND abo.COD_SITUACION = '||CV_AltaActivAbo;

                        SELECT abo.cod_cliente
                INTO LN_idempre_atla
                        FROM ga_abocel abo
                                WHERE abo.NUM_CELULAR = LV_num_atla
                                AND abo.COD_SITUACION = CV_AltaActivAbo;

        EXCEPTION
        WHEN OTHERS THEN
                   LN_cod_retorno := CN_Err_Abo;
               IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_Err_NoClasif;
               END IF;
               LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN('||EN_num_mov||'); - ' || SQLERRM;
               LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN',sSql,SQLCODE,LV_des_error);
               RETURN 'ERROR AL BUSCAR DATOS PARA EL CELULAR ATLANTIDA';
        END;

        -- De acuerdo a la tecnologia del Número de Cuenta Personal (num_celular), decide los datos a retornar.-

            IF LV_Tecno = CV_TecnoGSM THEN
            LV_imsi := fRecuperSIMCARD_FN(LV_num_serie,'IMSI');

            RETURN LV_num_atla||','||LV_Retorno||',esnCtaPer=0,'||'minimsiCtaP='||LV_imsi||',idEmpresa='||to_char(LN_idempre_atla);
        ELSE
                IF LV_Tecno = CV_TecnoTDMA OR LV_Tecno = CV_TecnoCDMA THEN
                  RETURN LV_num_atla||','|| LV_Retorno||',esnCtaPer='||LV_num_serie||',minimsiCtaP='||LV_num_min||',idEmpresa='||to_char(LN_idempre_atla);
                    END IF;
            END IF;

EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_CTAPERMASIVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;

---------------------------------------------------------------------------------
FUNCTION IC_ATLACUENTAPER_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTACUENTAPER_FN"
                Lenguaje="PL/SQL"
                Fecha creación="08-2006"
                Creado por="Igor Sanchez"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para ser usada en las bajas de número cuenta personal</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
-- VARIABLES
        LV_Retorno VARCHAR2(200);
        LV_num_cel icc_movimiento.num_celular%TYPE;
        LV_num_atla GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE;
        LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
        LV_imsi icc_movimiento.imsi%TYPE;
        LV_num_min GA_ABOCEL.num_min_mdn%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_num_serie GA_ABOCEL.num_serie%TYPE;
        LN_tipo_plan ta_plantarif.COD_TIPLAN%TYPE;
        error_proceso EXCEPTION;
        sSql GE_Errores_PG.vQuery;
        LV_des_error VARCHAR2(512);
        LN_num_evento GE_Errores_PG.evento;
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;

BEGIN

        -- Datos basicos desde el movimiento.-
        sSql := 'SELECT icc.num_abonado, icc.num_celular';
        sSql := sSql||' INTO LN_num_abonado, LV_num_cel';
        sSql := sSql||' FROM ICC_MOVIMIENTO icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

            SELECT icc.num_abonado, icc.num_celular
        INTO LN_num_abonado, LV_num_cel
        FROM ICC_MOVIMIENTO icc
        WHERE icc.num_movimiento = EN_num_mov;

        IF SQLCODE <> 0 THEN
             RAISE error_proceso;
        END IF;


        -- Busca Número Atlántida del cual es número personal.-
            BEGIN

                    sSql := 'SELECT per.NUM_CEL_CORP, per.COD_ESTADO ';
                sSql := sSql||' INTO LV_num_atla, LN_estado_num';
                sSql := sSql||' FROM GA_NUMCEL_PERSONAL_TO per';
                sSql := sSql||' WHERE per.num_cel_pers = '||LV_num_cel;

                SELECT per.NUM_CEL_CORP, per.COD_ESTADO
                INTO LV_num_atla, LN_estado_num
                FROM GA_NUMCEL_PERSONAL_TO per
                WHERE per.num_cel_pers = LV_num_cel;

                EXCEPTION
                WHEN OTHERS THEN     -- El Numero de celular no es Cuenta Personal.
                                RETURN 'FALSE';
            END;

        -- Según el tipo de plan, determina el parametro para retornar el numero personal.-
            BEGIN
                        LN_tipo_plan := IC_Param_Atlantida_PG.IC_VALTIPOPLANTARIF_FN(EN_num_mov);

                        IF LN_tipo_plan = CN_PlanPrep OR LN_tipo_plan = CN_PlanHibr THEN

                        LV_Retorno:='perprep='||LV_num_cel;

                        ELSE
                                IF LN_tipo_plan = CN_PlanPost THEN

                                    LV_Retorno:='percon='||LV_num_cel;

                                END IF;

                        END IF;
            END;

            RETURN LV_num_atla||','||LV_Retorno;

EXCEPTION
    WHEN error_proceso THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_Abo;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
              LV_mens_retorno := CV_Err_NoClasif;
      END IF;
          LV_des_error := 'IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN',sSql,SQLCODE,LV_des_error);
      RETURN 'ERROR IC_Param_Atlantida_PG.IC_ATLACUENTAPER_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;

END;

END IC_Param_Atlantida_PG;
/
SHOW ERRORS
