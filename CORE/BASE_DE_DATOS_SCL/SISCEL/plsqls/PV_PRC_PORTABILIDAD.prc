CREATE OR REPLACE PROCEDURE        PV_PRC_PORTABILIDAD
(
  PRC_TRANSAC IN VARCHAR2,
  PRC_PRODUCTO IN NUMBER ,
  PRC_ACTABO IN VARCHAR2 ,
  PRC_ABONADO IN OUT NUMBER ,
  PRC_ORIGEN IN VARCHAR2 ,
  PRC_DESTINO IN VARCHAR2 ,
  PRC_VAR3 IN VARCHAR2
   )
IS


   -- Procedimiento que conserva la protabilidad del
   -- numero cuando se cambia de Plan total a normal

   V_PRODUCTO GE_PRODUCTOS.COD_PRODUCTO%TYPE;
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
   VP_ACTABO  VARCHAR2(3);
   VP_ORIGEN VARCHAR(50);
   VP_DESTINO VARCHAR(50);
   VP_VAR3 VARCHAR(10);
   V_ERROR VARCHAR2(1) := '0';
   V_PROC VARCHAR2(50);
   V_SQLCODE VARCHAR2(15);
   V_SQLERRM VARCHAR2(70);
   V_TABLA VARCHAR2(50);
   V_ACT VARCHAR2(1);
   V_FECSYS DATE;

   ERROR_PROCESO EXCEPTION;


   BEGIN


       V_PRODUCTO := TO_NUMBER(PRC_PRODUCTO);
       V_ABONADO  := TO_NUMBER(PRC_ABONADO);
	   VP_ACTABO  := PRC_ACTABO;
	   VP_ORIGEN  := PRC_ORIGEN;
       VP_DESTINO := PRC_DESTINO;
       VP_VAR3    := PRC_VAR3;

	   V_PROC    := 'PV_PRC_PORTABILIDAD';
       SELECT SYSDATE INTO V_FECSYS FROM DUAL;

	   IF V_PRODUCTO = 1 THEN
          P_Interfases_Celular(V_PRODUCTO,VP_ACTABO,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                               VP_VAR3,V_FECSYS,V_PROC,V_TABLA,V_ACT,
                               V_SQLCODE,V_SQLERRM,V_ERROR);

		  IF V_ERROR <> '0' THEN
		     V_ERROR := '4';
		     RAISE ERROR_PROCESO;
		  END IF;


		  V_FECSYS := V_FECSYS + (1/(24*60*60));
		  VP_ACTABO := 'AV';

	      P_Interfases_Celular(V_PRODUCTO,VP_ACTABO,V_ABONADO,VP_ORIGEN,VP_DESTINO,
                               VP_VAR3,V_FECSYS,V_PROC,V_TABLA,V_ACT,
                               V_SQLCODE,V_SQLERRM,V_ERROR);

          IF V_ERROR <> '0' THEN
	         V_ERROR := '4';
	         RAISE ERROR_PROCESO;
	      END IF;

	   ELSE
	       V_ERROR := 4;
		   RAISE ERROR_PROCESO;
       END IF;

       RAISE ERROR_PROCESO;

	 EXCEPTION
          WHEN ERROR_PROCESO THEN
             IF V_ERROR <> '0' THEN
                ROLLBACK;
                INSERT INTO GA_ERRORES
                           (COD_PRODUCTO,
                            COD_ACTABO,
                            CODIGO,
                            FEC_ERROR,
                            NOM_PROC,
                            NOM_TABLA,
                            COD_ACT,
                            COD_SQLCODE,
                            COD_SQLERRM)
                    VALUES (V_PRODUCTO,
                            VP_ACTABO,
                            V_ABONADO,
                            V_FECSYS,
                            V_PROC,
                            V_TABLA,
                            V_ACT,
                            V_SQLCODE,
                            SUBSTR(V_SQLERRM,1,60));
                    V_ERROR := 4;
             END IF;

             INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                       COD_RETORNO,
                                       DES_CADENA)
                               VALUES (PRC_TRANSAC,
                                       V_ERROR,
                                       NULL);

             COMMIT;

	END;
/
SHOW ERRORS
