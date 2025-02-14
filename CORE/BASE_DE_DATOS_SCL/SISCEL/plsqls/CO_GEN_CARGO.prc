CREATE OR REPLACE PROCEDURE CO_GEN_CARGO (
lhCodCliente_Arg        IN NUMBER,                              /* Codigo del Cliente */
lhNumAbonado_Arg        IN NUMBER,                              /* Numero de abonado (puede ser 0 o null) */
szhCodConcepto_Arg      IN VARCHAR2,                    /* Codigo del Concepto (de cargo de facturacion)*/
fhImpTarifa_Arg         IN NUMBER,                              /* Importe Tarifa */
szhCodMoneda_Arg        IN VARCHAR2,                    /* Codigo de Moneda */
lhCodProducto_Arg       IN NUMBER,                              /* ?Celular (1) o Beeper (2)? */
lhNumCargo_Arg          IN NUMBER,                              /* Numero del Cargo obtenido de la secuencia */
EN_ciclofact            IN NUMBER DEFAULT 0             /* Ciclo de facturacion en el que se incluira el cargo*/
    ) IS
/*    Funcisn        :Genera cargos en GE_CARGOS                                                                */
/*    Autor          :?                                                                                                 */
/*    Fecha          :                                                                                          */
/*    Modificaciones :26/09/2002 (RSALAZAR) se cambis BETWEEN FEC_DESDECFIJOS AND FEC_HASTACFIJOS;              */
/*                                        por BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM; en OBTIENE_COD_CICLFACT                          */
/*                   :16.9.03 (rvc) CH-1310 Se valida que tarifa > 0 para insertar cargo                */
/*                               :28/04/2005 Se agrega el parametro EN_ciclofact                                    */
/*    Ult.Paso Pruduc:30/09/2002 (MPR --> Produccisn Pto.Rico)                                          */

TERMINO_CON_ERROR           EXCEPTION;

iDecimal                    NUMBER(2);
szhNullVariable             VARCHAR2(1);
ihAuxValidacion             NUMBER(1);
lhCodCiclFact               FA_CICLFACT.COD_CICLFACT%TYPE := NULL;     /* NUMBER(6) */
ihCodCiclo                  GE_CLIENTES.COD_CICLO%TYPE;        /* NUMBER(2) */
ihIndFactur                 GE_CLIENTES.IND_FACTUR%TYPE;       /* NUMBER(1) */
lhCodPlanCom                GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;  /* NUMBER(6) */
lhNumAbonado                GE_CARGOS.NUM_ABONADO%TYPE;        /* NUMBER(8) */

