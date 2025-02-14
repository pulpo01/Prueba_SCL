CREATE OR REPLACE PROCEDURE CO_SIMULAPAGO_LIMITECONSUMO_PR 
(
    vp_Cod_cliente            IN NUMBER,
    vp_Imp_pago               IN NUMBER,
    vp_Fecha_efec             IN VARCHAR2,
    vp_Emp_recauda            IN VARCHAR2,
    vp_Cod_servicio           IN NUMBER,
    vp_Num_celular            IN NUMBER,
    vp_Pref_Plaza             IN OUT NOCOPY VARCHAR2,
    vp_Cod_Operacion          IN VARCHAR2,
    vp_OutGlosa               OUT NOCOPY VARCHAR2,
    vp_OutRetorno             OUT NOCOPY NUMBER,
    vp_CodPlanSrv             IN  VARCHAR2 default null
) IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "CO_APLICAPAGO_LIMITECONSUMO_PR" Lenguaje="PL/SQL" Fecha="22-11-2006" Versión="1.0.0" Diseñador="Carlos Perez" Programador= Carlos Perez" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Descripción</Descripción>
<Parámetros>
    <Entrada>
        <param nom="vp_Cod_cliente"         Tipo="NUMBER">Codigo del cliente</param>
        <param nom="vp_Imp_pago"            Tipo="NUMBER">Monto del pago</param>
        <param nom="vp_Fecha_efec"          Tipo="STRING">Fecha efectividad del pago</param>
        <param nom="vp_Emp_recauda"         Tipo="STRING">Codigo de la empresa recaudadora</param>
        <param nom="vp_Cod_servicio"        Tipo="NUMBER">Codigo de servicio</param>
        <param nom="vp_Num_celular"         Tipo="NUMBER">Numero de celular</param>
        <param nom="vp_Pref_Plaza"          Tipo="STRING">Prefijo Plaza</param>
        <param nom="vp_Cod_Operacion"       Tipo="STRING">Codigo de Operacion</param>
        <param nom="vp_OutGlosa"            Tipo="STRING">Glosa de retorno</param>
        <param nom="vp_OutRetorno"          Tipo="NUMBER">Valor de retorno</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

/*****************************(I) NOMENCLATURA MODULOS GENERADORES DE PAGO ********************************/
/* Pago Electronico        'PNT'                                              ********************************/
/*****************************(F) NOMENCLATURA MODULOS GENERADORES DE PAGO ********************************/

sNom_User               CO_CAJEROS.NOM_USUARORA%TYPE;
lPref_Plaza2            CO_CARTERA.PREF_PLAZA%TYPE;
sCod_OperadorAbono      CO_CARTERA.COD_OPERADORA_SCL%TYPE;
iDoc_LimConsumo         CO_DATGEN.DOC_RESPALDO%TYPE;
lSecCompago             CO_PAGOS.NUM_COMPAGO%TYPE;
lSec_Pago               CO_PAGOS.NUM_SECUENCI%TYPE;
lSec_PagoLimite         CO_PAGOS.NUM_SECUENCI%TYPE;
sNom_proceso            CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
lCod_cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
LN_cod_cliente          TOL_CLIENTE.COD_CLIENTE%TYPE;
LV_CodCiclo             TOL_CLIENTE.COD_CICLO%TYPE;
LD_FecIniVig            TOL_CLIENTE.FEC_INI_VIG%TYPE;
LV_CodPlan              TOL_CLIENTE.COD_PLAN%TYPE;
LV_CodBolsa             TOL_CLIENTE.COD_BOLSA%TYPE;
LD_FecTasa              TOL_CRONOGRAMA.FEC_TASA%TYPE;
LV_NomTabla             VARCHAR2(21);
lCodClienteAux          GA_ABOCEL.COD_CLIENTE%TYPE := 0;
lNumAbonadoAux          GA_ABOCEL.NUM_ABONADO%TYPE := 0;
--

ERROR_PROCESO           EXCEPTION;
ERROR_CALC_LIMITECONS   EXCEPTION;
ERROR_MONTO_APLICADO    EXCEPTION;

