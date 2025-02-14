CREATE OR REPLACE PACKAGE BODY CO_PAGOSONLINE_PG IS

        CV_ErrorNoClasificado CONSTANT VARCHAR2(25) := 'Error no clasificado';

/*********************************************************************************************/
        FUNCTION CO_OBTIENEMODULO_PR(EN_codcliente IN ge_clientes.cod_cliente%TYPE) RETURN PLS_INTEGER IS
        /*Obtiene Módulo del cliente*/
        LN_modulo PLS_INTEGER := 0;
        BEGIN
            IF LENGTH(EN_codcliente) >= 2 THEN
                LN_modulo := MOD(SUBSTR(EN_codcliente,LENGTH(EN_codcliente)-1,2),10);
            ELSE
                LN_modulo := EN_codcliente;
            END IF;
            RETURN LN_modulo;
        END;

        PROCEDURE CO_OBTIENE_PARAMETRO_PR (
                ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
                en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
                ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
                sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
                sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
        ) IS
        /*
        <Documentación
          TipoDoc = "PROCEDURE">
           <Elemento
              Nombre = "CO_OBTIENEMODULO_PR
              Lenguaje="PL/SQL"
              Fecha="04-06-2009"
              Versión="1.0"
              Diseñador="HQR"
              Programador="HQR"
              Ambiente Desarrollo="BD">
              <Retorno></Retorno>
              <Descripción>Obtiene Valor de un Parámetro</Descripción>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre de parametro </param>
                    <param nom="EV_cod_modulo   " Tipo="CARACTER">Codigo de Modulo    </param>
                    <param nom="EN_cod_producto " Tipo="NUMERICO">Cod.Producto Celular</param>
                 </Entrada>
                 <Salida>
                    <param nom="SV_val_parametro" Tipo="CARACTER">Valor parametro   </param>
                    <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
                    <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
            exception_ErrParam EXCEPTION;
            V_des_error         ge_errores_pg.DesEvent;
            LV_sql                ge_errores_pg.vQuery;
            LV_nomparametro    ged_parametros.nom_parametro%TYPE;
        BEGIN
            SN_cod_retorno := 0;
            SN_num_evento  := 0;
            SV_mens_retorno:= NULL;

            LV_sql := 'SELECT param.val_parametro';
            LV_sql := LV_sql || ' INTO EV_val_parametro';
            LV_sql := LV_sql || ' FROM ged_parametros param';
            LV_sql := LV_sql || ' WHERE nom_parametro = '|| EV_nom_parametro;
            LV_sql := LV_sql || ' AND cod_modulo = '|| EV_cod_modulo;
            LV_sql := LV_sql || ' AND cod_producto = '|| EN_cod_producto;

            SELECT param.val_parametro
              INTO SV_val_parametro
              FROM ged_parametros param
             WHERE nom_parametro = EV_nom_parametro
               AND cod_modulo = EV_cod_modulo
               AND cod_producto = EN_cod_producto;

        EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := 1362; --No es posible recuperar parametros generales
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ErrorNoClasificado;
                END IF;
                V_des_error := 'CO_PAGOSONLINE_PG.CO_OBTIENE_PARAMETRO_PR('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SV_mens_retorno, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENE_PARAMETRO_PR', LV_sql, SQLCODE, V_des_error );
        END CO_OBTIENE_PARAMETRO_PR;


        PROCEDURE CO_OBTIENETRANSACCION_PR(SN_numtransaccion OUT NOCOPY CO_INTERFAZ_PAGOS.NUM_TRANSACCION%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS
        sSQL varchar2(1000);

        BEGIN
            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            sSQL := 'SELECT CO_SEQ_TRANSACINT.NEXTVAL';
            SELECT CO_SEQ_TRANSACINT.NEXTVAL
            INTO SN_numtransaccion
            FROM DUAL;

        EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_error := 1238; --No es posible obtener secuencia de transacciones
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENECAJA_PR', sSql, SQLCODE, SQLERRM );
        END;
        PROCEDURE CO_OBTIENECAJA_PR(EV_emp IN CO_EMPRESAS_REX.EMP_RECAUDADORA%TYPE,
                                       SN_codcaja OUT NOCOPY CO_CAJAS.COD_CAJA%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS

        sSQL varchar2(1000);

        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            sSQL := 'SELECT cod_caja FROM co_empresas_rex WHERE emp_recaudadora = ' || EV_emp;
            SELECT cod_caja
            INTO SN_codcaja
            FROM co_empresas_rex
            WHERE emp_recaudadora = EV_emp;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 SN_cod_error := 2809;        --Caja asociada a Empresa Externa no se encuentra configurada.
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENECAJA_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2810;        --Error al obtener Caja asociada a Empresa Externa.
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENECAJA_PR', sSql, SQLCODE, SQLERRM );
        END;

/*********************************************************************************************/

       PROCEDURE CO_OBTIENECLIENTE_PR(EN_numcelular IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                       SN_codcliente OUT NOCOPY GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER)IS
        sSQL varchar2(1000);

        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            sSQL := 'SELECT cod_cliente FROM ga_abocel WHERE num_celular = ' || EN_numcelular;
            SELECT cod_cliente
            INTO SN_codcliente
            FROM ga_abocel
            WHERE num_celular = EN_numcelular
            AND cod_situacion != 'BAA';

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 SN_cod_error := 145; --El número de cliente asociado al celular no existe.
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENECLIENTE_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2811;    --Error al obtener Cliente asociado al Número de Celular
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_OBTIENECLIENTE_PR', sSql, SQLCODE, SQLERRM );
        END;

