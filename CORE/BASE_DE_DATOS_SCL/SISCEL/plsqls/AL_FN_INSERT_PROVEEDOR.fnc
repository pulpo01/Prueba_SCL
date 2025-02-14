CREATE OR REPLACE FUNCTION          "AL_FN_INSERT_PROVEEDOR" (V_OPERADORA GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE,
                                                                                                                   V_COD_PROVEEDOR AL_PROVEEDORES.COD_PROVEEDOR%TYPE,
                                                                                                                   ACCION NUMBER) RETURN VARCHAR2 IS
           vp_cod_proveedor AL_PROVEEDORES.COD_PROVEEDOR%TYPE;
           ERROR_SALIDA EXCEPTION;
BEGIN
         -- ACCION = 1 (INGRESA CODIGO)
         -- ACCION = 2 (BORRA CODIGO)
         SELECT COD_PROVEEDOR
         INTO vp_cod_proveedor
         FROM GE_OPERADORA_SCL
         WHERE COD_OPERADORA_SCL = V_OPERADORA;

         IF vp_cod_proveedor IS NULL AND ACCION = 1  THEN
        UPDATE  GE_OPERADORA_SCL
                SET COD_PROVEEDOR = V_COD_PROVEEDOR
                WHERE COD_OPERADORA_SCL = V_OPERADORA;
                COMMIT;
                RETURN 'TRUE';
         ELSE IF ACCION = 2 THEN
                    UPDATE  GE_OPERADORA_SCL
                        SET COD_PROVEEDOR = NULL
                        WHERE COD_OPERADORA_SCL = V_OPERADORA;
                        COMMIT;
                        RETURN 'TRUE';
                 ELSE
--               RETURN 'FALSE';
                         RAISE ERROR_SALIDA;
                 END IF;
         END IF;

 EXCEPTION
    WHEN ERROR_SALIDA THEN
           RAISE_APPLICATION_ERROR(-20101, 'FALSE');
        WHEN NO_DATA_FOUND THEN
           RAISE_APPLICATION_ERROR(-20102, 'OPERADORA NO EXISTE');
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'Error ' || to_char(SQLCODE) || ': ' || SQLERRM);
 END;
/
SHOW ERRORS
