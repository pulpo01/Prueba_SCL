CREATE OR REPLACE function F_IMPUESTOS_CARGO ( v_num_proceso  IN NUMBER
                                             , v_columna      IN NUMBER
                                             , v_cod_concepto IN NUMBER)
RETURN  fa_presupuesto.IMP_FACTURABLE%type
IS
      v_imp_facturable  fa_presupuesto.IMP_FACTURABLE%TYPE :=0;
      v_imp_facturable_1 fa_presupuesto.IMP_FACTURABLE%type:=0;
      v_imp_facturable_2 fa_presupuesto.IMP_FACTURABLE%type:=0;
BEGIN
   BEGIN
        SELECT NVL(SUM (NVL(B.IMP_FACTURABLE,0)),0)
          INTO v_imp_facturable_1
          FROM FA_PRESUPUESTO A,
               FA_PRESUPUESTO B
         WHERE A.NUM_PROCESO  = v_num_proceso     AND
               A.COLUMNA      = v_columna         AND
               A.COD_TIPCONCE = 3			      AND /* CARGO */
               A.IND_FACTUR   = 1                 AND
               A.IND_CUOTA    = 0                 AND
               A.COD_CONCEPTO = v_cod_concepto    AND
               ---
               B.COD_TIPCONCE(+) = 1              AND /* IMPUESTO */
               B.COD_PRODUCTO(+) = A.COD_PRODUCTO AND
               B.COLUMNA_REL (+) = A.COLUMNA      AND
               B.NUM_PROCESO (+) = A.NUM_PROCESO  AND
               B.COD_CONCEREL(+) = A.COD_CONCEPTO AND
               B.IMP_FACTURABLE != 0 ;

            v_imp_facturable:=v_imp_facturable_1 ;
      EXCEPTION
         WHEN OTHERS THEN
            v_imp_facturable:=0;
            v_imp_facturable_1:=0;
   END;

   BEGIN
        SELECT NVL(SUM (nvl(C.IMP_FACTURABLE,0)),0)
          INTO v_imp_facturable_2
          FROM FA_PRESUPUESTO A,
               FA_PRESUPUESTO B,
               FA_PRESUPUESTO C
         WHERE A.NUM_PROCESO     = v_num_proceso  AND
               A.COLUMNA         = v_columna      AND
               A.COD_TIPCONCE    = 3 			  AND
               A.IND_FACTUR      = 1              AND
               A.IND_CUOTA       = 0              AND
               A.COD_CONCEPTO    = v_cod_concepto              AND /* CARGO */
               ---
               B.COD_TIPCONCE(+) = 2              AND /* DESCUENTO */
               B.COD_PRODUCTO(+) = A.COD_PRODUCTO AND
               B.COLUMNA_REL (+) = A.COLUMNA      AND
               B.NUM_PROCESO (+) = A.NUM_PROCESO  AND
               B.COD_CONCEREL(+) = A.COD_CONCEPTO AND
               B.IMP_FACTURABLE != 0 AND
               ---
               C.COD_TIPCONCE(+) = 1              AND /* IMPUESTO DEL DSCTO.*/
               C.COD_PRODUCTO(+) = B.COD_PRODUCTO AND
               C.COLUMNA_REL (+) = B.COLUMNA      AND
               C.NUM_PROCESO (+) = B.NUM_PROCESO  AND
               C.COD_CONCEREL(+) = B.COD_CONCEPTO AND
               C.IMP_FACTURABLE != 0 ;

        v_imp_facturable:=v_imp_facturable_1+v_imp_facturable_2 ;

      return v_imp_facturable;

      EXCEPTION
         WHEN OTHERS THEN
            return v_imp_facturable;
   END;
END;
/
SHOW ERRORS
