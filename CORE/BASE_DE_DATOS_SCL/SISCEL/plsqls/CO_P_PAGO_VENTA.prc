CREATE OR REPLACE PROCEDURE CO_P_PAGO_VENTA
(
VP_CLIENTE                  IN VARCHAR2 ,
VP_NUM_TRANSACCION          IN VARCHAR2 ,
VP_NUM_VENTA                IN VARCHAR2 ,
VP_COD_PRODUCTO             IN VARCHAR2 ,
VP_IMP_CONCEPTO             IN VARCHAR2 ,
VP_NUM_SECUENCI_PAGO        IN VARCHAR2 ,
VP_COD_TIPDOCUM_PAGO        IN VARCHAR2 ,
VP_COD_VENDEDOR_AGENTE_PAGO IN VARCHAR2 ,
VP_LETRA_PAGO               IN VARCHAR2 ,
VP_COD_CENTREMI_PAGO        IN VARCHAR2 ,
VP_OPERADORA                IN VARCHAR2 ,
VP_PLAZA                    IN VARCHAR2
) IS

iDecimal                    NUMBER(2);
g_cod_cliente               co_carteventa.cod_cliente%TYPE;
g_num_transaccion           co_carteventa.num_transaccion%TYPE;
g_num_venta                 co_carteventa.num_venta%TYPE;
g_cod_producto              co_carteventa.cod_producto%TYPE;
g_imp_concepto              co_carteventa.imp_concepto%TYPE;
g_cod_centremi_pago         co_cartera.cod_centremi%TYPE;
g_num_secuenci_pago         co_cartera.num_secuenci%TYPE;
g_cod_tipdocum_pago         co_cartera.cod_tipdocum%TYPE;
g_cod_vendedor_agente_pago  co_cartera.cod_vendedor_agente%TYPE;
g_letra_pago                co_cartera.letra%TYPE;
g_cod_operadora                         co_cartera.cod_operadora_scl%TYPE;
g_cod_plaza                                     co_cartera.cod_plaza%TYPE;
BEGIN
    g_cod_cliente              := to_number(vp_cliente);
    g_num_transaccion          := to_number(vp_num_transaccion);
    g_num_venta                := to_number(vp_num_venta);
    g_cod_producto             := to_number(vp_cod_producto);
    g_imp_concepto             := to_number(vp_imp_concepto);
    g_num_secuenci_pago        := to_number(vp_num_secuenci_pago);
    g_cod_tipdocum_pago        := to_number(vp_cod_tipdocum_pago);
    g_cod_vendedor_agente_pago := to_number(vp_cod_vendedor_agente_pago);
    g_letra_pago               := vp_letra_pago;
    g_cod_centremi_pago        := to_number(vp_cod_centremi_pago);
        g_cod_operadora                    := vp_operadora;
        g_cod_plaza                                := vp_plaza;

    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;


    INSERT INTO co_carteventa
           (NUM_TRANSACCION           ,
            NUM_VENTA                 ,
            COD_CLIENTE               ,
            COD_PRODUCTO              ,
            IMP_CONCEPTO              ,
            IND_CANCELADO             ,
            FEC_EFECTIVIDAD           )
    VALUES (g_num_transaccion         ,
            g_num_venta               ,
            g_cod_cliente             ,
            g_cod_producto            ,
            GE_PAC_GENERAL.REDONDEA(g_imp_concepto, iDecimal, 0),
            0                         ,
            SYSDATE                   );

    IF ( g_num_venta is null OR g_num_venta = 0 ) THEN
        UPDATE GA_TRANSCONTADO SET
               IND_PASOCOB = 1
        WHERE  num_transaccion = g_num_transaccion
        AND    cod_cliente     = g_cod_cliente
        AND    cod_producto    = g_cod_producto;
    ELSE
        UPDATE GA_VENTAS SET
               IND_PASOCOB = 1
        WHERE  num_venta       = g_num_venta
        AND    num_transaccion = g_num_transaccion
        AND    cod_cliente     = g_cod_cliente
        AND    cod_producto    = g_cod_producto;
    END IF;

    INSERT INTO CO_PAGOSCONC
           (COD_TIPDOCUM                 ,
            COD_CENTREMI                 ,
            NUM_SECUENCI                 ,
            COD_VENDEDOR_AGENTE          ,
            LETRA                        ,
            IMP_CONCEPTO                 ,
            COD_PRODUCTO                 ,
            NUM_TRANSACCION              ,
            NUM_ABONADO                  ,
            NUM_VENTA                    ,
                        COD_OPERADORA_SCL                        ,
                        COD_PLAZA                                        ,
            NUM_FOLIOCTC                 )
    VALUES (g_cod_tipdocum_pago         ,
            g_cod_centremi_pago         ,
            g_num_secuenci_pago         ,
            g_cod_vendedor_agente_pago  ,
            g_letra_pago                ,
            GE_PAC_GENERAL.REDONDEA(g_imp_concepto, iDecimal, 0),
            g_cod_producto              ,
            g_num_transaccion           ,
            0                           ,
            g_num_venta                 ,
                        g_cod_operadora                         ,
                        g_cod_plaza                                     ,
            '0'                         );
END CO_P_PAGO_VENTA;
/
SHOW ERRORS
