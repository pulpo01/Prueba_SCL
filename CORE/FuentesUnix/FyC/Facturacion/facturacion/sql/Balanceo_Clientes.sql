SET serveroutput on
SET term on
SET feedback off
SET verify off

DECLARE
    TYPE regRANGOS IS RECORD (
        COD_CLIENTE_DESDE   FA_CICLOCLI.COD_CLIENTE%TYPE,
        COD_CLIENTE_HASTA   FA_CICLOCLI.COD_CLIENTE%TYPE,
        CAN_ABONADOS        NUMBER(9),
        CAN_CLIENTES        NUMBER(9));

    TYPE TregRANGOS IS TABLE OF regRANGOS INDEX BY BINARY_INTEGER;

    stRangos                TregRANGOS;
    indstRangos             BINARY_INTEGER := 0;
    ln_ciclo                FA_CICLFACT.COD_CICLO%TYPE;     /* Ciclo de facturación (1, 5, 10, 13, 20)            */
    ln_ciclfact             FA_CICLFACT.COD_CICLFACT%type;  /* Ciclo de facturación (10705, 50705)                */
    ln_instancias           NUMBER;                         /* Cantidad de instancias a ejecutar                  */
    ln_totalabonados        NUMBER;                         /* Cantidad de registros a facturar desde FA_CICLOCLI */
    ln_aboandosrango        NUMBER;                         /* Cantidad de registros por RANGO                    */
    ln_acumula_abonados     NUMBER;                         /* Acumulador de abonados en Rango                    */
    ln_can_clientes         NUMBER;                         /* Cuenta la cantidad de clientes procesados          */
    lv_mensaje              VARCHAR2(1000);                 /* String para construir las salidas por pantallas    */


 CURSOR CLIENTES(pn_ciclo IN NUMBER) IS
    SELECT
            COD_CLIENTE         CLIENTE,
            COUNT(NUM_ABONADO) ABONADOS
    FROM
            FA_CICLOCLI
    WHERE
            NUM_PROCESO    = 0
       AND  COD_CICLO      = pn_ciclo
       AND  IND_MASCARA    = 1
       GROUP BY COD_CLIENTE
       ORDER BY COD_CLIENTE ;