/* ********************************************************************************************* */
/* (0) * MODULO PRINCIPAL    */
/* ********************************************************************************************* */
BEGIN
    /* VALIDA_ARGUMENTOS */
    IF (lhCodCliente_Arg  IS NULL  OR  szhCodConcepto_Arg IS NULL  OR
        fhImpTarifa_Arg   IS NULL  OR  szhCodMoneda_Arg   IS NULL  OR
        lhCodProducto_Arg IS NULL  OR  lhNumCargo_Arg     IS NULL   )  THEN

        SELECT 1/0
        INTO szhNullVariable
        FROM DUAL;
    END IF;

    /* CH-1310 */
    IF fhImpTarifa_Arg > 0  THEN
            SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
            INTO   iDecimal
            FROM   DUAL;

            /* OBTIENE_CICLO_CLIENTE */
            SELECT COD_CICLO  , IND_FACTUR
            INTO   ihCodCiclo , ihIndFactur
            FROM   GE_CLIENTES
            WHERE  COD_CLIENTE = lhCodCliente_Arg;

                IF EN_ciclofact = 0 THEN
                    /* OBTIENE_COD_CICLFACT */
                    SELECT COD_CICLFACT
                    INTO   lhCodCiclFact
                    FROM   FA_CICLFACT
                    WHERE  COD_CICLO = ihCodCiclo
                    AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
                ELSE
                        lhCodCiclFact := EN_ciclofact;
                END IF;

            /* OBTIENE_PLAN_COMERCIAL */
            SELECT COD_PLANCOM
            INTO   lhCodPlanCom
            FROM   GA_CLIENTE_PCOM
            WHERE  COD_CLIENTE = lhCodCliente_Arg
            AND    SYSDATE    >= FEC_DESDE
            AND   (FEC_HASTA IS NULL OR SYSDATE <= FEC_HASTA );

            /* VALIDA QUE EXISTA EL REGISTRO CORRESPONDIENTE ANTES DE ACTUALIZARLO (solo si es abonado) */
            IF (lhNumAbonado_Arg IS NOT NULL AND lhNumAbonado_Arg != 0 ) THEN
                lhNumAbonado := lhNumAbonado_Arg;
                /* En caso de no haber registro que updatear, no devuelve error, sino un '0 rows updated' */

                        /* ACTUALIZA_INFACCEL_INFACBEEP */
                        IF (lhCodProducto_Arg = 1) THEN                     /* Celular */
                            /* valida que exista, uno y solo uno */
                            SELECT IND_CARGOS
                            INTO   ihAuxValidacion
                            FROM   GA_INFACCEL
                            WHERE  COD_CLIENTE = lhCodCliente_Arg
                            AND    NUM_ABONADO = lhNumAbonado_Arg
                            AND    COD_CICLFACT = lhCodCiclFact
                            AND    IND_ACTUAC <> 6;

                            /* updatea */
                            UPDATE GA_INFACCEL SET
                                   IND_CARGOS = 1
                            WHERE  COD_CLIENTE  = lhCodCliente_Arg
                            AND    NUM_ABONADO  = lhNumAbonado_Arg
                            AND    COD_CICLFACT = lhCodCiclFact
                            AND    IND_ACTUAC <> 6;

                        ELSE                                               /* Beeper */
                            /* valida que exista, uno y solo uno */
                            SELECT IND_CARGOS
                            INTO   ihAuxValidacion
                            FROM   GA_INFACBEEP
                            WHERE  COD_CLIENTE = lhCodCliente_Arg
                            AND    NUM_ABONADO = lhNumAbonado_Arg
                            AND    COD_CICLFACT = lhCodCiclFact
                            AND    IND_ACTUAC <> 6;

                            /* updatea */
                            UPDATE GA_INFACBEEP SET
                                   IND_CARGOS = 1
                            WHERE  COD_CLIENTE  = lhCodCliente_Arg
                            AND    NUM_ABONADO  = lhNumAbonado_Arg
                            AND    COD_CICLFACT = lhCodCiclFact
                            AND    IND_ACTUAC <> 6;

                        END IF;
            ELSE /* Si el abonado en Null o Cero lo graba como NULL en la ge_cargos */
                         lhNumAbonado := NULL;
            END IF;

            /* INSERTA_CARGO */
            INSERT INTO GE_CARGOS
                   (NUM_CARGO   , COD_CLIENTE  , COD_PRODUCTO   , COD_CONCEPTO,
                    FEC_ALTA    , IMP_CARGO    , COD_MONEDA     , COD_PLANCOM ,
                    NUM_UNIDADES, IND_FACTUR   , NUM_TRANSACCION, NUM_VENTA   ,
                    NUM_ABONADO , COD_CICLFACT , NUM_FACTURA    , NOM_USUARORA)
            VALUES (lhNumCargo_Arg    ,       /* NUM_CARGO */
                    lhCodCliente_Arg  ,
                    lhCodProducto_Arg ,
                    szhCodConcepto_Arg,
                    SYSDATE           ,      /* FEC_ALTA */
                    GE_PAC_GENERAL.REDONDEA(fhImpTarifa_Arg, iDecimal, 0),
                    szhCodMoneda_Arg  ,
                    lhCodPlanCom      ,
                    1                 ,      /* NUM_UNIDADES */
                    ihIndFactur       ,
                    0                 ,      /* NUM_TRANSACCION */
                    0                 ,      /* NUM_VENTA */
                    lhNumAbonado      ,      /* lhNumAbonado_Arg o NULL */
                    lhCodCiclFact     ,
                    0                 ,      /* NUM_FACTURA */
                    USER              );     /* NOMBRE USUARIO del DUAL (similar al SYSDATE) */
        END IF; /* CH-1310 */
END CO_GEN_CARGO;
/
SHOW ERRORS
