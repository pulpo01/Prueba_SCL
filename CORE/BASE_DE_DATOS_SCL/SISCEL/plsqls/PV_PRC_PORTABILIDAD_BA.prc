CREATE OR REPLACE PROCEDURE Pv_Prc_Portabilidad_Ba
(
  PRC_TRANSAC IN VARCHAR2,
  PRC_PRODUCTO IN NUMBER ,
  PRC_ACTABO IN VARCHAR2 ,
  PRC_ABONADO IN OUT NUMBER ,
  PRC_ORIGEN IN VARCHAR2 ,
  PRC_DESTINO IN VARCHAR2 ,
  PRC_VAR3 IN VARCHAR2,
  PRC_VAR_OP IN VARCHAR2 DEFAULT NULL
   )
IS


   -- Procedimiento que conserva la protabilidad del
   -- numero cuando se cambia de Plan total a normal

   V_PRODUCTO   GE_PRODUCTOS.COD_PRODUCTO%TYPE;
   V_ABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
   VP_ACTABO    GAD_ORIDESUSO.COD_ACTABO%TYPE;
   VP_ORIGEN    GA_ABOCEL.NUM_CELULAR%TYPE;
   VP_DESTINO   GA_ABOCEL.NUM_CELULAR%TYPE;
   VP_VAR3      VARCHAR2(10);
   VP_VAR7      GAD_ORIDESUSO.COD_MODULO%TYPE;
   V_ERROR      VARCHAR2(1) := '0';
   V_PROC       VARCHAR2(50);
   V_SQLCODE    VARCHAR2(15);
   V_SQLERRM    VARCHAR2(70);
   V_TABLA      VARCHAR2(50);
   V_ACT        VARCHAR2(1);
   V_FECSYS     DATE;
   --
   -- Para manejo de la variable opcional de llamado al PL M.MIRANDA - EHEG.
   --
   G_PRC_VAR_OP GA_ABOCEL.NUM_ABONADO%TYPE;
   --
   --
   ERROR_PROCESO EXCEPTION;
   --
   --
   BEGIN
   --
     G_PRC_VAR_OP := PRC_VAR_OP;
     --
     IF G_PRC_VAR_OP IS NULL THEN
        G_PRC_VAR_OP := TO_NUMBER(PRC_ABONADO);
     END IF;
     --
     --


       V_PRODUCTO := TO_NUMBER(PRC_PRODUCTO);
       V_ABONADO  := TO_NUMBER(PRC_ABONADO);
       VP_ACTABO  := PRC_ACTABO;
       VP_ORIGEN  := PRC_ORIGEN;
       VP_DESTINO := PRC_DESTINO;
       VP_VAR3    := PRC_VAR3;


	   V_PROC    := 'PV_PRC_PORTABILIDAD_BA';
       SELECT SYSDATE INTO V_FECSYS FROM DUAL;

	   IF V_PRODUCTO = 1 THEN
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
