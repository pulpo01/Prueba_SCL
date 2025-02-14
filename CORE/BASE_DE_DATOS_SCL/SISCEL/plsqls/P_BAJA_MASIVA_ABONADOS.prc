CREATE OR REPLACE PROCEDURE        P_BAJA_MASIVA_ABONADOS
(VP_PRODUCTO IN NUMBER,
                                 VP_TIPSEL IN NUMBER,
                                 VP_CODSEL IN NUMBER,
                                 VP_FECSYS IN DATE,
                                 VP_PROC IN OUT VARCHAR2,
                                 VP_TABLA IN OUT VARCHAR2,
                                 VP_ACT IN OUT VARCHAR2,
                                 VP_SQLCODE IN OUT VARCHAR2,
                                 VP_SQLERRM IN OUT VARCHAR2,
                                 VP_ERROR IN OUT VARCHAR2)
IS
--
-- Procedimiento que refleja la baja de abonados marcando fecha fin vigencia
-- en las tablas de interfase con tarificacion y facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   CURSOR C1 IS
      SELECT NUM_ABONADO, COD_CLIENTE, COD_CICLO
      FROM GA_ABOCEL
      WHERE COD_CUENTA = VP_CODSEL
            AND TIP_PLANTARIF = 'E'
            AND COD_SITUACION IN ('AAA', 'SAA');
   CURSOR C2 IS
      SELECT NUM_ABONADO, COD_CLIENTE, COD_CICLO
      FROM GA_ABOCEL
      WHERE COD_CLIENTE = VP_CODSEL
            AND COD_SITUACION IN ('AAA', 'SAA');
   CURSOR C3 IS
      SELECT NUM_ABONADO, COD_CLIENTE, COD_CICLO
      FROM GA_ABOCEL
      WHERE NUM_VENTA = VP_CODSEL
            AND COD_SITUACION IN ('AAA', 'SAA');
   V_ABONADO GA_ABOCEL.COD_CLIENTE%TYPE;
   V_CLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;
   V_CODCICLO GA_ABOCEL.COD_CICLO%TYPE;
   IND_ACTUACION NUMBER;
   IND_VALOR NUMBER;
   ERROR_PROCESO EXCEPTION;