BEGIN
	DBMS_OUTPUT.ENABLE(100000);

    ln_ciclfact   := &1;
    ln_instancias := &2;
    BEGIN
        SELECT COD_CICLO
          INTO LN_CICLO
          FROM FA_CICLFACT
         WHERE COD_CICLFACT = ln_ciclfact;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Error, No se pudo obtener código de ciclo debido a: '|| SQLERRM);
            RAISE;
    END;

    BEGIN
        SELECT COUNT(1)
          INTO LN_TOTALABONADOS
          FROM FA_CICLOCLI
         WHERE NUM_PROCESO = 0
           AND COD_CICLO   = ln_ciclo
           AND IND_MASCARA = 1;

    EXCEPTION
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE ('Error, no se puede determinar universo de abonados a facturar devido a: '|| SQLERRM);
                RAISE;
    END;

    ln_aboandosrango := ln_totalabonados / ln_instancias;
    DBMS_OUTPUT.PUT_LINE ('----------------------------------------------' );
    DBMS_OUTPUT.PUT_LINE ('Numero de abonados a Facturar        : ['|| ln_totalabonados || ']'   );
    DBMS_OUTPUT.PUT_LINE ('Numero de Instancias a Procesar      : ['|| ln_instancias    || ']'      );
    DBMS_OUTPUT.PUT_LINE ('Numero de abonados por Rango (Aprox.): ['|| ln_aboandosrango || ']'   );
    DBMS_OUTPUT.PUT_LINE ('----------------------------------------------' );

    ln_acumula_abonados := 0;
    ln_can_clientes     := 0;

    FOR CC IN CLIENTES(ln_ciclo) LOOP
        /* ES EL PRIMER CLIENTE EN PROCESO... */
        IF ln_can_clientes = 0 THEN
            indstRangos                             := indstRangos + 1;
            stRangos(indstRangos).COD_CLIENTE_DESDE := CC.CLIENTE -1  ;
            stRangos(indstRangos).COD_CLIENTE_HASTA := CC.CLIENTE     ;
            stRangos(indstRangos).CAN_ABONADOS      := CC.ABONADOS    ;
            stRangos(indstRangos).CAN_CLIENTES      := 1              ;
            ln_acumula_abonados                     := CC.ABONADOS    ;
        ELSE
            /* NO ES EL PRIMER CLIENTE EN PROCESO */
            IF stRangos(indstRangos).CAN_ABONADOS + CC.ABONADOS > ln_aboandosrango THEN
                /* se pasa del límite impuesto por ln_aboandosrango */
                /* validar si es el último rango */
                IF ln_instancias = indstRangos THEN
                    /* solo agrega el cliente al rango actual */
                    stRangos(indstRangos).COD_CLIENTE_HASTA := CC.CLIENTE;
                    stRangos(indstRangos).CAN_ABONADOS      := stRangos(indstRangos).CAN_ABONADOS + CC.ABONADOS;
                    stRangos(indstRangos).CAN_CLIENTES      := stRangos(indstRangos).CAN_CLIENTES + 1;
                ELSE
                    /* muestra situacion de rango cerrado */
                    DBMS_OUTPUT.PUT_LINE('RANGO          :['||TO_CHAR(indstRangos                            )||']');
                    DBMS_OUTPUT.PUT_LINE('CLIENTE DESDE  :['||TO_CHAR(stRangos(indstRangos).COD_CLIENTE_DESDE)||']');
                    DBMS_OUTPUT.PUT_LINE('CLIENTE HASTA  :['||TO_CHAR(stRangos(indstRangos).COD_CLIENTE_HASTA)||']');
                    DBMS_OUTPUT.PUT_LINE('TOTAL CLIENTES :['||TO_CHAR(stRangos(indstRangos).CAN_CLIENTES     )||']');
                    DBMS_OUTPUT.PUT_LINE('TOTAL ABONADOS :['||TO_CHAR(stRangos(indstRangos).CAN_ABONADOS     )||')');
				    DBMS_OUTPUT.PUT_LINE ('----------------------------------------------' );

                    /* se debe abrir siguiente rango      */
                    indstRangos                             := indstRangos + 1;
                    stRangos(indstRangos).COD_CLIENTE_DESDE := CC.CLIENTE     ;
                    stRangos(indstRangos).COD_CLIENTE_HASTA := CC.CLIENTE     ;
                    stRangos(indstRangos).CAN_ABONADOS      := CC.ABONADOS    ;
                    stRangos(indstRangos).CAN_CLIENTES      := 1              ;
                END IF;
            ELSE
                /* solo agrega el cliente al rango actual */
                stRangos(indstRangos).COD_CLIENTE_HASTA := CC.CLIENTE;
                stRangos(indstRangos).CAN_ABONADOS      := stRangos(indstRangos).CAN_ABONADOS + CC.ABONADOS;
                stRangos(indstRangos).CAN_CLIENTES      := stRangos(indstRangos).CAN_CLIENTES + 1;
            END IF;

        END IF;
        ln_can_clientes    := ln_can_clientes + 1;
    END LOOP;
    /* muestra situacion de rango cerrado */
    DBMS_OUTPUT.PUT_LINE('RANGO          :['||TO_CHAR(indstRangos                            )||']');
    DBMS_OUTPUT.PUT_LINE('CLIENTE DESDE  :['||TO_CHAR(stRangos(indstRangos).COD_CLIENTE_DESDE)||']');
    DBMS_OUTPUT.PUT_LINE('CLIENTE HASTA  :['||TO_CHAR(stRangos(indstRangos).COD_CLIENTE_HASTA)||']');
    DBMS_OUTPUT.PUT_LINE('TOTAL CLIENTES :['||TO_CHAR(stRangos(indstRangos).CAN_CLIENTES     )||']');
    DBMS_OUTPUT.PUT_LINE('TOTAL ABONADOS :['||TO_CHAR(stRangos(indstRangos).CAN_ABONADOS     )||')');
    DBMS_OUTPUT.PUT_LINE ('----------------------------------------------' );

    /* borra registros existentes para el ciclo */
    BEGIN
        DELETE siscel.FA_RANGOSHOST_TO WHERE COD_CICLFACT = ln_ciclfact;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
    END;


    /* inserta los regisros con los rangos */
    ln_aboandosrango := 0;
    DBMS_OUTPUT.PUT_LINE ('===================== / COMANDOS A EJECUTAR /============================');
    FOR i IN 1..indstRangos LOOP
        BEGIN
            INSERT INTO FA_RANGOSHOST_TO
                (COD_CICLFACT,HOST_ID,COD_CLIENTEINI,COD_CLIENTEFIN,FEC_ULTMOD,NOM_USUARIO)
            VALUES
                (ln_ciclfact, i, stRangos(i).COD_CLIENTE_DESDE, stRangos(i).COD_CLIENTE_HASTA, SYSDATE, USER);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
             DBMS_OUTPUT.PUT_LINE ('ERROR no se pudo insertar el registro : ' ||ln_ciclfact || ' ; '|| i || ' ; '||  stRangos(i).COD_CLIENTE_DESDE || ' ; '||  stRangos(i).COD_CLIENTE_HASTA );
        END;
        DBMS_OUTPUT.PUT_LINE ('Se inserto el registro : ' ||ln_ciclfact || ' ; '|| i || ' ; '||  stRangos(i).COD_CLIENTE_DESDE || ' ; '||  stRangos(i).COD_CLIENTE_HASTA );
        ln_aboandosrango := ln_aboandosrango + stRangos(indstRangos).CAN_ABONADOS;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE ('===================== / COMANDOS A EJECUTAR /============================');

    IF ln_can_clientes = ln_aboandosrango THEN
        DBMS_OUTPUT.PUT_LINE('Warning: El contador de registros no coincide con los clientes procesados...');
        ROLLBACK;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Validación: La cantidad de abonados identificados inicialmente, coincide con la suma de abonados por cada rango construido.');
	    COMMIT;

    END IF;

    DBMS_OUTPUT.PUT_LINE ('===================== / FIN PROCESAMIENTO NORMAL BALANCEO DE CLIENTES /============================');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('===================== / ERROR EN PROCESAMIENTO BALANCEO DE CLIENTES /============================');
        DBMS_OUTPUT.PUT_LINE (SQLERRM);
END;
/
SET serveroutput off
SET term off

EXIT



