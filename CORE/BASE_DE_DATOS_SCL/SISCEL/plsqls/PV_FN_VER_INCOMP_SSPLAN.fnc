CREATE OR REPLACE FUNCTION PV_FN_VER_INCOMP_SSPLAN(pCodPlantarif in varchar2, pCodServicio in varchar2) return varchar2
is
  vCodServicio GA_SERVSUPL.COD_SERVICIO%TYPE;
  vEsIncompatible varchar2(6);
  vCantidad number(3);
  CURSOR CR_SSPLANES IS
        SELECT B.COD_SERVICIO
          FROM GAD_SERVSUP_PLAN A, GA_SERVSUPL B
         WHERE A.COD_PRODUCTO = 1
           AND A.COD_PLANTARIF = pCodPlantarif
           AND A.TIP_RELACION = 3
           AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
           AND A.COD_SERVICIO = B.COD_SERVICIO
           AND A.COD_PRODUCTO = B.COD_PRODUCTO;
BEGIN
       vEsIncompatible := 'FALSE';
           OPEN CR_SSPLANES;
       LOOP
          FETCH CR_SSPLANES INTO  vCodServicio;

          EXIT WHEN CR_SSPLANES%NOTFOUND;

                  BEGIN
                          SELECT COUNT(*)
                            INTO vCantidad
                            FROM GA_SERVSUP_DEF
                           WHERE COD_PRODUCTO = 1
                             AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)
                                 AND ((COD_SERVICIO = pCodServicio AND COD_SERVDEF = vCodServicio)
                                     OR
                                         (COD_SERVICIO = vCodServicio AND COD_SERVDEF = pCodServicio))
                                 AND TIP_RELACION = 3;

                      IF vCantidad > 0 THEN
                                        vEsIncompatible := 'TRUE';
                          END IF;

                  EXCEPTION
                                   WHEN OTHERS THEN
                                                vEsIncompatible := 'TRUE';
                  END;
       END LOOP;
       CLOSE CR_SSPLANES;
           RETURN vEsIncompatible;
END;
/
SHOW ERRORS
