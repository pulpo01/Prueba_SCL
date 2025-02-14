CREATE OR REPLACE PROCEDURE SC_P_GENERA_ASIENTO
(p_num_lote         IN  SC_CAB_LOTE.NUM_LOTE%TYPE
,p_id_lote          IN  SC_CAB_LOTE.ID_LOTE%TYPE
,p_cod_evento       IN  SC_CAB_LOTE.COD_EVENTO%TYPE
,p_cod_operadora    IN  SC_ENT_CAB_LOTE.COD_OPERADORA_SCL%TYPE
)
IS

--v_existe_error        NUMBER;
v_ind_imputac_ctA     SC_EVENTO.IND_IMPUTACION%TYPE;
v_ind_imputac_ctP     SC_EVENTO.IND_IMPUTACION%TYPE;
v_cod_error           SC_ERROR_INGRESO.COD_ERROR%TYPE;
v_des_error           SC_ERROR_INGRESO.DES_ERROR%TYPE;
v_contador            NUMBER := 0;

CURSOR C1 IS
   SELECT CC.COD_CUENTA,
          CC.COD_CONTRAP,
          E.IND_IMPUTACION,
          L.IMP_MOVIMIENTO,
          CL.COD_EVENTO,
          E.IND_AGRUPACION,
          L.DES_TRANSACCION
     FROM SC_CTO_CTA CC,
 	  SC_LOTE L,
 	  SC_CAB_LOTE CL,
	  SC_EVENTO E
     WHERE CC.COD_OPERADORA_SCL = CL.COD_OPERADORA_SCL
	  AND CC.COD_OPERADORA_SCL = p_cod_operadora
	  AND CC.COD_EVENTO_CTO = E.COD_EVENTO_CTO
	  AND CC.COD_DOMINIO_CTO = E.COD_DOMINIO_CTO
	  AND CC.COD_CONCEPTO = L.COD_CONCEPTO
	  AND CL.COD_EVENTO = E.COD_EVENTO
	  AND L.NUM_LOTE =  CL.NUM_LOTE
	  AND L.NUM_LOTE =  p_num_lote;
--
C1_CUENTAS_LOTE         C1%ROWTYPE;
--
CURSOR C2 IS
   SELECT NUM_LOTE,
          COD_CUENTA,
          IMP_DEBITO,
          IMP_CREDITO,
          ROWID
     FROM SC_ASIENTO_LOTE
     WHERE NUM_LOTE = p_num_lote;
