CREATE OR REPLACE PACKAGE BODY Co_Ultpago_Pg IS
--
-- FUNCION CO_CARGAPAGOS_FN
--
FUNCTION CO_CARGAPAGOS_FN ( EN_Codciclo IN NUMBER ) RETURN CHAR IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_CARGAPAGOS_FN" Lenguaje="PL/SQL" Fecha="07-06-2005" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>CHAR</Retorno>
4.  <Descripción>funcion para cargar informacion de ultimos pagos de documentos ciclo en tabla CO_ULTPAGO_TT</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Codciclo" Tipo="NUMBER">Código del ciclo a cargar</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
    LN_ultimo_pago  CO_PAGOS.num_secuenci%TYPE := 0;
    LV_imp_pago     CO_PAGOS.IMP_PAGO%TYPE;
    LV_descripcion  CO_PAGOS.DES_PAGO%TYPE;
    LN_pago         CO_PAGOS.NUM_COMPAGO%TYPE;
    LB_Ret          CHAR(1);
    LN_CONTADOR     NUMBER := 0;
    LN_inserta      NUMBER := 0;
    LV_fec_valor    VARCHAR2(14);
    LD_valor        DATE;
    LN_veces        NUMBER := 0;
    FE_Desde        DATE;        /* PGG SOPORTE CO-054 12-04-2006 */
    FE_Hasta        DATE;        /* PGG SOPORTE CO-054 12-04-2006 */
    I_Existe        NUMBER := 0; /* PGG SOPORTE CO-054 12-04-2006 */
    LN_Cod_CiclFact FA_TRAZAPROC.COD_CICLFACT%TYPE;

    CURSOR c_clientes IS
           SELECT  DISTINCT COD_CLIENTE
           FROM    FA_CICLOCLI
           WHERE   COD_CICLO    = EN_Codciclo
           AND     NUM_PROCESO  >= 0;

    CURSOR ultimo_pago ( V_cod_cliente NUMBER ) IS
           SELECT  MAX(NUM_SECUENCI) NUM_SECUENCI
           FROM    CO_PAGOS
           WHERE   COD_CLIENTE = v_cod_cliente
           AND     COD_CAUPAGO NOT IN (10 , 17 , 20)
           AND     COD_TIPDOCUM+0 IN ( SELECT COD_TIPDOCUM    /* PGG SOPORTE CO-58 17-04-2006 */
                                       FROM   FAD_CONFBALANCE   /* PGG SOPORTE CO-58 17-04-2006 */
                                       WHERE  COD_ITEM = 2 );

    CURSOR pago_anterior ( V_cod_cliente NUMBER , V_num_secuenci NUMBER  ) IS
           SELECT  MAX(NUM_SECUENCI) NUM_SECUENCI
           FROM    CO_PAGOS
           WHERE   COD_CLIENTE  = v_cod_cliente
           AND     NUM_SECUENCI < v_num_secuenci
           AND     COD_CAUPAGO NOT IN (10 , 17 , 20)
           AND     COD_TIPDOCUM+0 IN ( SELECT COD_TIPDOCUM    /* PGG SOPORTE CO-58 17-04-2006 */
                                       FROM   FAD_CONFBALANCE   /* PGG SOPORTE CO-58 17-04-2006 */
                                       WHERE  COD_ITEM = 2 );

    CURSOR valida_pago  ( V_cod_cliente NUMBER ,V_num_secuenci  NUMBER ) IS
           SELECT  COUNT(1) CONT_VALIDA
           FROM    FA_TIPDOCUMEN C , CO_PAGOSCONC B  , CO_PAGOS A
           WHERE   A.NUM_SECUENCI = B.NUM_SECUENCI
           AND     A.COD_TIPDOCUM = B.COD_TIPDOCUM
           AND     A.COD_CAUPAGO NOT IN (10 , 17 , 20)
           AND     A.COD_TIPDOCUM+0 IN ( SELECT COD_TIPDOCUM    /* PGG SOPORTE CO-58 17-04-2006 */
                                         FROM FAD_CONFBALANCE   /* PGG SOPORTE CO-58 17-04-2006 */
                                         WHERE COD_ITEM = 2 )
           AND     C.COD_TIPDOCUMMOV = B.COD_TIPDOCREL
           AND     C.IND_CICLO       = 1
           AND     A.COD_CLIENTE     = V_cod_cliente
           AND     A.NUM_SECUENCI    = V_num_secuenci;

    CURSOR c_pagos  ( V_cod_cliente NUMBER ,V_num_secuenci  NUMBER, V_FEC_DESDE DATE, V_FEC_HASTA DATE ) IS
           SELECT FEC_VALOR, IMP_PAGO, DES_PAGO, COD_ORIPAGO,
                  NUM_COMPAGO, COD_BANCO, COD_CAUPAGO, COD_TIPDOCUM
           FROM   CO_PAGOS
           WHERE  NUM_SECUENCI = V_num_secuenci
           AND    COD_CLIENTE  = V_cod_cliente
           AND    cod_caupago NOT IN (10 , 17 , 20)
           AND    FEC_EFECTIVIDAD >  V_FEC_DESDE               /* PGG SOPORTE CO-054 12-04-2006 */
           AND    FEC_EFECTIVIDAD <= V_FEC_HASTA               /* PGG SOPORTE CO-054 12-04-2006 */
           AND    COD_TIPDOCUM+0 IN ( SELECT COD_TIPDOCUM    /* PGG SOPORTE CO-58 17-04-2006 */
                                      FROM   FAD_CONFBALANCE   /* PGG SOPORTE CO-58 17-04-2006 */
                                      WHERE  COD_ITEM = 2 );

