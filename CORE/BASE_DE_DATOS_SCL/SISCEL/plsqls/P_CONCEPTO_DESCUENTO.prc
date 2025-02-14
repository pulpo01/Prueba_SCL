CREATE OR REPLACE PROCEDURE        P_CONCEPTO_DESCUENTO(
  VP_TRANSAC IN VARCHAR2 ,
  VP_CONCEPTO IN VARCHAR2 )
IS
--
-- Procedimiento de recuperacion de conceptos de descuento asociados
-- a los descuentos generados sin tomar en cuenta el plan comercial original
-- del cliente. Localiza los conceptos de descuento y los crea si no estuvieran
-- ya creados
--
  V_CONCORIG FA_CONCEPTOS.COD_CONCORIG%TYPE;
  V_CONCEPTO FA_CONCEPTOS.COD_CONCEPTO%TYPE;
  V_MODULO FA_CONCEPTOS.COD_MODULO%TYPE;
  V_MONEDA FA_CONCEPTOS.COD_MONEDA%TYPE;
  V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
  V_DESCUENTO FA_DATOSGENER.DES_DESCUENTO%TYPE;
  V_DESCRIPCION FA_CONCEPTOS.DES_CONCEPTO%TYPE;
  V_PRODUCTO FA_CONCEPTOS.COD_PRODUCTO%TYPE;
  V_ERROR CHAR(1) := '0';
  ERROR_PROCESO EXCEPTION;
BEGIN
   V_TRANSAC := TO_NUMBER(VP_TRANSAC);
   V_CONCORIG := TO_NUMBER(VP_CONCEPTO);
   dbms_output.put_line ('entra select fa_conceptos');
   SELECT COD_CONCEPTO
     INTO V_CONCEPTO
     FROM FA_CONCEPTOS
    WHERE COD_CONCORIG = V_CONCORIG
      AND COD_TIPCONCE = 2;
   dbms_output.put_line ('sale select fa_conceptos');
   V_CADENA := '/'||TO_CHAR(V_CONCEPTO);
   V_ERROR := '0';
   RAISE ERROR_PROCESO;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
        BEGIN
   dbms_output.put_line ('entra select fa_datosgener');
           SELECT DES_DESCUENTO
             INTO V_DESCUENTO
             FROM FA_DATOSGENER;
   dbms_output.put_line ('sale select fa_datosgener');
        EXCEPTION
           WHEN OTHERS THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
        END;
        BEGIN
   dbms_output.put_line ('entra select fa_conceptos 2');
           SELECT COD_PRODUCTO,DES_CONCEPTO,
                  COD_MODULO,COD_MONEDA
             INTO V_PRODUCTO,V_DESCRIPCION,
                  V_MODULO,V_MONEDA
             FROM FA_CONCEPTOS
            WHERE COD_CONCEPTO = V_CONCORIG;
   dbms_output.put_line ('sale select fa_conceptos 2');
           V_DESCRIPCION := SUBSTR(V_DESCUENTO||'
'||LOWER(V_DESCRIPCION),1,60);
   dbms_output.put_line ('entra p_crear_concepto');
           P_CREAR_CONCEPTO(V_DESCRIPCION,
                            V_MODULO,
                            V_PRODUCTO,
                            V_MONEDA,
                            V_CONCORIG,
                            2,'0',
                            V_ERROR);
   dbms_output.put_line ('sale p_crear_concepto');
           V_CADENA := '/'||TO_CHAR(V_CONCORIG);
           RAISE ERROR_PROCESO;
        EXCEPTION
           WHEN ERROR_PROCESO THEN
   dbms_output.put_line ('insert transacabo');
                INSERT INTO GA_TRANSACABO
                            (NUM_TRANSACCION,
                             COD_RETORNO,
                             DES_CADENA)
                     VALUES (V_TRANSAC,
                             V_ERROR,V_CADENA);
   dbms_output.put_line ('sale insert transacabo');
           WHEN OTHERS THEN
                V_ERROR := '4';
                RAISE ERROR_PROCESO;
        END;
   WHEN ERROR_PROCESO THEN
   dbms_output.put_line ('insert transacabo');
        INSERT INTO GA_TRANSACABO
                    (NUM_TRANSACCION,
                     COD_RETORNO,
                     DES_CADENA)
             VALUES (V_TRANSAC,
                     V_ERROR,V_CADENA);
   dbms_output.put_line ('sale insert transacabo');
   WHEN OTHERS THEN
   dbms_output.put_line ('insert transacabo');
        INSERT INTO GA_TRANSACABO
                    (NUM_TRANSACCION,
                     COD_RETORNO,
                     DES_CADENA)
             VALUES (V_TRANSAC,
                     '4',V_CADENA);
   dbms_output.put_line ('sale insert transacabo');
END;
/
SHOW ERRORS
