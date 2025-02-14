CREATE OR REPLACE FUNCTION FN_RECUPERA_IMSI (sNumSerie in varchar2)
RETURN VARCHAR2 IS
sIMSI icc_movimiento.imsi%type;
begin
         SELECT FRECUPERSIMCARD_FN(sNumSerie,'IMSI')
         INTO   sIMSI
         FROM   DUAL;

         return sIMSI;
end;
/
SHOW ERRORS
