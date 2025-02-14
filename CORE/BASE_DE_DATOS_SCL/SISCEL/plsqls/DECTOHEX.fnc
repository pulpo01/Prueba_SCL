CREATE OR REPLACE FUNCTION          "DECTOHEX" (a IN NUMBER) RETURN VARCHAR2 IS
      x VARCHAR2(8) := '';
        y VARCHAR2(1);
        z NUMBER;
        w NUMBER;
    BEGIN
        IF a > POWER(2,32) OR a < 0  THEN
            RAISE invalid_number;
        END IF;
        w := a;
        WHILE w > 0 LOOP
        z := w MOD 16;
        IF z = 10 THEN y := 'A';
        ELSIF z = 11 THEN y := 'B';
        ELSIF z = 12 THEN y := 'C';
        ELSIF z = 13 THEN y := 'D';
     ELSIF z = 14 THEN y := 'E';
        ELSIF z = 15 THEN y := 'F';
        ELSE y := TO_CHAR(z);
        END IF;
            w := TRUNC(w / 16);
            x := CONCAT(y,x);   -- build x string backwards
        END LOOP;
        RETURN x;
    END;
/
SHOW ERRORS
