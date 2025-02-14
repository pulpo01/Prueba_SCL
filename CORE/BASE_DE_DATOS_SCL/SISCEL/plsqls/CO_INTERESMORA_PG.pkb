CREATE OR REPLACE PACKAGE BODY Co_Interesmora_Pg IS

PROCEDURE CO_INSERTAR_ERRORES_PR(
    EV_SecuenciAco    IN VARCHAR2,
    EV_Concfact        IN VARCHAR2,
    EN_Ruteo        IN NUMBER  ,
    EV_Glserror        IN VARCHAR2,
    EN_Valcob        IN NUMBER ) IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "CO_INSERTAR_ERRORES_PR" Lenguaje="PL/SQL" Fecha="22-12-2004" Versión="1.0.0" Diseñador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Inserta Error en tabla ga_transacabo</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EV_SecuenciAco"   Tipo = "STRING"> Numero de Transaccion</param>
    <param nom="EV_Concfact"      Tipo = "STRING"> Indicador de si hubo error. 0=Sin Error, 1=Con Error</param>
    <param nom="EN_Ruteo"         Tipo = "INTEGER">Indicador de ruteo</param>
    <param nom="EV_Glserror"       Tipo = "STRING"> Descripción del Error ocurrido</param>
    <param nom="EN_Valcob"              Tipo = "INTEGER">Valor de Cobranza </param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    LN_Secuencia    NUMBER(9);  /* Soporte RyC RA-200601160584 17.01.2006 */
    PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        SELECT CO_SEQ_TRANSACINT.NEXTVAL INTO LN_Secuencia FROM DUAL; /* Soporte RyC RA-200601160584 17.01.2006 */

        INSERT INTO CO_TRANSACINT(
              NUM_TRANSACCION
            , COD_CONCFACT
            , COD_RETORNO
            , DES_CADENA
            , MTO_INTERESES)
        VALUES(
                  LN_Secuencia
                , EV_Concfact
                , EN_Ruteo
                , EV_Glserror
                , EN_Valcob);
    COMMIT;
END;