BEGIN
    /* PGG SOPORTE CO-054 12-04-2006 */
    SELECT FEC_INICIO, COD_CICLFACT
    INTO FE_Hasta, LN_Cod_CiclFact
    FROM FA_TRAZAPROC
    WHERE COD_PROCESO = 3000
    AND COD_CICLFACT = (SELECT COD_CICLFACT
                        FROM FA_CICLFACT
                        WHERE COD_CICLO = EN_CODCICLO
                        AND IND_FACTURACION = 1);

    FOR reg_cliente IN c_clientes LOOP
        BEGIN
            LN_CONTADOR:= LN_CONTADOR + 1 ;
            LN_veces := 0;

            /* PGG SOPORTE CO-054 12-04-2006 */
            IF (I_Existe = 0) THEN
                SELECT  T.FEC_INICIO
                INTO FE_Desde
                FROM FA_HISTDOCU A, FA_TRAZAPROC T
                WHERE A.COD_CICLFACT = T.COD_CICLFACT
                  AND T.COD_PROCESO = 3000
                  AND A.COD_CLIENTE = REG_CLIENTE.COD_CLIENTE
                  AND A.COD_TIPDOCUM IN (69, 2, 70)
                  AND A.FEC_EMISION = ( SELECT MAX(C.FEC_EMISION)
                                        FROM FA_HISTDOCU C
                                        WHERE C.COD_TIPDOCUM IN (69, 2, 70)
                                          AND C.COD_CLIENTE = A.COD_CLIENTE);
                I_Existe := 1;
             END IF;

             FOR reg_ultpa IN ultimo_pago ( REG_CLIENTE.COD_CLIENTE ) LOOP
                 LN_ultimo_pago := reg_ultpa.num_secuenci;
             END LOOP;

            <<valida_p>>
            BEGIN
                FOR reg_valida IN valida_pago( REG_CLIENTE.COD_CLIENTE ,LN_ultimo_pago ) LOOP
                    IF (reg_valida.cont_valida > 0) THEN
                        BEGIN
                            FOR reg_ok IN c_pagos ( REG_CLIENTE.COD_CLIENTE ,LN_ultimo_pago, FE_Desde, FE_Hasta) LOOP
                                BEGIN
                                    IF reg_ok.cod_oripago = 1 THEN
                                        BEGIN
                                            SELECT --+ full (OFI) cache (OFI)
                                                ofi.des_oficina
                                            INTO LV_descripcion
                                            FROM CO_HISTMOVCAJA hi,
                                                 GE_OFICINAS ofi
                                            WHERE hi.num_compago       = reg_ok.num_compago
                                              AND hi.fec_efectividad   = reg_ok.fec_valor
                                              AND hi.cod_oficina || '' = ofi.cod_oficina    /* Soporte RyC CPF 23-08-2006 CO-200608020279 */
                                              AND hi.tip_movcaja+0     = 6                  /* Soporte RyC DVG 01-08-2006 CO-200607280279 */
                                              AND ROWNUM               < 2;
                                        EXCEPTION
                                            WHEN NO_DATA_FOUND THEN
                                                LV_descripcion := reg_ok.des_pago;
                                        END;
                                    ELSIF reg_ok.cod_oripago = 3 THEN
                                        BEGIN
                                            SELECT  ge.des_banco
                                            INTO    LV_descripcion
                                            FROM    ge_bancos ge
                                            WHERE   ge.cod_banco = reg_ok.cod_banco;
                                        EXCEPTION
                                            WHEN NO_DATA_FOUND THEN
                                                LV_descripcion := reg_ok.des_pago;
                                        END;
                                    ELSE
                                        LV_descripcion := reg_ok.des_pago;
                                    END IF;

                                    INSERT INTO CO_ULTPAGO_TT(
                                        COD_CLIENTE,
                                        MONTO,
                                        FECHA,
                                        DESCRIPCION,
                                        TIP_PAGO,
                                        COD_CICLFACT)
                                    VALUES(
                                        reg_cliente.cod_cliente,
                                        reg_ok.imp_pago,
                                        reg_ok.fec_valor,
                                        LV_descripcion,
                                        1,
                                        LN_Cod_CiclFact);

                                    LN_inserta:=LN_inserta+1;
                                EXCEPTION
                                    WHEN NO_DATA_FOUND THEN
                                        NULL;
                                END;
                            END LOOP; /* FIN C_PAGOS */
                        END;
                    ELSE
                        LN_veces := LN_veces + 1;
                        LV_imp_pago     := 0;
                        LV_fec_valor    := NULL;
                        LV_descripcion := NULL;

                        IF (LN_veces < 5) AND (LN_ultimo_pago > 0 ) THEN
                            FOR reg_pago IN pago_anterior ( reg_cliente.cod_cliente , LN_ultimo_pago ) LOOP
                                LN_ultimo_pago := reg_pago.num_secuenci;
                                        GOTO valida_p;
                                    END LOOP;
                        END IF;
                    END IF;   /* FIN VALIDO_PAGO */
                END LOOP;
            END; -- <<valida_p>>
            IF MOD(LN_CONTADOR,1000)= 0 THEN
                COMMIT;
                LN_inserta:=0;
                NULL;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
        END;
    END LOOP; /* FIN CLIENTES */
    COMMIT;