/*********************************************************************************************/
       PROCEDURE CO_SALDO_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_saldovencido OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_saldoporvencer OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS

        sSQL varchar2(1000);
        LN_saldovencido CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_saldoporvencer CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_limitetarifario CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_limiteadicional CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_indfacturado PLS_INTEGER := 1;
        LN_indporvencer PLS_INTEGER := 0;
        LV_nomtabla VARCHAR2(10) := 'CO_CARTERA';
        LV_nomcolumna VARCHAR2(11) := 'CO_TIPDOCUM';
        LN_modulo PLS_INTEGER := 0;
        ERROR_NO_CONTROLADO EXCEPTION;

        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            --Obtiene Saldo Vencido
            sSQL := 'SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0) FROM CO_CARTERA';
            SN_cod_error := 2671; --Error al obtener Monto Saldo Vencido
            BEGIN
            SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
            INTO LN_saldovencido
            FROM CO_CARTERA
            WHERE COD_CLIENTE = EN_codcliente
            AND IND_FACTURADO = LN_indfacturado
            AND FEC_VENCIMIE < TRUNC(SYSDATE)
            AND COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
            FROM CO_CODIGOS
            WHERE NOM_TABLA = LV_nomtabla
            AND NOM_COLUMNA = LV_nomcolumna);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_saldovencido := 0;
            END;

            --Obtiene Saldo por Vencer
            sSQL := 'SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0) FROM CO_CARTERA';
            SN_cod_error := 2672; --Error al obtener Monto Saldo por Vencer
            BEGIN
            SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
            INTO LN_saldoporvencer
            FROM CO_CARTERA
            WHERE COD_CLIENTE = EN_codcliente
            AND IND_FACTURADO = LN_indfacturado
            AND FEC_VENCIMIE >= TRUNC(SYSDATE)
            AND COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
            FROM CO_CODIGOS
            WHERE NOM_TABLA = LV_nomtabla
            AND NOM_COLUMNA = LV_nomcolumna);
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_saldoporvencer := 0;
            END;


            SN_saldovencido := LN_saldovencido;
            SN_saldoporvencer := LN_saldoporvencer;
            SN_cod_error := 0;

        EXCEPTION
            WHEN OTHERS THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_SALDO_PR', sSql, SQLCODE, SQLERRM );
        END;

       PROCEDURE CO_SALDO_LIMITE_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SN_limitetarifario OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_limiteadicional OUT NOCOPY CO_CARTERA.IMPORTE_DEBE%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS

        sSQL varchar2(1000);
        LN_limitetarifario CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_limiteadicional CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_modulo PLS_INTEGER := 0;
        LN_abonadoactual co_cartera.num_abonado%TYPE;
        LN_saldolimite CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_saldolimiteAdic CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LV_CodCiclo tol_cliente.cod_ciclo%TYPE;
        LD_FecIniVig tol_cliente.fec_ini_vig%TYPE;
        LV_CodPlan tol_cliente.cod_plan%TYPE;
        LV_CodBolsa tol_cliente.cod_bolsa%TYPE;
        LD_FecTasa tol_cronograma.fec_tasa%TYPE;
        LN_monto_pago_plan CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LN_monto_pago_adic CO_CARTERA.IMPORTE_DEBE%TYPE := 0;
        LB_revisar_abonado BOOLEAN;

        CURSOR ABONADOS_CLIENTE (EN_codcliente IN co_cartera.cod_cliente%TYPE) IS
        SELECT t.COD_ABONADO
        FROM TOL_CLIENTE t
        WHERE t.COD_CLIENTE = EN_codcliente
        AND EXISTS ( SELECT 1 FROM GA_ABOCEL WHERE CO_fGetTipPlanCelular( COD_PLANTARIF ) = 'POSTPAGO' AND NUM_ABONADO = T.COD_ABONADO)
        AND SYSDATE BETWEEN t.FEC_INI_VIG AND t.FEC_TER_VIG;

        ERROR_NO_CONTROLADO EXCEPTION;

        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            LN_modulo := CO_OBTIENEMODULO_PR(EN_codcliente);
            LN_saldolimite := 0;
            LN_saldolimiteAdic := 0;

            sSQL := 'Open Cursor ABONADOS_CLIENTE (' || EN_codcliente || ')';
            FOR rTramo IN ABONADOS_CLIENTE (EN_codcliente) LOOP

                LB_revisar_abonado := TRUE;
                LN_abonadoactual := rtramo.cod_abonado;
                SN_cod_error := 504; -- Problemas al Obtener el Código de ciclo del cliente.

                sSQL := 'SELECT a.cod_ciclo, MAX(a.fec_ini_vig), a.cod_plan, a.cod_bolsa FROM tol_cliente a';
                BEGIN
                SELECT a.cod_ciclo, MAX(a.fec_ini_vig), a.cod_plan, a.cod_bolsa
                INTO LV_CodCiclo, LD_FecIniVig , LV_CodPlan, LV_CodBolsa
                FROM tol_cliente a
                WHERE ( ( a.cod_abonado = 0  )  OR   ( a.cod_abonado= LN_abonadoactual ))
                AND a.cod_cliente = EN_codcliente
                AND SYSDATE BETWEEN fec_ini_vig AND fec_ter_vig
                GROUP BY a.cod_ciclo, a.cod_plan, a.cod_bolsa;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    LB_revisar_abonado := FALSE;
                END;

                IF LB_revisar_abonado THEN
                    sSQL := 'SELECT a.fec_tasa FROM tol_cronograma a';
                    SN_cod_error := 2812; --Error al obtener Fecha Tasa del Cliente
                    BEGIN
                    SELECT a.fec_tasa
                    INTO LD_FecTasa
                    FROM tol_cronograma a
                    WHERE a.cod_ciclo = LV_CodCiclo
                    AND a.est_proc ='ACTIV'
                    AND a.fec_inic <= SYSDATE
                    AND a.fec_term >= SYSDATE;
                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        LB_revisar_abonado := FALSE;
                    END;
                    --Monto Límite Plan Tarifario
                    IF LB_revisar_abonado THEN
                        SN_cod_error := 2813; --Error al obtener Monto Límite Plan Tarifario
                        sSQL := 'SELECT SUM(c.acu_consumo-c.acu_pagos)';
                        sSQL := sSQL || ' FROM tol_cliente a, ga_limite_cliabo_to b, lc_acumula_0' || LN_modulo || ' c, lc_limites d, lc_umbral f';
                        sSQL := sSQL || ' WHERE a.cod_cliente = ' || EN_codcliente;
                        sSQL := sSQL || ' AND a.cod_abonado = ' || LN_abonadoactual;
                        sSQL := sSQL || ' AND SYSDATE BETWEEN a.fec_ini_vig AND a.fec_ter_vig';
                        sSQL := sSQL || ' AND a.cod_plan = b.cod_plantarif';
                        sSQL := sSQL || ' AND b.cod_cliente = a.cod_cliente';
                        sSQL := sSQL || ' AND b.num_abonado = a.cod_abonado ';
                        sSQL := sSQL || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta , SYSDATE)';
                        sSQL := sSQL || ' AND c.cod_cliente = a.cod_cliente';
                        sSQL := sSQL || ' AND c.cod_abonado = a.cod_abonado';
                        sSQL := sSQL || ' AND c.fec_tasa = ' || LD_FecTasa;
                        sSQL := sSQL || ' AND c.cod_ciclo = ' || LV_CodCiclo;
                        sSQL := sSQL || ' AND c.cod_plan = a.cod_plan';
                        sSQL := sSQL || ' AND d.cod_limcons = b.cod_limcons';
                        sSQL := sSQL || ' AND d.cod_limcons = c.cod_limite';
                        sSQL := sSQL || ' AND d.fec_desde = ( SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons)';
                        sSQL := sSQL || ' AND f.cod_umbral = d.cod_umbral_min';
                        sSQL := sSQL || ' AND SYSDATE BETWEEN f.fec_ini_vig AND f.fec_ter_vig';
                        EXECUTE IMMEDIATE sSQL INTO LN_monto_pago_plan;
 
                        IF LN_monto_pago_plan IS NULL THEN
                            LN_monto_pago_plan := 0;
                        END IF;

                        SN_cod_error := 2814; --Error al obtener Monto Límite Planes Adicionales
                        sSQL := 'SELECT sum(c.acu_consumo-c.acu_pagos)';
                        sSQL := sSQL || ' FROM pr_productos_contratados_to a,';
                        sSQL := sSQL || ' se_detalles_especificacion_to b,';
                        sSQL := sSQL || ' lc_acumula_0' || LN_modulo || ' c,';
                        sSQL := sSQL || ' lc_limites d, lc_umbral f, pf_productos_ofertados_td g';
                        sSQL := sSQL || ' WHERE a.num_abonado_contratante = ' || LN_abonadoactual;
                        sSQL := sSQL || ' AND a.cod_cliente_contratante = ' || EN_codcliente;
                        sSQL := sSQL || ' AND c.cod_cliente = ' || EN_codcliente;
                        sSQL := sSQL || ' AND c.cod_abonado = ' || LN_abonadoactual;
                        sSQL := sSQL || ' AND c.fec_tasa = ' || LD_FecTasa;
                        sSQL := sSQL || ' AND c.cod_ciclo = ' || LV_CodCiclo;
                        sSQL := sSQL || ' AND c.cod_plan    = b.cod_servicio_base';
                        sSQL := sSQL || ' AND d.cod_limcons = c.cod_limite';
                        sSQL := sSQL || ' AND b.ind_tipo_servicio = ''TOL''';
                        sSQL := sSQL || ' AND a.cod_prod_ofertado = g.cod_prod_ofertado';
                        sSQL := sSQL || ' AND g.cod_espec_prod    = b.cod_espec_prod';
                        sSQL := sSQL || ' AND d.fec_desde <= (SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons)';
                        sSQL := sSQL || ' AND f.cod_umbral = d.cod_umbral_min';
                        sSQL := sSQL || ' AND (c.acu_consumo-c.acu_pagos) > 0';
                        EXECUTE IMMEDIATE sSQL INTO LN_monto_pago_adic;

                        IF LN_monto_pago_adic IS NULL THEN
                            LN_monto_pago_adic := 0;
                        END IF;

                        LN_saldolimite := LN_saldolimite + LN_monto_pago_plan;
                        LN_saldolimiteAdic := LN_saldolimiteAdic + LN_monto_pago_adic;
                    END IF;
                END IF;

            END LOOP;

            SN_limitetarifario := LN_saldolimite;
            SN_limiteadicional := LN_saldolimiteAdic;
            SN_cod_error := 0;

        EXCEPTION
            WHEN OTHERS THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_SALDO_LIMITE_PR', sSql, SQLCODE, SQLERRM );
        END;
