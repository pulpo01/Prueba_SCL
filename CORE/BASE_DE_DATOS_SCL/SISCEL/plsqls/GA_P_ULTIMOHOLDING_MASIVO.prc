CREATE OR REPLACE PROCEDURE        GA_P_ULTIMOHOLDING_MASIVO
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
  --PL que comprueba si el abonado que se esta dando de baja y tarifario
  --Holding o Empresa es el ultimo . si es asm Elimina el abonado 0 de
  --Interface con Facturacion y Tarificacion
  --Retorna 0 si todo funciono, 4 si se produjo algzn error
  --
   CURSOR C1 IS
      SELECT COD_CLIENTE
      FROM GE_CLIENTES
      WHERE COD_CUENTA = VP_CODSEL;
   V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
   V_TIPPLANTARIF GA_ABOCEL.TIP_PLANTARIF%TYPE;
   V_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
   V_CICLO GE_CLIENTES.COD_CICLO%TYPE;
   ERROR_PROCESO EXCEPTION;
   IND_VALOR NUMBER;
   IND_BAJA NUMBER;
BEGIN
  BEGIN
      VP_PROC := 'GA_P_ULTIMOHOLDINGMASIVO';
      IND_BAJA := 2;
      IF VP_PRODUCTO = 1 THEN
         IF VP_TIPSEL = 0 THEN
            --- Seleccion por codigo de cuenta
            OPEN C1;
            LOOP
                FETCH C1 INTO V_CLIENTE;
                EXIT WHEN C1%NOTFOUND;
                VP_TABLA := 'GA_ABOCEL';
                VP_ACT := 'S';
                SELECT DISTINCT TIP_PLANTARIF INTO V_TIPPLANTARIF
                FROM GA_ABOCEL
                WHERE COD_CLIENTE = V_CLIENTE;
                IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                   VP_TABLA        := 'GA_INTARCEL';
                   VP_ACT          := 'D';
                   IND_VALOR := 0;
                   UPDATE GA_INTARCEL SET FEC_HASTA=SYSDATE
                   WHERE NUM_ABONADO = IND_VALOR
                         AND TIP_PLANTARIF = V_TIPPLANTARIF
                         AND COD_CLIENTE = V_CLIENTE
                         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                   VP_TABLA        := 'GA_INFACCEL';
                   VP_ACT          := 'D';
                   UPDATE GA_INFACCEL SET FEC_BAJA=SYSDATE,
                          IND_ACTUAC = IND_BAJA
                   WHERE NUM_ABONADO = IND_VALOR
                         AND COD_CLIENTE = V_CLIENTE
                         AND COD_CICLFACT = V_CICLFACT;
                END IF;
             END LOOP;
             CLOSE C1;
          ELSIF VP_TIPSEL = 1 THEN
              --- Seleccisn por csdigo de cliente
                V_CLIENTE := VP_CODSEL;
                SELECT COD_CICLO INTO V_CICLO
                FROM GE_CLIENTES
                WHERE COD_CLIENTE = V_CLIENTE;
                SELECT COD_CICLFACT INTO V_CICLFACT
                FROM FA_CICLFACT
                WHERE COD_CICLO = V_CICLO
                      AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
                VP_TABLA := 'GA_ABOCEL';
                VP_ACT := 'S';
                SELECT DISTINCT TIP_PLANTARIF INTO V_TIPPLANTARIF
                FROM GA_ABOCEL
                WHERE COD_CLIENTE = V_CLIENTE;
                IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                   VP_TABLA        := 'GA_INTARCEL';
                   VP_ACT          := 'U';
                   IND_VALOR := 0;
                   UPDATE GA_INTARCEL
                   SET FEC_HASTA=SYSDATE
                   WHERE COD_CLIENTE = V_CLIENTE
                         AND NUM_ABONADO = IND_VALOR
                         AND TIP_PLANTARIF = V_TIPPLANTARIF
                         AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                   VP_TABLA        := 'GA_INFACCEL';
                   VP_ACT          := 'D';
                   UPDATE GA_INFACCEL
                   SET FEC_BAJA=SYSDATE,
                       IND_ACTUAC = IND_BAJA
                   WHERE COD_CLIENTE = V_CLIENTE
                         AND NUM_ABONADO = IND_VALOR
                         AND COD_CICLFACT = V_CICLFACT;
                END IF;
          ELSIF VP_TIPSEL = 2 THEN
              --- Seleccisn por nzmero de contrato/venta
                VP_TABLA := 'GA_VENTAS';
                VP_ACT := 'S';
                SELECT COD_CLIENTE INTO V_CLIENTE
                FROM GA_VENTAS
                WHERE NUM_VENTA = VP_CODSEL;
                VP_TABLA := 'GA_ABOCEL';
                VP_ACT := 'S';
                SELECT DISTINCT TIP_PLANTARIF INTO V_TIPPLANTARIF
                FROM GA_ABOCEL
                WHERE COD_CLIENTE = V_CLIENTE;
                IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                   VP_TABLA        := 'GA_INTARCEL';
                   VP_ACT          := 'D';
                   UPDATE GA_INTARCEL
                   SET FEC_HASTA=SYSDATE
                   WHERE COD_CLIENTE = V_CLIENTE
                         AND NUM_ABONADO = IND_VALOR
                         AND TIP_PLANTARIF = V_TIPPLANTARIF
                          AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                   VP_TABLA        := 'GA_INFACCEL';
                   VP_ACT          := 'D';
                   UPDATE GA_INFACCEL
                   SET FEC_BAJA=SYSDATE,
                       IND_ACTUAC = IND_BAJA
                   WHERE COD_CLIENTE = V_CLIENTE
                         AND NUM_ABONADO = IND_VALOR
                         AND COD_CICLFACT = V_CICLFACT;
              END IF;
          END IF;
      ELSIF VP_PRODUCTO = 2 THEN
          IF VP_TIPSEL = 0 THEN
              --- Seleccisn por csdigo de cuenta
              OPEN C1;
              LOOP
                  FETCH C1 INTO V_CLIENTE;
                  EXIT WHEN C1%NOTFOUND;
                  VP_TABLA := 'GA_ABOBEEP';
                  VP_ACT := 'S';
                  SELECT DISTINCT TIP_PLANTARIF
                    INTO V_TIPPLANTARIF
                    FROM GA_ABOBEEP
                   WHERE COD_CLIENTE = V_CLIENTE;
                  IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                      --BORRAMOS DE LAS INTARXXX
                      VP_TABLA        := 'GA_INTARBEEP';
                      VP_ACT          := 'D';
                      DELETE GA_INTARBEEP WHERE NUM_ABONADO = 0
                      AND TIP_PLANTARIF = V_TIPPLANTARIF
                      AND COD_CLIENTE = V_CLIENTE;
                      --BORRAMOS DE LAS INFACXXX
                      VP_TABLA        := 'GA_INFACBEEP';
                      VP_ACT          := 'D';
                      DELETE GA_INFACBEEP WHERE NUM_ABONADO = 0
                      AND COD_CLIENTE = V_CLIENTE;
                      --BORRAMOS DE CICLOCLI
                      VP_TABLA        := 'FA_CICLOCLI';
                      VP_ACT          := 'D';
                      DELETE FA_CICLOCLI WHERE NUM_ABONADO = 0
                      AND COD_CLIENTE = V_CLIENTE;
                  END IF;
              END LOOP;
              CLOSE C1;
          ELSIF VP_TIPSEL = 1 THEN
              --- Seleccisn por csdigo de cliente
              V_CLIENTE := VP_CODSEL;
              VP_TABLA := 'GA_ABOBEEP';
              VP_ACT := 'S';
              SELECT DISTINCT TIP_PLANTARIF
                INTO V_TIPPLANTARIF
                FROM GA_ABOBEEP
               WHERE COD_CLIENTE = V_CLIENTE;
              IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                  --BORRAMOS DE LAS INTARXXX
                  VP_TABLA        := 'GA_INTARBEEP';
                  VP_ACT          := 'D';
                  DELETE GA_INTARBEEP WHERE NUM_ABONADO = 0
                  AND TIP_PLANTARIF = V_TIPPLANTARIF
                  AND COD_CLIENTE = V_CLIENTE;
                  --BORRAMOS DE LAS INFACXXX
                  VP_TABLA        := 'GA_INFACBEEP';
                  VP_ACT          := 'D';
                  DELETE GA_INFACBEEP WHERE NUM_ABONADO = 0
                  AND COD_CLIENTE = V_CLIENTE;
                  --BORRAMOS DE CICLOCLI
                  VP_TABLA        := 'FA_CICLOCLI';
                  VP_ACT          := 'D';
                  DELETE FA_CICLOCLI WHERE NUM_ABONADO = 0
                  AND COD_CLIENTE = V_CLIENTE;
              END IF;
          ELSIF VP_TIPSEL = 2 THEN
              --- Seleccisn por nzmero de contrato/venta
              VP_TABLA := 'GA_VENTAS';
              VP_ACT := 'S';
              SELECT COD_CLIENTE
                INTO V_CLIENTE
                FROM GA_VENTAS
               WHERE NUM_VENTA = VP_CODSEL;
              VP_TABLA := 'GA_ABOBEEP';
              VP_ACT := 'S';
              SELECT DISTINCT TIP_PLANTARIF
                INTO V_TIPPLANTARIF
                FROM GA_ABOBEEP
               WHERE COD_CLIENTE = V_CLIENTE;
              IF V_TIPPLANTARIF = 'H' OR V_TIPPLANTARIF ='E' THEN
                  --BORRAMOS DE LAS INTARXXX
                  VP_TABLA        := 'GA_INTARBEEP';
                  VP_ACT          := 'D';
                  DELETE GA_INTARBEEP WHERE NUM_ABONADO = 0
                  AND TIP_PLANTARIF = V_TIPPLANTARIF
                  AND COD_CLIENTE = V_CLIENTE;
                  --BORRAMOS DE LAS INFACXXX
                  VP_TABLA        := 'GA_INFACBEEP';
                  VP_ACT          := 'D';
                  DELETE GA_INFACBEEP WHERE NUM_ABONADO = 0
                  AND COD_CLIENTE = V_CLIENTE;
                  --BORRAMOS DE CICLOCLI
                  VP_TABLA        := 'FA_CICLOCLI';
                  VP_ACT          := 'D';
                  DELETE FA_CICLOCLI WHERE NUM_ABONADO = 0
                  AND COD_CLIENTE = V_CLIENTE;
              END IF;
          END IF;
      END IF;
  EXCEPTION
          WHEN ERROR_PROCESO THEN
                  VP_SQLCODE      := SQLCODE;
                  VP_SQLERRM      := SQLERRM;
          WHEN OTHERS THEN
                  VP_ERROR := '4';
                  VP_SQLCODE      := SQLCODE;
                  VP_SQLERRM      := SQLERRM;
  END;
END GA_P_ULTIMOHOLDING_MASIVO;
/
SHOW ERRORS