END CO_CARGAPAGOS_FN;
------------------------------------------------------------------------------------------------------------------------
--
-- FUNCION CO_ULTPAGO_FN
--
FUNCTION CO_ULTPAGO_FN ( EN_Cod_Cliente IN NUMBER )
RETURN VARCHAR2
IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_ULTPAGO_FN" Lenguaje="PL/SQL" Fecha="07-06-2005" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>VARCHAR2</Retorno>
4.  <Descripción>funcion para consultar el ultimo documento ciclo pagado de un cliente</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Cod_Cliente" Tipo="NUMBER">Código del cliente a consultar</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LV_fec_valor    CO_PAGOS.FEC_VALOR%TYPE;
    LV_imp_pago     CO_PAGOS.IMP_PAGO%TYPE;
    LV_Retorno      VARCHAR2(250);
    LV_descripcion  VARCHAR2(40);

    BEGIN
        SELECT P.FECHA,
               P.MONTO,
               P.DESCRIPCION
          INTO LV_fec_valor,
               LV_imp_pago,
               LV_descripcion
        FROM CO_ULTPAGO_TT P
        WHERE P.COD_CLIENTE = EN_Cod_Cliente;

        LV_Retorno:=LV_fec_valor||';'||LV_imp_pago||';'||LV_descripcion||';';

        RETURN LV_Retorno;

    EXCEPTION
        WHEN OTHERS THEN
            LV_Retorno := TO_CHAR(SQLCODE)|| ';ERROR CO_ULTPAGO_FN :' || '; ' || SQLERRM;
            RETURN LV_Retorno;