/***********************************************************************************/
PROCEDURE Co_Calculo_Pr(
     EV_SecuenciaTran    IN VARCHAR2,
     EV_CodCliente         IN VARCHAR2,
     EV_NumFolio           IN VARCHAR2,
     EV_PrefPlaza          IN VARCHAR2,
     EV_NumSecuenci        IN VARCHAR2,
     EV_TipDocum           IN VARCHAR2,
     EV_MontoFact          IN VARCHAR2,
     EV_SecCuota           IN VARCHAR2,
     EV_FechaCalcAct       IN VARCHAR2,
     EV_CodConcepto        IN NUMBER DEFAULT -1,
     EV_Columna         IN NUMBER DEFAULT -1) IS  /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Calculo_Pr" Lenguaje="PL/SQL" Fecha="27-04-2005" Versión="1.0.0" Diseñador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Generar intereses de mora por concepto</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EV_SecuenciaTran"      Tipo = "STRING"> Numero de Secuencia Transaccional</param>
    <param nom="EV_CodCliente"         Tipo = "STRING"> Codigo del Cliente de Cartera</param>
    <param nom="EV_NumFolio"           Tipo = "STRING"> Numero de Folio del documento de Cartera</param>
    <param nom="EV_PrefPlaza"           Tipo = "STRING"> Prefijo Plaza</param>
    <param nom="EV_NumSecuenci"           Tipo = "STRING"> Numero de Secuencia de Cartera</param>
    <param nom="EV_TipDocum"           Tipo = "STRING"> Tipo de Documento de Cartera</param>
    <param nom="EV_MontoFact"           Tipo = "STRING"> Saldo Vencido de Cartera</param>
    <param nom="EV_SecCuota"           Tipo = "STRING"> Secuencia de Cuota de Cartera</param>
    <param nom="EV_FechaCalcAct"       Tipo = "STRING"> Fecha de Calculo para Intereses</param>
    <param nom="EV_CodConcepto"        Tipo = "INTEGER">Codigo de Concepto</param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LN_NumDecimal           NUMBER(2);
    LN_FactorInt            NUMBER(8,7);                --LN_FactorInt            NUMBER(8,5); Soporte RyC CGLagos 06-10-2005 XO-200509300780
    LN_FactorDia            NUMBER(3);
    LN_FactorAplicar        NUMBER(8,7);                --LN_FactorAplicar        NUMBER(8,5); Soporte RyC CGLagos 06-10-2005 XO-200509300780
    LN_FactorCobro            NUMBER(8,7);                --LN_FactorCobro        NUMBER(8,5); Soporte RyC CGLagos 06-10-2005 XO-200509300780
    VN_IndFecCobro          VARCHAR2(1);
    LN_MontoDeuda           NUMBER(14,4);
    LN_MontoInteres         NUMBER(14,4) := 0;
    LN_IndRuteo             NUMBER(2);
    LN_Retorno              NUMBER(10);
    LV_DescError            VARCHAR2(255);
    LV_DescInfor            VARCHAR2(255);
    LV_FormatoFecha          VARCHAR2(14);
    TV_ModuloGE             GED_PARAMETROS.VAL_PARAMETRO%TYPE := 'GE';
    TN_codproducto            GED_PARAMETROS.COD_PRODUCTO%TYPE := 1;
    TV_ParamFormFec         GED_PARAMETROS.NOM_PARAMETRO%TYPE := 'FORMATO_SEL2';
    LN_DiasGracia            CO_CATEGORIAS_TD.NRO_DGRACIA%TYPE;
    LN_FecCalculoAnt        CO_INTERESAPLI.FEC_CALCULO%TYPE;
    LN_ConcepMora            CO_TRANSACINT.COD_CONCFACT%TYPE := -1;
    TN_indfacturado             CO_CARTERA.IND_FACTURADO%TYPE := 1;
    TN_diasaplicacion        CO_INTERESES.DIAS_APLICACION%TYPE;
    LN_DiasMorosidad        CO_INTERESES.DIAS_APLICACION%TYPE;
    LN_ValorCero            NUMBER(1) := 0;
    LN_ConceptoCarrier      NUMBER(1) := 4;
    LN_cpcc                    NUMBER(10,5);
    LN_PctIva                  NUMBER(8,2);
    TN_MontoCarrier             CO_CARTERA.IMPORTE_DEBE%TYPE;
    LN_FlagInteres            NUMBER(1) := 0;
    TN_MontoFact            CO_CARTERA.IMPORTE_DEBE%TYPE;
    TV_ParamMtoInt          GED_PARAMETROS.NOM_PARAMETRO%TYPE := 'MONTO_INTERES_MINIMO';
    TV_ParamMtoFac          GED_PARAMETROS.NOM_PARAMETRO%TYPE := 'MONTO_FAC_INTER_MIN';
    LN_Mto_interesminimo NUMBER;
    LN_Mto_fac_intermin  NUMBER;

    /***********Inicio Variables de Negocio *******/
    LV_ValidarBaja               GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_FactorCPPC               GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_FactorIVA               GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_EventoInteres           GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_MedidaInteres           GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_FactorCarrier           GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';
    LV_TipoPago                   GED_PARAMETROS.VAL_PARAMETRO%TYPE:='';


    /******************************CURSOR TMC, MPR, COL**********************************/
    CURSOR cur_deudaF ( LV_FechaCalcAct IN VARCHAR2    , LV_FormatoFecha IN VARCHAR2,
                        LV_CodCliente     IN VARCHAR2    , LV_TipDocum       IN VARCHAR2,
                        LV_NumSecuenci     IN VARCHAR2    , LV_NumFolio       IN VARCHAR2,
                        LV_PrefPlaza     IN VARCHAR2    , LV_SecCuota       IN VARCHAR2,
                        LN_IndFacturado IN NUMBER   , LN_Cod_concepto IN NUMBER , LN_Columna IN NUMBER) IS /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
    SELECT     /*+INDEX (car pk_co_cartera)*/
            TO_DATE( LV_FechaCalcAct, LV_FormatoFecha) - ( TRUNC( car.fec_efectividad ) ) AS dias1,
               TO_DATE( LV_FechaCalcAct, LV_FormatoFecha) - ( TRUNC( car.fec_vencimie ) ) AS dias2,
               MONTHS_BETWEEN( TO_DATE( LV_FechaCalcAct, LV_FormatoFecha ) , TRUNC( car.fec_efectividad ) ) AS dias3,
               MONTHS_BETWEEN( TO_DATE( LV_FechaCalcAct, LV_FormatoFecha ) , TRUNC( car.fec_vencimie ) ) AS dias4,
               TRUNC(car.fec_efectividad) AS fecha,
               SUM(car.importe_debe)-SUM(car.importe_haber) AS deuda,  /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
               car.cod_tipdocum,
               conc.cod_concfact
      FROM     co_cartera car, CO_CONCEPTOS conc
     WHERE     car.cod_concepto      = conc.cod_concepto
       AND     conc.cod_concfact > 0
       AND     car.cod_cliente       = TO_NUMBER(LV_CodCliente)
       AND     car.cod_tipdocum     = TO_NUMBER(LV_TipDocum)
       AND     car.num_secuenci      = TO_NUMBER(LV_NumSecuenci)
       AND     car.cod_concepto    = DECODE(LN_Cod_concepto,-1,car.cod_concepto,LN_Cod_concepto)
    AND     car.columna         = DECODE(LN_Columna,-1,car.columna,LN_Columna)     /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
       AND     car.num_folio         = TO_NUMBER(LV_NumFolio)
       AND     car.pref_plaza        = LV_PrefPlaza
       AND     (car.sec_cuota        = TO_NUMBER(LV_SecCuota) OR car.sec_cuota IS NULL)
       AND     car.ind_facturado     = LN_IndFacturado
    GROUP BY car.fec_efectividad
            , car.fec_vencimie
            , car.cod_tipdocum
            , conc.cod_concfact
    UNION ALL
    SELECT     /*+INDEX (car pk_co_cancelados)*/
            TO_DATE( LV_FechaCalcAct, LV_FormatoFecha) - ( TRUNC( car.fec_efectividad ) ) AS dias1,
               TO_DATE( LV_FechaCalcAct, LV_FormatoFecha) - ( TRUNC( car.fec_vencimie ) ) AS dias2,
               MONTHS_BETWEEN( TO_DATE( LV_FechaCalcAct, LV_FormatoFecha ) , TRUNC( car.fec_efectividad ) ) AS dias3,
               MONTHS_BETWEEN( TO_DATE( LV_FechaCalcAct, LV_FormatoFecha ) , TRUNC( car.fec_vencimie ) ) AS dias4,
               TRUNC(car.fec_efectividad) AS fecha,
               SUM(car.importe_debe)-SUM(car.importe_haber) AS deuda,  /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
               car.cod_tipdocum,
               conc.cod_concfact
      FROM     co_cancelados car, CO_CONCEPTOS conc
     WHERE     car.cod_concepto     = conc.cod_concepto
       AND     conc.cod_concfact    > 0
       AND     car.cod_cliente       = TO_NUMBER(LV_CodCliente)
       AND     car.cod_tipdocum    = TO_NUMBER(LV_TipDocum)
       AND     car.num_secuenci      = TO_NUMBER(LV_NumSecuenci)
       AND     car.cod_concepto      = DECODE(LN_Cod_concepto,-1,car.cod_concepto,LN_Cod_concepto)
    AND     car.columna         = DECODE(LN_Columna,-1,car.columna,LN_Columna)   /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
       AND     car.num_folio         = TO_NUMBER(LV_NumFolio)
       AND     car.pref_plaza        = LV_PrefPlaza
       AND     (car.sec_cuota        = TO_NUMBER(LV_SecCuota) OR car.sec_cuota IS NULL)
       AND     car.ind_facturado    = LN_IndFacturado
    GROUP BY car.fec_efectividad
            , car.fec_vencimie
            , car.cod_tipdocum
            , conc.cod_concfact;

    ERROR_PROCESO EXCEPTION;

    BEGIN
        LV_DescError := '';

        TN_MontoFact := TO_NUMBER( EV_MontoFact );

        LN_IndRuteo  := 10;
        LV_DescError := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
        LN_NumDecimal:= GE_PAC_GENERAL.PARAM_GENERAL('num_decimal');

        LN_IndRuteo  := 20;
        LV_DescError := 'Select del formato de fecha';

        SELECT    par.val_parametro
          INTO    LV_FormatoFecha
          FROM    ged_parametros par
         WHERE    par.cod_modulo       = TV_ModuloGE
           AND     par.cod_producto     = TN_codproducto
           AND     par.nom_parametro    = TV_ParamFormFec;

      /* Inicio P-MIX-09003 */
        SELECT    par.val_parametro
          INTO    LN_Mto_interesminimo
          FROM    ged_parametros par
         WHERE    par.cod_modulo       = TV_ModuloGE
           AND     par.cod_producto     = TN_codproducto
           AND     par.nom_parametro    = TV_ParamMtoInt;

        SELECT    par.val_parametro
          INTO    LN_Mto_fac_intermin
          FROM    ged_parametros par
         WHERE    par.cod_modulo       = TV_ModuloGE
           AND     par.cod_producto     = TN_codproducto
           AND     par.nom_parametro    = TV_ParamMtoFac;
      /* Fin P-MIX-09003 */

        LV_DescError := 'Error al invocar Procedimiento CO_OBTIENE_PARAM_NEGOCIO_PR';
        Co_Obtiene_Param_Negocio_Pr (
              LV_ValidarBaja
            , LV_FactorCPPC
            , LV_FactorIVA
            , LV_EventoInteres
            , LV_MedidaInteres
            , LV_FactorCarrier
            , LV_TipoPago
            , LN_Retorno
            , LV_DescError );

        IF LV_ValidarBaja = 'VALIDA_BAJA' THEN
            LV_DescError := 'Error al invocar Procedimiento Co_Verifica_Baja_Pr';
            Co_Verifica_Baja_Pr(EV_CodCliente , LN_Retorno );

            IF LN_Retorno = 0 THEN
                   LV_DescError := EV_CodCliente|| '-' || EV_TipDocum || '-' || EV_NumSecuenci || '-' || EV_NumFolio|| '-' || EV_PrefPlaza || '(Cliente NO está Baja)';
                   LN_IndRuteo := 30;
                   RAISE ERROR_PROCESO;
            END IF;
        END IF;

        IF LV_FactorCPPC = 'APLICAR' THEN
            LN_IndRuteo := 40;
            LV_DescError := 'Error al invocar Procedimiento Co_Verifica_Baja_Pr';
            Co_Obtener_Cppc_Pr (LN_Retorno);
            LN_cpcc := LN_Retorno;
        END IF;

        IF LV_FactorIVA = 'APLICAR' THEN
            LN_IndRuteo := 50;
            LV_DescError := 'Error al invocar Procedimiento Co_Obtener_Pct_Iva_Pr';
            Co_Obtener_Pct_Iva_Pr(LN_Retorno);
            LN_PctIva := LN_Retorno;
        END IF;

        LN_IndRuteo := 60;
            LV_DescError := 'Obtiene tasa de interes, dias de gracia del cliente';

        SELECT      cin.factor_int
                , cin.factor_dia
                , cin.ind_fec_cobro
                , cin.dias_aplicacion
                , cat.nro_dgracia
        INTO      LN_FactorInt
                , LN_FactorDia
                , VN_IndFecCobro
                , TN_diasaplicacion
                , LN_DiasGracia
        FROM    ge_clientes cli
                , CO_CATEGORIAS_TD cat
                , CO_INTERESES cin
                , CO_CATCOBCLIE_TD catcli
        WHERE    cli.cod_cliente     = EV_CodCliente
        AND       cli.cod_categoria    = catcli.cod_catecli
        AND       cat.cod_categoria     = catcli.cod_catecob
        AND       cat.cod_tasa           = cin.cod_tasa
        AND       TRUNC(SYSDATE) BETWEEN TRUNC(cin.fec_vigencia_dd_dh) AND TRUNC(cin.fec_vigencia_hh_dh);

        IF LV_EventoInteres = 'MENSUAL' OR LV_EventoInteres = 'MENSUAL/POR PAGO' THEN
            LN_IndRuteo := 70;
              LV_DescError := 'Error al invocar Procedimiento Co_Fecha_Calculoint_Apli_Pr';
            Co_Fecha_Calculoint_Apli_Pr (
                EV_CodCliente
                , EV_NumFolio
                , EV_PrefPlaza
                , EV_SecCuota
                , LV_TipoPago
                , LN_FecCalculoAnt );
        END IF;

          LV_DescError := 'Error al LOOP recorre FETCH cur_deuda';

        FOR cur_deuda IN cur_deudaF ( EV_FechaCalcAct,  LV_FormatoFecha,  EV_CodCliente,  EV_TipDocum,
                                      EV_NumSecuenci ,  EV_NumFolio    ,  EV_PrefPlaza ,  EV_SecCuota,
                                      TN_indfacturado,  EV_CodConcepto ,  EV_Columna ) LOOP     /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/

           LN_ConcepMora:= cur_deuda.cod_concfact;
          LN_MontoDeuda := cur_deuda.deuda;

            /* Si registro es de co_cancelados se asigna monto del parametro proveniente de la co_pagosconc*/
            /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
            IF LN_MontoDeuda = 0 THEN
                   LN_MontoDeuda:=TN_MontoFact;
            ELSE
                IF EV_CodConcepto != -1 THEN
                    LN_MontoDeuda := LN_MontoDeuda + TN_MontoFact;
                END IF;
            END IF;

            LN_MontoDeuda    := GE_PAC_GENERAL.REDONDEA( LN_MontoDeuda, LN_NumDecimal, LN_ValorCero );
            LN_DiasMorosidad := 0;
            LN_MontoInteres  := 0;

          LN_IndRuteo := 80;
           LV_DescError := 'Calcula Dias de Mora (1)';
            IF LV_MedidaInteres = 'DIAS' THEN
                IF VN_IndFecCobro = 'F' THEN                -- fecha de efectividad
                        LN_DiasMorosidad := cur_deuda.dias1;
                ELSIF VN_IndFecCobro = 'V' THEN
                       LN_DiasMorosidad := cur_deuda.dias2;    -- fecha de vencimiento
                END IF;
            ELSIF LV_MedidaInteres = 'MES' THEN
                IF VN_IndFecCobro = 'F' THEN
                           LN_DiasMorosidad := cur_deuda.dias3;    -- fecha de efectividad
                ELSIF VN_IndFecCobro = 'V' THEN
                        LN_DiasMorosidad := cur_deuda.dias4;    -- fecha de vencimiento
                END IF;
            END IF;

            IF LN_FecCalculoAnt IS NULL THEN
                IF( LN_DiasMorosidad <= LN_DiasGracia ) THEN
                    LN_DiasMorosidad := 0;
                END IF;
            ELSE
                LN_DiasMorosidad := TRUNC( TO_DATE( EV_FechaCalcAct, LV_FormatoFecha ) - TRUNC( LN_FecCalculoAnt ) );
            END IF;

            IF LN_DiasMorosidad > 0 THEN
                /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
                /*IF LV_FactorCarrier = 'VERIFICAR' THEN
                    BEGIN
                        SELECT     SUM(NVL(A.IMPORTE_DEBE,LN_ValorCero) - NVL(A.IMPORTE_HABER, LN_ValorCero))
                          INTO     TN_MontoCarrier
                          FROM     co_cartera a , CO_CONCEPTOS b
                         WHERE     a.cod_cliente      = EV_CodCliente
                           AND     a.num_secuenci    = EV_NumSecuenci
                           AND     b.cod_tipconce     = LN_ConceptoCarrier
                           AND     a.cod_concepto     = b.cod_concepto
                           AND     a.num_folio        = EV_NumFolio
                           AND     a.pref_plaza       = EV_PrefPlaza;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                     TN_MontoCarrier := 0;

                        IF ( LN_MontoDeuda - TN_MontoFact ) < TN_MontoCarrier THEN
                                  LN_MontoDeuda := LN_MontoDeuda - TN_MontoCarrier;
                        END IF;
                    END;
                ELSE
                    IF LN_MontoDeuda = TN_MontoFact THEN
                        LN_MontoDeuda := TN_MontoFact;
                    END IF;
                END IF;*/
                /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
                --IF TN_MontoFact < LN_MontoDeuda THEN   --RA-200511010043 DVergara 08-11-2005 Suma el saldo + abono
                --IF TN_MontoFact  < (LN_MontoDeuda + TN_MontoFact) THEN --RA-0264 09.12.2005
                --    LN_MontoDeuda := TN_MontoFact;
                --END IF;

                --TN_MontoFact := TN_MontoFact - LN_MontoDeuda;

                LN_MontoDeuda := GE_PAC_GENERAL.REDONDEA( LN_MontoDeuda, LN_NumDecimal, LN_ValorCero );

                LN_FactorCobro := LN_FactorInt / LN_FactorDia;
                LN_FactorAplicar := LN_FactorCobro / 100;

                LN_MontoInteres := 0;

                IF LV_FactorCPPC = 'APLICAR' THEN
                    LN_FactorAplicar := ( LN_FactorAplicar + 1 ) * LN_cpcc;
                    LN_MontoInteres := ( ( LN_MontoDeuda * ( POWER( LN_FactorAplicar, LN_DiasMorosidad ) ) ) - LN_MontoDeuda );
                ELSE
                    LN_MontoInteres := ( ( LN_FactorAplicar * LN_DiasMorosidad ) * LN_MontoDeuda );
                END IF;

                /*Inicio P-MIX-09003*/

                if LN_MontoInteres < LN_Mto_interesminimo then
                   LN_MontoInteres := LN_Mto_interesminimo;
                end if;

                if LN_MontoDeuda < LN_Mto_fac_intermin then
                   LN_MontoInteres:=0;
                end if;

                /*fin P-MIX-09003*/

                IF LV_FactorIVA = 'APLICAR' THEN
                    LN_MontoInteres := LN_MontoInteres * LN_PctIva;
                END IF;
            END IF;

            LN_IndRuteo := 90;
            LV_DescError := 'Inserta Interes (1)';
            LV_DescInfor := EV_CodCliente || '-' || EV_NumFolio || '-' || EV_PrefPlaza || '-' || EV_NumSecuenci || '-' || EV_TipDocum || '-' || EV_MontoFact || '-' || EV_SecCuota || '-' || EV_FechaCalcAct;

            INSERT INTO CO_TRANSACINT (
                          NUM_TRANSACCION
                        , COD_RETORNO
                        , DES_CADENA
                        , MTO_INTERESES
                        , FAC_COBRO
                        , NUM_DIAS
                        , COD_CONCFACT
                        , IMP_CARGO )
                VALUES (
                          TO_NUMBER( EV_SecuenciaTran )
                        , 0
                        , LV_DescInfor
                        , GE_PAC_GENERAL.REDONDEA( LN_MontoInteres, LN_NumDecimal, LN_ValorCero )
                        , LN_FactorCobro
                        , LN_DiasMorosidad
                        , LN_ConcepMora
                        , LN_MontoDeuda );

            LN_FlagInteres := 1;

            IF TN_MontoFact <= 0 THEN
                EXIT;
            END IF;
        END LOOP; /* for cur_deuda in cur_deudaf loop */

        IF LN_FlagInteres = 0 THEN
            LV_DescError := '';
               LN_IndRuteo := 0;
            RAISE ERROR_PROCESO;
        END IF;

    EXCEPTION
           WHEN OTHERS THEN
           LV_DescError := EV_CodCliente || '-' || EV_NumFolio || '-' || EV_PrefPlaza || '-' || EV_NumSecuenci || '-' || EV_TipDocum || '-' || EV_MontoFact || '-' || EV_SecCuota || '-' || EV_FechaCalcAct || '-' || LV_DescError || ' - ' || SQLERRM;
           CO_INSERTAR_ERRORES_PR(
                     EV_SecuenciaTran
                   , LN_ConcepMora
                   , LN_IndRuteo
                   , LV_DescError
                   , GE_PAC_GENERAL.REDONDEA( LN_MontoInteres, LN_NumDecimal, LN_ValorCero) );
