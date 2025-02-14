CREATE OR REPLACE PROCEDURE P_GA_ESTADO_VENDEDOR
( VP_TRANSAC IN VARCHAR2 ,
  VP_VENDEDOR IN VARCHAR2)
IS
   V_ERROR        CHAR(1) := '0';
   V_VENDEDOR     VE_VENDEDORES.COD_VENDEDOR%TYPE;
   V_TRANSAC      GA_TRANSACABO.NUM_TRANSACCION%TYPE;
   V_CADENA       GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   V_ESTADO       VE_VENDEDORES.VE_INDBLOQUEO%TYPE;
   V_VTA_PDTE     GA_VENTAS.NUM_VENTA%TYPE;

BEGIN
   V_TRANSAC := TO_NUMBER(VP_TRANSAC);
   V_VENDEDOR := TO_NUMBER(VP_VENDEDOR);

   SELECT VE_INDBLOQUEO
   INTO  V_ESTADO
   FROM  VE_VENDEDORES
   WHERE COD_VENDEDOR = V_VENDEDOR;

   IF V_ESTADO = 1 THEN
      --Si el vendedor esta bloqueado como dato informativo le da cuenta
      --de la venta que quedo pendiente, aun cuando no representara ningun
      --efecto durante la venta. Como es un dato informativo me interesa
          --la ultima venta que quedo pendiente en caso de existir mas de una
          --caso que no debiese darse nunca
       BEGIN
         SELECT MAX(A.NUM_VENTA)
         INTO  V_VTA_PDTE
         FROM  GA_VENTAS A, FA_INTERFACT B
         WHERE A.COD_VENDEDOR  = V_VENDEDOR
         AND   A.NUM_VENTA     = B.NUM_VENTA
         AND   B.TIP_FOLIACION = (SELECT VAL_PARAMETRO
                                  FROM  GED_PARAMETROS
                                  WHERE NOM_PARAMETRO = 'IND_DOCPREFOL'
                                  AND   COD_MODULO    = 'GA'
                                  AND   COD_PRODUCTO  = 1)
         AND   B.NUM_VENTA NOT IN (SELECT C.NUM_VENTA
                                   FROM  GA_DOCVENTA C
                                   WHERE C.NUM_VENTA    = B.NUM_VENTA
                                   AND   C.COD_TIPDOCUM <> (SELECT VAL_PARAMETRO
                                                            FROM  GED_PARAMETROS
                                                            WHERE NOM_PARAMETRO = 'DOCTO_ANEXO_CONTRATO'
                                                            AND   COD_MODULO    = 'GA'
                                                            AND   COD_PRODUCTO  = 1));

         EXCEPTION
            WHEN OTHERS THEN
                           NULL;
                 END;
   END IF;

   V_CADENA := '/' || TO_CHAR(V_ESTADO) || '/' || TO_CHAR(V_VTA_PDTE);

   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
   VALUES (V_TRANSAC, V_ERROR, V_CADENA);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      V_ERROR := '1';
      v_CADENA := 'VENDEDOR NO EXISTE';

      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (V_TRANSAC, V_ERROR, V_CADENA);
   WHEN OTHERS THEN
      V_ERROR := '2';
      V_CADENA := 'PROCESO FINALIZADO CON ERROR';

      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
      VALUES (V_TRANSAC, V_ERROR, V_CADENA);
END;
/
SHOW ERRORS