END CO_ULTPAGO_FN;
------------------------------------------------------------------------------------------------------------------------
--
-- FUNCION CO_CARGATOTALPAGOS_FN
--
FUNCTION CO_CARGATOTALPAGOS_FN (EN_Cicfactu       IN NUMBER
                               ,EN_ExisteRango    IN NUMBER
                               ,EN_ClienteInicial IN NUMBER
                               ,EN_ClienteFinal   IN NUMBER
) RETURN VARCHAR2
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_CARGATOTALPAGOS_FN" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="****" Programador="****" Ambiente="BD">
2.1 <Elemento Nombre = "CO_CARGATOTALPAGOS_FN" Lenguaje="PL/SQL" Fecha="31-03-2006" Versión="1.0.1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>CHAR</Retorno>
4.  <Descripción>funcion para cargar informacion de los pagos de documentos ciclo dentro de un determinado periodo en tabla CO_ULTPAGO_TT</Descripción>
5.  <Parámetros>
6.  <Entrada>
8.  <param nom="EN_Cicfactu"       Tipo="NUMBER">Ciclo de facturacion</param>
9.  <param nom="EN_ExisteRango"    Tipo="NUMBER">Indicador de Rango 0:sin Rango 1: con rango</param>
10. <param nom="EN_ClienteInicial" Tipo="NUMBER">Cliente Inicial (sólo si EN_ExisteRango=1)</param>
11. <param nom="EN_ClienteFinal"   Tipo="NUMBER">Cliente Final (sólo si EN_ExisteRango=1)</param>
12. <param nom="EN_CodItem"        Tipo="NUMBER">Codigo de item de balance (1= pagos; 4=pagos reverti)</param>
13. </Entrada>
14. </Parámetros>
15. </Elemento>
16. </Documentación>
*/
IS
    TD_fecinicio    FA_CICLFACT.FEC_DESDEOCARGOS%TYPE;
    TD_fectermino   FA_CICLFACT.FEC_DESDECFIJOS%TYPE;
    TN_modpago      CO_ULTPAGO_TT.COD_MODPAGO%TYPE;
    LV_descripcion  CO_PAGOS.DES_PAGO%TYPE;
    LN_CodCiclo     FA_CICLFACT.COD_CICLO%TYPE;
    LN_zero         NUMBER := 0;
    LN_uno          NUMBER := 1;
    LN_resultado    NUMBER := 0;
    LN_CodItem      NUMBER := 0;
        i               NUMBER;
        j               NUMBER;

    FE_Desde   DATE;        /* PGG SOPORTE CO-054 12-04-2006 */
    FE_Hasta   DATE;        /* PGG SOPORTE CO-054 12-04-2006 */
    I_Existe   NUMBER := 0; /* PGG SOPORTE CO-054 12-04-2006 */
    FE_Partida DATE;        /* PGG SOPORTE CO-054 13-04-2006 */

    CURSOR c_universoclientes IS
           SELECT DISTINCT COD_CLIENTE
           FROM   FA_CICLOCLI
           WHERE  COD_CICLO    = LN_CodCiclo
           AND    NUM_PROCESO >= LN_zero
           AND    IND_MASCARA  = LN_uno
           AND    ((COD_CLIENTE BETWEEN EN_ClienteInicial AND EN_ClienteFinal) OR (1 <> EN_ExisteRango));

    CURSOR c_pagos  ( V_codcliente NUMBER, V_fectermino DATE, V_codciclfactbal NUMBER) IS
               SELECT PAG.IMP_PAGO, PAG.FEC_VALOR, PAG.DES_PAGO, PAG.COD_TIPDOCUM, PAG.COD_ORIPAGO,
                          PAG.NUM_COMPAGO, PAG.COD_BANCO, PAG.COD_CAUPAGO
                   FROM   FAD_CONFBALANCE BAL,
                          CO_PAGOS PAG
                   WHERE  BAL.COD_ITEM        >= 0
                   AND    BAL.COD_TIPDOCUM     = PAG.COD_TIPDOCUM
                   AND    BAL.COD_ORIGEN       = 'PAGOS'
                   AND    PAG.COD_CLIENTE      = V_codcliente
                   AND    PAG.FEC_EFECTIVIDAD <= V_fectermino
                   AND    PAG.COD_CICLFACT_BAL IS NULL;