END Co_Calculo_Pr;

/***********************************************************************************/
PROCEDURE Co_Obtiene_Param_Negocio_Pr (
    EV_ValidarBaja        IN OUT NOCOPY VARCHAR2,
    EV_FactorCPPC        IN OUT NOCOPY VARCHAR2,
    EV_FactorIVA           IN OUT NOCOPY VARCHAR2,
    EV_EventoInteres    IN OUT NOCOPY VARCHAR2,
    EV_MedidaInteres    IN OUT NOCOPY VARCHAR2,
    EV_FactorCarrier       IN OUT NOCOPY VARCHAR2,
    EV_TipoPago            IN OUT NOCOPY VARCHAR2,
    EV_retorno            IN OUT NOCOPY NUMBER  ,
    EV_DescError           IN OUT NOCOPY VARCHAR2) IS

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Obtiene_Param_Negocio_Pr" Lenguaje="PL/SQL" Fecha="28-04-2005" Versión="1.0.0" Diseñador="NN" Programador="MGG" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Obtiene los parametros de negocio a utilizar en el calculo de interes</Descripción>
    <Parámetros>
    <Entrada>
    </Entrada>
    <Salida>
    <param nom="EV_ValidarBaja"        Tipo = "STRING"> Parametro de negocio para validar Baja de abonados</param>
    <param nom="EV_FactorCPPC"         Tipo = "STRING"> Parametro de negocio para aplicar CPPC</param>
    <param nom="EV_FactorIVA"           Tipo = "STRING"> Parametro de negocio para aplicar IVA.</param>
    <param nom="EV_EventoInteres"      Tipo = "STRING"> Parametro de negocio para saber que evento gatilla el calculo de interes</param>
    <param nom="EV_MedidaInteres"    Tipo = "STRING"> Parametro de negocio para distinguir si se aplica interes por dias o mes</param>
    <param nom="EV_FactorCarrier"      Tipo = "STRING"> Parametro de negocio para aplicar logica de interes por carrier</param>
    <param nom="EV_TipoPago"           Tipo = "STRING"> Tipo de Pago</param>
    <param nom="EV_retorno"                  Tipo = "STRING"> Valor de retorno 0=OK 1=ERROR</param>
    <param nom="EV_DescError"           Tipo = "STRING"> Descripcion error</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LN_ValorParametro     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LN_valorUno            NUMBER       := 1;
    LV_modulo              VARCHAR2(2)  := 'CO';
    LV_VALIDAR_BAJA        VARCHAR2(12) := 'VALIDAR BAJA';
    LV_FACTOR_CPPC         VARCHAR2(11) := 'FACTOR CPPC';
    LV_FACTOR_IVA          VARCHAR2(10) := 'FACTOR IVA';
    LV_EVENTO_CALCULO   VARCHAR2(14) := 'EVENTO CALCULO';
    LV_MEDIDA_INTERES      VARCHAR2(14) := 'MEDIDA INTERES';
    LV_FACTOR_CARRIER      VARCHAR2(14) := 'FACTOR CARRIER';
    LV_TIPO_PAGO           VARCHAR2(12) := 'TIPO PAGO';

    BEGIN
        EV_retorno := 0;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <VALIDAR BAJA>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
          FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_VALIDAR_BAJA;

        EV_ValidarBaja := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <FACTOR CPPC>';
              SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_FACTOR_CPPC;

        EV_FactorCPPC := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <FACTOR IVA>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_FACTOR_IVA;

           EV_FactorIVA := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <EVENTO CALCULO>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_EVENTO_CALCULO;

           EV_EventoInteres := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <MEDIDA INTERES>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_MEDIDA_INTERES;

        EV_MedidaInteres := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <FACTOR CARRIER>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_FACTOR_CARRIER;

           EV_FactorCarrier := LN_ValorParametro;

           EV_DescError := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = <TIPO PAGO>';
           SELECT     val_parametro
          INTO     LN_ValorParametro
             FROM     ged_parametros
            WHERE     cod_producto     = LN_valorUno
           AND     cod_modulo       = LV_modulo
              AND     nom_parametro    = LV_TIPO_PAGO;

        EV_TipoPago := LN_ValorParametro;

    EXCEPTION
            WHEN OTHERS THEN
            EV_retorno := 1;
            EV_DescError := EV_DescError || ' - ' || SQLERRM;
