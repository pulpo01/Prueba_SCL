CREATE OR REPLACE PACKAGE BODY          "GE_PROCED" IS
  --
  PROCEDURE P_GE_RESPUESTA(
  V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE ,
  V_MODULO IN GE_MODULOS.COD_MODULO%TYPE ,
  V_REG_BMOV IN ICB_MOVIMIENTO%ROWTYPE ,
  V_REG_CMOV IN ICC_MOVIMIENTO%ROWTYPE ,
  V_REG_MMOV IN ICM_MOVIMIENTO%ROWTYPE ,
  V_REG_RMOV IN ICR_MOVIMIENTO%ROWTYPE )
  IS
  V_PROC VARCHAR2(60) := NULL;
  V_CUENTA NUMBER := 0;
  BEGIN
    IF V_MODULO = 'IC' THEN
        V_PROC := 'P_IC_RESPUESTA';
        IC_PROCED.P_IC_RESPUESTA (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                             V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'AL' THEN
                  V_PROC := 'P_AL_RESPUESTA';
           IF V_REG_CMOV.COD_ACTABO = 'BT' THEN
                             P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV, V_REG_MMOV,V_REG_RMOV);
                  END IF;
    ELSIF V_MODULO = 'TA' THEN
        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                   V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'GA' THEN
                IF V_REG_CMOV.TIP_TECNOLOGIA = 'GSM' AND V_PRODUCTO = 1 THEN
                   V_PROC := 'GSM_PAC_AUC.P_ACTUALIZAESTADOSICC';
                   GSM_PAC_AUC.P_ACTUALIZAESTADOSICC(V_MODULO, V_REG_CMOV.ICC, V_REG_CMOV.ICC_NUE, V_REG_CMOV.COD_ACTABO);
                END IF;

        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                   V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'BP' THEN
        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                   V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'ST' THEN
        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                   V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'CO' THEN
                IF V_REG_CMOV.TIP_TECNOLOGIA = 'GSM' AND V_PRODUCTO = 1 THEN
                   V_PROC := 'GSM_PAC_AUC.P_ACTUALIZAESTADOSICC';
                   GSM_PAC_AUC.P_ACTUALIZAESTADOSICC(V_MODULO, V_REG_CMOV.ICC, V_REG_CMOV.ICC_NUE, V_REG_CMOV.COD_ACTABO);
                END IF;

        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
                                   V_REG_MMOV,V_REG_RMOV);
        V_PROC := 'P_CO_RESPUESTA';
        P_CO_SUPERSUSPEN (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV,
      V_REG_MMOV,V_REG_RMOV);
    ELSIF V_MODULO = 'AC' THEN
        V_PROC := 'P_RE_MOVSWITCH';
        P_RE_MOVSWITCH (V_REG_CMOV);
                V_PROC := 'P_SETSERSUPABO';
                IF V_REG_CMOV.COD_ACTABO = 'VA' AND V_REG_CMOV.TIP_TERMINAL = 'A' THEN
                   p_setsersupabo(V_REG_CMOV.NUM_ABONADO, 145);
                END IF;
                IF V_REG_CMOV.COD_ACTABO = 'VA' AND V_REG_CMOV.TIP_TERMINAL = 'D' THEN
                   p_setsersupabo(V_REG_CMOV.NUM_ABONADO, 146);
                END IF;
    ELSIF V_MODULO = 'CE' THEN
        NULL;
    ELSIF V_MODULO = 'GC' THEN
        GC_CONTACTOS_PG.GC_ActualizarEstadoMensaje_PR(V_REG_CMOV);
    ELSIF V_MODULO = 'GS' THEN
          GSM_PAC_AUC.P_ACTUALIZA_ICC(V_REG_CMOV.ICC, V_REG_CMOV.COD_ACTUACION, V_REG_CMOV.NUM_MOVIMIENTO);

    ELSIF V_MODULO = 'LC' THEN /* Actualizacion de Retorno para Limite de Consumo */
        V_PROC := 'P_GA_RESPUESTA';
        P_Ga_Respuesta (V_PRODUCTO,V_REG_BMOV,V_REG_CMOV, V_REG_MMOV,V_REG_RMOV);
        p_actualiza_lccomandos(V_REG_CMOV.NUM_MOVIMIENTO);

    ELSE
      SELECT COUNT(1) INTO V_CUENTA FROM GE_MODULOS WHERE COD_MODULO = V_MODULO;
      IF  V_CUENTA = 0 THEN
            RAISE_APPLICATION_ERROR(-20800,' Modulo ' || V_MODULO ||
          ' no contemplado en el Interfaz');
      END IF;
    END IF;
  EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20801,' ERROR en ' || V_PROC|| '  ' ||
 SQLERRM);
  END;
END Ge_Proced;
/
SHOW ERRORS