BEGIN

    SELECT COD_CICLO, FEC_DESDELLAM, FEC_HASTALLAM
    INTO   LN_CodCiclo, TD_fecinicio, TD_fectermino
    FROM   FA_CICLFACT
    WHERE  COD_CICLFACT = EN_Cicfactu;

    FOR reg_cliente IN c_universoclientes LOOP
        BEGIN
            FOR reg_pagos IN c_pagos ( REG_CLIENTE.COD_CLIENTE, TD_fectermino, EN_Cicfactu ) LOOP
                BEGIN
                    IF reg_pagos.cod_oripago = 1 THEN
                        BEGIN
                            SELECT --+ full (OFI) cache (OFI)
                                   ofi.des_oficina,
                                   hi.tip_valor
                            INTO   LV_descripcion,
                                   TN_modpago
                            FROM   CO_HISTMOVCAJA hi,
                                   GE_OFICINAS ofi
                            WHERE  hi.num_compago      = reg_pagos.num_compago
                              AND  hi.fec_efectividad  = reg_pagos.fec_valor
                              AND  hi.cod_oficina|| '' = ofi.cod_oficina    /* Soporte RyC CPF 23-08-2006 CO-200608020279 */
                              AND  hi.tip_movcaja+0    = 6                  /* Soporte RyC DVG 01-08-2006 CO-200607280279 */
                              AND  ROWNUM              < 2;
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                LV_descripcion := reg_pagos.des_pago;
                                        TN_modpago := CO_VALIDAMODPAGO_FN ( REG_CLIENTE.COD_CLIENTE, reg_pagos.num_compago );
                        END;
                    ELSIF reg_pagos.cod_oripago = 3 THEN
                        BEGIN
                            SELECT ge.des_banco
                            INTO   LV_descripcion
                            FROM   ge_bancos ge
                            WHERE  ge.cod_banco = reg_pagos.cod_banco;

                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                LV_descripcion := reg_pagos.des_pago;
                        END;

                        TN_modpago := CO_VALIDAMODPAGO_FN ( REG_CLIENTE.COD_CLIENTE, reg_pagos.num_compago );

                    ELSE
                        LV_descripcion := reg_pagos.des_pago;
                        TN_modpago := CO_VALIDAMODPAGO_FN ( REG_CLIENTE.COD_CLIENTE, reg_pagos.num_compago );
                    END IF; /* END IF reg_pagos.cod_oripago */

                    INSERT INTO CO_ULTPAGO_TT(
                        COD_CLIENTE,
                        MONTO,
                        FECHA,
                        DESCRIPCION,
                        COD_MODPAGO,
                        TIP_PAGO,
                        COD_TIPDOCUM,
                        COD_CICLFACT)
                    VALUES(
                        REG_CLIENTE.cod_cliente,
                        reg_pagos.imp_pago,
                        reg_pagos.fec_valor,
                        LV_descripcion,
                        TN_modpago,
                        3,
                        reg_pagos.cod_tipdocum, /* PGG SOPORTE CO-200603310028 */
                        EN_Cicfactu);
                EXCEPTION
                  WHEN OTHERS THEN
                    RETURN 'ERROR :' || TO_CHAR(SQLCODE) || ':' || SQLERRM;
                END;
            END LOOP;  /* FIN cursor det_pagos */
        END;
    END LOOP; /* FIN cursor c_clientes */
    COMMIT;
    RETURN 'OK';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'ERROR :' || TO_CHAR(SQLCODE) || ':' || SQLERRM;
END CO_CARGATOTALPAGOS_FN;
------------------------------------------------------------------------------------------------------------------------
--
-- FUNCION CO_VALIDAPAGO_FN
--
FUNCTION CO_VALIDAPAGO_FN (EN_codcliente  NUMBER
                          ,EN_numsecuenci NUMBER
                          ,EN_tipodocumen NUMBER
                          ,EN_codvendedor VARCHAR2
                          ,EN_codletra    VARCHAR2
                          ,EN_codcentremi NUMBER ) RETURN NUMBER
IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_VALIDAPAGO_FN" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>funcion para validar consistencia de un determinado pago</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_codcliente"  Tipo="NUMBER"> Código del cliente a consultar</param>
8.  <param nom="EN_numsecuenci" Tipo="NUMBER"> Numero de secuencia</param>
9.  <param nom="EN_tipodocumen" Tipo="NUMBER"> Tipo de documento</param>
10. <param nom="EN_codvendedor" Tipo="VARCHAR">Código Vendedor Agente</param>
11. <param nom="EN_codletra"    Tipo="VARCHAR">Codigo letra</param>
12  <param nom="EN_codcentremi" Tipo="NUMBER">Código centremi</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
    LV_contvalida       NUMBER;
    LN_uno          NUMBER := 1;