END Co_Obtiene_Param_Negocio_Pr;

/***********************************************************************************/
PROCEDURE Co_Verifica_Baja_Pr (
    EV_cliente     IN NUMBER,
    EN_retorno     OUT NOCOPY NUMBER ) IS

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Verifica_Baja_Pr" Lenguaje="PL/SQL" Fecha="28-04-2005" Versión="1.0.0" Diseñador="NN" Programador="GAC" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Verifica un cliente con acciones de baja</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EV_ValidarBaja"    Tipo="INTEGER">Parametro de negocio para validar Baja de abonados</param>
    </Entrada>
    <Salida>
    <param nom="EN_retorno"              Tipo="INTEGER">Valor de retorno 0= Sin Acciones de Baja 0<> Con Acciones de Baja</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LN_baja            PLS_INTEGER;
    LV_baja            VARCHAR2(4) := 'BAJA';
    LV_estadobaja    VARCHAR2(3) := 'EJE';
    LN_uno            NUMBER(1)     := 1;

    BEGIN
           SELECT    COUNT(LN_uno)
           INTO    LN_baja
           FROM    CO_ACCIONES acc
           WHERE    acc.cod_cliente    = EV_cliente
           AND     acc.cod_rutina     = LV_baja
           AND     acc.cod_estado     = LV_estadobaja;

           EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                       LN_baja := 0;

        IF LN_baja = 0 THEN
               EN_retorno:= 0;
        ELSE
               EN_retorno:= LN_baja;
        END IF;