BEGIN
   VP_PROC := 'P_BAJA_MASIVA_ABONADOS';
   IF VP_PRODUCTO = 1 THEN
      IF VP_TIPSEL = 0 THEN
          --- Seleccisn por csdigo de cuenta
          OPEN C1;
           LOOP
              FETCH C1 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C1%NOTFOUND;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'U';
              UPDATE GA_INTARCEL
                 SET FEC_HASTA = VP_FECSYS
               WHERE COD_CLIENTE = V_CLIENTE
                 AND NUM_ABONADO = V_ABONADO
                 AND VP_FECSYS BETWEEN FEC_DESDE
                                   AND FEC_HASTA;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'D';
              DELETE GA_INTARCEL
               WHERE COD_CLIENTE = V_CLIENTE
                 AND NUM_ABONADO = V_ABONADO
                 AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACCEL';
              VP_ACT := 'U';
              IND_ACTUACION := 2;
              IND_VALOR := 1;
              UPDATE GA_INFACCEL
                 SET IND_ACTUAC = IND_ACTUACION,
                     FEC_BAJA = VP_FECSYS
               WHERE COD_CLIENTE = V_CLIENTE
                 AND NUM_ABONADO = V_ABONADO
                 AND IND_ACTUAC = IND_VALOR
                 AND COD_CICLFACT = (SELECT COD_CICLFACT
                                       FROM FA_CICLFACT
                                      WHERE COD_CICLO = V_CODCICLO
                                        AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                                          AND FEC_HASTALLAM);
              -- llamada baja servicios suplementarios
              P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C1;
      ELSIF VP_TIPSEL = 1 THEN
          --- Seleccisn por csdigo de cliente
          OPEN C2;
          LOOP
              FETCH C2 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C2%NOTFOUND;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'U';
              UPDATE GA_INTARCEL
              SET FEC_HASTA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'D';
              DELETE GA_INTARCEL
               WHERE COD_CLIENTE = V_CLIENTE
                     AND NUM_ABONADO = V_ABONADO
                     AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACCEL';
              VP_ACT := 'U';
              IND_ACTUACION := 2;
              IND_VALOR := 1;
              UPDATE GA_INFACCEL
              SET IND_ACTUAC = IND_ACTUACION,FEC_BAJA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND IND_ACTUAC = IND_VALOR
                    AND COD_CICLFACT = (SELECT COD_CICLFACT
                                        FROM FA_CICLFACT
                                        WHERE COD_CICLO = V_CODCICLO
                                              AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                              AND FEC_HASTALLAM);
              P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C2;
      ELSIF VP_TIPSEL = 2 THEN
          --- Seleccisn por nzmero de contrato/venta
          OPEN C3;
          LOOP
              FETCH C3 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C3%NOTFOUND;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'U';
              UPDATE GA_INTARCEL
                 SET FEC_HASTA = VP_FECSYS
               WHERE COD_CLIENTE = V_CLIENTE
                 AND NUM_ABONADO = V_ABONADO
                 AND VP_FECSYS BETWEEN FEC_DESDE
                                   AND FEC_HASTA;
              VP_TABLA := 'GA_INTARCEL';
              VP_ACT := 'D';
              DELETE GA_INTARCEL
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACCEL';
              VP_ACT := 'U';
              IND_VALOR := 1;
              IND_ACTUACION := 2;
              UPDATE GA_INFACCEL
              SET IND_ACTUAC = IND_ACTUACION,FEC_BAJA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND IND_ACTUAC = IND_VALOR
                    AND COD_CICLFACT = (SELECT COD_CICLFACT
                                        FROM FA_CICLFACT
                                        WHERE COD_CICLO = V_CODCICLO
                                              AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                              AND FEC_HASTALLAM);
              P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C3;
      END IF;
   ELSIF VP_PRODUCTO = 2 THEN
      IF VP_TIPSEL = 0 THEN
          --- Seleccisn por csdigo de cuenta
          OPEN C1;
          LOOP
              FETCH C1 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C1%NOTFOUND;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'U';
              UPDATE GA_INTARBEEP
                 SET FEC_HASTA = VP_FECSYS
               WHERE COD_CLIENTE = V_CLIENTE
                 AND VP_FECSYS BETWEEN FEC_DESDE
                                   AND FEC_HASTA;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'D';
              DELETE GA_INTARBEEP
               WHERE COD_CLIENTE = V_CLIENTE
                 AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACBEEP';
              VP_ACT := 'U';
              IND_ACTUACION := 2;
              IND_VALOR := 1;
              UPDATE GA_INFACBEEP
              SET IND_ACTUAC = IND_ACTUACION,FEC_BAJA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND IND_ACTUAC = IND_VALOR
                    AND COD_CICLFACT = (SELECT COD_CICLFACT
                                        FROM FA_CICLFACT
                                        WHERE COD_CICLO = V_CODCICLO
                                              AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                              AND FEC_HASTALLAM);
              P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C1;
      ELSIF VP_TIPSEL = 1 THEN
          --- Seleccisn por csdigo de cliente
          OPEN C2;
          LOOP
              FETCH C2 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C2%NOTFOUND;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'U';
              UPDATE GA_INTARBEEP
              SET FEC_HASTA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'D';
              DELETE GA_INTARBEEP
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACBEEP';
              VP_ACT := 'U';
              IND_ACTUACION := 2;
              IND_VALOR := 1;
              UPDATE GA_INFACBEEP
              SET IND_ACTUAC = IND_ACTUACION,FEC_BAJA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND IND_ACTUAC = IND_VALOR
                    AND COD_CICLFACT = (SELECT COD_CICLFACT
                                        FROM FA_CICLFACT
                                        WHERE COD_CICLO = V_CODCICLO
                                              AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                              AND FEC_HASTALLAM);
          P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C2;
      ELSIF VP_TIPSEL = 2 THEN
          --- Seleccisn por nzmero de contrato/venta
          OPEN C3;
          LOOP
              FETCH C3 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
              EXIT WHEN C3%NOTFOUND;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'U';
              UPDATE GA_INTARBEEP
              SET FEC_HASTA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
              VP_TABLA := 'GA_INTARBEEP';
              VP_ACT := 'D';
              DELETE GA_INTARBEEP
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO AND FEC_DESDE > VP_FECSYS;
              VP_TABLA := 'GA_INFACBEEP';
              VP_ACT := 'U';
              IND_ACTUACION := 2;
              IND_VALOR := 1;
              UPDATE GA_INFACBEEP
              SET IND_ACTUAC = IND_ACTUACION,FEC_BAJA = VP_FECSYS
              WHERE COD_CLIENTE = V_CLIENTE
                    AND NUM_ABONADO = V_ABONADO
                    AND IND_ACTUAC = IND_VALOR
                    AND COD_CICLFACT = (SELECT COD_CICLFACT
                                        FROM FA_CICLFACT
                                        WHERE COD_CICLO = V_CODCICLO
                                              AND VP_FECSYS BETWEEN FEC_DESDELLAM
                                              AND FEC_HASTALLAM);
              P_BAJA_SERTRAS(VP_PRODUCTO,V_CLIENTE,V_ABONADO,VP_PROC,
              VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
              IF VP_ERROR <>'0' THEN
                RAISE ERROR_PROCESO;
              END IF;
          END LOOP;
          CLOSE C3;
      END IF;
   END IF;
  IF VP_TIPSEL = 0 THEN
    --- Seleccisn por csdigo de cuenta
    OPEN C1;
    LOOP
        FETCH C1 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
        EXIT WHEN C1%NOTFOUND;
        VP_TABLA := 'GA_FINCICLO';
        VP_ACT := 'D';
        DELETE GA_FINCICLO
         WHERE NUM_ABONADO = V_ABONADO
           AND COD_PRODUCTO = VP_PRODUCTO;
    END LOOP;
    CLOSE C1;
  ELSIF VP_TIPSEL = 1 THEN
      --- Seleccisn por csdigo de cliente
    OPEN C2;
    LOOP
        FETCH C2 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
        EXIT WHEN C2%NOTFOUND;
        VP_TABLA := 'GA_FINCICLO';
        VP_ACT := 'D';
        DELETE GA_FINCICLO
         WHERE NUM_ABONADO = V_ABONADO
           AND COD_PRODUCTO = VP_PRODUCTO;
    END LOOP;
    CLOSE C2;
  ELSIF VP_TIPSEL = 2 THEN
      --- Seleccisn por nzm. de contrato/venta
    OPEN C3;
    LOOP
        FETCH C3 INTO V_ABONADO, V_CLIENTE, V_CODCICLO;
        EXIT WHEN C2%NOTFOUND;
        VP_TABLA := 'GA_FINCICLO';
        VP_ACT := 'D';
        DELETE GA_FINCICLO
         WHERE NUM_ABONADO = V_ABONADO
           AND COD_PRODUCTO = VP_PRODUCTO;
    END LOOP;
    CLOSE C3;
  END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
     VP_SQLCODE := SQLCODE;
     VP_SQLERRM := SQLERRM;
     VP_ERROR := '4';
   WHEN OTHERS THEN
     VP_SQLCODE := SQLCODE;
     VP_SQLERRM := SQLERRM;
     VP_ERROR := '4';
END;
/
SHOW ERRORS