BEGIN
    SELECT  COUNT(1)
    INTO    LV_contvalida
    FROM    fa_tipdocumen c , co_pagosconc b  , CO_PAGOS a
    WHERE a.num_secuenci        = b.num_secuenci
      AND a.cod_tipdocum        = b.cod_tipdocum
      AND a.cod_tipdocum+0 IN (SELECT DISTINCT cod_tipdocum    /* PGG SOPORTE CO-59 21-04-2006 */
                               FROM FAD_CONFBALANCE            /* PGG SOPORTE CO-59 21-04-2006 */
                               WHERE cod_item = 2)             /* PGG SOPORTE CO-59 21-04-2006 */
      AND c.cod_tipdocummov     = b.cod_tipdocrel
      AND a.cod_cliente         = EN_codcliente
      AND a.num_secuenci        = EN_numsecuenci
      AND a.cod_tipdocum        = EN_tipodocumen
      AND a.cod_vendedor_agente = EN_codvendedor
      AND a.letra               = EN_codletra
      AND a.cod_centremi        = EN_codcentremi;

    RETURN LV_contvalida;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           RETURN 0;
END CO_VALIDAPAGO_FN;
------------------------------------------------------------------------------------------------------------------------
--
-- FUNCION CO_VALIDAMODPAGO_FN
--
FUNCTION CO_VALIDAMODPAGO_FN ( EN_codcliente  NUMBER, EN_numpago NUMBER )
RETURN NUMBER
IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_VALIDAMODPAGO_FN" Lenguaje="PL/SQL" Fecha="17-06-2005" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Obtiene la modalidad de pago de un comprobante de pago </Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_codcliente"  Tipo="NUMBER"> Código del cliente a consultar</param>
8.  <param nom="EN_numpago"     Tipo="NUMBER"> Numero de pago</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
    LV_tipvalor         NUMBER := 0;
    LN_uno          NUMBER := 1;

BEGIN
    SELECT tip_valor
    INTO   LV_tipvalor
    FROM   co_histmovcaja
    WHERE  num_compago = EN_numpago
      AND  cod_cliente = EN_codcliente
      AND  ROWNUM      = LN_uno;

    RETURN LV_tipvalor;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        LV_tipvalor := 0;
            RETURN LV_tipvalor;
END CO_VALIDAMODPAGO_FN;
-----------------------------------------------------------------------------------------------------------------------
--
-- FUNCION CO_CARGAAJUSTES_FN
--
FUNCTION CO_CARGAJUSTES_FN (EN_Cicfactu       IN NUMBER
                           ,EN_ExisteRango    IN NUMBER
                           ,EN_ClienteInicial IN NUMBER
                           ,EN_ClienteFinal   IN NUMBER
) RETURN VARCHAR2
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "CO_CARGATOTALPAGOS_FN" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>CHAR</Retorno>
4.  <Descripción>funcion para cargar informacion de los pagos de documentos ciclo dentro de un determinado periodo en tabla CO_ULTPAGO_TT</Descripción>
5.  <Parámetros>
6.  <Entrada>
8.  <param nom="EN_Cicfactu"       Tipo="NUMBER">Ciclo de facturacion</param>
9.  <param nom="EN_ExisteRango"    Tipo="NUMBER">Indicador de Rango 0:sin Rango 1: con rango</param>
10. <param nom="EN_ClienteInicial" Tipo="NUMBER">Cliente Inicial (sólo si EN_ExisteRango=1)</param>
11. <param nom="EN_ClienteFinal"   Tipo="NUMBER">Cliente Final (sólo si EN_ExisteRango=1)</param>
12. </Entrada>
13. </Parámetros>
14. </Elemento>
15. </Documentación>
*/
IS
    TD_fecinicio    FA_CICLFACT.FEC_DESDEOCARGOS%TYPE;
    TD_fectermino   FA_CICLFACT.FEC_DESDECFIJOS%TYPE;
    TN_modpago      CO_ULTPAGO_TT.COD_MODPAGO%TYPE;
    LV_descripcion  CO_PAGOS.DES_PAGO%TYPE;
    LN_CodCiclo     FA_CICLFACT.COD_CICLO%TYPE;
    LN_zero         NUMBER := 0;
    LN_uno          NUMBER := 1;
    LN_resultado    NUMBER := 0;

    CURSOR c_universoclientes ( V_fec_fin DATE ) IS
           SELECT DISTINCT F.COD_CLIENTE
           FROM   FA_CICLOCLI F
                   WHERE  EXISTS ( SELECT 1
                                               FROM  CO_AJUSTES
                                       WHERE COD_CLIENTE = F.COD_CLIENTE
                                               AND   FEC_PROCESO <= V_fec_fin )
           AND    F.COD_CICLO    = LN_CodCiclo
           AND    F.NUM_PROCESO >= LN_zero
           AND    F.IND_MASCARA  = LN_uno
           AND    ((F.COD_CLIENTE BETWEEN EN_ClienteInicial AND EN_ClienteFinal) OR (1 <> EN_ExisteRango));

    CURSOR c_Ajustes ( V_codcliente NUMBER, V_fectermino DATE, V_codciclfactbal NUMBER) IS
        SELECT AJU.IMPORTE_DEBE, AJU.FEC_EFECTIVIDAD, DOC.DES_TIPDOCUM, AJU.COD_TIPDOCUM
          FROM FAD_CONFBALANCE BAL, CO_AJUSTES AJU, GE_TIPDOCUMEN DOC
         WHERE BAL.COD_ITEM        >= 0
                   AND BAL.COD_TIPDOCUM     = AJU.COD_TIPDOCUM
                   AND BAL.COD_ORIGEN       = 'AJUST'
                   AND AJU.COD_CLIENTE      = V_codcliente
                   AND AJU.FEC_EFECTIVIDAD <= V_fectermino
                   AND AJU.COD_TIPDOCUM+0   = DOC.COD_TIPDOCUM
                   AND AJU.COD_CICLFACT_BAL IS NULL;