END Co_Verifica_Baja_Pr;

/***********************************************************************************/
PROCEDURE Co_Fecha_Calculoint_Apli_Pr (
    EN_cliente         IN NUMBER,
    EN_folio         IN NUMBER,
    EN_prefplaza     IN VARCHAR2,
    EN_seccuota     IN VARCHAR2,
    EN_TipoPago     IN VARCHAR2,
    EN_RetFechaCalc    IN OUT NOCOPY VARCHAR2 ) IS

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Fecha_Calculoint_Apli_Pr" Lenguaje="PL/SQL" Fecha="28-04-2005" Versión="1.0.0" Diseñador="NN" Programador="GAC" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Selecciona la maxima fecha de calculo de interes</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EN_cliente"           Tipo="INTEGER">Codigo del Cliente de Cartera</param>
    <param nom="EN_folio"           Tipo="INTEGER">Numero de Folio del documento de Cartera</param>
    <param nom="EN_prefplaza"         Tipo="STRING"> Prefijo Plaza</param>
    <param nom="EN_seccuota"       Tipo="STRING"> Secuencia de Cuota de Cartera</param>
    <param nom="EN_TipoPago"       Tipo="STRING"> Tipo de pago definido en la operadora</param>
    </Entrada>
    <Salida>
    <param nom="EN_RetFechaCalc"   Tipo="STRING"> Valor de retorno</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    TD_feccalculo        CO_INTERESAPLI.FEC_CALCULO%TYPE;
    TV_modulocalculo    CO_INTERESAPLI.COD_MODULO%TYPE := 'IMC';
    LN_uno                NUMBER(1) := 1;
    LN_cien                NUMBER(3) := 100;

    BEGIN
        IF EN_TipoPago = 'TOTAL' THEN
            SELECT    MAX(CIN.fec_calculo)
            INTO    TD_feccalculo
            FROM    CO_INTERESAPLI CIN
            WHERE    CIN.cod_cliente     = EN_cliente
            AND     CIN.num_folio       = EN_folio
            AND     CIN.pref_plaza      = EN_prefplaza
            AND     (CIN.sec_cuota      = EN_seccuota OR CIN.sec_cuota IS NULL);
            /*AND     CIN.cod_modulo      = TV_modulocalculo; */ /*CAGV 21-03-2006 CO-200603220007 - CGLagos 24-04-2007 Inc. 35235 - 21-06-2007 Inc. 38166*/
        END IF;

        EN_RetFechaCalc := TD_feccalculo;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            TD_feccalculo := NULL;
            EN_RetFechaCalc := TD_feccalculo;

