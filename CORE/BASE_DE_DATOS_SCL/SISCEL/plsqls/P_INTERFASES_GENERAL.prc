CREATE OR REPLACE PROCEDURE        P_INTERFASES_GENERAL
 (VP_ACTABO IN VARCHAR2,
                                                  V_ABONADO IN NUMBER,
                                                  VP_ORIGEN IN VARCHAR2,
                                                  VP_DESTINO IN VARCHAR2,
                                                  VP_VAR3 IN VARCHAR2,
						  VP_VAR4 IN VARCHAR2 :=NULL,
						  VP_VAR5 IN VARCHAR2 :=NULL,
						  VP_VAR6 IN VARCHAR2 :=NULL,
                                                  V_FECSYS IN DATE,
                                                  VP_PROC IN OUT VARCHAR2,
                                                  VP_TABLA IN OUT VARCHAR2,
                                                  VP_ACT IN OUT VARCHAR2,
                                                  VP_SQLCODE IN OUT VARCHAR2,
                                                  VP_SQLERRM IN OUT VARCHAR2,
                                                  VP_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento de actualizacion de interfases con los modulos de
-- Facturacion, Tarificacion y Ventas. Es llamado desde las pantallas del
-- modulo que realizan transaccion que afectan a estos modulos.
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_ORIGEN NUMBER;
BEGIN
  VP_PROC := 'P_INTERFASES_GENERAL';
  IF VP_ACTABO = 'CP' THEN /* Cambio de Plan Comercial */
     V_ORIGEN := TO_NUMBER(VP_ORIGEN);
     P_PLAN_COMERCIAL (V_ABONADO,V_ORIGEN,VP_DESTINO,V_FECSYS,
                       VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,
                       VP_ERROR);
     IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
     ELSE
        VP_PROC := 'P_INTERFASES_GENERAL';
     END IF;
  ELSIF VP_ACTABO = 'CL' THEN /* Cambio de cICLO */
        GA_P_CAMBIOCICLOCLI(V_ABONADO,VP_ORIGEN, VP_DESTINO, V_FECSYS,
                VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,VP_ERROR);
  ELSIF VP_ACTABO = 'DU' THEN /* Cambio de Nombre Usuario */
     P_DATOS_USUARIO (V_ABONADO,VP_ORIGEN,VP_DESTINO,VP_VAR3,
                      VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,
                      VP_ERROR);
     IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
     ELSE
        VP_PROC := 'P_INTERFASES_GENERAL';
     END IF;
  ELSIF VP_ACTABO = 'PB' THEN /* PROC.PREBILLING */
     FA_PROC_PREBILLING_2(V_ABONADO,VP_ORIGEN,VP_DESTINO,VP_VAR3,VP_VAR4,VP_VAR5,VP_VAR6,
                      VP_PROC,VP_TABLA,VP_ACT,VP_SQLCODE,VP_SQLERRM,
                      VP_ERROR,FALSE);
     IF VP_ERROR <> '0' THEN
        VP_ERROR := '4';
     ELSE
        VP_PROC := 'P_INTERFASES_GENERAL';
     END IF;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
       VP_SQLCODE := SQLCODE;
       VP_SQLERRM := SQLCODE;
       VP_ERROR := '4';
END;
/
SHOW ERRORS
