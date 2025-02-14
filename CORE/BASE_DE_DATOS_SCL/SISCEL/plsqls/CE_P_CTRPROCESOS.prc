CREATE OR REPLACE PROCEDURE        CE_P_CTRPROCESOS(
iCodProceso    IN NUMBER,
sCodActivacion IN VARCHAR2,
sCodEstado     IN VARCHAR2,
iPidProceso    IN NUMBER,
ObsEvento      IN VARCHAR2,
sResul         IN OUT VARCHAR2
)IS
sRetorno       VARCHAR2(100);
sFecActivacion      CET_CTRPROCESOS.FEC_ACTIVACION%TYPE;
/******************************************************************************
   NOMBRE:     CE_P_CTRPROCESOS
   OBJETIVO:   INSERTAR EN CET_CTRPROCESOS PARA LAS ACTIVACIONES Y DESACTIVACIONES O CAIDAS DEL LOS PL
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        21/03/2001  Juan Jose B.
******************************************************************************/
        ERROR_PROCESO EXCEPTION;
BEGIN
      sRetorno :='FALSE';
          sResul:='OK';
          IF iCodProceso is null or iCodProceso='' THEN
                   sResul:='Error Debe ingresar el codigo proceso';
          END IF;
          IF sCodActivacion is null or sCodActivacion ='' THEN
                   sResul:='Error falta codigo activacion';
          END IF;
          IF sCodEstado is null or sCodEstado ='' THEN
                   sResul:='Error falta codigo estado';
          END IF;
          IF sResul='OK' THEN
                  IF sCodActivacion='A' THEN
                                  INSERT INTO CET_CTRPROCESOS
                                          (COD_PROCESO,
                                          FEC_ACTIVACION,
                                          FEC_DESACTIVACION,
                                          COD_ACTIVACION,
                                          COD_ESTADO,
                                          PID_PROCESO,
                                          OBS_EVENTO)
                                          VALUES(
                                          iCodProceso,                             --COD_PROCESO          NUMBER(3)     NOT NULL,
                                          sysdate,                                 --FEC_ACTIVACION       DATE          NOT NULL,
                                          NULL,                                    --FEC_DESACTIVACION    DATE
                                          sCodActivacion,                                          --COD_ESTADO           VARCHAR2(2),
                                          sCodEstado,                                              --PID_PROCESO          VARCHAR2(2),
                                          iPidProceso,                                             --FEC_DESACTIVACION    NUMBER(8),
                                          ObsEvento );                                             --OBS_EVENTO         VARCHAR2(50)
                          ELSE
                                          SELECT MAX(FEC_ACTIVACION)
                                               INTO   sFecActivacion
                                                   FROM  CET_CTRPROCESOS
                                          WHERE COD_PROCESO = iCodProceso;
                      UPDATE CET_CTRPROCESOS SET
                          FEC_DESACTIVACION=sysdate,
                                                  COD_ACTIVACION=sCodActivacion,
                                          COD_ESTADO=sCodEstado,
                                                  OBS_EVENTO=ObsEvento
                                      WHERE
                                      COD_PROCESO = iCodProceso AND
                                          FEC_ACTIVACION=sFecActivacion;
                      END IF;
                  COMMIT;
                          sRetorno :='TRUE';
      END IF;
EXCEPTION
WHEN OTHERS THEN
   IF sRetorno='FALSE' AND sResul='OK'THEN
            sResul:= 'Error en la actualizacion de la tabla: '||SQLERRM;
   ELSE
        sResul:='OK';
   END IF;
ROLLBACK;
END CE_P_CTRPROCESOS;
/
SHOW ERRORS