END Co_Fecha_Calculoint_Apli_Pr;

/***********************************************************************************/
PROCEDURE Co_Obtener_Cppc_Pr (EN_retorno OUT NOCOPY NUMBER) IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Obtener_Cppc_Pr" Lenguaje="PL/SQL" Fecha="28-04-2005" Versión="1.0.0" Diseñador="NN" Programador="GAC" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Obtiene el tipo de conversion para factor CPP</Descripción>
    <Parámetros>
    <Entrada>
    </Entrada>
    <Salida>
    <param nom="EN_retorno"          Tipo="STRING"> Valor de retorno</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LN_cpcc             NUMBER(10,5);
    LV_monedaCpp        VARCHAR2(3) := 'CPP';
    LN_uno                NUMBER(1)   := 1;
    LN_cien                NUMBER(3)   := 100;
    LN_YYMMDD           VARCHAR2(6) := 'YYMMDD';

    BEGIN
        SELECT    (con.cambio/LN_cien) + LN_uno
        INTO    LN_cpcc
        FROM    ge_conversion con
        WHERE    con.cod_moneda = LV_monedaCpp
        AND        TO_CHAR(SYSDATE,LN_YYMMDD) BETWEEN TO_CHAR(con.fec_desde,LN_YYMMDD) AND TO_CHAR(con.fec_hasta,LN_YYMMDD) ;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_cpcc := 0;

        IF LN_cpcc = 0 THEN
            EN_retorno:= 0;
        ELSE
            EN_retorno:= LN_cpcc;
        END IF;

