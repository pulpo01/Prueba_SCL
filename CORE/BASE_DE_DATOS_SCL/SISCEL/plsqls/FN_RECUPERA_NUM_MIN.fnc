CREATE OR REPLACE FUNCTION FN_RECUPERA_NUM_MIN (sNumAbonado in varchar2)
/*******************************************
AUTOR    : DIEGO MEJIAS Z.
AREA     : POSTVENTA .
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
*******************************************/
RETURN VARCHAR2 IS
sNumMin ga_abocel.NUM_MIN_MDN%type;
begin
        SELECT NUM_MIN_MDN INTO sNumMin
                   From   GA_ABOCEL
                   WHERE  NUM_ABONADO = sNumAbonado
        UNION
        SELECT NUM_MIN_MDN
                   From  GA_ABOAMIST
                   WHERE NUM_ABONADO = sNumAbonado;
        return sNumMin;
end;
/
SHOW ERRORS