-- VARIABLES AUXILIARES
iDecimal                NUMBER(2);
dTotal_pago             NUMBER(14,4);
sFormatoFecha           VARCHAR2(20);
v_sqlcode               VARCHAR2(10);
v_sqlerrm               VARCHAR2(255);
vp_Gls_Error            VARCHAR2(255);
vp_emp_recauda_aux      VARCHAR2(40);
vp_emp_recauda_aux_tec  VARCHAR2(40);
dMto_Umbral             NUMBER(14,4);
dMto_Consumo            NUMBER(14,4);
iCod_Ciclo              NUMBER(2);
--
DATOS_SQL               VARCHAR2(2500);
LN_largo                NUMBER(12);
LN_modulo               NUMBER(1);
LV_CodPlanSrv           VARCHAR2(3);
LV_ServicioBase         TOL_PAGO_LIMITE_TO.COD_PLAN%TYPE;
LV_limite               TOL_PAGO_LIMITE_TO.COD_LIMITE%TYPE;
LN_montoaplicado        NUMBER(14,4) := 0;
LN_montoaux             NUMBER(14,4) := 0;
vCodServicio            varchar2(3) := '203';
vCodModuloLC            varchar2(2) := 'LC'; 
--
-- declaracion variables duras globales
vp_uso                  NUMBER;
vnum_abonado            NUMBER;
LV_Srv                  VARCHAR2(3);
vcod_movimiento         NUMBER;

TYPE                    DYNAMIC_CURSOR IS REF CURSOR;
C_ABONADOS              DYNAMIC_CURSOR;
--
-- definicion cursores
CURSOR c_limconsumo (vCodServicio varchar2) is
SELECT t.cod_abonado
  FROM tol_cliente t
 WHERE exists ( SELECT 1 FROM ga_susprehabo 
                 WHERE tip_registro < 3
                   AND cod_modulo = vCodModuloLC
                   AND cod_servicio = vCodServicio 
                   AND num_abonado = t.cod_abonado 
              )
   and t.cod_cliente = vp_Cod_cliente
   and SYSDATE BETWEEN t.fec_ini_vig AND t.fec_ter_vig;

