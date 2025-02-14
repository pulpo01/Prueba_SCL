CREATE OR REPLACE TRIGGER fa_trg_afinsdatge
AFTER INSERT
ON FA_DATOSGENER

DECLARE
  v_contador      number;
  Begin
    Select count(*) into v_contador from fa_datosgener
    where  rownum <= 2;
    if v_contador > 1 then
       raise_application_error(-20514,'No debe haber 2 regs. en FA_DATOSGENER');
    end if;
  exception
    when others then
         raise_application_error(-20543,SQLERRM);
End;
/
SHOW ERRORS
