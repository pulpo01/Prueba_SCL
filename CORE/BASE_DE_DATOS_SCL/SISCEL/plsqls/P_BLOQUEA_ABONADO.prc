CREATE OR REPLACE PROCEDURE        P_BLOQUEA_ABONADO
(
  VP_MODULO IN VARCHAR2 ,
  VP_PRODUCTO IN NUMBER ,
  VP_ACTABO IN VARCHAR2 ,
  VP_ABONADO IN NUMBER )
IS
--
-- Procedimiento de bloqueo pa evitar abrazos letales
--
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
BEGIN
   IF VP_PRODUCTO = 1 THEN
       IF VP_ACTABO IN ('DR','ER','FP','LR','OR','PR','RB','RR','RS','S1','S2','S3','S4','SR','V6') THEN
       	  	SELECT NUM_ABONADO INTO V_ABONADO
          	FROM GA_ABORENT
          	WHERE NUM_ABONADO = VP_ABONADO
          	FOR UPDATE OF NUM_ABONADO NOWAIT;
       ELSIF VP_ACTABO IN ('AR','BV','MR')THEN
       		SELECT NUM_ABONADO INTO V_ABONADO
           	FROM GA_ABOROAVIS
          	WHERE NUM_ABONADO = VP_ABONADO
          	FOR UPDATE OF NUM_ABONADO NOWAIT;
       ELSE
	   		BEGIN
       			SELECT NUM_ABONADO INTO V_ABONADO
            	FROM GA_ABOCEL
            	WHERE NUM_ABONADO = VP_ABONADO
            	FOR UPDATE OF NUM_ABONADO NOWAIT;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
       				 SELECT NUM_ABONADO INTO V_ABONADO
            		 FROM GA_ABOAMIST
            		 WHERE NUM_ABONADO = VP_ABONADO
            		 FOR UPDATE OF NUM_ABONADO NOWAIT;
			END;
     END IF;
   ELSIF VP_PRODUCTO = 2 THEN
       SELECT NUM_ABONADO INTO V_ABONADO
           FROM GA_ABOBEEP
          WHERE NUM_ABONADO = VP_ABONADO
          FOR UPDATE OF NUM_ABONADO NOWAIT;
   ELSIF VP_PRODUCTO = 4 THEN
       SELECT NUM_ABONADO INTO V_ABONADO
           FROM GA_ABOTREK
          WHERE NUM_ABONADO = VP_ABONADO
          FOR UPDATE OF NUM_ABONADO NOWAIT;
   END IF;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20269,'P_BLOQUEA_ABONADO'||' '||SQLERRM);
END;
/
SHOW ERRORS
