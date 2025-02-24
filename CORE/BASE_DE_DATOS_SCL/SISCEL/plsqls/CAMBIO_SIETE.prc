CREATE OR REPLACE PROCEDURE CAMBIO_SIETE IS
CURSOR C_CAMBIA IS
SELECT * FROM SC_CTO_CTA
WHERE COD_CONCEPTO IN
(
SELECT COD_CTO_GRP FROM SC_GRP_DOMINIO_DET
WHERE COD_CONCEPTO IN (000474,000475)
AND COD_DOMINIO_CTO = 7
AND COD_GRP_DOMINIO = 24
)
AND COD_EVENTO_CTO IN (14,15,16,17,21,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48)
AND SUBSTR(COD_CUENTA,19,4) != 4635;
BEGIN
     FOR I IN C_CAMBIA LOOP
   UPDATE  SC_CTO_CTA
                SET COD_CUENTA = SUBSTR(COD_CUENTA,1,18)||'4635'||SUBSTR(COD_CUENTA,23,12)
     WHERE COD_OPERADORA_SCL = I.COD_OPERADORA_SCL
                AND COD_DOMINIO_CTO   = I.COD_DOMINIO_CTO
                AND COD_EVENTO_CTO    = I.COD_EVENTO_CTO
                AND COD_CONCEPTO      = I.COD_CONCEPTO;
     END LOOP;
   COMMIT;
END;
/
SHOW ERRORS