--
C2_ASIENTO_LOTE         C2%ROWTYPE;
--
ERROR_ACUMULACION           EXCEPTION;
--
BEGIN
--
--p_num_lote:= TO_NUMBER(p_num_lote); --TO_NUMBER(LTRIM(RTRIM(p_num_lote)));

    -- DELETE REGISTROS SC_ASIENTO_LOTE
    DELETE
      FROM sc_asiento_lote
     WHERE Num_lote = p_num_lote;
    --COMMIT;

    -- DELETE REGISTROS DE SC_PROCARCH
    DELETE
      FROM sc_procarch
     WHERE cod_evento = p_cod_evento
       AND id_lote    = p_id_lote
       AND cod_operadora_scl = p_cod_operadora;
    --COMMIT;

    --
    --SELECT COUNT(*)
    --  INTO v_existe_error
    --  FROM SC_ERROR_ASIENTO
    --  WHERE NUM_LOTE = p_num_lote;
    --
    --IF v_existe_error = 1 THEN
    DELETE
      FROM SC_ERROR_ASIENTO
     WHERE NUM_LOTE   = p_num_lote;
    --COMMIT;
    --END IF;
    --

    OPEN C1;
    LOOP
      FETCH C1 INTO C1_CUENTAS_LOTE;
      EXIT WHEN C1%NOTFOUND;


      IF C1_CUENTAS_LOTE.IMP_MOVIMIENTO < 0 THEN
         IF C1_CUENTAS_LOTE.IND_IMPUTACION = 'C' THEN
            v_ind_imputac_ctA := 'D';
            v_ind_imputac_ctP := 'C';
         ELSE                        --    = 'D'
            v_ind_imputac_ctA := 'C';
            v_ind_imputac_ctP := 'D';
         END IF;
      ELSE
         IF C1_CUENTAS_LOTE.IND_IMPUTACION = 'C' THEN
            v_ind_imputac_ctA := 'C';
            v_ind_imputac_ctP := 'D';
         ELSE                        --    = 'D'
            v_ind_imputac_ctA := 'D';
            v_ind_imputac_ctP := 'C';
         END IF;
      END IF;
      -- acumula cuenta contable
      SC_P_ACUMULA_ASIENTO(
             p_num_lote,
             C1_CUENTAS_LOTE.COD_CUENTA,
             ABS(C1_CUENTAS_LOTE.IMP_MOVIMIENTO),
             v_ind_imputac_ctA,
             C1_CUENTAS_LOTE.IND_AGRUPACION,
             C1_CUENTAS_LOTE.DES_TRANSACCION,
             'P',
             p_cod_operadora
             );

      IF v_cod_error <> 00 THEN
         RAISE ERROR_ACUMULACION;
      END IF;
      -- acumula cuenta contable de contrapartida
      SC_P_ACUMULA_ASIENTO(
             p_num_lote,
             C1_CUENTAS_LOTE.COD_CONTRAP,
             ABS(C1_CUENTAS_LOTE.IMP_MOVIMIENTO),
             v_ind_imputac_ctP,
             C1_CUENTAS_LOTE.IND_AGRUPACION,
             C1_CUENTAS_LOTE.DES_TRANSACCION,
             'C',
             p_cod_operadora
             );

      IF v_cod_error <> 00 THEN
         RAISE ERROR_ACUMULACION;
      END IF;
      v_contador := v_contador + 1;
    END LOOP;
    --
    IF v_contador = 0 THEN
       v_cod_error := 01;
       v_des_error := 'NO SE ENCONTRO MOVIMIENTOS EN EL LOTE ESPECIFICADO '
                      ||SUBSTR(TO_CHAR(C1_CUENTAS_LOTE.COD_EVENTO,'09'),2,2)||' - '
                      ||SUBSTR(TO_CHAR(p_num_lote,'999999999999'),2,12);
       RAISE ERROR_ACUMULACION;
    END IF;
    CLOSE C1;
    --
    -- PROCESO DE NETEO DE CUENTAS
    --
    OPEN C2;
    LOOP
       FETCH C2 INTO C2_ASIENTO_LOTE;
       EXIT WHEN C2%NOTFOUND;


       IF C2_ASIENTO_LOTE.IMP_DEBITO > 0  AND  C2_ASIENTO_LOTE.IMP_CREDITO > 0  THEN
          IF C2_ASIENTO_LOTE.IMP_DEBITO > C2_ASIENTO_LOTE.IMP_CREDITO THEN
             UPDATE SC_ASIENTO_LOTE
               SET IMP_DEBITO = C2_ASIENTO_LOTE.IMP_DEBITO - C2_ASIENTO_LOTE.IMP_CREDITO,
                   IMP_CREDITO = 0
             WHERE NUM_LOTE   = C2_ASIENTO_LOTE.NUM_LOTE
               AND COD_CUENTA = C2_ASIENTO_LOTE.COD_CUENTA
               AND C2_ASIENTO_LOTE.ROWID = ROWID
               AND COD_OPERADORA_SCL = p_cod_operadora;

          ELSIF C2_ASIENTO_LOTE.IMP_DEBITO < C2_ASIENTO_LOTE.IMP_CREDITO THEN
             UPDATE SC_ASIENTO_LOTE
                SET IMP_DEBITO = 0,
                    IMP_CREDITO = C2_ASIENTO_LOTE.IMP_CREDITO - C2_ASIENTO_LOTE.IMP_DEBITO
              WHERE NUM_LOTE = C2_ASIENTO_LOTE.NUM_LOTE
                AND COD_CUENTA = C2_ASIENTO_LOTE.COD_CUENTA
                AND C2_ASIENTO_LOTE.ROWID = ROWID
                AND COD_OPERADORA_SCL = p_cod_operadora;

          ELSE
             DELETE
               FROM SC_ASIENTO_LOTE
              WHERE NUM_LOTE   = C2_ASIENTO_LOTE.NUM_LOTE
                AND COD_CUENTA = C2_ASIENTO_LOTE.COD_CUENTA
                AND C2_ASIENTO_LOTE.ROWID = ROWID
                AND COD_OPERADORA_SCL = p_cod_operadora;

          END IF;
       END IF;
    END LOOP;
    CLOSE C2;
    --
    --COMMIT;
    --
EXCEPTION WHEN ERROR_ACUMULACION THEN
   INSERT INTO SC_ERROR_ASIENTO (
               NUM_LOTE  , COD_ERROR,
               FEC_ERROR , DES_ERROR,
               COD_OPERADORA_SCL)
        VALUES (
               p_num_lote, v_cod_error,
               SYSDATE   , v_des_error,
               p_cod_operadora);

   --COMMIT;
END SC_P_GENERA_ASIENTO;
/
SHOW ERRORS