END Co_Obtener_Cppc_Pr    ;

/***********************************************************************************/
PROCEDURE Co_Obtener_Pct_Iva_Pr (EN_retorno OUT NOCOPY NUMBER) IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "Co_Obtener_Pct_Iva_Pr" Lenguaje="PL/SQL" Fecha="28-04-2005" Versión="1.0.0" Diseñador="NN" Programador="GAC" Ambiente="BD NN">
    <Retorno>NA</Retorno>
    <Descripción>Obtiene el factor de IVA</Descripción>
    <Parámetros>
    <Entrada>
    </Entrada>
    <Salida>
    <param nom="EN_retorno"          Tipo="STRING"> Valor de retorno</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LN_pctiva    NUMBER(8,2);
    LN_uno        NUMBER(1) := 1;
    LN_cien        NUMBER(3) := 100;

    BEGIN
        SELECT     (dat.pct_iva/LN_cien ) + LN_uno
              INTO     LN_pctiva
              FROM     fa_datosgener dat;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_pctiva := 0;

        IF LN_pctiva = 0 THEN
            EN_retorno:= 0;
        ELSE
            EN_retorno:= LN_pctiva;
        END IF;
END Co_Obtener_Pct_Iva_Pr    ;

END Co_Interesmora_Pg;
/
SHOW ERRORS