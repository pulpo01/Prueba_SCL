CREATE OR REPLACE FUNCTION PV_FN_VER_INCOMP_SSPLAN_GRUPO(pCodPlantarif in varchar2, pCodServsupl in number) return varchar2
is
  vCodServsupl GA_SERVSUPL.COD_SERVSUPL%TYPE;
  vEsIncompatible varchar2(6);

  CURSOR CR_SSPLANES IS
        SELECT B.COD_SERVSUPL
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
          FETCH CR_SSPLANES INTO  vCodServsupl;

          EXIT WHEN CR_SSPLANES%NOTFOUND;

                  IF vCodServsupl = pCodServsupl THEN
                         vEsIncompatible := 'TRUE';
                  END IF;
       END LOOP;
       CLOSE CR_SSPLANES;
           RETURN vEsIncompatible;
END;
/
SHOW ERRORS