/*********************************************************************************************/
       PROCEDURE CO_NOMBRECLIENTE_PR (EN_codcliente IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                       SV_nomcliente OUT NOCOPY GE_CLIENTES.NOM_CLIENTE%TYPE,
                                       SV_apecliente OUT NOCOPY GE_CLIENTES.NOM_APECLIEN1%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS
        sSQL varchar2(1000);

        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            sSQL := 'SELECT NOM_CLIENTE,NOM_APECLIEN1 || NOM_APECLIEN2 FROM GE_CLIENTES COD_CLIENTE = ' || EN_codcliente;
            SELECT NOM_CLIENTE,NOM_APECLIEN1 || ' ' || NOM_APECLIEN2
            INTO SV_nomcliente, SV_apecliente
            FROM GE_CLIENTES
            WHERE COD_CLIENTE = EN_codcliente;


        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 SN_cod_error := 2815; --No existe cliente asociado al Código de Cliente
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_NOMBRECLIENTE_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2816;    --Error al obtener Nombre del Cliente
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_NOMBRECLIENTE_PR', sSql, SQLCODE, SQLERRM );
        END;

       PROCEDURE CE_APLICA_PAGO_PR (EV_codbanco IN ge_bancos.cod_banco%TYPE,
                                       EN_codcaja IN co_cajas.cod_caja%TYPE,
                                       EV_codservicio IN co_interfaz_pagos.ser_solicitado%TYPE,
                                       EV_fecefectividad IN VARCHAR2,
                                       EN_numtransaccion IN co_interfaz_pagos.num_transaccion%TYPE,
                                       EV_operador IN co_interfaz_pagos.nom_usuarora%TYPE,
                                       EV_tiptransaccion IN co_interfaz_pagos.tip_transaccion%TYPE,
                                       EV_subtipo IN co_interfaz_pagos.sub_tip_transac%TYPE,
                                       EN_codservicio IN co_interfaz_pagos.cod_servicio%TYPE,
                                       EN_numejercicio IN co_interfaz_pagos.num_ejercicio%TYPE,
                                       EN_codcliente IN co_interfaz_pagos.cod_cliente%TYPE,
                                       EN_numcelular IN co_interfaz_pagos.num_celular%TYPE,
                                       EN_mtopago IN co_interfaz_pagos.mto_debe%TYPE,
                                       EV_numfolio IN co_interfaz_pagos.num_folioctc%TYPE,
                                       EN_tipvalor IN co_interfaz_pagos.tip_valor%TYPE,
                                       EN_numcheque IN co_interfaz_pagos.num_documento%TYPE,
                                       EV_bancocheque IN co_interfaz_pagos.cod_banco%TYPE,
                                       EV_ctacte IN co_interfaz_pagos.cta_corriente%TYPE,
                                       EV_autorizacion IN co_interfaz_pagos.cod_autoriza%TYPE,
                                       EN_numtarjeta IN co_interfaz_pagos.num_tarjeta%TYPE,
                                       EV_agencia IN co_interfaz_pagos.des_agencia%TYPE,
                                       EN_codoperacion IN co_interfaz_pagos.cod_operacion%TYPE,
                                       EN_numtransaccion_emp IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       EN_codtiptarjeta IN co_interfaz_pagos.cod_tiptarjeta%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS

        sSQL varchar2(1000);
        LN_contador PLS_INTEGER := 0;
        ERROR_CONTROLADO EXCEPTION;
        LN_valorcero PLS_INTEGER := 0;
        LV_formatofecha VARCHAR2(17) := 'YYYYMMDD HH24MISS';
        LN_numtransaccion co_interfaz_pagos.num_transaccion%TYPE;
        LN_numtransaccion_emp co_interfaz_pagos.num_transaccion_emp%TYPE;
        LN_fecpago DATE;
        BEGIN

            SN_cod_error := 0;
            SV_des_error := '';
            SN_cod_evento := 0;

            IF EV_bancocheque IS NOT NULL THEN
                sSQL := 'SELECT count(1) FROM GE_BANCOS WHERE COD_BANCO = ' || EV_bancocheque;

                SELECT count(1)
                INTO LN_contador
                FROM GE_BANCOS
                WHERE COD_BANCO = EV_bancocheque;
                IF LN_contador < 1 THEN
                   SN_cod_error := 2317; -- Codigo de Banco no existe
                   RAISE ERROR_CONTROLADO;
                END IF;
            END IF;
            
            IF EN_codtiptarjeta IS NOT NULL THEN
                sSQL := 'SELECT count(1) FROM GE_TIPTARJETAS WHERE COD_TIPTARJETA = ' || EN_codtiptarjeta;

                SELECT count(1)
                INTO LN_contador
                FROM GE_TIPTARJETAS
                WHERE COD_TIPTARJETA = EN_codtiptarjeta;
                IF LN_contador < 1 THEN
                   SN_cod_error := 2902; -- Codigo de Tarjeta no existe
                   RAISE ERROR_CONTROLADO;
                END IF;            
            END IF;

            sSQL := 'SELECT count(1) FROM GE_CLIENTES WHERE COD_CLIENTE = ' || EN_codcliente;
            SELECT count(1)
            INTO LN_contador
            FROM GE_CLIENTES
            WHERE COD_CLIENTE = EN_codcliente;
            IF LN_contador < 1 THEN
               SN_cod_error := 1965; -- Código de cliente no existe en SCL.
               RAISE ERROR_CONTROLADO;
            END IF;

             sSQL := 'SELECT count(1) FROM CO_TIPVALOR WHERE TIP_VALOR = ' || EN_tipvalor;
            SELECT count(1)
            INTO LN_contador
            FROM CO_TIPVALOR
            WHERE TIP_VALOR = EN_tipvalor;
            IF LN_contador < 1 THEN
               SN_cod_error := 2817; -- Tipo de Valor no existe.
               RAISE ERROR_CONTROLADO;
            END IF;

            IF EN_mtopago <= 0 THEN
               SN_cod_error := 2818; -- Monto de Pago no válido
               RAISE ERROR_CONTROLADO;
            END IF;

             sSQL := 'SELECT TO_DATE(EV_fecefectividad,LV_formatofecha) FROM DUAL';
             BEGIN
             SELECT TO_DATE(EV_fecefectividad,LV_formatofecha)
             INTO LN_fecpago
             FROM DUAL;
             EXCEPTION
             WHEN OTHERS THEN
                SN_cod_error := 2819; -- Fecha de Pago no válida
                RAISE ERROR_CONTROLADO;
             END;

            sSQL := 'LN_fecpago > SYSDATE';
            IF LN_fecpago > SYSDATE + 0.041 THEN
                SN_cod_error := 2819; -- Fecha de Pago no válida
                RAISE ERROR_CONTROLADO;
            END IF;

            IF EN_numtransaccion IS NULL OR EN_numtransaccion = 0 THEN
                sSQL := 'CO_OBTIENETRANSACCION_PR';
                CO_OBTIENETRANSACCION_PR(LN_numtransaccion, SN_cod_error, SV_des_error, SN_cod_evento);
                 sSQL := 'CO_OBTIENETRANSACCION_PR: ' || LN_numtransaccion;
                IF SN_cod_error != 0 THEN
                     RAISE ERROR_CONTROLADO;
                END IF;
                LN_numtransaccion_emp := LN_numtransaccion;
            ELSE
                LN_numtransaccion := EN_numtransaccion;
                LN_numtransaccion_emp := EN_numtransaccion_emp;
            END IF;
            sSQL := 'INSERT INTO CO_INTERFAZ_PAGOS : '|| LN_numtransaccion;
            INSERT INTO CO_INTERFAZ_PAGOS
            (EMP_RECAUDADORA, COD_CAJA_RECAUDA, SER_SOLICITADO, FEC_EFECTIVIDAD,
            NUM_TRANSACCION, NOM_USUARORA, TIP_TRANSACCION, SUB_TIP_TRANSAC,
            COD_SERVICIO, NUM_EJERCICIO, COD_CLIENTE, NUM_CELULAR,
            IMP_PAGO, NUM_FOLIOCTC, NUM_IDENT, TIP_VALOR,
            NUM_DOCUMENTO, COD_BANCO, CTA_CORRIENTE, COD_AUTORIZA,
            CAN_DEBE, MTO_DEBE, CAN_HABER, MTO_HABER,
            COD_ESTADO, COD_ERROR, NUM_COMPAGO, NUM_TARJETA,
            COD_TIPIDENT, PREF_PLAZA, DES_AGENCIA, COD_OPERACION, NUM_TRANSACCION_EMP, COD_TIPTARJETA)
            VALUES
            (EV_codbanco, EN_codcaja, EV_codservicio, TO_DATE(EV_fecefectividad,LV_formatofecha),
            LN_numtransaccion, EV_operador, EV_tiptransaccion, EV_subtipo,
            EN_codservicio, EN_numejercicio, EN_codcliente, EN_numcelular,
            EN_mtopago, EV_numfolio, NULL, EN_tipvalor,
            EN_numcheque, EV_bancocheque, EV_ctacte, EV_autorizacion,
            LN_valorcero, LN_valorcero, LN_valorcero, LN_valorcero,
            NULL, NULL, NULL, EN_numtarjeta,
            NULL, NULL, EV_agencia, EN_codoperacion, LN_numtransaccion_emp, EN_codtiptarjeta);

        EXCEPTION
            WHEN ERROR_CONTROLADO THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CE_APLICA_PAGO_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2820;    --Error al ingresar pago en la Interfaz de Pagos
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CE_APLICA_PAGO_PR', sSql, SQLCODE, SQLERRM );
        END;
        
       PROCEDURE CO_VALIDA_DATOSPAGO_PR(EN_num_transaccion IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       EN_codcliente IN co_interfaz_pagos.cod_cliente%TYPE,
                                       EN_codbanco IN co_interfaz_pagos.emp_recaudadora%TYPE,       
                                       EN_fecpago IN VARCHAR2,
                                       EN_horpago IN VARCHAR2,
                                       EN_montopago IN co_interfaz_pagos.imp_pago%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS
                                       
       LN_codcliente CO_INTERFAZ_PAGOS.COD_CLIENTE%TYPE;
       LN_codbanco CO_INTERFAZ_PAGOS.EMP_RECAUDADORA%TYPE;
       LD_fecefectividad CO_INTERFAZ_PAGOS.FEC_EFECTIVIDAD%TYPE;
       LN_montopago CO_INTERFAZ_PAGOS.IMP_PAGO%TYPE;
       LD_fecha DATE;
       sSQL varchar2(1000);       
       ERROR_CONTROLADO EXCEPTION;
       LV_estadoPRO VARCHAR2(3) := 'PRO';
       LV_estado CO_INTERFAZ_PAGOS.COD_ESTADO%TYPE;
                                       
       BEGIN
       
            BEGIN
                sSQL := 'SELECT cod_cliente, emp_recaudadora, fec_efectividad, cod_estado, sum(imp_pago)';
                sSQL := sSQL || ' FROM CO_INTERFAZ_PAGOS';
                sSQL := sSQL || ' WHERE num_transaccion_emp = ' || EN_num_transaccion;
                sSQL := sSQL || ' GROUP BY cod_cliente, emp_recaudadora, fec_efectividad, cod_estado';
                
                SELECT cod_cliente, emp_recaudadora, fec_efectividad, nvl(cod_estado,' '), sum(imp_pago)
                INTO LN_codcliente, LN_codbanco, LD_fecefectividad, LV_estado, LN_montopago        
                FROM CO_INTERFAZ_PAGOS
                WHERE num_transaccion_emp = EN_num_transaccion
                GROUP BY cod_cliente, emp_recaudadora, fec_efectividad, cod_estado;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                SN_cod_error := 2903; -- No se encontraron datos asociados a la transaccion
                RAISE ERROR_CONTROLADO;            
            END;
            
            IF LV_estado != LV_estadoPRO THEN
                SN_cod_error := 2909; -- Transacción no se encuentra procesada 
                RAISE ERROR_CONTROLADO;                  
            END IF;
            
            /*
            IF LN_codcliente <> EN_codcliente THEN
                SN_cod_error := 2904; -- Cliente no corresponde al del numero de transaccion
                RAISE ERROR_CONTROLADO;              
            END IF;
            */
            
            IF LN_montopago != EN_montopago THEN
                SN_cod_error := 2905; -- Monto no corresponde al del numero de transaccion
                RAISE ERROR_CONTROLADO;               
            END IF;
            
            IF LN_codbanco != EN_codbanco THEN
                SN_cod_error := 2906; -- Empresa Recaudadora no corresponde a la del numero de transaccion
                RAISE ERROR_CONTROLADO;            
            END IF;
            
            BEGIN
                 LD_fecha := TO_DATE(EN_fecpago || ' ' ||EN_horpago, 'YYYYMMDD HH24MISS');
            EXCEPTION
            WHEN OTHERS THEN
                SN_cod_error := 425; -- La Fecha no es valida
                RAISE ERROR_CONTROLADO;                   
            END;
            
            IF LD_fecefectividad != LD_fecha then
                SN_cod_error := 2819; -- La Fecha no es valida
                RAISE ERROR_CONTROLADO;              
            END IF;
                             
        EXCEPTION
            WHEN ERROR_CONTROLADO THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_VALIDA_DATOSPAGO_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2907;    --Error al validar pago en la Interfaz de Pagos
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_VALIDA_DATOSPAGO_PR', sSql, SQLCODE, SQLERRM );
                               
       END; 
       
       PROCEDURE CO_DESAPLICA_PAGO_PR( EN_numtransaccion IN co_interfaz_pagos.num_transaccion_emp%TYPE,
                                       SN_cod_error OUT NOCOPY NUMBER,
                                       SV_des_error OUT NOCOPY VARCHAR2,
                                       SN_cod_evento OUT NOCOPY NUMBER) IS
                                       
        CURSOR Transacciones IS
            SELECT emp_recaudadora, cod_caja_recauda, ser_solicitado, fec_efectividad,
            num_transaccion, nom_usuarora, cod_servicio,
            num_ejercicio, cod_cliente, num_celular, imp_pago, num_folioctc, 
            num_ident, tip_valor, num_documento, cod_banco, cta_corriente, cod_autoriza, can_debe, 
            mto_debe, can_haber, mto_haber, num_compago, num_tarjeta, cod_tipident, pref_plaza, des_agencia,
            cod_operacion, num_transaccion_emp, cod_tiptarjeta
            FROM   co_interfaz_pagos
            WHERE  num_transaccion_emp = EN_numtransaccion; 
        
        ERROR_CONTROLADO EXCEPTION;   
        sSQL varchar2(1000); 
        LV_Reversa VARCHAR2(1) := 'R';
        LV_subtiptransac VARCHAR2(1) := 'S';
                                          
       BEGIN
          
        FOR rTransac IN Transacciones LOOP
            sSQL := 'INSERT INTO co_interfaz_pagos';
            sSQL := sSQL || ' (emp_recaudadora, cod_caja_recauda, ser_solicitado, fec_efectividad,';
            sSQL := sSQL || ' num_transaccion, nom_usuarora, tip_transaccion, sub_tip_transac, cod_servicio,';
            sSQL := sSQL || ' num_ejercicio, cod_cliente, num_celular, imp_pago, num_folioctc,';
            sSQL := sSQL || ' num_ident, tip_valor, num_documento, cod_banco,';
            sSQL := sSQL || ' cta_corriente, cod_autoriza, can_debe,';
            sSQL := sSQL || ' mto_debe, can_haber, mto_haber, num_compago,';
            sSQL := sSQL || ' num_tarjeta, cod_tipident, pref_plaza, des_agencia,';
            sSQL := sSQL || ' cod_operacion, num_transaccion_emp, cod_tiptarjeta)';
            sSQL := sSQL || ' VALUES ';
            sSQL := sSQL || ' ' || rTransac.emp_recaudadora || ',' || rTransac.cod_caja_recauda || ',';
            sSQL := sSQL || ' ' || rTransac.ser_solicitado || ',' || rTransac.fec_efectividad || ',';
            sSQL := sSQL || ' ' || rTransac.num_transaccion || ',' || rTransac.nom_usuarora || ',';
            sSQL := sSQL || ' ' || LV_Reversa || ',' || LV_subtiptransac || ',';
            sSQL := sSQL || ' ' || rTransac.cod_servicio || ',' || rTransac.num_ejercicio || ',';
            sSQL := sSQL || ' ' || rTransac.cod_cliente || ',' || rTransac.num_celular || ',';
            sSQL := sSQL || ' ' || rTransac.imp_pago || ',' || rTransac.num_folioctc || ',';
            sSQL := sSQL || ' ' || rTransac.num_ident || ',' || rTransac.tip_valor || ',';
            sSQL := sSQL || ' ' || rTransac.num_documento || ',' || rTransac.cod_banco || ',';
            sSQL := sSQL || ' ' || rTransac.cta_corriente || ',' || rTransac.cod_autoriza || ',';
            sSQL := sSQL || ' ' || rTransac.can_debe || ',' || rTransac.mto_debe || ',';
            sSQL := sSQL || ' ' || rTransac.can_haber || ',' || rTransac.mto_haber || ',';
            sSQL := sSQL || ' ' || rTransac.num_compago || ',' || rTransac.num_tarjeta || ',';
            sSQL := sSQL || ' ' || rTransac.cod_tipident || ',' || rTransac.pref_plaza || ',';
            sSQL := sSQL || ' ' || rTransac.des_agencia || ',' || rTransac.cod_operacion || ',';
            sSQL := sSQL || ' ' || rTransac.num_transaccion_emp || ',' || rTransac.cod_tiptarjeta || ');';
            
            INSERT INTO co_interfaz_pagos
            (emp_recaudadora, cod_caja_recauda, ser_solicitado, fec_efectividad,
            num_transaccion, nom_usuarora, tip_transaccion, sub_tip_transac, cod_servicio,
            num_ejercicio, cod_cliente, num_celular, imp_pago, num_folioctc, 
            num_ident, tip_valor, num_documento, cod_banco, 
            cta_corriente, cod_autoriza, can_debe, 
            mto_debe, can_haber, mto_haber, num_compago, 
            num_tarjeta, cod_tipident, pref_plaza, des_agencia,
            cod_operacion, num_transaccion_emp, cod_tiptarjeta) 
            VALUES
            (rTransac.emp_recaudadora, rTransac.cod_caja_recauda, rTransac.ser_solicitado, rTransac.fec_efectividad,
            rTransac.num_transaccion, rTransac.nom_usuarora, LV_Reversa, LV_subtiptransac, rTransac.cod_servicio,
            rTransac.num_ejercicio, rTransac.cod_cliente, rTransac.num_celular, rTransac.imp_pago, rTransac.num_folioctc, 
            rTransac.num_ident, rTransac.tip_valor, rTransac.num_documento, rTransac.cod_banco, 
            rTransac.cta_corriente, rTransac.cod_autoriza, rTransac.can_debe, 
            rTransac.mto_debe, rTransac.can_haber, rTransac.mto_haber, rTransac.num_compago, 
            rTransac.num_tarjeta, rTransac.cod_tipident, rTransac.pref_plaza, rTransac.des_agencia,
            rTransac.cod_operacion, rTransac.num_transaccion_emp, rTransac.cod_tiptarjeta);
            
        END LOOP;
        
        EXCEPTION
            WHEN ERROR_CONTROLADO THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_DESAPLICA_PAGO_PR', sSql, SQLCODE, SQLERRM );
            WHEN OTHERS THEN
                 SN_cod_error := 2908;    --Error al ingresar desaplicacion del pago en la Interfaz de Pagos
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
                      SV_des_error := CV_ErrorNoClasificado;
                   END IF;
                   SN_cod_evento := Ge_Errores_Pg.Grabarpl( SN_cod_evento, 'CO', SN_cod_error || ' ' || SV_des_error, '1.0', USER, 'CO_PAGOSONLINE_PG.CO_DESAPLICA_PAGO_PR', sSql, SQLCODE, SQLERRM );         
       END;                   
                                                
END;
/
SHOW ERRORS