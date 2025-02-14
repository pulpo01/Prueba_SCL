CREATE OR REPLACE FUNCTION Fa_Borra_Nconsumo_Fn ( EN_CANT_FILAS_INFORMAR NUMBER)RETURN NUMBER IS

LN_CONTADOR_CLIENTES       PLS_INTEGER;
LN_CONTADOR_DELETE_CONSUMO PLS_INTEGER;
LN_CONTADOR_FILAS_A_BORRAR PLS_INTEGER;
CANT_CICLOS                PLS_INTEGER;
FLAG_ERROR                 BOOLEAN;

CURSOR HISTCONSUMO (V_COD_CLIENTE NUMBER) IS
       SELECT ROWID
       FROM   FA_CONSUMO_CICLO_CLIE_TO
           WHERE  COD_CLIENTE   = V_COD_CLIENTE
           ORDER BY FEC_EMISION ASC;

CURSOR CLIENTES (V_CANT_FILAS_CICLO NUMBER)IS
           SELECT COUNT(1)- V_CANT_FILAS_CICLO AS FILAS_BORRAR,
                  COD_CLIENTE AS COD_CLIENTE
       FROM   FA_CONSUMO_CICLO_CLIE_TO
       GROUP BY COD_CLIENTE
       HAVING COUNT(1) >= V_CANT_FILAS_CICLO + 1;

BEGIN
--
       LN_CONTADOR_CLIENTES        := 0;
       LN_CONTADOR_DELETE_CONSUMO  := 0;
           FLAG_ERROR                  := FALSE;
           CANT_CICLOS                 := EN_CANT_FILAS_INFORMAR;

       IF (CANT_CICLOS = 0) OR ( CANT_CICLOS IS NULL) THEN
           LN_CONTADOR_DELETE_CONSUMO := -1;
       ELSE
       -- Select cod_cliente
                   FOR C1 IN CLIENTES (CANT_CICLOS) LOOP
               LN_CONTADOR_CLIENTES := LN_CONTADOR_CLIENTES + 1;
                           LN_CONTADOR_FILAS_A_BORRAR := C1.FILAS_BORRAR;
                           -- Select cod_cliente con num_filas
                           FOR C2 IN HISTCONSUMO(C1.COD_CLIENTE) LOOP
                         BEGIN
                                 DELETE
                     FROM   FA_CONSUMO_CICLO_CLIE_TO CONS
                                         WHERE  CONS.ROWID = C2.ROWID;

                             LN_CONTADOR_DELETE_CONSUMO := LN_CONTADOR_DELETE_CONSUMO + 1;

                                 LN_CONTADOR_FILAS_A_BORRAR := LN_CONTADOR_FILAS_A_BORRAR -1;

                                 IF (LN_CONTADOR_FILAS_A_BORRAR = 0) THEN
                                    EXIT;
                                 END IF;

                             EXCEPTION
                           WHEN OTHERS THEN
                                    FLAG_ERROR := TRUE;
                    ROLLBACK;
                    EXIT;
                         END;
                           END LOOP; -- Fin LOOP CONSUMO CICLO

                           IF (FLAG_ERROR) THEN
                               LN_CONTADOR_DELETE_CONSUMO := -1;
                               EXIT;
                           ELSE
                               COMMIT;
                           END IF;

           END LOOP; -- Fin LOOP CLIENTES
           END IF;
           RETURN LN_CONTADOR_DELETE_CONSUMO;
END;
/
SHOW ERRORS