BEGIN
    SELECT COD_CICLO, FEC_DESDELLAM, FEC_HASTALLAM
    INTO   LN_CodCiclo, TD_fecinicio , TD_fectermino
    FROM   FA_CICLFACT
    WHERE  COD_CICLFACT = EN_Cicfactu;

    FOR reg_cliente IN c_universoclientes ( TD_fectermino ) LOOP  /* mgg Requerimiento #40247 06-05-2007 */
        BEGIN
            FOR reg_Ajustes IN c_Ajustes ( REG_CLIENTE.COD_CLIENTE, TD_fectermino, EN_Cicfactu ) LOOP
                BEGIN
                    INSERT INTO CO_ULTPAGO_TT(
                        COD_CLIENTE  ,
                        MONTO        ,
                        FECHA        ,
                        DESCRIPCION  ,
                        COD_MODPAGO  ,
                        TIP_PAGO     ,
                        COD_OPERADORA,
                        COD_TIPDOCUM ,
                        PREF_PLAZA   ,
                        NUM_FOLIO    ,
                        COD_CICLFACT)
                    VALUES(
                        reg_cliente.cod_cliente      ,
                        reg_Ajustes.importe_debe     ,
                        reg_Ajustes.fec_efectividad  ,
                        reg_Ajustes.des_tipdocum     ,
                        0                            ,
                        2                            ,
                        NULL                         ,
                        reg_Ajustes.cod_tipdocum     ,
                        NULL                         ,
                        0                            ,
                        EN_Cicfactu);

                EXCEPTION
                    WHEN OTHERS THEN
                        RETURN 'ERROR :' || TO_CHAR(SQLCODE) || ':' || SQLERRM;
                END;
            END LOOP; /* FIN LOOP c_Ajustes */
        END;
    END LOOP; /* FIN LOOP c_universoclientes */
    COMMIT;

    UPDATE CO_ULTPAGO_TT
           SET    TIP_PAGO = 4
    WHERE  COD_CLIENTE >=0
    AND    COD_TIPDOCUM IN ( SELECT COD_TIPDOCUM
                                         FROM FAD_CONFBALANCE
                                                 WHERE COD_ITEM      = 3);
    COMMIT;

    RETURN 'OK';

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           RETURN 'ERROR :' || TO_CHAR(SQLCODE) || ':' || SQLERRM;
END CO_CARGAJUSTES_FN;

END Co_Ultpago_Pg;
/
SHOW ERRORS
