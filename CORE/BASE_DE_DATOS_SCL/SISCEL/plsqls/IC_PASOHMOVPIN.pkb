CREATE OR REPLACE PACKAGE BODY        IC_PASOHMOVPIN IS
  -- Paso a historico de movimientos de Celular
PROCEDURE P_IC_PASOHCMOVPIN(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE ,
                            V_OLD_CMOV IN ICC_MOVPIN%ROWTYPE ,
                            V_NEW_CMOV IN ICC_MOVPIN%ROWTYPE ) IS
    V_CMOV ICC_MOVPIN%ROWTYPE;
    V_TABLA VARCHAR2(35):= NULL;
    BEGIN
      IF V_OLD_CMOV.COD_ESTADO = 9 OR V_NEW_CMOV.COD_ESTADO = 10 THEN
         V_CMOV.COD_ESTADO := 10;
         V_CMOV.DES_RESPUESTA := 'CANCELADO';
      ELSE
         V_CMOV.COD_ESTADO := V_NEW_CMOV.COD_ESTADO;
         V_CMOV.DES_RESPUESTA := V_NEW_CMOV.DES_RESPUESTA;
      END IF;
      V_CMOV.NUM_MOVIMIENTO   := V_NEW_CMOV.NUM_MOVIMIENTO;
      V_CMOV.COD_MODULO       := V_NEW_CMOV.COD_MODULO;
      V_CMOV.COD_ACTUACION    := V_NEW_CMOV.COD_ACTUACION;
      V_CMOV.COD_CENTRAL      := V_NEW_CMOV.COD_CENTRAL;
      V_CMOV.NUM_INTENTOS     := V_NEW_CMOV.NUM_INTENTOS;
      V_CMOV.NOM_USUARIO      := V_NEW_CMOV.NOM_USUARIO;
      V_CMOV.FEC_INGRESO      := V_NEW_CMOV.FEC_INGRESO;
      V_CMOV.NUM_CELULAR      := V_NEW_CMOV.NUM_CELULAR;
      V_CMOV.ORIGEN           := V_NEW_CMOV.ORIGEN;
      V_CMOV.LOTE             := V_NEW_CMOV.LOTE;
      V_CMOV.SERIE            := V_NEW_CMOV.SERIE;
      V_CMOV.PIN              := V_NEW_CMOV.PIN;
      V_CMOV.BALANCE          := V_NEW_CMOV.BALANCE;
    -- INSERTAR EL MOVIMIENTO EN EL HISTORICO
      INSERT INTO ICC_HMOVPIN
                (
                 NUM_MOVIMIENTO,
                 COD_MODULO,
                 COD_ACTUACION,
                 COD_ESTADO,
                 NUM_INTENTOS,
                 DES_RESPUESTA,
                 NOM_USUARIO,
                 FEC_INGRESO,
                 FEC_HISTORICO,
                 COD_CENTRAL,
                 NUM_CELULAR,
                 ORIGEN,
                 LOTE,
                 SERIE,
                 PIN,
                 BALANCE
                )
          VALUES
                (
                 V_CMOV.NUM_MOVIMIENTO,
                 V_CMOV.COD_MODULO,
                 V_CMOV.COD_ACTUACION,
                 V_CMOV.COD_ESTADO,
                 V_CMOV.NUM_INTENTOS,
                 V_CMOV.DES_RESPUESTA,
                 V_CMOV.NOM_USUARIO,
                 V_CMOV.FEC_INGRESO,
                 SYSDATE,
                 V_CMOV.COD_CENTRAL,
                 V_CMOV.NUM_CELULAR,
		 V_CMOV.ORIGEN,
                 V_CMOV.LOTE,
                 V_CMOV.SERIE,
                 V_CMOV.PIN,
                 V_CMOV.BALANCE
                );
    -- INSERTAR COMANDOS EN EL HISTORICO
      V_TABLA := 'ICC_HCOMPROC_MOVPIN';
      INSERT INTO
       ICC_HCOMPROC_MOVPIN (
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       FEC_HISTORICO
                       )
                (SELECT
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       SYSDATE
                FROM ICC_COMPROC_MOVPIN
                WHERE NUM_MOVIMIENTO = V_CMOV.NUM_MOVIMIENTO);
      DELETE ICC_COMPROC_MOVPIN WHERE NUM_MOVIMIENTO = V_NEW_CMOV.NUM_MOVIMIENTO;
      V_TABLA := 'P_GE_RESPUESTA';
      IF V_CMOV.COD_ESTADO <> 10 THEN
         GE_PROCED.P_GE_RESPUESTA(V_PRODUCTO,V_NEW_CMOV.COD_MODULO,NULL,NULL,NULL,NULL);
      END IF;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'P_IC_PASOHCMOVPIN: '||V_TABLA||'  '||SQLERRM,TRUE);
    END;
END IC_PASOHMOVPIN;
/
SHOW ERRORS
