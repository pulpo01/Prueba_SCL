CREATE OR REPLACE FUNCTION GE_VLUHN_FN (v_serie IN VARCHAR2)
   RETURN VARCHAR2
IS

-- Objetvo: Valida una serie IMEI, incluye validacion de numeros
-- de serie antiguos
-- Entrada : Numero correspondiente al serie sin el digito verificador
-- Salida : 1 (Verdadero) Numero de serie correcto
--          0 (Falso)     Numero de serie incorrecto
   v_resultado   VARCHAR2 (1)   := '0';
   v_serie14     VARCHAR2 (100);
   v_digito      VARCHAR2 (1);
   v_digito1     VARCHAR2 (1);
   v_largo       INTEGER;
BEGIN
   v_largo := LENGTH (v_serie);

   IF v_largo = 15
   THEN
      v_serie14 := SUBSTR (v_serie, 1, 14);
      v_digito := SUBSTR (v_serie, 15);

      IF v_digito = '0'
      THEN
         v_resultado := '1';
      ELSE
         v_digito1 := ge_fn_luhn (v_serie14);

         IF v_digito = v_digito1
         THEN
            v_resultado := '1';
         END IF;
      END IF;
   END IF;

   RETURN  v_resultado;
END;
/
SHOW ERRORS