/**********************************************************************************************************************/
/*********************************************************************************************(F) DEFINICION CURSORES */
/**********************************************************************************************************************/
BEGIN

    vp_OutGlosa := '';
    vp_OutRetorno := 0;
    vp_emp_recauda_aux := vp_emp_recauda;
    sNom_proceso := 'CO_SIMULAPAGO_LIMITECONSUMO_PR CLI : ' || vp_Cod_cliente;

    -- inicializacion variables duras
    vp_uso := 0;
    vnum_abonado := 0;
    vp_OutGlosa := 'Paso 1 recorrido PL';
    vp_OutRetorno := -1;
    vcod_movimiento := 1;
    iDoc_LimConsumo := 88;
    lPref_Plaza2 := '';
    lSecCompago := 0;
    ---
    LV_Srv := 'SRV';

    IF(vp_Cod_Operacion != '3') AND (vp_Cod_Operacion != '4') and (vp_Cod_Operacion != '5') THEN
        vp_OutRetorno:=1;
        vp_OutGlosa  :='OK';
    END IF;

    IF((vp_Cod_Operacion = '4') AND (vp_CodPlanSrv IS NULL))  THEN
        vp_OutGlosa := 'FALTA INGRESAR CODIGO DE PLAN DE SERVICIOS SUPLEMENTARIOS';
        vp_OutRetorno:=-1;
        RAISE ERROR_CALC_LIMITECONS;
    END IF;

    vp_OutGlosa := 'Select CO_EMPRESAS_REX';
    vp_OutRetorno:=-2;

    SELECT b.nom_usuarora
      INTO sNom_User
      FROM co_empresas_rex a, co_cajeros b
     WHERE a.emp_recaudadora = vp_emp_recauda_aux
       AND a.cod_oficina = b.cod_oficina
       AND a.cod_caja = b.cod_caja;

    vp_OutGlosa := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
    vp_OutRetorno:=-3;
    iDecimal:= Ge_Pac_General.PARAM_GENERAL('num_decimal');

    vp_OutGlosa := 'SELECT FORMATO_SEL2 FROM GED_PARAMETROS.';
    vp_OutRetorno:=-8;
    SELECT val_parametro
      INTO sFormatoFecha
      FROM ged_parametros
     WHERE cod_modulo = 'GE'
       AND cod_producto = 1
       AND nom_parametro = 'FORMATO_SEL2';

    IF (vp_Cod_servicio = 3) THEN
        BEGIN
            vp_OutGlosa := 'Select COD_CLIENTE Ga_abocel. Cliente : ' || vp_Cod_cliente;
            vp_OutRetorno:=-9;

            SELECT cod_cliente
              INTO lCod_cliente
              FROM ga_abocel
             WHERE num_celular = vp_Num_celular;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                BEGIN
                    vp_OutGlosa := 'Select Ga_intarcel. Cliente.';
                    vp_OutRetorno:=-10;

                    SELECT cod_cliente
                      INTO lCod_cliente
                      FROM ga_intarcel
                     WHERE num_celular = vp_num_celular
                       AND TO_DATE(vp_fecha_efec,sFormatoFecha||' HH24:MI:SS') BETWEEN fec_desde AND fec_hasta;
                END;
        END;
    ELSE
        vp_OutGlosa := 'Select  UNIQUE COD_CLIENTE GE_CLIENTES.';
        vp_OutRetorno:=-11;

        SELECT UNIQUE cod_cliente
          INTO lCod_cliente
          FROM ge_clientes
         WHERE cod_cliente = vp_Cod_cliente;
    END IF;

    dTotal_pago := Ge_Pac_General.REDONDEA(vp_Imp_pago, iDecimal, vp_uso);

    -- APLICACION DE PAGO 
    IF (vp_Cod_Operacion = '3') THEN
        vp_emp_recauda_aux_tec := 'PAGO L.CONSUMO por '||vp_emp_recauda_aux;
    ELSE
        IF (vp_Cod_Operacion = '4') THEN
            vp_emp_recauda_aux_tec := 'PAGO L. CONSUMO SS por '||vp_emp_recauda_aux;
        ELSE
            vp_emp_recauda_aux_tec := 'PAGO L. CONSUMO PLAN ADIC por '||vp_emp_recauda_aux;
        END IF;
    END IF;

    BEGIN
        vp_OutRetorno:=-26;
        vp_OutGlosa := 'SELECT  COD_CICLO, OPERADORA FROM GE_CLIENTES.';

        SELECT cod_ciclo,
               cod_operadora
          INTO iCod_Ciclo,
               sCod_OperadorAbono
          FROM ge_clientes
         WHERE cod_cliente = lCod_cliente;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                iCod_Ciclo := 0;
                sCod_OperadorAbono := ' ';
    END;

    FOR rReg IN c_limconsumo (vCodServicio) LOOP
        BEGIN
            vp_OutRetorno:=-27;
            vp_OutGlosa := 'SELECT MONTO CONSUMO.';
            vnum_abonado := rReg.COD_ABONADO;
            BEGIN
                BEGIN
                    SELECT a.cod_ciclo, MAX(a.fec_ini_vig), a.cod_plan, a.cod_bolsa
                      INTO LV_CodCiclo, LD_FecIniVig ,      LV_CodPlan, LV_CodBolsa
                      FROM tol_cliente a
                     WHERE a.cod_cliente = lCod_cliente
                       AND ((a.cod_abonado = 0) OR (a.cod_abonado = vnum_abonado))
                       AND a.cod_ciclo = iCod_Ciclo
                       AND SYSDATE BETWEEN fec_ini_vig AND fec_ter_vig
                    GROUP BY a.cod_ciclo, a.cod_plan, a.cod_bolsa;

                    EXCEPTION
                        WHEN OTHERS THEN
                            vp_OutRetorno := -28;
                            vp_OutGlosa := 'ERROR AL OBTENER CICLO';
                            RAISE ERROR_CALC_LIMITECONS;
                END;

                BEGIN
                    SELECT a.fec_tasa
                      INTO LD_FecTasa
                      FROM tol_cronograma a
                     WHERE a.cod_ciclo =LV_CodCiclo
                       AND a.est_proc ='ACTIV'
                       AND a.fec_inic <= SYSDATE
                       AND a.fec_term >= SYSDATE;

                    EXCEPTION
                        WHEN OTHERS THEN
                            vp_OutRetorno:=-28;
                            vp_OutGlosa := 'ERROR AL OBTENER FEC_TASA';
                            RAISE ERROR_CALC_LIMITECONS;
                END;

                BEGIN
                    LN_cod_cliente:= TO_CHAR(lCod_cliente);
                    LN_largo := LENGTH(LN_cod_cliente);

                    IF LN_largo >= 2 THEN
                        LN_modulo := MOD(SUBSTR(LN_cod_cliente, LENGTH(LN_cod_cliente)-1,2), 10);
                    ELSIF LN_largo = 1 THEN
                        LN_modulo := LN_cod_cliente;
                    END IF;

                EXCEPTION
                        WHEN OTHERS THEN
                            vp_OutRetorno:=-28;
                            vp_OutGlosa := 'ERROR AL CALCULAR MODULO';
                            RAISE ERROR_CALC_LIMITECONS;
                END;

                BEGIN
                    DATOS_SQL := '';
                    IF (vp_Cod_Operacion = '3') THEN

                        -- para pago de limite de consumo por Plan Tarifario
                        DATOS_SQL:=DATOS_SQL||'    SELECT   1, (c.acu_consumo - c.acu_pagos) AS monto_pago, NULL, NULL ';
                        DATOS_SQL:=DATOS_SQL||'    FROM tol_cliente a, ga_limite_cliabo_to b, lc_acumula_0' || TO_CHAR(LN_modulo) || ' c, lc_limites d, lc_umbral f ';
                        DATOS_SQL:=DATOS_SQL||'    WHERE a.cod_cliente = ' || lCod_cliente;

                        IF (vnum_abonado > 0) THEN
                            DATOS_SQL:=DATOS_SQL||'    AND a.cod_abonado = ' || vnum_abonado;
                        END IF;

                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN a.fec_ini_vig AND a.fec_ter_vig';
                        DATOS_SQL:=DATOS_SQL||'    AND a.cod_plan = b.cod_plantarif ';
                        DATOS_SQL:=DATOS_SQL||'    AND b.cod_cliente = a.cod_cliente ';
                        DATOS_SQL:=DATOS_SQL||'    AND b.num_abonado = a.cod_abonado ';
                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta , SYSDATE) ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_cliente = a.cod_cliente ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_abonado = a.cod_abonado ';
                        DATOS_SQL:=DATOS_SQL||'    AND c.fec_tasa = ' || LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_ciclo = ' || LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||'    AND c.cod_plan = a.cod_plan ';
                        DATOS_SQL:=DATOS_SQL||'    AND d.cod_limcons = b.cod_limcons ';
                        DATOS_SQL:=DATOS_SQL||'    AND d.cod_limcons = c.cod_limite';
                        DATOS_SQL:=DATOS_SQL||'    AND d.fec_desde = ( SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons) ';
                        DATOS_SQL:=DATOS_SQL||'    AND f.cod_umbral = d.cod_umbral_min';
                        DATOS_SQL:=DATOS_SQL||'    AND SYSDATE BETWEEN f.fec_ini_vig AND f.fec_ter_vig';

                    ELSIF (vp_Cod_Operacion = '4') THEN

                        -- para pago de limite de consumo por Servicio Suplementario
                        IF (vnum_abonado>0) THEN
                            LV_NomTabla:=' GA_SERVSUPLABO ';
                        ELSE
                            LV_NomTabla:=' GA_SERVSUPLCLI_TO ';
                        END IF;

                        DATOS_SQL:=DATOS_SQL||' SELECT b.cod_plantarif,  ((f.mto_umbral*(c.acu_consumo-c.acu_pagos))/100) AS monto_pago, NULL, NULL ';
                        DATOS_SQL:=DATOS_SQL||'   FROM '||LV_NomTabla ||' a, gad_servsup_plan b, lc_acumula_0'||TO_CHAR(LN_modulo)||' c, lc_limites d, lc_umbral f,  ga_servsupl g,ta_plantarif h  ';

                        IF (vnum_abonado>0) THEN
                            DATOS_SQL:=DATOS_SQL||' WHERE a.num_abonado = '||vnum_abonado;
                        ELSE
                            DATOS_SQL:=DATOS_SQL||' WHERE a.cod_cliente = '||lCod_cliente;
                        END IF;

                        DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = ''' || vp_CodPlanSrv ||'''';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_producto = a.cod_producto  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = a.cod_servicio  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_producto = g.cod_producto  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_servicio = g.cod_servicio  ';
                        DATOS_SQL:=DATOS_SQL||' AND b.fec_desde <= ( SELECT MAX(g.fec_desde) ';
                        DATOS_SQL:=DATOS_SQL||'                        FROM gad_servsup_plan g ';
                        DATOS_SQL:=DATOS_SQL||'                       WHERE g.cod_producto = b.cod_producto ';
                        DATOS_SQL:=DATOS_SQL||' AND g.cod_servicio = b.cod_servicio)  ';
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_cliente = '||lCod_cliente;

                        IF (vnum_abonado>0) THEN
                            DATOS_SQL:=DATOS_SQL||' AND c.cod_abonado = a.num_abonado ';
                        END IF;

                        DATOS_SQL:=DATOS_SQL||' AND c.fec_tasa = '||LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_ciclo = '||LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_plan = b.cod_plantarif ';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_limcons = c.cod_limite ';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_limcons = d.cod_limcons ';
                        DATOS_SQL:=DATOS_SQL||' AND d.fec_desde <= ( SELECT MAX(e.fec_desde) ';
                        DATOS_SQL:=DATOS_SQL||'                        FROM lc_limites e ';
                        DATOS_SQL:=DATOS_SQL||'                       WHERE e.cod_limcons = d.cod_limcons) ';
                        DATOS_SQL:=DATOS_SQL||' AND f.cod_umbral = d.cod_umbral_min ';
                        DATOS_SQL:=DATOS_SQL||' AND b.cod_plantarif = h.cod_plantarif';
                        DATOS_SQL:=DATOS_SQL||' AND h.cla_plantarif = ''' || LV_Srv||'''';
                        DATOS_SQL:=DATOS_SQL||' AND B.TIP_RELACION =4 ';

                    ELSIF (vp_Cod_Operacion = '5') THEN

                        DATOS_SQL:=DATOS_SQL||' SELECT 1, (c.acu_consumo-c.acu_pagos) AS monto_pago, b.cod_servicio_base, c.cod_limite, ';
                        DATOS_SQL:=DATOS_SQL||' FROM pr_productos_contratados_to a,';
                        DATOS_SQL:=DATOS_SQL||' se_detalles_especificacion_to b,';
                        DATOS_SQL:=DATOS_SQL||' lc_acumula_0<Módulo del Cliente> c,';
                        DATOS_SQL:=DATOS_SQL||' lc_limites d, lc_umbral f,';
                        DATOS_SQL:=DATOS_SQL||' pf_productos_ofertados_td g';
                        DATOS_SQL:=DATOS_SQL||' WHERE a.num_abonado_contratante = ' ||vnum_abonado;
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_cliente_contratante = '||lCod_cliente;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_cliente = '||lCod_cliente;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_abonado = ' ||vnum_abonado;
                        DATOS_SQL:=DATOS_SQL||' AND c.fec_tasa = '||LD_FecTasa;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_ciclo = '||LV_CodCiclo;
                        DATOS_SQL:=DATOS_SQL||' AND c.cod_plan    = b.cod_servicio_base ';
                        DATOS_SQL:=DATOS_SQL||' AND d.cod_limcons = c.cod_limite';
                        DATOS_SQL:=DATOS_SQL||' AND b.ind_tipo_servicio = ''TOL''';
                        DATOS_SQL:=DATOS_SQL||' AND a.cod_prod_ofertado = g.cod_prod_ofertado';
                        DATOS_SQL:=DATOS_SQL||' AND g.cod_espec_prod    = b.cod_espec_prod';
                        DATOS_SQL:=DATOS_SQL||' AND d.fec_desde <= (SELECT MAX(e.fec_desde) FROM lc_limites e WHERE e.cod_limcons = d.cod_limcons)';
                        DATOS_SQL:=DATOS_SQL||' AND f.cod_umbral = d.cod_umbral_min';
                        DATOS_SQL:=DATOS_SQL||' AND (c.acu_consumo-c.acu_pagos) > 0';
                        DATOS_SQL:=DATOS_SQL||' ORDER BY (c.acu_consumo-c.acu_pagos) DESC';

                    END IF;

                    vp_OutRetorno:=-28;
                    vp_OutGlosa := 'ERROR AL CALCULAR MODULO';
                    OPEN C_ABONADOS FOR DATOS_SQL;

                    LOOP
                        FETCH C_ABONADOS INTO  LV_CodPlanSrv, dMto_Consumo, LV_ServicioBase, LV_limite;
                        EXIT WHEN C_ABONADOS%NOTFOUND;

                        BEGIN
                            IF (vp_Cod_Operacion = '4') THEN
                                LV_CodPlan:= LV_CodPlanSrv;
                            END IF;

                            IF dMto_Consumo > 0 then

                                SELECT CO_SEQ_PAGO.NEXTVAL
                                  INTO lSec_PagoLimite
                                  FROM DUAL;

                                LN_montoaux := 0;
                                LN_montoaux := LN_montoaplicado + dMto_Consumo;

                                IF (LN_montoaux > dTotal_pago) then
                                    dMto_Consumo := dTotal_pago - LN_montoaplicado;
                                END IF;

                                LN_montoaplicado := LN_montoaplicado + dMto_Consumo;

                                INSERT INTO TOL_PAGO_LIMITE_TO
                                (
                                    COD_TIPDOCUM,        NUM_SECUENCI,     COD_CLIENTE,              COD_ABONADO,
                                    COD_MOVIMIENTO,      IMP_PAGO,         FEC_EFECTIVIDAD,          FEC_VALOR,
                                    NOM_USUARORA,        DES_PAGO,         COD_CICLO,                COD_OPERADORA,
                                    PREF_PLAZA,          NUM_COMPAGO,      COD_PLAN, COD_LIMITE
                                )
                                VALUES
                                (
                                    iDoc_LimConsumo,     lSec_PagoLimite,         lCod_cliente,     vnum_abonado,
                                    vcod_movimiento,     dMto_Consumo,            SYSDATE,          SYSDATE,
                                    sNom_User,           vp_emp_recauda_aux_tec,  iCod_Ciclo,       sCod_OperadorAbono,
                                    lPref_Plaza2,        lSecCompago,             LV_ServicioBase,  LV_limite
                                );
                                
                                lCodClienteAux := lCod_cliente;
                                lNumAbonadoAux := vnum_abonado;
                                 
                            END IF;

                            EXCEPTION
                                WHEN OTHERS THEN
                                    RAISE ERROR_PROCESO;
                        END;
                    END LOOP;

                    CLOSE C_ABONADOS;

                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            dMto_Umbral := 0;
                            dMto_Consumo := 0;
                END;
            END;
        END;
    END  LOOP;

    IF LN_montoaplicado < dTotal_pago and LN_montoaplicado != 0 THEN

        LN_montoaux := dTotal_pago - LN_montoaplicado; 

        BEGIN
            LN_montoaplicado := LN_montoaplicado + LN_montoaux;

            update tol_pago_limite_to
               set imp_pago = imp_pago + LN_montoaux
             where cod_tipdocum = iDoc_LimConsumo
               and num_secuenci = lSec_PagoLimite
               and cod_cliente = lCodClienteAux  
               and cod_abonado = lNumAbonadoAux;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    vp_OutRetorno:=-38;
                    vp_OutGlosa := 'No se pudo actualizar monto del Pago.  Monto Aplicado = ' || LN_montoaplicado || ', Monto que se podia aplicar = ' || LN_montoaux;
                    RAISE ERROR_MONTO_APLICADO;
        END;
    END IF;

    IF LN_montoaplicado != vp_imp_pago and LN_montoaplicado != 0 THEN
        vp_OutRetorno:=-37;
        vp_OutGlosa := 'No se pudo aplicar monto del Pago.  Monto Pago = ' || vp_imp_pago || ', Monto que se podia aplicar = ' || LN_montoaplicado ;
        RAISE ERROR_MONTO_APLICADO;
    END IF;

    vp_OutRetorno:=1;
    vp_OutGlosa  :='OK';

    EXCEPTION
        WHEN ERROR_MONTO_APLICADO THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
            v_sqlcode := SQLCODE;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente;

            INSERT INTO CO_TRANSAC_ERROR
            (
                nom_proceso, cod_retorno, fec_proceso,desc_sql,desc_cadena
            )
            VALUES
            (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm
            );
            COMMIT;

        WHEN ERROR_PROCESO THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
            v_sqlcode := SQLCODE;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - SQLCODE '||v_sqlcode;

            INSERT INTO CO_TRANSAC_ERROR
            (
                nom_proceso, cod_retorno, fec_proceso, desc_sql, desc_cadena
            )
            VALUES
            (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm
            );
            COMMIT;

        WHEN NO_DATA_FOUND THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;

            INSERT INTO CO_TRANSAC_ERROR
            (
                nom_proceso, cod_retorno, fec_proceso,desc_sql,desc_cadena
            )
            VALUES
            (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm
            );
            COMMIT;

        WHEN ERROR_CALC_LIMITECONS THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutRetorno := -1;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;

            INSERT INTO CO_TRANSAC_ERROR
            (
                nom_proceso, cod_retorno, fec_proceso,desc_sql,desc_cadena
            )
            VALUES
            (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm
            );
            COMMIT;

        WHEN OTHERS THEN
            vp_Gls_Error:=vp_OutGlosa;
            ROLLBACK;
            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
            v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;

            INSERT INTO CO_TRANSAC_ERROR
            (
                nom_proceso, cod_retorno, fec_proceso,desc_sql,desc_cadena
            )
            VALUES
            (
                sNom_proceso, v_sqlcode, SYSDATE,vp_Gls_Error, v_sqlerrm
            );
            COMMIT;

END CO_SIMULAPAGO_LIMITECONSUMO_PR;
/
SHOW ERRORS
