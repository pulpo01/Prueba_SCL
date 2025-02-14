CREATE OR REPLACE PROCEDURE        P_CAMBIO_GRUPOTAR_MASIVO
(VP_PRODUCTO IN NUMBER,
                                   VP_TIPSEL IN NUMBER,
                                   VP_CODSEL IN NUMBER,
                                   VP_PROC IN OUT VARCHAR2,
                                   VP_TABLA IN OUT VARCHAR2,
                                   VP_ACT IN OUT VARCHAR2,
                                   VP_SQLCODE IN OUT VARCHAR2,
                                   VP_SQLERRM IN OUT VARCHAR2,
                                   VP_ERROR IN OUT VARCHAR2)
IS
--
-- Procedimiento de actualizacion de datos de holdings
-- afectados por transacciones del modulo.
--
-- Los valores del codigo de retorno (VP_ERROR), seran los siguientes :
--         - "0" ; Los holdings han sido actualizados correctamente
--         - "4" ; Error en el proceso interno
--
   CURSOR C1 IS
   SELECT COD_CLIENTE
   FROM GE_CLIENTES
   WHERE COD_CUENTA = VP_CODSEL;
   V_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
   V_NUMABONADOS NUMBER;
   IND_VALOR NUMBER;
   IND_PLANTARIF VARCHAR2(1);
BEGIN
    VP_PROC := 'P_CAMBIO_GRUPOTAR_MASIVO';
    IF VP_TIPSEL = 0 THEN
        --- Seleccisn por csdigo de cuenta
        OPEN C1;
        LOOP
            FETCH C1 INTO V_CLIENTE;
            EXIT WHEN C1%NOTFOUND;
            VP_TABLA := 'GA_ABOCEL';
            VP_ACT := 'S';
            SELECT COUNT(*) INTO V_NUMABONADOS
            FROM GA_ABOCEL
            WHERE COD_CLIENTE = V_CLIENTE
                  AND TIP_PLANTARIF = 'E'
                  AND COD_SITUACION IN ('AAA', 'SAA');
            IF V_NUMABONADOS > 0 THEN
               VP_TABLA := 'GA_EMPRESA';
               VP_ACT := 'U';
               IND_VALOR := 0;
               UPDATE GA_EMPRESA
               SET NUM_ABONADOS = IND_VALOR
               WHERE COD_PRODUCTO = VP_PRODUCTO
                     AND COD_CLIENTE  = V_CLIENTE;
            END IF;
            VP_TABLA := 'GA_ABOCEL';
            VP_ACT := 'S';
            SELECT COUNT(*) INTO V_NUMABONADOS
            FROM GA_ABOCEL
            WHERE COD_CLIENTE = V_CLIENTE
                  AND TIP_PLANTARIF = 'H'
                  AND COD_SITUACION IN ('AAA', 'SAA');
            IF V_NUMABONADOS > 0 THEN
               VP_TABLA := 'GA_HOLDING';
               VP_ACT := 'U';
               IND_VALOR := 0;
               UPDATE GA_HOLDING
               SET NUM_ABONADOS = IND_VALOR
               WHERE COD_PRODUCTO = VP_PRODUCTO
                     AND COD_CLIENTE  = V_CLIENTE;
            END IF;
        END LOOP;
        CLOSE C1;
    ELSIF VP_TIPSEL = 1 THEN
        --- Seleccisn por csdigo de cliente
        IND_VALOR := 0;
        V_CLIENTE := VP_CODSEL;
        VP_TABLA := 'GA_ABOCEL';
        VP_ACT := 'S';
        IND_PLANTARIF := 'E';
        SELECT COUNT(*) INTO V_NUMABONADOS
        FROM GA_ABOCEL
        WHERE COD_CLIENTE = V_CLIENTE
              AND TIP_PLANTARIF = IND_PLANTARIF
              AND COD_SITUACION IN ('AAA', 'SAA');
        IF V_NUMABONADOS > 0 THEN
           VP_TABLA := 'GA_EMPRESA';
           VP_ACT := 'U';
           IND_VALOR := 0;
           UPDATE GA_EMPRESA
           SET NUM_ABONADOS = IND_VALOR
           WHERE COD_PRODUCTO = VP_PRODUCTO
                 AND COD_CLIENTE  = V_CLIENTE;
        END IF;
        VP_TABLA := 'GA_ABOCEL';
        VP_ACT := 'S';
        SELECT COUNT(*) INTO V_NUMABONADOS
        FROM GA_ABOCEL
        WHERE COD_CLIENTE = V_CLIENTE
              AND TIP_PLANTARIF = 'H'
              AND COD_SITUACION IN ('AAA', 'SAA');
        IF V_NUMABONADOS > 0 THEN
           VP_TABLA := 'GA_HOLDING';
           VP_ACT := 'U';
           UPDATE GA_HOLDING
              SET NUM_ABONADOS = IND_VALOR
            WHERE COD_PRODUCTO = VP_PRODUCTO
                  AND COD_CLIENTE  = V_CLIENTE;
        END IF;
    ELSIF VP_TIPSEL = 2 THEN
        --- Seleccisn por nzmero de contrato/venta
        VP_TABLA := 'GA_ABOCEL';
        VP_ACT := 'S';
        SELECT COD_CLIENTE INTO V_CLIENTE
        FROM GA_ABOCEL
        WHERE NUM_VENTA = VP_CODSEL;
        VP_TABLA := 'GA_ABOCEL';
        VP_ACT := 'S';
        IND_PLANTARIF := 'E';
        SELECT COUNT(*) INTO V_NUMABONADOS
        FROM GA_ABOCEL
        WHERE COD_CLIENTE = V_CLIENTE
              AND TIP_PLANTARIF = IND_PLANTARIF
              AND COD_SITUACION IN ('AAA', 'SAA');
        IF V_NUMABONADOS > 0 THEN
           VP_TABLA := 'GA_EMPRESA';
           VP_ACT := 'U';
           UPDATE GA_EMPRESA
           SET NUM_ABONADOS = IND_VALOR
           WHERE COD_PRODUCTO = VP_PRODUCTO
                 AND COD_CLIENTE  = V_CLIENTE;
        END IF;
        VP_TABLA := 'GA_ABOCEL';
        VP_ACT := 'S';
        SELECT COUNT(*) INTO V_NUMABONADOS
        FROM GA_ABOCEL
        WHERE COD_CLIENTE = V_CLIENTE
              AND TIP_PLANTARIF = 'H'
              AND COD_SITUACION IN ('AAA', 'SAA');
        IF V_NUMABONADOS > 0 THEN
           VP_TABLA := 'GA_HOLDING';
           VP_ACT := 'U';
           UPDATE GA_HOLDING
           SET NUM_ABONADOS = IND_VALOR
           WHERE COD_PRODUCTO = VP_PRODUCTO
                 AND COD_CLIENTE  = V_CLIENTE;
        END IF;
    END IF;
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
