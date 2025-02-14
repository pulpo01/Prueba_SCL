CREATE OR REPLACE PROCEDURE P_ALTA_CICLOCLI
                         (VP_PRODUCTO IN NUMBER,
                          VP_CLIENTE IN NUMBER,
                          VP_ABONADO IN NUMBER,
                          VP_CICLO IN NUMBER,
                          VP_INDACREC IN CHAR,
                          VP_AGENTE IN NUMBER,
                          VP_CREDMOR IN CHAR,
                          VP_USUARIO IN NUMBER,
                          VP_FECALTA IN DATE,
                          VP_PROC IN OUT VARCHAR2,
                          VP_TABLA IN OUT VARCHAR2,
                          VP_ACT IN OUT VARCHAR2,
                          VP_SQLCODE IN OUT VARCHAR2,
                          VP_SQLERRM IN OUT VARCHAR2,
                          VP_ERROR IN OUT VARCHAR2)
IS
--
-- Procedimiento que realiza el alta de abonados de producto en la tabla
-- base de abonados a facturar en ciclo
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_CLIENTE      FA_CICLOCLI.COD_CLIENTE%TYPE;
   V_CICLO        FA_CICLOCLI.COD_CICLO%TYPE;
   V_CALCLIEN     FA_CICLOCLI.COD_CALCLIEN%TYPE;
   V_DEBITO       FA_CICLOCLI.IND_DEBITO%TYPE;
   -- 'inicio Incidencia 36770 [Soporte GSA 18/01/2007]
   -- V_NOMUSU       FA_CICLOCLI.NOM_USUARIO%TYPE;
   V_NOMUSU       GA_USUARIOS.NOM_USUARIO%TYPE;
   -- 'Fin Incidencia 36770 [Soporte GSA 18/01/2007]
   V_APEUSU1      FA_CICLOCLI.NOM_APELLIDO1%TYPE;
   V_APEUSU2      FA_CICLOCLI.NOM_APELLIDO2%TYPE;
   VP_TERMINAL    FA_CICLOCLI.NUM_TERMINAL%TYPE;
   V_NUMHORAS     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   V_TIPCOMIS     GA_VENTAS.COD_TIPCOMIS%TYPE;
   V_CLIENTE_AG   VE_VENDEDORES.COD_CLIENTE%TYPE;
   V_INDCOBRO     GA_CAUSAREC.IND_COBRO%TYPE;
   TMP_COD_CLIENTE FA_CICLOCLI.COD_CLIENTE%TYPE;--iNICIO XO-200510100843
   V_FECAUX       NUMBER;
   V_FECBAJA      DATE;
   V_FECALTABOCEL DATE;
   V_CLIENTE_INTERNO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
    VP_PROC := 'P_ALTA_CICLOCLI';
    VP_TABLA := 'GA_USUARIOS';
    VP_ACT := 'S';

        SELECT NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2
    INTO V_NOMUSU,V_APEUSU1,V_APEUSU2
    FROM GA_USUARIOS
    WHERE  COD_USUARIO = VP_USUARIO;

    -- 'inicio Incidencia 36770 [Soporte GSA 18/01/2007]
    V_NOMUSU := substr(V_NOMUSU,1,20);
    -- 'Fin Incidencia 36770 [Soporte GSA 18/01/2007]
    VP_TABLA := 'GE_CLIENTES';

    SELECT COD_CALCLIEN,DECODE(IND_DEBITO,'A',1,'M',0)
    INTO V_CALCLIEN,V_DEBITO
    FROM GE_CLIENTES
    WHERE  COD_CLIENTE = VP_CLIENTE;

    VP_TABLA := 'GA_ABOXXX';
    VP_ACT := 'S';

        IF VP_PRODUCTO='1' THEN
       BEGIN
          SELECT NUM_CELULAR
               INTO VP_TERMINAL
              FROM GA_ABOCEL
          WHERE COD_CLIENTE = VP_CLIENTE
          AND NUM_ABONADO = VP_ABONADO;

         EXCEPTION
         WHEN NO_DATA_FOUND THEN
         NULL;
       END;
    ELSE
       IF VP_PRODUCTO='2' THEN
          BEGIN
             SELECT NUM_BEEPER INTO VP_TERMINAL FROM GA_ABOBEEP
             WHERE  COD_CLIENTE = VP_CLIENTE
                    AND NUM_ABONADO = VP_ABONADO;
             EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         NULL;
           END;
       END IF;
    END IF;


   IF VP_INDACREC = 'R' THEN

          VP_ACT := 'S';
      VP_TABLA := 'GED_PARAMETROS:NUM_HORAS';
      VP_ACT := 'S';

          SELECT VAL_PARAMETRO/24 INTO V_NUMHORAS FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'NUM_HORAS'
      AND COD_PRODUCTO = 1
      AND COD_MODULO = 'GA';
      VP_TABLA := 'GA_CAUSAREC';

          SELECT  IND_COBRO
      INTO V_INDCOBRO
      FROM GA_CAUSAREC
      WHERE COD_CAUSAREC =(SELECT COD_CAUSAREC
                                   FROM GA_ABOCEL A, GA_VENTAS B
                                   WHERE A.NUM_VENTA=B.NUM_VENTA
                                   AND A.NUM_ABONADO=VP_ABONADO);


          SELECT VAL_PARAMETRO
      INTO V_CLIENTE_INTERNO
      FROM GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'COD_CLIENTEINTERNO'
      AND COD_PRODUCTO = 1
      AND COD_MODULO = 'GA';

          VP_TABLA := 'GA_ABOCEL';
      VP_ACT := 'S';

          SELECT B.COD_TIPCOMIS,B.FEC_RECDOCUM
      INTO V_TIPCOMIS,V_FECALTABOCEL
      FROM  GA_VENTAS B, GA_ABOCEL A
      WHERE  A.NUM_ABONADO=VP_ABONADO
          AND A.NUM_VENTA = B.NUM_VENTA;

          V_CLIENTE:=VP_CLIENTE;

          IF V_INDCOBRO=1 THEN   -- INDICADOR DE COBRO VERDADERO =1
        V_FECBAJA := VP_FECALTA;
        V_FECAUX := V_FECBAJA - V_FECALTABOCEL;

            IF (V_FECAUX > V_NUMHORAS) THEN   -- CONDICION HORARIA DE RECHAZO  > 48 HRS.
                BEGIN
                -- SE DEBEN GENERAR REGISTROS; CLIENTE INTERNO
                        -- CLIENTE INTERNO
                        V_CLIENTE:=V_CLIENTE_INTERNO;
                        VP_TABLA := 'GE_CLIENTES';
                        VP_ACT := 'S';
                        SELECT COD_CICLO
                        INTO V_CICLO
                            FROM GE_CLIENTES
                        WHERE  COD_CLIENTE = V_CLIENTE;
                       V_FECALTABOCEL := V_FECBAJA + (1/(24*60*60));

                        -- 'inicio XO-200510100843 [W.astudillo 18/10/2005]
                    BEGIN
                                         SELECT  COD_CLIENTE INTO TMP_COD_CLIENTE
                                     FROM FA_CICLOCLI
                                         WHERE NUM_ABONADO = VP_ABONADO AND
                                               COD_CLIENTE = V_CLIENTE AND
                                                   COD_CICLO = V_CICLO AND
                                                   COD_PRODUCTO = VP_PRODUCTO;
                             EXCEPTION
                                 WHEN NO_DATA_FOUND THEN

                              INSERT INTO FA_CICLOCLI (COD_CLIENTE,COD_CICLO,COD_PRODUCTO,NUM_ABONADO,COD_CALCLIEN,IND_DEBITO,
                       COD_CREDMOR,NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2,IND_CAMBIO, FEC_ALTA,NUM_TERMINAL)
                               VALUES (V_CLIENTE,V_CICLO,VP_PRODUCTO,VP_ABONADO,V_CALCLIEN,V_DEBITO,VP_CREDMOR,
                             V_NOMUSU,V_APEUSU1,V_APEUSU2,0, V_FECALTABOCEL,VP_TERMINAL);

                                     WHEN  OTHERS THEN
                                           VP_SQLCODE := SQLCODE;
                                           VP_SQLERRM := SQLERRM;
                                               VP_ERROR:='4';


                   END;
                   --FIN 'XO-200510100843 [W.astudillo 18/10/2005]
                EXCEPTION
                WHEN  OTHERS THEN
                VP_SQLCODE := SQLCODE;
                VP_SQLERRM := SQLERRM;
                        VP_ERROR:='4';
                END;
        ELSE    --CONDICION HORARIA < 48. HRS
                BEGIN
                -- SE DEBEN GENERA UN REGISTRO; CLIENTE DEL VENDEDOR
            VP_TABLA := 'VE_VENDEDORES';
                VP_ACT := 'S';

                        SELECT COD_CLIENTE
                        INTO V_CLIENTE_AG
                        FROM VE_VENDEDORES
                WHERE  COD_VENDEDOR = VP_AGENTE;

                        V_CLIENTE:=V_CLIENTE_AG;
                VP_TABLA := 'GE_CLIENTES';
                VP_ACT := 'S';

                        SELECT COD_CICLO
                        INTO V_CICLO
                        FROM GE_CLIENTES
                WHERE  COD_CLIENTE = V_CLIENTE;

                        --'inicio XO-200510100843 [W.astudillo 18/10/2005]
                        BEGIN
                                 SELECT  COD_CLIENTE INTO TMP_COD_CLIENTE
                             FROM FA_CICLOCLI
                                 WHERE NUM_ABONADO = VP_ABONADO AND
                                   COD_CLIENTE = V_CLIENTE AND
                                           COD_CICLO = V_CICLO AND
                                           COD_PRODUCTO = VP_PRODUCTO;

                                 EXCEPTION
                             WHEN NO_DATA_FOUND THEN

                                      INSERT INTO FA_CICLOCLI (COD_CLIENTE,COD_CICLO,COD_PRODUCTO,NUM_ABONADO,COD_CALCLIEN,IND_DEBITO,
                        COD_CREDMOR,NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2,IND_CAMBIO, FEC_ALTA,NUM_TERMINAL)
                        VALUES (V_CLIENTE,V_CICLO,VP_PRODUCTO,VP_ABONADO,V_CALCLIEN,V_DEBITO,VP_CREDMOR,V_NOMUSU,V_APEUSU1,
                        V_APEUSU2,0, VP_FECALTA,VP_TERMINAL);
                                     WHEN  OTHERS THEN
                                           VP_SQLCODE := SQLCODE;
                                           VP_SQLERRM := SQLERRM;
                                               VP_ERROR:='4';

                    END;
                    --FIN 'XO-200510100843 [W.astudillo 18/10/2005]
                EXCEPTION
                        WHEN OTHERS THEN
                                VP_SQLCODE := SQLCODE;
                                VP_SQLERRM := SQLERRM;
                                VP_ERROR:='4';
                END;
        END IF;
      ELSE   -- INDICADOR DE COBRO FALSE =0
        BEGIN

        -- SE DEBEN GENERA UN REGISTRO; CLIENTE INTERNO
                V_CLIENTE:=V_CLIENTE_INTERNO;
        VP_TABLA := 'GE_CLIENTES';
        VP_ACT := 'S';

        SELECT COD_CICLO
                INTO V_CICLO
                FROM GE_CLIENTES
        WHERE  COD_CLIENTE = V_CLIENTE;

                        --'inicio XO-200510100843 [W.astudillo 18/10/2005]
            BEGIN
                         SELECT  COD_CLIENTE INTO TMP_COD_CLIENTE
                     FROM FA_CICLOCLI
                         WHERE NUM_ABONADO = VP_ABONADO AND
                               COD_CLIENTE = V_CLIENTE AND
                                   COD_CICLO = V_CICLO AND
                                   COD_PRODUCTO = VP_PRODUCTO;

                 EXCEPTION
                     WHEN NO_DATA_FOUND THEN

                        INSERT INTO FA_CICLOCLI (COD_CLIENTE,COD_CICLO,COD_PRODUCTO,NUM_ABONADO,COD_CALCLIEN,IND_DEBITO,
                        COD_CREDMOR,NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2,IND_CAMBIO, FEC_ALTA,NUM_TERMINAL)
                        VALUES (V_CLIENTE,V_CICLO,VP_PRODUCTO,VP_ABONADO,V_CALCLIEN,V_DEBITO,VP_CREDMOR,V_NOMUSU,V_APEUSU1,
                        V_APEUSU2,0, VP_FECALTA,VP_TERMINAL);
                         WHEN  OTHERS THEN
                           VP_SQLCODE := SQLCODE;
                       VP_SQLERRM := SQLERRM;
                                   VP_ERROR:='4';
                END;
                --FIN  -XO-200510100843 [W.astudillo 18/10/2005]

        EXCEPTION
                WHEN OTHERS THEN
                        VP_SQLCODE := SQLCODE;
                        VP_SQLERRM := SQLERRM;
                        VP_ERROR:='4';
        END;
      END IF;
   ELSE -- aceptacion
        BEGIN

                V_CLIENTE := VP_CLIENTE;
                V_CICLO := VP_CICLO;

                --'inicio XO-200510100843 [W.astudillo 18/10/2005]INICIO XO-200510100843
            BEGIN
                         SELECT  COD_CLIENTE INTO TMP_COD_CLIENTE
                     FROM FA_CICLOCLI
                         WHERE NUM_ABONADO = VP_ABONADO AND
                               COD_CLIENTE = V_CLIENTE AND
                                   COD_CICLO = V_CICLO AND
                                   COD_PRODUCTO = VP_PRODUCTO;

                 EXCEPTION
                     WHEN NO_DATA_FOUND THEN

                        INSERT INTO FA_CICLOCLI (COD_CLIENTE,COD_CICLO,COD_PRODUCTO,NUM_ABONADO,COD_CALCLIEN,IND_DEBITO,
                        COD_CREDMOR,NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2,IND_CAMBIO, FEC_ALTA,NUM_TERMINAL)
                        VALUES (V_CLIENTE,V_CICLO,VP_PRODUCTO,VP_ABONADO,V_CALCLIEN,V_DEBITO,VP_CREDMOR,V_NOMUSU,V_APEUSU1,
                        V_APEUSU2,0, VP_FECALTA,VP_TERMINAL);
                         WHEN  OTHERS THEN
                           VP_SQLCODE := SQLCODE;
                       VP_SQLERRM := SQLERRM;
                                   VP_ERROR:='4';
                END;
                --'fin-XO-200510100843 [W.astudillo 18/10/2005]

        EXCEPTION
                WHEN OTHERS THEN
                        VP_SQLCODE := SQLCODE;
                        VP_SQLERRM := SQLERRM;
                        VP_ERROR:='4';
        END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        IF SQLCODE = -1 THEN
           NULL;
        ELSE
           VP_SQLCODE := SQLCODE;
           VP_SQLERRM := SQLERRM;
           VP_ERROR := '4';
        END IF;
END;
/
SHOW ERRORS
