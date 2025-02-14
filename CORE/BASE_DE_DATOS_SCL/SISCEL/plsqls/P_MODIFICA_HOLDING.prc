CREATE OR REPLACE PROCEDURE        P_MODIFICA_HOLDING(
  VP_PRODUCTO IN NUMBER ,
  VP_HOLDING IN NUMBER ,
  VP_PLANTARIF  VARCHAR2 ,
  VP_CICLO  NUMBER ,
  VP_FECSYS IN OUT DATE ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- Procedimiento que refleja los cambios y efectividad de los nuevos
-- planes tarifarios y/o ciclos de facturacion del holding en las tablas
-- de interfase con Tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_PRODUCTO GA_ABOCEL.COD_PRODUCTO%TYPE;
   V_ABONADO GA_INTARCEL.NUM_ABONADO%TYPE;
   V_CLIENTE GA_INTARCEL.COD_CLIENTE%TYPE;
   V_CICLO GA_INTARCEL.COD_CICLO%TYPE;
   CURSOR CCEL IS
   SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLO
     FROM GA_INTARCEL
    WHERE TIP_PLANTARIF = 'H'
      AND COD_GRUPO = VP_HOLDING
      AND IND_NUMERO = 0
      AND VP_FECSYS BETWEEN FEC_DESDE
   AND FEC_HASTA;
   CURSOR CBEEP IS
   SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLO
     FROM GA_INTARBEEP
    WHERE TIP_PLANTARIF = 'H'
      AND COD_GRUPO = VP_HOLDING
      AND VP_FECSYS BETWEEN FEC_DESDE
          AND FEC_HASTA;
   CURSOR CTRUNK IS
   SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLO
     FROM GA_INTARTRUNK
    WHERE TIP_PLANTARIF = 'H'
      AND COD_GRUPO = VP_HOLDING
      AND VP_FECSYS BETWEEN FEC_DESDE
   AND FEC_HASTA;
   CURSOR CTREK IS
   SELECT COD_CLIENTE,NUM_ABONADO,COD_CICLO
     FROM GA_INTARTREK
    WHERE TIP_PLANTARIF = 'H'
      AND COD_GRUPO = VP_HOLDING
      AND VP_FECSYS BETWEEN FEC_DESDE
   AND FEC_HASTA;
   ERROR_PROCESO EXCEPTION;
BEGIN
   VP_PROC := 'P_MODIFICA_HOLDING';
   IF VP_PRODUCTO = 1 THEN
      IF VP_PLANTARIF IS NOT NULL THEN
         VP_TABLA := 'GA_ABOCEL';
         VP_ACT := 'U';
         UPDATE GA_ABOCEL SET COD_PLANTARIF = VP_PLANTARIF
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      IF VP_CICLO IS NOT NULL THEN
         VP_TABLA := 'GA_ABOCEL';
         VP_ACT := 'U';
         UPDATE GA_ABOCEL SET COD_CICLO = VP_CICLO
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      VP_TABLA := 'CCEL';
      VP_ACT := 'O';
      OPEN CCEL;
      LOOP
         VP_ACT := 'F';
         FETCH CCEL INTO V_CLIENTE,V_ABONADO,V_CICLO;
         EXIT WHEN CCEL%NOTFOUND;
         IF VP_PLANTARIF IS NOT NULL THEN
            P_PLAN_TARIFARIO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
                              'H',VP_PLANTARIF,V_CICLO,VP_FECSYS,
         NULL,VP_HOLDING,'H',VP_HOLDING,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
         IF VP_CICLO IS NOT NULL THEN
     P_CAMBIO_CICLO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
       VP_CICLO,V_CICLO,VP_FECSYS,
       VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
       VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
      END LOOP;
      VP_TABLA := 'CCEL';
      VP_ACT := 'C';
      CLOSE CCEL;
   ELSIF VP_PRODUCTO = 2 THEN
      IF VP_PLANTARIF IS NOT NULL THEN
         VP_TABLA := 'GA_ABOBEEP';
         VP_ACT := 'U';
         UPDATE GA_ABOBEEP SET COD_PLANTARIF = VP_PLANTARIF
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      IF VP_CICLO IS NOT NULL THEN
         VP_TABLA := 'GA_ABOBEEP';
         VP_ACT := 'U';
         UPDATE GA_ABOBEEP SET COD_CICLO = VP_CICLO
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      VP_TABLA := 'CBEEP';
      VP_ACT := 'O';
      OPEN CBEEP;
      LOOP
         VP_ACT := 'F';
         FETCH CBEEP INTO V_CLIENTE,V_ABONADO,V_CICLO;
         EXIT WHEN CBEEP%NOTFOUND;
         IF VP_PLANTARIF IS NOT NULL THEN
            P_PLAN_TARIFARIO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
                              'H',VP_PLANTARIF,V_CICLO,VP_FECSYS,
         NULL,VP_HOLDING,'H',VP_HOLDING,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
         IF VP_CICLO IS NOT NULL THEN
     P_CAMBIO_CICLO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
       VP_CICLO,V_CICLO,VP_FECSYS,
       VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
       VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
      END LOOP;
      VP_TABLA := 'CBEEP';
      VP_ACT := 'C';
      CLOSE CBEEP;
   ELSIF VP_PRODUCTO = 3 THEN
      IF VP_PLANTARIF IS NOT NULL THEN
         VP_TABLA := 'GA_ABOTRUNK';
         VP_ACT := 'U';
         UPDATE GA_ABOTRUNK SET COD_PLANTARIF = VP_PLANTARIF
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      IF VP_CICLO IS NOT NULL THEN
         VP_TABLA := 'GA_ABOTRUNK';
         VP_ACT := 'U';
         UPDATE GA_ABOTRUNK SET COD_CICLO = VP_CICLO
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      VP_TABLA := 'CTRUNK';
      VP_ACT := 'O';
      OPEN CTRUNK;
      LOOP
         VP_ACT := 'F';
         FETCH CTRUNK INTO V_CLIENTE,V_ABONADO,V_CICLO;
         EXIT WHEN CTRUNK%NOTFOUND;
         IF VP_PLANTARIF IS NOT NULL THEN
            P_PLAN_TARIFARIO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
                              'H',VP_PLANTARIF,V_CICLO,VP_FECSYS,
         NULL,VP_HOLDING,'H',VP_HOLDING,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
         IF VP_CICLO IS NOT NULL THEN
     P_CAMBIO_CICLO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
       VP_CICLO,V_CICLO,VP_FECSYS,
       VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
       VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
      END LOOP;
      VP_TABLA := 'CTRUNK';
      VP_ACT := 'C';
      CLOSE CTRUNK;
   ELSIF VP_PRODUCTO = 4 THEN
      IF VP_PLANTARIF IS NOT NULL THEN
         VP_TABLA := 'GA_ABOTREK';
         VP_ACT := 'U';
         UPDATE GA_ABOTREK SET COD_PLANTARIF = VP_PLANTARIF
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      IF VP_CICLO IS NOT NULL THEN
         VP_TABLA := 'GA_ABOTREK';
         VP_ACT := 'U';
         UPDATE GA_ABOTREK SET COD_CICLO = VP_CICLO
          WHERE COD_HOLDING = VP_HOLDING
            AND COD_SITUACION IN ('AOP','AOA','CVA',
                                  'RDA','ATP','ATA',
                                  'SAO','SAT','SCV',
                                  'SRD','AOS','ATS',
                                  'CVS','RDS','RAO',
                                  'RAT','RCV','RRD');
      END IF;
      VP_TABLA := 'CTREK';
      VP_ACT := 'O';
      OPEN CTREK;
      LOOP
         VP_ACT := 'F';
         FETCH CTREK INTO V_CLIENTE,V_ABONADO,V_CICLO;
         EXIT WHEN CTREK%NOTFOUND;
         IF VP_PLANTARIF IS NOT NULL THEN
            P_PLAN_TARIFARIO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
                              'H',VP_PLANTARIF,V_CICLO,VP_FECSYS,
         NULL,VP_HOLDING,'H',VP_HOLDING,
         VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
         VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
         IF VP_CICLO IS NOT NULL THEN
     P_CAMBIO_CICLO (VP_PRODUCTO,V_CLIENTE,V_ABONADO,
       VP_CICLO,V_CICLO,VP_FECSYS,
       VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,
       VP_SQLERRM,VP_ERROR);
            IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
        RAISE ERROR_PROCESO;
            END IF;
            VP_PROC := 'P_MODIFICA_HOLDING';
         END IF;
      END LOOP;
      VP_TABLA := 'CTREK';
      VP_ACT := 'C';
      CLOSE CTREK;
   END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
 IF VP_SQLCODE IS NULL THEN
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
        END IF;
        VP_ERROR := '4';
   WHEN OTHERS THEN
 VP_SQLCODE := SQLCODE;
 VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
