CREATE OR REPLACE FUNCTION FN_RECUPERA_NUM_MIN_ANT (sNumAbonado in varchar2, sFecha in date)
/*******************************************
AUTOR    : SANDRA PINTO ZAMORA.
AREA     : POSTVENTA .
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
*******************************************/
RETURN VARCHAR2 IS
sNumMin ga_abocel.NUM_MIN_MDN%type;
begin

    sNumMin := '';

        SELECT NUM_MIN_MDN INTO sNumMin
        FROM   GA_MODABOCEL
        WHERE  NUM_ABONADO = sNumAbonado and
                   FEC_MODIFICA = sFecha and
                   COD_TIPMODI = 'MN';

        return sNumMin;

end;
/
SHOW ERRORS
